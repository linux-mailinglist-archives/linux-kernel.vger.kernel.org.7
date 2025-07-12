Return-Path: <linux-kernel+bounces-728472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBDCB028B4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32294A608CA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934761F582F;
	Sat, 12 Jul 2025 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VHY3mW2F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6D1F09A3
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281925; cv=none; b=HQ0a20MpBC+DE5zTaZax6SPv/6+UcJJbpNlLS2sH/gwKsIPuIGr8JMRVY5gpwJoJ15l5VFGLibeG+pWl6aJE50jmuMzwptOOzvo4gyBIxskArZnYhrBxTL7JntRZEl3O/JNM//MOZY6Bpi4aZp0+qisk30Nx2yorDsq2o1RgsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281925; c=relaxed/simple;
	bh=188J8HQVdkSWJL5yLh9gG8Tf0d3WxXMDhANnFNnA2Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LPdZ+jRaISYsomd/bbv2a3r6WL2+oXbDESjdMEMIDrdFzBEnVLsaYS0YMQEKOAPP5kbnTowo83NKzOcLk3NJJt6hnVzs9wfMpOlxUv8+jnxjURhDkITlPy2QKaTUKtfb6syHB65FocM9gaQBdTfQTzE40tl0UQmkzcgpx3epZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VHY3mW2F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BMojIO018184
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fl8z648VrhMIvou4b1DZumHvgXBVOysJzC66Tq4IjrU=; b=VHY3mW2FmUlRIfZ4
	ZOxSfsfARs3eWhNoskrb4v9kz2lzNUfUooKYRY9CHx+aEqadXRGbHX+6SN2P/egR
	YsfW6f/WRF+ZJZXJlgy+nf1TKdO3qC0f35olOsNDQnV0pQR9RvLi7BMauF2PKaSP
	faZCAtTP8Lo8q4WXmfKdOofTE8jLGpA3iQ79EqC9PXdvWNo8sE+JNa0kYKKQ4Mrt
	Hq7OUkPZIgsaE1hBPcwM6GZT98+A3HnLrkrBLge+0FzNWSz1nYYEuTqHlKC/6rix
	/BKwnGXe3YxiDkVO7MRgeRz35KoeEwVp67H3t7215rXlRztnGSjtRi22w9Sot+TC
	4NQTDg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47tkf345xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311d670ad35so2612751a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281923; x=1752886723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl8z648VrhMIvou4b1DZumHvgXBVOysJzC66Tq4IjrU=;
        b=uLGChSZwUgFs966jHa3x8ully6WoxGwXPKZ8ZYrWHw9HqJQXn1M/JzDha7QjxlEPSc
         DUsTirqngF9SeZXrfkMRfbTh79eIuqjPmbh8yGPw3KB/+N3e176BWiB37VwIA68GVK0A
         jJm8ZzlxHsMUo5sCJ/7Hs1JzHrC4mr3Pqx8xrr8wutsT5XrHUugrs6rhoNuGuWtoN0pB
         V41/J/6zyD/FyzkFtnBgUMtuQ+I9YXNfP+hw3nBbnm9hHcQbrRvpVxPaCU2jeoz/2+Tj
         B4cpAVeU2ipu6D3YdpVXK7+WuRqZtgQXsLXA2/gHzDiwIdipWCWGm/cWIp3Tvs13E6Uy
         /9hw==
X-Forwarded-Encrypted: i=1; AJvYcCVRjjwQ8uZGH51mSHZXc5g/o4V0i3eU4eX3TqwkxQ8yoyjuGEahD3xD1vsGhIGHF4EeYh+QtZzUyiL2UW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJJSNXdVHlG3my9UtFzqSsbDHdCmuL52KGa+RPvPMo9gKiPmq
	+DhEseyy41v2EHVIW3mkO5rNA6kI7Iq7gf+An0k671XPP//bmJedQVM6EoZdOutCIMCfXeD3xEW
	pz2rSQ738IUHUqFhJCWArljZd5FFmGEONIRIo+HbrGckx+K67M/6NUDd3wYJnk0B+SuA=
