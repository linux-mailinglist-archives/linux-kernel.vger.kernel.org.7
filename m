Return-Path: <linux-kernel+bounces-759726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A3B1E1B2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18166627455
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE2B1F8725;
	Fri,  8 Aug 2025 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBn9bP5P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007E20E6E2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631028; cv=none; b=VzO6ygNV5HWhxtDGmriJBIfe58XEOTGnW+LzWvVI4B/8xgFkjoZRTC9USJkhcEisFxntEPWz9HbZ2TPsPlJnKjraxNl1Fbe4RqWpj7x/Nz90VDbXuyFaBs/dfafE5GE/+ZdYyVIRzpOV12ilGWdBLSx2kpQqC5ZrL7y3/fhRxdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631028; c=relaxed/simple;
	bh=vudh6ChWfb+QAp63DxN/31q2MEqtFSevu7JbiruqA44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VtnWT4oCAl6Z7st3HsSShpUwo5Hd1psrU1M1VOd8D0vXI72TzWPGCnZyUGWRwqAXCoRObwYHYmBU9JzH0w9ADXGvtzFhgBj3bRejT7e9Gh2Y0Caq489okqK5LNutVijwqz9gwAoeEcv94XXRJvd7SvRNAyQBvaEgI/NQUxU7LKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBn9bP5P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577I9oPk012838
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 05:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j0/NbC6Dz3I
	Sr1wnPGqDAmCICjCJoiyEDtY+fN1XBu8=; b=WBn9bP5Pv6wjkiTgkiMnxIDcsTK
	iJFDyvg4NcR5yVnOo7RRjGMl6z5Nlo7nnL7uiLP+6cFhl4QUKqiKYbx1fDSHWZS8
	dsp6IxyaHZ54eCAHrmAAkyChQIg+vQxPN+LA6HbFwFFs/17OoERFqu9pYer8oDql
	E/vF0hUYxFYK3VIGDc0ydL4ERlu7X1avjGfy05oOYcVySm2UbFs44/7SNS3f4+7u
	kV6smLhpOo5kZ0s8RraDxmDs06K3RBfuhXotcV96U6/X28BFc55byHE/2fjzL/4S
	JEhwPfET5tX8BjkQtZ7sacigyVVkee6aJJgv44A0VKxFoVOru2dqi383W4w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpybgtv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:30:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bfc40bdceso1274135b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 22:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631023; x=1755235823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0/NbC6Dz3ISr1wnPGqDAmCICjCJoiyEDtY+fN1XBu8=;
        b=UcdFRUbtmvT4Iw0uZhXIbIm/oXyAMmhMOakHW2+qZUK/wtojrEoDrAgFxkP85Pkdmm
         v0Wc2hDJ5G4TQhmllhA5w8Qi6l184PeJzTF2T7tRRDCEg5Ue4bzEb5vE+gmebxEYNim1
         hucXMAxrYpwaLd+HBUzqhfxox4jF4ALSW3vq47FIbDnVV2ImnCH7s6RidWF9jy0nYNzz
         0KRd0ZDxos9Kud3GOU+KgsDBUl9Pu3tEWvZF5HxRIrtXsIpujWohm2Uenq6436LJ153/
         4wayC5//xgrJudouyvOIFYu9vuSWQhCgLE5usuzuwuH2TnSy8UPJTLpiiqvmUrvxTS2f
         lIYw==
X-Forwarded-Encrypted: i=1; AJvYcCUoFKJ/b8vVn6fTp7iZlxt9xDCITZPI51Trd18uMIKAzZl424EWLGqr5RbEWi2aa5PNo0Sf+gTWC2+exqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2y68FXrY91rSGP/VvxsZgakLFPERkI09ZEzDxcWefeWiGVea/
	8R8NgVZG+7lJEVDZ7XW+U10gBfPrb7u6uOxCWqBiO7H6PsZw80FWbBFeynpxO+PCQ1GrVObkIEZ
	vQfQmTdyorcwyekyROmbHoaSCeE8azEKiMziQhczOJKglGbuzsLkrms9WooaSCcGfYKY=
