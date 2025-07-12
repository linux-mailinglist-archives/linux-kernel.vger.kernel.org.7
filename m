Return-Path: <linux-kernel+bounces-728480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CDDB028CA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73937B44063
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC1F229B21;
	Sat, 12 Jul 2025 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DzYmnk9p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D34225A40
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281938; cv=none; b=k2mw0+axMtLjPUJhxO2nyV1fxRCjak8JsvSmFOVyl0Ai69rp0eZRsZusR6MxWpz2BxeBLd3w+SyhS4rQjcGO8b61n6fB3Jbt/s1nItRL5BQ68bUc2NwIwVZLrp2/Sh/gPonLxUNdE9BZj4XU9MJwEYRoCc49nTUiovB2zdP9KZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281938; c=relaxed/simple;
	bh=yjltdvgzQFS/rBBYfAe4dvA1j+EvnEUZxQgjt30Wp1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s644uhME4SYhEekiqKFJbwyaMysZUXdiB/vuP9sn8qS/fdkyXZWt6LhLM5fM/7IeFjIY8Aoxwzfj0OBsrWveX6k9Po2++uAuEufyPuqFzP6lX58iodebYhQIxw2yt80TF8lNZwutr0v6zcGG/uZsjqjhkUrXt7DdP/DxJPIZTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DzYmnk9p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C0n6Yr013269
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kpz0sBR+v1h/WdMG/RhlIYKzhzI8L7RbaceCFIlPTic=; b=DzYmnk9pMCKKLcPt
	7or/cvo+N4cER94N3rqKy+jWI5yc7iOodbhyOMV977WQQZdDRP980jFaXGYZNoKi
	uuZF9rAjhOOcXixzXjOeljeh2e0wYJpEIIUqNAfLP2iE22Z8jYdhH55uNDd9fCyD
	iVeZ9Yao2qNOCWV3J7aaCXNlFmTIOz311RshrAyn3ip2TnUYZm0GA3pckQsxlrAh
	fqkHpDmlk3rLB9gStkwLeECtrqZMasxD0/ydCR+jSRN6pD0+7mDNdMX7g8fPiZyz
	Z8hK5S1E7xOg4ExlnsLNyKGlqWrCJlBAVV+cNQvtmfZLiTZUle9yLZ0lB1pOQYXl
	XLeuvA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47tkf345y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313f8835f29so4025060a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281926; x=1752886726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpz0sBR+v1h/WdMG/RhlIYKzhzI8L7RbaceCFIlPTic=;
        b=IPxPxPClcRSFp/21zdEZQcBzRCPUeCZS34eQ6welZMkwxsovYrDgkp/gIoeb6iHF7o
         CrhKrSWw+SWcZvaTPuruJVL8hsDgYKzrJyjrsYu15O5Ev4vhcnExDwMh5FTsdGsKb/On
         KZqilIOlxn1CTfWfFe33hjzegMJ6EYCRSRilWweFxDkuW6vZRVDDWYZcshaWr+zKCoRs
         6lnTvjUVh7Hfi7quvbalzg7YsPZjkI6FWibyKct8hXHCDgcoSwaDRuXDrI6sMPBymSpJ
         R98lPybzYz7LJaCC1QJ1qZydOyC5z04tn73t5dAKqSvCqdQBXIki/ar9U9nh6vmgpVGc
         nvTw==
X-Forwarded-Encrypted: i=1; AJvYcCUQlrlsCK+JxYqphSg1XIhN69Ak9hcJPnOviaQdoJ8ONNVHBUdHSUpOk86XFlVwctbEf6k3AGQnQ8wmRR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZg7/WV0Xb6lmhvkTQwhFSxcwW97ZqS6FrmZdBPJQ3A/bA5re
	LW8N9JfLUVgL9bRXZku2qc6AdZW7fmJSy9T5gkbEYN10L0P8H1FJoI8MzISuK360PNSrnj11+mp
	21YMFz6a5IdJrgTz/VRDwtRdfUheI5vPJC/7R+ZAK98JuG6sgdCIzaulqDPB4sBOUT2c=
