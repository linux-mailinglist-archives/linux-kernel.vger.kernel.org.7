Return-Path: <linux-kernel+bounces-876637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE5C1C75C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F66662DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260313546FF;
	Wed, 29 Oct 2025 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DT/xK2qK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BtrECFhd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E73469F1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753670; cv=none; b=SPXkSnVHAxifusKUlUDm2d9GiAdW3h3Sg3SwEdZ4c4GUr5e/6nS0EEqxgNd/Bi8sddCVJpkSbYAkKTNa7LUhmLAOq+YM8lx5Zb+VoQHWWpLKFJN9hqyuBLgHdYebMy4qJwwfVi5P7gV2ygfbj8KZQ7HBx3bKncNsFZ+3mKAppZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753670; c=relaxed/simple;
	bh=TILMcgRj0kC60wf4eiNeL+x6Ppo3TKOdtnZW13u6rEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtlgUsdqchM69zebe1mNysw2TfDAyhLW5hQIe05QA76TGoLDPVMXvtC1PH3/Lcxk+4QQAzdx2JAnM/i0PC/ODZWauOWMMoBidx9M7APAPedAQgcZCHicYS1GiRU/xTy5ZDVyq/Mcs9hvVcfXnKdbmFrYc4/+DP16xuDbkuzfcEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DT/xK2qK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BtrECFhd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TBeB0N434961
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kkVD4J5QeGsAGYyihfrN5ZhJkOber/W0iUx
	3w/k7ZD0=; b=DT/xK2qKa5JtmyI1WU/9Ici3j/1AerHU2c72sfVfVIUjIdXfN+Z
	Qu3g7J7XfnuaIlQZue2mW4RaMYRams0Z21n1Xa9fazra/g3n/aznvtF/m40laJSc
	ypwOyATWAXTDhkil2GdxtRkbFB4jtjN+AOFRcWF3vOLdqpPFhC1uq8QwPqpV9UF6
	5PjtMMEVcXpGmZKHwmNoDJv2pD4D0mzOVUU79tGRa17Jvbgp7dATY5ZpkjtcDB6b
	nNdxD78crJTnHXodf7ib9z3tn44kmIn16lWjynDOevTrbSnw5M/ipqoMeXyTQ0LQ
	g3cvp8x63xhDvSpGTjq0Aq97dsQBEY2fZvg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3j8jrt2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:07 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-556a45a4519so4541e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761753667; x=1762358467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkVD4J5QeGsAGYyihfrN5ZhJkOber/W0iUx3w/k7ZD0=;
        b=BtrECFhdmhEjFqLU3Ws1xrevl3gjOObNXtujQXOFh2Sc1Lo/YlHmtlnfvIpZBwkNiD
         +1A5FkR0OCWElb4ltZE46uZrD3sHLPirJWtEFhRXctzNRnwp2mH7tRB1fm4zzyBL6grV
         Hm7KmuNJt043GXGXbAjSNmsLIFmOuTwKCd7YRUtEGuTxWvjEoYE1C9Z5nSnECn26Oe5e
         CWyFZd4AJGuJ4t8US5CHxMmNR4hjm41KqQDpuZBcun7a1g63maelOFa+DGX+UH7bPoc6
         pBJEB0QqFJ+4sJSTw90YCyTtxTXLWuDmQmZyawoZdty/5v06/D+IU70lSxKcZmEbskcm
         INXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753667; x=1762358467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkVD4J5QeGsAGYyihfrN5ZhJkOber/W0iUx3w/k7ZD0=;
        b=wjwMOBJhRvuEyB/FzY6/hoYEqcFhGNd4YbYSOhxCxUT/F6JjKX1GZTQgbmoTJHqI8+
         EByjtNRkvZmMX7IUZ4Y3C5jIJjG65wTM8xHHIFhoKDzi4FtCUwNvoF76JWEQQvSjrC78
         xiTAL4s0o3Yg1aojvWIqi04zIMl5OAewEgOv4WdWABfMEG3Folj95CEnUpVKLtLI4jRX
         +B7/hTh0oQ1uuLPvIB5taM35XHBU/StEQqwWznDBHumqqEDW1DIMC7G8izukhgDiSRgS
         m2em46plQErtxBFhcdNIsmPU1QklSzs3c7OhMDH2EcoLqtVIWhKU2S6pjdCaOZVdLoOk
         fElA==
