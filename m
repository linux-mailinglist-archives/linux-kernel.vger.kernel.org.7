Return-Path: <linux-kernel+bounces-887299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1C9C37CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99443AC9C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB69B2D8780;
	Wed,  5 Nov 2025 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQEa4ICh"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD02D837E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376143; cv=none; b=c2VllHa1+8u1HWD8PcFOxPvsKpgAJWxmp3ZoLQ03GDcPZ8wW9lZz7c/jDaJIHiY37RyTkDFMQzOO7FErH4rcS17XNHGxIBTjS2cljc9fOqfLTls4bQBEIt+QvhXASsqmSX/TbOEtMKLPO3HGCTzmqDYups/0LtQDahZi9f7I/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376143; c=relaxed/simple;
	bh=EpJQxkCUe84VuUUz72+6wpORvW7Z+OmC8JqigviCnvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crduzjggZYeMF+iSWLLrfWifVOxrkndmDFfFsTSKcXvqRxtkQliSN12z6Gl3OPSs8BjeGlPQvqLxOnLwD8VYU8lJJOYpE8Dx5qe8rldiLvhTY+KRGufmlq0PaI9r4n08wHuRmkxEg2TdcPK2hRQ9eGAt1DXGrEt41kKX8GQlssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQEa4ICh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so268703b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762376142; x=1762980942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhMs1hlDgsVZf1g+dek0j89GxNp2KKlLBpBDsBeutOs=;
        b=kQEa4IChO0i96NFN91cc4uA4msJUVtAEkgC5tC5r3MOp+rZET+iXs5xqbRJBR+NLf+
         0RuQ6dY76F1OQNy0iDBBQsNf6TVOv2lPX74xsCeB2lfxog0IPf1Lehu7Tm4mHdzIKc1m
         ovKhI6pLcUBbhZiDaypoNoT8/oQnIdNmdOwyIQadayoAIAap1qFQh7XsY5DsNFjrhyMn
         NRJoJ83adrOXpqBW52u62MXI5XKroTktrJryO9P99W37OapRNsRxFm8WslAs/3DG5BPv
         hO3xn5lDNLxKjjRWntQ92Lc3JMAOQrZpy623/pNiD5ahXuTjRhBYYpim5vJ4QvzB4Y1+
         Ipng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762376142; x=1762980942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhMs1hlDgsVZf1g+dek0j89GxNp2KKlLBpBDsBeutOs=;
        b=lG89ilCb+1pk1SiI9+1qUaV6wUxrF5/uxi2hGtjRsNtbn7SK68NF7F8xedQkbQz6NR
         UdhuqS+1IXZK7SKRCu6L9n8U2d9xzRClNcdPFJfocThKm1I+0REFM+7UECzhj2/rB1zM
         k2C/bYO/P5oIuPBNkWcr3vIS+kXbuHRFcRDa3M65Le8XyWW4kBl3OA2qEKmcQu917ViV
         XRTBx+3oU+186mBYo9vlGNkwZMbnDUqU2FfJQkJmkmYDOeYFdtOgeVa8Qr91SOKfk0iq
         Iw9Q8Z70hN1aJ9l/ERj4yZxc90QatFT6Cz+zZgzkMvCR6dsorT+Ll5q13HlmWFDm4MP/
         Lyow==
X-Forwarded-Encrypted: i=1; AJvYcCW66NZbEkJYLBFcSvQPi4z1dEWcH8v0E4Yc1qwF0r4wy+wxSXXy7lrzc11OjsodJHCZDdfmg5PxaWmCEIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1heHVDOmsY+ix2/8fvFHjt2+uhjtZxVokbWaXfS80aqG0OUew
	sOy0Od1LmE6fvADQEn57HDNGYopbRRMZZXUOjJbU3A2kcaNOvY3gnoGP
