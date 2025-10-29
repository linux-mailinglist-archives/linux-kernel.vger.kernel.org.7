Return-Path: <linux-kernel+bounces-876426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A01C1B68A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD817349C91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51D346E7E;
	Wed, 29 Oct 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KX2zZNaX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jqsHX8ZS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002FE3451C9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749024; cv=none; b=SHYqFqLVZGI1BbLnadznXN0LxbPWZgnVr9iuzDOZkvZa7qkalgWwacH9tg0C+mnuGfCoDiXjqn5vH4MDusupitdRvqH1tn0Sfzp0HnCSz8wnYbLK2R2TOEzsux81onyz1M0h0KxAvHDwA2ZD/fJgLJ12rjrqxsVwgUewPLNH5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749024; c=relaxed/simple;
	bh=Q4MX9SlPQmMJ4CcUBynx4ietUSAeT1pRBUKc3e+j1qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYhP/tMuHKVCLdYiWAih+fWhtzkSkyriz108uIQR4kTTBvVGCc5bJrJnUqZcoMDUx8/nlmR8IYJQAV88X1qeWM54Y6HuQ3nX+2SdzL/Oi6yHn6/f6WpbuodeTHq8j9SHnZCTA2QdzTD1S0lYb4jZNpVQ9INX0gjMvaSNcihanMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KX2zZNaX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jqsHX8ZS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TEhOn9816754
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nUtjA9zjZYqM21NPenW/TF7z83CiW4ruI7h
	h5gWZ9l8=; b=KX2zZNaXPXvadPtQrRFhgKLMK2KawjY63PQxWMLM435exHbBrIC
	LnGsFNdNg2PdaFgip70D7BZnAe3pTzknxIcAthzB/BsS6PwNC7eWZvcxPKWRTJsA
	cTRgzj1qp5avNKiBJPgrmfLOzzKe4fNZgxZquAPsRHU+Gm85UJfLbv88y5OgdAcy
	xUeNaG1ksNdoJE0/Zd7J7ipIS8Y54DmQq8EHyEjbh9CyKgh+yQZ+iKNVdr6s8RhA
	uTyF8ANG2HEdyWIiAaLDezB3LokuuHybGqi2aoUvjNuzNfZ7Wg8z1FkpmcWhFevG
	3I23xZ4KWgYSMjJg/+pK3nMabvQFt5h3wlQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3mxgg00x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:43:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecf0501ec2so87447561cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761749021; x=1762353821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUtjA9zjZYqM21NPenW/TF7z83CiW4ruI7hh5gWZ9l8=;
        b=jqsHX8ZSLRl30isBdgFXlVMOs+fkcHid3CBUnzE389K34PXYKnO+HWivtFpGF9bkfE
         9+IY6St1J/WaQ/u6sfq3oUd3uO+eKWPqQUMbG6ZfZYiuIsgX2RrrhPjcuVptIxeoNxLG
         iYwUqQUnFiN8ndpLKW7yxVAXmC3wPZ+G5hTsd5L86eU004cnyPDKeo2o5cmPg9s2Ms4q
         gRZAD40pYj25uEvwLPpfgVqrDV6ZRuM2mEcZrRvHJBODazNXXdwuDaUP5rFnYjeNw/iG
         kDNJ6ZD6NHIUAy7YJseJQRCOaICqcfI/Ewz8YoOGhvSaArt9FiRKD9glE5HgL8s1lF58
         kTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749021; x=1762353821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUtjA9zjZYqM21NPenW/TF7z83CiW4ruI7hh5gWZ9l8=;
        b=oP6yQ40aR127iWnnM8ITuVZzf/iLiEGOCHHIJYNJCub2Okobbx19fnbT6Z7Yjdxkwz
         BavMxXxl3apoyRQNLYMdn3KuAWnKOhoxe3spttIk2bHDtaD7WSUktiz6gGdBQz0rDV4Y
         ixSujHo60PJx1IUTG8QsiuQGWpJbYAvju7qtfOYrVypDV7LYn4ToQg6ev5Dd1iByImrd
         w6hUi5dGlPtIm3qkmhLPRpkwqPmzEY2geUU50qfa2Y5dEDZag6yDzw9U4Fwn57fb9y5h
         rtedOWTZ8+tnOQdIy5+uolLnepeeW1KOCbm/KBYSNOv4bW10clIfVpIDNzuoGRDfxGja
         dAYA==
X-Forwarded-Encrypted: i=1; AJvYcCW0LQ0yIT3ARqgVhJqfyylkhtPq0pcsAU0ECpbJBWZvem4YgSFCrIULprpkg3WJVMYjLT1Nxrbomn7H1iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfTBFnh0gwH8p8roQjGnu+htvApu/Pc+XMAwrgr2BusAqmaUNM
	95KWwUqt2rbPmgI4ffr7ruVY6ph/U6lJh7ll5raQMunDobvN7J9LtiIlAmcsHB1SBJNmMpWbtj1
	cYGUqbmZvcGBlViYwOu887CwnakS8f8HlzKsMZQBPtXTnFm9XA7YdLplEJ5IXQYB3AFI=
