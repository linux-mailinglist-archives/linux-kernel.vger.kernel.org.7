Return-Path: <linux-kernel+bounces-781804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A85B31702
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A01D209D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8112FE578;
	Fri, 22 Aug 2025 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hi8dgRFx"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B52FD7BF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864282; cv=none; b=emEuVC2ezDbnKPHm831CHbs9Cxvs6uPT3lpn0UEdLZbysEPYVciA/Wqq4j07vetqNcqD5C0t8iTkBgaL7JzK1Dre0+32TRNGzk7Lsi7pU/o15BVhWX9026DvqLzejnVNmdJGd7WPrBlJn71Ew8zeRYfou40LAcDLthhtEY1AkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864282; c=relaxed/simple;
	bh=d+gdIOY69OMtz3pwdkndo1LXsFkdRZe06PjHx4Kz+pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=icBKPpAMwW+ckQRv5ehXI7A5IU5WsC0S1CASmF8DwcKKN/zEMyCqtyqc4CldnN1gSoK+SCcNstRCSRKlu5MkM1Lipg531KiPkRyeHTlN2148qKGH3u0gD/WHRU9UNalWr92u+ulC3O0nRSn00FEyxkfI55u4zFvTHMbB7snGZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hi8dgRFx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b668b52so296537a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864279; x=1756469079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+a1l40tTzlrTRYfopQv1JVRSDvfbbIQGFL5sfGNDrU=;
        b=hi8dgRFxqrGNyHCYQyTQyq1uPdeqfRdBPxjn2GQliCcoYL99ckee6D9f8xFg8C4g/q
         KxQS+WMDHfGrEaI5n541KXWQVuQRXP3GBYIuq6j127MLm8B6YD/0YdhslnBgME/DYaEy
         a4gO/B5WzU89fFmj+TYfkRBxPInMM3MU7HFhgzDPVjdOML85xmxo4JRHXJf8WOTUHxy9
         JNuPxyFiLqEEa5ITnbUPwLvAjJYW9RItc/HfQ6HP2geA+HFZWcargYhuRVfI4fGOzBGQ
         f57XQwAwTN4iC8+powLyeAc35PNC2w/c2y99tDapPKcBcPPMZYnDjZplpr/hm0EphbdN
         KZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864279; x=1756469079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+a1l40tTzlrTRYfopQv1JVRSDvfbbIQGFL5sfGNDrU=;
        b=UzSzKw1cXuJ4eJb+Et8WlmK2Au7+uPSPTJHG49A+CgIug4WznjSl5e18orqkRXt30x
         neUIIOXzUfrGtsCg8lNQZsqPDDC5og0nXK7KlBO7nKdyESpdqUJ7Ob4atjbYtLch358g
         zdVYbVJuzw3XBpTON10hcbWnRL/6L8OyFwVi87nyupZQuE30hqBNemJ/OFJ5SsjRNpEr
         pDwGaPXuYd1jt5X3oZpQwQDcunsNNl1bLPy/+sPw/owdFjpFn9TbVcjSDzYFu+97lMs4
         RWd81jBRYZv3bVJlyud5sJlH6TERXaoGlo8auP7CCTQ3543WtUh4m0fnptDdFCWW3Imh
         mEvg==
X-Forwarded-Encrypted: i=1; AJvYcCW2vYaRo+4byDFr2BLcSRh6s/T6soh3S8lJbW2g50BxISQ6z262uPoAVIstcHbu4Riekh8teanM1rB6CjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYpgs/7CSzFvff8zwP3l9kiV6AoKYeuUi9TLoO1N3sSghPPZE
	QmI+jSVZz3XxgLDAi0AqoS6lC/v/MNjQYzCK9E9P7fCCvzRuh1lqFOJzV1nYBCE839aet3IOYXY
	wri4m
