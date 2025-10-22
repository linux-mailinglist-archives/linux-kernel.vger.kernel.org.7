Return-Path: <linux-kernel+bounces-865210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20CBFC7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2CA44F9B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DB9350D51;
	Wed, 22 Oct 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2hL1pfD"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902D34EF12
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142915; cv=none; b=ThAfVrDkvYey3w656vfy5l+RLNjFhFM+OZYBt+2V87NMvyk8NhZd5L7NFVi9MydInzvH5NDUMZngnZ7lyFGquSpxKi37jMOiBi9raiES4k/KDxCiMPkubLeF2GCaupwAf/60fcUccIp6rgpvaWLHJ4UvC01RrMcxp58VOZ1R63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142915; c=relaxed/simple;
	bh=r7b9miz+zGlUHxIqeITYi2Gi+cySbUCD1AnY1/8Oj/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbxfRkTNfKKdAUOxKzniP+ZGRan8m9UaF2KAp40ODLAUlptd9Bf6mhpjne2VPOIoFm06bMMKN4K/Xuy0UeHAkFw8ZAhMfx/85JXYAsJI7OJXVRyOtgEpz0JUS1uieBrGSNE/YYDTHMR1+kas5XtwatTzfVDpTIoDT3CBdwO9lvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2hL1pfD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so4495153f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142907; x=1761747707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXtaPkh3GXutadYrt9/amMN99qvUxpYxHtsBwRH0BwI=;
        b=c2hL1pfDXaQ7BMjEDgI+CWfh1L/rZ+C1/hq8BbB/F5WSf1qIKQoA77SV7hC+sVTuQl
         IJSZCBqQbU8EmkcXQPdAcZFloz0X2sSKAxrkpiDdY360s/7SfKGywmNkZhVI/zYii9SQ
         BV/DfoaXlrOtZS1R9LadVGp8hjA1eDj+BZqzmoixM/zFS3Ir9fow8gvQmZKvB77s9Cja
         82D5L9fwEo7c7Law/gDpzKzx+EgUtNbjlqHR896YMWjsvYWx/o5nvUNGDP0GSgl8+ZE8
         31xNtKXkJX2O4X3epyG63+VG+UHAmkKSRNhS9ttio+e3d1c70PRYCzDJk0GnHWlTVFun
         +eCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142907; x=1761747707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXtaPkh3GXutadYrt9/amMN99qvUxpYxHtsBwRH0BwI=;
        b=iERTsUxXu50Ct9UDDq0DXFO+twguDSyjG8F8hyAApGFgAfrIUbOEHDHYh9eq0BiD/2
         PVQN3fkvvc1gb7UjETFv4bp6szJ9cJQhKC5br4MKg7u2JkTajOzM+94vD7HrnyXc/ZPY
         3rgHkt5EP9y7DyRGUwBZqQV8d3Jd2WbgXhhF2sUlh1/lJvSdeJuZIx8Ex2ZSnOS/6Ufa
         tQ+Ldf7/NfqUKbFJCeL4vrxEAMcD3znKSdb6SKTOVOHOdHH2WgKHziHO0lBtEvl9p0pC
         /V+8uc5tZMRAOsX6E4gFL6M4+aAr2kXtvvxKQLMzUmhOWKQDIU0Yzy+Sn++iygDgzFqr
         MUbg==
X-Forwarded-Encrypted: i=1; AJvYcCWzy1s5VDoH7spWVcJJTtA6wtyOlvcOCX8H56v879sA3SqSyf8tlmTYZPgDj2gDdFt8xqU3aANVnoEITQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRlD6Cl0rccxtyqFQaYEKQZOaAA/uGhPJl5Vyc2ZrtIHClGSp
	iRR4l9lgNXPcHdb62GDKcIjgSK6xjXMNqhwuTYmSoaokXdIW7KWnOMtt
X-Gm-Gg: ASbGncsAQ5uEyGiCvc7QkmQoX36z/6rwqa5KeZ3SlpQFbNQhauMpfK/Em3KWwXrlMrq
	g5WKegubHuiezY/MyiVbokCq/YH40L5h0SrsT3KxE0h7wuCFdjM/Bq1m5PTh9/YRG1i1iEEwfHo
	NiyX+jG7RQZ9onwWY8y9niTAwiIMzCdlQ1Zd/aRDme+UqO+D5KPeUeE1B4z2XVZGxSNrjr0aXXI
	q7idksHwUy0WYOHk76JB1Iust8cG6FBYB//iwq+l4JbcBghLdEoXaXgpmg8sbGYdI71SXIzBSyy
	YwtP9fKI8DvMO0+P7wdh6BWg3jtiGUaPwYouRRgrO8XBPXLq00+uIpa1KfCcokaxqFuyOqYdsaM
	gkmMd0ZCxLXPDJ2ZNtjZH6DddzpDf7Lgd92VUjFhDtcbBGVCc3JejdjFoy3BIC1wnVcA=
X-Google-Smtp-Source: AGHT+IFuKTY+6VlzlctM2Ho4Y6ooXPbr1OkVqVQk/ddAnkBtDFDjaUEYC7CuSZMpeeIzVLphs/KiOA==
X-Received: by 2002:a05:6000:1a8a:b0:428:3f7c:bcf8 with SMTP id ffacd0b85a97d-4283f7cbeefmr11118870f8f.29.1761142906649;
        Wed, 22 Oct 2025 07:21:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm24803518f8f.19.2025.10.22.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:21:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v5 13/23] arm64: tegra: move avdd-dsi-csi-supply into CSI node
Date: Wed, 22 Oct 2025 17:20:41 +0300
Message-ID: <20251022142051.70400-14-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022142051.70400-1-clamor95@gmail.com>
References: <20251022142051.70400-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

avdd-dsi-csi-supply belongs in CSI node, not VI.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     | 4 ++--
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 584461f3a619..4a64fe510f03 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -20,10 +20,10 @@ dpaux@54040000 {
 		vi@54080000 {
 			status = "okay";
 
-			avdd-dsi-csi-supply = <&vdd_dsi_csi>;
-
 			csi@838 {
 				status = "okay";
+
+				avdd-dsi-csi-supply = <&vdd_dsi_csi>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index ec0e84cb83ef..f1d2606d9808 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -64,10 +64,10 @@ dpaux@54040000 {
 		vi@54080000 {
 			status = "okay";
 
-			avdd-dsi-csi-supply = <&vdd_sys_1v2>;
-
 			csi@838 {
 				status = "okay";
+
+				avdd-dsi-csi-supply = <&vdd_sys_1v2>;
 			};
 		};
 
-- 
2.48.1


