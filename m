Return-Path: <linux-kernel+bounces-873689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082FC14747
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 729295035B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B10230F541;
	Tue, 28 Oct 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KzxpnBkQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237330E0EB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651998; cv=none; b=TmXX1GgrMGVN9r41/ufxSX5R998ZkOLgau4u8piZZ4do+FRQKn/RSH6o8nBcGHZVhdO2GOF6Z063fWoPmp0FhKJGXriNViJVmXEHfXR/be/MkuYZBHDOWMIXjJoT/qUTOL2KttJ41BlsTBrbbRXrlcuvFTu40chDwKJBdQ0droY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651998; c=relaxed/simple;
	bh=Ebl4v/VkXfD1I64iutehxYEDpuSCR37dBGPipaquSZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsdA4op960D7HZEjc0ymnTwC7fsw3rVA+5ljG21XTCpJbDErMt9XQe8cjHVGrwjAdSr7x/xxOFtHu8Rur2JTTa0o0BTId8w18X9WuAlX5E9MZ3qdhMJ7NX8bog670z1Jc3CgCOqMAarPsIFj/MlHQSuwxapnHrSHHvKhkOzOXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KzxpnBkQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SBFZ8N555542
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+e0kmPSERHqC5oqgfvQz5PD2Os0wmkHOTZ+f+cd7qww=; b=KzxpnBkQ/iPM+x6b
	JwzP6NlSbWI2LPuBEe2oIWpTt989YCxXvT/KNfMPYwjKorflEvO4IxuosrTb0U4V
	qK2hlLXsy6MqiuyEFAolwx+Z4lxUXwvSyfo/65nAfkQSiEQUL26lrqOa7CKOcczq
	lNpiq7z/HYQi+BiG7GjGEA3Tn07miY2vPcAtzYYB9osvHOa+kZZCUz62/1cBFKBj
	tdHcLil15MS1q3QGRFEwBck1zrTidt6bwNPE4qAp8ukyDCJnWnMQrX8TdcVvVtiX
	c+BcURsFQQkzy0uWWKS21aJWggGbFVVYfJoFFC6CBLbcmtva9FTLazK+vNtZB6PA
	XOldQg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2pjf998q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf4540bb6so59212111cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651994; x=1762256794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+e0kmPSERHqC5oqgfvQz5PD2Os0wmkHOTZ+f+cd7qww=;
        b=VHlpvH89z0NjAEifoPAZyMRJz+naC7j0rdJMU4sSRO4PcY57jr4j7hI/L25kI+dmsm
         yFIBE3N62VXGHUFwrAcmn7pbFYYH28N8mGPj5c0w8u+b6MT+KOYNLoFx23KaOxG7tkdt
         zzT5QxAJYaWgXvszjJIKL79Rf9vfXJ33mwl5tUseo1RXXeNPkPDOyQNMtaykH6ZeAoaT
         SnME8tt9MhoE/WjU4cR3rDMSLUO1Pm52espPJqVpqRmCKMoJwX+NuyP05t11HyD6WuEB
         RfvpewgmF6LAcWMhrh8LeO8jzmEN8FY0mjoZpLmfzJG5pMbbrk8Sg5lolYIG6gyqCYQz
         0Ozw==
X-Forwarded-Encrypted: i=1; AJvYcCUBNB9DKKfiRA9eFJdHXEDn01ZAyM117jUMdPC8NFyNUw3Ey22tWYhePyr22jXX6zjV6kkX0za3SQHPBgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsTWacrgZwF2TgovpS+DgHiZuLD+JXTdGRzAUWcxQmfDHDTkk
	Zg4QnUfbRleS7DQiIuWFBDhlbkbdEGWeZM0/+DerEWmzs6YVS5fDAeiu0qW926ujj44IZi5nQkq
	+R4QgdA0lt/EqIiD2dwZ94KtEqRoQsPDbwvNf9VgbIu1WYke0BhsneHwMAZpHm5PRSz8ZYPhzDs
	I=
