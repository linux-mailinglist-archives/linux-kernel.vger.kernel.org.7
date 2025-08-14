Return-Path: <linux-kernel+bounces-768107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D23B25D13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D6A3B4009
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EDB2594B4;
	Thu, 14 Aug 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWiPrWap"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7D347DD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156148; cv=none; b=r8jARck82zzkjnj9DcTpOqfouS8h90eZf4J2FtZn69bteDVvIbbwOCefvJLVCS/1zka3V9exnojGZePgrIBbSwkvDHM57e4Ww+7S1UPHuAZI+h3MHth30bRzJI/xGxJp0c/kcPV84XI/aulYuXzDcEy6QpbZEhJB+DvSfxoKG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156148; c=relaxed/simple;
	bh=Xb0ChfIllunQ9/noWHgHerT0uL82KmjGEGaefQ+BHJw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZmMcWNRPbwOqEt5ry53FJYPDUljLebUgnL23/ECD+ZWtXxTKNasFdcsCuu0bnM+silwi/NlSUJHOBPyfFNTo824vAUZzvIsldP+BC1SjwY2jxLQR4Be4s0qDAjY0mc7gPEwwyLnlxacMQxLe+7ycArMHCzYppBfu89R5Z9juAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWiPrWap; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLJ9Sq020736
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MnT1zdkBq5Ly/+u/Ng12sc
	+/8iUYbKTBTdeRJ7Coetw=; b=AWiPrWaps+f0CqdkqCfWGramuh7shykOv78hV5
	sOlZaMgbPOVJBysPN9DZUXguz1vWwJiVIlSnbGVNj0BybQK9hbYjL/YReqZFgHPO
	r/v7OP8UPPRA5YkjIEBu4JHUg6wfpVUglaFeQFfrWCVYIBfwqgKgmPzIW16QSDdj
	58FnmHZ8nROJtDEloOFpu+mh+lllmuTZKuO6IHY7WsOL89I4xsJ9Z2764g0EKD+m
	Fr40r/lukj+pC6cODGNXYCuT7pN4+BKouZI3Vv17jqlKLEJ4tdsn0UgyseCSUUvS
	gzr9cZgCqB3v5oTd2zLQoJ9BWndytKRZfu3ya7fXCWl32w2g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sxyn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109ab1e1dso29179351cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156144; x=1755760944;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnT1zdkBq5Ly/+u/Ng12sc+/8iUYbKTBTdeRJ7Coetw=;
        b=HuHroB3FwqWK8ZIwRUwr/ZGaFz7zvLxVjVzL2zYzRdI1JBwTNSxOvMm83GjTfI/rtb
         cVG+KW/GXWAKk2JzUJJ0Gl2kn7zY/WwUk7KneFbsZuquk8u2q55RcN4ZULConPQMyTbx
         y6UQjc5VWV5VQ7J+vR4DxkBc2d85AgsmOSQCf6fQefsFbmPSkAZnPZNHGOm+9tOx2Yqu
         F5mWA3s6Q1hfLWcZuWy/UZWPpyQTdqa6HcCZRLC/pjWMbxrtEGFaFZOnP3dS30qmCyi4
         sVDn7OQbCF2BSC8NcjPB8zqeFnU+4U6AKhhcLcmdhTTnu4CZEI1aszK0dzKt1G2V0WWH
         oNIg==
X-Forwarded-Encrypted: i=1; AJvYcCXxiamhu+iut8s+bkHedlfODMPopaYii8G2oxmFDeiDswuydOjY02O+60tEyHDK8dUBBg/D0qQ8Mmy6CW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTVngPsPjwnF8e8aJ7YauFV7wekN+RiZNkrBOfJGIYuy9cOgH
	+aAJWtFpL5PRE6pBjuEOgTwnXpSLLBjwFrSPsVUnUWG8On5cVHeAzBEkp14s5OLcmZeMG4q7tGK
	Xr8yRYdqSB6QDQaKMh7PjUhbXowKzWcnNjbBReOn44VKiSSzifVhbXkw67sbWXxt9x0w=
X-Gm-Gg: ASbGncuNGKHLFVEJxHmjuwRM6LX1DYT1W7hhEkiERZMIcv3m793SAxe+vsrGavhuOs2
	KGXxb1l93Yyx+kRhkZfL585qaO/3Qb+5XAxPhnPPJgSdaW59NDblf27+A1YYogL/EDV/4P1XE9q
	bRJdnzOpHVISAmUQ0tw7vDRQ4deqd3Ih1mb5vWQKKSVAfX0tAO2ix+EHkUirNCYwy4EMEyD6Ter
	983rnQqy5fqIRqYESAb4zb5wlrOsTk7XesBwnfkEt58FJu1WMtE08HoFDTO2ii7NNyB4DpGCVyT
	yQUkXO2FCDEg5iT9WA0bYyaqEHKVfVnAFKObz/XFrS3HFdiyTXbmk92i9Zyr5oSHFP/jCqm6qH9
	3isXsdPikmKtFvWQcDfLHCs6JD1tkJ+Z9QgMXWTLhEVW8xc79O956
