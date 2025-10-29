Return-Path: <linux-kernel+bounces-876434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37352C1B94C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C17458174F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514392FF661;
	Wed, 29 Oct 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WrHSavp/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Km42uYIh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B6310624
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749214; cv=none; b=uKMU4r1+yG5GLoa5EICwzUWOX6/ef1Pegz4VjvkNs+RAaRuiRPMDrg5c02sFgg9oeapdA2rpwO7XGRiqa/fKH/w6xBW+ZcjlI70ikaA4jmSJnzsBWqDtkSuHH4Fky+hW+EJXeeUvcz3zk12NsyjxVjweT+fX6aEQrOd8LBGFq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749214; c=relaxed/simple;
	bh=WlLMZwo0H4Ep9SK9cIL4i/qaXEGNycF3lxaPWFNBL/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8Uy7V3y7HEPqko8BhvamvRXrwtfb7T9CEm9V80Jouk283nvdwmHMf45IdRsAxxkipOV+8SIPu5mD+4tQPDt9LtQK7taIyPzErgFvI25Q+/cyQ4Mq2Lu+8HHZnp3gRaP7qf00L6r/GgZgqkY1WnvlYzXjwXLGlKqU9isXeidgCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WrHSavp/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Km42uYIh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TDd3FJ569166
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3VQByPyxhbQga8wEr4/BN3Sn+0fDUaknqZU
	S5siW03Q=; b=WrHSavp/1SNze8CpBfqeOmlH3QWMaVVrl+7Nx6bSc70s8EZ7CJO
	AlxJ8sUtKvserq6JFA7HqErfhMbdZJhYgnoBjN1ipHlHD/THcG9Lpi9WbzomEdz1
	I8RL8zyFKl8dDdevs+IBsWmylI9aG57h/+mxtRo6d6kZ9olfJeFBLZWi5azLTqtd
	b3hwm+vAPw6K5cAbjKTi6H0u0m/KUg3HN8byDv6XnaLk31zLx6lmu8MOGSfMbPyS
	Ihi+gwhwHqowjofIKo1ymKzo3xsxkHyzKCcVIAt4KnW8MFtDzf0oVC7rWMAlrP+6
	2G6cywUi56DSEKmqTTZsmmf0o2Ss8ZGcFaw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3m0bg72y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:46:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4eb9e480c15so85938231cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761749211; x=1762354011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3VQByPyxhbQga8wEr4/BN3Sn+0fDUaknqZUS5siW03Q=;
        b=Km42uYIhCt6crVJbqvZUFh48lJ0/BkYL1rui7XQ7XcZeuSD6l+6pj8j+0UWcoUrTOp
         3FbZRgBLcZtVaVXLtXC4l0dLlMRunut2CSgVPSHt5G1WVkTjyr+B8+Vg/wGrOt8Yxhsv
         zhZxHHgHx11ZWfDYZMngmF5ce4ZxnNGMXpqFqKjOe0Z3Fkb0a9AdrZeG2ABCzX/qNQtM
         FLsDebHYELz2Q4bsNlQi1uWeqH/Qf/i6sInRAAwUiqCXELFOBOrk2BZoeBmlFVucmMWu
         BEJrwOTz5nT52BPkJuF8w2U15dHmCQG0qo9zugR91CIiX2n36WUkW3fdND6lbjAsErBk
         IRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749211; x=1762354011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VQByPyxhbQga8wEr4/BN3Sn+0fDUaknqZUS5siW03Q=;
        b=wpoO1c588JH02I3THTcAIvkrOmNO6zDc4gE4ZmGmVRxXbF3pAZaHb4GYBIRGGc16P/
         57meWI4D3+4fkyz6z9JeGVUPJU8H++k04VcWJdFI5nGYCnYPdh6zufj0WZjaRNyvXgSr
         XgiM6fUOlynRitdtYknEmuIUFkX8jgBopIzZ2n8BbBNKYWQm+/gkpb5JnbV2z9GYag7D
         E39lKyC8GDjqa3zpNdk3dZUO5asUHEukfKPv087UzvFgqnGnXvEsgzWMvdw2yad+aKsf
         iQeG4czpx6ZXVRIlykvE+4e+cwVXUwPdPf02INEFYZtQJk3ec8Fkp/7p/hFhVRpvEPu6
         C7ug==
