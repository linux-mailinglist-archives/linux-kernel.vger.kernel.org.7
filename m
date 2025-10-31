Return-Path: <linux-kernel+bounces-880085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3DCC24D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5FD44EB6BE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A7346FB3;
	Fri, 31 Oct 2025 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8rN4qxx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tr1VXJl0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4E34677B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911306; cv=none; b=rlr4h7rnpk6rJZOD9e/yXGIiKIXiAxmBs4NPGbCOBzDUcjPTVQvrOYVAiEmiDYv1cpsBq2TWtdOPTH67SkFrigcRDJVpRcyfnia+ONT9BfMOg8on73o8I69ixMQgXlFuMhp6wTdeS0PtEu6Jdmtd5Ae5SWjFS9jIsHEmr50ReNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911306; c=relaxed/simple;
	bh=dItJdgHUJs1UViTcltNYdVRQKbflbnmQjHFvKJeVGJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+GBhjpQqWCYRUvuwHwmHzuRttU9Tds+vLBgyO4rv9WtLgks6wbTcaVFEWVFcl3yTYMqPaOrYz1dojwfSl/MRMLh0NLWh5BmF43pf2GfOIL0yqe2hXthTqEmeABVb3rSxxIVESJYpP3tqxbIfY5sBaQM/aM1JFFka5h46R7FRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8rN4qxx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tr1VXJl0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V80W9v832623
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=CREb++Zs7HHNjOQFOKPIizCrDGl0LQjv6t/
	Y+I+Q4V0=; b=P8rN4qxx7VmSIKd4cYMyGrZzDcDD9V0DO+LHGZYh6a+YBb0rwOn
	qFCnFDVV0NnL8VALMM8N6X7Ye1dY5x98HJ0yddxuM6VtQUXclxlCGQISmfqpl5WK
	IIcKJiPxfSEdhjxlhFh2PHuvD0W3mqOrwZ09l0/bn1vQXo8Abj04kk55oAhBhLna
	fOc6M9gAdkN4cV8SXgoXMJgj9rlberGWiXQWFCzKgU7dzi3S3PlDaA/KbxzQgy8g
	qtuinX9CWMNVpa8d6ImwbI+h0xrw+kVsMXuCQkw8BB0Tnf7wuXWF3SlKcuJGAvZY
	8oShi3Vc49EJSBHBy356qTCbcVlcy7zz/+w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb2311-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8bb155690so24069821cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911302; x=1762516102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CREb++Zs7HHNjOQFOKPIizCrDGl0LQjv6t/Y+I+Q4V0=;
        b=Tr1VXJl0FZVkD+0rJC2o4jsnuKafhMOxaRJDyn3rNq8Y7BtCrFOSM1S5BDPjzFixYN
         aYrQYjAcA3QKbwts0vkDoZ14i6G2wdhVSsng3uuhOQmS77agCekAerTIF+YcvlngjO/P
         /1vXSiGMpHlcnrR+g9zgFVYuZWeicVy+J3IckL2+ureUrYJ1fJZbG8iDxztMEm+YTiEK
         QN+3A6PGzc0cPpEO1GNoqsJ6NAUkAJs2/sAkE/NH7wYNHTRz3wafaQPUAoRT4KZP/tk8
         XEtbzNP2FC44d96FhdnxSkr8dnuWDwgooEec/H3faaAOeJMMdFE/81NP68fSJzU/1fnt
         SONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911302; x=1762516102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CREb++Zs7HHNjOQFOKPIizCrDGl0LQjv6t/Y+I+Q4V0=;
        b=Xvubvk22dTGmuopAr70D6MriPB9ziicSOUV4NKA6vivIzWyQ5CNRNvEPtbf7JjecnJ
         CmCQ9+57ncYGti/w+d9H/5EwgRW7R6XLNgrKJDIwdi3yXXLYV4gcveY58ioPPKVTdo/6
         9saeAiFdCGww1Qlm8POzqPMesn5YRIF8ufNT4WwmqrtoPIKwZk0vD0HgYbYOsCdGY214
         ZfWBHMQB4qpxOOymiglnA/PBZqtZ85somUjHCnzt+4QlZGfF/zEvIoqCL1mpP0cF4dvC
         xawi6Mz3p9QLGUXp3uEvDBiy6sDpLDbKzb9pzWCQtcaekaBy5LeyZArMzn8J8fq+Jn8s
         Tziw==
