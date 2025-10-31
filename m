Return-Path: <linux-kernel+bounces-880118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8756AC24EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC9F3BE7AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F84A345726;
	Fri, 31 Oct 2025 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fSdKXISG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YT8qa4ZK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DF347BD5
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912456; cv=none; b=bU1p6VIrefyI5zLkCGNd1iJBhdXHAUaIlxqMtVa/FtAunz6S2NNvGxmQ6qHUWvwxjr0J6p8O0C+4+SSMlOAlhEXMyv+CK7KyYXJrRfVkth1n0AEs3SgRgQ6UP8z5Bcjl3yB/BWUCuX4m1JSHe36q/hCyre7X66UGlqjWaqNh4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912456; c=relaxed/simple;
	bh=FBHTA+kR2fbsMsa/SrJEtQSqf/pZXq187Gm8uu9urMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/4+p2LXVHavCkzi3Fgpq8NgRWfZFF6OoVsXzfD2ivetfEjtHsEmcIAjIHZ/A7A3QXYubD+ArhGEIC+9P6SrB3Eykb/NmqUbLIwRq+x59B7bcTv1QlGa4OlWLrY5AgcPqErYuOvjhEwu2cT01SrwVDTpf8QYAnuWLT905hVZQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fSdKXISG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YT8qa4ZK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VAIPYm1416935
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4032bjOkzCR7p70VNAqkoxOuXsJLBApNSv9
	jSTqGdeI=; b=fSdKXISGFb51HUKLJs7JReOl4+DP6ySMFtD8dxrCiwqaW5ImG+f
	BmohCnrnQtRctcsIf8luHV+SBB6W/LIwHRU8zVsFg5OXiGYGfuD3sbcuQTPSLTtY
	dcCmVoZg/Hop7xNEcHIYUBHOXIdl2aRSmxR8FB6eO0czuGUqGn00j4EPnkzogdUf
	H7eMitzzbVzWqmvkecrvDRjie3rSsqv2HsaoW5u7f0FYTy/JQPtbBg0XeEe9s5+h
	l2SVdQXdtJ20kQd/2/UHL81QFBf9h8AB/q9LO7obCXhpu/IdYNWCsGC1nUDV1ibu
	CMUdYjuQ+3xrZ4LkXx85AQqLmBhvm3MfOEw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69hna2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:33 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9310723f466so596987241.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761912453; x=1762517253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4032bjOkzCR7p70VNAqkoxOuXsJLBApNSv9jSTqGdeI=;
        b=YT8qa4ZKck+WGZpnQoxOyOcL0EHKjt/tPH5feZz9qL6+lXV6kRRhx/D9aYNWFZpWaB
         iMGD7AFdemgiY8iY+A8wnKfQsV5DtYikRALuM268xXmAqUiJQnV14cryPqcCe9O7dwDr
         9aX79KbS7VfpkFnBqqjqTXgQRFIC7uMnTy1zlP30xXsZo0QJSMrVer8bV+Hd/d2u7HgA
         2UUTNEKOfDXwX3VqA9d8lZLArLM+iHWXSZ5/062f6CSbHe/ARbEOXq5Bo/vdw77mcokE
         ngf8mYsUToyDddt0a5hU8JHA7wt7IoB0qCWV3PmC1uiqmMOLVnCFirk4qeVECwv+xkHP
         F6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761912453; x=1762517253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4032bjOkzCR7p70VNAqkoxOuXsJLBApNSv9jSTqGdeI=;
        b=pGRuSEsyVAYP1tMmV2G1CwCFNZdpvT+B7qGXJ8I5mqWVwGsBH2pu3xEqD0Fucqmsnd
         jRHjYTAn70ewE06uKl2BrYBCBlcY/BOkGnTq6Cc0bGtH6gv9CkcO+JSzfFmauyGLNgfR
         kn/wWKsuD78a+ATgEiKAhwh2uqQDK0+/prCUX/EVnJCLxTHGeM7vzyDXlhjB0OTnZFFi
         cBkmjFq6undu3m0qhwfjjb2zg8V10t9ebR7D3cUjGmZvfwCuh6DV5Jy4knVlHwxvWQMq
         Nq4LQ/j5zYX5ePlTQsgl5b4Pn/FUX4genXkLpck+cVXdAXdUnc4nEKUjmRxkvOxU2EPc
         tN2A==
X-Forwarded-Encrypted: i=1; AJvYcCUjBh9YQbrZCfOVNPsSSL9YM9QcAi2/244ADqMcc3uxAP9517n0WjZomTVwfKO69sTmt99HdOtHXOA+OSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhAjWFvSslFdmvyOdWoThoYG7HZndiKrkgk8bvV0hhMinKMDI
	O5NuYGVUFHptVztsn1VlbWoI1naWEP+1/0l5Td/mt1qlurwRMzhyI6Ph1LpzUygZcqbc3i80BZr
	wTUeQh6kgfkQ90AdSW+AQTtCeFGCK1STHNUhv0Z55jVkSbcUPvPirIX5Vlb/gkssJmxw=
