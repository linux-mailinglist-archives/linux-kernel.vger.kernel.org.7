Return-Path: <linux-kernel+bounces-782011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF33B319E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33838177E61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D23126BA;
	Fri, 22 Aug 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTXH9Azp"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41C3093AA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869643; cv=none; b=nCj8W2LdJzpS2JBOfCHtAq1Fl6v3JyFp8mubaUJKPBZw33qzrYo2RUD+RLt1F3OD3iAh60IwRikVfXAgdIIi6k/qpTQZfFLnG1vG45ILxIym3EF2smOb9RAIavRE2wnQ2vk7XyYy9Ww7YKQBh8FT9pxh1rljEC3tN2byZfMmguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869643; c=relaxed/simple;
	bh=gtHwwV3RKSc0NdIoaehkWO49HXFd1zQTXe+JxXko4Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPHcJrPOfyH8cI3a6AtdOLX4EoyqKTaz7TOFrdlaKUv0RG0Jd+j+xX62XHghiSk3yq7f7OSaYeV8FeQJZ3/msIKa2jLCc3pZvvlLOGdtlt7qEcUaNtF2GezTm0Z15g3BOUzHmjSLpHVRG+9CwCqrEowK5p+/VGoHgrIHeQ+XpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gTXH9Azp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c1d397fffso93162a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869639; x=1756474439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7InwlD2Vsu/SAdPgoVwsVcZID6Hbo3ljVtynaU9CsMQ=;
        b=gTXH9Azp0kt6dQJHPWlCTMR0HVkn8hvHjYWLsscnEpCMgJFx1iMzP94/01s0AJe3vW
         rr6vAFrDgGAzib6Jyy8hiSLiEj/U2xKF+fTluryXGE1HnI5ERgWmp2HmLs/46hMxX4di
         VfpP3imU8n40W7ASj66qLxuy2pLMnuATKWAx3jCRahGJhTvwnUxqxpOJocaymfqycNbn
         QYalkoaa52kg3GXvbjOlIzin0CKw/TUS1h4FNiIpYFZJWBypNjE9H44fGJeDPLDzt2x1
         gKS7lH8fPRl2DDjlPsuOt4tDcE0ADAbEigm+TpdJg3uoKZMVH3LE2Ie0JOzY5Up9rXDQ
         EXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869639; x=1756474439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7InwlD2Vsu/SAdPgoVwsVcZID6Hbo3ljVtynaU9CsMQ=;
        b=U4FcqGojtxenNR0iz/unhPpbWcdeKUKcZwanq0epLoEzL5ywDWv8H+jxOArz5msNc6
         cG8oeSsNKQ9E9U0//oLBw0Teua/x/qROotqSfA14yvGSM+xT+AG2rz7NgKXsBhy1QUQN
         YL+GmUbGsGQhHoud5hVGtks81haOSkUD6kxL9NYhOzZvdFOPHMtMPV/ZDEVFrTmgPkJy
         Kh9Vsj9DUthvUwpKyMAfzttRNS0I3LMSrP3yIuzS+3MmiTIdmPmhrrbjT7eb6wCr5bhT
         JiYEdzU0dyUmBBxCp6KYrXtQIjRIx8DbtcUIw7UAMLtj/SG1W0AaydDUZkGVfRIXPgcW
         qm0w==
X-Forwarded-Encrypted: i=1; AJvYcCX92uv4ybwQU8bUvR76/QQaF8J7+254KfRFNDuLQAEzLfrI6wAxRKXSS/2dcbmi6a++ufgJXIaVtDTnMQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEQY9G4HMSMG32Ua56KXh3hT/X4V1M52ThsQcXeQJvUF43Q/G
	3JhOUrBq8LJWOI7e2I6mIRcQhqdakRYinGSH5ViJyEaYAvNaHBvOWdsMwb6ZUmpUwZo=
