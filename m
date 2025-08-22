Return-Path: <linux-kernel+bounces-782005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43414B319ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15589B20FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126AD307AD6;
	Fri, 22 Aug 2025 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHcZbjRD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B6304BB5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869609; cv=none; b=FiEqM0b6mi6E+H6NE8fiHbz42bh3drM59euE4Qytk5yypy1it1ZRJpI9kzPuoq+/IWaDefzjqa4QG29eRi2X4drsDmOQI+XxulvqP72OezkLnDZg34Gi7yNGYM76QH58QwLrVIGc/DNFv5bMe0ksLuGpfSxWU3tSDYzoGZhpeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869609; c=relaxed/simple;
	bh=/M26qPH1NPziTh0Tbmf9sXdkHY+iN5CemaBMwSON+uA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqXctkwE8ulNQAvzehU/xuxiLa50CuTPcI5HF85cGcOn1Zb3akWW8aLmkCU98moHb1ffulC7oPZF+sSPobB/fkT+ePPUWS8gbZCDQGfEFNe4XeqxPFgtHR3yVfpePM/Y8Q65uOaUyeYMqkv1/+vTM2PVyQ5GUewR/LiX/iMR6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QHcZbjRD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78d5e13so27262066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869605; x=1756474405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=plBpRxzOXh1Cs6ihly2kzk0+EpaX0QDgSfgHTsuw0DU=;
        b=QHcZbjRDvSen74Mbw4GFvOSGi5d5YWfvD09q5Abuo6IwvcDLTDe9niWmetXEZc8TOR
         QBqzu6CsBVLV6/F5SNdGD61ZJ+uyAJMo22OjYS0nPJOVGUw1CyUfu70HVQM0z4WJ2T3W
         RGUGXW9kkPd9FFsGKGroFVYjh8bMD4YcZARyw7X7ftDWKIIYKhN+7ic/5H4xQ3rlS7gg
         E2NBqB17xRa21JJaGDhvgj1Dex/U/UZSQR8Wl4JJpEz5jcjhCUzpTItxJQ7SKMZ2jFjB
         XaS30B2xrVmWmsJzWkU8t/d7zFFiVr6aUJ3avjOfZO4vsfYW9hlqrvSiG2qhzEMDsPxs
         YnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869605; x=1756474405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plBpRxzOXh1Cs6ihly2kzk0+EpaX0QDgSfgHTsuw0DU=;
        b=vjB/NE8AXQVUjjI1B3SOis04F8XCurIJ9KShk/eWYcoBQq09MjTwR+Bu4rdCk2RiJK
         +y7HRsW4Btpu3No9TYcnUcZBpI9wkuUDYPfwqDAyyFrDV9i9GazIn65D3zrucgJdNgtf
         G/pSTZFNVnfDYV6FfqSozie75w0yy3BZNP5IYgdE17/Pnr7plMFcjPg9ANqm0j89D9DE
         bRaLP0OisyyGbxU4GwZL00Bru5tE9zO+AY0KWfnAZynzx8U/GCyGHXnFNbF7kUUe1vix
         r+S9dFJp03Y3EzOgqm0SKjxLdXHR0CXIF0s6lCLgroHGCHSyGK4s1N4JbGRwDb37o0bt
         A18A==
X-Forwarded-Encrypted: i=1; AJvYcCUAV2HvA9oqW/WQQBARXxpsHintyqL/o0M9YXdHOiN0bpmePydc01G5bpxj/dYpk6fmdTpQTwQwNcVwwVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUzvMomvprfS1TQWnzlL8RPZkFCMLn0F6AKZGEv0G2hW+aRDi
	HBCbg935b1FU9LFqM4SmEOY+TK0siR0MgFubXaElYMtPGnFlOU2Yzshx1TR+1bnsqG0=
