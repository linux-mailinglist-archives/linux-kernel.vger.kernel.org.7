Return-Path: <linux-kernel+bounces-728475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6374BB028BC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535FF1C822AB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4AC205AB8;
	Sat, 12 Jul 2025 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d6CEWo6o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCD219E8C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281931; cv=none; b=taBoov4ppTzzcUHwn9mxv/ZHfumbdGDDerXQxb+YJEGjYp5ce3i7w+CGJHl8qFF/NgBsVyleQkOZGlQQSIw2cOvOXZKaalEa/1FXO9BoIR+SGzxQ761YMgG4CkjATjzXt33L+jCpxRERrSsiqORL+2RG7TtD/CMR+cYPwF9Vckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281931; c=relaxed/simple;
	bh=rUc4Sgw5rxOU20loNM6AdBhsgLGh23bqcztnvCfOjeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GX++0GMLnUasXqu6lNGftMQwNvia2nsq0bLjd+eltp2IMp/Q2Hp7JbrJOowtYTnAFFvWg6R1nXVRZwJp0lIWbB+fkthHWB4NIfq9RHv8NfnmFB70Skzl35bpkzVzlrRD5kzrFLpWz7MPTqrqkOmWGaC81cSVV9dmphBhRAXeEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d6CEWo6o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C0OkAm010015
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bszOuNEzmYEHHlgQlK1KYpB1RHEkBL6gk1zou4Kczfs=; b=d6CEWo6oMn75QCMA
	eP9iMW8OF9R10iyrHRSm+vVx8ns2eAJKJUYPNkDazLyslYaVpGIWnqLZmFdnFInZ
	x/4uVBEdBEgZU3z65jW3hRxycwrZiqdZ0RK0Esa4p4VMb4qep+I4fs+nXpV9N+Da
	iyw6udVBLUSreh8QnJju4oUBb7hv5rnwUMEqSMj3NqLGb7K6zX85ywdNxWaKi/tW
	FNK5c4U0pbb4yurc/i+eDewmHRA3mqwxpxfem97o2eMEqQYk1veR1nxuE4Mz/4YW
	5OsxdcocS02p3rUhpVAFV1hOXDH5u+bOG6w1GfXiti87uGzFWs8v9DvDx3fknyP8
	UDcgxw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b1b8st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31315427249so2419219a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281928; x=1752886728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bszOuNEzmYEHHlgQlK1KYpB1RHEkBL6gk1zou4Kczfs=;
        b=vXEozJPNWB5KZgBn649821bdVvYtsSAooPNu9wKRGnOHT/FXE0yFnHAFohrJwVZckK
         Ylo4FznaEFo8Uda6xoyJRKpVfcK2fALRhnciseIG8GFL/Q1f7wA4277BvsjnHxJ0nJwt
         SA1VdE9qOsAhEeDOf4EUg0JlDmD27T2HZpFMb7+cVIaSTodca2lsQ82eR5+0j3C311nm
         Cyi0w1cJLdFwqtFO9JOX9r9gUBMzcBZ2btzDGtLHYeyAiHW7vvMO8xBMVHZWttOKiFmU
         C1G7xcSEHoWKTL4MmKC7lBvWa7eIkZ9Y1++iRbm5Dt5uKlZ6RmJj01hO5UKlwUD5z5v1
         YklQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4yhnXhR0pkHK3A96xnT3fHYlMUzODPovpudmHbbWo76lW1ARS3DsxxHyN6FDiTQJymLaWFi4t/Rx7sAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04ndEXwHbGUwcAxDaY0mcUIBm585A7D/PGSZ4LCeaHY4tyR0r
	2pB52SKjyrBtNhPNAIt5E3LC6BEv1/Tna86ghAfguvYN7+oyoTcfAN6LEIOeit7GeG62HZn7fDs
	qFYRprcR8mEopf9AyWXGSJsc/P5U0NgXLjAbNAbBVwldwt2w+E3SSx7fkRYHvLfnRTsY=
