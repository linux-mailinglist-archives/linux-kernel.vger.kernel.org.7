Return-Path: <linux-kernel+bounces-782012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB926B319D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F70188DB68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05D3126BC;
	Fri, 22 Aug 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k81pPbp7"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A133090D0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869643; cv=none; b=VUfeQKagvmWcnC07CEGeajC/x6KEiJoCvZh3o9feut2c0WLv2pqU8EXh1R6XMz1FxStGkbtIjmx+oAiJTIUc620RCfFcz8/k+BAwU38/BebV9O88DAPCsTldt1mAQI9Wk1Hv/p5plRifDLVRH/6dSf7DiS0wCJnybAfklupUAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869643; c=relaxed/simple;
	bh=5atFZObtrKpnJgmo3YJtQJOpQJ+u0UszDqUhQBXM1Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNpI8adNgBs6C3zsyE84X/bwsqdl8ZVtMG8JH2n4O8zWZ/6eCJ6RouTW16F5/zTSp6akihqzsWncFbw2hRYQHlAB78dWPcw1j0Ze3vCcH3hpYMIx7kR4fO2yOZINrDs0V3etOFKObo0NlO3EcFQf95SlSASEbyNwMhhywl3dKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k81pPbp7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afdf4bb0e5cso31587166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869640; x=1756474440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIbUpOBxMgd9xJXdgFTREqyCWOlmw8WyO+WxG/Gv6lw=;
        b=k81pPbp7QpvoeB+bsSkEKaWR0jiLT2rLgMPQ/2Zu1iu7wOTYn31U4esPa5jJ/6PjmD
         OXdHZ9SffcjZbDUL7qr0q4DGzpMayfYCo2o1pfdJ+rInO1YlDakTU9/9nCBZoQ09V56V
         XwKOYcVTVsvSUZHdGUDVKwjJZI5G36ZbtMNzAuYNbhncCxjswVONLClACzdwce6koX3L
         0VlMZ3BFuie9nSwz6kokk3s4bXPFM865q59ER4eNZoGCeDgi32tG8fvzGq9oc0/S3iji
         ApJzBlvn/m2IeM1yTNNyijgKV8DibCKn77rM5dF9qGrABaT2JmQppWwyux5j9WsQCS4C
         rogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869640; x=1756474440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIbUpOBxMgd9xJXdgFTREqyCWOlmw8WyO+WxG/Gv6lw=;
        b=GmfcYbzL7FfjSjpQRpv3mXxNhemTAm0M/H3yFSndgmMfgBWsnhBiS+oMDieQqAZloJ
         tcdWL388fjWnhFNwYa/xKephB7KGZgbe/Cf0UYHSSoJ1PUyyhTFbCVy+x6NxzBloB+TH
         v1l7eDWwKWTfKDYCvPE1lKRPWWL79eQTOTHxkMPZzy2xevzMnCU7PJHNBrhkW1r7pJ8o
         oKGH9fkUPsPOun+6CcFvvS6XU9lyyhLxKb9rWOyZqEAMjktqdpNHZ8UCFwPLRPYrG3MF
         b8I/ylzKo+WPvmyaKapsMrfAuTzw0y9wjh2yXD28Hj5o0mJiZ1ru46rKQDvlxNWgk4Pb
         kviQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/QF/+2w3v0M7Lb/Yc6hX1L38vuXC2FcWaxacPzoqQ5erg2NJeIRu7ZUlTxaLbjOwtuPF/1mF5lFsdskI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0gjOe6f0aFKBu0pJp45TdmuBU5ugwiZCozd5rQZIq0+dYJ4s
	cXfuAAh0MHFPkBMerem/v3j/Sa79AlPhIxkIEFGF6izQ445WBilmLTH+WlA43pTWh/k=
