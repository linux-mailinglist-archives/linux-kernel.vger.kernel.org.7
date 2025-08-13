Return-Path: <linux-kernel+bounces-766185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37713B24364
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5138807E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2372EA15F;
	Wed, 13 Aug 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NR3o+EJb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF62E7BD4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071762; cv=none; b=lktEaCWia0RUb+ERsaNxmjpaeQyarnyzzHgcA5GYTxCawff7yRZi47i0aSPxL/AII76K2/218mxMY+I4yDqEmI1oc8iGf3B3PD+cXjqUN5K+6B5qTBSGgGC0zBXx3DZ0YyoGGcFUNL+aMIfqqhkwe4pZB0wcLfrtiIZsa2t1mIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071762; c=relaxed/simple;
	bh=D07Jua3uhs96Js26Ok23Ar/4/MvIJ5BYb7yr7CLyRNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6tZmyykb4uzu7g7EfvGK7MgsjONLbpbl423DLs48j8xvIEDl/nOg+UUj5Q8PE0qKdIKNMQK52vdj00U/J7SsYDLHsx5Xj8ZtBX12oE5MAnS+x75z3CgujwJBjXoXHtpza+fxieTSnehzesLAx53tfMcSh/pKeS/Z3ed6gJyytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NR3o+EJb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mL8O026036
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m7q8BR9F5OBMsEZzbyywFRTwDIso+RrsEIi+fPUY/e0=; b=NR3o+EJbKDDtp+mM
	WqvqKrsep2fZg6tXDy2VxboBE/Cwnm9RJ9KZF+IybjXsCRhZ0AtjEaQjp+fqCQmb
	R2nNI9tV3bCL5zttpTVJy1rONst15lSE5JW0B3P+a8m9FHEFTsaMNpQbsfZwUBcE
	BRC4LlizN3M6EoxwdXd3KIKa5vagfaGon69ggDXAIhoofKYJNUqceTWgwQcJNJmx
	tHGPTLVBKeulYfEd54EKRaXM5WxkPJn652+are4cAIDnjD+5ZeZMEx+CtD8tHcTT
	Doo/awXIkwiG7CByUUGlu7guQTb/QHSAtyvDWNaAgCeZuvEiZWgFvoWRTYkg9XVw
	s9hlMA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9su6kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso11909860a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071759; x=1755676559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7q8BR9F5OBMsEZzbyywFRTwDIso+RrsEIi+fPUY/e0=;
        b=RlKjWB1G6Rzh0e9CaSAH8H+ENCHsyMqaRmHjjayisNTPgMuizL/kKjQDtFc9Llp8LS
         ndv0YnxIb0SuWzugffHv8DtjC+c8d8XAVugYonUe+EBNjKZnbOZKy3NA6qKCF4IimjHn
         nKyERcHH32AD6zHRYtP+kDWV5qREXjE6nVDG42fGk0swjGYXUsc1Wz8VNDORpIhE20kG
         n4wVCrjx/F8I7WeQmPo1t0bHUooomQEkQM9FYJK46bgqTpMfDIp2svETAZNJg1UJ8FWQ
         X7BDKfQNe5aGWErb2w1RviXTEDfRU2pQvzoB2N6yxOeD7TjL0B7/yeZGdO8jBUIVgJww
         5Chg==
X-Forwarded-Encrypted: i=1; AJvYcCW/2Pm9WyAbeaKadhincc0vtIjbeVF/85fM8rZ5rpASlw0x1zL1xyAMyBjsX5NBxnU6xUDFCjerjDILR5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YymG+CgZNXu1PEqF4C13lD1iXN5U+pQ4LLd9U03+n4JSf/gQHGB
	CRWfqpHIVxQycQIOapGEgY6f1THGOAsUlNlcLjj6zmEMzw/iw+iEe3TLdPUUHjLxyz+OdffLLXI
	sGRs9yvGSw57+vHLIvbMYVk7s85RBQJRnCu/Nqt4uujI1wqBYRwnVbWYAbWNTbZKaNdA=
X-Gm-Gg: ASbGncsfok99wALNkjWJNep/DqOifZNUlMGMgKIudUV1QM+5nl6sFk66e2p9c5cGG6z
	Z6/I9deK0eGpisxEb49DFPaUJI5l5c0udYWFqBeU0wSYmSTv8mAoRtWS/xstbuQb04PjDto+932
	HRHZwMiZ07iaSmdJisJCZqQgb9ObKbcoT/bnsi8BUD7P1VCQUXfTaM6UF5GmLIjOTvC0kABt8pI
	rw31wtWZCx0W6puQ9o374t14UGPUh59vFWGr5hpQzFHMfS0SU4oXegb73tZmqZreqr25LXLmMES
	iFqIZzzRVxCV2vko2cAVzcDDU0hy/b4ZcY3v/i98mBIJBLNsAnrkkRxkt9RYrvNB
X-Received: by 2002:a05:6a20:9185:b0:224:c067:66f8 with SMTP id adf61e73a8af0-240a8b57048mr3545296637.37.1755071759586;
        Wed, 13 Aug 2025 00:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdYTtuNK9Ef5PQP9T+pU7CHZDwI8WmNAk7Iws2gqgqkZgmeLbgTRT90wMOoMIIfYtKtYpH6w==
X-Received: by 2002:a05:6a20:9185:b0:224:c067:66f8 with SMTP id adf61e73a8af0-240a8b57048mr3545254637.37.1755071759151;
        Wed, 13 Aug 2025 00:55:59 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm31395754b3a.65.2025.08.13.00.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:55:58 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 13:25:17 +0530
Subject: [PATCH v4 1/7] dt-bindings: clock: qcom-rpmhcc: Add support for
 Glymur SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-glymur-clock-controller-v4-v4-1-a408b390b22c@oss.qualcomm.com>
References: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
In-Reply-To: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689c4510 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ZmWPdgOBrplkPgKrADIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: OCfnT1HYRJ60XszOs_o_48l0VA7_E4WC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX22lc3fFEGd2K
 +gwdsIKA8gRiuBYnd+iDQHnriUMsB8d/s6/NQ16Gq2Ycsl6tVClM/bRHuFD6MT/kul5F1GS60sl
 ozHd0FjlROPj53AN8Yo9F1Bbwi6O2cCGpol/+YXKQtTqw02iC/NEGz5l5aQ9OQqBbRM/Y/2WNwO
 U9tnFGCrICKjjlpFRksfTHGzZklyHq+Qc0HHPIwMy5w/ybJdCVy4gzXQQBjTa8KaNEvDvopKL0v
 Tmc81szHj8hI8n622UuSxPTJ1Es/EwfKmSf6AsMguk31ewHxyCEqL1eiwdeTVR1NduMzUVgJ1da
 uABDfz5ey4InUmxt02W4Y6YJMUhMLRQehLD1uhR2+5OIsAHi56N4doCUGK1v9Ron3ZNnI9EKvZM
 5ytJworC
X-Proofpoint-GUID: OCfnT1HYRJ60XszOs_o_48l0VA7_E4WC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

Add bindings and update documentation compatible for RPMh clock
controller on Glymur SoC.

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