X-Received: by 2002:a05:622a:a07:b0:4b0:7b0a:2a48 with SMTP id d75a77b69052e-4b10ab22239mr29514911cf.56.1755156144437;
        Thu, 14 Aug 2025 00:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb3VwlSaDZILHus8O8KVQpaUO65K8gcN15rQT2Aok46dv65U3XR+AaISmMxzu0iFe1TWgqcg==
X-Received: by 2002:a05:622a:a07:b0:4b0:7b0a:2a48 with SMTP id d75a77b69052e-4b10ab22239mr29514731cf.56.1755156143950;
        Thu, 14 Aug 2025 00:22:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bde5sm5648258e87.3.2025.08.14.00.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:22:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/4] soc: qcom: ubwc: more fixes and missing platforms
Date: Thu, 14 Aug 2025 10:22:19 +0300
Message-Id: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKuOnWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0MT3dz8olTd0qTyZN0UU7NUk6Tk5GQj4xQloPqCotS0zAqwWdGxtbU
 A8tNKmVsAAAA=
X-Change-ID: 20250814-more-ubwc-d56e4bccc23d
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=947;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Xb0ChfIllunQ9/noWHgHerT0uL82KmjGEGaefQ+BHJw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBonY6uMeIzm1lyX9BWlQIfQdv5CbDOChdnHncIG
 HQlQH09WHmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ2OrgAKCRCLPIo+Aiko
 1bjaB/9DTi3kETUeajlqCnkurREx7K7Qm1orGwfmzZQpdAhKtOPSO0YQ7Y7p/NQHdMzfmBUpKrI
 lAD67KyTJVLeDTJ1TTH+UoW3FnMmc8pHdwFno+6l7V1iZexOeRV1cQKE77+PsQqTEuedcb8JyG8
 D1ph8klHW1ba5c2TblPSxwvgPhhqdqG58gkgfl//JsfG0Z/sMEP14S+0GTv8m6IDkUDdlwsy0H/
 HDrto+zjK87cFKg1Ln2v0XvJACe6CZ8HoD6vAQjuxnZhfyEDyNc/stEIsr98J/LXHeHqyfFXo1r
 h+zuoASLIicwiJVSuZizyxnXGcIwu09hMoNOi5Jk8X4F1nYz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689d8eb1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KpN9Cobk0z5BVES1_GMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Wakx056x_Iwsp3dz_4J4g4O8LcOW02EV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX5V+OB/54pVCD
 I0oRyFyEV/7LrB08TAOgSgYZEHHTr8KihA3R+W+a3zJrWutC95urIwtly8Jw92EkDCHrQVr4pDO
 K+BChNaiPDsParUPr2paNL817q9BXHKF10k1zle3PrC3l3VRbSfkNGr0XlenEK4oXwlyk6kWvL6
 06MPmBZkyQ/aFXcyz9mdtnqWvUuYHm1xLSOOxTj6CfUOFsE+2yVD1h/lMzRNWIwdkbYHg5wkdEV
 znsR6Jeyj1lkBzAdbUaLPaFyuiVxbCuWfTtjnh4x0fwpo33Vp2kB8Ot6KR863i0TPQjPoLGxiMb
 n8kMpD07pIs2hYuzcfLoxd2A5C8YDcHtnr3QIh5GTmOo6Dg+IKb1XiQYNZGI3A00PE+q2wqjppJ
 o0mOlkIT
X-Proofpoint-GUID: Wakx056x_Iwsp3dz_4J4g4O8LcOW02EV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

Add missing configuration for several platforms and correct
configuration for several other platforms.

Note: I'm not sure how to handle MSM8956/76 platforms. MDSS definitely
doesn't have UBWC support. This doesn't provide a threat for now (as
MDP5 driver doesn't provide UBWC support), but if we were to switch
these platforms to the DPU driver, we might need to filter them out.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (4):
      soc: qcom: ubwc: use no-uwbc config for MSM8917
      soc: qcom: ubwc: add more missing platforms
      soc: qcom: add configuration for MSM8929
      soc: qcom: use no-UBWC config for MSM8956/76

 drivers/soc/qcom/ubwc_config.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
---
base-commit: 0b6974bb4134ca6396752a0b122026b41300592f
change-id: 20250814-more-ubwc-d56e4bccc23d

Best regards,
-- 
With best wishes
Dmitry


