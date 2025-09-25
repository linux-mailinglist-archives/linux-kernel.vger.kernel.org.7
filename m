Return-Path: <linux-kernel+bounces-831804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D341CB9D969
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4C019C3B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5EA2E92B5;
	Thu, 25 Sep 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UF8p0t0o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33362E8DEC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781746; cv=none; b=DzcQR6BTK3gCN/RnOnth9Aoqsz4H8NNInpLTnkPd1yEHYVP4YC2HpqMxU1dKOxM34UthhCSRBKMRIDeC1Ui/0lQgmcsMmw4Imh67evP8AOttTgEG3cLT8ADTIT7F8yP8WJIgTygQb32Bxza9/p2M1hUnCnHLCMn5Q3vtz8sxC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781746; c=relaxed/simple;
	bh=PmOpw/EYlFkARbCMNbiM/N6wPtAmStKVwZu0bN0uBRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKI5hrxNb9Lj34uVtw37JpNKerXVwXy7k6h1fmWxpcP4Lg/Z2nImS6rxdZ4mESbp+kThAVfCyNwCpviWvcTAgkQ+16wJry7GH47Gx/b/3TPOL41pMq1xIbYcTlEH2jUUeuaV0uhxxlH18ECl58wDCD3a/wWXnGa2h4cjxMogpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UF8p0t0o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P11NNm024516
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	syumanWrZUjcI1O0TLXpaU3G8S6LULiW8Zo6+Nj/zZI=; b=UF8p0t0ocvyoPbV9
	qWJSKLFyo/uCn2OzOdcxX6qpu4AQakYpYJGc9PDFgXR7ccMMfYZDl25eL6DKBOh1
	CYdbscH//jYbP9Z1vzg6C1xmC/89GglNgo7xT55HwLKLyET/886XNz2X0a1ytl9R
	33Lfm+um4rbXxhyTNOdLXEzp5PR0FsQA8sodPsIlhD9q7qVs23sn+a457pc8FzfM
	2Yr3Rk1mfJ7IpVih1ufTelCoc8U7cw5AnZNrvaTKGmFpuUulmegSOfsn134QxbkT
	N1jKwGwMbaZ0il0RCjSYHOdWVxrU7E+H+SVuY9TvhieMH2efO3oRKD60v8+rr76M
	ewo22Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0e1sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780d26fb6b4so564905b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781742; x=1759386542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syumanWrZUjcI1O0TLXpaU3G8S6LULiW8Zo6+Nj/zZI=;
        b=qh6qsHbhR1Z/u2RTE3UfKzhbMIg0c01VvFSqxSc7nyxg+Aux+m80XOmbZsnm0WNxls
         FEkHjAzShnnQy168vOL0LaJr2BRQwY/YJICt/mV2wod6K8IvavGh2uN10ujms5jflb3c
         pvyBwGqJuZA/dr6MGN0/iSRagkuS5BJHdZ0dOU3V35JSBwsSkwTnkjC6ioNInyFGVCug
         n6l01jnVUyj123JP8cnfP4+WkN7FQ+M7kTs+9WJRDZ1mqsHOxmP8czA/m/BC3el+0rRc
         cfIQOGsdvKp+TcZ99Ss5aViN4D3ob/x0cmkd1nHXzFjjHge9QT4eB511WwDcMXMf8acq
         eauA==
X-Forwarded-Encrypted: i=1; AJvYcCWbQxHYsitIMbSyJL2LFjFGMP91hLBQCj1H7yOOF5flKGzfD5UuK0DUa70+QKRIIwJQuvn8fbqZ7K0ZS6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvvckyDFby6H9H2O/OT/gRFjFsNkAwKLg1H7ht9OFR1WYT8Sw
	0aHc4eQkwU4ObOnUmSsZMZZ8tpU7lpeKKLLJir+inI02nP2G90RtmDLZELa0GOCyQROiNHTP+uC
	ds4AUt47TI6RI5WoDzMvDd39iloTcpZ8pVfuPh+IsC9ZjmqfHRaat5heMovGbrAOdIWU=
X-Gm-Gg: ASbGnctcB1tvsAgQxDVd8N02VOo0p2bDqDh1aaQhp2aAOzcmOH/BYz1Ozr58sDUfMDR
	er4442y9hU8S4nqpMLIDeswdDJrcKEIYRgtwVL/3Rfd72GMhdZsGtAAHyTHlJLx3nKpXfz9sRku
	DibJlgrrnJHQByPRNVxSdGX1ZnAFNAnH+ORM5f3qmKD+LTeNgodcaeAuBt97T74wC2Z7qpGCU8q
	l4aRnjk7lUJtf/Bky3Y0ubIZgDxhP21VFzwXzy7QM1jij8t8YIRUGNRMtfaxDqbXaq/JNKEi5Xb
	j6RSvgS5hbCfE6J8E/7Q0ioo6sCXv9LGXVhNv0cZzp3/UFDLP/cveOTkrG/PNgzos5B44t+z1B7
	J5sPHpOdqmVi5ewYMLIVEpgxQHoD9Ak+NNaRno2KYO5UKFOArfkQkJidrWw1c
X-Received: by 2002:a05:6a00:4654:b0:772:823b:78a4 with SMTP id d2e1a72fcca58-780fce2cc33mr2678490b3a.13.1758781742007;
        Wed, 24 Sep 2025 23:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf5M3AmpXjWH3ZY4yFT1pbvy9PyWNjSVRiqBempmGBotHIOY10SAhH6iTuflkNvEtRrydS6g==
X-Received: by 2002:a05:6a00:4654:b0:772:823b:78a4 with SMTP id d2e1a72fcca58-780fce2cc33mr2678434b3a.13.1758781740750;
        Wed, 24 Sep 2025 23:29:00 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:00 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:07 +0530
Subject: [PATCH v2 01/24] dt-bindings: arm: qcom: Document Glymur SoC and
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-1-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4e12f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KVNckf8Hb-gWPUCTgC0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 4epFr3tT61PXxtv_SgMVfvWCZOGV6654
X-Proofpoint-ORIG-GUID: 4epFr3tT61PXxtv_SgMVfvWCZOGV6654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX+ysWzMjenz/K
 2XPHLiWYjZY7hC8Cw0zK6ryattfhagjGAc43XowFKnrSh8x9IrqfK1aRHQ3btJY/dIbhDBMJlby
 dolugHa0+evTVB/souX11kPV+YVo2XO8wc2BR00F1dGYyEbt/1VPHXCG8hgnQkJyjwRr9W39ZQx
 +9IxlCeG3RmOX00wVSriKK+noPATEtSNQFMTUQScAiHYkZ+UMd/c9uOo3/bj1FqohHvtNAqD8jl
 1Avho+KXOeMAcSfhiAmZCOHYOzlboYb4EW3dRsNzJX/s/fww1vskXZXTGTYHQNx7VD8qzHVml6j
 Q0nLn7jHflbF0b8qEkinVUJihmd+Xq1BT2eBcMXFwLf7wjgObxCHVxtmg6hC8JeFxx+qgTx6HkD
 qmJEo1Mj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

Document Glymur SoC bindings and Compute Reference Device
(CRD) board id

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 18b5ed044f9fcc4d12f4e3baa001099b6e154af7..b529a8e097a35c10e0008124467d8f6038071308 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -61,6 +61,11 @@ properties:
               - qcom,apq8084-sbc
           - const: qcom,apq8084
 
+      - items:
+          - enum:
+              - qcom,glymur-crd
+          - const: qcom,glymur
+
       - items:
           - enum:
               - microsoft,dempsey

-- 
2.34.1


