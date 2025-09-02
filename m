Return-Path: <linux-kernel+bounces-797401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0754B41002
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620BA70301F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA082765FF;
	Tue,  2 Sep 2025 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWF/oUsH"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CC223DFD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851838; cv=none; b=Cm2otzpcfjV/YAvLpG7R8hxuDfXEV9CCU33iExHQLIwI/JBYQAzxXrg+WPHRHtdrtxKNY7XaOgarHUInQmQPZTNotDUR+C0Sh1ropIbLkoBDIdrb4nCePfkH5dqPiO2fzNQZsqdPnGyNvNEH8trPvBS8p+hhJtXkDa1FkGou1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851838; c=relaxed/simple;
	bh=lrrGq05uBqDUnENPp27Ejo8lITvAmMR+nAFQ9QTzujQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PtMLe6L/+9/yPkTn8PenExnjqPD+mWa7oll60JibfRWU9l2b1uL7togHrvWuM9CeOEu3JcnsY6iKJAZ1Z5LbOXG4sv4A5/kIrMf/EsT15u/ZQj9HOdx/jwKw/mPwN95cdRsUw1AFsVRlrSzJoMV9iQ4s6max/42CQ966V+eWMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWF/oUsH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so877272f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756851835; x=1757456635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPCllzbZKVVF2KM92LpxrwyKTATB9gAdtcbS8pQ8SHQ=;
        b=BWF/oUsHJ193ILznFsu9BBTZQUAhEfNpE0HvW6TrZVU9RGeHp23IvVnr6ePKo14Bnx
         rb2wIkveMf6K53g1mTQ7F8lACZph5vjQyJgkrL04RlEkEy5dkv25KAJyXBJSZcM64G96
         xZ4N1dXVfTRiCVNQO8+zDhYMMb46Wa8ut8HowDqoWXEBwJ0sxDh1T948aJorKCOoKpbO
         CGpJluHCupJRMLCZoxKUAx/VkZbZTKOkQ1GV0Qdg/HLC9E1gt1lFQvlNN5R53WZ0WclU
         tMSx5RrOTNdG+++nV7UMmVJpoj856r7CpcnoU0qdde8mq70YvgHWT05/BktFenzKQAoa
         LlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851835; x=1757456635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPCllzbZKVVF2KM92LpxrwyKTATB9gAdtcbS8pQ8SHQ=;
        b=dCKqyHjc2e8ryHEw3WeD61zxtVFwnYOpzfo7IVMZJ9IXcAkmIp07U8yZE3FeDleN2w
         THkf28tGUqkenhvhNMFhe1FtE1X/1TLQZhrZ4SM4IteIAfBaGtdGWAZ3T//ZNdk7Wkcb
         oSZaMraHffrIsLGB6TvnqL2VrveKcQoNU+sagpqf/i5+SP+3MAJNpG0VxCGcymntL8gG
         BzTPNu4v/wGOT1x+MLx+dsKmhTEp5eIPo8378utA/Yj5KoZAxpg3wW/tBijULokJYEJe
         tE0VLkeSWz3CDKiN139FVylZuxAPHYvE/onbCHxNjfJSDahRTX0aOXRWVC53wFlb9FFn
         K4LA==
X-Forwarded-Encrypted: i=1; AJvYcCW8tW9tlJU09+jVH2CzSVPVs/aA+WcIqe/lOCMBSZ4/AQ08oZvxSstJSMxUyParasUcts22NDv04TH9IkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mCGdD8ZV8s29dVVGP08nLsDgTHqfMfu0mb9XtX8w9EFG/MtO
	mB9f0CBNNsXp4abU6DlYuNSSmUZHGPuvw6hvb5HHDVVnL8ZoPi6B5ug=
X-Gm-Gg: ASbGncsP98xRFPbyygpQzajzpdU/s2ieqZmGG6wHVER5UtuH0TvlG48vjl3+W4oD9K2
	aWA+mpx2T7U/DvftBC9wQ9NKXzuO0bjClE6/s6aC8XN8tInpZXRP+83mxgVrerqiClEjX/7oPQx
	KlZVLgcOhCBZvtmHA5xM59iqTPR1PeNpScKXLsC39moTW0GX1SyBGwoxvNyrwN+2/5c5Tb68bPh
	MiAoXPx/f6KJ34Q3oU0yqvDlaalvh1Jp5SSOWYSk66bwkTIuNl/49OjHWataxL++dPta/waAEgk
	kFz1WljPVsa0FNU6/D34N2CapG4r/m9Nk9Qodl6+jX80sn9Rm+p0eh/ncTYmEuhf0lMmlfTRzgT
	ELqru08XxcLTmNq8x9Ibe3zco1aIRqAdnZxzdptvg1h2JrsN58XVMJ88/x69CZw==
X-Google-Smtp-Source: AGHT+IEfJgab8GfiryC5WdSKmZQ9zpYxvPj9Lr1/MRPjNVZKqe+HOaH7VF4ZsQDNtz9cSknuX0R6/A==
X-Received: by 2002:a05:6000:1ace:b0:3cf:a44b:26fd with SMTP id ffacd0b85a97d-3d1dd81c504mr6508443f8f.8.1756851835387;
        Tue, 02 Sep 2025 15:23:55 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:7287:75b3:5214:63cf:2c39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf8a64fce8sm20833683f8f.34.2025.09.02.15.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:23:54 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux@armlinux.org.uk
Cc: linus.walleij@linaro.org,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ARM: configs: u8500: Set NFC_SHDLC as built-in
Date: Wed,  3 Sep 2025 00:23:34 +0200
Message-Id: <20250902222334.105236-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CONFIG_NFC_SHDLC=m setting in u8500_defconfig causes a Kconfig
warning because the NFC_SHDLC symbol does not support being built
as a module.

Change the selection from 'm' to 'y' to build the driver in-kernel.

Fixes: 344cad0660ea0 ("ARM: configs: Update U8500 defconfig")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 arch/arm/configs/u8500_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 0f55815eecb..9c8dc6dd5fe 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -40,7 +40,7 @@ CONFIG_MAC80211_LEDS=y
 CONFIG_CAIF=y
 CONFIG_NFC=m
 CONFIG_NFC_HCI=m
-CONFIG_NFC_SHDLC=m
+CONFIG_NFC_SHDLC=y
 CONFIG_NFC_PN544_I2C=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-- 
2.39.5


