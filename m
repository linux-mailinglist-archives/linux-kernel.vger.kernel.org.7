Return-Path: <linux-kernel+bounces-785402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF5B34A24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5D43B81FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D869A311955;
	Mon, 25 Aug 2025 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DjOyVg57"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453A309DB0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145976; cv=none; b=d3SupDx0TbhmelwUVBbDuZc1Jr5GbemWKxo5yjgCezOTyEpyfMgEu9/e2iEW99WRJn0Nxm1SRJrmXqbuEnbtSg52oP6E38A/eVR2Lt9CiHez7jlc+5d5WweOAwQRiMfX6I6LdGQW5RMNz/WbZoBmdvLMgsSDItM8qyB95xC7hPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145976; c=relaxed/simple;
	bh=Z0kZ7CUuc3z5own5uSJ060FKIchIKAXnRIi1NENCfjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmS9pfav1WmFUG4Rz4zrLlo9SBywehI8awJrD69h8zLUKP+/czeDkNTKdPUcd/EB2nAdC53ji+wmMf5fBriMfrNhOJGDuhjoy9/xbLT8XumkrBTRoXrWK30DJbR0JGgSOQT8VTShqqtTSE6L6QzhiRIp50KZpH8xhB0scIz5uhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DjOyVg57; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PGQuja032292
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W9N/u7K2gXkeEvZixNyEyu8saL0lvRgYaWEIkCSty2s=; b=DjOyVg57Y5WJcakb
	hjcSoI5aFBFhGvwmLUnVgQy6WyPIo6N/nHcfn7wJl7fCGH572FlaFG3tnF29x8Z6
	phzKNeGbtlC0Y8HZlk92sZuy3LuLAMQDiXHKHy4eUnNtsm/PnaTjIlS+vxk04H0N
	H/gPcQyV7INz/+qC85siDGvzR3NugzgcNTBfeTp/fKHvAGCywwLk+AkaRLKlak5D
	A1/GJmIyQbmwTdt8ncP+d3zjfCLkVPU3rOt8y8CYJ5mBBbB1eBN2CezQ0MT7zeO7
	0rYLAQV3K6M/27Zig+u7/9RyVyGn+350qcL7+stYIZ1z0jYTUAtxsATzwhzicsqf
	Rt0k2w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5wdx021-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-246266f9ae1so33772465ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145972; x=1756750772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9N/u7K2gXkeEvZixNyEyu8saL0lvRgYaWEIkCSty2s=;
        b=LkdqbqH5IoVG8zRvqQ/4DaBpEdi5nfD8xWNF0pjcd3iU5305p5/3f8efO5w+tBPzDX
         74SG+JEe80e0EYFvAMLkj6njBqdtR4dSdTfmmh18QKnL3EVD5nY9ykHIgH8bc1+76x4g
         M2haAiE8UImbFqsDa5stDR4I2nvT9+Bip8G/0e6IDHZZxeI5XDDFPmfgEwsGsOebiX44
         PyaNw/A96beaxzyqWbyE6WaF2pjGsT55hratmtM5XRdLkjbBPkBWwjzScjwWtKS13r0B
         EZXSxQf6TOaqo4uTm6QhGzBBaF17GJSOF+x8ZIPXvbJC/OTVLU8ZUzPFlMBvkpR1ZFk0
         L7TA==
X-Forwarded-Encrypted: i=1; AJvYcCVBSmnzwxQ84Bnfl/0bD4DfQqj+iga96K5R0MQttUynWik3QbzoKsY+/6JU7wdaIR/3tiRJaEkyUThjCEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zJU7V7pUloe8Q6fTeUfcSqydtwhsVMAjBmfmwNr3tydc43QD
	Y+fLIhNO0jmyjf40lobn5SRvFJc57zejOjN+LXuwAwXiNmDlE4hCRsK7oCKusiQcmIWbDr+xD63
	e3Yve2cFjtUo1JdjxADXTGbCQ6ihRoc9pRQoYzPMvisaJSuvIh5IcQAG8sdYzzJ+1rXO+1q+VGg
	8=
