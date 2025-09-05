Return-Path: <linux-kernel+bounces-803093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35706B45A70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E8F18995AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1AF371E95;
	Fri,  5 Sep 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XWu1qiX7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E997371E96
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082435; cv=none; b=iSQf7B5l+PfXJkqhinR9O+sTLMDHSycZXu9X7m/9a//JR6UFCMnj5kAVMdZxrz5gY3xmlEnU8lc+flEEk1NzESQPsnUauyxvtQEMt0oggHgIkZrVFtjHrcl0zziJ6NbkpuDTcIUOV39fOa31R7BbntAFoypFoTOavOCus0wAUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082435; c=relaxed/simple;
	bh=0mrJk6zYNya7zNruWFwjYDMwVqqDhslfcndoay6BTWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvEDrwlkeTBf8iDOnG1TIpwGt3KCFdDZLLQDYLjGaIXCwMgIvdEez0VyJqATkijXDuzbQuShDsfEgv+34mZWd0KH5A+Yduo81aX6niVcawVYgeT86wkqjU7cRbcIZYghWEw58dj48H8eLUJqqY04YmWlBboW0F83HnEGoETw/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XWu1qiX7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856nCZH023154
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 14:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pN4s5Jsp6Mg
	beINTKiydsrxJyktG0zAYiE2Vu5bV4zg=; b=XWu1qiX7fsu6kSjhvUA5rJwu2fo
	mtOMYmhzVXK29zsms4jRb+qmPei7tnqruP4MmX4s0cpC+N31svND7iCYUAGlVHiw
	yiFJLbs/xeMVkq4hDYaxS1yf1yKrkl3mAK4qi77apuZcOlHyUe//JglHfRFzwb0x
	9A15sV+R2WwdnQXJh6cIslHZoqL94pCdnjKKarTYLb8GnfQLzPPLXW4IRldyKEn7
	weDFlwsdw1SvI1a4Q7QNpJt8TBYpNn3P8ez4vSk/L4F9lT5fhV9psJKQBS1vtVnC
	v1zeS/wxiBm7/H7J4C++s1IqQAE+9SzJkEyBJUYQ+EVWayp14+MWTIfyJ8g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eujfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:27:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77288e1ce43so2332806b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082432; x=1757687232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pN4s5Jsp6MgbeINTKiydsrxJyktG0zAYiE2Vu5bV4zg=;
        b=MZzcC5vfqpKvEVhUm7311KLG8KmeUk1wLOn/RStiTKXXUrazk1N/vdeeP+7HrsXP8s
         tSkQZS/dFDP/ZuZ7W9l4lg3bQNtMUbweAEnuwJTgoS3bKW0mb4uHedKWXgVCNvA/dF5W
         yyMhKdrbv1ck+6GlpTvk9pk1joKfxV1AKfwfZjqghLn1+TiOK2CAOszat2OTunv4wt5d
         JoEKQR61DU/WKfZ4Q4GmpAqpzbby/Z/zqP5fRxRLPrXRYNVbaLlJgPH2A1pHNywRKnmj
         HXtW+ZNOMZYBCSjknCXOhqsCwRpVsSxBmHowaxnZ7nZwj8GuttUtUHUW/hNH88OaR9nY
         9G+w==
X-Forwarded-Encrypted: i=1; AJvYcCWIQk4TbFuA8TsSKAK7RrYs64nC4IU8u0osl0ioUBg/kdPZ5smwMQexWcrPeKogGb71jeNZrQUS5Ywx0Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4Vv0lfRYKhpGobO4TWmqMNw0rfy0n89tBKiZuUG9axHdZYd0
	H/DmPS0RlyTiktFRXpzofoZU+crRUaxfOa7BYfGaa2IrtNdACpL1QEYVhQTlzrLFqLzJgJqCOjZ
	opwwDmH5ohagxfhjajiUwv/YI3xcnvIN0WIlRIRybNB0KQOn6e1cQSfHG507wMkewjUw=
X-Gm-Gg: ASbGncsETz9YC0e+omHPBPuLVKxuufIzX7gQH4Yf72+ION90t8h1ayjNggfLlsfmjYn
	ediU4LcXAl2WdIhhePiszoECxX3r7h8gv91LefO3iipG7n+T/yBFbZYl/A9cUf58IHoP0Xs1fua
	w4Us0YC1iQYwnm9EWGk6q5AZZ6gHo/FGOGhnLVHrh0qYhWDGqG7iq9SM2bcNSUjh2D1IIFf2tPZ
	wh9Z78UbbyJBEl/Jp6LidfmZU3gXBSefNpGoypyxH+wax7lwWiGeV8iF3FmvlXIkR5tE7hNhv0P
	31eL/NWRwl7Vq7KWpWTR2rLoJTMl50NbDBd/yG/DXQPCv94z2crYHtKt04GWceSoIRY5kSGxgr6
	p
X-Received: by 2002:a05:6a00:4f81:b0:772:60b5:957b with SMTP id d2e1a72fcca58-77260b598a8mr24282235b3a.32.1757082431958;
        Fri, 05 Sep 2025 07:27:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFQKIMJndn5bwcU6MyFm5v/inGRI3uo/dgTXqP/UDOrNbxCF1ZR4FqzrLYTPamp8Ieukwasw==
X-Received: by 2002:a05:6a00:4f81:b0:772:60b5:957b with SMTP id d2e1a72fcca58-77260b598a8mr24282190b3a.32.1757082431468;
        Fri, 05 Sep 2025 07:27:11 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a601sm21930824b3a.3.2025.09.05.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:27:11 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
Subject: [PATCH v1 1/2] ASoC: dt-bindings: qcom,sm8250: Add QCS8300 sound card
Date: Fri,  5 Sep 2025 19:56:46 +0530
Message-Id: <20250905142647.2566951-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: m-Np7KKJfr4eTx24Ix1fiFsXUvNigHAI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfXxh6Ggn7UmwDs
 gVpRs20ehUQRQllk4OSwQofricXxAR6haFvvnwoOpCD9BC/Bpimohu40UpWO1HW3QIHvuke7GPU
 5MWhhusAYrzFXnMB6JBnWiMM5krhDQnpkJiOyMsu15kgoC5jxeF9hfC6z79T7q8OB2h4aeI3MT1
 pOMO/43eMPLvxo+nVkgbMHzKIRJBYsb7AXTB8l7xUk68rvW2dsNZ1U9LCuyTY1wCo0HPRbPJFJy
 1zNAAfkRmCCZcfsnm03XAkwnlNbsCsT5r9ys428dmxzeVe5+OXJPNa4Xt5U2OvQcqKY42gvv4kR
 8CqfLVqKRtECTfNjcahEdcN4gc0teMRZ/MoVUfPSgUG7ajS4aMCtDAMX0xvJ4HHAbIEQAf6O7q7
 yZ6TFyMR
X-Proofpoint-ORIG-GUID: m-Np7KKJfr4eTx24Ix1fiFsXUvNigHAI
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68baf340 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=zZQLtTUG7XCfRDSkAgYA:9 a=zgiPjhLxNE0A:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

Add bindings for QCS8300 sound card, which looks fully
compatible with existing SM8250.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 8ac91625dce5..eebf80c1d79a 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -35,6 +35,7 @@ properties:
           - qcom,qcm6490-idp-sndcard
           - qcom,qcs6490-rb3gen2-sndcard
           - qcom,qcs8275-sndcard
+          - qcom,qcs8300-sndcard
           - qcom,qcs9075-sndcard
           - qcom,qcs9100-sndcard
           - qcom,qrb4210-rb2-sndcard
-- 
2.34.1