X-Gm-Gg: ASbGncvnCmlqXK9DZprZB3sMuLo62G/eQTXBj96Xh+LhtdfazxiMPYbnFjW4yg2heZB
	iH6SBU9sQXOOuZiZALPYvb2HHCbljlsY0WT1/xCf2+ls0AJGFYX1Bwc+4dgmJNmwSpcTLT3vSDs
	7OhWbCmq0K/6O/lUIfCfoaiNXMQKlFi33LuxPZ9YI/q93czxm+YNGwYKXB6+omT2+Ua21hCJTgH
	cxOTKCbMpOV5HpN77W8cR/feGjwSYHlaRiyFyO9EtqcqWD43WlTd+NDFEXtJyDWmM13WGwyaE/9
	SIF2BEKJOqtp+fZmASqiEMpO6VjxyaazqchmeZqmMuIkL6cTEJL1yiMciags4GkMwUeW5E2cNwk
	q
X-Received: by 2002:a05:6a00:3d4b:b0:76b:f260:8614 with SMTP id d2e1a72fcca58-76c460ded44mr2946493b3a.3.1754631023402;
        Thu, 07 Aug 2025 22:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE322Xtuer1nSvLoooPflfHEOze81sggfs2Qy/lSDwJaYopil6xUbkHvvn+WnhQgau0g52mJQ==
X-Received: by 2002:a05:6a00:3d4b:b0:76b:f260:8614 with SMTP id d2e1a72fcca58-76c460ded44mr2946439b3a.3.1754631022958;
        Thu, 07 Aug 2025 22:30:22 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f483sm19278662b3a.31.2025.08.07.22.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 22:30:22 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com
Subject: [PATCH v1 1/2] ASoC: dt-bindings: qcom,sm8250: Add lemans-evk and monaco-evk sound card
Date: Fri,  8 Aug 2025 10:59:38 +0530
Message-Id: <20250808052939.1130505-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808052939.1130505-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250808052939.1130505-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXxXnxx+fc2aWC
 ENWcTso+hA0z8kESgqypZ0pVtqIQYxAP3OoeAGAG57694GfzTscnee+ieu8HZPZ2LfKDaFx8v7N
 6HklLh7M4yF5/aUQ0umNk5lQ+oIkYmwdofTeB01VlOfcj9L5TNcdkiuHY52QCJMtTfEce5YLVP7
 BUPl5Z98qc47hqC3rwTAgZsQKGRJA5I8Rz8aLV4HD9OTbRITO0FaOGhvs7tDp4VCzZSQ8gOooFa
 SolanQF6/E/bwStI3br8/iWXN8YBWMMSYVFAVs61cO08sNtfU/QQB6evZIrykWkUAQSs5k3nsOr
 9qX7l3Ycs4nusaXu7Dev+opfMCsQIleIeKHuKQZl/MVZgCu6sRzKcJ/B2ttLLB9nVpGy7EOQ1H5
 CxOfvBRg
X-Proofpoint-GUID: ssEvb3S_hpS7sMqTkIYIVK_uu7i5eEgv
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=68958b70 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=kbphIXzXdx9KadpZM_wA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: ssEvb3S_hpS7sMqTkIYIVK_uu7i5eEgv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

Document the bindings for the Qualcomm LEMANS-EVK and MONACO-EVK
board specific sound card.

The bindings are the same as for other newer Qualcomm ADSP sound cards,
thus keep them in existing qcom,sm8250.yaml file, even though Linux driver
is separate.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 5d3dbb6cb1ae..c63bfe031b57 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -31,6 +31,8 @@ properties:
           - fairphone,fp4-sndcard
           - fairphone,fp5-sndcard
           - qcom,apq8096-sndcard
+          - qcom,lemans-evk-sndcard
+          - qcom,monaco-evk-sndcard
           - qcom,qcm6490-idp-sndcard
           - qcom,qcs6490-rb3gen2-sndcard
           - qcom,qcs8275-sndcard
-- 
2.34.1


