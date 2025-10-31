Return-Path: <linux-kernel+bounces-880396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D15C25A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EB6460A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB133126C17;
	Fri, 31 Oct 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OtW9fTZH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sgm6ZIXr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05706147C9B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921934; cv=none; b=HHcWfpYNa/Ax9fANClR6whNDAHGHg1I4Em+n4BGjwEqJGhI6gl73i/kduAy3jGuz609Xe6pMVfpD6OUQc/xuM2mrrLPfahtVxtrvwRSdYaqJeJAyvP0yST8ZfHCqJFY79GWKiqZ7E3kD6ro6DczbBjX2k74uCF7igQ2MUlKoPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921934; c=relaxed/simple;
	bh=6nlfIDWVoO6X4bV616Nj6UdXo/PgmNDCxuueBokBf4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QOAJPsrwNua13p9Zpp+PSI/jLTDrfXA502+invk2eVUkPw7D+hnqvHcar4pn+NurhT71LVsVg73ZsBpYtB7lQdEFECwyMXxC+rMtecSBISoBgKb1EsaWbsLRvM3hmlciVVsg0+PxhyNtqNBzFDawkJud0lGFns67yvEwRtldt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OtW9fTZH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sgm6ZIXr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9jdXK2471732
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=77pwNb7BkfzP7XhT27GZIL
	tVUBbMiNanzHbCWZjosco=; b=OtW9fTZHUJvdFs4wEugsLpecz2Mnuu/SjcpKkK
	XcchlBOFG4v8BjmF5qT27dUA3PNROqANLOdEHURl4G3arQCZnYe0mo2lOx2kOugp
	HrvrBoHLGVionlCqA8hQUsq1EZPAiJw9MXAradG6F5kkgHV4Vme87GgvKpuBy9ux
	+THPd9D73LXAcDJ6cc1pZsWWIRQMJqJ/+emLXmHLNk4KP3bdLYk/USKJv4SpVuer
	KvxIVCbM6DANF7bko8ytluZ4kO3RN0ISLaaF7UrEr20BPV8SmWdpCaJzMLrYwbNZ
	H/gU/iO/jOFIk+DZLzaCZ8uT6a+7qkmrP4GAZf5J+WJNIKXQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4trv0rt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:45:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso49147241cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921931; x=1762526731; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77pwNb7BkfzP7XhT27GZILtVUBbMiNanzHbCWZjosco=;
        b=Sgm6ZIXrL80mZ2ix75ueVSHv2o7xHUKFz+uXbnD0l06tP5mKIJgpDLPt+jNsCHTgAD
         q997POSdN5zG4tMxB/anBIzU4qnMh6ePG6+vFu7975O572BDNJAJUiVoBwV0UmhBuTa3
         h0Qlw+9GDEGEK3NQKpnRkJDIrJho7UCnDSlcFcEYt/fpfK1MDby9+IDuXPDSnua234mZ
         a/aEAahLC3ZkX0VpNwM1ZYtwNmlL3dgqcuhpX9aSynd8Q5BTVVlASijBxZGuxuN3hCoR
         qQzHu6gyQ4GNuhlP/w76bYz1BQl0DYRnewD4LXWpptOR9PVCXtRRsYBDYua32rhOw4+v
         lH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921931; x=1762526731;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77pwNb7BkfzP7XhT27GZILtVUBbMiNanzHbCWZjosco=;
        b=AK7fP7yuLVW1ajTGRkpHzczOf7snM4IPEeVM9rPVxhs0Yyb64JkTCgXrbxZk7tyebK
         uv/ZHruChFk9ikpBistojpATrDBQSmJbcBczli1ndOMMoC+KcQCk1pA7cLudnnhDom31
         mnIErxpi1caaTaRfB02fYv/gIx36DHmbG9Zq8nRqDDN34vk77/48E7PiP3rROYu7TP1h
         7dL+Urd1ekEA+AVEjxLUPZTp+Ks64rvErhL7aPkcEk/bkZ4lasMUdsE24t+tsQ/1SMN+
         aPuuhfgMOPbKS/IveoEqc22mR5wkXpH/EAdFTNmdRRHdiLXv1PGX5xeGkqUdzK9dzKek
         uJpA==
