Return-Path: <linux-kernel+bounces-845029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F51BC3502
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337A519E0F55
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD922C0F62;
	Wed,  8 Oct 2025 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CLH7/0GW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D8D19F121
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898007; cv=none; b=dA/WtU+jUug6jPQKjnNczUddRyKNIMuRxL/arJPYB6gCe5DB/tZjpH1wd7Cl5rMnaOesCK4lsRtE/f9DqACz1X8C8jubEjovIpLeaBRISHW2vdPdgFtHDoR1FzGW/OM1JzpiHIAVusOFJxt92LNqlatW8Lw0x02+ajDmX/tNq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898007; c=relaxed/simple;
	bh=I4dDFo0IzxPriZN7knT5nIhKZ7qkayg76Lj+xM8mgJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1ocT2hnTKquq4rOfaeT3wF0hFWKAU2d9PWyR9I9hPDC0z+g8NdWwumwwVMgZxXOX2/47nJ82bQm4zyPbNXxpBLHGKNgQTYodHL/6dWuew1RsJwMovlrlqs7EuvOwrynF8nFF1ElOh7TKryLsQadDDrF5DUG1Qosjeok9qe5Nis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CLH7/0GW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803Wih003578
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 04:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CkpGC3QKPB6IOx3Ma4I/10f0rxAG2IWVMaxvxoJMBGU=; b=CLH7/0GWHqEYGtuF
	3LAesdETOq7vS7zmDkVlcq+8Iow43Wfk347zzRhgXrs1+QTTYBIisoCaSQVZbFbD
	09L1oND2xFAFAB1sEYBcONWRo4PVpawYbThTgqR2h0R00IpCimJiKFFQxW2uJNh1
	ht86pXltU5mbfS35EdEx74vR1htU/F8OByXW6/yMpSFaQoCuIbgGruu5CCJWrrq3
	jxXoFqqwuKg1Kevobf01r5cJAzt+iv5+gH7Sa1YLpkxI8g7VbmI2hkJTtR19iXtD
	0Am+0q64rp33W+/RqiMV5Pdwpddqi+fip5d5xZ4YRKDxAC+HW0L/4AOLgIS9/bCL
	e2qtDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7s6h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:33:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df10fb4a4cso258446411cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898004; x=1760502804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkpGC3QKPB6IOx3Ma4I/10f0rxAG2IWVMaxvxoJMBGU=;
        b=Mz4JZA5SlL59V4epU3v0AswKzySK//r5uUaHTOwouZ8A7qIDBATt5VpzipcWEZ0F+q
         i3CB8SoMFVIo+HYQcXrDsxJomaOiqTbCmp6pBcnAm2zHx86hkZf0tpk3Um9oK4JRqbyE
         3JyLWjWzhDde660VrYpmIHeylae7/ib4UB3DGqWZ3w5CVpSERVa3Nzl4F8bOtwWRklnS
         SKBtZnsEcJtsWJ4G99T+z6bXdY0yp9COGJBb836MifDu3plpXq9GYCS3IJm/WQ6d782P
         +RqpS3qz8TYuFyusPSfN3Rja+ctTLpyU/ldfT6lyLoXEdtoO9ZwvlTxD/JgJy0UmUEsu
         hGfA==
X-Forwarded-Encrypted: i=1; AJvYcCWb9Tq88jm9ymXsVK7amR020GqWcQIGohCA/aLsLPW4P6QlCV4ajKWisN28Z60dmdFfydcuZN4uK+FjjC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrhSVeVgmMtHPwR6tX7RWADmbzOA/c9oDu6fumeZ7ciVpzrzb
	ZyRG56AYqvgc53mshX/JPtH9UPikzAbQTaE/zQV97KXPQ/sSQBHIA4rcDPtcQtLnBsVQqKo/DzZ
	gWwvWKctvqt4zRqGNXiOuBiLOf1/2iH67ojVNp0of69q25SEwWSt3CsJp/eECP8/gcb0=
