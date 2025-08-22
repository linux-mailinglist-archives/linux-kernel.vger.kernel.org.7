Return-Path: <linux-kernel+bounces-781490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4355B31333
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014C8724163
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A72ECD37;
	Fri, 22 Aug 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkDTW1Yv"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D762EF651
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854809; cv=none; b=c97pLC5A3Qc9C6qbcAZQC2zFsULcPqIwpprbQyknnuvz/oeKwoui/6UWMlXrFYJ+Tv9gAHxfh9gVyIgGuhtzNx2OkoIfTSNXw6rpJJaHP3aCwXpNoSmS4vGpcYYcQ8yOUWXSgVOF+eDSPfnOi3bum/ltOR1U5wWhM8oeqY/XFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854809; c=relaxed/simple;
	bh=wo+28rzLb9E7nLBgQRSXIPSdalCHv6JNOeyFv5zLcqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oK20trI7I/e8U9//BKxrvRTrvhlkBuskm2I8qtnkeGzGdUKDOPVooZITmZRVrNv4x9dbRb3arISEJBbDI5hyz+uQvF8Xa2YpgOiQQPIiakJKJToC2GSUbdc9AQcsv10zNNqzf7UklIvTb51Ny60eIfBhMLbcZmjGB/pMgwkvz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bkDTW1Yv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c6412336d4so159172f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854804; x=1756459604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4iYMHLc4WfPh2tAiIuQ5o+Q2It/ACAsF7CETw+1bqM=;
        b=bkDTW1YvcK29cGzpP55tDFOXzUvgae+IgN0QGSwmRKMwel1L8ABecAuMgylvqy9K8C
         GTUWnd87XgNxp8X8zp3FnUVe4tQAsP5FG8Mvl4jauqnXNSWy2cSQ4T+tB4y6X1Lezjmd
         Cn+tpA7yQpUQnCiOlreLaXhiFYJ0AZwMlfOUow/iJtCifnH7jsANDQ3/lyQczASWe4uH
         ysKdlZrw7cStzc6xSb50azZGqpEAkCi+Z5zU1njvXAKHjb8SIC1oe1pg3KrIERnWgAhA
         aYjdI50YjMda9isvPTGpv0JgCcKRECcO6jtDE6qU8uVceUKc0Jpcj0cjI9uCypK7Sg5D
         A0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854804; x=1756459604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4iYMHLc4WfPh2tAiIuQ5o+Q2It/ACAsF7CETw+1bqM=;
        b=A4QZrsF7QftB/NfAvqxqAj/9QFbISL/Q9NdJY73rVgcA1dihYqX6K94x/zrsMzgUoj
         HxbO1w+rTAvBVVW9UhlVTfCXATZiFYx/YnXcAKK9BVzgURC0qZkqXG98pb3XOSSKHo+C
         PBmRzhDvPP/mUruoPrmLLymlMznu8zWFCYS+E0JmX2y+8A/jCwJLGnrTgOyzYyHEYkTB
         hSRtGzy5QnVyIxd2b4HrQOIwjC145Pl8FOeROUAEnnbaXiIvF4hzI3L4VVEpPsobVM4M
         RY2JjJeSeuELvKcBjsq3tCkXBrijboFx2At/wXotuizxm+qcPA/oIN+EL0SBYWN0uW1Q
         G88w==
X-Forwarded-Encrypted: i=1; AJvYcCWFJtQ7bkoM5Yq5fNjRi2GkPjjTnK476HL1r6+DecG4euRZqph/NAGUWDUiM5bTQNx5FpobYldKx9tzuFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbW5h+LR022TlwuwZGK1XU6m+shNLF8nbL9F3BXHXS0zfmLAr
	5rm95jzqNrH0KmtGhWg+t8adCaJJ60X2QoTA+XCbarA5Md4f4fpjzILYN7DJlbdSBtI=
