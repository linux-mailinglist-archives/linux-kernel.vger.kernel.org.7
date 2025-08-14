Return-Path: <linux-kernel+bounces-768110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D85B25D11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB2A5A4896
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CF26A095;
	Thu, 14 Aug 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UkL0JQ7w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2949726B77B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156155; cv=none; b=d76CawDtj4e/FaW/1NqKdw8LEv5yeKdfHZnbTtn/HGfSEDqSaSlZQW2d8d474s59oVhotqCoyXH3qUwMqxt5KUiHyVbSU0aoeJRdxp2ug5zWyRCg0MWYqQJF2202jQRu9885x6AUXNCBGYB2wEaiq1D28H3g9E1M107DBdrfEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156155; c=relaxed/simple;
	bh=E3/N/WjQbiDmz0VMGmvjPdpgGB25WtC6B8H1wIC+vFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbPYTLJJuCScp2mGvvntEsey4+piP7Wnfdo+NS+1uHI9MA2jv2rJ3BSibD/1F1UJ6sEypZDWgFzc9/Ezis0dbFhc7oPWY+e0xGFGS+h2vF7VkS2hO60syIrpYVNmsHJzSUA2WDestUk+LKUxq3yfKDUpa3bzu7UJgL7B16x4cJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UkL0JQ7w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLX6ID020590
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CB8bmGdBNhI4UMshHOPhj6IVXl4P+wbGWYKdpfCUS4s=; b=UkL0JQ7wDH8XQSOj
	CfCEzweC3qyDsfuRDe7pI+FC4oNkRwIkj2Y65mz+guCTujlIHtb49rU4x8s94GGM
	WsoRwr8azWxCQSrGqzR4eJ3fEpvYoo2cbxrwNpGJZGuQE8nfP7CSohQjl6KYKWCb
	iKIex7tn67kWqWXKBxwH69nvQ7Iy8tJxN4J99CBcvYyXjv/X16Fk9WrZjDo6Z+F9
	awC3C8Z7H4O9ye8MBK501k5tMaQFh8arQzw1IZeeUMa8JJa94+NxEo2KsBSPsKNN
	IDwIPRnrT2oArO+cqDN3bDa7NdJBTJkO7A8FQyVgU2G4bervBGK6qhCGGg6Lld8M
	nZ1hhg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmeq79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109ad4998so29554371cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156151; x=1755760951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CB8bmGdBNhI4UMshHOPhj6IVXl4P+wbGWYKdpfCUS4s=;
        b=CSa4hT3m1IXwxXh+H3ULl5H2v2tQnH/ugg0qAx/Vnvr7QXEjTKZ7/W9DGjmWqJMDSS
         iLlQHAQg29VtFxU6pEk6h6VOl7dxTvu1LMxnPcuvAGAZ80ulneKLKnvtQA3quPhjIA4n
         waKHiHfnhnS/J6eYYi4obkgUer2U+RcL/PhwK6zlpf8K12NxK0Jb3bld4lybqL5X/0p1
         4laAACc4P4SZEVj56doBEFRukI2JCmFOMgAbetprWzZRVlWDKDfccn94fuISsvhWs8LP
         VgI1bYE+L+f+IFYL9d/VCwc0pt8qsSKAY2l2iSnIVdbpTs77U4vuc4iqgPEZFlyGX2dL
         PBJw==
X-Forwarded-Encrypted: i=1; AJvYcCWbdzpXo1ZBpHJgmCyJieoBu+05rsyZUL45F+P8bM/5E/mBwLZK/hDqnWlZlrPcurVReMpV0pvtQarTdks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZIOuvGKkiB+bWtSPYA56h31ivppciE5SUDq75ST1umGyN55HZ
	Fpqd3DqCtgJG71raXvPjNNesdJb6ftloOAmdsKObcnTsOCXbVtd+sE4epnUv58RKmPeRWhSMeP3
	TaRdTQkGM2zfnc1oau9W6TmDT1BcyM33z8ue/kJY6YqYFZFGTdq+UlAFE6gs0ycKQsrY=