X-Gm-Gg: ASbGnctT9uSMp8x133zo/aO28xazOW4zLeiJm9Sz5DxrtmNo2cyeXP3tAGvQuOocI8h
	uThhH/4JOCProJIP4XHfL2Z2TloMl3YqwjAycUDIrR3DfnX5d2gSoNVJdaQr3aXBZi2uAoCaZC4
	KGXG/ZaMW0Zo43M/XymgEVdAOSNr6acbENz3coR2q/BozM74dDQwqvZBTrNKbkNVsEnae1iuZqE
	iXSTj1hhubLBHgIajhzjTVY/fbSNR0UFxySajFPpkj1F9yF4qW9u+qZmaljaGsYQ5jy1dWoUkAW
	50shEGcdE7vxjzInEduj7JKZfVW12k9RTAdlfGkUx6XCKVZBtrW+qS1RqvV3ZRstW6XEMbpfWcc
	eQxx/z38COaPmJdG1f0oCWKQV
X-Received: by 2002:a17:90b:4c0b:b0:311:b3e7:fb31 with SMTP id 98e67ed59e1d1-31c4f38f296mr6562768a91.0.1752281922865;
        Fri, 11 Jul 2025 17:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzKmykxcOi7eiVHkBQUvfbqe7W8TpJLzKZDJVQgtqH3XstptXMGJj6vS+CfJ5H1ALRn0iosg==
X-Received: by 2002:a17:90b:4c0b:b0:311:b3e7:fb31 with SMTP id 98e67ed59e1d1-31c4f38f296mr6562722a91.0.1752281922296;
        Fri, 11 Jul 2025 17:58:42 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:41 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:15 -0700
Subject: [PATCH 10/19] drm/msm/dp: Check if DP is disconnected in atomic
 post_disable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-10-33cbac823f34@oss.qualcomm.com>
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
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1047;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=188J8HQVdkSWJL5yLh9gG8Tf0d3WxXMDhANnFNnA2Fk=;
 b=FqvQDl31EdqzSOt4Hvfj+exBkiXqDCV3n0dR0LgZUSZS8s7Kirwh9cM81Kk0rDfMx3wCd/r9L
 5vrMnhBRtN0BLDkpuichaWN+O2kslCCRaf2b2pp1tEdByp9TD+phAmK
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX2mvUwaLOtuNL
 rQNj8pnEHVcxyH8QU/OSsNYhQgNMfEw7fDR+dfNyYJ43QCcUD9UAfFeBte+FMRFNE1Ex6pfcDgW
 QnvgpP3L3J1eYMi2t1VZm0JhAcFcTU4AvBjOsrwmYJHFn0KcVrdfUzvDomYbTuip/kohS7DfVbF
 ARr/lEmLyxXFWUFIBw2b0Y3VIgRA0iyTk+cm+aR8ltz5uQImQDV2cdnwSIhHw2XmztG9eL2Xe/K
 0KXn/9R0HPZsLtMKOpKzlSfxIOOlnLSSzTe7601TlFKn2lne9IGaEhndB5Wpa6ps2ugaMYJIh5Z
 FWJHbtl69tVPWr9gtKwuhsWRC2bfheO5Dht9cUoUFIumSahV53r0t+Xo6QLXSyjsmRUP0Cs0Gsa
 yWLobyAZa87isAtK/BDkvmx38mkg9PehRGnWM2KrUmXyW4LW8noxmq/JqZl9YytsO19o1blO
X-Proofpoint-GUID: kGEBiXiuEEKc9XzuhuMfgE1SJ_S4w8IU
X-Authority-Analysis: v=2.4 cv=Xuf6OUF9 c=1 sm=1 tr=0 ts=6871b343 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ict5BleZVNFJU3CK3-QA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: kGEBiXiuEEKc9XzuhuMfgE1SJ_S4w8IU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Since the hpd_state is unused, change the "wrong hpd_state" debug log in
atomic post_disable() to log if the DP cable is disconnected.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6535c1cccf84..4c9a515648bc 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1643,10 +1643,8 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 
 	mutex_lock(&msm_dp_display->event_mutex);
 
-	hpd_state = msm_dp_display->hpd_state;
-	if (hpd_state != ST_DISCONNECT_PENDING && hpd_state != ST_CONNECTED)
-		drm_dbg_dp(dp->drm_dev, "type=%d wrong hpd_state=%d\n",
-			   dp->connector_type, hpd_state);
+	if (!dp->connected)
+		drm_dbg_dp(dp->drm_dev, "type=%d is disconnected\n", dp->connector_type);
 
 	msm_dp_display_disable(msm_dp_display);
 

-- 
2.50.1


