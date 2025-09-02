Return-Path: <linux-kernel+bounces-796328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6847B3FF00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D52C81B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE902FF15F;
	Tue,  2 Sep 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fgpXocFG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD32FC867;
	Tue,  2 Sep 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814224; cv=none; b=nMVVSYwigUEmiwAjMbi/UbelBw4seDFUZyafpzRO9GPd2PdSVVVzsdKZV1Fpkp0fNWnX7zRgZoDwPtApRMH5agDPNPEb5Mw6lBwxUOvYjaZ7KU6LsVfbfDgNIE3HiW8Rq4CP2yMQjDQADDdg7lP/JpeEGBWXY3OUWR3dc7iLmTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814224; c=relaxed/simple;
	bh=BpGRJ2nCOdBOHfK+HkfFWIB8NLGRzCDpfAqVeifYDvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WnsI4/nSOaVJWKELh+FxBMtNFsCd9FGRSAsCEoJC9hMgR4EURq7ioS7qMO1xhxszNHnBZ7RVm2+4a8sW9CcZO5Y8RQHXq/7yw0EQgtUpTPGFdO0sOMP1IDMOsI/nWWwCxSVfCKvZv1wPR/MBZFObyMppIFqdwxHjbs14sYdEFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fgpXocFG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814221;
	bh=BpGRJ2nCOdBOHfK+HkfFWIB8NLGRzCDpfAqVeifYDvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fgpXocFGq3xxaq728YI5M/nrWM42dcTa7TWDYPahKoIax7Gmgm6lCJJEfA0cLYx/N
	 gjvzDnaQTohHycyY7WMOeuJuf1sxEtRQ6GfHxNWoFqowFG5ewLvat9xOpGRuwxyIKP
	 KQOFyU8qaG9trROXSySqS8b9dWlM8/nFnPNcIhthcI0LcI8hd2ylTjTYPPQ2HEHCot
	 NCzLZsTUlfRhwYAXRMywH7IR2tSKkBbz9Q23VrqN9BwpKmh58nFatbgCyiqnnz7k7O
	 UScEreG6nR/hOk/w3iVwsFUWpCgqeiDENNEGPswPQMOuVI0gKUypJ2bJ2Nq1JUVlRD
	 lZ3BoT9+FEbjQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id DD68117E1354;
	Tue,  2 Sep 2025 13:57:00 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:28 +0300
Subject: [PATCH 06/17] usb: vhci-hcd: Add spaces around operators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-6-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix a couple of checkpatch reports:

  CHECK: spaces preferred around that '-' (ctx:VxV)
  CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index df25ac939a2273571391562227d5c1628a6377e2..1b442bc564ed26185d172daa32cabd1a3f50f322 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -708,7 +708,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		pr_err("invalid port number %d\n", portnum);
 		return -ENODEV;
 	}
-	vdev = &vhci_hcd->vdev[portnum-1];
+	vdev = &vhci_hcd->vdev[portnum - 1];
 
 	if (!urb->transfer_buffer && !urb->num_sgs &&
 	     urb->transfer_buffer_length) {
@@ -1135,7 +1135,7 @@ static int hcd_name_to_id(const char *name)
 	if (c == NULL)
 		return 0;
 
-	ret = kstrtol(c+1, 10, &val);
+	ret = kstrtol(c + 1, 10, &val);
 	if (ret < 0)
 		return ret;
 

-- 
2.51.0


