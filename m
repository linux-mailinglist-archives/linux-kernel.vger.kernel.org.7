Return-Path: <linux-kernel+bounces-746432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3378CB1269C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379FC179236
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1D26E6F4;
	Fri, 25 Jul 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NJWZQRr2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0D26B76A;
	Fri, 25 Jul 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481310; cv=none; b=f0C15xeF+p7JGUHzbK1yWHf8eQ5cMlI2GtGV+HZ//J62mqZ6mgxnxjR+XxDtv41WAq0v7BHjlviCJsMrMdRJzsNbmG962kTU7+mOxAZ6bsBBtCe+dw+yx5cS700cuZ6yMQNlvonFwOnsX3g7peuuYC7EyLf+IrlxR4rdzGH2TAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481310; c=relaxed/simple;
	bh=BTiZt0A3QcfiED5Ytviafe/ndXfvYdnp38ZNGVjYV/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SCOe/pBaCTgMuGFC/XLvk8GLZeNubG230Zj+zKfcHTEuYVRo3d5c/Jss15SmCq6EEQsSRh9sWJZ14BRhYanUQcLrjfzcIt2KyEhQwLSr+Fyt/d4THC339Nj+QJPLr6ueshEZUjl/469TQ7UoxRm1eQJJPD9hqM8dor8yXkDEcyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NJWZQRr2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481306;
	bh=BTiZt0A3QcfiED5Ytviafe/ndXfvYdnp38ZNGVjYV/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NJWZQRr2QWrip00HWvntGMvMYJRL8qOKDmc7B2G64voL/Xb2t8AYfOkp+2sE0CqPc
	 ChS6cxgoXJM/w5w7GhKkNzzl8sxmGwh8MgAJxtNhK74DUDBatW6GBduKpzbbr+nXYK
	 WK3fL07lyN/NWWwNdrytvWxLy10mcJsBTeV1jt8dnbrdzfukZyHyaV4aRz55L/V+ua
	 TsdmfP7wxjark+qMwPBr0h9Sp4P33qtJOW2GA2j3xeETo0GmCwfTnkUTlafngwgaNB
	 W/SfxPxiADjoMckJdlcc6v2R+KimxtK++IhJSNDuLjhod/vCTRjkQVNFe6dYCx3KBa
	 8YWNAMEnOoHjA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id AC4B517E14E7;
	Sat, 26 Jul 2025 00:08:26 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:12 +0300
Subject: [PATCH v2 10/18] usb: vhci-hcd: Simplify NULL comparison
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-10-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Use the shorter variants as suggested by checkpatch.pl:

  CHECK: Comparison to NULL could be written "!c"
  CHECK: Comparison to NULL could be written "!vhcis"

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 15e1613f4d196e0172131ac722e62c5c579c6346..cda42ca492897e4ebf0055a317916874cab94ad6 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1153,7 +1153,7 @@ static int hcd_name_to_id(const char *name)
 	int ret;
 
 	c = strchr(name, '.');
-	if (c == NULL)
+	if (!c)
 		return 0;
 
 	ret = kstrtol(c + 1, 10, &val);
@@ -1543,7 +1543,7 @@ static int __init vhci_hcd_init(void)
 		vhci_num_controllers = 1;
 
 	vhcis = kcalloc(vhci_num_controllers, sizeof(struct vhci), GFP_KERNEL);
-	if (vhcis == NULL)
+	if (!vhcis)
 		return -ENOMEM;
 
 	ret = platform_driver_register(&vhci_driver);

-- 
2.50.0


