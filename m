Return-Path: <linux-kernel+bounces-869574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43983C08333
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AEA1C25BED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46BC2F7AC4;
	Fri, 24 Oct 2025 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAmafXT5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125A2F530E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341713; cv=none; b=Z+672O1Fyj6nNi3c9gI+1PpN1HSa6Bbt1fASFvQHrM5HlyACha15Zslr/N0yPiLbqIk+DTAdMFFRFBw178H+6HERhl8R+Mbmhs2VquV3JYFtwnLMZc6m0BN66Pxs/dUXC6de31I1fmsjoV9I/JbkIwbyHy665LGks6Gz7A4iYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341713; c=relaxed/simple;
	bh=WlbCj8/yFWNBZJSWw7I75oAu7ZGn1oMh3UBg4y5Eorc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nMPs18RAapdnQc0NYREZW4CU4DYthPP510AudiaWEYksIzG+Mi403z6wBZ3eFLs4fJMFTz343jvX5in1MobbaRju3mi9ygGne14V0LqU5VLdDPzZAyaDR/d2Ac9jkZMHdewm9cebjupRDZFV9IZVYsaBRZfEk2UOPOM4DUlhPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAmafXT5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9X6J004046
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iYwGj867iebYBlUQ6FRlDd
	eZUCqI3oxDReWWqzN70+w=; b=TAmafXT5S06jW0SDovRjdXjMQv9Bw44tGc7IMJ
	l77VUoE36a9/qz29COj1pk5dmPSjzbzM+1PgbGNEZW73GwFqngec9VG+zBkWGqiM
	1HC3F0hBoH/AWRMAjyWtUh/v9CSFP9zxlWgoMpUxfTnEOA/Z4RhNXXGZM//YQOZI
	ctWWZIE9uunjy7syccPbUGxLg+F6P2HXKBYZtsTOaJvG5z5fEqwWVB6lyM/i/CGS
	X9AN9M8dLfvkm1WcfzfkHtMnZJX7nDWQ2rEF4LYsY8NPe9qIpFW4IAFXRo6Z+c40
	girjMSydIOvxJRD0ayutuFdpjQ7+bKOQuvdDsR5qQ51TbvTg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524fhnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:35:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6097ca315bso4848381a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341709; x=1761946509;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYwGj867iebYBlUQ6FRlDdeZUCqI3oxDReWWqzN70+w=;
        b=RoCYKD3t7GylVCYnm4shc5pQH+9g/CJXmStoHUAUI07Sh/qnz1OpAPUTkjuRcn84Z7
         mJhzmSRqyfU5yNX+lv6qpbqSLzlBCQCqLqCeq14WpV7keTa5r2KLlKlz6kb7Rr5bS7eV
         wqxtcR82KI5V/TQL7XH9rX4eNrIR5g6fOskg+BH4WB9hR68i1mSlBrXkftMwMxxWy1l8
         6cZE+CcXKqnKE2APcPlRXhewJreWNSdMT1994v1f5y97IzJ6HL8UUVseDynhb3sVfmmM
         UkVDCNfwt7zhK2birs0NKLX2EFQ8bZoOHUm0howHvaOlcPjgdM2bvZ7B4D6DcAaFJBBL
         p6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv5FIoMiSlApWhGlJvWo2DKHU4zgKSdIcFiyblBM0wRb8MfwCT4n8ATbodOTztK18zw1v0wc4xsv6xftU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMHx9Yfz94uO85AIaUsHoGRgLNEDHIgWP8kt0f+jdR2uvWqSdw
	UD7RAPH6lGrWgL4ZWMq8srU76LuNnZNXxTQw/kcPaLfnN+3A5QjuXUduhBsrPKI2NPMZgr2E5FK
	bMqgJ3CYOYuI/F2KdOTzNeKubi/3iUDiH1bIteTcIM+Jl4O/vYMKJ6lK0/CXUm5IVxUY=
X-Gm-Gg: ASbGnct9dXEfDubgLivUz/abM0WzyBowzrELjO33BYIlc01Yq5zUDy36l6SIycRl8A4
	WogurH/my5JPJB4DpqNn/QQ15BgvXMHeP7qbv3H0cn/sC/+nuMIg4mdtdvCk1R/7MXNmsymf5tp
	CYTfkPTFy480J4L2gtaDO1RKcJWREuNS4/hBSD5YJ5cHr+u4QlnyYyMnOUlPkdjTuGaJdhdRrfB
	TdUzuMvGDPKyfFuKnq8NEx5RKRdJS00e6VBHS5V0JfKRfsyB2FDmxVGvIlvmGvGD65ICwT7po0i
	6Bn5QNhqRJY4p/5aN0LU+pfKPFFgjw+vdXR4x8/LbIFHRfE0FC7uWp7dBGf279XLqnlwqXoJX8A
	IiiXMo7LRQFBL+lWrkPGuajtxK/rmlt3faczxSMDHKVgyuTCvMBXYFgJFUQ==