X-Gm-Gg: ASbGncuvg93V+IFizLH5l1GB3SZcH6Lt+bAy600RsD0QsDXBeIroZkjTBFqj1meCfPT
	cb9uMnPcgApAxksbXWpddgH0eicfUcf2FXI+gng/Vq7RHvrFJpTOID4GtyDymdNRlgNsw/g1riq
	R0NqXVG1lsDY37Z3gmSk9NG6Nl5u2lyzL29uvYkBPXHdXoB9znLScsFwXNyZdGe1cPT6929uChZ
	fj90OMXpkWWbDO1m9RgIRDkKrOHTQ8F0ql3bUh5bkCPoGFS6Zj9hmrjy9ZTA3OP3pRm5OxyVT5R
	oYQ0vz7VE3p3zXavar+J9We9IKdbpFHnAtfuvB4CSz1S+VHmK4pvTfCG76JXetMzItuuMHrCrSx
	LTAPBSTWg82Lg
X-Received: by 2002:a05:6122:3711:b0:556:745f:6a06 with SMTP id 71dfb90a1353d-5593e563b6dmr1087785e0c.10.1761912453092;
        Fri, 31 Oct 2025 05:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIcGE2eWLXSFTHonsnjJICwses9jJ9xucL5+zcIhg+h+3QNnE7/PCg9OINg4FnGuKQHFTSlg==
X-Received: by 2002:a05:6122:3711:b0:556:745f:6a06 with SMTP id 71dfb90a1353d-5593e563b6dmr1087747e0c.10.1761912452655;
        Fri, 31 Oct 2025 05:07:32 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fd280fbsm21273995e9.5.2025.10.31.05.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:07:32 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 0/6] ASoC: codecs: lpass-macro: complete sm6115 support
Date: Fri, 31 Oct 2025 12:06:57 +0000
Message-ID: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwOCBTYWx0ZWRfX3y+E3n7+oEHv
 dFDajTvX7Eg16flHZqYHN+ZXCscWJDS4AVlgFtQoi7fTUX3RSeVVwsu8cAz9GXT5BOhc8nsx1t4
 Y2zEKgacrZernFQDH82RsJWeiJDHH0GO0KaBgFWRYiMc8/JJpSTgwjqdqQAG4HqU28OD0JsviOc
 d8lgkKkLFdEpCNOyhYqD+nJniRCdhfXOGptJ4R1g6COGLC925Crj8F0uw/4rhn696eQpqc7Lt5p
 vItej29GAempQQyhz6R3NLje9jL/rkX+sD638T6tV0z5ktQG/FIIDs57cvqIFlVj8whfDHGNr4D
 vVQ/bigIugJeWYVeh5OAvDeGq4bx8PKgVgviRWdqhOfXN5KpYNJSoWcrgNQgRwQrg1B8zDDpKK9
 WekeUmUegxAhIUck1LLWEQYhDP5gmA==
X-Authority-Analysis: v=2.4 cv=Bv2QAIX5 c=1 sm=1 tr=0 ts=6904a685 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XNMdb2pSUVPagnxhOkYA:9 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: eZB282da58OaycOywoXk8h8TE8irN08S
X-Proofpoint-ORIG-GUID: eZB282da58OaycOywoXk8h8TE8irN08S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310108

This patch series fixes SM6115 lpass codec macro support and adding
missing dt-bindings to complete support for SM6115.

SM6115 lpass codec macro support is added partially and broken to some
extent, Fix this broken support and add complete lpass macro support for
this SoC.


Changes since v2:
	- fixed a wrong patch that was sent in v1.

Changes since v1:
	- cleaned up va-macro bindings for clock-names.
	- cleaned up va-macro codec driver to include soundwire reset
	  for sm6115
	- updated tx and rx codec driver and bindings to have a dedicated 
	compatible due to changes in number of clocks.

Srinivas Kandagatla (6):
  ASoC: codecs: lpass-tx-macro: fix SM6115 support
  ASoC: dt-bindings: qcom,lpass-rx-macro: Add sm6115 LPASS RX
  ASoC: dt-bindings: qcom,lpass-va-macro: re-arrange clock-names
  ASoC: dt-bindings: qcom,lpass-va-macro: Add sm6115 LPASS VA
  ASoC: codecs: lpass-va-macro: add SM6115 compatible
  ASoC: codecs: lpass-rx-macro: add SM6115 compatible

 .../bindings/sound/qcom,lpass-rx-macro.yaml   | 18 +++++++
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 49 +++++++++++++------
 sound/soc/codecs/lpass-rx-macro.c             |  3 ++
 sound/soc/codecs/lpass-tx-macro.c             |  3 +-
 sound/soc/codecs/lpass-va-macro.c             |  1 +
 5 files changed, 59 insertions(+), 15 deletions(-)

-- 
2.51.0


