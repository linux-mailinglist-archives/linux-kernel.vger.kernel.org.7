Return-Path: <linux-kernel+bounces-831474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE2B9CC41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C88B1BC0A83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB93D1DE4FB;
	Thu, 25 Sep 2025 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3JG/jjX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731314A4F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758490; cv=none; b=SnBIGvhO13oNedFDkGd8kV2Aa/3cQA6NPmnou4fRgZiVNabn/5zMyS5v3lBgTpB4MdcRFjijvksE8+zPnIy6q4UGCgXZVgeeWTwffiduXIZ9ioXxFaYDffIim/+X2o5LVxPOVi0wWSYJsTZseoBYYrVYggPCO61GNM0clMLG9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758490; c=relaxed/simple;
	bh=2S7wvWXh52vu+wnRGR4BJ3o9wnSisMc90P+h+1e08P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwdTZ8y5zQxrGkJJiil1gj4r654CRkj39UNxc5OhiveQqr4irrYSxYl8RSfHHRSl/MLKs1zb1dW+QAMb8KmPYrYL1eF37McZtkwIBKqZBgDXYY62To6CJNqsIbfkNJGsS7cg4/FonP/qQh0JWkjc7WGYhvb+7shSa0d15WuqJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3JG/jjX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODbrTT029619
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0OEBm1RnS26Z+eRtG67meW0s1XrkCDmtmh5F61o6fY=; b=J3JG/jjXnjU9J6kh
	HRWik2cqrz3L5uXVC0Xarh43HNyE2gxAxt66SDMNXO2wN2KwSzTkjscx7RDH2ypT
	OQzUA/mD3Qi/jXrydDFlXgSYMcBB7FPQBwIfm+4fdqSd+Fr0XhJHje2a1BIWzDWY
	S3onsTiYMY80V0396B7iT0tmYN89vIaK96ccpG4p64YMZKV4B+N25+mdVCQVwo6J
	GQWzVrTgDwSoGUHSn/ZSBoQ06BdxhZCcXYN+ZLe4pg8yxqQiXZqHm7tEiwXow3DY
	Drrs6snLHqfcYa4tUxvWTMdtd9iqFq7i+8QAkadvETPF8WPMzd3zOghPuWFfrtDQ
	dJ841g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fp02p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so330258b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758488; x=1759363288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0OEBm1RnS26Z+eRtG67meW0s1XrkCDmtmh5F61o6fY=;
        b=lwXJ2cA6WqQuTTSaCS6HcpmQBn6s2poDRpg0Q9Lkl/XrknL7p+2ddiyrtRwSgaicqY
         0IbnGDNgm6Scc+eK8dRKrULJQ+gq9S6Qy+Slf1ZuKzWPfxq1hZbz2UV3oZs8OjuCqDmH
         rW9rBr3nHLGxSZ2JsN5MDvYEk+e226EcwW0OXZfqYAPAtIjGUH6tsN95fguFT+MLotfd
         8bl4i7drEWLhQjrPnzB1yb6/YocK2+4gesDMs65AIK8a7jJR2VJAXdfNR1flmVy/BW7Q
         +5AXChXv9KknfeC9O1iw2W7sJz7uYQhbZXhUdXJIUMnXEn6juGz21zGH5aFf76j4NDov
         orOg==
X-Forwarded-Encrypted: i=1; AJvYcCWSwXSrI2XpQeYUSc6P5sz7oqwCLiXN1XhuA7BkSuwtNBRuSCQH0KXxwohMNwiaEl7MfktT3gLim7oRCSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UcV+wZR/MXJS8Qw//DXJW2pWQ2SRi3gm79jM/JFTLhYfb4KJ
	69lgvfBuBKJ3b4T20w7hMznQT3y5x2JvCAcX42pKmvgixZYEt6p2ILVXg3+jLscZXHazixcwtBQ
	CRhZIpW5U3yaaS017Hbi4K/70p0/30bLO7EY8URB8sP3lJ6WHJVTUBvAY3+ctoYQGqS8=
