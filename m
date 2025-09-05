Return-Path: <linux-kernel+bounces-802907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24252B45842
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5BDA08591
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D4C35084C;
	Fri,  5 Sep 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUmA2no0"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B134AB0A;
	Fri,  5 Sep 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076875; cv=none; b=DdnPQnodVcikHFkG6GB887Dpq/Bika53swBswG+TEYVZjYTNyaPVdSOFkea6Kbqh/6CigAF7NBIUkJJ6v57P8+1XJXsjCUm2rsH+bNDQaEZQv+M7VgukagD+HxUY62zVslouDkgKDdOE00lvZhajRPb8vukL27T8B6AhhTc0j6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076875; c=relaxed/simple;
	bh=IZK6zl3u5zSxSBwKBG2YF0MDPUkHUhLLXXVjQrfuQNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFjczjOovzAL23IBrrw7Svz39Sw1C1qHTrCb0hFfhQTjR8NDTLSK2rGPjQgycgY4rxSdNAJ4KbP0Rdanyec9SjHBhPCEc2AJyxt8BaGOCIqJWEebtMRDseRWKEiTd7LIh8ipUcYE50d8iQ6Ks0AX8Ijs2IxTGf9DM4iAuCQ/oKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUmA2no0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so1777733b3a.3;
        Fri, 05 Sep 2025 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076873; x=1757681673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsVe1zNOC/H6ojIiXUvMEvLQQ40mzIiSdTqnpSLIO+s=;
        b=GUmA2no0lJgRKmLpYP0WNsP1Wi7Iqvext45A1KDNEkO8EHPE7FgIKeV0z6VzSnTDYx
         Ktk3XSI6CXQkBdBP/OFblq6vYrdkDlFWhWuSMA7xoM4zHHVoLU4N9pEXwZdHWIAEtKRl
         sPNRaXGufLsdrgD+fVZkAjh9703FAiQdu46uYGP1Es1RRvaXdwpt3ZKXHfMesQ3jLdEV
         SP3/r9UZxCrim2fRyFc+PZ1tj5P/PtaOJKtEyMu1jWQgQmQkFRrR9NGcOlbrcxS4nTyt
         8S3E/mbeCiW1p71Rdo0xFQg6kEOu+wMRaTNioZ+R/HhwwhX3JkFRy+fdRM2hAJ2JPSTC
         OaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076873; x=1757681673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsVe1zNOC/H6ojIiXUvMEvLQQ40mzIiSdTqnpSLIO+s=;
        b=V1gdRQynFzZBJxst/57vAwHqIzp4bzKu2AtP8yGNs5+JM1ptAnw16IbFGBV8WPd+I2
         vm+ozwTTdQ6LFoIZO9b/d+w+kOtW5OIy8mPBQJstVNsmaAwkCfcdGLuRVWUwwdGB7xgU
         b7C2SbNJmdOLEHLer5T2ccPIXKF+pW09L8tIFubATrw1k17jlSPPxckZksKg772t942X
         Nz4zHC1GL96znB9MxW7BGTi35iEqXpRi1uaX3c5Bo3KR6P/+bWtIqUBRSAsKxJVp4fy+
         819umI99QsftWcCFISlzoj+VN3P8mvbGsJ3UVibu3yktv+N83xLOMG0uZ32Eg4UQT3Ed
         RDQw==
X-Forwarded-Encrypted: i=1; AJvYcCUt4n1IB9UxtKPfEXupqb1PAsSEJBZF8gCSYXvWdOY3DyqUZxJ7o70/+0c/WToQ4CQ5e1/KW94BZ+2i@vger.kernel.org, AJvYcCWcwCG3itiyR6VgmUvdvJfTHljdvkB7yVtPVclaY6v4EWFrIG3B35LhPTcIWImVGD5TwTTIWS1DcvZWvkHs@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVwhS7CzgM4kOKxVrBS/SORAMvI40vtIGKaDxQuuQtQy83pFh
	SqwEwBq8t9b8J0xi43cdcs7B2OMp33ft7u5Y7LsVPJnkzagtzkZH93N/h/1kpOjor71rRC3J
X-Gm-Gg: ASbGncus5xA+IW4j7ykiPKCnqq0mFMvvhsCcHPV6K4/JNliGU0ePNJXpyyDjEdqLrml
	BFXxIkeM9KkO/J+kh1bzwPOHjgvDfJCYwjRZwqXM70amP2QU0GjfxB8BPTycdKjq5Gov4PHWiPt
	sUZupgi3eTYDQXoaLF7f5OVlFXSNVfhIbipAqCb9iGrPPlzRTe8F+8hpKUlveK68S3Ck8/UPVnF
	adjY+YG1LKSi6kqOku7z6vwf9BBCzHcazGjpgGQhJS7tYnkxXz3EjX00M/RhMdB/QIpxrv7zV7X
	UHamd0Sen6XkvvRuktkpDnQzlq0yyfh8IY0P/OQPrkWKoIWw02RL5M3hfTVsGBzdo6cY8310ugZ
	O6k1+RwJS64iOATEB2mNBew==
X-Google-Smtp-Source: AGHT+IGSB/6psGMdfnR0iXpbtMTHmVJmb0qzrCCGWnM1iEKu1OnqX44klrv8XQHpsVoJpsKMYBJaTA==
X-Received: by 2002:a05:6a20:1592:b0:243:a373:a9e8 with SMTP id adf61e73a8af0-243d6f030bamr31504446637.38.1757076872830;
        Fri, 05 Sep 2025 05:54:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb98f9f6asm4992305a12.8.2025.09.05.05.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:54:32 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v1 0/4] Fix USB controller support for RK3368
Date: Fri,  5 Sep 2025 20:53:13 +0800
Message-ID: <20250905125318.7956-1-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixs USB controller support for the Rockchip RK3368 SoC.

Key changes:
 - Update phy-rockchip-inno-usb2 driver to preperly handle RK3368 usb
   phy initialization and configuration.
 - Add usb PHY node to rk3368.dtsi with correct clocks and register
   mapping.
 - Add missing OHCI node, add missing attribute for usb host node.
 - Add dt-bindings document.

These changes were tested on a RK3368-based board [1]. Both of USB ports
can emumerate device (HID and mass storage).

Main code changes come from the rockchip downstream source [2].

[1] https://ieiao.github.io/wiki/embedded-dev/rockchip/rk3368
[2] https://github.com/rockchip-linux/kernel

Tested-by: WeiHao Li <cn.liweihao@gmail.com>
Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>

WeiHao Li (4):
  phy: rockchip: inno-usb2: Add usb2 phy support for RK3368
  arm64: dts: rockchip: Add USB2.0 PHY for RK3368
  dt-bindings: phy: rockchip,inno-usb2phy: Document rk3368 usb phy
  arm64: dts: rockchip: Add phys attribute for USB host node

 .../bindings/phy/rockchip,inno-usb2phy.yaml   |  2 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      | 47 +++++++++++++++++-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 49 +++++++++++++++++++
 3 files changed, 96 insertions(+), 2 deletions(-)

-- 
2.39.5


