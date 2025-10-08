Return-Path: <linux-kernel+bounces-845134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF2BC3A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D6419E30B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923D2F7AC2;
	Wed,  8 Oct 2025 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ectvjZni"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DC2F7AB2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908703; cv=none; b=WN5C6l3AekG0jvXUBAkcYNX3iQXJMA4ljWovCJa4Z5BAHJBMCStc9OEvFFhPuBjuomKwt2up+WwII3JzmGR0ArkJ6NrXrGEUzfTJuuwhOChm6tNTBKhS8QWq0fd+OCvzVijvuvG8YvKfiVNuaXh2WzKR8cHbUfMH9/2s6cRkzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908703; c=relaxed/simple;
	bh=r7b9miz+zGlUHxIqeITYi2Gi+cySbUCD1AnY1/8Oj/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3dRhi4jCFst64JSjM7l57nUpWJHPzqYjiaPfDyE34FjFVgw1oDElwRziJ4zPP9nPNtUO1I/tVmyDAPFU3PE/7BojVkygOYImIMHMSNb6EVTddp+3amiodJqEbaHnddh5bpll7yRJloCo6WZIYhZ14NFElWPYjRc8PV3oEEqEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ectvjZni; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57933d3e498so9758049e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908697; x=1760513497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXtaPkh3GXutadYrt9/amMN99qvUxpYxHtsBwRH0BwI=;
        b=ectvjZniNBnhT5DnLSpNzu2/yyZUGH4x1NJpun4RBY20zR01dI2K7u6ermdYckI/wk
         rYw5LaxAH6MXNgla5ggqueDGY13PVw3Q8j9JblrLiz3eDxmIws1G6f48rgmAjbgZJKBT
         RR21vzwQpmYU+8rewQCRyicae8/IcBdI96JmwOr+uAJnQ9Z37J4nH7jQjyqHPc7VpRo/
         Vo2VGDH4VjVegd4OeifsPcvEwKeg3n0BjdWNAPqAZYoqC3N1mMTgLbVCTvhcbxpxh6bY
         0LhVCZNCwsH/T9qDcdGcLZfqXZeiqG7YFaOIP6ylxTXnQ5DeKJT/nkFuuUuD9d3ELiO8
         +bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908697; x=1760513497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXtaPkh3GXutadYrt9/amMN99qvUxpYxHtsBwRH0BwI=;
        b=gI4qkVu8B3gVvQfUJPoyWtXG2kcs/MbJkpdKGzytxJQj3LxhBBUiKpO4g/+TCP9QeE
         Vz4gzPAwKWtjm6ApAK8uTnvNo3EdbrcQ358XnoJ2gXaTrzYL6NUTUa0+Q0cSQO2CIrUZ
         /zGX/wiJUc++DH5VQMsN0oTI9CCGIhqSks2FCMXP5tDUzmxL+4avRrZHa0mJWZds6r6f
         CMWe3U1Oz7Q54CJ3NW/a5nefU/0I4anzZznd56DhipukTixUexVTNflV02do9Tx5H92X
         YuLW9+KcL8It2SJqnwBu4CVLkiXjaWCiwLmKWt03F6J/Tv7OyCTLVHRqSiiATzXAt0nV
         8cNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtzHzUu37ivWjjkg6bn6Pg77PaLjk/3jDf5orhsG+XrDf2Q7iFywVXmrbwjXMM900Nz//spBB53xXZzHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97+LNKas85dzT/Ay7a47b3ZAsoKI0WNz4lydT/GOULFV0tn+x
	Me59msrXG5QWhXTjhdQDLavyuy7gWQIfey47qVcdu6/lnUodA+LZqOgS
X-Gm-Gg: ASbGnct6R9Hh+kiVNjp2niLgsENIw7308XxEGPIjVV6VP2qKoiSKduxLqvWbvuXVe3P
	eVzltF96epQPyqdPKur2DLhy9306G0M71pZ5tavaxZRSy5kujHxJGPLEUb34KOugGgaOd5YpF5X
	2mrAA8YGqrGYGzjuyNJajXLm5mcNRna1sR8Bwze5lENNAHKr/kRdj1Y3+FYIfxpu0rYu47DMa0I
	gc8fl3M5CWuY9DPpBPL9aWTSRm8+G/MKTji++eqBGj2zzziJfdA+tyPSKww0anf+xKkgmtYiJvX
	qW0H+dnYy8qh4QldewRFSb5nRZukt4wS4hS07z67B0f2Qj+9mgZ9wgGZPxsTChUsyuNyjOzuyrB
	KL7ZjinHrQd8rrD1KczFyBw9WwVhc/0B9FVzaAw==
X-Google-Smtp-Source: AGHT+IEjBzSywNMkFOAbwPQ/jDGY7x/5cVSXXn3BDGuPeQ0omEve1y2ZqSoYQ22QYGSRP1UJUPETlA==
X-Received: by 2002:a05:6512:230c:b0:58b:5f:d97 with SMTP id 2adb3069b0e04-5906d896c1dmr693727e87.2.1759908697218;
        Wed, 08 Oct 2025 00:31:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d22bsm6911016e87.85.2025.10.08.00.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:31:36 -0700 (PDT)
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
	Linus Walleij <linus.walleij@linaro.org>,
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
	linux-gpio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 14/24] arm64: tegra: move avdd-dsi-csi-supply into CSI node
Date: Wed,  8 Oct 2025 10:30:36 +0300
Message-ID: <20251008073046.23231-15-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008073046.23231-1-clamor95@gmail.com>
References: <20251008073046.23231-1-clamor95@gmail.com>
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


