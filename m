Return-Path: <linux-kernel+bounces-859581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D99BEE021
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D41B64E624B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767A523E35B;
	Sun, 19 Oct 2025 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zuso0Hl0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608122FE15
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860631; cv=none; b=TF+rSBeH0HLd2sjNzP9CcTofpOgcYmg/rEwn4qIUDDfeAS25+A8JCpq3qLfAgwUjbRWvU4FMdJNeUYAnvYbG89ZeVeKgsQbS7R5dJlHDNv4y7O4AFRasMQJevkJJay1tVNBKU/CUluazurULlLMjN6Z+1O8ZKawF9d5gaab8wA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860631; c=relaxed/simple;
	bh=Ebl4v/VkXfD1I64iutehxYEDpuSCR37dBGPipaquSZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HajtxjJbGZKZEEpzPgzga6tibN6V2sV7IgxCCJuHDkjYIBPbs8PTAUolsUwXl4NrCABL0JDnM2eYLdqj7bwSxV6MzqXnWhTYshAtFKDgh1JmRRDQVopfwpLp0bivxwpr0eyTDdfmTKm4oLVPsilpg58nNhjfRJ59Tzb0JSxhz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zuso0Hl0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J5fAio023777
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+e0kmPSERHqC5oqgfvQz5PD2Os0wmkHOTZ+f+cd7qww=; b=Zuso0Hl0+p3CeeOa
	W3DSELNAjdeJRbiiHI6/YJtUwBlf/wog2BEU2x9o5T3LLi74OdQc/QlbNUrdcy0A
	OMDpovdQsvosiZ92YqYQw8EOj3Yi9b7IBlE4zZWeNVSLGEWz9VrScrpYPKlvHs+e
	3plz2yZx5Wo5sqY8cC0AZ6H3awDjSIlbbUm6lRK+YMQm2JtEl24AzBKzSebYs7lR
	TuhLdgLPH1hk/nlvgeMfosVrhXU79VYKTFdF0ifthVLDmI1pKT6hmJyf+3TNJ1Y0
	pPkttr+yp++JR6OWwMampIKdCt9NBQf+/9w3BfwOTctbAJLlPEVxvsBTpOdzhrs7
	avYwkg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08paaw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88ec911196aso1295884285a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860628; x=1761465428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+e0kmPSERHqC5oqgfvQz5PD2Os0wmkHOTZ+f+cd7qww=;
        b=CuWRreCohN+yROmmZb9IfIIRkDBv3gHa0m/AlZ3KKijMYq+4hl0RiOI/cPn2DV9apx
         vR7wGBK2DzNp1Fuh3PNso9BUUZAX/SGdDoCg/8U76J8j8TSp8fwuThk0kpeJaL9pQQKh
         GkwgYQB39qIeDAEVMGPdkLMMDzLZyWmzhzHdvVMIuq2nczwDDmi3qgyEfo8lngE1CDWw
         +OwDaD2FVIB3EI3oCPICqKA4JN97MyXay2KCDh6RieTZuOT242YzV0DBgB4Kvbon2V2Q
         n1+mx/u05kweVuLz4yPRtPSL+s/qpNvOm1ZDC86Tc8hcaCmndzG0V+oazzbOywoyf0ZE
         Uwqg==
X-Forwarded-Encrypted: i=1; AJvYcCUWqVJfr8w2Z3SCYVOj8uhXj0Lla5tcF76hg5TxhtMkilWggQ1rcAT9/SECLzuAlFLV8TYrgbPRSM7qeUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjW0bnCPqTFpEjD4AKCENhGBna3LXIZ9m8SEMxghOj20RrLPTL
	Q39tEI9tgT61DIGsouXQAwnJJl8kmat58Ol/wrECBUvJs3vMJaE5Hqq91zq4IfsEldAB37TjH1F
	tLgYGTaSEYvQJBsETkjSAQElh531PaaxXXRO+mAAh/v3v9IFOxlPHjUptcQ6MMwKY0dc=
X-Gm-Gg: ASbGncscnXcO62La5c0mV9TfTGBZz2/mC2JFt34yKxfP0RiOhhuwvbG0WulDnHcqt9E
	+GNfA4dqHeZP3GjU4R4xBz8TJwzSUkfvaho4D7bhHq4Mdk4KPogxph4h4pUUaf7JS1skxIwQJwG
	Omp4/BdilHBsw0DXe8wNx+0QJp5Z3DhV0+KDNxvMash/ctY6soueR9NVKZ5KRj+qUwlASkTb8CL
	JAjEt7/citCbsEJ96sBJiNxoO/UeIlZHddkG1Rk07xN1gTa66+Wu33Cos3vfIhFaiWQew575XbN
	uQsYPLe1uulxb8yhce/BQOML0ym03zhzCIfjYeCkR70hJbVwiBFNVTRJmObWHENpH+P1cPZ9YAn
	9aFISnpF5z3Z6Wmu8E+hU9EYvaVLi48bsj2o0V9I3InHcG0aPzyJ4GFoYBhsinIOcv5LMHHEqee
	az7EGYgwycO5g=
