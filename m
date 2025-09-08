Return-Path: <linux-kernel+bounces-805292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F3B48684
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520893B12A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBF2EA472;
	Mon,  8 Sep 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hz7rxv8m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A82E62A4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319619; cv=none; b=Nqoi1jwDgxTqOMxZWHO1Jnz6K7Eoz9sJQP8wdNs3wZAW8IiEzw5fRIgkmyMw1SsgLCMkh1yKqjBTCVbRCi2cu0ZQ2H97qTB2hQNJL2HUbMqNLSPdJza89Dkn9TMTiN3e8YHa9ioTQqu1l+bTrimBYha7X7DPPBnXYUrpjDIrcRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319619; c=relaxed/simple;
	bh=orOKlPtQLn5AGPhNEQlHkVZYfkJ9hhPyxvhObhS2CkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBqEtIXMSp922gyRUaMD8xEIj1JyDrqII9BG9kPuyK7boVC4uLBWMhmQgB8skubdxGj8WxUj6ZkSTPJ+0zH8jNxXQnFHxO3bMxIyySYo/wJWhU4L/dKBRlqiLuxf2eYBZgwM35fU11f2zHptgcYxtVfwIWu+hSwlriLHiWNSNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hz7rxv8m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LwK8F020507
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uiQp9Gtm65Pdl4W6k0WxVxnFve96qzLdksXdOVeH1VU=; b=Hz7rxv8mmA3JvVJV
	CS3ADwafbY16xoZwLnciGXlSLw+pIRijKLqJ824/Cu2xMrLwLTsAh3PUAUqg2V/S
	r0uC3UEkkYOc9Lr77+YbRnzyAOCTAKHQgTPboFwUUpa3eI8errnpSXlIkv5KjnEv
	LtTkq4sbyTvIigTM+RJeMlOaIIGFkF43z43iA+Z7viP/3PWufYo21sV3Fcy9YPgA
	fEgXoNrgoa47Qoh7/NnOWPnNc+0jL78ZcRtkWorA9wcVIYwjCamN0pDe0wh+JRjN
	Ou4tWX4YKhdqKGQYeOVCKJ9Oh9ys9wuEFuBzDyWSV9IkG6yKKn80rgOu2odBp+R2
	yKvv+w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1vbtkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:20:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24c8264a137so52388665ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319615; x=1757924415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiQp9Gtm65Pdl4W6k0WxVxnFve96qzLdksXdOVeH1VU=;
        b=mrOon+x323yJECjPsY8NUaOxK3YiX8i6G4V8Lct2DlVzfKPKcQtF82tbH7YbYy/YjY
         UujcqnkWlbz7QIIaewLC5UpdcIaqSKDKygO4xcV6IMPnMYJbHOhF4wn5/Ey6e2KoHNHq
         2tLjvzPqo5V+VB3PEfiz0U8OIy5DPfxWJcQQYJaXsgZlX1DiVMJYqnxyMWf6SDi4X8MF
         /ZDZeprz7Db6QMNASTpxc8Eha8EfMP9hqmNjcQj7Ce2q+BoLaL9FpnFs4MZ/zHTsK13k
         Kp72UDgoRPGGuU75pQGUknu3kMDr4pP7bxXA8fW0cI2JvNyyP8hdhNa/R7et7INI7fiR
         tHCA==
X-Forwarded-Encrypted: i=1; AJvYcCUYfUJHtDYFcGIeZCE/TTNJbMU/2+w5ADL5yolUVnkpsM8P2wpLdvkAlLddze3xyj/brZNm8C+bmxpwtPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKhxuPS9seaLNA/dmLTHbvECw5bzLFVnXIz+hDubQkDq7tFPS
	LJRGxhgH0lzqB9j5byhnq1CuR5uVhbBblMgpIrGZXtILpD++39M7mZ5mWpBQhY9BaAkyL6fJWuk
	PObCQEQFrl3a3URDskHM4DCvuOro1d1pRFTqjVWGKfmUGq9b81OuBi2Z4dm1qPTJYOqQ=
