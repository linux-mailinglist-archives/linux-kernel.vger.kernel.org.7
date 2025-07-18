Return-Path: <linux-kernel+bounces-737121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C31B0A7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2FA16DBAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911E2E5B00;
	Fri, 18 Jul 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOuGNCl3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D929B8C2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854095; cv=none; b=HINfvL4qLan2zN7voQPrtlHUbECoBJgEUUyCZyIjTwGHTYCoP+3IAS1BuSO0tUJLQtu1rHyMBcYmmfXadFxWlLaqelPeWjzqOkUhCzJxU+PbEgcIrhYh4IEE/prpesHUVnF3bJGiQhgV0J/aINzLb1y12P3ggIg8Rv4UhKYpiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854095; c=relaxed/simple;
	bh=H5UmIvUo7LQWe2Migv7tSh5KSIEnuEJyZElnvQeZk5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4qTqjvozP17YCtxACi6HM9ABAlwind84bcLU45mZAI4pEH0Atv5+ekBdaYO2LaNEACJCwcf4TPVjSEmg9id+Q5HCNKMh8wenCgXCDsPUwQJFRlGSCUV/+1vcTTyt6cYAqf8A8vhH2A7HCSbn9lwjJPPIUSX+1EaDcqVJsB13Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iOuGNCl3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IEK9JL022220
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5K2XGMBh9O5MReKiBN1SLoFGkqLPj7SyaVN7/UiJX0Y=; b=iOuGNCl3yrRE26TS
	vH4H1+fKyxxrrXD67MqktB3qaDss/N0c8NaPrXmFR7VFwTi3o+riIea36RgA9K5u
	NabZzLLd7isgzy7YfJvWSugamwqg7VQCumi/I2t3GAfAsJVVNIN1XVqDA4icqLX8
	fikyD4hdVeGlA9fNfJODcdGwtFE6wcYImHPg5CEhCDLM7eNolt21CzrWd8S6ebJG
	tiPaHLYJm4bVLs8O10MU8o1IkYMwjISGJY+jX2M5XHr59NE68ao6TdZqfrvCUmNX
	70sDxPs/sufesmjBgFAqKmiO9F7c0z2S6pWvrWkGWMBC+WkJFocO1wHZc6uwOk33
	u/yPKQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsyc5hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:54:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-87edf585bf9so2575702241.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752854092; x=1753458892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K2XGMBh9O5MReKiBN1SLoFGkqLPj7SyaVN7/UiJX0Y=;
        b=Qg/N67Mu2iL5YzbULKCa77qUiEFZXSrtt3rikwxMLtYagcKwCwFnt2S6aaq8Q3joED
         PeQ3CoPUhvvuL4++Vc58lXjTjM86/IT5DuWKXtIPbfgrKYMVJq4PkGDGKFPnMvg+FO4z
         bJnT55DJNPeUQ/zvzBVRA6KYBjk4+dM2u9vUZ3SxPMhteHtw7HGa2u70Dt4Iemy2ZIOv
         BExIH5rzaARBqjlFlBvXWPZMI8v26JTjG9j2JQMMVSEMVzq/mIpn8wekZW2ZckIvhixS
         NG0fmeUdLLt5Z/MxfC5+NmQrNQEJIWj6IlrbdUL/BGVVaZdS9U21KdmKuruIh85VVSrj
         W7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtIYax1CUMvaInaYElhTJtSWv+k8vfiBDxgP9z9PQGufW4/ypejO6Tsyd2g6tAPni0wTFo5Q5iJrWW8W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVv1ptY+vrnR7L0n425Sdq4CwBbAoew5Rm5PfCVdC5CM0lLlzr
	AEF/mIDTBC7EQFRjl9k5tcbd4l4lL5jTkW1fm3C7PlQntdRcfEY9BsCknCVgUavjRn9G0TjBP+8
	WgrXRF6JdLY8qyMoaNPY2BQGAhvoP9cYJLyCWcewEk2S9C5VaTCFn9tSmaepCt/nNAeY=
X-Received: by 2002:a05:620a:6007:b0:7d4:3bcc:85bf with SMTP id af79cd13be357-7e342a5eda7mr1399845885a.12.1752852371893;
        Fri, 18 Jul 2025 08:26:11 -0700 (PDT)
X-Gm-Gg: ASbGncvxcAQZ66CYx8G0dK5MEMNHVHIBb0X+NM6bb0URTBVWBN4+IWmSxUEAg1ETCQ4
	8V8sF7/fpOIus0WG0c3nyEs+az+ITkboPHFdAfB4Ri5bKPFdokxpzcYlicCpR/5fB6uT3teVxaD
	K+PYdsodhbUcvDzIiSwVYwgj4tpi7caCdocG07V86enZI1bGp8gbVmszCmdA636LvL5+ghlvkon
	SyoIf6XgY7QYcced6fIMYwcvcNjxgtJK+oE1tW5/vOURMcTu0D2/M5tDpAl2/5WBLXMVViC8lmC
	VxCP3lVu6prFBqwBq2L4wQfLNzlLZj6OW7s5HUir/OTMNtXZwrvag0sv8XDal+E6oEYtOA4YbYR
	SfcCamB7e+eyWbvbgoue72lIDJoUcs3YwlpID2ODnX2RWexgZNg+HsYWXERGGiE+/Qr33aMNuAr
	Wwmx6nH94zwQxqzfI7pzfjaRVXM5+Poe0t7Ao=
