Return-Path: <linux-kernel+bounces-746439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8943B126AB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BD2AE5A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC8D2737E2;
	Fri, 25 Jul 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bZyF680x"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70011270ED7;
	Fri, 25 Jul 2025 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481316; cv=none; b=bqQVNh1QEcM5F+QaBbxKsZcLj+ehleKqpZ+/kVt97aoi1Da4Op4OvjxZd+Tuyq8O5Xk1LtSS/qT3TK/GCGibNUOTQo/4rM8CtrSRB6cx7bU75koZdKXq5u9mnAaCcB+v1pg7wIdmB969QY56Xo4Cv5n3VwHXDi9gPfmiq7Etgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481316; c=relaxed/simple;
	bh=ow1ljpmkv02H9hsOpbrXGJDs1A/a1CXp5uwQULajhsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lw2rV/0TE5vjBfhRm6ryj7RcJkLj3m4M2boUsCnwg/BByuNcBLay2u4aS3zSM0sF1SU+CHOjtpgXcUxsIBOaJAYSVM5q/aJ7whGRqk9JzEjQ2/Ld8eDr0xQ4MpOPzVktXyOA2xpsy4ziWjEcphaz0O4bXgxqKwrVtX8adp4UNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bZyF680x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481312;
	bh=ow1ljpmkv02H9hsOpbrXGJDs1A/a1CXp5uwQULajhsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bZyF680x2IUDuJPlQI0q7ZatJ/E7GTnx5ELWQd0hJxdRgSqngA9JCi3gbISX/VAZQ
	 yYrJ23h5UZuSNCGf2ykzM7Vmg3uFBnrsiuPB79V3X3plwp5RDnehZu/DaUYl9/wG+J
	 2LtF0V8+fGpoBTVqB5f7kO7PxMLYmFQ8+3LY4b0ym0h73/K8XsdKVmY4G0LCbF205U
	 9REAjHk3y2+OfCgNdBqAbk9h1PPO9iIDtLSASKWc0gJu+o6W8mYjfQ3AqVe7geYSEP
	 wFb6RvKjJtaeTCJKFE/j6CaeEYOE3QUK6FZk8jchvMxrD3E2hPY/p6d9EsrJ0zgOW+
	 Ub89R9zgqvjrA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 83A2517E157A;
	Sat, 26 Jul 2025 00:08:32 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:19 +0300
Subject: [PATCH v2 17/18] usb: vhci-hcd: Switch to dev_err_probe() in probe
 path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-17-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Replace pr_err() calls in vhci_hcd_probe() with dev_err_probe(), to
simplify error handling a bit and improve consistency.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 73c5979fee3ce345ea2c212fea03adabde55243a..5d2983a6c2b05d2a769424e1595b4212a806c2a2 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1369,10 +1369,8 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 	 * Our private data is also allocated automatically.
 	 */
 	hcd_hs = usb_create_hcd(&vhci_hc_driver, &pdev->dev, dev_name(&pdev->dev));
-	if (!hcd_hs) {
-		pr_err("create primary hcd failed\n");
-		return -ENOMEM;
-	}
+	if (!hcd_hs)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "create primary hcd failed\n");
 
 	hcd_hs->has_tt = 1;
 
@@ -1381,22 +1379,21 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 	 * Call the driver's reset() and start() routines.
 	 */
 	ret = usb_add_hcd(hcd_hs, 0, 0);
-	if (ret != 0) {
-		pr_err("usb_add_hcd hs failed %d\n", ret);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "usb_add_hcd hs failed\n");
 		goto put_usb2_hcd;
 	}
 
 	hcd_ss = usb_create_shared_hcd(&vhci_hc_driver, &pdev->dev,
 				       dev_name(&pdev->dev), hcd_hs);
 	if (!hcd_ss) {
-		ret = -ENOMEM;
-		pr_err("create shared hcd failed\n");
+		ret = dev_err_probe(&pdev->dev, -ENOMEM, "create shared hcd failed\n");
 		goto remove_usb2_hcd;
 	}
 
 	ret = usb_add_hcd(hcd_ss, 0, 0);
 	if (ret) {
-		pr_err("usb_add_hcd ss failed %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "usb_add_hcd ss failed\n");
 		goto put_usb3_hcd;
 	}
 

-- 
2.50.0


