Return-Path: <linux-kernel+bounces-754687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7EB19AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155C73B6842
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711AC223339;
	Mon,  4 Aug 2025 05:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="muXpCsr/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70098153BED
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283983; cv=none; b=Cfw0wdAULq6v+/8XD616SIGiaAoXKXuyYCD2Y336HwEISoN+in3FSX1WE9u+KZkGZECW91VAGC/9UJp4rG46GyX3HccoEQA8ZyjSrT8CadYDvppPQ2EyTXuOW+mF9Svr9IPZFyu+FTYlpkXoKZSnAj6HDkhAAbUUVUkLpps4JZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283983; c=relaxed/simple;
	bh=o+KKhqjgceUKc54+3lwvh9D2uZKZYubKBJvC6PvrxDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ci2Sw2N/Svs5QrHbLgvizsKXYOdGnFVEgk1IfQB3WD3jvZY9bYoJH434q1FkuBKUL0CJMY47afZWDyGErGwSH9Rz0dNy6Z/ekRJmlhq4vzNfpWErvlzoRWHpRWhOyrur4P9EJAsi92kDaX8DecdX0MBn8wppTLi+VIfEX+M56/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=muXpCsr/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5740BvTt005156
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 05:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mFgAZJ7P3Zm+6XkWFs5BVvgYy6OJo2QLp+7
	HH563RNs=; b=muXpCsr/zsFbL166dtN8CxzUqtxQo9GaQvp56QrnjHQiI/nJsSE
	j4C6ztRwWvDL+KNADD66Y8sC2T+7sbnMhQPJzbKrrnGgUFg1Ri4F+jvP2zSdVQL4
	TAdmceULpyCPOYYHqG/hJEEGkglnseIR2t8BdB4avGLPLfmfYntSXfi1qv7esaxV
	45hNtxjeFI9mg66jFAkkJcmwVBINQXcrupnNlvKJKqdIDAoDRpLSKju1Af2Hf2ym
	h1EwWyguCa38yFDky7HOliATiKugyCqNboBBjFaqhDHZeXVbuHXGvVGvEsQ04w1E
	4jGkOnp3PYZlhATLYhkNmhtJKb0A1BEVrmw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjkrp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:06:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31f65d519d3so6460877a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 22:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754283980; x=1754888780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFgAZJ7P3Zm+6XkWFs5BVvgYy6OJo2QLp+7HH563RNs=;
        b=n+UFKv65ijDQ6U4lDmmmdD/Zu1A5r4TBH14UjOQbZOEh23wgp4J+fygnoeyFD5OJkD
         pRTrwxBgCgzC1015HgZ5b8Tkzwb8Zy3QeJmZ/bF6Az7eNelVlawthUE4DVFevYK/xQuT
         vgGLXDqVBfcx0YakfsaoEZOiuSokbydinyBxV18USrL/TD4kKSCMlbVZ9BChk0VUi/Ls
         so9mEvLqnB+KuXwflahSV1ith469Znhfz8g492SljO4p0a61JCCQOuyISMOfIl2oLy+I
         Esdick83FJB4VY5HMa7lPSUAUOz5O7T1cKKXSaidM/LN+LGHJH/quvlBREobEq6Wun4G
         Z/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWAvW6qra6SuCaHT9zoA2bNBWtPZyVE8+vsa2/3OPYVOJQHVJAhLcjixptEF89eSANIQaej0WJdfRWZOAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQLW0aUm7fOaGwB5xOE1SS2hmUx7gVrNDwp/5HXjZKXL5veph
	fw1+60+5NX2b/jCscZAbROz9hk7i0ypArZFNSc7xlDd5eMtBX4aizE/ekv0aVlNTEriJ9xrObj7
	S5FcoUwBo945+89hH5TD2zc0ZIF37+xmGceGwv05X2ngbzH7Oy3qFDSV1J/Jqfdf6xuY=
X-Gm-Gg: ASbGnctz4g4y1Sk+GY9Jr5mFT5tQg5fi72fdRoaXiINPyEfBbEzIAmawP9YXjharOxZ
	BVHTlW2SBBEshtCXH/f/5ZXA1dkM10fYRifuftGLwrzrURYVjQQ6S5BDUnOmtm7sDDh+Bxm03Yc
	VxzsTovoP0AapYtN58LOQS2yaYN8mT7Cxn3JLXa4N/hfSC/CztuWx0NVloz4YiuCULidtDoSYyy
	9hH6YR7jSd55HwzuqWPvS72KPV8fMqZGk0cL0mHhyP8HF339mfNNUCrj9j3kxTWsBht3cVTKBmi
	lVhGswl9J5tV8yhCrLGpqQFpBWOs3S5GtzE4iKK9OpX141kOHSKnvokjLqiK1yKCDxZPuhhkbwf
	KtUo=
X-Received: by 2002:a17:90b:3b45:b0:31e:ff94:3fa0 with SMTP id 98e67ed59e1d1-321161d6078mr11744942a91.6.1754283979756;
        Sun, 03 Aug 2025 22:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGWeHm4SZUpqc8ezy4PspRdFA/54Q0jokeRMGEtdsPupU2NKwBbTJIGQaIB1gJqcWLAo0wvw==
X-Received: by 2002:a17:90b:3b45:b0:31e:ff94:3fa0 with SMTP id 98e67ed59e1d1-321161d6078mr11744914a91.6.1754283979290;
        Sun, 03 Aug 2025 22:06:19 -0700 (PDT)
Received: from e0cec1fbb194.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm99705135ad.7.2025.08.03.22.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 22:06:18 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 0/2] Add OSM L3 provider support on QCS615 SoC
Date: Mon,  4 Aug 2025 05:05:40 +0000
Message-ID: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=68903fcc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VdEDuztqGucW-MqrkSEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 7-3S74w9PLpOl4LPF_URZwiQJKApYLQQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyNCBTYWx0ZWRfXydJwtXk54CVp
 SduHlRloTVjdRmBukFMQ6J42lpuNZWq/iEYyZd376ftj2XD30KQiKWwx2YFiexCdDYrheDkpkP8
 ZGBcRugyft/gBmixDFu6PyX3cxBmKWOETvCsLrmunl95AXzB0B5gM7jbVq2EoMcnHAThzvFJaUM
 o4Zcv8c1/du+OjD3AUfxHTVckiyMtcSHQ60Rcu7HxMpBiykwIijAFSMsgnVufZyRr3MpM8Jn+Pm
 fip5bWxOnUBxf75agTTGGvANDHGd2T+kd+55MD9JEMZF8rdgMGi6iD0hZUl8IY6oxVGoRmVlRRe
 f18dnqqKJzN952FGHU6ALOWkHe3TZ649MCZFQYbY8iX6oSdooRGUIuxWzLUsvzrXaJagKH6iTOz
 VnWKsANsYesKWoh0/O22oZhBvmkp+0L0777rKDP+/+icSE2NG4oGE8AefnMnte/4fg0N2+Od
X-Proofpoint-GUID: 7-3S74w9PLpOl4LPF_URZwiQJKApYLQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040024

Add Operation State Manager (OSM) L3 scaling support on QCS615 SoC.

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC
  arm64: dts: qcom: qcs615: Add OSM l3 interconnect provider node and
    CPU OPP tables to scale DDR/L3

 .../bindings/interconnect/qcom,osm-l3.yaml    |   5 +
 arch/arm64/boot/dts/qcom/sm6150.dtsi          | 148 ++++++++++++++++++
 2 files changed, 153 insertions(+)

-- 
2.43.0


