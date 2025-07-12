Return-Path: <linux-kernel+bounces-728476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B4B028C3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D93BB390
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC5E15D5B6;
	Sat, 12 Jul 2025 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="boHp7gWT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55A21FF58
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281934; cv=none; b=X6khN/Sm8Xgr56WW0hc0FO1XYwpjzH9KRtqva0Zq/hRwZ7pYTk5oLj8JVyl1/Y3Om1qtQizl2zY9UsMEbgKE5Q8AuAUOAKOuLcV+Z6kksKdSNonEdu5jeLgDb/ZydW9soXS4P7+zwgu29ZQE+TXu8oJ4ltWM9lInwPkvgC5smNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281934; c=relaxed/simple;
	bh=9kVJAzY2UVngycfebqlTXxBWX8Abe2dBrz4IzUnf9Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sa+r2dSN4qL326vUwoe0T7r53AEzJWLKWcoLxAGYIpvjhSc2Czyo/+N717ycLTVhPNqUxm2zk6diGOK4WqQ8x9cEGZBwShH0UP9NwnJZRlRRjX9zlE5rX/iUSqeNjTvP/zFOq1V2IXueiFwJXbG6+ZOdKw+IlhLnLsa05Eh365M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=boHp7gWT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB5Qhv029945
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7sLJEL4Y5lJZguz3eyBuo3UOb2LWXxlleh1DhGvnHak=; b=boHp7gWTt5GjwyVG
	d6rxAUCcj9DL6VBNPZR+42TaXUrC/Fm+CGZQA/7I+YeuA58sxmCBwy6Ukg60fHMO
	UZ0AQVt1Ixdwh4+Y9ZA1D2l64D2XDnn0MnZIaMGzVPlPKDiLVJAd3AiuOApmILVn
	l1hiQwLcNe4NXApwSl+OZz1Dyb4oF/97+TNVyot7yp2kJeIZ8PSmD8BLnfvLae4N
	l351z2l+Z7N+6Gqiw2Mv2ibYKGbR5kadlmLP0MLRLpShOw5ojIcBpKDOKRnuE143
	ISilALVm7hJEWuhJQ+fahJwgvNoGjGG2UrbVDm79OEw1PTLKk4Z3D6iSx4cFYjXq
	qUF0gA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbet999-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so2519079a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281930; x=1752886730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sLJEL4Y5lJZguz3eyBuo3UOb2LWXxlleh1DhGvnHak=;
        b=cm0ObGyVhmYxZ3x+tiHv4NImEgI2iHacUFKK3npttkBQ9JJBdEQDHYLsbchP9P/6Mu
         sK5X0DFeawyicxwWZlnXA8zX8CkAZC/m/0ltovbHFRvxZV688docIPjy5NCpX/9M28dq
         Nk1VrAuMPn22i61npmjg63j1Tx7lAlnITtOlXyANhH2DuYOPnx7BPaeaKuxIVen67PQT
         Q6Ubija3kH+/DYFEcAL3+Tl54uBHMao69EWV3G5GHb1RklZ9kAeZYmJoYZXsBaAYEirP
         YncKz7TSo82wpQZV9A5+pImBck97btNKMLKjwMvM8CfDXe6br3SErBin8fL/M9JGXhPL
         2/Og==
X-Forwarded-Encrypted: i=1; AJvYcCUaihzs1GvNom734j/dPo20RuPusX51x1Gy1iLKVV+6XHYxzJdVwFL8krEM6gvwdL1MvdpANwYD7ZK1VYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIkrwM1Bu+IXJgiozknq03r0TrPg5XNhfyxv1xr9+IxQhW6oh
	ruqB/05J5PaGyvJq9CNpF+W4OI39iUFU5BJFsK1WbUQYc8qsbTREcHqVaEb+bR26Pzec8S4RBIV
	EI5GtuhbFDNzhgAPvb2WNAbWCKtlt904zrMuW8kL6TnR7SysqgJk6ZBh1wREF2H62n+M=
