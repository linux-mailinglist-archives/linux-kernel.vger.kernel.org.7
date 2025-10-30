Return-Path: <linux-kernel+bounces-877520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE5C1E58B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DB41893F99
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1681C2E336E;
	Thu, 30 Oct 2025 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="ddSVIiQu"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456B23D7CA
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798338; cv=none; b=hgAF6LIYmkiHNgVO5K+QDvUEG655tGViPXYplqj0UnNMjSIA8J/fHR70QEQZxPh7NxFuX43rfuA/nV0xfcVeaI1yMDqPyiwvWeckftX0SD2Y8nlo/CJavTRx8JwZ8kXKF+zKH0ahcHzwikIFseeQaJ1mx77fqIxdxFo+pRaDj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798338; c=relaxed/simple;
	bh=akH7KpJecI4n+QJrs5zH9nQeo0YDkYU2UBuk2BavrVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVEA22WzOUqqurrlVrcoynmj8th2dLarq2XhMi8Uf4aRg4SQCWralSuhO0wb2uoCye7c70NJHrAD74Xw4iwnvE4XkeYHO81SadkSLv8vkqu+4iB6Llhqrm5oadISgNDR8bac289MfQo+zFsps62iHuLRz2zMiB6KyGkU3+MKvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=ddSVIiQu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso391064a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761798335; x=1762403135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6cUclqtjLqmHCCyJ+ZbRyqsvOdXEkvs5Ie/9Febbuw=;
        b=ddSVIiQux12DoSrznFw/KgfWv4RCUijOzECd7MSpEVEfbMHrwUyIt5OehVOiCmzOOc
         PEqvGz065En91gOpJMXKdC6gdLel2icbRZF3/WlU072IIYH3Mu+qrAZ4An6LNZSyoytu
         cqhM4khFtheDO2UEv03V5UYFVVhxUL+qRUvdlUwR83unDXzAOGzZPn1ck+cWYb2AUeow
         EmOu6vQZEd/1PPUxnrVgp7bwW8jz/dqUATPGn1ZExFJF59eLkBu43VYDjUWURYWIMykP
         +ogm+oX0Y7gYh2eBKEhM5Z+j6NGLUq2EcwQb3mkdUlbrlnGxQZEp1ak8fSl/OSw2e/st
         5fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761798335; x=1762403135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6cUclqtjLqmHCCyJ+ZbRyqsvOdXEkvs5Ie/9Febbuw=;
        b=jHyUvTTVdoFvxBQwiwSoFDmpPhS7uDiSzyWFyLP2iNcmzMVmD/+eJP+D5/Iu2aFDqf
         S+WsdXQ4n2TcRYm2cpqCBeBmPILkNE5xGdTNRYI+qmxPvV60xthAOVLLgVwvnuvBB7VE
         VJXvk9BN4VckXz7ZVte/MoZefUPcQGQr7ASwv3ZeW7q4yb8TcpWi7hVgq5QWAuPk3Gbu
         Yd08Fy39TlNV8yKFDVf0X2ZzbHPqrHmXpFvXhrSErqfD1pLnxM7z2HReEGCpzu/It476
         hPDoJ0Hv4eK46MqLksmlM12TuW17Kv1yDUa7WjWUUsuZFiRaoUEGrk1eQ8ymZluK0tAL
         pnKA==
X-Forwarded-Encrypted: i=1; AJvYcCVuwbvJVKglyMV5xd0N/AkOLg7wNyOu7iqq80od1+kBiCrz1QYfCrZTfOKiWIt5wg1YSSXrfXaF8/ouxSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQGDhbzIIiJ2qW7r9xhdM45Zc6kPYKAIzGIEMFutUR1KhVSpZ
	aa2awVLkhBp+ynZU1ukpR/6sqTErDsBdF55ysloTyGfW6sslNMEtJQ7W2HXTNCMRxyg=
