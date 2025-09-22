Return-Path: <linux-kernel+bounces-827981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA13B93998
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2337AFD2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638531B105;
	Mon, 22 Sep 2025 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1FLgZPW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420531A57C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584050; cv=none; b=Zlmn8yNVj9aCaBVFsMofvKgYSJHKI5gE4wwbaZ9n8FsvtbrgtutXF+o5vtoaIqe4NuuwTXtq8XsazXkUw7A565+YkyrZq2xbX/CAXAGFmeo2ZgpgqPUF1eewAEWh+BOOfYtFeRoEO9sjvbhophemfhcYJMurtaoj2gqPlIQH+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584050; c=relaxed/simple;
	bh=NO6OCdz9v3Tc/Ktiqg3Wh+gypiA56gt1Z/XEzJOevmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rkg419RFWBtK5NIHsgQBml7VlittJIhl6SmrUpK29ZtA1gSooKVCSQiHO/Ic59Hq2xKAkm8yrjvRKV7qzi+J3r+YLnRhKjhwVunHGSXopuBjauszQy/8RMIh83Ltt5NE/yqFqJnSwPNR2ywvNpptGZalFwEtYrynSAJtadxYBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1FLgZPW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGqASG017220
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m6ztTUa1Nhe291Dt3QY6n7
	qVtvRxyg0bpRvNd5kITc0=; b=E1FLgZPWQQqKCbHet7mgc23S2YPAxqBgIGCBo7
	F8/N7a7T7hM5JZCCHceCUCUCn1aiKp4j88BwNktkH4QSRgSImNJVq/Lh1btO32yi
	hne1s3ewJn1fmmf2lX7j9W2AoZcdKrwtw5WIv2bK8SLfK8KdR4FVajZ/BEI7xyW3
	liePs0S7WY/McEcJMSBlnh1nJTgGiHoX8dxGuKORiybg85TLFj1zuuvCBl+v4i7F
	VAKnuVvN+IZeQjBT7FnegKWgvXK9z715oG+2zU5YD77A8Wt2hfEV9okr1Tb1WGTc
	OPiyKP+ISTYladpR0urdkVEQhZB1hXgWOtpgeBSFcRVlvfoA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fedv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:34:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2681623f927so48393585ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584046; x=1759188846;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6ztTUa1Nhe291Dt3QY6n7qVtvRxyg0bpRvNd5kITc0=;
        b=Rij1n5w1i6M1rRd2CuZPySHYPB2a68JnO6gF4J0hqlFPNnakYXGrvRMJ33JQ/WLOpo
         HvX3DQqTzL0gggVXbPqHNyTNLb6DL7dWDqFenzb6wy5jI6XYqCHELtPdHstvfOTVrQ9f
         uC+3iaZfYP+5l+h/Lc9iYBhSh3kTE+TANqFYuFwOJIr9oIOd6UVpkJX7Ve/RNn28v3Si
         FD1AkF8VZl6iS91uaAiO96/48Z7xamq8qWcjR+9cs9O5xwfTKBjARFgD1h7o8YzuV8nL
         iCFzb9fPLKp4ztjF9hc5CqbtQfrxlpKsManjy2pDe2hdeB1Im1yTrPPR8opxRhn1QIa2
         KKoA==
X-Forwarded-Encrypted: i=1; AJvYcCV2qEqhYs7V+vNynBJtCbS+3G9Q6TEiEIJcVHv2wLKxItrd+/aXLFo25D8uhTZafrwiUuqew5azTziV1NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDJl+npovEUWxcAzs2kjrwPTpgc0GOXve0uRYc275n+4/o6Kt
	8X520YQwZ46rynoTKKAvU6tge3SFj4LnI11OFwfnxpP1lhUgC7HD9RT4oxIE4TtpK9Ky9F3jz2C
	wE8IAPeFV654hcW0xCW8jChRjOXYdlHDypiqj3j1Xo0pHa8GzwATE49cub8EpkETnQeA=
