Return-Path: <linux-kernel+bounces-815354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A33B5632D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AD91B26B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA012848B7;
	Sat, 13 Sep 2025 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HljCuZPh"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DD285CA3
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798499; cv=none; b=pY0tCgMClu34yUzeUe05q9waQnkCHfajrqOxUiA6roS2Mzm8uJ1/miNBS5BDul1iKDYlS5d1YSqboE3soEkRnnL9Qe0RZ8jyqYt7/qY9TTjmpjQ51lxV5xW5i1xwY3PGFEWFBkiuUzI6nE3dyzu/0KfgPH7LF4xUAVMnkWHejrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798499; c=relaxed/simple;
	bh=0y2/d70U9xnaWfeS0Wb0q41Df1I5MN62Olvm/podXrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8HOzTXbYdM1uoPECh03Sq5R8mfY7enNqV3A5LjryWXfWzm0nvh+Lu1gjBg2HDOYwKz1W0D+UkQa5ItQ1Nxe6LyCiU8Ocy5beSmUGAVv8MYaLpYBV0ec1lFZD1SVyVZi4wqF1Opn2pduFOWaoEukOD4vbTD969WAPFlyHA/R9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HljCuZPh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3dae49b1293so1653564f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798496; x=1758403296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=252dG71R8/wsuDQzak40yRZblq74Z4LJhIzW4rwDhZ8=;
        b=HljCuZPhPNDKExnMUAPo+JyT1CT6bsF6PejrPUvrdk+eNaXnwl8Ct5O46on6NFY4l/
         Wtr9fqHx2pQ3nKmineyE4qY/WFYiFZibp0VIocQu7Z670q/DKdJk21tJRyaIT8dJPY0y
         VMQYb7AcITOy8xb6dfrXLPJRDZDkE/UcJVQZrqmGKBppoXYNcUqbV49kwbGg0UslSqGT
         13syjxSEcrxqI8M7boRRU7Typh8eiTE8DrxQpU1mKoYJchMclRaDMrz6NkE997tF/7J8
         HQp9m062BEiIq7T6Yk3xit/1O9e/UQJs4sCvDrlGh5YlZ0qWfAbbaX4WqvxCxYbn1Tn6
         bLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798496; x=1758403296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=252dG71R8/wsuDQzak40yRZblq74Z4LJhIzW4rwDhZ8=;
        b=hlcoXCtVmLerOAQarLVuEuGYVIePw9dSpi9+Jhw8vQ5hVP1Wo/H1j5GrKnxhcZO6nF
         +owUWSjcWxFvBhteyHLQnOnfMcAjtNSQw7lkBfN/oSKqc0fn4LQov/PwqrUbHIn8mPYc
         QGCEXxn+hz+ZGRqgB20do8FoO9VAc+ufQG8mlO1OS6CqsuNoU9kDbLi7afDCp7s8GKeP
         Eq4rLNVLAU8shvcle4IBNQ0KwBk4JWRVV8L8dA2ruPyR8f3rlTRc2ESO01mNcaW8HwCP
         TPSSO455KTP1/mNvZAvh+Ys9/jAShrKaOsjqg2cY3NZG9EQDeMjqj7MCcwzLXAXhih4f
         naqw==
X-Forwarded-Encrypted: i=1; AJvYcCXkY8kgPO8Tjhq86Hctyv5TUdCCCCrYdW9ryQJURIDVcalcaBwe/e3wq5OTtY6D73L4xsSeFJt4g3OgDxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/ekSgM+VU13XKs9d9C6tNwC6DKWlOURbn0AxUPBPAvIhZ0eQ
	AM3wIkeVPHpK0VEwba4YT6u5bO56NtIIOJ1L/YbX4d+wvxA0EzqNbgUn
X-Gm-Gg: ASbGncuLGUTNJQNE5G7ZDOTWscSYZKdNsDL8MIzygrCjDXe2fipDZAsKQidmIFWu7jO
	I4ptO7LHl/uuvxqHzEH6/09hTY7LqFdMrwghatR3O68pbz1bapoZhDPBA10qU8McQasUof7NgPg
	Qm07Ulo331eWCxjiBXvXHsKwVwvWx7kDpjFU9buB4aPeFjzCFm9kkeMchv6TpKTJIMkKyv5B5/E
	uDnzq64wRgI9z7e+s+aaLiTZo69gYR/31k+7gHRH8S6Qqhm04rLVe88Kocf/JJT4fULZEUny3vU
	ySVNiLlplJYM8R+OPe8lEMSbLN0VE6r3rQR7AepQHL8YG38RUjcXt3kXOjdXNUiXjrozNqIwfAk
	ulol781T7dkw4EKLY5Cn8rWyFnJpX/H5NKKmBN8hwWQ==
X-Google-Smtp-Source: AGHT+IHOzhOcRmPGX9ESktIGDwB7TcfB0Cd8b/2rDPSkgB1eTEkWJ4gz/AUMS7YuUta78c/x3bq5/g==
X-Received: by 2002:a05:6000:2885:b0:3d7:b12b:1312 with SMTP id ffacd0b85a97d-3e7657b0092mr4921139f8f.9.1757798495900;
        Sat, 13 Sep 2025 14:21:35 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:35 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:08 +0200
Subject: [PATCH RESEND 6/9] arm64: dts: marvell: pxa1908: Move ramoops to
 SoC dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-6-8120cdc969b8@dujemihanovic.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=x0fqWkqgQtK1SSNlROzTYDeTJ7VSRsicm6OwB8pn5ns=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/hP31qVdWIe4+l05XL9nPhHs4y+LTr8vmJd3znD5
 TvMT4gkd5SyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBE7LIZ/tkf897MIve97fb6
 6WWy7sv3iqW7X3gkNqnscovakQnfJqUyMhyfM997m9rR5dKyzHLXg+R0Pie83LL0h/SBernAWWm
 vGtkB
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

The ramoops memory region is the same for all boards based on the SoC.
Move its node to the appropriate dtsi.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .../dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts     | 12 ------------
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi               | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index c28c2eadc42cc538fc5491ecdfcfbe0191004794..dc58b19ef5d11c69f52ea7804323fe2fb2257ca7 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -37,10 +37,6 @@ memory@0 {
 	};
 
 	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
 		framebuffer@17000000 {
 			reg = <0 0x17000000 0 0x1800000>;
 			no-map;
@@ -62,14 +58,6 @@ cm3@a000000 {
 		seclog@8000000 {
 			reg = <0 0x8000000 0 0x100000>;
 		};
-
-		ramoops@8100000 {
-			compatible = "ramoops";
-			reg = <0 0x8100000 0 0x40000>;
-			record-size = <0x8000>;
-			console-size = <0x20000>;
-			max-reason = <5>;
-		};
 	};
 
 	i2c-muic {
diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
index 61498fd75d1dcaf0d068943c1ac14d3e5a7ca9ae..deb1a9df27c2f7c946096c05a684c3f1f0f16d6c 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
@@ -58,6 +58,20 @@ psci {
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops@8100000 {
+			compatible = "ramoops";
+			reg = <0 0x8100000 0 0x40000>;
+			record-size = <0x8000>;
+			console-size = <0x20000>;
+			max-reason = <5>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,

-- 
2.51.0