X-Gm-Gg: ASbGnctil9WOrw6xvWjQtHn6Tze61pFNhX7IdN+xtnfUwfy4i2xCKqW49o5zlrHdNKA
	JPGFwKyhXTNQDfS+IlrlmhuQD6ZXQ/BSgCbjkpNCuthzrLCF3VaTnmgWQIRpBEakQBZRzN6jvbQ
	Cw/2xNTJCY4b9VRQeRJ0kGzp8MPgnKudtjqx8wxJxWHoafZmg9ln5IqQ6HStF32PYCPllBPpgmr
	6rhPkLd+XIBa0c/qbBtE4Kbo6puy52214bPsYk4jiJKtL6oGFiSKdZp1mSYsmsD2jvlSorNFeQE
	7v1nWHF2MMbB5roNHVW1NJ5qhZWB/bzrIoQNjVdnXdljK4fQrJgcV2UcwLGMUbmf2AnsKCunCE3
	Ay6tofl0/I4rXsl4PrgVDUYS8
X-Received: by 2002:a17:90a:d88f:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-31c50d7b0e2mr5926416a91.8.1752281930196;
        Fri, 11 Jul 2025 17:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbwePogEFfPtz3jAzJvuYrrBkkmysTcdFzL7yxrfrSVdKodFresGxmdbEN7GKCEIj11A4IDg==
X-Received: by 2002:a17:90a:d88f:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-31c50d7b0e2mr5926385a91.8.1752281929755;
        Fri, 11 Jul 2025 17:58:49 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:49 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:20 -0700
Subject: [PATCH 15/19] drm/msm/dp: Drop ST_DISCONNECT_PENDING
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-15-33cbac823f34@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1224;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=9kVJAzY2UVngycfebqlTXxBWX8Abe2dBrz4IzUnf9Vc=;
 b=CYGPKGabSZ/+TIsiQAZHb2A3eC/F6u/eET7zLcbCthqfB2ue7vTy3EREyb3X+n5CiyHbVY84j
 Y/BXfFJMiXUA/hiWbzM8LmB5YRERO18jZHLTmDJU4AEqP3Ua3kRWLdX
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX5GMQJm6ehLm5
 +2bkS4/PKmE1wN5AHVGDh/77URnOniQZrDJ3qXY4hJgDTB/MHJQ1Xe2QA3dTBm9Dxadcl1x9h21
 F3GMjt5v/Rw+S/z7n2kozBqA1pwWINfTLRv0OglF7N3pMLztCC144QMyY9eJXFulCIslARTecO5
 wGtBKh81f6CgRT0yo/n/cUeyeoCiQFkjJiOEgYmEOjquKmP24Ok4mWcklWDoC01FajtxiCzGQmO
 oE3q6iN5jNEw6Y4z7iEHQil+HxfQ+raBHK8vx6GBayJ9c1+k5yDc6/GvQlOEhOdHKdad3hkB3dN
 OgSF9y9ZzKn1BJ80s00HtxuMNNKfoB4ZYWzBNMPTwUk4Yi942ARmGPj48HI6n9ws5KNFkWf5oc5
 3exi/qBUhj3uXzYwc2T4jKurkLw+5tVh+H7+FgJwQFErd5ImjCqQigRVOJGCKBdj+rvmluvi
X-Proofpoint-GUID: -wqhlqxK6VHPCv1QJrAe8KHQPRj4tRPa
X-Proofpoint-ORIG-GUID: -wqhlqxK6VHPCv1QJrAe8KHQPRj4tRPa
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=6871b34b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=P6Iu8OupbF04u0vqO0EA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507120005

Drop the now-unused ST_DISCONNECT_PENDING state. This will completely
remove the hpd state enum.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c7ad61e96b37..529e30193168 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -43,11 +43,6 @@ enum {
 	ISR_HPD_LO_GLITH_COUNT,
 };
 
-/* event thread connection state */
-enum {
-	ST_DISCONNECT_PENDING,
-};
-
 enum {
 	EV_NO_EVENT,
 	/* hpd events */
@@ -517,10 +512,8 @@ static int msm_dp_display_handle_port_status_changed(struct msm_dp_display_priva
 
 	if (drm_dp_is_branch(dp->panel->dpcd) && dp->link->sink_count == 0) {
 		drm_dbg_dp(dp->drm_dev, "sink count is zero, nothing to do\n");
-		if (dp->msm_dp_display.connected) {
-			dp->hpd_state = ST_DISCONNECT_PENDING;
+		if (dp->msm_dp_display.connected)
 			msm_dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
-		}
 	} else {
 		if (!dp->msm_dp_display.connected) {
 			rc = msm_dp_display_process_hpd_high(dp);

-- 
2.50.1