X-Gm-Gg: ASbGncvNMMyaGQW4ZB5esD1NavEVahCgx045ltrMmPhw7gCz8Fpix9msS64FrmdQ/8j
	Y98iK0mCyjOz1oXILYRQlo02ChJlfjPkUHE1qJZIfIABjodFODyXgH6oUlNrOBGZLXhl69xU8qw
	zMbt48a4Vs3M8XIkLybnrIJ3EgucJse7MHoJS2RifWZ777SwxAvBfjwvC/scoZT8hGgpooBKnEW
	Cu3d22aGtTFbiGNtG/K4lbsuK0aTaMpinKWgKFxJMavYPH7XWaa0zH8elYznv1/XJ0tRZUF2qes
	NvmGJl6eMkyMjeO0x3cGWiSME/raTvfe853eLIb7l3xBXXK8/ohKH8SNStA9FHGuFxThrfnRHNy
	OAoGAIyWSyMFkd2Y=
X-Received: by 2002:a05:6a20:6a26:b0:251:a106:d96c with SMTP id adf61e73a8af0-2e7bf478c02mr1819135637.10.1758758487668;
        Wed, 24 Sep 2025 17:01:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzNuh3Av7R4gC2b8bh95S8AHR2YvjRgTYw7k8EaoMUcQxNqLDTZ5+Kh+DD6EFGVU/5rSBkGA==
X-Received: by 2002:a05:6a20:6a26:b0:251:a106:d96c with SMTP id adf61e73a8af0-2e7bf478c02mr1819075637.10.1758758486852;
        Wed, 24 Sep 2025 17:01:26 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a1bafsm423152a12.43.2025.09.24.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:01:26 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:01:16 -0700
Subject: [PATCH 2/5] ASoC: dt-bindings: qcom,sm8250: Add kaanapali sound
 card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-audio-v1-2-5afa926b567c@oss.qualcomm.com>
References: <20250924-knp-audio-v1-0-5afa926b567c@oss.qualcomm.com>
In-Reply-To: <20250924-knp-audio-v1-0-5afa926b567c@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758482; l=903;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=/I5Gh2eYLKEy7ErQmMVLe2xAiiZ0xMLF0xKldvwzBHo=;
 b=bPIPTCEb/BeOXHS2eoDQIMQ8sca42xqvYdM4rkqZt569KYm880F8rolGAlZZ8emwzp8bsy4jQ
 qob/B10CMOlDWm5qg2BPkSn3LkOJjHLFK5byvJmjZi4uZX37sIRdAEB
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: 8aDY-WnsNzHs_D38wen1Jg3dkTooqg68
X-Proofpoint-GUID: 8aDY-WnsNzHs_D38wen1Jg3dkTooqg68
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d48658 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MCV5zX6qGx6s6p2FbZwA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX6cn9H9BOhBjH
 3AIyfHVW9cG34uY0A3HWQdnnw/Jc/5OJV0y/08Vc0iADgmbKl9Nxs5iZ+lL4wkUHD/TzJk9Ujjk
 PCGrtypN6jdDJ8Bu7sL0ouy5NURldE/6X/RxIqb6rH8nvmtbI7kT+fG2ALyvf/l1LD8c8nMwFvk
 BLnPTpiCCK/2cOO1sMP5mjItyGh3BBKR7q3z8TiiRMYSYuD3nmn4QXmIRN7v5g3jIa/EtvERHVR
 Prnsup3uniAIX/8ZQR69I1iFJFw97mfKFebm2AvCTSBGixtCWRly+c10Nto6tY9NiB/zkfBblIz
 wmr2pToJcuuh7APIE6xUbPJyCVvozqVpsKldIjwNIzLwW/TaEc48cmwKb4rdLgV5vHeS05kCh67
 0LIha2i4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>

Add bindings for Kaanapali sound card, which looks fully
compatible with existing SM8450.

Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 8ac91625dce5..708bae805403 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -23,6 +23,7 @@ properties:
           - const: qcom,sdm845-sndcard
       - items:
           - enum:
+              - qcom,kaanapali-sndcard
               - qcom,sm8550-sndcard
               - qcom,sm8650-sndcard
               - qcom,sm8750-sndcard

-- 
2.25.1


