Return-Path: <linux-kernel+bounces-786864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC84FB36CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A747ACEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACC23FC4C;
	Tue, 26 Aug 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bMM60nCJ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C5223301
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220276; cv=none; b=gCQWNn2kY+ohAHPBS6loa/5hZEQwBNxH+tpwnZfdI6xRTKSt579hRBx0GyhW09aTcLwjZr+ldsBQFp7Ii9JqAnbgdCM+A3i5HHOqPMeNiYuCbcDqrzA8oAjAKVDRz45LgAbOYJSOT4inQVppZojyfDUJisYT0WsfpzLhadRT2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220276; c=relaxed/simple;
	bh=AHBUSWC6NQwt5gipootBG6lu9YU2EyCEcBy5+RZx010=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mthLbet5j+LpyCYUguZLg3/6egfRGVLuUaD6L6bbJum5chFw4ABR2yYF11222E0ejOKuks+kbOaxVeT5GNnvERCiM2gRZDT42SrjrWX0W2qjnE+u764QV+H/+O1eJiThzzLPeuX5mf538uOYcYuVbBIoDJ9bFUzhKUJSi/w+/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bMM60nCJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-771eecebb09so2050809b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756220274; x=1756825074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4l4TBk/LGXRpjovIOSrhrLfanQNTxjIirl6+Uo+sE8=;
        b=bMM60nCJIbnj/vEfgjx/W3UrWekLDr1H+f5Ayy71bdIaUb5PqZ2UIWre3HBUSl5PNq
         9moi/JhosHvUlcWHaqjku2UvM9eUHDf4VcJhtjQgS5gucPQFMPjqwAx/Yw7FxVaZxh+T
         GHgj4INzGUn1X1Fl86Y+wM7NMR7wvPaTDr/BzfbYztOILhWsN2yF3DaX08Wz6TRDbYJU
         XiPhoSoXaNNQbasDn9Bu5KFiRQ/5j+xRunyggrrhxhwBxTxyo372IlV0FoW0ojvy5SH+
         Fr+XUNSt/z95jT27a9VZjN4+PysCv73QKu1Mm++3IAVKLdzJa3xwcUuxif5zi6a7CJMp
         LBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220274; x=1756825074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4l4TBk/LGXRpjovIOSrhrLfanQNTxjIirl6+Uo+sE8=;
        b=j47rQDiWJdMV/P3KITgBwvh0xXK5ioMUCu1hc6C4JlUVQ9Dc+fsSGGjLCtFOGpXWrc
         OYX4AHgGVshA9rGFMbPQvs6FCrXq2gSWEoHUEKtcHKAmmaI8FW+f+g1TqWDVCH00EuiJ
         oFaVWUBZIGPxnEa9tj04KIYBVPThfvqA72BXojbtn840n0+5Ivd07H1/CVPA/G3FDWtZ
         9e0PSB0nTIHmPx/m5tdQ2bzk1e+Pw+xXGyezQYH8z6x4AIPH/TPsAAZzJBgoxS86HtZl
         mQhHO2UCc+0HUCrC5Oopj21XAJMqLEFfVAKBxoeLG6LcIdA+tY9We/GH8t2na4PXJwHk
         qOSg==
X-Forwarded-Encrypted: i=1; AJvYcCW1JPCBzeLo86vxYMD4E1cqrcTfJm1lFNNPvG9K3nCmTDGQYqLn2cQ0KFSK4FhCZuNVPGXoQEDlxKBWNqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1aGlXfJ7djRU6FDfkxP6yEaQJOwkjyPTS6NHBAWUomhr7hya
	chYZEyirkFeQRTb2sGx4FTJ3wi77orR4ufL2OJy8vbf/VuIPOfPMj4MbJi8mGAuuUpU=
X-Gm-Gg: ASbGnct8fo8hmiL2Xcizi9osJBdMoW0iSzRba7D3XQj8Lxp8F1qVNViGkvrnXGkTj1Q
	2vmzFYZAl1XWZ0IH1pzw7GrIB0khmfDrGI9Vh/OJd18vl3C0U0f4cGBPZHBve3QBQnNdJtAZ5o5
	JW36EEDLp5Y/ikYSpYOPdlRSJJiDzmq3NOZ/afGI/lduULZ3mKEzfXC11AST35RJ45HXebYMjJ9
	jL6Kw3S4NIBvoXkNXem4fP1vNntgOZpwaR2Yw4ny1mmzXRo952Q6Vst6Hkv1h4lanMLf5VBonWd
	XRa4wSM3gYT7qIrAYWCbbahLoDX7WEvVjKTQ922hMmh2xECjmacOZomaqw8TSKoxkRR/MF0sHIQ
	mnWWkn3e67HC9a/IYvScbOf/PXdZtWdDh6S2rzna/nDrtb7MUY5WxHEb2c/cYi35lsCi/JbVagH
	q3Pu8LJOEbun3fF0hVkQ2cJV1GuGSkZuobZwZzB99Fch0=
X-Google-Smtp-Source: AGHT+IF2b1+8Sme48WZ+/3lAfrfDRXPo0RsBhXH2ou3PBP/Wh3Zgu70REv/4ACU8qivX/oSldk1NJg==
X-Received: by 2002:a05:6a00:1793:b0:771:f852:4529 with SMTP id d2e1a72fcca58-771f8524884mr4800612b3a.13.1756220273882;
        Tue, 26 Aug 2025 07:57:53 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77059928c5asm7209799b3a.1.2025.08.26.07.57.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 07:57:53 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH 1/4] riscv: add ISA extension parsing for Zalasr
Date: Tue, 26 Aug 2025 22:57:37 +0800
Message-Id: <20250826145740.92276-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250826145740.92276-1-luxu.kernel@bytedance.com>
References: <20250826145740.92276-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parsing for Zalasr ISA extension.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a3..ae3852c4f2ca2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,7 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_ZALASR		100
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572e..bf9d3d92bf372 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -472,6 +472,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zaamo, RISCV_ISA_EXT_ZAAMO),
 	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
+	__RISCV_ISA_EXT_DATA(zalasr, RISCV_ISA_EXT_ZALASR),
 	__RISCV_ISA_EXT_DATA(zalrsc, RISCV_ISA_EXT_ZALRSC),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
-- 
2.20.1