X-Forwarded-Encrypted: i=1; AJvYcCUbbbhHMIolP/ZAXS7eqQD0/xX1WcjZrJuwKRHw6l90Pn2q8FaWDM1kN1Fac74HiuIBgKomd0b0T8DgWnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1aflJaBJSrzGmybThhXx5aqe5fMeqXOJmEM2uEbcjgaEZQA4
	stzzReVE4UipkEju1wMpwUmtmiA67GnCCkerA9bTg0rCUcHG7ag3uWhBXVDojglYOr9hx18dOlu
	pqmSX9mCfwX2UmejEvtquEIzu7ltWpOxn+EcJx3fIFGpsKr91JICU/TNx1bK6I8Hm9Y4=
X-Gm-Gg: ASbGnctwFURvWpIGB8JsD4Ni2i27KmY1ArLMpDI84GP8XVIcD9Yun5AMEtwT33y64Xd
	LvfdkcyAuj+/oQXS5CgxvoUIKeooAQeGb19NpSG52Gyc9Erln9vqdjgPvfUkrwyi1SDVqJAGAXE
	XZCrjPX1VZ4IlY7TrmGOgHrW8CKau2O2t2HdqL19V+mRGHpdhj66C7apJJaGlvgCbeUYivcNZiW
	mdZ67pcqej9ccP9Wgbp4J+JVTT3lmPLeUC6W0XTng0ncplKmXIisHx8tc+CCcVtLiLGyW/u20vO
	XeeEr56IFtux1h8a5xTVnzYd/0vcVzwPXHPM3H4hOa6qLC3A1Tbi//YCyzWCS/x0gkTI2r76Svk
	WHk1FJDnuQuDCehgUpzQrAlx5fU/CbI4D7zTG5e+kdEOPy7HMtGQ6cVqkorug2kKq7qfYMxMzya
	4c+wkBVaxjut5/
X-Received: by 2002:a05:622a:5588:b0:4e8:a9f6:360 with SMTP id d75a77b69052e-4ed3106045emr43953801cf.70.1761921930936;
        Fri, 31 Oct 2025 07:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5+REZLSoIAdglhasOxd3hWm/UGtFktQgHQz41B27IbrsB/Zb7GRMxZC+lsXsS1X6v0aQefQ==
X-Received: by 2002:a05:622a:5588:b0:4e8:a9f6:360 with SMTP id d75a77b69052e-4ed3106045emr43953011cf.70.1761921930279;
        Fri, 31 Oct 2025 07:45:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 00/25] interconnect: qcom: icc-rpmh: drop static IDs
Date: Fri, 31 Oct 2025 16:45:16 +0200
Message-Id: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzLBGkC/23PzQ6CMAwH8FchOzvdh2zCyfcwHsYouihMtjExx
 Hd3aIyaeGnyb9pf2gl5cAY8KrMJOYjGG9ulwBcZ0kfVHQCbOmXECMuJoBw7uFp3wkZrTGpeSSa
 FksUGpYWLg8aMT2y3T/lofLDu9rQjnbtvRnwzkWKCK005E6xY15JurffLflBnbdt2mQqatcg+g
 iTrH4ElYSPzRumiENDkf4T760AH/ZCeDK8rUaU84HnIhDLrYAyrVvkALs3fH5bHoDQcAQAA
X-Change-ID: 20250613-rework-icc-0d3b7276a798
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5403;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6nlfIDWVoO6X4bV616Nj6UdXo/PgmNDCxuueBokBf4o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuAOk2hrZHHSgd0wAgezQ+fSNcc92TKHr6ax
 0lzhUOJK2eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLgAAKCRCLPIo+Aiko
 1SDBB/9op3bW14Vt4BEYWkX+llnk1SW1f+qbwGCYHEJOdy6G3gU0Depwb9DQeEmot09KhJr/tu5
 TWk7WMjU4y283gU16qmZN7y+vy2CxYtEBemwlGXsihvvCrfdBKuvSZ/QrkD2HEtBYUYPUn58vtN
 TUoa1XTBjl3/FvG6rCapNXRsrRs9oiQVgQ35kYl12lgtOsZB8DSHm7yrou3pPgSUo1SiAgZ7ZB3
 yGqojVhUV1ld5OjIEHHelUAxhYBxP4yeWhBk3fvhVmFoo+UDsL86W0vDuHRwxGeRtSznRfOk9pO
 bFSzDuIIXEeUslyBPXA8ALIKvaDw4bDyQC7ACM/rxz3AcyqE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: XK6a6wKiySy_gI6-adEYt3965BRyzswP
