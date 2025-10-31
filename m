Return-Path: <linux-kernel+bounces-880092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3485C24D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605CE467CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829A834887C;
	Fri, 31 Oct 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EIaKnxI6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ANkG48Ua"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F23348872
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911317; cv=none; b=DhnKQcvfJpXw5PLsIRsLiRkmmv7s+yCGBBBe9nXAVhX4beVkQGsAs5orW+pOHNxDEemtv3rMMq/5lMx+5GiRO5vcAWCKCZE+JNFGEZUXbmFZ36LVTre8VsEHO9JgXTBftkXrcWFV/2SZyWvkPRvGCJ9zY1nPOoL0nW3ILELN5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911317; c=relaxed/simple;
	bh=6qhZ2V7jPWMlO09vJWcPidbXDMoiF5TkOHsCoJUNPBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y03O94FzkRwFep7k+qXeQDLuTpKys27nsDP0qEIKWiievhw3c/xz7lCmvW9Wsog76jSrX+cBF95Ib3Q8LSqExI8PS+X6ikEwOLxIthglzzdbQjehMuU1pnvEGVJnwyO1WzIdK4yZK0p39IFscgYDQWYtMFiLloqhm2FX6s5Zrdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EIaKnxI6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ANkG48Ua; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V73WNc2058996
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j3qsn+XRU24
	M9cd/quCxFZxsbCcNEdloWtUmT5MmDVU=; b=EIaKnxI6WuzddOV2dLwhYc8qNQf
	GekCk3EmIjWY0PIVYrcfcHg+zw94A6BVYQZ/i7QokTU6s69FTP8N+NaIsxEW5cNW
	MNkkZOR/wnZBBSqKyY3F/VkCTNKnFVtm7TNWn1KkTfOz9uTO5EhhbydL5sJ3gfGZ
	m4AWNoV6bOd7F4cTFT+A9FOKmeNCtqLz9rtGsBaARBCu/giQsPI0ILSCCqjoBoGf
	tGq2M/NlTUCOw6jD79eOxQTWtwSz4VAAmfEz7zFeYe8wgDaRkg0ryW9WZ28F0DEU
	8xekY1QcSgVIANDU8r8vlTzqikP9cVhj81zK/60KUDPy213+9eYi2xadY9Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4rcvgs1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecf3420ce3so41820041cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911314; x=1762516114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3qsn+XRU24M9cd/quCxFZxsbCcNEdloWtUmT5MmDVU=;
        b=ANkG48Uas84CEWVZxyQO9j+d0Hs5+seDnRjHHL7+oO8XBKsKxIMRnI0mSZAf5qIG5U
         vE0HOKkDCWA62iHSeM8KxqQrlxg5Ct2UR2/huly7tjMa7V9X2ggQUwk4bPaBxuNvrC6j
         IwgaqJMYcH9I8veLSH2wMuBi8GsuMCJP3+pV1AFzwCV42pate75qOTIrLE0cdOVgMH+q
         NgSmwfxX4sfpiNMgim6HL8tKRV/yDyfR/+4b2g9M1bbMnbC80+0nC/zLUfeiJ6OGm6xv
         fW19D0XAjOedijhFgKAj76VMpyUcRB6WgvATm6mtwsYEctOBKy+LacZxlB+rta8fnfyG
         /Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911314; x=1762516114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3qsn+XRU24M9cd/quCxFZxsbCcNEdloWtUmT5MmDVU=;
        b=tOrX0hV+P4WyqzTg7FxnyqDUSYrbjn/7qHe2Fi5bexOMF+8L1rmdrkJ3CmTm5Uygqb
         DkBxRlqHfh63FjRevMKTfPdsJJlnUi0EpWLQCWMHOQYYbWtfh8oCbF/EslL2yOd1flnj
         0D+tb6TZhM/bzQPVREUHNCsCh4mFE2iJGnPvTfc5Qa43d+qPGLH15nvh5ikBKyNL7SkC
         AXADO3z8nFksTs9TNOhRQ4I8XAXPLlFBhnitHA/Nkk7a2kwqIiEsYMaJOflpoffjBToy
         auT4RX2V9fGfTDDaVT2DwSy6US8U+kt0D8JMRhP6TYblWV1/wAfJgrhf2nUXPxsHLTN2
         IFVg==