X-Gm-Gg: ASbGncurL9be+Fdcj5VByOWbxEqkoQIrmYNSx85PPyTOTSvYkmrDoXrM7Znn8r1pSFG
	jjkAxAwKmRjhciShMpQMBLzEFwM54U1aYlIwDSR7criBwtHjYicxzb6QmoAQTSxI6uv0Wk7hqJb
	xckEGCWFQ6HxETbolW+fulynEe2srbQlFVFeRlQ+ySMu6Ev+cUwThADRRW8jx4cy4Q+ek0KU7jM
	uP68BmPWDVEJZ2/VPmHcr/tdG3j56nLdmOWHIAk6woPzayeZiMTIlejc+3xuVRfZZBi1r83X28Z
	iUXjefLY0bpL9X1u3U5ZyqAJm9FumoHal1cvjTVUYHKH4wEfqOVgCjVS607r3jNK+r4kAp32qru
	pBW1AtT70SzrSmGDspQ+tUGBrT1o/s/o22FtEhBSkzZLfD+s=
X-Google-Smtp-Source: AGHT+IHPFm5cGv1tt4RmeePKjzvdzFbQmc/HUxeSszlk9l9aFCxxYkmCsNAadtWmj7V2HR6zSfhavA==
X-Received: by 2002:a05:6a00:140f:b0:7aa:bd80:f4db with SMTP id d2e1a72fcca58-7ae1c767de8mr5566668b3a.5.1762376141566;
        Wed, 05 Nov 2025 12:55:41 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f661b71sm349766b3a.12.2025.11.05.12.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:55:41 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	leoyang.li@nxp.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "powerpc: dts: mpc85xx: remove "simple-bus" compatible from ifc node"
Date: Wed,  5 Nov 2025 12:55:24 -0800
Message-ID: <20251105205524.17362-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 0bf51cc9e9e57a751b4c5dacbfa499ba5cd8bd72.

simple-bus is needed for legacy platforms such as P1010 so that nodes
are populated properly.

Fixes fsl,ifc-nand probing under at least P1010.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi      | 2 +-
 arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/c293si-post.dtsi    | 2 +-
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi   | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index fb3200b006ad..4f044b41a776 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -50,7 +50,7 @@ &qman_pfdr {
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,ifc";
+	compatible = "fsl,ifc", "simple-bus";
 	interrupts = <25 2 0 0>;
 };
 
diff --git a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi b/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
index 5c53cee8755f..2a677fd323eb 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
@@ -35,7 +35,7 @@
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,ifc";
+	compatible = "fsl,ifc", "simple-bus";
 	interrupts = <16 2 0 0 20 2 0 0>;
 };
 
diff --git a/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi b/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
index 4da451e000d9..b8e0edd1ac69 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
@@ -35,7 +35,7 @@
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,ifc";
+	compatible = "fsl,ifc", "simple-bus";
 	/* FIXME: Test whether interrupts are split */
 	interrupts = <16 2 0 0 20 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/c293si-post.dtsi b/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
index 2d443d519274..f208fb8f64b3 100644
--- a/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
@@ -35,7 +35,7 @@
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,ifc";
+	compatible = "fsl,ifc", "simple-bus";
 	interrupts = <19 2 0 0>;
 };
 
diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index 2d2550729dcc..b540e58ff79e 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -35,7 +35,7 @@
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,ifc";
+	compatible = "fsl,ifc", "simple-bus";
 	interrupts = <16 2 0 0 19 2 0 0>;
 };
 
diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index 8ef0c020206b..aa5152ca8120 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -52,7 +52,7 @@ &qman_pfdr {
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,ifc";
+	compatible = "fsl,ifc", "simple-bus";
 	interrupts = <25 2 0 0>;
 };
 
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index c9542b73bd7f..776788623204 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -52,7 +52,7 @@ &qman_pfdr {
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,ifc";
+	compatible = "fsl,ifc", "simple-bus";
 	interrupts = <25 2 0 0>;
 };
 
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 6bb95878d39d..27714dc2f04a 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -50,7 +50,7 @@ &qman_pfdr {
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,ifc";
+	compatible = "fsl,ifc", "simple-bus";
 	interrupts = <25 2 0 0>;
 };
 
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 65f3e17c0d41..fcac73486d48 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -50,7 +50,7 @@ &qman_pfdr {
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,ifc";
+	compatible = "fsl,ifc", "simple-bus";
 	interrupts = <25 2 0 0>;
 };
 
-- 
2.51.2