X-Google-Smtp-Source: AGHT+IEggOb9po8Z3KgzQOQPbQZul31JWCo9ugabQ7H/MSY3eKHvImtsITPWszPtj+g49k/Y+6XRAg==
X-Received: by 2002:a05:620a:6007:b0:7d4:3bcc:85bf with SMTP id af79cd13be357-7e342a5eda7mr1399683785a.12.1752852347508;
        Fri, 18 Jul 2025 08:25:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d994csm2466821fa.84.2025.07.18.08.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:25:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 18:25:41 +0300
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm8550: stop using SoC-specific
 genpd indices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-fix-rpmhpd-abi-v2-4-0059edb9ddb3@oss.qualcomm.com>
References: <20250718-fix-rpmhpd-abi-v2-0-0059edb9ddb3@oss.qualcomm.com>
In-Reply-To: <20250718-fix-rpmhpd-abi-v2-0-0059edb9ddb3@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=H5UmIvUo7LQWe2Migv7tSh5KSIEnuEJyZElnvQeZk5I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoemdzL+wwxdRAvn/dW/Fgxt9ssFTlQfCMVMZ8j
 eFEaMzeiXyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpncwAKCRCLPIo+Aiko
 1RkJCACuN9DQAUNI4hr20SEIbwT6XwG3vTte/s2Xaox+qFhz60zOZI9kTeiNjzLXskGp7mr2kSX
 YFHe4+PR2Lc1GXvz9hCTIRUzjZk7cOR5n/X5HbuPn5XTu+iTVaSZpe1d0/czlxgdJpqF9x7w9U5
 GBSz9quyNBMI1MZEI1LecIVOWa0KOJmRnZ5mWsE+WP34rNBhctH84OUProDO/9oZn0+vVA7OeMs
 ISwAiL1XkQNF/Rhxpp3XkaQjX0TZUq/JYRjpcYdPpf2fVe4A5ZFr2CUQ/mNsQ20MVyfQ84l/kcM
 a0a86mnuvzGxwDj5DQyqmdMYUpLBcJo9ijV6w9yJ5F15IanK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyMyBTYWx0ZWRfX0BNo4AvuUzmc
 I7EAnRxXjsGG6X6v/rqX3/TMF4r0r42Scddga3UWfXK1+omKIWhlxEKGzeetvud4v5ZdY/8CjPJ
 1v5H9BJC/KEff+G63kqaMgBCnATcXjyHUuYo3dfzjnVWxS4V54OwxlhUchBcn2HJ4YPrn8TWxlX
 ybVLicBms+9e82Fm1R0pDqRMwhFQEITgt4hwggJ+uNtvcrNLxggCEEGLSSXP9chKX2NxWGiaVp3
 ptw74opYLujEr/WLx1UpRqfme1HTsXDKHH1O/OFjgPzFAZTTh8U6U3O4t13yk466hbWlmmbfL2I
 mamO8M8URjl47NWrA3F3ftY06AaX2tm2ePd0ASQVFqIQFgAUyb4ux60CvCRxxFXVikaoSzuyoDI
 Laz1cBfuupAyB/5McYp6exWUZOjz6oS2m1mWxV4iroOILBqqStDDgepHlzg0QisV2zGYObNZ
X-Proofpoint-GUID: kb52hhgoOVgxlBnOL8PxXXpaHxA3fzLd
X-Proofpoint-ORIG-GUID: kb52hhgoOVgxlBnOL8PxXXpaHxA3fzLd
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687a6e4d cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=e06P08YCo0CmzbESZgoA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=814 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180123

The SM8550 has switched to RPMHPD_* indices for RPMh power domains,
however commit e271b59e39a6 ("arm64: dts: qcom: sm8550: Add camera clock
controller") brought some more old-style indices. Convert all of them to
use common RPMh PD indices.

Fixes: e271b59e39a6 ("arm64: dts: qcom: sm8550: Add camera clock controller")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 45713d46f3c52487d2638b7ab194c111f58679ce..a4ca06679c2f1eebacdd5938e380981c1b17925b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3623,7 +3623,7 @@ camcc: clock-controller@ade0000 {
 				 <&bi_tcxo_div2>,
 				 <&bi_tcxo_ao_div2>,
 				 <&sleep_clk>;
-			power-domains = <&rpmhpd SM8550_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;

-- 
2.39.5