X-Forwarded-Encrypted: i=1; AJvYcCWjt+hmoBV118IIf5LjxTZbVZOHNFvzjTPH1O+tdTLFGau+1+/i4p82l8UY4Kp6vyNr4xrl7RmWbIcZUm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycIC9yxHYl4ULMweyj2kSN/oyWmjHHrIIRtwwNuO1VFL7QKuoT
	EvHpFtURsLzMWvbAeJkqqgA6c7lOdNSX6XW1Q3qcWSX8gGVmBC5cYvKGuGS9BJmdjPCxdIv9Fdm
	p9ZBMmlaenZo9utqq11CyXszazVQQ2q4YjCj3TQBGEATSyJVyhWUFwI3HbIQjV0F9+XA=
X-Gm-Gg: ASbGnctM5Cjj31BlWpG+PQoHjdOod6TDDfiChMsqAHEVRQMOMjRO/Kch9BmwzPH78gU
	ZGWJo2D1I7sw234pVmNRVzCf6gV8oPEyTVD6g3FyxSKRfY8RceVlXtc29ynlFgyE5pEjrDGjxS3
	ily1apDU5RbLpdIsytFa13qAwgAlEjGz5DP9c/jpToXJbftjB13H4WdH/XLZgVTbVcOsYpCTwDe
	FnVnjr78zEOc+REy4UNpCBlLOuvnptWqwe7kfCprHLoS3cJropd8eHD3U780TqbtSb8R300VWxU
	amy/uX+PK3iRrStKMfVf8sGkRKpmQgMhFepGtOO5QjbIogkUuq4EzSFU4OPc8a8l6LCz8zmThAk
	9QI3fCJVHcN/2
X-Received: by 2002:a05:622a:1a0e:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4ed30e17a3amr35245271cf.34.1761911302369;
        Fri, 31 Oct 2025 04:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrLMBqXq1lpss5fYYEYEBdkpGMMktplpYGgijhBBMxwiDCmZvkiKiAaqFkPlxpIxhU0z65pg==
X-Received: by 2002:a05:622a:1a0e:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4ed30e17a3amr35244861cf.34.1761911301871;
        Fri, 31 Oct 2025 04:48:21 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728aa915asm86831165e9.16.2025.10.31.04.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:48:21 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 0/6] ASoC: codecs: lpass-macro: complete sm6115 support
Date: Fri, 31 Oct 2025 11:47:46 +0000
Message-ID: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tUhfQqa5IR9Crw4WRB3uuJSDLM981O9m
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=6904a207 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XNMdb2pSUVPagnxhOkYA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: tUhfQqa5IR9Crw4WRB3uuJSDLM981O9m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfX6rG0jVL2+B1C
 4zlxxVfVjrJF+gGPt9sLedTyGXjv3SUKFg8gt6SSRmD/Wn58wVrP/TWPvSSLOW2Q20wMBPzmBl6
 OU237ZqfxBgrJ1vgPDky/h5TuWoR+rZbLYweVSKG4PJWHVc3TIO74g4EXLtBoZXSKrsUXb1o3Iu
 XfEeE35OJk/t1uYZ9YTGuHW/u6hPvTXeLcNcuv1O9HbOzt6TmA5KBKdwhpeWuO9ch8eNJu1b3eI
 OH9QeKzuoiRQQOrKFMvLFr1mfr1zCcpefSXxBjt9Et9UXKDYuk0n/fxcPEqaSLGArtO3Kw2sPC2
 haUBftx1HKqjK1N0Fh8SEel238k09ry9VRsc6/f6xj/5OuTRVF1tffvPL+lym1x70Zz1ZSDue7q
 ojVu99a4xv+o6/eoXqrn2pNBvGfH5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310106

This patch series fixes SM6115 lpass codec macro support and adding
missing dt-bindings to complete support for SM6115.

SM6115 lpass codec macro support is added partially and broken to some
extent, Fix this broken support and add complete lpass macro support for
this SoC.


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
 sound/soc/codecs/lpass-tx-macro.c             |  1 +
 sound/soc/codecs/lpass-va-macro.c             |  1 +
 5 files changed, 58 insertions(+), 14 deletions(-)

-- 
2.51.0


