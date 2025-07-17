Return-Path: <linux-kernel+bounces-735563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A6B09105
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA383B6F40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB352FBFEB;
	Thu, 17 Jul 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T1ETQKcH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5232F94B3;
	Thu, 17 Jul 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767730; cv=none; b=P6Vc+UD7BwvRl6xavCzOZYyhAM49HiHw2T6AWjlqKad/hjqT4PKJ8SqQvUHZ9LqftoaxY1bHRuCdkLRxSI82MUEt4drCDIGUjz/JxL0ofosZdJIDvYazziNtDz86WeC9N3lC6LIrGnBDLPdaDIvLqYZLhQE7nZEUUiptSfcAEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767730; c=relaxed/simple;
	bh=Mq75B3YLUjtjut5Sgu7P62yPBv9viF0PjYeZ1ACiQJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5avNCqck1mgCYKRDqBNoYJ0u3uv7ZE2IiBZmfBi95os857FZOriXdyeMv0rQBhmwc6ql549cEhpL1N63clOj1M5SeecbTn3ZWNJhYfG5hQ2SdyYpuHXqLvjrZvdbIjGfe+z05CS1V0MaXcnPQrFNz5hg/T10N2/7gN69UbeMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T1ETQKcH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767727;
	bh=Mq75B3YLUjtjut5Sgu7P62yPBv9viF0PjYeZ1ACiQJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T1ETQKcHD4wQrUkVFUs19SF0WfyrVvY88eQY3T874hsDDcTff+k+cVm816ZkmJTtY
	 ywECvBkz55X9Vk00J1C7r3JNl9zjHybRYx/o9C5OIE4EkWgsgc6bMQfIRKjWVKhMVw
	 sgxhsG2bsSB8hpqGg2f5dueMqsC9fnYGt7KavKkZkLKFbBIJKnFbhrKwZhG8db/UYV
	 6Yl95Z/yQ9U0o9jD9qxpvlo03B6EEEQhFHNuvoHV3XrfJE+iSfBTcLKMxQ+aSX/r4b
	 jYTxVYjw+S8J8hOestJt2ToJty38C1TW+F+m4lfiDp4ylFyJgvSWe11x1y0J1GSFun
	 XeWed1Qd1UvLQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id E7B2F17E1319;
	Thu, 17 Jul 2025 17:55:26 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 17 Jul 2025 18:54:52 +0300
Subject: [PATCH 3/9] usb: vhci-hcd: Simplify NULL comparison
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-vhci-hcd-suspend-fix-v1-3-2b000cd05952@collabora.com>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
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
index f58ba3b5ed50c5cc68d2180a4df78ab4a5f5061d..7e0f11fdbf4fe919265db31768c3a19d27dbdd18 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1133,7 +1133,7 @@ static int hcd_name_to_id(const char *name)
 	int ret;
 
 	c = strchr(name, '.');
-	if (c == NULL)
+	if (!c)
 		return 0;
 
 	ret = kstrtol(c + 1, 10, &val);
@@ -1523,7 +1523,7 @@ static int __init vhci_hcd_init(void)
 		vhci_num_controllers = 1;
 
 	vhcis = kcalloc(vhci_num_controllers, sizeof(struct vhci), GFP_KERNEL);
-	if (vhcis == NULL)
+	if (!vhcis)
 		return -ENOMEM;
 
 	ret = platform_driver_register(&vhci_driver);

-- 
2.50.0