X-Received: by 2002:ac8:580a:0:b0:4e8:beac:1151 with SMTP id d75a77b69052e-4e8beac14c7mr6065691cf.58.1760860628114;
        Sun, 19 Oct 2025 00:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDctdAhTGoH2UVH4SIDDcoeLsFaivxMV8gksU2P+0NHGGMP1let3HDtxEPPUwme+DeMzOSFQ==
X-Received: by 2002:ac8:580a:0:b0:4e8:beac:1151 with SMTP id d75a77b69052e-4e8beac14c7mr6065531cf.58.1760860627615;
        Sun, 19 Oct 2025 00:57:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaf4cesm1357027e87.30.2025.10.19.00.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 00:57:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 19 Oct 2025 10:56:52 +0300
Subject: [PATCH v4 5/6] media: iris: rename sm8250 platform file to gen1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-iris-sc7280-v4-5-ee6dcee6e741@oss.qualcomm.com>
References: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
In-Reply-To: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ebl4v/VkXfD1I64iutehxYEDpuSCR37dBGPipaquSZg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo9JnECS8dwDhbb6wsBiT73LflWqJdL+MdmheXt
 gM9pKy93qaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaPSZxAAKCRCLPIo+Aiko
 1ZLYB/9dd3i8u8x3HW0QEmpoIkw1Ko/osxFOOmA+2TF/8rLI4a33AczPjU0+Bsj7lelv0QM2JXh
 iWuIVG67FB5hWZYHyEPz3uekZCBVe+a0BaCeZeC1/w+OmE6AdiLo+NITUXHio3fXR/FP0WOX7lV
 6V8XxQuActxxASDQv9Al+M2v5KmjrUkP8E81/mZthVbB2/o6hY/Q1S3bXBRylqlRhQKxnNH+CAp
 g2zyfg1IqpjmpmP3nXoPxuCmqRw/E/z4mXvPBwaRjwkhLXFi3EPD3OR+wXXa4RzoBtlruaVo8xl
 Y6+fSnFOVtiYy3VCw6zeaz0agOmvXTGoklLQJxW+6LqYHUR6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX9+9UdjgI/Onv
 2rILORY1J78e9MI+CKRosR4daA8h8r8jllPekDCWibuWvpbOEtCLjh7r+deXm7dKhVJ4kAMgKfA
 Cptsyf+8k6lUfDbRcqClUDjxIoiDB1QKedUDvnwtU8hgJGySaicw13fSe1EFQUcjOcm1rDpOyqr
 CoZR1VP4WCHYHBE1BmjbWmbzGzxqsVyTiCIH70uz3uOpww/SKaWcD+aPhAxiBNP+NnZbOEvmSPc
 bTOCxU8yMW5BF94KbPSYf86OUs2gj1yMVMTIPg1g/m/scTrqblYgY9gqY+F/CKGJ7Oy1DKC0vZ6
 Wy1v3PEb9dNfeICV2Q/52Aqx4tpvh+GTuSfvPY/gheuuk8n+fBMuAnIq5tmliGK3v48uVpsjaeL
 XhTgXrn+UpnezVBDByXfMiz6TMHMVA==
X-Proofpoint-GUID: z1g3OBfM7SmMH1d7wPEa1YJ9wX2fMgVC
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f499d5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=OYuIXoeRUKmE5Kzn4ZAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: z1g3OBfM7SmMH1d7wPEa1YJ9wX2fMgVC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

In preparation to adding more Gen1 platforms, which will share a
significant amount of data, rename the SM8250 platform file to
iris_platform_gen1.c.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Makefile                               | 2 +-
 .../platform/qcom/iris/{iris_platform_sm8250.c => iris_platform_gen1.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 13270cd6d899852dded675b33d37f5919b81ccba..fad3be044e5fe783db697a592b4f09de4d42d0d2 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -26,7 +26,7 @@ qcom-iris-objs += iris_buffer.o \
              iris_vpu_common.o \
 
 ifeq ($(CONFIG_VIDEO_QCOM_VENUS),)
-qcom-iris-objs += iris_platform_sm8250.o
+qcom-iris-objs += iris_platform_gen1.o
 endif
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
similarity index 100%
rename from drivers/media/platform/qcom/iris/iris_platform_sm8250.c
rename to drivers/media/platform/qcom/iris/iris_platform_gen1.c

-- 
2.47.3


