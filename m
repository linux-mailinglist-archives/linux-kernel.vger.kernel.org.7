Return-Path: <linux-kernel+bounces-737136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC5AB0A834
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA8F1C815FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E42E62AC;
	Fri, 18 Jul 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4JCJR3S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA72E6137
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855233; cv=none; b=gAl8N3U5M5x/l8mQIca9lGf58OTnSQPC3baYWMDAUbWsEQ4Lu71fEfiAopXKobW1VJt4jXbxxhMIrtfnAO6coihfmE+WOYnqjBciT6sGUywfVkcYPOR5IPjfIQWWKxqehdsJ//s2/FsKG4OlME6E+GMtVb5ZBAXH3ubmb+0Lcgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855233; c=relaxed/simple;
	bh=jnQej5os8946OtwsAYxWV5AqWfH0NVCPXeIuQ2kik1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pIC2Qp3Z9Lgi+3wO14ycy7AReYNJIyNE027ywGrbmB44UD4Y4LN/h4uBoKpn5hdrvparpMDMy247Pu/4oqgtM8NUtd7ZlEN4ewvJ1HGqyYeEZFnK0QOrgjPQQMNuTb+x6iPyZJm2iF2n3PwbtG5P5PMVY8lCDpihGaa4WCmtxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4JCJR3S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I87PYW011166
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=E2+mYONdTWwAKa/b2Dnjv7
	gT1I0AopAtzO+8co3bDc4=; b=H4JCJR3SXw9tgn0jFSQ5nadXmD0sTfvO33FeTC
	xkfh5XGBEmDujfKzTA5bMnAmG5Ulv0jyGvCevfwmHKoWpXjjAm/4ng3/dBAtlHy8
	fXnvStcAJWLpDeStFDUL5b3tZLKgJMwKj2+8EYZ9t569nddutkEkmWTjHCBQKekl
	YTPqrhSxc9uFxgvQDSZowyjcXVbjGUytVvTHk1t93YwZtV18n4CAfLQDI0ukqG02
	l2OvLbQsuhE5RDzF9Y+u3GD6qZ2vVsKZpD3jzSSEtEpoYMcN7sV7R5DWDtcK7Ejs
	+hO5ebj+NecfXcjO/nYYv91mk1VdOFt9E7xx2ChLivO8s5og==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh64f1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:13:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e33af599bcso376061385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855229; x=1753460029;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2+mYONdTWwAKa/b2Dnjv7gT1I0AopAtzO+8co3bDc4=;
        b=Fx+CjLFKMsVSuO5M8fz+BMmSBXfXzp+DQBJaTqh49F9k8j3Tf1eQinmCj0xS7Ggj1R
         kYDq4b1GmoC8iVvW5j7sdTICH6+aYPKZg6xleS5zzKFql1JdF6OdeZ1E7sgJHpo9c7da
         zXzbj5onWZg4ldABFdkvw1faVueIyFVn5aU7POkn/0nhD1kbxcCvP+UUz+Cn1LQU1KFo
         9yMyZmhRuov8XDm9FQrgGXiBuU9QdAUqr8zwGqztYI2+7xTnEeoan6HBsxamHcCy+kYH
         keyiNEzMZHgFwIkQFW4TWuZm183sYecInI71fSVbe8FHo0pdU/MgV4Ob2BKcqRrV5le/
         8jww==
X-Forwarded-Encrypted: i=1; AJvYcCUnaoYk3SGeB+Yo38A4Fuafj9FMkXMnBni/gSfax20qhPIGna1qsmiuFwrOySy5bItH3Js9vNx5dyQD8oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQkLhveOdTr2+69tIvZIs+pbd57AcDSaDk7o6GKdkh4xK+2El
	wYm7Al38h890HxjgeEtAgYAY2h/VtpkfPqdhHTzuwVO1uH5DMpefHSGXvIHz1/Y1ZijTNvOKaPh
	CQz0LlGVF7U7CpqLDEJ12dYlufCSVAFN4XP5r5Jk4Y07RxInYkKoLzoDBI133CtJ/Sc4=
X-Gm-Gg: ASbGncsN9i7n9l7n4+MEFjOKajWZYWsTU3UBkeVxrYxRedLQvrfU6LVYljnHv4acbVQ
	1CDYSDnaWy7n+dd/f6WRDSZCiZ1O/DsT+vVvVcsdceyQVggKihBDfs9/6rp3JQZFZO7YYNbbz2z
	GzVqV1qeR8wXQaHsN6A6k2j2FB2/pLH5i7PL0qxCkaoWvlbqbKLsUEMI8qQvB+CzbylRRYsyFLE
	+7e6Z7bzNjvZ21F8SzuFqZvEQ6JHEtevMDF+2aAcTTQIgTfEnY7H/kNEyprjhQRRS239Qczqe7Z
	x+NnOzk3P+KBs6zLdfCTd2YlZG3yKU4NCbxgbw99G/mjASBUA+FXxxeH03Vw7D0FNYDajZ496dN
	ELCqIIO9WBwlxHDQzX+H4hb9y2pY+cn0RXChE9bvQrAQyAw5udGKn
X-Received: by 2002:a05:620a:8509:b0:7e3:35e3:3412 with SMTP id af79cd13be357-7e34d9ac2e5mr622295585a.34.1752855226582;
        Fri, 18 Jul 2025 09:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJFME1iu2nBdlZCEndMtUjbp0cqubsgTDnznr23GMq/CHMfz0nkUvr0ssMwdhTZk5t9cEtiA==