X-Gm-Gg: ASbGncuiOSk4tPViv5BhZPFyu4Y3tNTH7vkPf6agMWR0UHpLZ4BJzUcxphlvHLKdplA
	RvLBioSlTLIyFii3TgFgKJniNMiLzz8iqw8V7nFLK0MY18S+N+BYCGY+h0/SKkgrP2GQPYTd9D/
	3Abb3na6V7KtAiiFbxNwuCavReNsssmH3VMgORLn3zI55guPaGwtHRwDBgVJS/OrKC0EvYohv0V
	h1spd5P4AEfr8PY1fF7sdJjIn2JnAZ/mbuYTZ6h6sXB2z9LWZn+A9H2l2xe+qkbGrZ3XtUDuway
	bmAe+NVnZeFSf4SX1MH6xdNbaMGgF+5S5QbcqMgtwUHQLKQRPTMQnIJsQvp/C0cGUgeRGVDekE5
	zBoGvCypDopyvA2Pn3JrDlgqMAWXx/c816VapLuM=
X-Google-Smtp-Source: AGHT+IHiBRJ0jddGVRkUbXo1oWiOVT+C0uPdT43nbsFtAtr/mDQxv5fOF7pvzO3s70eWszermwJukQ==
X-Received: by 2002:a05:6402:2351:b0:612:a505:34c3 with SMTP id 4fb4d7f45d1cf-61c1b4dd3f8mr1247388a12.4.1755864278552;
        Fri, 22 Aug 2025 05:04:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm6690444a12.48.2025.08.22.05.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:04:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 14:04:09 +0200
Subject: [PATCH 09/15] arm64: dts: qcom: sm8350: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-dts-interrupt-address-cells-v1-9-d54d44b74460@linaro.org>
References: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
In-Reply-To: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=d+gdIOY69OMtz3pwdkndo1LXsFkdRZe06PjHx4Kz+pI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqFzCS/jl5P4ZY4fifeNw3zzW6jQjCKYUMBrl4
 pzCfPa6LmSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhcwgAKCRDBN2bmhouD
 18G0D/99zUzXpjCCEm82bn5wVvUvnCpEjKAdZe7XQ6fcyHTGozJTOrJTAjf15+GgQX/TL0eoRAv
 4u3nDivqeRMBQIGLVY+wCTT3IgPdMueGz9Qazp43bxIobOzUEctMwKQmHRrOrZXLfAlIbW5sGRA
 1KGc9gFqit80+1R/JPN804xC5kzksafYedCaQpuW4HZIjTFoXlqQruMHlcXPfo1/wLqzrmn492N
 f5A2GZGt5w24GADOttowioWFhloNnwKF8Q6gyB+nRIQPY/+mH+RShPExtuivTR69A8kSTl1aH/H
 t8rcJCLAfrmGlDpfkMHn2nrI2qE6r39stD1mDx36MvQ4Q169klEEbTpXNwmpQijSORSI2UiFwtx
 3IfGFEgebj8rruRbmAfi8eUiiGcpxDZ/IP9lPUis30FbZAPPAOMeD7gGJqolFj4HCso5HGvlnnQ
 JIbOYj97gzfADdJ574q1rqxH3JQZ5WguAI2EvKJU/AOsygcrSTQMJI3V4F70KcSBFyLOaIH7V7P
 yqy7+0fMpBHxCjN274/JWbs0w6GTFJM440C2tmVZckt1IEbqXfH3JIrDIfn3Q80QV2FdDO08Aic
 s3NSSJNRJTlNouSUZ3QqwR5XpOfOFZUGDpwDwVIUPEG8p7L/gz36i/qjZGIO5tc6VfUkSjHG6Fu
 oZEL3Ebu9zcgMog==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  sm8350.dtsi:1554.4-1557.30: Warning (interrupt_map): /soc@0/pcie@1c00000:interrupt-map:
    Missing property '#address-cells' in node /soc@0/interrupt-controller@17a00000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 9a4207ead6156333b8b6030fb0fbc1d215948041..acaf40298f2e353e81793639522d0b0c52f6179f 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3544,6 +3544,7 @@ apps_smmu: iommu@15000000 {
 
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			#redistributor-regions = <1>;

-- 
2.48.1