X-Gm-Gg: ASbGnctH2XT507xQOcBQfSQfYw0ypPJIVJhRiLufXmcrJeLLWnao1Klloj91lWGvkoa
	phP8zFekEITz6LyndXJBam63eKEa3j1VruWcfrbnthqWmKWLZ1P8UWoDTVmrHg2acighcemdNQB
	6190qTxSj8nwh4oT9Z9qzyon4rjcgsESChpLkeDh5bjzDjxByTcBx3svTWHaQ+PTbfCmYV5OlKt
	gbcJjTa6XaEO/ui3MjdRR0B5qATdHliqTFJ8DIFQOG0C/peaDUveUsO3ZAAyT/nLcRes84x8wE6
	cvVzamvyVsmAtOcSbuDtbbbZr2lRtqvtPLjyTNuAFJZwLNGTNsjo7mmY+DCR2u6psEZoZ4OABup
	2WemCqYQRJZ9gV78hioej5KAlWl6o+asnP1ZBJ86cdWiG8+Mpq0K0Bw==
X-Google-Smtp-Source: AGHT+IHWimNmhX2D+e0rAbr+oUyeChnSAW/pbGvbaUpaR6zi2utB6mY/Z10H3CaZcm5CXc2OFCrfew==
X-Received: by 2002:a5d:5f4b:0:b0:3b7:7563:9d59 with SMTP id ffacd0b85a97d-3c5dceff114mr1593265f8f.57.1755854804453;
        Fri, 22 Aug 2025 02:26:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5826751d5sm3297007f8f.14.2025.08.22.02.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:26:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:26:38 +0200
Subject: [PATCH v2 6/6] arm64: dts: qcom: sm8650: Additionally manage MXC
 power domain in camcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-6-28f35728a146@linaro.org>
References: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-0-28f35728a146@linaro.org>
In-Reply-To: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-0-28f35728a146@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZndUBUupjU+OOdgcN5TmqiL/eMh2uIr1+LmbccinqKg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDfOCJnAzwaebLAVtkSCcABycmAsCAfOcMDIVLyn
 YLAXinaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg3zgAKCRB33NvayMhJ0bqbEA
 CsT1D9Ow705PLEPkKSK32uNTf42QVbKH3pGRSRr3VOTfhNZCRpnnkRh1+1FoCjLI3ZGjG+RmZmrO0Q
 qvi/McXqk0bXsnKLoVnE5+uHivcz/qSlb7iRG/FkBMdqHjbNI+vlHIiKlB7l3sEZSWV5/3RGnXExdA
 fGwgEXVqitPMcRXA75S1EtBJl0E+8j1zL+wwmjYAgf7Cu6qT+KRgGk7ZvMv2YE9HodC743cEZxWuGg
 g6wnYm3gHXBBN175LvSn91VhNrb+UgbvtLT/LQBOxo3KKEFVgYth2qJj9rG1AkHhpX3LpksdlRquxe
 U7cklzUA64WnqwxZ95lv3gksSUK+kh/A+dGhwKKpZF9Q4YFi+FoTRKqnYNYMvUDO/zYbTrtoaBvtOX
 SlboOQ5kiQS9HsjX8WFlZoYMlVeEEC2MAYJ8BDpTCdNgmwbivA9S1RQ2I485ASdBZW1VzArproZiKO
 tI0357El2XZvb/119I6zpGj0oEUDrR/jPzubcOX7aOZnJhtHOKk9WY3hNBc+MLs3n6Uczz8JWFcm9q
 zXnaBW/6ewLiZTauMdpaud4c1Gjn9lgJYQigtrw0p+ZKGbBZg6/SiaLi/nb/SJ4HDIhyWNWw3XsQt3
 vKMIRGIRuuhBawqMsOiZDtguEXn+Vxbz3RhRduo5be8xC4/7ktBI2fC5embQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Camcc requires both MMCX and MXC rails to be powered ON to configure
the camera PLLs on SM8650 platform. Hence add MXC power domain to
camcc node on SM8650.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 99b7c6603f284df54b0a4e0ed554817fa8ce6f35..890c4341179a471416bd63308d13b0e313188142 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5349,7 +5349,8 @@ camcc: clock-controller@ade0000 {
 				 <&bi_tcxo_div2>,
 				 <&bi_tcxo_ao_div2>,
 				 <&sleep_clk>;
-			power-domains = <&rpmhpd RPMHPD_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.34.1


