Return-Path: <linux-kernel+bounces-781997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F1AB319BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3225B5C242C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A19308F05;
	Fri, 22 Aug 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InTqdKm/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63592307AD4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869500; cv=none; b=UcTdZkMr7DAiORAWW4dvS9lhKOyofzQEMbQyB9Mi88wsVc9L+xby8RSW+UCXXE8tqgoDQNtt3edQ0GqtVgfpBlqMskXR3UnTmUZNxURnzQxSE19XhKS+k9PHj7jnudun6fE2sph/tgbN3291RgY6bN7Hay4yd9G+tsSmx9tUBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869500; c=relaxed/simple;
	bh=kHSR3OBfxE0kL9LgZuy6tb09v4e6Fk2998ktGFCNaNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdw4rAOOjcS2QXYy3DtDqJUSOya3jGUFQvnXxwYXavJTFSsM1++nchJS34LY1lyFUse2k7vE08c6PU/9iLLJLS4E7IUDPASFvbm5gW2M/1Cleuw/Sym+pchXofHPr/0TGSQO8GcweoEBsxQyD3/I2bdY1OV51inr2x+W/v3ilQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=InTqdKm/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb74bef86so32692666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869495; x=1756474295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHSlakyKxrjNUT7S6VUafjxhT54zInLD1iFLeYFLDh8=;
        b=InTqdKm/pLifk5bI20r5jarUHoL/GPGFMu19pf3Wt4i0nXmZDwdkkmv0rzCYK8+U+t
         Q20TBmk7l/tRCWS57F3x1V3RDUEUm+jykVlpD+TdeF0ganutpQKirVNNWPkOqbeWINW+
         ZlVTnUwL4K+m0Gwfmce0Z/ruuSaikUMf/m5YFrxVPQGPKCNd6KCVbNZRzW+qsWqkWE86
         79zCTysX/rCHdcQJJufabRjg4Lw1t108/JeFvbW5B4cPFzeh8JmFQ/He/HRZWig8K0+Q
         uuU2UOMjqPWejNcEcqBrx4Bs8lnBJKhXXavwSBKjalrZJStUYuQj2p9Dn774UZhnM/4O
         ERpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869495; x=1756474295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHSlakyKxrjNUT7S6VUafjxhT54zInLD1iFLeYFLDh8=;
        b=SM/0gCL9t71sJxMQ9BIRQtjwdxqPShpjR2DRulV9s6cygxoBmVCACgRu4M+kRcDcMO
         aKFEpCy6vvWG7TZdWEW6VIDlaFwfd6THOxIxaHidg/Wy6mYfKyyH/FoS1MIZAMc82Epw
         casW/z9jVPe046zrIac9nDrtICqAROdbjTx/q95iMOhL12eDqPmWOxwoUfKAXBntqbAz
         DR60lqQ6VgKI8Iey4mfEJlkYUiWilXzYfv//PJAq9Gg1hYAjL1bN8yxlBIeldK42yaFo
         iYQaJuddbWuRU1Jub3sCMcJjCNonwAK0P+MogxNRVlqg0Okrpj7Y7i7THyE9IaLjpcU6
         1ZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd7qhuyYCjHu8Jo68MkxpS1DnPmp/twGGAi1FtvMcZV3ZLXh7XDosO8K+iBUtxVz+r5OSokaJeXtQP0Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLQ/zpYXSYp3oL5xFcNGf2v55OgsUD7wEh6vi5nuf21zB9S0B
	yF/UQTn9GWBqTf6XPhUbpvoBAkcOadlbEcF8OYCQKiQSSQtx2heF7ypa7Uokd6aaevI=
