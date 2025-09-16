Return-Path: <linux-kernel+bounces-818316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5D6B58FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F145525DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F6E2857E9;
	Tue, 16 Sep 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iABD70tt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1F2848A4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009525; cv=none; b=s2Y/zx3LJmYX6MDyaLShEZKa2XCurPhuNC/YgOH23/Aa05d4hctE7KIKr45M0bOj0f9aq4c+mYyg/RSYikunI1dzk/pq7xItRcU+Bxd2M/l05IUuYvkNXIFFeIMPcB0vRyMFOrRkhy/y0C2tYzcVWCAodmGerkW/7kuOdyg7TLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009525; c=relaxed/simple;
	bh=zylmmscsnfAs5OtV0ch3oQtaSHtRLKMkmNf4bkdCBHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdO+2GxjzI5Ybj35qs7T5jCXo0dOYZMY/tbcwFtelJSIBXmVvbaA8BH8sKEzOQDmMIfFg81tmKOy8tDdCsk4kjc0zsHW3rH8bussDpsIYhfOPSBIcyPzTAbo5tBgCeU6+XVX9dhExC3hpxyVS2q9M1YB1Knn+XMgoGovbsY9z2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iABD70tt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pl3R005242
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ot8w2T4cQuPGEePCaHCyKU6VR0cRvcl1EFBEGB7W5yo=; b=iABD70ttfChR3d6Y
	HgQavt7UtBhOmfLgr6+ig6ywP5XwOu4Tf+eUv0e6dCfnQcc3rSizG9DGw/ARBrNk
	Y8nJO8Br4PXJtdJ6ZbIylGagbS+8fGYm53Fr3TtarbLsLerU06iUbGvfczrbRo1v
	/50ik/e7jxu2xE41VB8eSeqFp61pJYo5mvmKLF5GBCx+wVFtpOTfTZithWl4af0q
	Mr2yBBhyzTeX8vEXWl8XBQ66sSEXF7hg3AckR9Fh1daQD4rIYpnFrZvrvb3d4XyY
	6BmVMrG2xNKz6SJ2NPSZwhcc7S7nUriCV622B5lkv4aTnhjifN74mvfRQcTsVpw4
	BVTSCA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n3m3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:58:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so4993070b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009522; x=1758614322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot8w2T4cQuPGEePCaHCyKU6VR0cRvcl1EFBEGB7W5yo=;
        b=k5rFOYrK7Rr8zP+oSoZCLpruv0ZiAAg2mvrlMttfCHfPoUwgJzOmWzmGh8PLbQDKam
         wVj+4iDq8AO7TUKzEiD4C0JmZEKKuKwbeswwrtsWrp7P9PUvjtUJsu4tEKvqwssCBLHE
         GvFGdL2W5rPI6MY+xsAWhL+FkGUIi6dOs7M1c338yHubv26V9H4nWoLQAYT89RANXEcM
         DHQMwfRzE8Gckg2u/5CcfoPcRroc5N4TF6/+KY9bEJmqplrJrE3EntOWxMY8tnS6ndvm
         d6Sqv1bYURHqiUjjswPCbHEB59Cfwrsh+sQsRTgqfvjO/kvRl0vr2z95YvrWCn8Amv5S
         5LVA==
X-Forwarded-Encrypted: i=1; AJvYcCW1cwy3optczOuOD/Sn6iVpI3SywnjEB507NkuBPMDasLPwADXHx+eAcW0Ggm+500Ay8PC97fGedO5scFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygYxrwpPUzqYyGXBXohW0T/o3dh+DGRN0ZvsV7nXE4NYj/tJ0y
	E2ax9Hu2xsHH6hoYrtgeYNb4ywN5Z80w/AP9hALuVGu+dVeDoP/AWzqD9jPnskPjd7s/7zWy1s0
	mmCwOnr6F2XloopRlfh5VOQADqgMRV2nK81BQ+ZdVkotKxFrFy91xvQDLId+zhyO6Rfyd6H5i8W
	Y=
