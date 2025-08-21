Return-Path: <linux-kernel+bounces-779306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C0BB2F274
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53321BC497F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBB62EAB6B;
	Thu, 21 Aug 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvePidbH"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253EE2EA736
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765068; cv=none; b=YmT7GMer9ooq22AfFv+/KSy4CbfUNMzqaR/n6+6bL82JjxnGgEPTqSU/b4o3qYKOKyQGr/CBmPXskbGt9UX3iVNE2NJcp9+31swauylJUvaJzNNChSbS71by61mKxWeWlGmKdA+imyKRQbjeuwuKKQUc/qd1+GxDDPBr3RlchFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765068; c=relaxed/simple;
	bh=iqqc9H3kVGDEO4owcMh77Y6V/4jzKjChKYZ4/hBrnt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjElpQRhiWRtB8GTArHgOBc2hba29ReOWGwf27AB/vQoiNTLzmV1CaOggMGxtdqsGLmVP7kWuxnukN0rgpvLSZ3FkZj3vbYnwkRWZrgJ90GkX9d0GcobUV0qMr5+qlq9hezWcja1rnF3ZmA6VBZV3f/8h5/QNsRzKICG7vi4PyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvePidbH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7ab87ffso7787166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755765065; x=1756369865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hh/M2EwfSa9FwHQzHqRzfiw+17/lHcQFKbZckUyEnvs=;
        b=dvePidbHHlQjyzeFugj9OaFDHPKSaQKJeIifd5dxdo8acJdtHKRVGz6vhO/kWKCD08
         ieywzpXAKGVxglvZhs5ipSo9vPO2sAS7B0Ov74vCn5S14PU5VvgTkWiYR/wYpEHxNY9y
         Z6LnHtNjxbiSK3nk/45eJDFG04sv5WhahCsGJC9cEtVM3YvA5S+741MeL72j9YAEdjVD
         dyx42BCtW1LASmi3RFmAwXtJwmyDf58/6DjgISPF+eEyydHXb26yvunI6Xiv3DCMZe7H
         tBBHEeiHIbOB2NMAQyfw1t4mFeimgp89UkslTnAHdnnygH0Gm3Xn+OxIE7Sag/o9e9ko
         LfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765065; x=1756369865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh/M2EwfSa9FwHQzHqRzfiw+17/lHcQFKbZckUyEnvs=;
        b=SwErDMPktepkjk5+fElAAAjtDp+bFTzUxlsfR4OjnSWpWQ8LN4uwCPkdeiVMIoH5Rv
         rcjdT8EsPFqKqfgr8f8Mt5O4Am2zIqqHgdrNsHe7qefTDk3ict6Qn0abGrY1zWBGNNpV
         OxU5OFaKpxwBOxpaBoySzeg9SAocke8YW8FOlKfhxergX/gu5AQrcfgyRfSviBfJzwBJ
         m04ptuEqxeDvPa6+Q3leVD2LCduVzuy4V8kK5D8ror0olmjG+0BGZexpwIMrL/CSSf9F
         uW2efuOYRjeuf3hx1XzBEQIjQlzzRuhmGNvonLhdpWTfD+v117DfQjlJjZnxe7uIDoya
         H2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0GObwJrP/CmHvsCkRmENgnvtv9qMoirVsty/MvP1MF80U5RA8RYwX8aO6fxytzTRGXAzsVub0VpgZIao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzROu6qWBDD0XH6vSgVeSogczmRsxTa/l/3W9kjdtV++ZUC7js
	dJ3MaRUNl3hMN81jkRwEvQgt5dqZa2soPpEKOLAaYJlXze/yIrBI4T8MOkjCGdKzp7I=