X-Gm-Gg: ASbGnct0dZZeGTVyUB4AF9PgpgnOX/BSZA8V3LQZg+FNuwOkMg8cflRUiZc3xzs5ccl
	skbFgjrgZfLBApRE3KnRc1u1mI94uzyUZyNak5yOz3W4mdevXXAy3RDoZy23sBmEMeumj8yaIu9
	oRKf8pN1sWzm0+ufOKf+vLCGxO8+7k+Pw5poN8JnU0DuxQkuyKaGQbeZMKmChCmJWCkO4RpQhJ1
	dmhoTR0cZoQt0S27qlBsiIuCQi4MuYggvlZoIlyhYmfB+zP99GHMwrfd6/V7U639NAlyDMEwWLw
	Klph9VzN8Vqy8t49QsK6nxF9B2QrHhvv1YaAf7tpifzpT2qq00J7ins0ktiV/S8l5vmLUeFYAk+
	BsVmjxIo49yyGRxThSCLKjZQX8RGlGawYTQ==
X-Google-Smtp-Source: AGHT+IFnfyj7hyi0/c09cbjBoTYvL6saQhuWyCyJd0OxPggzM8rvrTPHBbrWyfLXtAnNNs+IcOqPpQ==
X-Received: by 2002:a17:907:3fa5:b0:ade:902e:7b4b with SMTP id a640c23a62f3a-afe29446218mr156790866b.7.1755869638582;
        Fri, 22 Aug 2025 06:33:58 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded537f98sm606493066b.104.2025.08.22.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:33:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] arm64: tegra: Add default GIC address cells on Tegra186
Date: Fri, 22 Aug 2025 15:33:53 +0200
Message-ID: <20250822133351.312424-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822133351.312424-5-krzysztof.kozlowski@linaro.org>
References: <20250822133351.312424-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=gtHwwV3RKSc0NdIoaehkWO49HXFd1zQTXe+JxXko4Kc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHHAvQa+zloR+7x5BoZNSjCzszRxYAuAtuQZC
 RR1wxd4X9iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxwAAKCRDBN2bmhouD
 1xCcD/98E6YrGSofW4XO+nzWaMgShPd+Zag2gRZVtq7olJtSfvHwILrXf6GenyxOzXBqKH/4ece
 wlHSULleesg4wtuJi8B2PeM21wVzDCDq+8857UXiugy7o3wtmxBHnIpalU9vwk4DXF58t8Wa6RB
 dsDZY0ZQhhef+AlrtqsqjSqovnzVz0a9L4q/olTgsjGZH7iVxPRDrrTv38ORkcxy+uMvL1rwzFD
 IzWc3828FLdu4KRL+uRBS7QBjR6gmeCfBZ18qBCi473ZhP8pFqFgiG+rkej7BEk6ACdf25cvecw
 u6oP8d7469TyZf3Ny7jvGSvAOW3BlhA48YfYjRqnDSOmJU7r4ct01yiUCsyGC7trYmiwuqgkeVr
 QzQfTs4Y4x1YsmlKR6kDvCxHEuIepfIApaWFtWK65y+O7CGFFs03aR2vSiq44EltXXmVxV/JZMH
 bMc80xfH2O7Hnc9uzE0/JGBAR6g5OcMyUe8ddYwRkltGoTgX6hWCwFzkWbk6vf6KzaeRfQPR4Pi
 USSXs+N2stx4OwgGSlyjzCONgoY793e+QUbmeRuksaVWzECOVyDA3e/n5XmbFh0GJ8h/9ZS9qT3
 vgJasVhf405Z9eixCZG+YrBcaRuYAQe7jBd2O+uAl0NX1pb91PGsFufAo/VNTm6RUa2qLykTQGd B/qW2yFHbRrlxWA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  tegra186.dtsi:1355.3-41: Warning (interrupt_map): /pcie@10003000:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@3881000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 5778c93af3e6..7601f5818f6d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1173,6 +1173,7 @@ fuse@3820000 {
 
 	gic: interrupt-controller@3881000 {
 		compatible = "arm,gic-400";
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x0 0x03881000 0x0 0x1000>,
-- 
2.48.1


