Return-Path: <linux-kernel+bounces-784108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFEB336CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B245417881A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A4E287269;
	Mon, 25 Aug 2025 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpvlYGrO"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0FD285078;
	Mon, 25 Aug 2025 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104778; cv=none; b=rz/cCInbdlhqhLAo9bDdQMaQd0/GnN7CkGA84JV1MksXUncCVlgCAFP2f3376k71mQjUF4BpUVOQGQsQqzQGNDUiqzP58b/qdbYjZsGUu0Jk/yTJfSE4nWOlRhTRRPacJKQ5famnTg+tQYgyt7l7KZPs2teyIOq/P273Cyz+fto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104778; c=relaxed/simple;
	bh=5MLPHhs7X7tEQnLuBDMQXNq13qWw5ftTlDRa+cdAVqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tqj07dZKTg9cL+OKRt8Gv3qcY0LGvyRrVm6mUPvD2eAgBlJwtne0iNBaZDV1wYOg5Yh9vqgd7PIoJSt8+WPK7wSsVavdUlIAaaufvuTtHTVtkiH56nV1em3ccnp5tI5/HbpcX9YjScjfwPlgh3ImK6dGHBslvHaEF/QnayZGa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpvlYGrO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3258cdb71a4so608677a91.2;
        Sun, 24 Aug 2025 23:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104776; x=1756709576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6diibYp2tXwnL5maACfhft2HyoHkn3Q3aXxB54ydFk=;
        b=LpvlYGrOqnGXSyJxgIIHK12Om2zfp+ujUFnQq9lAk5h9E+6NTXEbM/25lMRN66YbV7
         bXnZiH7TfhpSKkCLkg8RstjN7pScxSOkOzuiOiN/aVLcT2oFA+PInm0tGtKuFtrNtoEV
         uR6I53hIqX1s+ZgBYA/sBa60r/i649b1j2+VmjhNLtOVWWxCjZEuw8fQUyda8VX7bkEv
         Pe57h0qJnPHJ+wf4z1SXrF7F9W7ELSfH81kaYu3dkB5y95RkEeDHnV5DMp5ZkIzw4p8M
         jHtjen0IzEMKp8P3fR33aWoAgoxDglGqt+13XG6y38m1iVKchpgUPPaT24/1xLJfakkE
         pgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104776; x=1756709576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6diibYp2tXwnL5maACfhft2HyoHkn3Q3aXxB54ydFk=;
        b=WT/10i94ln++ca3QAveUWvSgquF7fHIW8CJ2/xWI/ynE5X997Ij99/hOmeThy9w4Dx
         l3UmWn125QPn0qRkOO5eeq+ObusNjAU41sV0nZOm3ywhE9zixRHQXcHC+3tiqJ79IN3s
         Sej3Jq/Axx9JLI1MyICrIYr3X2xBChGza635fqQx7fOHr9Tl31UJqJAlBGJGeh7hFKeo
         HZ+AQUiRUuMpgo4u6z11ZnSY7ny0vJKkvG4lPBYvbANKPE5Zx3lsWoNAAX5Thiv7a/I6
         2AnQ0Q1wtCRxUvwXJ6NLhG6BHLybOotwvRgu3JP0c+9qPJBVWavEw+iq0qGtplKQFZUo
         v+oA==
X-Forwarded-Encrypted: i=1; AJvYcCUMO1vvaoXU6/hs244IEhSW8F+6BjaYNVI4Z2DPpTjRWR60gOoA1apBy5JA1VYpgO3S5TTkZbB5CjclkKoQ@vger.kernel.org, AJvYcCVy69nhpfOcaXBcyPURdnckMMOVEqVDCJUsRe782LmyO7FbeSfRqv2qE0ln2GEEU+O25eHdT4kcPSRT@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFdjrmlztpIwjlUsiBOh5yDUycFMfK8fcXohGMKLZVbinTHHm
	d3G5S4Sk4ang0qDOYM3OKqngxD9iyM5KUyUPJ7pyfyaKyvCJcpIo53FUoYdrkQ==
X-Gm-Gg: ASbGnctL/gtTcE4+CeyxHyfYtl/7U0xyFfteYhVxJ8kiFCJR4HjRHe4t2E++wcdRQwF
	ViWoju3IFzwkYMYlvDEEsvrM3ilFftiUMW5ny08E9H9SejN5NzDHT0mhmmIsZa6DPUCh9o0kSWo
	2aVyAbo478JYlqYHE36/snTjIYHyWODhUhRUfanX/UCMtAKKLiwjyO8xYzC0ly4E/+KUj6kgisT
	eTyWtqfOxsPwYPKqE/Wt5D0ivYtobTzw15+N6peP9ed5/2CRkkhQQNFv5FHnfNN0i/vAgqVnoRv
	/GT5NtDLWG+gjlbVTwhfj7i8p+qKIWeQk5Hv9h/gVY5dqJtxpCgljlVR9DP2EEM9jCdXiYZ84zr
	fKHIXV/tCrNzaVDrQbWoW
X-Google-Smtp-Source: AGHT+IGdW8+4UA6TxuzS2zcTt+SptsBG8WqDGXv/MJl0gX98YtWpcNTjXhO3HSlIWSEsMxekGESFvQ==
X-Received: by 2002:a17:90b:5343:b0:314:2892:b1e0 with SMTP id 98e67ed59e1d1-32515ee3bcfmr13043918a91.34.1756104776447;
        Sun, 24 Aug 2025 23:52:56 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:52:55 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC support),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 01/11] arm64: dts: amlogic: Add cache information to the Amlogic GXBB and GXL SoC
Date: Mon, 25 Aug 2025 12:21:41 +0530
Message-ID: <20250825065240.22577-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825065240.22577-1-linux.amoon@gmail.com>
References: <20250825065240.22577-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per S905 and S905X datasheet add missing cache information to
the Amlogic GXBB and GXL SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 7d99ca44e660..c1d8e81d95cb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -95,6 +95,12 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -105,6 +111,12 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -115,6 +127,12 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -125,6 +143,12 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -134,6 +158,9 @@ l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x80000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.50.1