X-Gm-Gg: ASbGncvCSUExUBq8swXzi+UfQ+tqW+CMQZQVt7TbxZepPuL/wc/aEWAOqPzLZee1qe1
	aLag5Hr+8xF1AYTZBgX7g6x9OYEVX7FvU6ql8wNBXfR5IzUo67IeG4CiAs+O/AqLQPLCM260eIo
	MrHerMld3nuXnux/xAKCvas8i8BGf5PdmEWNL2HlHB6QFfxJ3oQROqvnnXQcPNKORizZNSFG8Yo
	99DV0pVJuJMf3+TMpu5+KKTvF98PAGl3FAJ67NABzkvIcZpapmyqaOyBQc9dV/OTVTDjba5lZdv
	LBXE1msTDMQxSsHPQs2+5zjENIuIic526p51aP6Sbim7yca/NVwttK014gf/K1VQqs27SWaiPsr
	RHQCdsbGggVoi4hp/d5Fe0SddD1wxdL/tDA==
X-Google-Smtp-Source: AGHT+IGKR+92fxX5+Z9yJGkvAm6H0/KbqZgdhDgNr2OSqOSrSs9eDLAbKH458nV1ZrGSEn5tz9kKyw==
X-Received: by 2002:a17:907:2da9:b0:af9:649c:d0ae with SMTP id a640c23a62f3a-afe294b454fmr144596166b.8.1755869640065;
        Fri, 22 Aug 2025 06:34:00 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded537f98sm606493066b.104.2025.08.22.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:33:59 -0700 (PDT)
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
Subject: [PATCH 3/4] arm64: tegra: Add default GIC address cells on Tegra194
Date: Fri, 22 Aug 2025 15:33:54 +0200
Message-ID: <20250822133351.312424-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822133351.312424-5-krzysztof.kozlowski@linaro.org>
References: <20250822133351.312424-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=5atFZObtrKpnJgmo3YJtQJOpQJ+u0UszDqUhQBXM1Nc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHHBQIbhlJ3imq5KsmMQfKx9f+EstPrtFGlm4
 p0hsndhH6CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxwQAKCRDBN2bmhouD
 1xkCD/oD1zUaszwiqKPLyuGMr5PM0NCHH6utO08UhTPZelp1VJXkzksRDIqbgJLfo/1RKvb554L
 8pGrjNUGX7RiZYtuBS7/9s6khM4le1cwljfgkmg2nOPDM5HD/yFsH3A9P2Ym90PoSak9gH4pHS1
 EHGnv78GovXiDfbXX85u/8pMPyH1r3kMam09KXUWQdyZLb/Frrp1J8LwXZHT/Am2+pTNHp8MCG5
 z9Z1IuHUIpBaaR0SQszliJYTpeG+R+6Y4McX6xDKrVAPXZekfirOgAWSLnH5zbK5iJHO0xKMejT
 zwTbi3OT2zsQP5embmVo4gI/XB3c4K5ZxThanDur0KIhL/REGr8Ef8R3K1asAgSJJ1Y7tpp8F7T
 gPmIcFSoWxcwD7xIBW+1+XGomTHPsfrBAt4fZISd6NfXXW24KVFP9h0WJRNi3w/QuTnEb4CJw3w
 Bw+d0UeQISRg93HUXRDLDJ2pZaHnRgZ0yYfelt45Yh8+OV8ljYWg7e9VWS/3oCqZFNKV832tBGl
 DmZumdNpl2A8lp/mV9cZhOM1WBUQrFA8Xqzvh5DIFQLbDaHOMHmVO928eCwXnPccUe48CzLgeEe
 ZZ0fI+0acxD/85tL1AXEIQIbDCll5Jzq8kjllcRoX5AOi5oHjKW4i0iIYKPyuwhZbxUYo0TdaoD 3nukuUTlr/mFtXw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  tegra194.dtsi:2391.4-42: Warning (interrupt_map): /bus@0/pcie@14100000:interrupt-map:
    Missing property '#address-cells' in node /bus@0/interrupt-controller@3881000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 1399342f23e1..b782f8db1288 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1331,6 +1331,7 @@ fuse@3820000 {
 
 		gic: interrupt-controller@3881000 {
 			compatible = "arm,gic-400";
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg = <0x0 0x03881000 0x0 0x1000>,
-- 
2.48.1