X-Gm-Gg: ASbGnctAbqxryKvUamVQ/SSYgb3ErTGmW4FIhHUYSLxNfZ7mtMbIeyQHwbs6LPak1Nf
	gfc1LVPPv0qeJHTxhnpDZyLfoufLvKBdQBU2XSDWMDZJ4tgb+0JJpWeT+j8GfhKHKXHRh9a95R1
	qcglATdSPzgLK4HF45LfDp5hQjH8f23cJ0vJYLu3h8baBeg0WiYpDdNpXnwdJpbR5moOcvDuGAK
	rpw08wJ9/UdydsATfS7AmiDlqm98BKlEtSoQmWl1XkAyDqC9BfwbfJU7GkjhFT52mt1xXvhyw1F
	WlS+XwXEiFCwTia18kmAwQvAO2pazbgDeK1DHkQXWk8fWxpW1VNTGU/KXU9Z96MqzG/8pY8XXCy
	hapZ21+Dd5ruyx5H+8eZfr4Rg
X-Received: by 2002:a17:90b:3886:b0:311:d28a:73ef with SMTP id 98e67ed59e1d1-31c4ca845famr8018762a91.10.1752281925791;
        Fri, 11 Jul 2025 17:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKh0L/9TQnNmBay88tOhLWbbUb90POPJfrncC4mgSklO12N0KVR5eOs5fxviRSmmoM4Hox/g==
X-Received: by 2002:a17:90b:3886:b0:311:d28a:73ef with SMTP id 98e67ed59e1d1-31c4ca845famr8018725a91.10.1752281925320;
        Fri, 11 Jul 2025 17:58:45 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:44 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:17 -0700
Subject: [PATCH 12/19] drm/msm/dp: Drop ST_MAINLINK_READY hpd_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-12-33cbac823f34@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1230;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=yjltdvgzQFS/rBBYfAe4dvA1j+EvnEUZxQgjt30Wp1o=;
 b=WfFiy+F0KkPjBLpzzbEf5tdoau0ORRRNR4ey0sQZ/xL06nlHnVc1WCtGxOBpGqdwwrs2bFYu6
 FD54qCrYupNCmUD7Gmmd/+FQEoCpVzIuDjYOmuh1aFneX8YdiD/3Rp/
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX+te/dr6AV4SZ
 RjiSY9hpQBz/Xump0313oPYRqPHEVGHldIutns+gTAsnDj6+kMcng1Bz8AKOqFkQN1/Qno2ZmHU
 fY4kKczO1hX+w1qcam1St48zvcW/21q2Z1JPV7+b3GzK4j1+h4PDrEEdkmZq8NJPkgG9vE7vrJA
 mZYxsKKxVxSfxYr3MGaqNGYGKXL2BCNwrjVhLSXZca7OqyciWnRglEuEBSkPLkxCu0si99buCoo
 s8YZWTSzaumrjFsloNkLY5714FhJw/xrzvVntnc5Eb8UqbIGCh+sDiYU/jjSv6ukOMPDZx8TX+i
 YFThduZYJRDv0AKfxlZHM1ez9rngNW2dJpqMyWoNHclbtxMK3V8e/kP4yo4gkx0abSqO52bUOSh
 dreZVuYZxvH3Esw9W/O4N7vUz1V+pfkCOkuxMs3alB1+UFnex9TgeO/Gg35nBm+sFEsH55KD
X-Proofpoint-GUID: krNKQmW_S8Ll_SBLre9OlLIqSEiAUuH9
X-Authority-Analysis: v=2.4 cv=Xuf6OUF9 c=1 sm=1 tr=0 ts=6871b350 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=5QVpEtgF4fCaE371oBMA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: krNKQmW_S8Ll_SBLre9OlLIqSEiAUuH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Drop the now-unused ST_MAINLINK_READY hpd_state.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 17093b78900c..5efc8d4ecf54 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -46,7 +46,6 @@ enum {
 /* event thread connection state */
 enum {
 	ST_DISCONNECTED,
-	ST_MAINLINK_READY,
 	ST_CONNECTED,
 	ST_DISCONNECT_PENDING,
 };
@@ -526,7 +525,6 @@ static int msm_dp_display_handle_port_status_changed(struct msm_dp_display_priva
 		}
 	} else {
 		if (!dp->msm_dp_display.connected) {
-			dp->hpd_state = ST_MAINLINK_READY;
 			rc = msm_dp_display_process_hpd_high(dp);
 			if (rc)
 				dp->hpd_state = ST_DISCONNECTED;
@@ -613,8 +611,6 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 		dp->hpd_state = ST_DISCONNECTED;
 		dp->msm_dp_display.connected = false;
 		pm_runtime_put_sync(&pdev->dev);
-	} else {
-		dp->hpd_state = ST_MAINLINK_READY;
 	}
 
 	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",

-- 
2.50.1