X-Gm-Gg: ASbGncsIKGAyG9t4h9tojYEx/BbWGO0bEDVlm/8L8hUqjVatuXBWjKbJqT7Be9WLIBY
	hi7M3coWcuOqHecdVl8fdSKLWzQ4QONe/Q0uqD8fKwPL5LdYM2Y7JvfnuIJj3CkfjLLuzhOhHfL
	uaBArqmSpqLEmN1lkiSkg0/KTaZL8NS46GPm+LXpqLEwkSE+LLrBOQv9if8F+dpI1IIHAQS9SWM
	/ifZT+TDxGVuOOWX/3R3Wr7FypByoY/74dnTTj7YpIb+qOcb5Zm37eYToKFgQdXwMBCqyK799mV
	WMvxbkhlQ8YisXRNj3qQdWk0Qlzxt0YWyM4Hy8uCjzx2/ZNzCPYuiBtTav6h1POO2mHU+DuEFho
	8cIR3b9TmdNWcthYmmdzRlbEW
X-Received: by 2002:a17:902:d58f:b0:278:704:d6d0 with SMTP id d9443c01a7336-27cc41d1be3mr6027395ad.19.1758584045848;
        Mon, 22 Sep 2025 16:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSbin/PIvKVcn/OXuhCk/5eExOX31UGaUEM1vyKmkyPKW8/DOkrYdu+4YvFnTtODfyJdb6Qw==
X-Received: by 2002:a17:902:d58f:b0:278:704:d6d0 with SMTP id d9443c01a7336-27cc41d1be3mr6027095ad.19.1758584045367;
        Mon, 22 Sep 2025 16:34:05 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698019821dsm143706275ad.64.2025.09.22.16.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:34:05 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 16:32:39 -0700
Subject: [PATCH] drm/msm/dpu: Don't adjust mode clock if 3d merge is
 supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-modeclk-fix-v1-1-a9b8faec74f8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJbc0WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMj3dz8lNTknGzdtMwK3UQLcwNjc9MUS0szAyWgjoKiVKAw2LTo2Np
 aADo2laBdAAAA
X-Change-ID: 20250922-modeclk-fix-a870375d9960
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758584044; l=1310;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=NO6OCdz9v3Tc/Ktiqg3Wh+gypiA56gt1Z/XEzJOevmM=;
 b=FqqpcegGZLXcfSidwXQSnQCKvesciEyokTB8ipKxsrgPjY51xArxNhIg82ImuTocCxHkuuPGw
 VJFOYqL/PstDdIHfGPlZ+Z8RwhNoeEAsIRRkKI74iPOGYZqxpsIOTuW
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-ORIG-GUID: wsY4gbRpHeLi-mbd62bIVL4e0ZeQWaqw
X-Proofpoint-GUID: wsY4gbRpHeLi-mbd62bIVL4e0ZeQWaqw
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d1dcee cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=NBkOncM4Jvnk2V6n248A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX/dPPCcprrDfY
 CqeberRTVnV1984r7gxjrJI+XfjczX2BGYt7nwmpJRpJCWC1LDZzK/fSawDW6MhMmMMx+WduY0H
 kXvbBTz8MOWk1i6Wiu8PVvH3BFYjwmg1jvoT8r57Qv5U052kxrPhR6msLp1aT2aiaso86WVG/M4
 XXABFmz1IQj04FueJvogAYwniXcEM+BWOpShhvMdK4gUC8T0dbqIuxJs2L6qNZU5zYrwK1OTHbN
 N310yMSysILgGApO1oEJU+Lmjg0qO56A2s7KlGJ0sb9U/cxf3+DU8THF/9X0Rwa1mQHeW3asNag
 EDMmp9/4Fw9Z+adcNnwqZiPhiHC/HKwAd5OaI/iWJpe6EDXKZeLtVZS7GBX16FPNUbgiEoDtxDv
 HkhVpmIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

Since 3D merge allows for higher mode clocks to be supported across
multiple layer mixers, filter modes based on adjusted mode clocks
only if 3D merge isn't supported.

Reported-by: Abel Vesa <abel.vesa@linaro.org>
Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 4b970a59deaf..5ac51863a189 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1549,7 +1549,8 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
 	 * The given mode, adjusted for the perf clock factor, should not exceed
 	 * the max core clock rate
 	 */
-	if (dpu_kms->perf.max_core_clk_rate < adjusted_mode_clk * 1000)
+	if (!dpu_kms->catalog->caps->has_3d_merge &&
+	    dpu_kms->perf.max_core_clk_rate < adjusted_mode_clk * 1000)
 		return MODE_CLOCK_HIGH;
 
 	/*

---
base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
change-id: 20250922-modeclk-fix-a870375d9960

Best regards,
--  
Jessica Zhang <jessica.zhang@oss.qualcomm.com>


