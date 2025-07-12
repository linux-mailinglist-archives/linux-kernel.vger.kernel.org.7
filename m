Return-Path: <linux-kernel+bounces-728473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB47B028B7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2008A60D21
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5932135C5;
	Sat, 12 Jul 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTK3Zm+7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8F1F1301
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281928; cv=none; b=emZYSAS7suuuW/oKGTaIBVNIChZ3ArAKGjLDJx5OEXYVCwoGHcOrptE01TN2SwQZFbigDhImTGt+rStBZYra2go1AigL+A1cnrP6eWY9TrMW13AcHGqtfOJ3CqT5uHRjw+C/AQDILGJI/yJRs5cWXZOSU01J7B8ZLQ5VKe/2CAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281928; c=relaxed/simple;
	bh=HTrS6sAi/jnAaHRctTTXyFxWe0sOyzNOXSJAQUs3eeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdJyn2mbMAnOs7MLCpl6MuIbGA6EStjzwQMSA8JKBJqSjAZs3MEKLVJUwCjFkZwQfm7YrnaGYgeKoEq5XttEhOxXME3E1/5VrzgPXGiaX+WFuGQF6/ALb1C+8pwHNekKwIf0o75eyUa5azsUL1io7y3IQHOXGlsuwwn2Bv5hTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTK3Zm+7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAxfou003719
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bnj/UdtLS2aJT6tt+mnkQtsgFuu9yNGCn+96IC2OnLA=; b=WTK3Zm+7AdUZi6nJ
	+w4v21aGD9luQc3Iy4CZdymSx0pOmpYXe1z3yzpi+GRqjkeMHsXIQjqpUHe+SLV7
	Bm/uqPeIeEfWiryX6IEDVKlBU6hUmYoB8esnMkVOuDK0gXvASWABIYN+UVGbA794
	VY9WQgUAwMrZlHCWmJUkRAzouEXm4Afo1zpX4jcSf7B2pBJdBmux6IBvUg+oeB6x
	QjQMSeGIW/lmfOycsAWh7YOHvn2Nr1j+WfpzWhc+uDWOr+zdJ6VcuB/SneuREgLt
	127nOOCoYn/fF1wKcg19GjEmbGn5kVH9Yozb6QIw2HUT+khoIev7I1R8NXU8jI6a
	YmDJuw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbp29x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235dd77d11fso26865785ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281924; x=1752886724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnj/UdtLS2aJT6tt+mnkQtsgFuu9yNGCn+96IC2OnLA=;
        b=jwjd8zsdXIIej8OFuQBd4OYmsoVO0/akq5mxL+hdlvxiDsollNrsUAG8lEIlUAvf9J
         ilAWrpeJjtCr4L4Z/64Vzp3WxCBeKtgMU31haKxKDlicfSSfymMxrIyS9B0DBzDpcfac
         grokQgeCUoFnDtfK1mQ7kH4Z07QyED6gR1bUK98ylJcf00aJymIiZcOE+l2OTzTlrJU4
         hIGLnDFs15dQhjyJlm0IQ7rd3zh/F+DOkgUiGCrHMcHlpg/6xNeGYGtWgyZoXJC1n0KJ
         H8NSx5lu8RW1rX6uQhi970FL8Vmp5fkvTD1qmg980BiJMKAmoFkKo6SayVTO2pjcban4
         g+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWbvD4LMWJNXZXvUYc13rad9nxMevlZVGAxS4LoyoTu/SxSnfuz4iKgRM6AcnW9VnM8s058IWbyIsGHzgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnF8YhUM7O22W6VdTZOb420yu6vAEp1a+3+NF/HJLJEJc7PAJo
	XGCicMl5EU9qjlMZLZnQL5+WcxFAYJUHnzsDBrEoT5ny995rJg8NhWMR8i6gwXwMz6RN2dgrysm
	gtUDgTVcSmTSMEAqVzni2M8ttcSbCckv2Tk4XmOtSPUTfjKvjtzc7tzpkpYYSx75HBss=
