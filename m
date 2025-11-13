Return-Path: <linux-kernel+bounces-899140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC15C56E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1BB3BB65D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5883321C3;
	Thu, 13 Nov 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aI/3G6za";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vot7FCS5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3533345D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030180; cv=none; b=SvZe4bn8PIaZn7LzvLQZ3l1WLhIW/Wigt0J1fngc+HBZqYgVkllUB7qRo929Exk/OrhNrHpHzAutoqd8fuai15/NvVaE7URqq3PYBnBzijZZlqspHGrCnyouqloGpC2J5FXd8wUy6bccNEQf6Q24x/fwTkRbtYt+SGFd5O7gMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030180; c=relaxed/simple;
	bh=4OHWHDjFq2jAK9+Bld2fkj3MwlJ5JU6OOThT1NP9j4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqxJHlNEFIVkp8yJKQMh+ViY9yyZU7CVLJoEsHic9Ape6P/HjFvTVR87cn0d1k/Ku8u5QoEI9ZV1ZhGxbpU8hymph5er1GMP94D15tL6M80/dJCxx9801qXlkWjc3jB9UuLQhy5sHC3CK0sGxvvsyk/ad5pLmy60QCfRfTZaEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aI/3G6za; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vot7FCS5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD9GFRb2962626
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AR4qgOv39nCgYv9wQSzT0BQbLvoJwKdb29TlFdA6Xsk=; b=aI/3G6zaLd2sKtwi
	s5Tiyek8O7Bm69Fx/yNglGsvnukWY5owLK9AItiBXPF+vLUflWUFKOw5wTZVPxGv
	6mgmZy7pHc6HP483ehbQnBLYDLoUzXd7vVKkW1uVPBBBoOzG8mlZ3YyxFD0FxAOJ
	+brnRTQuaDSAW13UwGs41o9BrQjT80RhxLsjJOqdA1qHTqB23wLSaB2CDM2PSifi
	i1qnAjKDFkazEsfVnB1iu10+9hGIokBlBxKQ57hivs/UvtgQ9mCepVud+EmZ0/ST
	zMWC6dhvknbvViytP9W9NnXN2gOvxwHfp3g/9vqv13H2NG1r0bcPyHESXWuOv5Uz
	CtO/rg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acwbpu79v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b90740249dso1492490b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763030177; x=1763634977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AR4qgOv39nCgYv9wQSzT0BQbLvoJwKdb29TlFdA6Xsk=;
        b=Vot7FCS5/7gq0BQHJkyaUAn7WRXWU5HMoUEeSkK5oB6SCG9z+6bdQtx1GApzRwVurG
         780EX+KN1rnqGeITbRW0H31tLeFbJRPgFnsfHo6Km2fcG1kAnQA9yyWW+pJXZdV2iTeo
         QIQwxB7TqrUCMdrXW3AJGkDuaogRCzv595PnpwC+Vp/3qMMblF35l0koClSp7PFyeRxO
         xrzkxoVGUHS1GDNqpL2f3juH2tn2yeL1poOpx+c6VxStmmetZLp91D+XDQI5h6FZ57t1
         JGGuslwW79YUBSwhzb3qbMuhCLrzSYUTKN2aPG2CjD/hvac3qyHy/7ToeZahltoeDILv
         x3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030177; x=1763634977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AR4qgOv39nCgYv9wQSzT0BQbLvoJwKdb29TlFdA6Xsk=;
        b=Gdb831nMmM2Q5C0DU0vxjHOGoybZp9pJx6DcyGHVwWVq2umF3Svj3ObQimWRuAIpeI
         ljVTNuo8P5tPU54GeESpj1/6OUt8QKRn3C0/Aveg3F+rMbg4Rwz0GorMq2iaJ/e0E/TQ
         LJWrinhMTrL4eTxLIvtj+lF2HMUsP+VV65Xlx6Due22PTb35nKvntVO/1xUEcvXeH1Zc
         WVN7bpCGBJ7OcGJG1miFTZnWvTyYqxdzB8oBIA9C7B0AXR54PzSPrvHMSF7jcyR7BS0b
         w6OjvtU15c2vBIW1/eP7cNQZYVvGEx8Wz/fXG53dmAhmZ+HhT8rdlo2Pw+7eev5QCqfs
         AjCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYk/Qqe6BcZeOz76myMQ78n5IrjzMl0rklVXPb3qUdUq/lN9TkUQDdVqtrnmWNDc51IJaZDbs6VFscD1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq15f+PqO7qwDzErdagPswLp/tD3Ghk3ROYFVrTfcfpwzeJVum
	m9m4GtNix+VzbRvAEUHW08GUghoM5a1GxLZmHSQjqMQDEfBRlhNyGB/RECpW2vMzA33z9QTPRe1
	Pbnf+4WJpmGAFr6vgKR6f1Dh1Nrz/asLuAE7hApZEfnVCii0oI/dm4RTrXhx/X5KS4/Q=