X-Gm-Gg: ASbGncuvgYrus61mjFm64Fvr+mXpGhS1Y0uMbquMXLzJMuh2pS1LRkxvZz8Rkx0p6/v
	Q61YnbWrZW2DqB27A00ip5LDxdkMv13+ifCXzhRVk5RseAWGS33iaIwmp7GaKFg6VZCnRhJU4Lw
	LfHp/awZNcEK3deHlJ76LQM9jX0g33LJffO33C2KcK+q+myxDVyU2gSWUyBMiPCnbXV6f+tG/DX
	bq7894ux0lrVNQaQZ+IeZgcUAbQTIRc3GYJledHjzGKwRx8jXCwUi34brxnCN+Z0B2TmPeSrocy
	isCsL5gHbsldRjyL03iCC7pMK/3PXwB08Vl0DuqY3WUvnN9NG1gMChYxWGI20hc/PRIXccIoSew
	5SBVtlNlcmebE1fG0LEkdAkJjxFvDWAppnwhrMlKYdDiCSYUduQarAoqqvacBQkQaL41BAJulpR
	MK5zBHjtEMprX+3BLLobkrU4SB
X-Google-Smtp-Source: AGHT+IH1qZlCrQ7jvNZuabOFz90UxYltHxbnuJBYmWEXINJqkod6nkwwuZ3kM71t1oIhJR8TNZjC7A==
X-Received: by 2002:a17:902:e812:b0:28e:acf2:a782 with SMTP id d9443c01a7336-294deea9585mr62399795ad.37.1761798335012;
        Wed, 29 Oct 2025 21:25:35 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.22])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d0827fsm167991715ad.31.2025.10.29.21.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:25:34 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: isdn@linux-pingi.de
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()
Date: Thu, 30 Oct 2025 09:55:22 +0530
Message-ID: <20251030042524.194812-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hfcsusb_probe(), the memory allocated for ctrl_urb gets leaked when
setup_instance() fails with an error code. Fix that by freeing the urb
before freeing the hw structure. Also change the error paths to use the
goto ladder style.

Compile tested only. Issue found using a prototype static analysis tool.

Fixes: 69f52adb2d53 ("mISDN: Add HFC USB driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
v1->v2:
Updated to use the goto ladder for the error paths, and added a note on
testing and detection, as suggested by Simon Horman.

Link to v1:
https://patchwork.kernel.org/project/netdevbpf/patch/20251024173458.283837-1-nihaal@cse.iitm.ac.in/

 drivers/isdn/hardware/mISDN/hfcsusb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index e54419a4e731..541a20cb58f1 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1904,13 +1904,13 @@ setup_instance(struct hfcsusb *hw, struct device *parent)
 	mISDN_freebchannel(&hw->bch[1]);
 	mISDN_freebchannel(&hw->bch[0]);
 	mISDN_freedchannel(&hw->dch);
-	kfree(hw);
 	return err;
 }
 
 static int
 hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
+	int err;
 	struct hfcsusb			*hw;
 	struct usb_device		*dev = interface_to_usbdev(intf);
 	struct usb_host_interface	*iface = intf->cur_altsetting;
@@ -2101,20 +2101,28 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (!hw->ctrl_urb) {
 		pr_warn("%s: No memory for control urb\n",
 			driver_info->vend_name);
-		kfree(hw);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_free_hw;
 	}
 
 	pr_info("%s: %s: detected \"%s\" (%s, if=%d alt=%d)\n",
 		hw->name, __func__, driver_info->vend_name,
 		conf_str[small_match], ifnum, alt_used);
 
-	if (setup_instance(hw, dev->dev.parent))
-		return -EIO;
+	if (setup_instance(hw, dev->dev.parent)) {
+		err = -EIO;
+		goto err_free_urb;
+	}
 
 	hw->intf = intf;
 	usb_set_intfdata(hw->intf, hw);
 	return 0;
+
+err_free_urb:
+	usb_free_urb(hw->ctrl_urb);
+err_free_hw:
+	kfree(hw);
+	return err;
 }
 
 /* function called when an active device is removed */
-- 
2.43.0


