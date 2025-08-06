Return-Path: <linux-kernel+bounces-757817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD13B1C70B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5C6720B90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B628C5CF;
	Wed,  6 Aug 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b="3X7WPClh"
Received: from mail3.ecloud.global (mail3.ecloud.global [135.181.139.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D34A00;
	Wed,  6 Aug 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=135.181.139.185
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488385; cv=pass; b=rlIKSznDMFzvpkMnxbBGaHcPDMg79lSCYiAxoP5fLotXR+ot9V1GFReSSqR2s5jUQnq1LpsOwXsdrF7V4Ea0dZScB48yQfkVnEyoWAQp8JnpGwmRAvEFhuaVmmNXE1mezhs5IRVodhOYdJI9zPt7TXauudcvvAAa1kCKlIJ//yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488385; c=relaxed/simple;
	bh=zWV1q7rU97xDtiL9bpJG+ENOUrrgUx1p4Nl2i2KYlBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbsPmWwPLUgicqBrsDgttmElVxjci0HXk2WhbKfkZZJMd2PwnJMSu7CspwrM0KHtR7A7rRZ0iLuXiKYqLZACQHPBlsPpWws/AeaQ6NhWvGpNVgfczg/wo3rhbvslMIFK8yI7Vi+odsPz44tIijXT9iJp6i4K90YssYxxBLy6sOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io; spf=pass smtp.mailfrom=murena.io; dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b=3X7WPClh; arc=pass smtp.client-ip=135.181.139.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murena.io
Received: from authenticated-user (mail3.ecloud.global [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail3.ecloud.global (Postfix) with ESMTPSA id CCC7688A551;
	Wed,  6 Aug 2025 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail3;
	t=1754487955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YR1yS45wdvooEjIeF84tr73vMkd8J1BhZxP/TC1Yqyc=;
	b=3X7WPClhX2AzyhNT4VkkY8OfhSlYEQ0ULAT/hmRf7VMIZyl3hU6aSySfr8RFAO/ALwQmSN
	WnrrE7jkt0JnqZhRkWhx23kb/p4uvyFUSp/rm2O5k7wzG05/bwFuLDNFBlYVSqQjBPrKhU
	+yrEQxE2JeWztynIUnVFXWGgCT8nkxw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
	s=mail3; t=1754487955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YR1yS45wdvooEjIeF84tr73vMkd8J1BhZxP/TC1Yqyc=;
	b=+eJqvMhsH+9Lr0nWpvAELJ69+XqRsZ+nFVW2yzAm0PHP/U7krp89UQ3vpnhTTXhMp6O3ts
	tLhVSVXF0y1AhvyNsLcBfvTfrvER2sEIVzhpQ47UL2iyUiPuh1Jw1pEqDFdK5TO03ewJHc
	sCMSKKQl5zRZJrXuLSJULnnyKG9BUKU=
ARC-Authentication-Results: i=1;
	mail3.ecloud.global;
	auth=pass smtp.mailfrom=mael.guerin@murena.io
ARC-Seal: i=1; s=mail3; d=murena.io; t=1754487955; a=rsa-sha256; cv=none;
	b=uYMcLFsURRTxn1Rr11qPte77BeAXJRfDBxLqzN6xqavdNZ3NCV2FebQ/6/FjV7B7KbaUDa
	nARTJkVEk2KG3rwLm1KjB5Iq+MFQsiHH/FjipZ9+62xXo3WraNF0tHwsIHs2wmacJyqYn9
	aVPr7dLOrymAptI5fJZVIyT9qDEG69o=
From: Mael GUERIN <mael.guerin@murena.io>
To: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mael GUERIN <mael.guerin@murena.io>
Subject: [PATCH 0/1] usb-storage: add quirk for Novatek NTK96550-based camera
Date: Wed,  6 Aug 2025 15:45:22 +0200
Message-ID: <20250806134524.32016-1-mael.guerin@murena.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Mael GUERIN (1):
  usb-storage: Add unusual-devs entry for Novatek NTK96550-based camera

 drivers/usb/storage/unusual_devs.h | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.50.1