X-Received: by 2002:a05:620a:8509:b0:7e3:35e3:3412 with SMTP id af79cd13be357-7e34d9ac2e5mr622289885a.34.1752855225796;
        Fri, 18 Jul 2025 09:13:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/8] pmdomain: qcom: sort out RPMh and RPM power domain
 indices
Date: Fri, 18 Jul 2025 19:13:38 +0300
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJyemgC/yWM2wqDMBBEfyXsc0OTiAj+SvEhJtu6lFy6ia0g/
 nvT+jLDGZizQ0EmLDCKHRjfVCjFBvoiwC02PlCSbwxGmV4NepCMn8RPyTks2f+qpe663lit3Ox
 7aM/MeKftb71NJzO+1iav5wizLShdCoHqKCJu9RpsqcgwHccXYpV3FZQAAAA=
X-Change-ID: 20250717-rework-rpmhpd-rpmpd-13352a10cbd5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jnQej5os8946OtwsAYxWV5AqWfH0NVCPXeIuQ2kik1I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK2X/4FUMKR/6O9sQRhqyVPR9hRSX6jxmwhn
 gheSKljeAiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytgAKCRCLPIo+Aiko
 1WBDB/93DGP5KNuZts9BxHzohRG1Am3sPtjk5P93zmsB/JMqiWqKOM/hgbgj5r+UBDA8tyf+e2S
 eBGQrnJ6eZ3ybThugmU5ZTY8qq3d4TKf5hWv3P7bufQoeu0FWwMJNcg4nmSGxlrPWslux4byiRl
 86v7dmjWxDRHZkT6CtDTUVi+XyjMjCeIvssj0pR5GHfYMh8Y6JBV0daf0me7Sec1keBlgb6BboW
 DAr1H8ykZzXcebSMtffH3PEY36WiCxRAngEjpl+CcCQIVJNsRCgr2MA/7TOT09cFJZFqYaGa3sD
 O1EZUeyToT0ck7XzZCHFx0gcP1/M8gaCwNqEc5OheEDt7Y9U
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=687a72be cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gAiK-lJt_Rg5ifV0ZIAA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: -EGRJGaoJNfAf83DsMMAFTlem1W2_uH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyNiBTYWx0ZWRfX3XEosQJCRyfS
 +4eJsYpBdaC2bDD5pt7sNlZri3spxcPDvqB2xnRR8Hatd1mHzoAu5rAJRwtIiMUcE4hnWVL8G7w
 lFiyciGOlnpElDTkdWqhSLtC9Rsosmad2UhGtQfgoN1CKZBhbH+LscoVRxLoYez4Om13aCWKCnL
 RCcQHnv+mV6oA/+RH2igGFBL6M7TZv3y2JzKB609bFKz/tH8Ql+ek0+0kM5HY3W9lRwocr6whOC
 JbFGGbzwKfuwVAesCPd1P/1UAHKfA+AUgD/W0HTLelb4f+MC/VdYs6bdGQV7JSNdDy/KncMQGz0
 l0TGvk1AOF2YbPU+gQr98u4zUHltnSKHHv9ZHyHp7Yng1Uq0SlEiFJrm1JwDVq3Z9FG9vCRpn0D
 D7hOYQjx/WnTpxdHQbfNEHfofTRO1nPnhBKQM4o9hoeHLxfIrBTgR5V7Ef3ABFVakUoAVazL
X-Proofpoint-ORIG-GUID: -EGRJGaoJNfAf83DsMMAFTlem1W2_uH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=708 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180126

- Separate RPMh power domain bindings from RPM PD bindings

- Drop now-unused (after [1] is merged) binding indices for RPMh
  platforms

- Introduce generic bindings for RPM power domains controller

Two last patches (marked as [DO NOT MERGE]) should only be merged after
corresponding DT cleanup lands ([1] and DTS parts of this patchset).

[1] https://lore.kernel.org/r/20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (8):
      dt-bindings: power: qcom-rpmpd: split RPMh domains definitions
      dt-bindings: power: qcom-rpmpd: sort out entries
      dt-bindings: power: qcom-rpmpd: add generic bindings for RPM power domains
      pmdomain: qcom: rpmpd: switch to RPMPD_* indices
      arm64: dts: qcom: dts: switch to RPMPD_* indices
      ARM: dts: qcom: dts: switch to RPMPD_* indices
      [DO NOT MERGE] dt-bindings: power: qcom-rpmpd: drop compatibility defines
      [DO NOT MERGE] dt-bindings: power: qcom,rpmhpd: drop duplicate defines

 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi |   4 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi    |   8 +-
 arch/arm64/boot/dts/qcom/msm8917.dtsi    |  10 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi    |   4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi    |  16 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi     |  16 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi     |  12 +-
 drivers/pmdomain/qcom/rpmpd.c            | 112 ++++-----
 include/dt-bindings/power/qcom,rpmhpd.h  | 175 +++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h   | 375 ++++---------------------------
 10 files changed, 306 insertions(+), 426 deletions(-)
---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250717-rework-rpmhpd-rpmpd-13352a10cbd5

Best regards,
-- 
With best wishes
Dmitry