X-Gm-Gg: ASbGncuUd3YuxXKnDZkXZuG4gT0OXyaJcKNnFUQMmQ0erzUMGTby/eiDE8AP/i5kMQ3
	leDPJKRlViUOZ8D31WmCGu/gAhJa+PAXCFRKN/mwSTNW0MgW7mulgnBnC3+Ira15xLGRLfaNcxg
	KSpt3QkVq1qWrSwYfV+qPRQoD+DYoBf8ivIbgXDIPdKauSPo3TFgZiWqCB2JEQjocTroHj7jVB/
	jOvsZAEDbdZef3oIRaSh+VlLsF2deMtpCAmu6ymDK4q6MGv0INlR05CYKWILvoR7gVlHMJIh7Dg
	1yUZZ61qAxS7V11DDHYtrohT8xLiKWLA2uFiRykBRXxPEw6LoUzeX3VdR2twlhU1gTGMRXCpWYi
	g24JSPUS4Lu5cgjcJ+xMMXCu5E80YgTpRR2Z6nqo=
X-Google-Smtp-Source: AGHT+IFH99GO8Rglk9z1kVj4gHZfOeJnVrjz3zilZUHOkV9zKxf8NlcHsbBnTMmSCOB1kQdl0LkccA==
X-Received: by 2002:a17:907:7b8c:b0:ae0:ba0e:ae59 with SMTP id a640c23a62f3a-afe2943ebfemr132325066b.7.1755869494660;
        Fri, 22 Aug 2025 06:31:34 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf24bc40dsm554863066b.109.2025.08.22.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 15:31:17 +0200
Subject: [PATCH 08/10] arm64: dts: imx8qm: Add default GIC address cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-dts-interrupt-address-cells-imx-v1-8-f1b479da9340@linaro.org>
References: <20250822-b4-dts-interrupt-address-cells-imx-v1-0-f1b479da9340@linaro.org>
In-Reply-To: <20250822-b4-dts-interrupt-address-cells-imx-v1-0-f1b479da9340@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kHSR3OBfxE0kL9LgZuy6tb09v4e6Fk2998ktGFCNaNE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHEmpXOBhphAMxpNv9K4iWFobvh3z5y2FOtCm
 oc8Bat2eRuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxJgAKCRDBN2bmhouD
 1zvTD/0cT8GVrN4h/fVwVC9D8PivWS1iPCVzB1oOviTi/ZPILeFCCt2UiG8SZTY5AHKpyFrCKBr
 y7r5VnQ9k7POV0GkdF6cr6Rx0kudWl4Auhxq7ljxJ3SgQ6q/sbyiIWaqbsIa4vVS8Ul65R5mgSn
 HWrLun9VAVRgCyRoR8fvkqyuk6rOP7THvuAOtiudMDyRHEBWl0xw4dD04mXY0TROWpHwlmQykoo
 SnrfYpXxDmunvQ3EddTUce+v9o7lb09/PkaC/4BkqJF9WofBhpx+A5WWC0xPdtiOdO3RKThEIvc
 KIFPBTEM9nOVfqHIOZ1EG80xO+cweeADF0tPU/lHMhXbhr4XgrUXnmi0mum8ifop7YeqBgGNiDG
 eV9uoWroZ4Uvg6FN8LDXCgmfUmhlRlR1A3I1v9maOZhV2ojio1j2dx83Xk+TZeFeLyfb7h7U0oe
 7XtohEOhkEdeR9Y8NresyjZWLoyXYWhV3JAvVIll5sFWqWimk8PqAPRAn9Z6x5YkWHUvIiHyHyc
 bjZfi3NJhcS/uXvZE+qMaAfQAG960emuj0Tfj/MVQLRPmX1gA0Y+Rmqv0o0qbtJdgsk02i0Xwfb
 8b+uMpM2Ur591EvypbdpzjlyzSbnriMvUMYgHhv8/Kyvt1geFiEIh3+3S8Y2lZzxjNUjEkqROCI
 EsXQufp2TZc5omg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  imx8qm-ss-hsio.dtsi:83.3-86.28: Warning (interrupt_map): /bus@5f000000/pcie@5f010000:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@51a00000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 827e1365b5dae438d4628852ed6884aa846eb89b..5206ca82eaf642a32299147e9c1b45704075e2b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -245,6 +245,7 @@ gic: interrupt-controller@51a00000 {
 		      <0x0 0x52000000 0 0x2000>,  /* GICC */
 		      <0x0 0x52010000 0 0x1000>,  /* GICH */
 		      <0x0 0x52020000 0 0x20000>; /* GICV */
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.48.1


