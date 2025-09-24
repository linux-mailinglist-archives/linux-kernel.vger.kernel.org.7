Return-Path: <linux-kernel+bounces-831341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFA7B9C679
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E4E7AAA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9763229C35A;
	Wed, 24 Sep 2025 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jm7k6HBI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D342882D7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754746; cv=none; b=XoQBooIDMiI6ax4hBjBI368uhUbJY0Vze0DuxsAv8l2Bn67v68aJW4jqtIO4I0YRbe3K+xVPIDIUGXratTJfp4wOqUv4X8KF7bQyUA8eSCiCXfdSjVuPiich8WaINsvcVIkgwpPd/ozUvBGWTv4AlXA5Z4smIXD9gdGIBLUAwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754746; c=relaxed/simple;
	bh=nccuP8cYHwqRLgitAVKUToM+oD9cA22ZoDKwCaULBko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNpbA5tbvYhhW6eie78OOGWa7dKu/054kIlNED3WOMC8KLrdDEBNMocltigPnjDz8h/yz+sjjj9ELRwKirnEOHcMWAloeCtmzdaBIuzr5h4fn96PqXfPxjNIDAxH86GrSGcNKj/3HZeoYtd5OWLPlDU/5YNtdnzeYN9sH3ZlOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jm7k6HBI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCq7k6020897
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fMgpIMFqrzsSm+B2qsU+OeemAY/LmfQHctAKtQNCtPI=; b=jm7k6HBIMgEFJDiZ
	YpF0lrJNdphuFuYAUSKWJNdvWUN8N2M8mRSRKdgVf6jUxuox0NWpgr54BtWegrmJ
	Ke/qFPoLGubR9H3I8YhH9xIng0JHH2T0lRNDRqbjFPBasQj1esxtwivShQh8H12o
	5MH3e6hopPigaf+EJJ8ZFvn1Y/SiMUu2Oxg+sRD9vbX/fGILbsw1zcGQeoUUIkOW
	sg6xjDxmqwy0Zc1VJVxKa1OuoD3Y7rNPcQOv0bdCU8pvdZHa+fK5/kY12VMnvG2T
	JLKhjNkzoCclLZrJtY/3W6SFqUEzl2A7jkJAgfvkFGxvNCXZKWwIfnSg6B8gDpqB
	chhaxA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdy6e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f610f7325so266775b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754743; x=1759359543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMgpIMFqrzsSm+B2qsU+OeemAY/LmfQHctAKtQNCtPI=;
        b=pWmxkQZgLEcSI12nqE7oO8in+JpQYxJ9OTjFqVtF5X/FZ0wL254g+32rqDkC5iwdqn
         w4w3KU2xtDOLKoF8bYqPlPzM/CQqzYSjnZ/mtw5OW3zHJWmcaX5tEwE1Iuch+o7K69Cf
         7lfIce3rYQqKY+ibv6k05CuLw0nDSBDadiHtMgktMzCxABZja3KAZ1yuQFFCkIZ7OneF
         UuI5es9n6tzaDwTlH+F+LKY4f3Yw82VWlsuWlDUu8YmACDN1psxLO4KNU6rKTzfnwLl0
         OaCCgA7T5viQtKsfsghzpP8Awx9YK8NyYrp8Hx5AFmVZ+vuuW66jx0TNXSqvbPxNgPkU
         AVRg==
X-Forwarded-Encrypted: i=1; AJvYcCXwMHGXqDpPOb/r+p0sdo93nHugOPHx5pfOb1sZ8vutZ6NDxepakSKYutLKaRbksAQbXW3buX6xhCxEyik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLaFYagi2JV75af36WJRHuhgxyMVJmhrx67hjbBCmXlpmUE9XM
	Wuo/+nrAh+Q4BywXfl8Ki+v4LWg1pf0NS3xsm2kCN88FSRN4JCP9tZ5nu4piVDGokqIHQBlnKPw
	XlA1+HDz0yCRjLKh+EcVBmZSlbyczTLPyQWJuLAeTPhOqlXmYBxTDyVMK7ycznUZ6JyE=