X-Forwarded-Encrypted: i=1; AJvYcCWvSXXzeAeffk2Pa1FehTSSu9neEOM+p3v+TjJ0/X4h0OOHV1MQvoBF2jEdTzRlrfC0xqtkt2LlrBgg1a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/D3ye4ORcYsvHEXg+6a8cVE4NyxXAdCpJFR3hV/3A76th+hjk
	JgJcL/QsAXekFFPhxMhLPisu2zTDWzU4FT5AcCf7qiTZdx64h54wcOJbJCoWa7pXA0AS10UuwI4
	a8YnhtaFd7B02I6PRW3X8fVG9vtV1mSJMpYBopwCoSEmLfPepGeoWUkayiZ2DWuanpRQ=
X-Gm-Gg: ASbGncsKozoN/55SiPp/YxTT9aBkRpWKUoYfvon7uLo2oOcksHEZb51ab1pq4va9YRS
	/3SGhDGRU9nmV7k7OyZIQOfeN6cDHaB6hyxHP7NGGiuSeJH+CmVj6ui9L5FfwsYHSsjX9VlbLwy
	G0FCZ3R5uLTr8+ifWRFylstD+mD9RUacMxsrIwFsVvmDt0buCZYX32NXrhHK7Gl8B0lNQHW4lan
	KZzmTw4mSpz/fBB30lpa81i6Pfw5jDIhftZOl6EZZX/GncbFXoXOYClnnKunjCfR02Zstko65/1
	xoTBiuHInmQhqSFFxA26nqFQyMnnKY76oQkbTCxXvsv0JgMh9+c7o/dnKR35wdgNe2pd/+dw3hq
	q1UUIA9zc9opv
X-Received: by 2002:a05:622a:8354:b0:4ec:f07c:3e85 with SMTP id d75a77b69052e-4ed1e4dde2fmr11330951cf.43.1761749210789;
        Wed, 29 Oct 2025 07:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXErexYyuFdz0AmKoKmT2JVIOCX89erGQ023chN47ZncI2gn9SrZMs/CXgh80y8c6IyjAKUA==
X-Received: by 2002:a05:622a:8354:b0:4ec:f07c:3e85 with SMTP id d75a77b69052e-4ed1e4dde2fmr11330681cf.43.1761749210348;
        Wed, 29 Oct 2025 07:46:50 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e18bd9dsm51573075e9.3.2025.10.29.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:46:49 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH] ASoC: dt-bindings: pm4125-sdw: correct number of soundwire ports
Date: Wed, 29 Oct 2025 14:46:36 +0000
Message-ID: <20251029144636.357203-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PRF2yPWEbngO3_zDUjrJTXKo6_4t3qaf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDExNSBTYWx0ZWRfX9a0gWRIOpXYz
 MWQvkg2YRZH+Evef+Jszw4QuXL2GlFyrkYQUNuo0oxpUb/WrRpjzcnERWz/LP5CTJEHAUjAdB4E
 Ak+L0Yl8vZJwHdW0NLJsHBraPv3YcN3SVppm+QfJapUSFeY8kwqJYQhhyWUK8aLMbRVRC/GQpW1
 rxKi96+tlBjVIwZbIZqyNboYYG8wvorcRndpkF4+sYmaDzB13qGrG8m5e6eYZdmbzJ+xwSDcCcZ
 F513PDG2PuR5hul1J+t0nuGBzWHtgCZ5E+9zEq3Hk8isMRxkc0Sm66b7m/2jDfOLq4VRLpzrp+Y
 tA5bRCBF3rH7oj9TpzeZLZD38O95zf4QHQxquzRtAigoqvTf4Ow4pkE9F1uJJOI9ETWEgV0Xz/e
 TvOKd6u1ljPfv+3abZDPlwfhAVSIZQ==
X-Proofpoint-GUID: PRF2yPWEbngO3_zDUjrJTXKo6_4t3qaf
X-Authority-Analysis: v=2.4 cv=YLySCBGx c=1 sm=1 tr=0 ts=690228db cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=sX3_Zgyp12BJ_7Xf3x0A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290115

For some reason we ended up limiting the number of soundwire ports to 2
in the bindings, the actual codec supports 4 rx and 5 tx ports.

Fixes: 88d0d17192c5 ("ASoC: dt-bindings: add bindings for pm4125 audio codec")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml
index 23624f32ac30..769e4cb5b99b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml
@@ -32,7 +32,7 @@ properties:
 
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 2
-    maxItems: 2
+    maxItems: 4
     items:
       enum: [1, 2, 3, 4]
 
@@ -48,7 +48,7 @@ properties:
 
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 2
-    maxItems: 2
+    maxItems: 5
     items:
       enum: [1, 2, 3, 4, 5]
 
-- 
2.51.0