X-Gm-Gg: ASbGnct30syzfmClbQO/7jrt2LTS5n/1zRkO9gIWoxZBzde3oT62OZeiey3luwWatol
	ORHUUVqAqpJcO4NpR8bRWNoR3mfcbIPJ9aJ6t5TnlrOImhEhhWgumM7a4uSqBdwKcIobudoLQmE
	fKjuPxRtWJZYzCGypFNj81OVwRdHlDJuE8OPOUjmXC9xvhl/v1t15W4nrZtT12Pr1odJUXTa+IB
	V7nGqv29kJsKRUqYPVxxxmaIjuEmsj22Wx1xu/OvAhbbwoQy/9VC/E6thWudoHTCqXR3ktROc45
	3e2v9UzHBNjwBmgdALcE0nH84y8iq1rSA2so+Y0uzq1u/9RAiSqc7ngEdiCkuwqX
X-Received: by 2002:a17:902:d48e:b0:246:441f:f144 with SMTP id d9443c01a7336-246441ff51fmr170733565ad.56.1756145971615;
        Mon, 25 Aug 2025 11:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoHCXN0pnoD1hQs4BeT0/dzqTl6jh6CQ/sTZS7KdstHbNbmX2M9g1BYidj1V41oZ6kgYySsA==
X-Received: by 2002:a17:902:d48e:b0:246:441f:f144 with SMTP id d9443c01a7336-246441ff51fmr170733205ad.56.1756145971129;
        Mon, 25 Aug 2025 11:19:31 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688647acsm74174015ad.87.2025.08.25.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:19:30 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 23:49:08 +0530
Subject: [PATCH v5 1/7] dt-bindings: clock: qcom-rpmhcc: Add support for
 Glymur SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-glymur-clock-controller-v5-v5-1-01b8c8681bcd@oss.qualcomm.com>
References: <20250825-glymur-clock-controller-v5-v5-0-01b8c8681bcd@oss.qualcomm.com>
In-Reply-To: <20250825-glymur-clock-controller-v5-v5-0-01b8c8681bcd@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: k7oPMPt-M-qXFvjhVGCNlouQ78qyUb9v
X-Proofpoint-ORIG-GUID: k7oPMPt-M-qXFvjhVGCNlouQ78qyUb9v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX7bBA/LUfNut8
 dCNmw4teZOUKpfogIWem2Y/1QPWm0qrD62GS104SkK4n+Vs4UIqlkBk6wxC5Z45Glr/sbr3+IF9
 05lkriUivjQA36G9IMzrhvMf/ngMgmfCW01pXmZa+buzLvHuH0Lcj9d8zDyHnD9pxhPwNeA+D98
 RGo8Drmz8qRTE9MCFbAbeCB+duOGPpxoD1+t2k+ocLhoK5btP/Q5/0i7uIo2U/EWSgG4k8G8WUv
 HiYgX4ZFq2VcmiwpSE/XcZam7IOWGvy9wOV8b19jOnUDw+ilfmeNhqTFr2RbzkL9zlA0TU9fPGq
 HxcXr69iGKepas/CUKIy5ZY+Fb861y9en8g33xwZbYN9c9ywZ6YAi6BcOfUcZ925YliGV3ZdRRt
 JZaq20HR
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68aca935 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VCPuoYa76ZImaTyFhsgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

Add bindings and update documentation compatible for RPMh clock
controller on Glymur SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index a4414ba0b287b23e69a913d10befa5d7368ff08b..78fa0572668578c17474e84250fed18b48b93b68 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -17,6 +17,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,glymur-rpmh-clk
       - qcom,milos-rpmh-clk
       - qcom,qcs615-rpmh-clk
       - qcom,qdu1000-rpmh-clk

-- 
2.34.1


