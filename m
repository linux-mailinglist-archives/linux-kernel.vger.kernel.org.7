Return-Path: <linux-kernel+bounces-784124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5EB33702
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B4D17904E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D4D287252;
	Mon, 25 Aug 2025 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzzJkiaa"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EAC2797A1;
	Mon, 25 Aug 2025 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105015; cv=none; b=kjA1ZbVzjD5Gt/HigSuMIvm29AZxaon3BU1YTBIu055e1RAMDk/BiH71QKQ0J64TwvwhmmsnQIsTNblVXOP2h7+5ilSh7R9NZokv/StZBRbnSq1iDFrmTW+ls6ecdd9QHj8ffXDJGNppjaMfZX3EEZHvLlS4JF3S2q484O3/hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105015; c=relaxed/simple;
	bh=BhPG4H+I7zDs8dwab76+BoAR+ozvEKZSdpitJSyJUkw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dk3pHzGlDCrVnpwBl8A25jVcgtiugA5RzCeWspHT6DaqkkQJFAdQFEAiLhGP4qgRRgY/MGkzwzOJcJ1+iRpZzTpX7bK4o/e5op7/NQcOUAIWr76iimvAUoGQu+4Vp9T3a2NyT2sZrh2BA6nfPEr4Pk+40sH4RntsJoBGPd+bAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzzJkiaa; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce5da315so1138684fac.0;
        Sun, 24 Aug 2025 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756105013; x=1756709813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/Iq+sl3J+lnpf+wc6OQRiTYktTo8qUO7r+bK6zwUBU=;
        b=NzzJkiaa0a4rmQ5KSHFErHRwY19WA5FrRK1SWM/8jp4mptVz3LrGMkpSXmbmnIO9B3
         6ObmSu/gf5ayqVM3ejdN4LkRWNxjnl16gjhmIAfgmte/IkFW8WI6CdotbOks/kVuoU26
         7rXkzaV4rpdTjx/7BFMAYKhH1gVO4aXhtFH3AUG3QmykH4L+D+vzRD3Wt3HqAzX+3qm5
         VKp6imDJ0Pnd2RS3Yaya39L+1Ye5ftGUUpeF18m0r4DxgpOi8SKTfk1IY88zQi6MLspH
         50wck3vvZ8O6vVAwdhc3Ds63K1GX5Irjb4+LoIKx8wpqWwYd+4RIC6Afm/HjF/M2TrWS
         zNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756105013; x=1756709813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/Iq+sl3J+lnpf+wc6OQRiTYktTo8qUO7r+bK6zwUBU=;
        b=MDP0tsQ/eWkRe/J0y/rYtxfPaq+tfAsvz9+QJrLoUK9ulqfWQG+daYWqqRI1J1K4yg
         9mK5ETBoq3i5vCNHayqNMmAB6oR2RgcooWVNQnGhmgUzIQ5vGKcaFVkp962iGQ87Lfnt
         1992EZXTHBN5tz0q58MyUu9N8vGmzUSFFHUix3FIC/U1B3lhK2jsSSuDh4QcFoP9KfZP
         Y4Dsb/Qa7zEmckTZXXyPYrvlGnUetFAwQyxPBOHbEWhoPgp7uXC3mDFWvcGIHKRQRPAs
         8WMICXTMRvugXHBYncgWcoJX9+L2AcW1Z0/G/47Ncoqng0BPpjsiUqYYM3gnW1xOPd3d
         78ug==
X-Forwarded-Encrypted: i=1; AJvYcCUN0SvjKEGy7h005qeWkToZXyBAwQUudjVsJqOcOACisEj7FCpAf60OQ40x2W8AObQuDgfEfiR1u1DV@vger.kernel.org, AJvYcCUqEob+bcm6hOWOyJItj6T2v7U2WErTI/pBDj+duzIB1AZpESi/9v+b0Y9tgCoEizdpXJcEUPF9I5JX4kZb@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJQ/PF17or3xLCnJpKxVRK9x8kAPHR6M0mamlLthKqughy4ge
	YQBuYriX7YhEkMMESmXwb3UFTnx1EyNjttteszaSnN7RKCLxlgzfIf8r
X-Gm-Gg: ASbGncvoAstKSg62O3cs2TOkVMv9WeHq/LpBegqa/urIVrNDnKOSqR575XQiXtcuUJi
	rc1+alSEEjZ4zze5uRx9Y2kD3SKq4ZBGgyLzI3eS3a5IT+kLWmAR5SwExv37c2aRzv2rOc7HAHo
	5d35h05Q0povaK7xrvJJ01oSYDB4Pe7EkB+eOWtGunfz9fxkwMDxPuDkjEAN5Ry6hR2o9/dGV5f
	CEHZmIBPd3cU/HzA9e3+AyNvqGfSeSZ6rCqT0SwttKBUaVoPc8u/doCqkpYjvXO0fvl3CqXzHRw
	/cN0EpHi/yJadMVXT3QPXFLU+Ec4xvB/ONV2TOO+rhV0pr/pDj523+Gdzdskw4CRr+Zwz6erlRM
	/Btv/prnlT6pcttb8+mVK5omGXNwdY3mg
X-Google-Smtp-Source: AGHT+IE4S8hpOAZcHJoPilZ7mmplf7IZel6cvlTzB91P6LUa8rKsYKvo/Uiar7NnssN2qnxAYRP3Qw==
X-Received: by 2002:a05:6870:1698:b0:314:b6a6:68aa with SMTP id 586e51a60fabf-314dce1b218mr4807487fac.50.1756105013383;
        Sun, 24 Aug 2025 23:56:53 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7a21bdfsm1630481fac.8.2025.08.24.23.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:56:53 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	looong.bin@gmail.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH 4/4] riscv: sophgo: dts: sg2044: change msi irq type to IRQ_TYPE_EDGE_RISING
Date: Mon, 25 Aug 2025 14:56:44 +0800
Message-Id: <a0ddd70d0658a26a24a9ae48d7ea9e59dfd7cb6f.1756103516.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756103516.git.unicorn_wang@outlook.com>
References: <cover.1756103516.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The latest MSI driver will read the DTS configuration to set the IRQ type,
so correct the IRQ type in the DTS to the correct value.

This field in the DTS was not used before.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index 6ec955744b0c..320c4d1d08e6 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -214,7 +214,7 @@ msi: msi-controller@6d50000000 {
 			reg-names = "clr", "doorbell";
 			#msi-cells = <0>;
 			msi-controller;
-			msi-ranges = <&intc 352 IRQ_TYPE_LEVEL_HIGH 512>;
+			msi-ranges = <&intc 352 IRQ_TYPE_EDGE_RISING 512>;
 			status = "disabled";
 		};
 
-- 
2.34.1