X-Gm-Gg: ASbGncsgrPH6j0y4Hd5R+ZEG52ifMXBRfOgpTdC+B1nYiHEwUC3iCdx9BdFPsLfKCIx
	a9QOazDlRbv6y29rSQKp12wuXxvkMlL+/zxK5ws2KFJEHr+vHxZQgoEYy6Fo6JzNIoGSh908bBG
	0w8TgRcdmPn6xUcfrMQIFdsqjrSFmntP6RaG1+eiF0lmC2UI5U5+/N/yJz4xy8A9MV5j9eYnq+/
	fltK6+7dNMidaB++DYx4636iEmAM3KQPer6FpO/j2oUznX1UQO90gHL/UteeFeMB9DxB5GFu2Ow
	r76w6FAUSGwa16tnv1JB8SmincMFLgBYKPht9Jy5FVjAV4jcVVhbyxYztNZGYRgGANwL4sVW1WI
	t37aV4pLWHlfPxZ4fThG3WcFw
X-Received: by 2002:a17:90b:3a46:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-31c50d5dd27mr5480911a91.7.1752281928535;
        Fri, 11 Jul 2025 17:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPp232VKZu5fw0vh7/xwi5GtN1guTWNchaqd+MF6vNbgX0pVciWwweX1gqU38GAdEKUujB/Q==
X-Received: by 2002:a17:90b:3a46:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-31c50d5dd27mr5480891a91.7.1752281928124;
        Fri, 11 Jul 2025 17:58:48 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:47 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:19 -0700
Subject: [PATCH 14/19] drm/msm/dp: Drop ST_CONNECTED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-14-33cbac823f34@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=883;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=rUc4Sgw5rxOU20loNM6AdBhsgLGh23bqcztnvCfOjeo=;
 b=ofz4DmMAv5I6W/4k9XAX02jtlY82ln0uuSdJIP6n0rJn+5lWf3v5ties60153vfPtnsCPGq3S
 QElekPUwvEHBF8kimc20I7HFgbTWwwOGAq8QBTFIY7ozh/OADyjlT5v
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6871b349 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=k23i9R_ERYQwGrdfUk8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX+vQ+5KB0whMA
 FK1fl7ZdnBfvuCQ6dxaPwZKbSuNrFMdvwoDu3lNJ39HDp5ZbNkT9Bzlk6Zgqp0aDk7LTcNfBy9N
 q2o8YSAjqLrPvTEg/8YMCis8d4p9Z0RpDOVd8UHaIX6kxphQ3mLYXodUTEjWXOqAC6p1w/4Vhtf
 6rSSfj3q+ycvULVqTqeNgk/+c7DMAcJISSDi1UoQSCVLrQPUZX9ap6UB98oeHHPeHMCwphAPPib
 yowzxqdXCqkMAd6QckJWw/bG4IqO4342qrz0ng43qyTxOffB+IYV4xeIEATgsB+L8oWZ2zoxSZt
 KkTAakH6rNf8+RXPr+TIVEDUOTjO1se1t9Z5LqeRhkBvEZnDrKx1oOVqFyR+pjVGZDozj931Gg9
 MS/Gv+Of+NkPY09QSYeDrTFxNrqj1RNfc0NILJXkGJJgugZ5LNcEnH21iJeaInCfQ16ZO6ab
X-Proofpoint-GUID: eYHE7lC5lO79bIp8hPXYvgMEU6BUd0AC
X-Proofpoint-ORIG-GUID: eYHE7lC5lO79bIp8hPXYvgMEU6BUd0AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=962 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Drop the now-unused ST_CONNECTED state

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index dac5078a849d..c7ad61e96b37 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -45,7 +45,6 @@ enum {
 
 /* event thread connection state */
 enum {
-	ST_CONNECTED,
 	ST_DISCONNECT_PENDING,
 };
 
@@ -1594,9 +1593,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		msm_dp_display_disable(msm_dp_display);
 	}
 
-	/* completed connection */
-	msm_dp_display->hpd_state = ST_CONNECTED;
-
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
 	mutex_unlock(&msm_dp_display->event_mutex);
 }

-- 
2.50.1