X-Gm-Gg: ASbGncsE9nZdxo6VgNXi2LbN1n91gWTU/E8lvuSTMbs6qacNjB+bwWnWETGFQry7d2b
	hAVHvXQpN0u3b5iTO7GG+/jRXcO15WyGnzU7gW8GImxv87Wj8y7LGlZmYOA+ZqY8ujAFL3gzZmm
	8eGusc6kbT9EKnDaOe71LuC25cIpZ9aHHUEDa8hfIi8cqZMMZEV0raPeXe256BZJz0acTjF4890
	IILYMFR8KyXiLfdEz/H94r0cIebn3pewGvyQDC6nSbaznRZ6ZjWevtCu7wUsck5+hjLKiuxDokS
	FcVCqFnwFujYedqyMANV/tvXtOzt3OImmeFSQaYM6f2eApnkf5Z3/4BIsixc5/4QYKa6MvKVsRn
	XscNpcu9gW7+ogQNd2GSwEWR1
X-Received: by 2002:a17:903:b8f:b0:234:c2e7:a103 with SMTP id d9443c01a7336-23dee0b4bd8mr70465395ad.33.1752281924279;
        Fri, 11 Jul 2025 17:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpusDhFVgrUlTpfeonAK2ctLBAovrbfhCYztjelTtDsWRdvt1q8SMY3jgvBDzdtC7LdCLSHA==
X-Received: by 2002:a17:903:b8f:b0:234:c2e7:a103 with SMTP id d9443c01a7336-23dee0b4bd8mr70465065ad.33.1752281923817;
        Fri, 11 Jul 2025 17:58:43 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:43 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:16 -0700
Subject: [PATCH 11/19] drm/msm/dp: remove ST_DISPLAY_OFF as a hpd_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-11-33cbac823f34@oss.qualcomm.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
In-Reply-To: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1085;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=qiVAy7LBnLe6xWk8rAe5U/Lv4H0O1vYH0pwvmDHYaFw=;
 b=PZTBGq2SsGnfTa5lANcBGzPbzp7hYuocHgNU0oogVN6pQFC10FUz+KRyjf9Nzx284+35/YVOz
 5xYZPq9PivYAlMpkfEHmc9/ZugLlIvRMkX1fYAWogVCNFlRr7rNwUi1
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX2jvwln1WAHcw
 ohIR791kr/2/D3af86Afx46PsTzLO2+DL3jlaNqnzSCVjg/4QR8yyV+KaJTmpFMAv1vDT+vIy5u
 Kx9zVfTqo5nClCCWmPnLjzdA5gS5hvY81lsyyEHw93pRmmoWPKwHGUiw5Et3GNuHLf6dIUYBwEt
 mYEVZbZs5tD0uHEnu1qfr4YvXzLS2cyOAjcpE2gGBMrzIy/IwTjKaLZwVZMJMt7pbn+o5nQGQEz
 px7KULdNH+qazpaK/Gg+MZMY7fnobOxsutvhgTXBqre8O4RsMwq5l4mWRebPDt0QKF0zpyLejjD
 S+n0p4zWNFjaLNM5l1wdcIMxLS3WwEPpAE/APpio63Lj0rflU4W0hChX+NHJBA2aRTy30eCyy1s
 tjFVCueiKZ0m+2k+LS24bGduaUh1HNT4PRNRox3h6zzXxcnWWXW7FhscpRy7nnn/iVcRcK10
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=6871b345 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=5EiMiATjTmrooIwbMLsA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zCBK8MAdwQDEk_1lg4x2zPAY50vk3DSl
X-Proofpoint-GUID: zCBK8MAdwQDEk_1lg4x2zPAY50vk3DSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507120005

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Since all consumers of ST_DISPLAY_OFF have now been removed,
drop ST_DISPLAY_OFF from the list of hpd_states as technically
this was never a 'hpd' state anyway.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 4c9a515648bc..17093b78900c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -49,7 +49,6 @@ enum {
 	ST_MAINLINK_READY,
 	ST_CONNECTED,
 	ST_DISCONNECT_PENDING,
-	ST_DISPLAY_OFF,
 };
 
 enum {
@@ -1652,8 +1651,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 	if (hpd_state == ST_DISCONNECT_PENDING) {
 		/* completed disconnection */
 		msm_dp_display->hpd_state = ST_DISCONNECTED;
-	} else {
-		msm_dp_display->hpd_state = ST_DISPLAY_OFF;
 	}
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);

-- 
2.50.1