X-Forwarded-Encrypted: i=1; AJvYcCUqhlS1339G7rCRQTH5Ec1+N/V2KV5/pvqv+ZHXKgZIuiDnT59zfSHls/gBB1ZjTG8F9xpFFpTD5XLLoOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUL1GAX8u5BatdImhx9OqBjnSBTLkBgJvLj8HI/JAqeTudlM8
	Tj/O16UIwaWukGmw1jwVUIItX0HVGhssFUon4yLYTkPPdgZmm25J5Grp2SXO1fZSbEdBePlDGfU
	N1rZCBzmtCcgPJGyOtqRFtITONe7o1+NXrZLCkGi6WqeSOMirbf09t6cl/TUi3iGBtYM=
X-Gm-Gg: ASbGnctg05dHahK9TUXc+7w+CSFsyg8okIgLxnmRVm6vI2L7ndbHGYu77AAo+QHomwm
	UjIHiu9aNX8IuiZZkvoLDYAgPzPTZnYufILACLudrcfXrl4W1v4/avuWVnBbqb1a/4AiIauwlK/
	uUKd/67AElf2JI3/a1J9kO4Gx+WbYq7MT9CHQ3KKmXmMYxY4MpfupZk31nXCTTL/rmMcY2HZn8w
	zotOVAZrscMu8W2gFkjVT5TwAF8p/teNFXKlwvM8gMbX5nBna4BquVfte9PQ6ZhHYIIrxQ7gxfK
	nor54mySXmujkuvN+cV5/WrnCI5gjTAoWGnok5p0/00u3yZvIzxYC7g3keNIt2hIkb3+Pc9H3ku
	bj2Qh9hj7j8Df
X-Received: by 2002:a05:6122:4f93:b0:54b:bea5:87ee with SMTP id 71dfb90a1353d-55814168731mr1307466e0c.7.1761753666778;
        Wed, 29 Oct 2025 09:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjTP9FZKurkzCHatar3BEeLS2nx9Ae/R1xxfOgAjHIz1P4IfYhsPpkU2tFJSrFrwOXmEN0IQ==
X-Received: by 2002:a05:6122:4f93:b0:54b:bea5:87ee with SMTP id 71dfb90a1353d-55814168731mr1307352e0c.7.1761753666080;
        Wed, 29 Oct 2025 09:01:06 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e27f7b8sm57154535e9.0.2025.10.29.09.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:01:05 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/4] ASoC: codecs: lpass-macro: complete sm6115 support
Date: Wed, 29 Oct 2025 16:00:57 +0000
Message-ID: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEyNSBTYWx0ZWRfX/BPLBUhupmfA
 VVns+UJlqVTap2aMJS4ymb2Hmj19ZZpn/BZvo3pcQlZpkpBX7I8sDwITpE+BdmBXELCd6bdB/JM
 iU00Jc05mYXXoz0iY6hVL38CzFgsNB5X+64oaOo870ja/+NnvYfpJfAl0ekQW+HDGwyvEEKgHaS
 TtVI2s/O0PEEeURzmJCHYTZLnL6EaR6QK8I1/krnuLqSOPPwfw8NlHGmJuHsMD/+ujY4XCrUmQY
 MId9i6WXUrn4rZk1WrIgFLNM9hA8bvReHA+uxRDlZKcM/AVpsLm09jw/vbDyR94ontCoQBDKH5K
 BBHMuOm0QAjhbWE2OM5lPF5IkqWFHeoN5Dqbmud0MeOkRGwYDgEYY/biJNftBBQ758PuwOvkeNo
 I67QZfEeDgtMQTogENxVGm74tMjwVg==
X-Authority-Analysis: v=2.4 cv=FOoWBuos c=1 sm=1 tr=0 ts=69023a43 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1oLurHACul6UgZ_C9z0A:9 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: DpzxCnzbrxYBifOEB9Dg0LIHXaTmraof
X-Proofpoint-GUID: DpzxCnzbrxYBifOEB9Dg0LIHXaTmraof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290125

This patch series fixes SM6115 lpass codec macro support and adding
missing dt-bindings to complete support for SM6115.

SM6115 lpass codec macro support is added partially and broken to some
extent, Fix this broken support and add complete lpass macro support for
this SoC.

Srinivas Kandagatla (4):
  ASoC: codecs: lpass-tx-macro: fix SM6115 support
  ASoC: dt-bindings: qcom,lpass-tx-macro: Add sm6115 LPASS TX
  ASoC: dt-bindings: qcom,lpass-rx-macro: Add sm6115 LPASS RX
  ASoC: dt-bindings: qcom,lpass-va-macro: Add sm6115 LPASS VA

 .../bindings/sound/qcom,lpass-rx-macro.yaml          |  4 ++++
 .../bindings/sound/qcom,lpass-tx-macro.yaml          |  5 ++++-
 .../bindings/sound/qcom,lpass-va-macro.yaml          | 10 +++++++---
 sound/soc/codecs/lpass-tx-macro.c                    | 12 ------------
 4 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.51.0


