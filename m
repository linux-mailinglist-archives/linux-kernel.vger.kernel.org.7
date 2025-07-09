Return-Path: <linux-kernel+bounces-722902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 201F2AFE07B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F7F18879B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138E926B778;
	Wed,  9 Jul 2025 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BBevW1VN"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D628468F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043513; cv=none; b=AtTmRutzdQ3uun9woh741Dqqc9nRjdaFzjya/5xUnG1DiQF0bt77YDGwa/pSRWR2IriUJt3hc3GvcO4tefgt1Z4Z5pdrQ7+Q9ON0GV6sE9/FNoEz8sodu5nhgk43IiAlRXQPbd87rwT9IMAwejt8Qy1WOG/CibwEebaGkc4bzjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043513; c=relaxed/simple;
	bh=SQeZSs3fjZTm/d2JUDvde9hFjG2wrLvI3Y7DviBDdro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULbcTg5l3Q7mGRhxulxtCL4ptre3c9Hm493YBgQd+Yk5vWJ7fPKdWm1poEI3184vT/PEmbTjg7/Fb7G6bTx62yZbOIzbZnAp+9GNWLyx6+/vzreWWaXvGIYtoWOKQRDCSrTy+AlKaCUs6LtlFrXtbEDoOKF4MgsGzhQSlA6Ky0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BBevW1VN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 917873F475
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1752042971;
	bh=zmTk/bLQEATrkW5ZhuNgtPLCeoO7OY3pblXNYUWXoMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=BBevW1VNAuOl2BHRSpGcTIB4WXucGrcYA4Gno4sTV5GKDR9QB+vmyeWqyls0Jf6TF
	 wpKyKO6IuRwsDEssfjzpJWpkLfoc1vfJEhecR4Wf8h3hFnsTb471ulcp3ZQ/qf0shs
	 VSJCuKMuG85S+9f2HfIq3vkY+budM/7bmyjid/Dyjmr73LYnz32xcb6RAS+cRAbKDS
	 qbW6ClZsaLg9fmUGNJrDTlgw3G2mcCV9WkR8UNQMorfMkhWBwmox3IV3UaKdt7naId
	 BljDx7kPbPIkKnpNDD4KhdGJccLIWT0HSexT3qPBvBpSP0Ixn2FsEDUHkSMKB1kXTS
	 KY7C7yxJQKvRg==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-237f8d64263so50423155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752042970; x=1752647770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmTk/bLQEATrkW5ZhuNgtPLCeoO7OY3pblXNYUWXoMQ=;
        b=bkFnUqJd/qFAXI9RHaswo1XlzHGxJ7kGFqV2RZwNinbh1qJAzTXzVVozEt7bypqGtQ
         0yzjzqQYi1zk0Hg4TuFVwtAeazGQKMX+VGwNc/zdghsNNA2rUvTPcu1zedID0i+WuMY2
         lBBsZTHkdUifp+0jfJVqSiDLSYXSA8Yl0jYXsg5FAGRO3A0H8UbfFp+/Urwa56VSYxdU
         Q1EdiKz93WC4hTuTXhjaG8QiuxGAvM+UCMzxt1NbVjPC/viJYl2SYcggdYwPWoedhyCO
         c3EJjN0tUosb4A0SEjML5LIFM3It5djpdwO6xCGq0vP+bruUHQAQvxOsVv3W1DUPCZRr
         KP4g==
X-Forwarded-Encrypted: i=1; AJvYcCXsoVsQCi/A9t2Mq/SAcLCTMAjbnVIgLnW+bNThYkyo3nPRp6jiYd9mPu7RJSMMR4TV9b5c6OvyRK5FLko=@vger.kernel.org
X-Gm-Message-State: AOJu0YydX4eOMOJ4MHeWn3Vl4i/uAVU7GIGc62a7MFGALzpe+rqHJoKo
	qHW99fLs9944+ffRtnOgdvtxlaAArCPH+WbzkmjSy1bQcLyLxDtEcCylCyOFEpAONrBDTX6tsRY
	edkqix0LFXBK/fLEmrHwtkuGKLXldvmRHDd+d2Jfx06ru9AfifRhHCeAv93vjC6ZBAjGuaoLbvG
	tMDRQoEA==
X-Gm-Gg: ASbGncu0pW9PtbkTGS60YIi3m5ox9UyC6szWciOZ1ot7lLhrhlZbZ/YmV4ZjlprsmKu
	BXFHqihRyrX++nf5Hvv8VZTYTounm7+yJC18R83Csky74L0Yy/tE6U4gOf+ZK8RrcHKEzX9IWeF
	KUvkjZzS6gIZFNhxYQsSluD6sJzSn0FIDANtbHRYM9xl1Tobbu25EUjJbVDde8lbd8V5dLCY9xv
	62tGfeJkFlvAY4T98wEEjuX2T8So9omndNLsJmK2kLB+HlSy9FQzjcILhBgjTsXXEviB9SE7YUk
	LUcZs1g9YQp+gLTNWrXV1BH/OFRLn6ZgVWj4qmENPszpG259ua7ZK8DGhjjuhQcRPjhtht20xkl
	zRyUFUjU3wt96NLx75okvUAE6
X-Received: by 2002:a17:902:ccc8:b0:236:6f7b:bf33 with SMTP id d9443c01a7336-23ddb2e6794mr24592365ad.24.1752042970064;
        Tue, 08 Jul 2025 23:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb1yK7GzVpWZ21nqMLdUIn2S5TE/zoZmGFxw6MqotPvtA6RRu0o+2eYJ78aGSZrUJzzS8CiA==
X-Received: by 2002:a17:902:ccc8:b0:236:6f7b:bf33 with SMTP id d9443c01a7336-23ddb2e6794mr24592035ad.24.1752042969658;
        Tue, 08 Jul 2025 23:36:09 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a4c6sm128172265ad.46.2025.07.08.23.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:36:09 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: cegolf@ugholf.net
Subject: [PATCH RESEND] Bluetooth: btusb: Add new VID/PID 0489/e14e for MT7925
Date: Wed,  9 Jul 2025 14:36:06 +0800
Message-ID: <20250709063606.25806-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add VID 0489 & PID e14e for MediaTek MT7925 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e14e Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index abdb07d71be0..a2d423fd8663 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -669,6 +669,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe139), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe150), .driver_info = BTUSB_MEDIATEK |
-- 
2.43.0