X-Gm-Gg: ASbGncsyWy3yVeFUA39eH/jWhtThZ6vwd9h6aKCjQOyn08jn+vT0baFAzM0r2BGdfUe
	pmnT1lbeIgdeEAGrYkPfHF6m6ZECSPDV0u4TAX6g5IqUvlbCTePmxBywj9NQESFah4ISl3n2zeT
	oBnA2nTkcxhDm3wcaD2JSyGmozIUxY3wP4H5pg8qWu8YC9umxjX1weX1vkWkMIej1Jq0cMQxKmT
	suwlrCFxx450y1SFfdSU4fp8GpxaWOqeyNNaPM7ioF1Dn7H45kw0yVpnWpv3xcv/6WCRNiuH/iq
	7d3JbwD4r3770m8C6yF0wUme0VzCayPyVekllHldWsF82MAUqrPcdVdl7r4N09DFipOpkPBPhs2
	EK6nu/ysI6i7bkwfhnbuik4z04X420vdBBxpEnh5xkeXOXlf6AFqYwUnSnZDOuzD4s+nQeKh9CH
	AHM/lZ6lIN3ASE
X-Received: by 2002:a05:622a:1983:b0:4ec:ee5f:e057 with SMTP id d75a77b69052e-4ed075ead8cmr44032161cf.67.1761651994291;
        Tue, 28 Oct 2025 04:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPdyep33zieqq9ymIFf1QeHam3SMWH00VNYbqjTxTd6ngmg/6fH8ql3fHc8hhslsjfAg+zVA==
X-Received: by 2002:a05:622a:1983:b0:4ec:ee5f:e057 with SMTP id d75a77b69052e-4ed075ead8cmr44031881cf.67.1761651993830;
        Tue, 28 Oct 2025 04:46:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm3096564e87.6.2025.10.28.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:46:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 13:46:24 +0200
Subject: [PATCH v6 5/6] media: iris: rename sm8250 platform file to gen1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-iris-sc7280-v6-5-48b1ea9169f6@oss.qualcomm.com>
References: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
In-Reply-To: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpAK0RSJzPitVU8mSgc9I6m3hvDaUuZVbfkOsLv
 4v1jiD5uMyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQCtEQAKCRCLPIo+Aiko
 1SXRCACLSs2lpfLAOajSrrl0O0GLKc5qXCKdJ4cIxGnRirHlcx8FMtLp9wGjwR8jbLNXFrmOpFH
 bhTkztGCJl1xMmgm5sj6m9gZCRs1m3WZsXCfJ75Up2dDYuWMSPJTKu7bRA6GyUd046jmP4Tmiax
 tEB7zwZH3ts6gL7oDpMp/IyWs4NZG79RA0xF2uxAKIYlmscq8cBB1ambr4oFuN/NwVWQ1dlpVxI
 gMWvuHSut86efnZso+rMtM0eFiMGH5gfzeegYleLCiX7n8bNhAUIqVB3enkqsJdqnk7aJpfxTXR
 kJWy1IMMDHZhvhqPibTZfy1vUJDPCxo/xp9haZd4T3fZAnlK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Ut9u9uwB c=1 sm=1 tr=0 ts=6900ad1b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=OYuIXoeRUKmE5Kzn4ZAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5OSBTYWx0ZWRfX9lER6M3qAd0l
 GIgwqQsKR9tw2yPacWfm4iMNJRoqF6HmpsikI2QDMHaQx+Viv3f74WkT8W6dgpnfBzyc6WX6gOI
 bbQo0VtK1Z6ZmhHRGqaHFsKDG5L2w6BH2QWXwIAF9zCEg9VW0sD/taoBtYo4UFp8evRtVqdbxOb
 y/xqjPcy/Sc1iyz9LtGp2FcWToLPOmIEqZuMidlGoxRQ2C1X1eaQrGex29dEtfxyoLcdFbe6LX5
 ADsIz9GEFYgg2Amfd9qGo/BD2+mm3ZcVotOZWb0xCuXipiZyvtSJgsIZHMsmlHKoc3UyJPrJk01
 XzdtugbL4XN4EQ1gvt0fvE/MlgW+ax0vcd8FuI730Kg0P5M75Ptev6/kOma+EbPl2zTUrEekiAq
 uG4cJiN2JnRlZRZ04yP5WkHWP7jVgA==
X-Proofpoint-GUID: 2EqX3RfrtAiZGEDN-KhOSn7Pp9uh-x-1
X-Proofpoint-ORIG-GUID: 2EqX3RfrtAiZGEDN-KhOSn7Pp9uh-x-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280099

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