X-Proofpoint-GUID: XK6a6wKiySy_gI6-adEYt3965BRyzswP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX0tJJRsgvYIqf
 BbRAZas7MoRzb+tYBvDJp6oEmcthY/lwWBVXNAbSoVPVnL/YtHBwndMOjAhZ5BNO7snMB+6ecer
 bqM3c62Pwyp7GxODnugU15aAA4JqObK59+lcktZXn6DKfEICOg52ts3RX+yGqnyI9VInHGxrtGi
 Mw2qHeNAJXH90PHAqVQqU6R4xDs3bveFXO9JhuE8f5zbQqcVYlp6N091Gf65kpnYFJTk9Vgc78g
 l3aXhnrsO8HlivpWeRNBPFKPtcWCu1yFtxQspUzufy6Z7M9G6sjfFpT/YTSmgv1ls0YUQHTSoLg
 OuxNkb1SMk6oqgrbTqnKMd7sUuoKF3iIM4aSqgUHwqiywUR8mFyFiDGlT9O2cx79lc9vvBQkMd5
 /rgCYv3LoufYJrTlA+oBTCVn2eYP1w==
X-Authority-Analysis: v=2.4 cv=XoP3+FF9 c=1 sm=1 tr=0 ts=6904cb8c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KoqnvRM8aJjj302hGRwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

Currently most of Qualcomm interconnect drivers use static IDs, which
poses a threat of possible conflicts with other drivers.  Rework RPMh
interconnect drivers to use dynamic IDs and drop static IDs
code.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Dropped the NULL-termination patches (Georgi)
- Rebased on linux-next, picking up changes for Glymur and Milos.
- Link to v2: https://lore.kernel.org/r/20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com

Changes in v2:
- Rebased on linux-next, dropping applied dependency
- Link to v1: https://lore.kernel.org/r/20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com

