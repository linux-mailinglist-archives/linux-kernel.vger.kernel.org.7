Return-Path: <linux-kernel+bounces-866857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE3C00CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3191A62595
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022F30E859;
	Thu, 23 Oct 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Z81Rt1dr"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFC30BB81
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219618; cv=none; b=c9Mf5oxGU2SsC0FQWFkVchvuuG4zvNDbaC7CdqUNqZRqqDZoUvRnPK1c3zS9Gb4IJ1dYzRI5iDaj9DyOv1CrLXM+0RtzjfDa6ZaBgVLdi9FO8OyBnYTJEI0lUOZ2FDoKxj14R51v2Qjs/QADsNz3OkOrsIks+gyVuo9lsT6qCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219618; c=relaxed/simple;
	bh=YFeGy6RIY6FQoh3n2HdlAiSUuoO3IjvdzWdiygan1s8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chNs7xMKR9UeR9UwqJGYghbZ72eg2ACRSkBzXWmsNAHI7YS4ifqZQgb6Bj5+xs1no8Req8a0omMgWl3RoWGDB1fdN4MSZtUb9dJe7ZET5wAG0zkcVCjwbqUg15FQub3eDVmWePaZlJdb8KiI6fVjrl6sqX+b3B8ES7nFcSz/qig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Z81Rt1dr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5a8184144dso119295066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219614; x=1761824414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Lcsqgxvnd/Qt11z9KJ6n+cswHFhauw2sZ/mVRLJ040=;
        b=Z81Rt1dr1PFKz3o5Yro3EKb8BsbL7GkRku5FJxRSUidctGag4ryGZjsNXkwHy92miV
         truPLmSmDbQFcRdFe/bG5F6AA6le/NvPkz24qvUNWIwhHSmKuWALO9SNykeY+9Djim4q
         yasTxI1tPVHsi+Mh/XxD6FrEwfsg7WjR1tc9GERNi/SrNsujYpCQCnCqmZKGP6fEJAhx
         51uJEX+knJ0rGlEmMhnpxxTMjtNu9Rh9mJi5aXikdV9xtGclyRtezCTTtniYYcmHnDW8
         hgOwhe0dSnvr9gJaMUmgWYn5AJPxV5xQHnaGqB8TUOT+qGjEFTFk1gBhHPgV+Vn8q+44
         DCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219614; x=1761824414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Lcsqgxvnd/Qt11z9KJ6n+cswHFhauw2sZ/mVRLJ040=;
        b=ULw8C4WoL9DWhwQxzhVhNXsnmBUlrJNw64Q2Dcn7iKrd5LkVp+VD1OMCIs0N8yojk4
         icLitKeasbVqEdoOdobqktXiVUNrEBTnf3VRcbupkuxL7C2KYGLRfAqsvctDY41E5vLO
         zZK/c54r5pJOkJEJRINq1tBIGBP2t7wiie1XGG7/Y6HHOX8g6c4R7r5IKpDC2iFM50lI
         tKm9xwBd3soXNW0uG10qo1K+7hzRALnKRsqOtHD41HOS2Fiwdb8pkQSNNqatkZCE40lG
         lUUB/XPkhWeTREVncIJRAj37TNsJpg0j58PwfeSgIFG7rBBU3VZe1oQbjanmeUA6Isnb
         ZDTg==
X-Forwarded-Encrypted: i=1; AJvYcCXaFc9JAwZp5HvjjHKsFNwUOx2+Zzv8A/tLX49zPMqk9G7u9/DYSlMTWy3CAW+2thsfom9eLwssGeuDE/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyQ5kR8VLhKRy/uw4T1HaBkuBFFhmeaPi1lDllO0s3BQOKUDs
	pwEX9RBBb/XbRCelTxKMOVO9x433wR14iZZSBLq0QfetB98QcwxxjAkaj8vJjQl4+vgIMDqHtXQ
	jXTf60XiikQ==
X-Gm-Gg: ASbGncvtEgXps3zrsSyX9r4N8IIfiI0X9pmeQAPpBawZutfc8wV7PhU+V+jHxr6baqc
	Od+o/CAwvmiLj6MfChULKyYb2wEufxIn1I73tb5czPWnIyEWUIaUvfNaOS+kf1aO2qRnif8jRdF
	yVIb3BSmYY54y1KYIFod96JcIgIE1iXdCv2qIFeMuSwVIpH5zoqpOlZU3WotLULERxL/cxusLzC
	acdj3B46V2Ka+JgBJBR2zJw8SJXZJyhgKp3DZzu/FPmPSOpgHHrsXRTB2qeI9V5m0P2C7AAEtGT
	YYM2eXHKl9tBvWHUWuNr7yqgq8OFnADLU8878sV+3zEeWzufxrBtR1aab9pUDXWv83BNtP9Ob1J
	tbqNvbI4T15vsSVajVjA6ulKIDrBlAyrvt/4r/QP9l2QYfcfz8aQDC1bbsfifGeH4G6Ssk30mAy
	spnq4NOXhTGfNuW1mxfvLX0Rf+2b231T8d2vPjYpgLi2HG/g==
X-Google-Smtp-Source: AGHT+IGQoN8cyAJufe4YugUyW8YjG9/T5wbn/mNlO6I4Qw2SpJzK9mmfw4ugdQ+HpO8/mriv57+TXA==
X-Received: by 2002:a17:907:7e8d:b0:b48:baf8:a737 with SMTP id a640c23a62f3a-b64768d5275mr2680084366b.58.1761219614199;
        Thu, 23 Oct 2025 04:40:14 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144cfbcsm192518066b.56.2025.10.23.04.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:40:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 23 Oct 2025 13:39:27 +0200
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm6350: Add OPP table support to
 UFSHC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sm6350-ufs-things-v3-2-b68b74e29d35@fairphone.com>
References: <20251023-sm6350-ufs-things-v3-0-b68b74e29d35@fairphone.com>
In-Reply-To: <20251023-sm6350-ufs-things-v3-0-b68b74e29d35@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219609; l=2058;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=YFeGy6RIY6FQoh3n2HdlAiSUuoO3IjvdzWdiygan1s8=;
 b=4D4XuH1ZeZaMnXUhH6PjI2pOUQDDb7t6oGYOHIdJ1y07+p+NTwDJUQHIQdxuI6BQMz6JYdttd
 52/kMVUVkj1BMcXJJ3zhTyzC61sTvi6s1M6xQRwR2gH04MyO0Nv0lt4
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

UFS host controller, when scaling gears, should choose appropriate
performance state of RPMh power domain controller along with clock
frequency. So let's add the OPP table support to specify both clock
frequency and RPMh performance states replacing the old "freq-table-hz"
property.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 42 +++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 19a7b9f9ea8b..30e77eca4c02 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1175,18 +1175,40 @@ ufs_mem_hc: ufshc@1d84000 {
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
-				<50000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 150000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<75000000 300000000>;
+
+			operating-points-v2 = <&ufs_opp_table>;
 
 			status = "disabled";
+
+			ufs_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <37500000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <75000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <150000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		ufs_mem_phy: phy@1d87000 {

-- 
2.51.1