X-Forwarded-Encrypted: i=1; AJvYcCWj8ifKBlrpWZhvt/ydSf1Yfeu/1gv0kXK60jYC1gwTVDheuNVgNSKJGYHkWT4sQomH0CQpwDBvQvejrpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/TsfTBhWY2VkMh9zF9h34gxYo/ZYYfwWQ7znlqqUmGzv09qO
	DLBpjIL4JPGixzhEbuSckuszDjK4mju+duzz1HnWiSS9x1UJINxP25D8X0MRc9poRD/wk1icZDI
	S1DGxWGnuMcp65oyF2cmHH4AoZFrx6NY2fxOyLzgozBSN5lfyGsy/CHArS265zQjs3Og=
X-Gm-Gg: ASbGncuR+K4JunNIv9bNGfztn7Z6FWCEGczuoq03KA+SkQCP/LgvL720O+qnfxi5rrR
	w/W2bOz6PBKB92OfAIJKAPG0llO60DUjDIYb5EEG7PeQcPSQPoWs4Rj+9Mwpos3rt86qn1RYscn
	cv22tYgfvzhTsjXo5/juWB5lMP7ye+HEErfPxaOL8ZF4XUpOD4vTyEZ31wVI0AjSwC8xqDXQRGx
	G/2BYUMomKo0UYulQawO9dDez9X6xjOW3MqI3iVz64Xw0gUaxy4O24gBwkhzLiazaqnx5EbIA8U
	+Y0u196fvrSTWNFaS2+J+8ucDjAGJwyxGSPo2JmC8jH36HY47JYlAsk9GRwuOB8eJBsInPH8hOV
	x1IClUdlHFcoG
X-Received: by 2002:a05:622a:44c:b0:4e8:a3aa:7a89 with SMTP id d75a77b69052e-4ed30f97698mr35247751cf.45.1761911314473;
        Fri, 31 Oct 2025 04:48:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx8pA84RF2TkqEabXHMntaiGr0s/X9J/igoE8sRfJ6NgMHoHpJPy27oEbX9455Qvr7kMu1sw==
X-Received: by 2002:a05:622a:44c:b0:4e8:a3aa:7a89 with SMTP id d75a77b69052e-4ed30f97698mr35247421cf.45.1761911314041;
        Fri, 31 Oct 2025 04:48:34 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728aa915asm86831165e9.16.2025.10.31.04.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:48:33 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 6/6] ASoC: codecs: lpass-rx-macro: add SM6115 compatible
Date: Fri, 31 Oct 2025 11:47:52 +0000
Message-ID: <20251031114752.572270-7-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJYb4f+Z c=1 sm=1 tr=0 ts=6904a213 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=MaTAXlxkpdZwQv4a-28A:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfX/5lf+fTyJQL3
 yKG8j/Wm0Ph8HNMlp3mV76OHyyxtcRO3E+Enyan0GlKAwVxhK6dM05wh7bEvHyiNQN4rEYg/7QV
 TJATDjuSKr7gSQpFwR0VbIBnX6BP3YauHNC0vcz8BNu5ziNps6nBT3dOWbjsxyTjOuiF4wFsRYL
 NVVoGe/K3t4m85kN2eDR8SL4tytOKR35RQDJJuaTf4V1Xe0rWaqTOdOF0h9FhGDYfCuFeOACWVa
 i1NEHbsMgctKsLYQrUIedeAdXqWfN0bXWnVul7Osua4UXFNzhenq8z1xzjZlR/hgFMXLy5SJ7oe
 aVv3yDxRIFy6P6j955rqzLi6kiQvcMIky/WxkOwmSNlFq4lk1gw/oFOG8gRl7eIcOzVPFMbudXz
 lopgqVPTc1hBBcf7a+9Mf7PAGkzEZQ==
X-Proofpoint-ORIG-GUID: FBbhU920uGDoStTBPK91Vx-6ZexgoXel
X-Proofpoint-GUID: FBbhU920uGDoStTBPK91Vx-6ZexgoXel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310106

SM6115 does not have "macro" clock, so its bindings differ with existing
SoC support in rx-macro. So add dedicated compatible in both driver and
dt-bindings to be able to address that difference.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 9053c93bd44c..f889fd17f166 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3951,6 +3951,9 @@ static const struct of_device_id rx_macro_dt_match[] = {
 		.compatible = "qcom,sc7280-lpass-rx-macro",
 		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
 
+	}, {
+		.compatible = "qcom,sm6115-lpass-rx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
 	}, {
 		.compatible = "qcom,sm8250-lpass-rx-macro",
 		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
-- 
2.51.0


