Return-Path: <linux-kernel+bounces-876641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA34C1BEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EB51888BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595535581F;
	Wed, 29 Oct 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uopo1BI+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FJwpg0qN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D4355053
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753683; cv=none; b=LOm/GYFEOhPw0uZcGOIzk7JSU94nKxvgnUPOI8oe5dbIivIUcYaqwDzZEqeb9NLxR/IBPQQJcAT2HScgdR4ZYwnnva/H1E/3KD5UZkpneptbApJ9bxDt6GtwaM0rpb9uqdGoDoeG5k7pzUz94cZX/8BFjFtBhE2fiWH+4KkHcMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753683; c=relaxed/simple;
	bh=GsY8XliOywntV/lSkdR2EomMbEJYJdhySDnjPJ9zxtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLpfThKK0sVr16P3DG/W1asA2tWB+OEU+G4lNoLqYrAu8qhPAI17BJdHhcqWgbJ9DPOFiDP2Lu5Y8RP3pdh/rlyQstrg7PYDbBJwwsAjZkc7nM8+j3Nnqb3ysrQumcD483hME+6/GZx8unW6utzX0RiGBl9p3OrEXCjiuceDMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uopo1BI+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FJwpg0qN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TCXVr23720398
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bCQYJqybrY4
	QyIi5nJG9oiSEgsqPll1C9TpKkvG3Kps=; b=Uopo1BI+3neqkrYpdEHJZFPWU85
	BePw8Wgpkah82je0ldGoTb0qmRJzwoQYS3b51z3JmzXKU1EtpAH+qsx4XqiR69pD
	puF5HXeDH+DiJxgtPrduOy2m+xaGUvsTAbE+fQXNHH1gqE+aPl6atjso3FaexfJG
	v+p66bzeEUP7UzaXHF1j8p54hUu9J0uX+OtHv6VcUs67pqCugrpE7blw4gi0C1FC
	+UcjPiLRyJvIEP+x+XhivZHgHIMmdPy2jnDt0nIwDT4vpJH6MpjNGGyUYpZ0zCfe
	uZ/26d+sBaAAPUElQtvLhSMX8/90MIj/MCrzjEflBKWegTeOdZax+w2fFQQ==
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a237g7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:20 +0000 (GMT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9447edc234fso9863239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761753680; x=1762358480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCQYJqybrY4QyIi5nJG9oiSEgsqPll1C9TpKkvG3Kps=;
        b=FJwpg0qNSksm707+zIKFP41t4uFV4GrWJT4t9nl5eWg5adSHjb3joyadTlFYgkOujm
         rdrcqLE3nXdDoBUhZ7045e/0FP+09oCZ5+WP3OFPflHwxJAJDriX1MEXWa+0ZAg2+PW9
         5rtYhQgZ9dxBHvlvvwk9kT/6ZPDsrX5t8eQlUjeS1hdxdUtKDvtZXLbuuuhvmXaaUrUg
         hoOznqnX4HrUlqrW2M/g2ijonnAp/kDkaH203HKqx5iQybWIPiAxILo6C/idS1fxVL0T
         6csTKYhwhL+//dX/isCCCk1i3W65rmQxsoP5AyHCUBgjlujxIFin9gDaiMhmPVk+c5CH
         68Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753680; x=1762358480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCQYJqybrY4QyIi5nJG9oiSEgsqPll1C9TpKkvG3Kps=;
        b=ptNZtrprtkh5G6eSHtw1YnnVrYe/ber4vLKVwT//EcU07s+Yzm0H0+4T7pYRSlz1Hg
         v9nf4AmB8+6dUgfJ3MUaA4e6SMGOWYEhrV5OEZ14f3oD1s3OmCAanY37cePpOC6m9wnY
         SffuOdkNr8+9eeV9Z3CsNJnHM9Mfuu8UpEYIFCDb5GcVkowzuKxOeHfPJqFxD6JN79la
         rQGdbjEV1Uiwf9aBaiwePYVpqSGg7E1IjkwMHGvTehBm+rwSCXvrR+Sa1v1yf+/JSxoS
         VY9mS/+ilEBK11aAc3RxSojn8OiNDX3pDGh667wJlT58U+7UbV56TOvUbkWaK088JLi5
         n25g==
X-Forwarded-Encrypted: i=1; AJvYcCWrNN9gwC0VJHr0UFKISNWaQCcrJ8wKBWKo1F0yDOJ5jnMsMAKskaksXlk7gGp31Vl3P7T+HtAO4Yg0E58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb8W//++T2Y0oq+Z7VVpDEK65fMCIhzh2HmbFTtRpFOrfpGRft
	8FPJ5rCHFyYFuwF7ktg3F9sYCslo97Hd/JM4doZY8iOyPCCTrgFFpGcpzkXFP9M+pQVL3w5F7VK
	aR/TG9AtpVP0KO3NQj0DstYmU+hfCD1xTH19OprBDAgZn3F/Eh3OUN3rPm3Bvz1mDk4M=
X-Gm-Gg: ASbGncvXyFzHlT8gh+FQOtNlamOPonMzFBgHjq2bg5wBz+/OhjvkdaVtmfo8j3BGM+I
	mFz48PoENIdcsEACyzgDBk2DJyTv1TSyFfL9DfwlpgH7xLogDb7MPF4d3lLKBENa7E/e4m/t0Wc
	f9xolqXJJqMVhnjratATwtJYfFhvxvp3mhc7PLDZz87AvMz7GP6wo2lR1+UGXnPWVF5oeNyDId9
	3mUSJoLiyW93slJtKbu9wF8i67Hju22ebwlRwI1g0+Y8W+7BMX81Z0PylFu+T7Da5xrixvwaweQ
	SUSSMiePHOS8fmd8YJOrv4I5jMfhKEgapLLP3mE7xqi/Y/2CkeGKTs1Y6ojdnKS3r390XTTNswR
	QWpTAZPqKEYj4
X-Received: by 2002:a05:6e02:1aa6:b0:430:c77c:cc35 with SMTP id e9e14a558f8ab-432f9086d91mr48455285ab.29.1761753679816;
        Wed, 29 Oct 2025 09:01:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjE2ILUkFn3/Lrhrza2F+LZELq3MCwWNFyOzyJeSoP67+DN5uQCi8Stu/eGsDknJ4oEUzAEg==
X-Received: by 2002:a05:6e02:1aa6:b0:430:c77c:cc35 with SMTP id e9e14a558f8ab-432f9086d91mr48453445ab.29.1761753677620;
        Wed, 29 Oct 2025 09:01:17 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e27f7b8sm57154535e9.0.2025.10.29.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:01:16 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 3/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add sm6115 LPASS RX
Date: Wed, 29 Oct 2025 16:01:00 +0000
Message-ID: <20251029160101.423209-4-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEyNSBTYWx0ZWRfX+ViyBrMMCJ7t
 labuG2xatoZ4ugO0KNmbqEiMC6sMPB35xqr2NfeWYbbkLsYUVzsQXbAUShRqfBnHFS3u/BcQhLZ
 wGEvvreih7P4fHS2/oFJe6YCJm807W6xIvKHK7exc90w/CXwzk3+AUxAH8UjYurRvUjQRgczFtV
 SpbGoxH3fygeqlyV8lY8975PUblmDlW1PZ9bKhVaihRzVnGGXj4qq30XL7xWSoJWmSnZgNZB/n4
 aC7f2qFUXTHSAbI7rIrVzucmL40WINjZMuixfZQBAItduoZd+2uGGIcxXQDHdCaILKBB3X5H6pC
 EIabxOdXlV2A4KyaXLdS9R/zp7lxfITqokG09BhUhPvV3NI2d6jWL68AiiVBeMTn3NpTdu3ijWS
 RcRqC20W2GESHyVTvOEfUGE54EmDzA==
X-Authority-Analysis: v=2.4 cv=V5ZwEOni c=1 sm=1 tr=0 ts=69023a50 cx=c_pps
 a=7F85Ct0dzgNClt63SJIU8Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Y2NZmO-KPezWHx3tqIEA:9 a=LKR0efx6xuerLj5D82wC:22
X-Proofpoint-GUID: AaybtObP2eLis_n06V1OqL_Bcu_VIi5a
X-Proofpoint-ORIG-GUID: AaybtObP2eLis_n06V1OqL_Bcu_VIi5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290125

Add bindings for Qualcomm SM6115 SoC Low Power Audio SubSystem (LPASS)
RX macro codec, which looks like compatible with SM8450.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../devicetree/bindings/sound/qcom,lpass-rx-macro.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index b869469a5848..7f9697831918 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -25,6 +25,10 @@ properties:
               - qcom,sm8750-lpass-rx-macro
               - qcom,x1e80100-lpass-rx-macro
           - const: qcom,sm8550-lpass-rx-macro
+      - items:
+          - enum:
+            - qcom,sm6115-lpass-rx-macro
+          - const: qcom,sm8450-lpass-rx-macro
 
   reg:
     maxItems: 1
-- 
2.51.0


