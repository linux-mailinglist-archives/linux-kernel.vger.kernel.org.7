Return-Path: <linux-kernel+bounces-753063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E233B17E44
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D094E6251
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE321A449;
	Fri,  1 Aug 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HyNcZ/uj"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207871F5619;
	Fri,  1 Aug 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036878; cv=none; b=QeZNws/91VxTcDLIv/CIOtQ9BF7HHnLEnr3wYZlZ8MfYwzyzEVb00L7HLZDcx5ozddIEiWOm44l9VzAFK/M04ycxxVO4SPbWRF31I/yxM+iIksmyIoBcN1uklTDOvBvWXVphlrABHK/O513anwOU/h9l67C73yjI32x5OeGayNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036878; c=relaxed/simple;
	bh=kF94KblkvNaW0a492n1o8gF4V8HnWLee2s8FOfCrzKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8QAPAHmqhI2YEnm343Z3DK3NxFkijvYL0ywh9/N/iASj6odQTzpHHnskdcCVsF4iuNuEOgDyg02/7Ie36suqviidXFffAMTHUDCgKSZbPFEhJlClcrwFVpkzzLgsGVW8lYdFqDdpl2mLu24k4J0amjQXDfGjqtoJN2g1RLIl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HyNcZ/uj; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=J4
	ZX4k6AGFiA+bdNl/yhf8pOKiVOEBfJK3/s0ofw8h8=; b=HyNcZ/ujltgcfTZSyK
	Ac+Hi4/ivYIBb4sTD7ogKmc3jWlbw/z+QFFZIQ9vDXdkD0gztsCoJn4UAN7K06Ah
	oI0NO4O8yqIK13kFL+rH4uesUUISLjFCQ5ijhDLCgqLLJi2Gfpeypuu7Z9zpr5rr
	ItTyJpPraSL1vVMDp29fjd29g=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAn+gmAeoxo55tXIw--.8218S2;
	Fri, 01 Aug 2025 16:27:45 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>
Subject: [PATCH] usb: quirks: Add DELAY_INIT quick for another SanDisk 3.2Gen1 Flash Drive
Date: Fri,  1 Aug 2025 16:27:28 +0800
Message-Id: <20250801082728.469406-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn+gmAeoxo55tXIw--.8218S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF18uw4kXFy7AF4kWr4fuFg_yoWfXrb_Cr
	yDWa97ua18J3Zrtr4vya1Fvr48tw4q9ryv9ayDtw13JF4UCws5JrW7JrWUZr1UGr9xtFsr
	Kws7Gw1kuFn7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRrcT5UUUUU==
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/1tbiERmczWiMdVKjmQAAsg

From: Miao Li <limiao@kylinos.cn>

Another SanDisk 3.2Gen1 Flash Drive also need DELAY_INIT quick,
or it will randomly work incorrectly on Huawei hisi platforms
when doing reboot test.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/usb/core/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index ff0ff95d5cca..f5bc53875330 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -371,6 +371,7 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
 
 	/* SanDisk Corp. SanDisk 3.2Gen1 */
+	{ USB_DEVICE(0x0781, 0x5596), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* SanDisk Extreme 55AE */
-- 
2.25.1


