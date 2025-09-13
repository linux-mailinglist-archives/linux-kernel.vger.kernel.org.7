Return-Path: <linux-kernel+bounces-815350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C742B56325
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FE2AA0954
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1643728468E;
	Sat, 13 Sep 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRiKKIgV"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11CE283C89
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798491; cv=none; b=burgwhQON8U10lTJyaPO7cAdLVRrrwT/stVtaHKLovU+Pu6NDqHtj9ZknLmWxc1KMOWMJAxx2CCmlg0GRQ09Euo2Ta8j9GfY7wVaChemAL4boXSJCs/Y/AcvSg5RnvONYu+x3/wtbnal7ye0GLop5VugfmGugRimNBYUVuTw6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798491; c=relaxed/simple;
	bh=8zTxgMnEbpJztdLg6jikdNo8zifCDUcjqv2xo8Nf+pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FCxpSJdE2vatI2KZQquMsz56Ux6fK3F4nKWd4QxRu68tYzseRxqYdkOQIK+yfC311tan6FLv29FveTwYg8twgNFNduv8nHHF6yGzpOncVf1wt76tVdnYUtmK3Zy+NR5YaMQGYG4nR45gVxj5CRnsByDD5v/SvH6wQFM3ZwF8ntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRiKKIgV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so16539935e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798488; x=1758403288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xL3C//pZp2AWlO03t2q6KgLvL06f+SJHlgWyKC0fL+c=;
        b=TRiKKIgVensxO2i3j1zTC8pttJJWmVAGxoOxvEr83YTgaWrPzbqkOZdMMP7IVqXz39
         j0iPl+s865CY9295gZNLSbJtBYhe4Qk/xdWjA8ancwnMQpjt9bRiAqlm6cOQ+7u7pRNI
         TGOqUG1QF/cZo2kEzjkybHu4zj2wbmKp5otuGy5+dX/A1P53G3oMhsCjHYNM6nZTW/F2
         5eFYsOp3FCOA6DtFwmh/9dX101hkL1GPkx5bzpRDrElPHHyqReDmSEXa3EkD1ik2n92F
         7aL6BAWfChsfwjq5Uzo5r1pLuBDzOYMl5Yq9P798xF6beWV3hiJTDmXnCMt6GIXDWqrv
         VTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798488; x=1758403288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xL3C//pZp2AWlO03t2q6KgLvL06f+SJHlgWyKC0fL+c=;
        b=Pkg/Rpg2IxWnG+m9PGItQgrW8PlgnZ9KRqmje9FiZmehtKSzXtDk9zTxUp3SUwdbPe
         tmRpvjIzIv41MBwq3JSWynZTcKtDaTrnMhYOgPr81WKw/dlxykJu+0pyFnsuD4Wd3FuZ
         JKNY/ed7t8YyuDY6h87OC9tIgG3xEVuSH+aFzD+izo+K4g/E+D07ypVAO23X6PiJvq+8
         pMBSeFz596d2Gdr30RZKpFg5DDbHCV2qMlSjMtMJ7rV1E2dMO+9LAlufUHaAlaz5BFQB
         nxycpKAzjTAYphvv2WDcPvlrZAPJMVrJVWZGoYUDL0e7Yp4BOwNHgWjrifvryMvanEox
         Z8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0hGHMCH2R3B0AwcuaOo2SxazU7rXNBcxbBe+H7BJewBe3SblswxOs0fcquAXo9vz+zI2Xc0fPKhXaU8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgfLsuL2HNVM41OT4kPzKXlNL7mpHHe9ENDmV66wBjEDG8Xkx
	siz/4uT3Xcz/BK1AcNoZik6+xgfpElV0XTVpREDH7nBKaPnfsjPaRvwB
X-Gm-Gg: ASbGncttsdMgncneiKAZ8YxvfGSTIskKtExVft8CbPat2MFsjCdPCO0dpysAB6dNCNH
	oKNkb9hZskVUaWkaUmVkQrHzTptjCLdD1Ecqy9nNJs4FgCqzMGubfr12y4SOFJeJd7Goskeiwts
	3au4ZWu7Edl+B/ulrkFKJH+vjrtUoa+Cm1zf1SH6SGczVs72pWlex/CQjXq1LzqXUp/y+92Nhaj
	5/3a+wBiJIIZSUES96/H9XGni++4qqXMpQWI29ajd96xhqbJyt4rGpOCHcJtBe20e1zqoWYcq2Z
	s9GtQKBUny9EDtJRloNBmAfYeVn/CEMi+94y0Jc6LUcpipp6K4B8h3xVMs0kvNb3zCkv9mfx7v9
	1hwgH946cEQN0/Y/A/AHA8165QtMlF11xQhZ72AAc8A==
X-Google-Smtp-Source: AGHT+IFTCecBSyk7qSB9OZ+w6EvZXPsCkL9LEyhwk6+17yz+FRVjdFe1qhayQGm2rot65cvy44Mtdw==
X-Received: by 2002:a05:600c:1d2a:b0:45b:9c93:d21d with SMTP id 5b1f17b1804b1-45f24ef20d0mr59569695e9.8.1757798488110;
        Sat, 13 Sep 2025 14:21:28 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:27 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:04 +0200
Subject: [PATCH RESEND 2/9] arm64: dts: marvell: samsung,coreprimevelte:
 Correct CD GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-2-8120cdc969b8@dujemihanovic.xyz>
References: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=duje@dujemihanovic.xyz;
 s=20240706; h=from:subject:message-id;
 bh=ifag7Tho57hQxJ2BLXtabDmC2XZUT9SI6SYVIH9Ngjw=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/if57uvdUP+coQwr8aSaQf3TW2t0pdcnz1Teg6f5
 U7RUJaCjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZgI50RGht1mTixiPcEtPdxz
 nKcv3TGJyXtx6Fap1KUqM3OnFtz7WsvIcFp6lf4K71kz8hsbHrHa6Ypksfppuq2YcNHL8vzLJf/
 MWAA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Right now, the CD GPIO is defined as active high with a cd-inverted
property. Just define the GPIO as active low instead.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index b9628b1f59f2f749804799e3d9faa48e3036e81a..aa161982ca43844287d212e8a24884d2b8440fed 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -330,8 +330,7 @@ &sdh2 {
 &sdh0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdh0_pins_0 &sdh0_pins_1 &sdh0_pins_2>;
-	cd-gpios = <&gpio 11 0>;
-	cd-inverted;
+	cd-gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	wp-inverted;
 };

-- 
2.51.0