X-Gm-Gg: ASbGncvT6L8Upa7xdZZyxGkaUI0GVNc36kTsjI4/1o1J8i4t2Mo7AgbVUYzmyho58Ek
	/xHPIN34+8iSSlVu+Rih412XwsDy5BZpc4Jm73VIc68sr7ZbY1TC7clBKO7SehSyC8qfG06uUeX
	JssD6i0kyxa1CHogDUE2UTlzShRoaNFEyFS8qWm6RMAGsmnGDbhVo2iALIZWO9m/CLDjEqwVftQ
	HUzR7/qUHODjQrDFW8YYVH8hC5aPbYwbqqFN9kRPG/2Fd35GcA8pt8XMBrA77ldZ1uiuhysPS2C
	NciK7GZ1gqUovf2Uy4m+R8OYZMetmCJ6N9xtV6CVP7+a0JOUmZIyURMtlSun8EpOQQ59FJPFjnQ
	0Rm71Vf/JTPsli2Q=
X-Received: by 2002:a05:6a21:3396:b0:2b1:c9dc:6dab with SMTP id adf61e73a8af0-2e7d2e45e02mr1491861637.48.1758754743643;
        Wed, 24 Sep 2025 15:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXb9iTgoVPLaR0CHqKB/TzfTzAqbsVbT7DO5mubz2WWzmbtksZ6qJqUAfhpQ7FIRENwBXqKg==
X-Received: by 2002:a05:6a21:3396:b0:2b1:c9dc:6dab with SMTP id adf61e73a8af0-2e7d2e45e02mr1491833637.48.1758754743202;
        Wed, 24 Sep 2025 15:59:03 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2b70esm111166b3a.101.2025.09.24.15.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:59:02 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 15:58:53 -0700
Subject: [PATCH 1/9] dt-bindings: clock: qcom-rpmhcc: Add RPMHCC for
 Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-clk-v1-1-29b02b818782@oss.qualcomm.com>
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
In-Reply-To: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754740; l=821;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=phKtN7ebMiQmSiG9AvoMUJXIakeBUvWlreynI7Iyig8=;
 b=/3h8ths0TYSVixc4PJayGd+ZArZnNhGQdhWuSaG6FBjv6i2DsdzTmRt/5hBJ6Hml81JAvRwgR
 UQ4zAULmxV0DoyWOG5l/TEUw5iFD9IXHvhE/n+LddOV7VNcB3QHbzKQ
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: 3TQLskzIBCfRcZJJhEbwawLY13JYrfSg
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d477b8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=b6mPgT8S7ijOLrz7_y4A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 3TQLskzIBCfRcZJJhEbwawLY13JYrfSg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXzv8n+pksg/xX
 oDJy3NSvzZ1bPYg8AlOJpAHUOvZKpj2lRDBl25ATmVjh1bZophK6oft4mKLnAxbYJsRW22f8Bdj
 BD5qfndkFlQcYqQHJxK4RYhOVhaviDFRc9cPxVStZ22R3No8lrPQ3ZjkKgyueNt8IzZXZKWdi5P
 vJiIlgVqIsEXdfllZiipWxII3QM3xkP1MQ8xUDkgYklAHt1FbnS0AjHM4ZoI5Xvn7DMIFtaPfqw
 nSyK4EfKnLzZY2+Db7vGP32q1//kCe5PdEA/KSTsVDmJHTS/oyIRDqL0anLzb8HCXOFwOLd+CdG
 r//dYbeoKo/e8+Il1u8qZ6jt1sLZz03nRpdhrwwgQa17oabBU04FyzQdxQ4MrtWFX4GN4DuY2Dg
 LrYaizdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

From: Taniya Das <taniya.das@oss.qualcomm.com>

Update the documentation for clock rpmh driver on Kaanapali SoCs.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 78fa05726685..3f5f1336262e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,glymur-rpmh-clk
+      - qcom,kaanapali-rpmh-clk
       - qcom,milos-rpmh-clk
       - qcom,qcs615-rpmh-clk
       - qcom,qdu1000-rpmh-clk

-- 
2.25.1