X-Received: by 2002:a17:90b:3883:b0:33e:2d0f:478e with SMTP id 98e67ed59e1d1-33fd64bae12mr4044665a91.3.1761341708903;
        Fri, 24 Oct 2025 14:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWlQxqPCcIAOWXSzN5WR1fExwHDigmaUzlorQ8BuPJ5M6mU/xZjao9CQZDugQ5HMPoV6fhEw==
X-Received: by 2002:a17:90b:3883:b0:33e:2d0f:478e with SMTP id 98e67ed59e1d1-33fd64bae12mr4044651a91.3.1761341708473;
        Fri, 24 Oct 2025 14:35:08 -0700 (PDT)
Received: from hu-bjorande-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712ce3a90bsm193546a12.25.2025.10.24.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:35:08 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 14:35:07 -0700
Subject: [PATCH] crypto: qce: Provide dev_err_probe() status on DMA failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-qce-dma-err-probe-v1-1-03de2477bb5c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAArx+2gC/x3MPQqAMAxA4atIZgO1aEWvIg79iZrBqimIULy7x
 fEb3suQSJgSjFUGoZsTH7GgqSvwm40rIYdi0Ep3jdItXp4w7BZJBE85HKHtjRqC6Zz1Bkp3Ci3
 8/M9pft8PK4tbH2MAAAA=
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761341707; l=1372;
 i=bjorn.andersson@oss.qualcomm.com; s=20230915; h=from:subject:message-id;
 bh=WlbCj8/yFWNBZJSWw7I75oAu7ZGn1oMh3UBg4y5Eorc=;
 b=CkJ0xxxNyWQYABSEWTZR5o42pHfUizLhi2bwdWincG9fpab3WpXn+18HW9DsX0Ysscl74ABcY
 OEyeqMj0UX3AhV33NCrKzdQMNO2S7WeVF1mcZ/CRUyBPijfmCCTjxOk
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX4cDUn01aGfFn
 Qus9FG/6tvVQ97XkrHNTI3yMsQFnMntaklzafRofjKzzxY4d50QweoAAZvADkqLuhNw7LLLRmKp
 grA7PsvJjZVixfgTgBrPx5oq/4Q6W2md4xHNQ2GXZkhYXZ+Avd6YmoSHfzdYmBhBKgWcDl8LEES
 l9oyVR2dcnd5YiHVVmDCyHyXW1/7nhXzbXCDjDL53Z7RySFBl065RpXjHbmncEcnCHAnbts8aNm
 Lgnm71xc5m9+BPtkladFM4s7se+HLTn35CiKQcG+vMW9lItffBiYFWzVnrvM80s2kGQW2eKleDp
 mSSKDKZRXU8FuQTZFDVSqoCbY3j62YUg6par49RAyxAGRwoGneacZIhICf9nTv21hgzYcjKvTas
 tMyarfXRZFl88Nq49rqXJ6Q03EZMoQ==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fbf10d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=9nxSR7a-VyI66LGa1BwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 28rd6mtoFrFVHyOW4v8gniXl4q8XGdJS
X-Proofpoint-ORIG-GUID: 28rd6mtoFrFVHyOW4v8gniXl4q8XGdJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On multiple occasions the qce device have shown up in devices_deferred,
without the explanation that this came from the failure to acquire the
DMA channels from the associated BAM.

Use dev_err_probe() to associate this context with the failure to faster
pinpoint the culprit when this happens in the future.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 1dec7aea852d..68cafd4741ad 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -24,11 +24,13 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 
 	dma->txchan = dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
-		return PTR_ERR(dma->txchan);
+		return dev_err_probe(dev, PTR_ERR(dma->txchan),
+				     "Failed to get TX DMA channel\n");
 
 	dma->rxchan = dma_request_chan(dev, "rx");
 	if (IS_ERR(dma->rxchan)) {
-		ret = PTR_ERR(dma->rxchan);
+		ret = dev_err_probe(dev, PTR_ERR(dma->rxchan),
+				    "Failed to get RX DMA channel\n");
 		goto error_rx;
 	}
 

---
base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
change-id: 20251024-qce-dma-err-probe-a7609d65bac6

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