X-Gm-Gg: ASbGncuqi4c6+EMfhwGdhvQ6dWayP7d+G5Ul8/pjaJiqlDakZEbrLJ93xopvzYBE5rb
	sDzduOXuBRNYDm6wEo0rnr5NpTFXd6YaHW24jS9TdwfHIjPd7yImjbbwahnS70qZdMXLc02Doda
	wKGQbeTI3S0WyF866VpQh1Ybt1iIIcIwqvPSWThxfH0QzLmaHSTy00caMstnYxghAKJ/W+ZYRJq
	YEruX0AIHkpnKqSbYMeXD3RdE1iIQDhszOKVw/Wc7CDjSsnM1uL5oyRk4y+mWccXXxkdamYqvEC
	Emt5lcUaZYOpHaWV5EO74RdlYYJwlWA15SjealwgN+U3e5/+x0/cn/LEKGQR0gmFblcaBx+ZdGo
	ueZMA6RSo1hhP
X-Received: by 2002:a05:622a:112:b0:4e8:a3e0:8106 with SMTP id d75a77b69052e-4ed15c29a1cmr43483551cf.57.1761749021407;
        Wed, 29 Oct 2025 07:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExa12O4yxMcXaHXaMolo7+zrWVZU4hDShXRUR4ZvuDxC4zGr0GrN48ikAZFN2nClBkOKeCog==
X-Received: by 2002:a05:622a:112:b0:4e8:a3e0:8106 with SMTP id d75a77b69052e-4ed15c29a1cmr43483201cf.57.1761749020952;
        Wed, 29 Oct 2025 07:43:40 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e387a14sm50768215e9.3.2025.10.29.07.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:43:40 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH] ASoC: codecs: va-macro: fix revision checking
Date: Wed, 29 Oct 2025 14:43:35 +0000
Message-ID: <20251029144336.356816-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AuHjHe9P c=1 sm=1 tr=0 ts=6902281e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0zzDRROiBSe0RgzfM-IA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: mU-HXQ1EDWyBktbBnbi2VfQmZJOJyZ_1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDExNCBTYWx0ZWRfX+DyNEPtHhVRD
 vlkZMX9pg00EEA90eJN3+bAotToqJIHu0B75yvqJus0qibrCgS2nnngmRn/KE3hXGZNbKAZ79Dh
 rgCXgeKyp8YTLpHo6GRpYb9Qhq5ka0uv757H8IUI9lPLMOQUmfF0+sG+WpQo8bR2hGD2Y7nvTZD
 kP5TH8ml6j/uGjItg+uce5C475CCL/Ekw0ntX1G1cpVyIB9i1TNzGj4/235RuIT2TW7yWJn+Odc
 OLSPNC7Ld3gQJTR+VwzNoPd+xTGcGhogkZBxTz5bbh7eU2BFM+SnZTERdz6TEJXwwTIMbd/cch2
 sl0BQOTk90/fa+hGP47ipP3XveZdbUrqD870UO0dK/QdVwqGFSHK7GM10sSnTqkOuM6zdwl7QKJ
 UN3OORs4XDjL0TTVIcPaa4hwmhrzyQ==
X-Proofpoint-ORIG-GUID: mU-HXQ1EDWyBktbBnbi2VfQmZJOJyZ_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290114

The revision rework patch seems to have reversed the bit positions for
macro presence in core_id_1 register.

This broken RB1 and Arduino UnoQ audio.
Fix these bit positions to correctly reflect the register definition.

Fixes: 281c97376cfc ("ASoC: codecs: va-macro: Rework version checking")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-va-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 2b0ecc52c6be..fbe5ebeeaa80 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -67,10 +67,10 @@
 #define CDC_VA_TOP_CSR_CORE_ID_0		(0x00C0)
  #define CORE_ID_0_REV_MAJ			GENMASK(7, 0)
 #define CDC_VA_TOP_CSR_CORE_ID_1		(0x00C4)
-#define CORE_ID_1_HAS_WSAMACRO			BIT(3)
-#define CORE_ID_1_HAS_RXMACRO			BIT(2)
-#define CORE_ID_1_HAS_TXMACRO			BIT(1)
-#define CORE_ID_1_HAS_VAMACRO			BIT(0)
+#define CORE_ID_1_HAS_WSAMACRO			BIT(0)
+#define CORE_ID_1_HAS_RXMACRO			BIT(1)
+#define CORE_ID_1_HAS_TXMACRO			BIT(2)
+#define CORE_ID_1_HAS_VAMACRO			BIT(3)
 #define CDC_VA_TOP_CSR_CORE_ID_2		(0x00C8)
  #define CORE_ID_2_REV_MIN			GENMASK(7, 4)
  #define CORE_ID_2_REV_STEP			GENMASK(3, 0)
-- 
2.51.0


