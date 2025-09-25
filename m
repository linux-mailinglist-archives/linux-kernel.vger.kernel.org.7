Return-Path: <linux-kernel+bounces-832759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0317BA03A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181497BB9CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED0130C349;
	Thu, 25 Sep 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCxFmuy9"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28F308F16
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813458; cv=none; b=R5ZTyq8NFk7DC6KuvPR8HfSAuGWi3lg1RWlYVQhGoKFWPiRkiBdk364lXxuDDUlKaVTv+aLKs/HG722T+SpOzlMx1n6hTrHgIOm1LqDtOOtBdRR3J0h0DiEk/05j0drqulbF0HBhJmkeTLHgva3NLzmuqXDhipuwDuauwk8CT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813458; c=relaxed/simple;
	bh=J7izVaKPM1ps20wr6OTScdC6fJEWehyUv1o5AkzlcjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COadTLmFriulkU1e8DUnW/k5AFC22qMLdyNUXC20EiSUCdbwfDrmB/bg4X/DD4lydSDl4Hp/CfwjbXJ0eGFwnjXa54ZwysT0uO325n4PHCRGSgsDaIqToaDIq1vvRTc+DDrgZkUUbTyWyXn3BKGmGP8F2dqW99qBSpz3Z6L/QpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCxFmuy9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57bc9775989so908625e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758813453; x=1759418253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3BqohOGg+vh6fUFPn6hdSt72tlOBF+v0LkjnbZ1rhI=;
        b=VCxFmuy9fKwOJRFSU/JASyXJ5UL/UCL1eM9+kOGLj9QUfN8scfO5knlbzdYFz3CiUF
         1KoRm1jBf9tZg2Gtv5zUhXvQ5s8KsYMy+ytFDerborOhX4jYf/wnDTiTtIG5yaf3D3W2
         SJkXhZo9qDI8yclQSflwogoaDWUwy5bXoBBqqky5E89tyURbSQByyHncC0c/W8DXSxCi
         FTQ+ICv/c00GevI17Ph2hMIrQTf6gAuEra183m86l9xSyABOfle6MMbZDdzIp+3NCkk9
         Pk9v02NEu+Xcm3ITNeKXqkr1ZEpW0G6d1icD8suAo8YzHGdj7qcgEqU0eFrVegv9Z8XM
         rVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813453; x=1759418253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3BqohOGg+vh6fUFPn6hdSt72tlOBF+v0LkjnbZ1rhI=;
        b=S+SAtQqRrKRtdnVfaQ58pPRWFuwKlsb+1ESVs1+u2Ut++pezHNAyReWw0KRzdM7l5B
         jdEB67es8+X+ohqD0Or7sVDbK/G4Kdz3foQuFnl+Iqr+2u9s39YnBjYanZUku0DJZbWR
         gyQKiO3auFP/LRwk1YI1xf0MnH2+JBJX8T1eD2aU6kIzbDQp9RRDWM3FQfP3wpspvIjo
         WsUyXiywlBUzb4nDLKUdovdbBtZHBYiZ8JWhOFt2lutvdE1QhGZZuCzTDNUHLDToFgkS
         UN3bIDhM4HxGbBBLxaZtvU+ThYnQNJxJvzpX1AJm2Cqwo1YD+XN3s1rirSsbjyg5ffVl
         p+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHXWt6SX7ajTRYk4skQZEg3GB9PEPb2oiCKC9RjHgvTysydnogXefmChNzivA4zd2LMS5IrMAt7KOQ5j8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwhe64/XG4pw3AXJmVCtVceNOQbUG1eYt23gvqWBKxB2mD5pIY
	mGNkBhs4GTijFKTeldjVp+gT9ZEDq62QPT8wQ7WddewvOYS3UbLM+hGw
X-Gm-Gg: ASbGncuCITF0S5FVEtB6lWQ9y5puOJIgkcG0tTueEXJ58KyV6XCWu/M3M7LlywErZHB
	ryoz3lhFndQUUni1jZELDay37KiNs61SB4DLw1vnEPafMGHEr4erbOgMnRJ1WKqfflctbMv6SYr
	NYYhY16S87hOfPf+LvTb75FU1/Z+ArMarblv60Jp2EwQ40/54/h2/BWvoE5PJUTbaQjgDn61wX9
	vXQU7ecLVaPlct6dmxlZ0ura/gTMa8WHpSG3h+ObF4aFm7RSJGF2zypQXA8w+9b43/P2nw/fTtP
	FCqUUkIdlSfP8xZU8N+3WB+eViKEVHrcaDE+TgYM21LkLt0jlAIR9WJ+V3cpX4b69Yk7/QKiJpS
	ElJqyw56YFKksxg==
X-Google-Smtp-Source: AGHT+IGK++i2dbsoBub16rSwg8Y61Fa1WoKo+NmQGOT7b2HQy8IsigN1Ldy/HuzqUEX4JSs3hgUwJw==
X-Received: by 2002:a05:6512:6188:b0:55f:49ab:884a with SMTP id 2adb3069b0e04-582d12fde4dmr1009677e87.21.1758813452520;
        Thu, 25 Sep 2025 08:17:32 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430496sm870084e87.27.2025.09.25.08.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:17:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
Subject: [PATCH v3 12/22] arm64: tegra: move avdd-dsi-csi-supply into CSI node
Date: Thu, 25 Sep 2025 18:16:38 +0300
Message-ID: <20250925151648.79510-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925151648.79510-1-clamor95@gmail.com>
References: <20250925151648.79510-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

avdd-dsi-csi-supply belongs in CSI node, not VI.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
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


