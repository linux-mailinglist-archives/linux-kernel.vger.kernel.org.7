Return-Path: <linux-kernel+bounces-606963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B7FA8B625
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 11:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296921905B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFD72405E0;
	Wed, 16 Apr 2025 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZahJsC2x"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6D23FC4C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797326; cv=none; b=a4l6DP3Y2AaMgy3uFP3KcwuHKAWyAzq4h3+ynPx09RdAJZDaUftQbGZhwbIjpt4BoA9sKpICXw9n4LOrtL4f6TUCFK9ig2J5/8yL70EUtyHBMib2m1jKNGDvhM6Tcxrh8N20bVGu6NHieQ5EGunUI3N30nP3eqsTacyR7MKFlBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797326; c=relaxed/simple;
	bh=+O/L/5MHMfzsjf6BVoS8AVUm/FO6Ket3M8WtYojklgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JSws3CZZbi863Jg4k4ucn7JnROBFpgxYuGtTfsYaYz4OIiXyc822PKCg0LJNr6uk7aPQ4Pz6k8Sgpb/MqnQxKGokVTCqcxnxRS6GrpL7eGKCxR3sjUZRQVbDcWXOVTP8aOcQBTnzn6HkXwg+6t/4pyLHuWq1HW9CX51idIJm9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZahJsC2x; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224347aef79so86074705ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744797324; x=1745402124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tDoB9oY5pzFrjtX7RQL+H5y6LvbZxxMz1FSpV0+iCQ=;
        b=ZahJsC2xLVXH6pevnXLUDP3yOyYtwl7fHqFZDYHsPd7Ju6ZTPMK/qAbYup2s0FZ4m9
         RJrgbyid5KZ84I2EIGADQre8oIOtC5Sdu7iGw6JbPzwXKrviQLW/9m7BW7YwkPXvMYC+
         EZbjR+Nnu9yjynL47jJjh+iVYTZyL89lnaff7pQXkcpNHsXtajItUidHZUllkMUw1SlP
         XlRz/zogTi5ziuuNQtrU0R6ewEngnaNuH4Jq9TZZ/Pb0KOZPvf3Yy6xhRb4+71PMK6/Z
         NVp0acSpMsnUy1yyg1WCGGejlxGFyVWD/ZPEsfFnaqumiSdq7UvfD08PWSYNAOy6MPkj
         SmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744797324; x=1745402124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tDoB9oY5pzFrjtX7RQL+H5y6LvbZxxMz1FSpV0+iCQ=;
        b=Cgz0o5OZ3eWRq+GKD5t4FhXtgWtJBkQA2+wp1JQ2inf5/Hkk2ZRm8U3rVZ75lGwv41
         zr93eG+t2DXwbLlaKrNa7kMql5U6KGFjD86nTtsQ86EUkHNJpqreJJ0oMXnnVXzlETt1
         7GKlekgf6sRlzEtknkak8S2wbFr8pES7VJO+Ir85JKuaeEG4dZwlNjzC739+wcTY7T8u
         9el9hrkRHpf7mSaZvTtFz/whis+RcnwqsOgeHv6GA4u/mNKITRDpjcwszUxU7kxLeqX6
         ljwfU+jLvBeORS9YZzZFBxTl/9gJHJltscF+Se1H8+W7/uA3Y1qiZ9p0iIl7DtvUSw0K
         Sw2A==
X-Forwarded-Encrypted: i=1; AJvYcCWWoFfHnMoPSb6uO9cd7VhoNbB/obp5wpELlv922bnvtOCVqnwUKOgL5+R1hPPCzay1K06HYLRX/yjaSoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVbmBJu8boVZ3rsS1ijabnFM4fWThwmpKH4xr0Kd/1ShENU19
	UjnWVsBR1XhFsjzhrriWsyLUthyv2g/cVYpCDIwmpmSNMPtKvis6Mz/bJ9ojqE4USvYqw/UBvVe
	3oAEffQ==
X-Google-Smtp-Source: AGHT+IE4gfaJgeJgyjDWgKIoVMFWKOGuhTre5Em731+szH5NipM/QUb+xSn8FcegIOyNHXWuE/NSmJbujIqO
X-Received: from plog20.prod.google.com ([2002:a17:902:8694:b0:223:faee:f527])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1104:b0:220:f795:5f14
 with SMTP id d9443c01a7336-22c359122bdmr15547805ad.27.1744797324104; Wed, 16
 Apr 2025 02:55:24 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:53:38 +0000
In-Reply-To: <20250416095505.769906-1-chharry@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416095505.769906-1-chharry@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250416095505.769906-4-chharry@google.com>
Subject: [PATCH v2 4/4] Revert "Bluetooth: btusb: add sysfs attribute to
 control USB alt setting"
From: Hsin-chen Chuang <chharry@google.com>
To: luiz.dentz@gmail.com
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

This reverts commit b16b327edb4d030fb4c8fe38c7d299074d47ee3f.

The sysfs node introduced by this patch could potentially race with user
space. The original motivation - Support configuring altsetting from the
user space will be added by another series.

Cc: chromeos-bluetooth-upstreaming@chromium.org
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btusb.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 937d69684df8..5fa75a777a71 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3688,32 +3688,6 @@ static const struct file_operations force_poll_sync_fops = {
 	.llseek		= default_llseek,
 };
 
-static ssize_t isoc_alt_show(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	struct btusb_data *data = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
-}
-
-static ssize_t isoc_alt_store(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf, size_t count)
-{
-	struct btusb_data *data = dev_get_drvdata(dev);
-	int alt;
-	int ret;
-
-	if (kstrtoint(buf, 10, &alt))
-		return -EINVAL;
-
-	ret = btusb_switch_alt_setting(data->hdev, alt);
-	return ret < 0 ? ret : count;
-}
-
-static DEVICE_ATTR_RW(isoc_alt);
-
 #define BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS \
 		hci_opcode_pack(HCI_DRV_OGF_DRIVER_SPECIFIC, 0x0000)
 #define BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE	0
@@ -4203,10 +4177,6 @@ static int btusb_probe(struct usb_interface *intf,
 						 data->isoc, data);
 		if (err < 0)
 			goto out_free_dev;
-
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4253,10 +4223,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc) {
-		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
-	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
-- 
2.49.0.604.gff1f9ca942-goog


