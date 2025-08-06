Return-Path: <linux-kernel+bounces-758040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBEBB1CA0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E2718C3C56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232F429AB1A;
	Wed,  6 Aug 2025 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b="oQdWIakC"
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AB1A23A9;
	Wed,  6 Aug 2025 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=135.181.6.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499185; cv=pass; b=E6L7SjVqeptNjy5zn0LfziGz3f1ofKnUSunWfleN/o+Tan0+dsIdCOqEA+oTUuLFJWiTL01Gq0Gl5UpxDqWeHCvFZb6F2Dfr5ybi7y625gzySzqQVvtxmiO+8/WSbfJwUaKwn1Cubq7GyiBlE63Ifp0n+jO6n0/kUBwsafsYmN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499185; c=relaxed/simple;
	bh=IRT6rwbL4X0DdZuWPbr7pZKiwjI8xp3jX+0axIrxF6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRx354xBj3AVR1sxsNfuJ2rTCRkqTqHvVzRwLIGhsSEkKG/Ia6uHhy3luQ0DKu5QEsPhnnqN41wfe3u+sYQCBK+zco5WZBLf5gblye3nLORwrVLnJ896YhhNGV69LMXjjovwklCrCuZDQaeZ4pJqk04AKOjEpZ+XXy+yOTPRun0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io; spf=pass smtp.mailfrom=murena.io; dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b=oQdWIakC; arc=pass smtp.client-ip=135.181.6.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murena.io
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.ecloud.global (Postfix) with ESMTPSA id 11C49721093;
	Wed,  6 Aug 2025 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
	t=1754498657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HlsPHu0lunuNuH/+9Lf02QRfkfxBhwZcQROZqbYrBI=;
	b=oQdWIakC5eJNfHISWopI24OjijY8hhwWR4vKVZvrhtX3oeWJg7jjSJStdaFyEkNrZvldEe
	kknImvJ+kWvsptZoIYJnpUHtLY/aA4y6my1QYaDjjfAEGQWfiwp/30x2+mZb5DtgggUTUY
	uyMDRtsQ4o22U9+S9rrRdOE+yG4ZfsI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
	s=mail2; t=1754498657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HlsPHu0lunuNuH/+9Lf02QRfkfxBhwZcQROZqbYrBI=;
	b=Li78kQ0lVjE/v5fiOaRgM5oUJe6IkWWHv2Fjt5v3huf4RD3PT5kC5S9+jd9UlKaea9Utut
	So+rLQDvEWRqagPp8LwQz2vul5Lp8A1/lno6ZMquPOQLF27Qqe6+FtcMezxrcRcdrVxFG0
	AEIGR5534BdVDkdJOMdFpJ5SuS8Sw+A=
ARC-Authentication-Results: i=1;
	mail2.ecloud.global;
	auth=pass smtp.mailfrom=mael.guerin@murena.io
ARC-Seal: i=1; s=mail2; d=murena.io; t=1754498657; a=rsa-sha256; cv=none;
	b=YQbiqqlaghWJNmPAEeEhSrQIQIzkq+07MjPirDhai3vj16pjNR7TwuykhiNN0mmTsYx841
	65kt+wi+JSrwbIgymnHTuy8oIDan4zc5oMG8HT2LhFOkMjfaZ26atErLUykDD4wL8i0DoV
	gN+fvv5NdneQDlv2mTQ4nV5qTHfSDJQ=
From: Mael GUERIN <mael.guerin@murena.io>
To: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mael GUERIN <mael.guerin@murena.io>
Subject: [PATCH v2 1/1] usb-storage: Add unusual-devs entry for Novatek NTK96550-based camera
Date: Wed,  6 Aug 2025 18:44:03 +0200
Message-ID: <20250806164406.43450-1-mael.guerin@murena.io>
In-Reply-To: <20250806134722.32140-2-mael.guerin@murena.io>
References: <20250806134722.32140-2-mael.guerin@murena.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the US_FL_BULK_IGNORE_TAG quirk for Novatek NTK96550-based camera
to fix USB resets after sending SCSI vendor commands due to CBW and
CSW tags difference, leading to undesired slowness while communicating
with the device.

Please find below the copy of /sys/kernel/debug/usb/devices with my
device plugged in (listed as TechSys USB mass storage here, the
underlying chipset being the Novatek NTK96550-based camera):

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0603 ProdID=8611 Rev= 0.01
S:  Manufacturer=TechSys
S:  Product=USB Mass Storage
S:  SerialNumber=966110000000100
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Mael GUERIN <mael.guerin@murena.io>
---
Thanks for your review and your advice. Here's the updated version of the
patch with a correct description as well as the unusual_devs.h file sorted
correctly.

 drivers/usb/storage/unusual_devs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 54f0b1c83..bee9f1e80 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -934,6 +934,13 @@ UNUSUAL_DEV(  0x05e3, 0x0723, 0x9451, 0x9451,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_SANE_SENSE ),
 
+/* Added by Maël GUERIN <mael.guerin@murena.io> */
+UNUSUAL_DEV(  0x0603, 0x8611, 0x0000, 0xffff,
+		"Novatek",
+		"NTK96550-based camera",
+		USB_SC_SCSI, USB_PR_BULK, NULL,
+		US_FL_BULK_IGNORE_TAG ),
+
 /*
  * Reported by Hanno Boeck <hanno@gmx.de>
  * Taken from the Lycoris Kernel
-- 
2.50.1