X-Gm-Gg: ASbGncshFGFeIATM+jqdL0/BNDxVYFVi4L7LSpd3qbHlInRnbnZIvVb9v0iiIpYkD1R
	6GwQmvLBOnNLe4YcH+KYZz1Wwfwx2kKeE85Y4kqWruN7T1hzcyIkRSD8fdgt4IslCO3Di3k+VB8
	LRaBVKqfP4CMfNX2XZf82HaNyLxZmZab+6Ok0sE5kidj38q3gqXVecdHlvIvay5iCJKrI8tomhz
	9i5GwUtNC+uxmrdDZuZcflKH//lCWeS7mcthT6UObFZ3dNDm3Fzj2UhaXY+Ju+Aefd8WPrpUdBG
	Wu3FbXMMQrqUIrFP+voi2avJEvwjPguI19O7Fdvr8uM/lMbWm31VzdV6h+ODQAIpSXpV0CECk28
	DRM4fsiCrbsfDj08kozY6uO8ubw==
X-Received: by 2002:a05:6a00:928b:b0:771:e1bf:bddc with SMTP id d2e1a72fcca58-7761208d656mr16834714b3a.13.1758009522146;
        Tue, 16 Sep 2025 00:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKdHClzzvHyazfnyBj58lGy8nWw5lRZsRQKuhdPh9d1u2cuL43JD3iU1uvQJq5lIa6GOXV1A==
X-Received: by 2002:a05:6a00:928b:b0:771:e1bf:bddc with SMTP id d2e1a72fcca58-7761208d656mr16834669b3a.13.1758009521616;
        Tue, 16 Sep 2025 00:58:41 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761af2e09dsm11292222b3a.76.2025.09.16.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:58:41 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 13:28:16 +0530
Subject: [PATCH 2/4] dt-bindings: rpmh-regulator: Update pmic-id property
 info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-glymur-rpmh-regulator-driver-v1-2-bb9b00e93a61@oss.qualcomm.com>
References: <20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com>
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758009510; l=1081;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=zylmmscsnfAs5OtV0ch3oQtaSHtRLKMkmNf4bkdCBHA=;
 b=vEZhDtXr0Mqqp+NUVl5eEuLTfBqEdDHfRiv322bCrWfCiAWuhpP6nlIrhN9pT1/r+gK21uA1D
 OkUw730yfSFA10uH3vbyBoaxWGmJx1J9aLjIoJTjLR6IEQJWmcGCqxv
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-GUID: Nk2G1-14HXaFALkg19XPAuGKPwrM6z5h
X-Proofpoint-ORIG-GUID: Nk2G1-14HXaFALkg19XPAuGKPwrM6z5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX89Lo876YLbsr
 Yr7gVjyYypbc2XnTthpxhfDqOBztqmJ+hk30i663GzHT0J8+BOdC00fRBG38x013ZH5vIn0kn7e
 9bqnsADoWcNW9U/N+bXsLxeEDWIf80uq821mYDPRn0dPRlfIdwxwXHqD9LLF2jpUavByMcYGB1K
 QLCn04QUlPwdQSNnJBDUam+5ZAqvlL9bofiKlTFSEOSmb1QpOlpiaOrxmlJw3LWT+S2SXPwVMu9
 8ooiPp5fWz8qMFEvdO/a16xUDmR3IX48W8OWdFFK5jqOmMId7sN7jsfFv3Qz924HaPpl/F/LaJM
 CdFiTmKca826BpTqetLy/Vz/CjsOX4XBmLGCeaY201lN+8jKsik8ZpRNmKOxrEPKzC0LibnsCUb
 7Pb4Qo1o
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c918b3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B3qX-pFcB6t4li0ik0cA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

On new targets like Glymur, `pmic-id` will have this new
format `[A-N]_E[0-3]`. Update the property description to
reflect this information.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 40e57b10ebbebeff130871b6d978df64111b6f29..40ddc64577e78b5c0dbb7b4e8893a08e8b37c92e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -108,7 +108,7 @@ properties:
         RPMh resource name suffix used for the regulators found
         on this PMIC.
     $ref: /schemas/types.yaml#/definitions/string
-    enum: [a, b, c, d, e, f, g, h, i, j, k, l, m, n]
+    pattern: "^[a-n]|[A-N]_E[0-3]+$"
 
   qcom,always-wait-for-ack:
     description: |

-- 
2.25.1