X-Gm-Gg: ASbGncvjWiTxca8nhhBvD3pgdZ58TnJ3W+LaKsl0Kqwg7bnd1CktgHCBUkpO7zHty2q
	mi9g5cUfT7EhZVlWAESKUkBnL6NPqjXz/otb8lisb3iUek/F7YsjrjM1XCzC8sPnSEGwUfuP5x8
	hMKITf/71/CTwPJb+AprCeN+B/mODMxX1xuRR/69WBfjqkS08v0NIuA1s8F5nAcKQ+tkglFfVv1
	2vIc7GijCb4th2CThEmdXMic/msv7fYkpBKpvuYzQB0WWBsXvg574kZR05isTpCJBHuiSt2YYjE
	vpKpLRaeqdVPoQ/hNXC0I5G6teQ0+m7E6YeB2KNVacITZm20vyjn69eLQNbMLfsa5U4vLCcdyyj
	L5F79ti0Gqumi8bRPfzoUxJt7HRQ0cxezmkmd/pHQuEIoIHW2eghB
X-Received: by 2002:a05:622a:180e:b0:4b0:a07f:c1d0 with SMTP id d75a77b69052e-4b10a9df06fmr25849341cf.5.1755156151136;
        Thu, 14 Aug 2025 00:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtOIqJE9d/sTcrcmqc3jqwvz5pGujMrFYQObf4gagrdYXX4fx4Q28OrN/xl0L4v9Zx2CcFEw==
X-Received: by 2002:a05:622a:180e:b0:4b0:a07f:c1d0 with SMTP id d75a77b69052e-4b10a9df06fmr25849081cf.5.1755156150671;
        Thu, 14 Aug 2025 00:22:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bde5sm5648258e87.3.2025.08.14.00.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:22:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 10:22:22 +0300
Subject: [PATCH 3/4] soc: qcom: add configuration for MSM8929
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-more-ubwc-v1-3-d520f298220d@oss.qualcomm.com>
References: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
In-Reply-To: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=E3/N/WjQbiDmz0VMGmvjPdpgGB25WtC6B8H1wIC+vFs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBonY6uy+vSA/X4Kgke/NFHP7uLX88/xECGSb/oe
 5294f4V376JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ2OrgAKCRCLPIo+Aiko
 1apsB/9wSFENpXzI06HmIYvImbE8JcKi94PgOm0vB8p2X3CkXAr20neQwNHpq++EUtd3lW876d3
 vbADkOzr2s7S5epizeNWWm9KHeC59XGcDuJwBauSlg23Dc9Ec6dNaAs5c3+pl9WOY68l4H201yK
 +Hmf/tzCvy+bXBXCqMqqlufGt81LcJPpsIkf4N/lw0uxvwZX23YWFOXJBxb0piOMRBiLMW5jNMU
 nPMcEDq6zrdbo8T+bYLuSDo4LwBzVfBm4PMUIOxZVu8qXDCg3EcxhxmSn5JodzQcqX5Xg0eYJrl
 GlrJslQMU2XCMRoRDhyhGqY0ohk5LyoJV9D+GTaDr148tMR0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX1efqHaVgk7YZ
 m43q0UmeoiJ805InyU3qSxmm/iJ8QzQM0/SU2O9PTKqXu/tQ2ogMjf0ncZ3uzhtH4bZY39lSd09
 8xzZ/UQWsmVBHCZHf64NPGYBYJGV1PXLmt9Liht6paBnbfNkEBvcmCzAQb2587DufETdSwaJ25x
 kgE149UJTmSl2aIoLNxnXqisfNkdY1oGqWIEyqqLErmFrMZ2FXd1yTJiSAUP93hPUnj+mRLIBuy
 6AhnB6meNZsBBaJS9i90b68PI1wrPMVWH/Of05wzREz6KYDyp6a+Ww54d6/XP5YyP3Y+LZll3YG
 tsoMeJWeWAseYnQKaSBtK84iyrVes9+4aFiSV1Zgk3oTU13qJrmexflNYlfcXgoa6SmC3+S7s+J
 Z+9Amc1I
X-Proofpoint-GUID: db9OG4efU6q8WAbOpONS0s_qWHwKkGVZ
X-Proofpoint-ORIG-GUID: db9OG4efU6q8WAbOpONS0s_qWHwKkGVZ
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689d8eb7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=TTbi-_CV09467DSuNksA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

MSM8929 is similar to MSM8939, it doesn't support UBWC. Provide no-UBWC
config for the platform.

Fixes: 197713d0cf01 ("soc: qcom: ubwc: provide no-UBWC configuration")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 8b23b4d4e3989a7170a9f44f3a5e466cffd70157..689e333ae44308cec178ff343bf09cc89bf9fce4 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -227,6 +227,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8917", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8937", .data = &msm8937_data },
+	{ .compatible = "qcom,msm8929", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8939", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8953", .data = &msm8937_data },
 	{ .compatible = "qcom,msm8956", .data = &msm8937_data },

-- 
2.47.2