X-Gm-Gg: ASbGncu9EBOyD6Mirh6C4TUjTbovcLx7ypXevehBTM2Wywh/0lQAUdy6IfU/hlIX+gR
	sOPqDSnqEgozVAXicmHjcZC2I5G+sMu6BVS4hEGcoVzC80jD505cYhldbgmUYdrGw41CDWC7K61
	0YZ+dRaVXlBRnPm78hOaIntRgva6Dm9ypzkRIxdkXBMTI+qrFjH0WUXDP4SAMGU+CwHHfd8i9hW
	u6BaDIR3nT7fu98c8O6lsUymywiFSvwxY0pkBqN3K9hmq0Zg6VmXx1a37IMCEkRN0jPTiSJyGTJ
	kgosrM9ogmxW3T9fFODY5+j3XVM8EsvrC+tSbU4sxrdzSiFaZx36371cmnPBsocb345d+d/+iSW
	2+W4tbZj6bpNxEiuBu6ZJ1TW2kygYiq+eOw==
X-Google-Smtp-Source: AGHT+IFNk/pJFnDs4lRHPJnbj+R0+UoDvHoNWBUQnniqvKfqWInUDOjeDP+OKC+piYhF74oUFSgD6Q==
X-Received: by 2002:a17:907:972a:b0:ad8:8c0c:bb3d with SMTP id a640c23a62f3a-afe079e2116mr74283566b.3.1755765065406;
        Thu, 21 Aug 2025 01:31:05 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2fc568sm346436166b.38.2025.08.21.01.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:31:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: Minor whitespace cleanup in example
Date: Thu, 21 Aug 2025 10:31:01 +0200
Message-ID: <20250821083100.46340-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=iqqc9H3kVGDEO4owcMh77Y6V/4jzKjChKYZ4/hBrnt4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoptlEzToO3Ku+DKnz2vaPiN1ssj2RVk8DjRQKc
 Qtcz+MExfyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKbZRAAKCRDBN2bmhouD
 1/4tEACNYir9uMarV45GanTEgmnE4LFISWmgKJwbLjhiKVj51LWYivtWPj6mF04MOvmQ/0uO4oC
 eZoanmeV9/UPVaCWfsvGdXfIwkF8G3ezVQSCFHL8s/VzedE9HUpJUqTU50rc9jZtZKhZ4ACtsr9
 Ci2yCUbRSaoDyloZXA5YI0ImHjPi8QXHCa4TJQnoQPrIiTUw8QupgbCttoCDPzrcZWBpsjb7EIq
 aKun5PQRfFRYgBN1V6bl6v+1XG8GLHEfxnvFMEF9Hd5ve561qriEMBuzC3tYaSmfaAr0KTMgJOc
 YKJr6lmLHAPCZcbiIpVDFAx8/dtmHvuayFfFjuFmf321cHCUYfdAvLR66Fe8hfBpeI/xEOEBDCj
 7bB6b4sPJLZRCH9KSRHud0IaFOZGC6bukzBRVc95w0EqFIYgpcIDzA9mq/GIfUSnKSj4XWFqlBm
 DRmXsOAnThbF2L5ZDfaux9b2woTITUBSKUwcSCEYiQqNJlyBkja4nfOJ1rQfvIC8WqEu69gV8Ku
 +hCx1Dx6/lkn0FJwJs2hDLlRczw//7mZonnGXjdaEWslBwqK0bAGEspxUG9wwEDfMtYjJHRQzWy
 ovcuxx5q9cnEdPmVYf89/0u7owD8QmBimSmPtg+UCWVkkDMeYcatGhMRTur/sdy4OZU/I9uri1D Q1A603HnLHhssWQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/fsl,easrc.yaml    | 2 +-
 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
index 8f1108e7e14e..d5727f8bfb0b 100644
--- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -104,6 +104,6 @@ examples:
                     "ctx2_rx", "ctx2_tx",
                     "ctx3_rx", "ctx3_tx";
         firmware-name = "imx/easrc/easrc-imx8mn.bin";
-        fsl,asrc-rate  = <8000>;
+        fsl,asrc-rate = <8000>;
         fsl,asrc-format = <2>;
     };
diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index 85799f83e65f..c9152bac7421 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -176,7 +176,7 @@ examples:
                <&sdma 20 23 1>, <&sdma 21 23 1>, <&sdma 22 23 1>;
         dma-names = "rxa", "rxb", "rxc",
                     "txa", "txb", "txc";
-        fsl,asrc-rate  = <48000>;
+        fsl,asrc-rate = <48000>;
         fsl,asrc-width = <16>;
 
         port {
-- 
2.48.1