X-Gm-Gg: ASbGncuPn1hph8n647DlAOvUANbxyTKpqyFdHoM8YzH4kW6Ji1FtsClSX46mrLLi+Ms
	QuQ6gpyxZ2Qk8aWmymx4X4JntBPc/8WfCZq0mgso0bb/7WW5P/9CRtSn2uRVuIg9z0CMSgN1ZD8
	2o7vAC2WjvXy5fx7az18yCm2mNW4tPv/wzfP2qQ1+H9SqK0lqmHijty8kftuIs5C6/GPA8qV7o+
	rgMNI0LYVj8L4q6FkECkT3w4Bg2RKbpzW8vMDAWZ3mByKMhk6Hn8hKR4bEmqgla/KUI/aOeMhXs
	Q4x/cBv2UisAL1m9mqN5l3pSrMEF/ZIm0a835/I0QKlVhLDDjHh0MCE2vYZiY0EPUT4X3P5UuHK
	X8wDlvyYWDCtbdUgWKHq0Xd0qr42kf/Bqsw==
X-Google-Smtp-Source: AGHT+IHG72D11u5IdJuYzQxDRkzR4OlLZS8XqeeHSUIp4lu16BBZfsKFUUmkkTFaUI4Lrd1NwdPo8Q==
X-Received: by 2002:a17:907:9405:b0:af9:5a1c:fee5 with SMTP id a640c23a62f3a-afe2874f3eemr157584566b.0.1755869604966;
        Fri, 22 Aug 2025 06:33:24 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2ba366sm608881866b.19.2025.08.22.06.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:33:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: socionext: uniphier-ld20: Add default PCI interrup controller address cells
Date: Fri, 22 Aug 2025 15:33:19 +0200
Message-ID: <20250822133318.312232-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=/M26qPH1NPziTh0Tbmf9sXdkHY+iN5CemaBMwSON+uA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHGe8ukZiKdW9GXbdlR449mVvImtqaLWDZRib
 uARzocBq/uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxngAKCRDBN2bmhouD
 18wmD/4g58pwxpUSfvmYnBNwgp53IbqJp2Z1TU+ZoB/MN1/V8S81fvV9w4BI2luvOKtasYkb8FR
 f3qyubbQQzCBoH7QBbn/8Pw3DMUgoxlAxpaM+DrgKGF+XM1oC+R/qef8vaqBBxiCFGWrBm9Xp2W
 zv8axs1FC+7p2srxUx605mAiMYUhOC6CruL72Z+IV3I3TpixyDDHD0fiWd0BTypL+cFcVWKJNmb
 Cw0Njd2LeLUHORFkA3A400iFs131n0hg3/DHDWPY37zWbGOCkKrL6Hpq5rlC3uTLAMzHll1SaBO
 T44+i4ycF7Eek6ALQJkzntoAuaBJ5FnINMdbEOQOeU4GscaZh7mmItaPjYaFWaaRrXQRQLLaUIt
 KBwASmC4Z5DvsT95DoltGs+z4MHuSROWNxWh3uVNeIwVdzOdSeA6Ui6gMq5DL9OkLSCDJAhhcr7
 QZWKNXsDR2HS5BaEMPLjF8Z2RXKfLVU0BoT6WCQVi/scGcPiWKfD5+jw1BWp9TFmUR5L5J//HOD
 OPkGXfibgJBQ5BHgAW5yOMSCxulI9w9ZoNRFCqlIOteLENRJBQY0ezpP5dwZK+6seW8kRhjmvxd
 A9j1KvyKIs/Aso9V4faQS7C8SBiGaQ3SlXtOSstFIKgwrQ7bjooPTeM4JZoRVTUHDD7liSPhSaV 8KFajmmyQrv/dNw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to the PCI interrupt node to silence W=1
warning:

  uniphier-ld20.dtsi:941.4-944.29: Warning (interrupt_map): /soc@0/pcie@66000000:interrupt-map:
    Missing property '#address-cells' in node /soc@0/pcie@66000000/legacy-interrupt-controller, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 335093da6573..875b93856a64 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -947,6 +947,7 @@ pcie: pcie@66000000 {
 
 			pcie_intc: legacy-interrupt-controller {
 				interrupt-controller;
+				#address-cells = <0>;
 				#interrupt-cells = <1>;
 				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.48.1