X-Gm-Gg: ASbGnct7Xmcmf6PvBLjtejVpBGbeSW5ryFnzYRIyDq8N1RZhPW9LyEfb1xCVVIYLNyG
	5H5LdfysOTG2KpcpNIxcLYas9YXTT4cTINANz32Yyq+C0fNlcr7J18x0ZhDCjGJnzd/g+KF6OXV
	wRtHyFM/3cOnP/U+0a1SvJfKgP28IcyMnKF3vCXn0/cKV7sCymGgBXgzFJ20rqPh2CSx2D4qrmD
	OSf91JFUzk37YZFN3ZMRWSK7miTTqih+p7pbnmA2FgUIz8z8DgFJZcb+RJxkzZYgxXRt7teJ8ya
	UrHgFLa2b+g7/JAJv8Gl+BR0ozS7mTCU6Vo9QwbVrZ4Z0e+4deBz5bLbZGJPVvGZE0F8S+nQSW0
	XDqNW34LXXUyoIiNuun2aEVjSkFBvG3CO6Qh4jtd97ocZ2jPUd2Rg4XqspA==
X-Received: by 2002:ac8:590c:0:b0:4e0:5cda:9ec6 with SMTP id d75a77b69052e-4e6ead91c12mr27068171cf.70.1759898004262;
        Tue, 07 Oct 2025 21:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8kM3Oryp3/2tw8jgZmztY0G7AFi+6cE/Qc5lYn5psXENVanRiu+Hhm5CHAlCXlL1gAxqVTw==
X-Received: by 2002:ac8:590c:0:b0:4e0:5cda:9ec6 with SMTP id d75a77b69052e-4e6ead91c12mr27067971cf.70.1759898003788;
        Tue, 07 Oct 2025 21:33:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119f461sm6751107e87.107.2025.10.07.21.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:33:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 08 Oct 2025 07:33:04 +0300
Subject: [PATCH 6/8] media: iris: rename sm8250 platform file to gen1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-iris-sc7280-v1-6-def050ba5e1f@oss.qualcomm.com>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=I4dDFo0IzxPriZN7knT5nIhKZ7qkayg76Lj+xM8mgJ8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo5emDHjUsiHFflcSEw1+UiRtQqy9E0yGxqmTqA
 kwhNWMOj0SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOXpgwAKCRCLPIo+Aiko
 1bDXCACRECfYAltsL7sONUXIa5n0ZxrXgjkLfN5silrHFMw9KtoL4K1n8gFNsfen+1dqhTk2rGA
 5z+Z8xBegaaMfXqG0BD5v/cQDNU6O/pmyuPHPnpFJ+HXmkZUz1/FJ7AO1vtDJi/dgxWq47gjJbP
 Kd0RFrwRTXGrspxhO7ik2LLxqWjCiRXRc65H48JzplLRwl5HBjUCaTVgZuZYAcPk6X8iqcfSvb7
 iEXgMVSBiJsQLZp1qO5AGGOSLUM/mvfGfHAnLdaxXkm3erQTmTj3SvhcG85/cY570zJaraYXdEw
 ysRsNhzHkpcIqusnbos0bATGIdVVY+uM6VWSigOSC4gfbNlz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfXzRME5k79HXuY
 4s9ByKJFL4bIym8TZ9E1KuQNgw8KrBbZmaLlVQ7TAsvl1cHfmK+xz1w0hb7gVujupvf67WIJcga
 46rX25ZzjYI5GcqarU4A70Rxsw5HN3tTuhtO+WKSBlstaCsrVg7m5vY1CP0MyziqevMauFbR4/4
 lJuwl+qF5sDwD2p6WPn7x2npCQJcIsH+kWfM8x0N5vWeMb3Sb5MfY2BoXKprjngozH4XiMBYhI8
 bkDW6hjp6J8LR0eoXvQ47FuYXL8wVEQtgEM4m0ZPbIFG0AbUyLWW/UkUR5eCDCccaYkvCTJXncV
 wnMch+i958HDcU+SPtK3pLFk/lxtLw7ws7w8j384eHCNvCXTicqq4RQ/ahrEuPky2jNu3kKutjY
 MkdnzYnjdbsbenomD9EkBMLrXb928w==
X-Proofpoint-ORIG-GUID: fe0cWh50suk0KVoXf_zLJClNvubzXVD-
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e5e995 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=OYuIXoeRUKmE5Kzn4ZAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: fe0cWh50suk0KVoXf_zLJClNvubzXVD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

In preparation to adding more Gen1 platforms, which will share a
significant amount of data, rename the SM8250 platform file to
iris_platform_gen1.c.

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