X-Gm-Gg: ASbGncvBmxWq3l6xS50sWUn0tU1gd3AxDMJd8oIj8apcZ3VSufz8deKEtHx2SrWXxmL
	uYmGpuh3wHJMYFx3ZwBuuGYVHuechmOWFivO6dZGRM03Cr12S5McF+Agj0IXwZ3u4QIGK2NXfYO
	22sHSpUXoMn1Y4C9fyKBUJFUpGHTTr2Q1sKFefRg2mZnLpfGys2trj5IbE94VK5JWZ4WCLE+sru
	BxYNhHxS/KcMjD7aXWHxFesY2Kv3QrNtpmRXinZV/4v7ypI/Q1IxS1w4qJOGG9nYJf0jxkMQvkI
	TCZTd/fNmCIzi7ehu9bvF9lG0c2xLi11JcR9iZutrkCtBudTWU0PH2yGIwZIFkTtWOaXv4f6vdL
	wxS3PEoVPt1lr3IFbXfZnjvANcw==
X-Received: by 2002:a05:6a00:3d47:b0:7aa:9e4d:b693 with SMTP id d2e1a72fcca58-7b7a4edd4a6mr8524552b3a.17.1763030176300;
        Thu, 13 Nov 2025 02:36:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGIq6p3zYaQkOGcAJjI+TPTb7shKZI9xkbDN5N3p8QV8KTQjYB+x/iWASM6JrTmUJjbM6j7Q==
X-Received: by 2002:a05:6a00:3d47:b0:7aa:9e4d:b693 with SMTP id d2e1a72fcca58-7b7a4edd4a6mr8524500b3a.17.1763030175582;
        Thu, 13 Nov 2025 02:36:15 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d2d16sm1886922b3a.22.2025.11.13.02.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:36:15 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 16:05:52 +0530
Subject: [PATCH v7 02/14] firmware: qcom_scm: Remove redundant piece of
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-kvm-rproc-v7-v7-2-df4910b7c20a@oss.qualcomm.com>
References: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
In-Reply-To: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763030164; l=906;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=4OHWHDjFq2jAK9+Bld2fkj3MwlJ5JU6OOThT1NP9j4s=;
 b=w318Bx7r90h+xljy776NCBKlBZscTjUwXmchks0oHl7B2ii5+sjpDI+SxMgAzllPteVRLK8/D
 vd+vLj9aDZ7CVdPuR0c9KIiD2pEmgBVuUnJP07VuH43cYMqBKxCuxiJ
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=NvjcssdJ c=1 sm=1 tr=0 ts=6915b4a1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pWxEDRe995Kf1ot4LjYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: sPQ2YJGS-qcqIF_H44HXxJZvVy7bfF_d
X-Proofpoint-ORIG-GUID: sPQ2YJGS-qcqIF_H44HXxJZvVy7bfF_d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA3OCBTYWx0ZWRfX3oP187owVbp3
 3mOucEuSk/ez7UUc4HcUN7iZ7Zkcl1k/21RY1zfHXg/7eQYGp+X6G1WVLhVV2CrUTCxRBxsJtkB
 KgbPS4/6ybDjMYo3ckymiGIyiUybz0dTWQWcIZEDT6W83xOWo7bu426a6emQMYucG7jnZ//jdTx
 KEGbUG7QeejZgkfHWzF1L6D61RLIRxDnQXBNSlTzy91xPSMmjF/Fm4o6vGgXsFvAh/w01cbPoI7
 8c7uvclSNGhogg4QbmBB1E3huAwYwlzohboaHD6A8x4PE+p0G688ypYNxsloVvQ3iM7vbE6FW+P
 wKxTupj/t+cqeNLBcUVMD4aGfHsBqwnoHw0WlzUivS11lzZrOTmXx8X7kN3T4lofCcHLXCMZqP0
 UGRRoh8P5Ku9o0MzS7AZJn8xXVDUqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130078

The qcom_scm_pas_metadata_release() function already frees the allocated
memory and sets ctx->ptr to NULL. Resetting ctx->phys and ctx->size to
zero is unnecessary because the context is expected to be discarded
after release.

Lets removes redundant assignments.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index e777b7cb9b12..26969bcd763c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -650,8 +650,6 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
 	dma_free_coherent(__scm->dev, ctx->size, ctx->ptr, ctx->phys);
 
 	ctx->ptr = NULL;
-	ctx->phys = 0;
-	ctx->size = 0;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
 

-- 
2.50.1