---
Dmitry Baryshkov (25):
      interconnect: qcom: icc-rpmh: convert link_nodes to dynamic array
      interconnect: qcom: sc7280: convert to dynamic IDs
      interconnect: qcom: sc8180x: convert to dynamic IDs
      interconnect: qcom: sc8280xp: convert to dynamic IDs
      interconnect: qcom: sdm845: convert to dynamic IDs
      interconnect: qcom: sm8250: convert to dynamic IDs
      interconnect: qcom: x1e80100: convert to dynamic IDs
      interconnect: qcom: qcs615: convert to dynamic IDs
      interconnect: qcom: qcs8300: convert to dynamic IDs
      interconnect: qcom: qdu1000: convert to dynamic IDs
      interconnect: qcom: sar2130p: convert to dynamic IDs
      interconnect: qcom: sc7180: convert to dynamic IDs
      interconnect: qcom: sdm670: convert to dynamic IDs
      interconnect: qcom: sdx55: convert to dynamic IDs
      interconnect: qcom: sdx65: convert to dynamic IDs
      interconnect: qcom: sdx75: convert to dynamic IDs
      interconnect: qcom: sm6350: convert to dynamic IDs
      interconnect: qcom: sm7150: convert to dynamic IDs
      interconnect: qcom: sm8150: convert to dynamic IDs
      interconnect: qcom: sm8350: convert to dynamic IDs
      interconnect: qcom: sm8450: convert to dynamic IDs
      interconnect: qcom: sm8550: convert to dynamic IDs
      interconnect: qcom: sm8650: convert to dynamic IDs
      interconnect: qcom: sm8750: convert to dynamic IDs
      interconnect: qcom: icc-rpmh: drop support for non-dynamic IDS

 drivers/interconnect/qcom/glymur.c   | 225 +++++-----
 drivers/interconnect/qcom/icc-rpmh.c |  18 +-
 drivers/interconnect/qcom/icc-rpmh.h |   7 +-
 drivers/interconnect/qcom/milos.c    | 142 +++---
 drivers/interconnect/qcom/qcs615.c   | 511 ++++++++++------------
 drivers/interconnect/qcom/qcs615.h   | 128 ------
 drivers/interconnect/qcom/qcs8300.c  | 671 +++++++++++++---------------
 drivers/interconnect/qcom/qcs8300.h  | 177 --------
 drivers/interconnect/qcom/qdu1000.c  | 348 +++++++--------
 drivers/interconnect/qcom/qdu1000.h  |  95 ----
 drivers/interconnect/qcom/sa8775p.c  | 200 ++++-----
 drivers/interconnect/qcom/sar2130p.c | 630 ++++++++++----------------
 drivers/interconnect/qcom/sc7180.c   | 678 ++++++++++++++--------------
 drivers/interconnect/qcom/sc7180.h   | 149 -------
 drivers/interconnect/qcom/sc7280.c   | 617 ++++++++++++--------------
 drivers/interconnect/qcom/sc7280.h   | 154 -------
 drivers/interconnect/qcom/sc8180x.c  | 648 +++++++++++++--------------
 drivers/interconnect/qcom/sc8180x.h  | 179 --------
 drivers/interconnect/qcom/sc8280xp.c | 825 +++++++++++++++++------------------
 drivers/interconnect/qcom/sc8280xp.h | 209 ---------
 drivers/interconnect/qcom/sdm670.c   | 522 +++++++++++-----------
 drivers/interconnect/qcom/sdm670.h   | 128 ------
 drivers/interconnect/qcom/sdm845.c   | 766 ++++++++++++++++----------------
 drivers/interconnect/qcom/sdm845.h   | 140 ------
 drivers/interconnect/qcom/sdx55.c    | 489 ++++++++++-----------
 drivers/interconnect/qcom/sdx55.h    |  70 ---
 drivers/interconnect/qcom/sdx65.c    | 457 ++++++++++---------
 drivers/interconnect/qcom/sdx65.h    |  65 ---
 drivers/interconnect/qcom/sdx75.c    | 378 +++++++---------
 drivers/interconnect/qcom/sdx75.h    |  97 ----
 drivers/interconnect/qcom/sm6350.c   | 629 +++++++++++++-------------
 drivers/interconnect/qcom/sm6350.h   | 139 ------
 drivers/interconnect/qcom/sm7150.c   | 653 ++++++++++++++-------------
 drivers/interconnect/qcom/sm7150.h   | 140 ------
 drivers/interconnect/qcom/sm8150.c   | 706 +++++++++++++++---------------
 drivers/interconnect/qcom/sm8150.h   | 152 -------
 drivers/interconnect/qcom/sm8250.c   | 736 +++++++++++++++----------------
 drivers/interconnect/qcom/sm8250.h   | 168 -------
 drivers/interconnect/qcom/sm8350.c   | 684 ++++++++++++++---------------
 drivers/interconnect/qcom/sm8350.h   | 158 -------
 drivers/interconnect/qcom/sm8450.c   | 601 ++++++++++++-------------
 drivers/interconnect/qcom/sm8450.h   | 169 -------
 drivers/interconnect/qcom/sm8550.c   | 501 ++++++++++-----------
 drivers/interconnect/qcom/sm8550.h   | 138 ------
 drivers/interconnect/qcom/sm8650.c   | 527 ++++++++++------------
 drivers/interconnect/qcom/sm8650.h   | 144 ------
 drivers/interconnect/qcom/sm8750.c   | 602 +++++++++----------------
 drivers/interconnect/qcom/x1e80100.c | 610 ++++++++++++--------------
 drivers/interconnect/qcom/x1e80100.h | 192 --------
 49 files changed, 6642 insertions(+), 10730 deletions(-)
---
base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
change-id: 20250613-rework-icc-0d3b7276a798

Best regards,
-- 
With best wishes
Dmitry