X-Gm-Gg: ASbGnctZk11G7ZSy38zDfBiBGv+MyXMIjmMErP3pyNGVs0TTdmqj3lSwyDxQ0VunxWO
	QUiqztaZ/6esoVTzx+tHoedFguDLst/pbTUsDoBANq0w5RB2CYYpRtM6/aPZ87Gm4tQXpO8Jj0G
	sMu9TEnkrPdehxx9+HIYXgalhpqwB5aXXngjssXuJ3E2WjznDm5WJ6F2L5zhrC9I+AUlNwCs7U+
	+m4SXFcAnpApMWyPEL6X+HDr7SFxYQPR9Stst5nqLcNT+wyGPnNF1CTCdML9KGVWhriTvYF2j4j
	PZb3FaPtm2R9gVIVwWSLxkNkvl4dNP6xN73Qbg76bgAYO46tUjH/GqRDkNv5W18kO9T5
X-Received: by 2002:a17:902:eccf:b0:24e:47ea:9519 with SMTP id d9443c01a7336-251718ddac9mr98887355ad.47.1757319614674;
        Mon, 08 Sep 2025 01:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1vovZ9gkQhZX2rd/L1KkPL3qlKIyszAECpRN309/lL9U00EjRsbkgJQyBobjrCkcpgK0uuA==
X-Received: by 2002:a17:902:eccf:b0:24e:47ea:9519 with SMTP id d9443c01a7336-251718ddac9mr98886925ad.47.1757319614225;
        Mon, 08 Sep 2025 01:20:14 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:14 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:51 +0530
Subject: [PATCH v4 01/14] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-1-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1254;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=v81wxg2XnsrITbgpwYn82teoXJQ/l0LPAItmU3R1jlg=;
 b=+5W9XDqLZ3HvskV0J+JhX/1XQy4z2UoMFE1DFgGDiojtHaS1/WyS2D/FlKi2vbAuaFXMThdCo
 qIZCasUOKXmAzeHCr4KNp9eFh0u7hWlbVQvGhT57cjHSkNuYspnI91N
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: -BO6tE1Me_eplyrPCkJpt2xsB38o6lVj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfXwv+WssNKUAe8
 ECMuV7yrTsKVFhPoJwo1Wbfj85Am/5GYyESUPy+IqESDxMP7y2iewBlg+BBwMg9xlb3jisG29Zm
 8UsDO0xtCRueKLSEbQ8E4ZqwWqMuB4nPZdg2TMnT8Peg5fLlbk1q/KCJDsBzgh06VsOzssNKh4a
 U90x78i02ULjfKXQ3mKZFj6JywmUnUmcBr29r7nQnkb5SIyNaAuRLFqzY+DOHm0cIj+3E/mo7So
 E1YrMn0aRVKNkMR6Ew2yGgkgghgs8YjWVHBXmywTzOEX1Zz39uNIpEy9JKZG7u7k670qgCdSHsX
 gnkI1oyOh5Y3CmwZtNG/v+gAe//REdcQxPBKVXufD5yheleT/r0Jfp1ewDeRN1dXyXCJZnuoz5u
 erJxeYZT
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68be91c0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=oyqPBBxx3V5-Y59TF94A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -BO6tE1Me_eplyrPCkJpt2xsB38o6lVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027

From: Monish Chunara <quic_mchunara@quicinc.com>

Add the MSM SDHCI compatible name to support both eMMC and SD card for
Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
compatible string matches existing Lemans-compatible formats without
introducing a new naming convention.

The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 22d1f50c3fd1..594bd174ff21 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -48,6 +48,7 @@ properties:
               - qcom,qcs615-sdhci
               - qcom,qcs8300-sdhci
               - qcom,qdu1000-sdhci
+              - qcom,sa8775p-sdhci
               - qcom,sar2130p-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci

-- 
2.51.0


