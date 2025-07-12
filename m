Return-Path: <linux-kernel+bounces-728464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90306B028A2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9941580C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B1C183CB0;
	Sat, 12 Jul 2025 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N0HBNJvj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56A814A60F
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281914; cv=none; b=H4E/sG6ylaD3L6hJRaQZP0AH4XU3PostnjlSdy3Nw3JqX7fVscdHUe9uPrGy2kaQyPnXnVeVKf7BhdeYhGlxZfKwJ+6BkLLsQyhIwbsa28I0psWXdifhU3mt6Py24A21xxTu5v8R2n6XVXOoLy6AMyRb6IbdKsd8U1gIezTUqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281914; c=relaxed/simple;
	bh=J92vKQQU00spCPJVU/OigM0xG5dEIU7VHwUl2A4FDFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTHwKmWbHPZ1PHBVuq05w5GfZAsXO2TdxNk0HHIeYtuxKuZo5ni7+0okdwU1jpO4CHtLDvH+Fi4FI0ugBC8jXll4sYbpDyNvkqlUGgOuDwKTkMgO/847KCrsJxk1qK+IJBy5Pm5FU4BZDk16IG3f5w18WoBl7dguHs3RFHpj8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N0HBNJvj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C0RM3T016818
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q11UOiARa3HDFn+Un9pQ8/hWjntRP+9VgAjNKaCCqQQ=; b=N0HBNJvjUhyeB+w1
	iQHXeMn3jbBYaG6mXuGwLuGW2SRCDWcFQi0cHZBYfsjMwJ8uoNT5bmoRLvjxrWPW
	uwkYFvE1tG6ZJl5bn1tiT3nhCMKIYUqlWhBNnyISAalmmkwRIAdRVmGz1k6OhZGw
	MCNMzTDEjz3M4FgosXnBhnwGc3STdf/BFu2VqmZxFGLHLh+qu74587JnonKBIci+
	3jWJvdMZD6Cc04Q8sd+Be6sjKfd9jHLYl2pGkPbCHh+LMJdvAXmBJx015vOzqKUK
	OBHcTjX5+gH/nn6rEyCSU1vPcHqAT8MkKJzeVQwhY1UksK/3CtCBf9q4RGgUi1Yh
	u082yw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smapa8fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2355651d204so26289275ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281910; x=1752886710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q11UOiARa3HDFn+Un9pQ8/hWjntRP+9VgAjNKaCCqQQ=;
        b=vIwXLnmQOuurHUDdc8DQsKR8XDxgYYMmbgQuS6Epa/ZItzpuddQn522c8a+EXyA+BY
         6xl/N4I3pXwbB/h4y7K2jo46zYcpXvSuwp7rKmCkk3guCa6/2u1+g9yQv3e66mRCugcI
         lEr7pqlde3P3BR32DPH1UlivXb0mFsXu2B8pxsYOgTOwX6yCmoXboqSQDiwdq78Md/5w
         zneZ4cHF0HrftCc65XjzKR2yUlPWHK3JxLh1RiY1L6XlpaBjKOcvG5LSoEzNw/ARiTdl
         3QuaRkySjs5jnkIRNxCMrgMbaI6EAVwLmvEhprYqny+pPVPs8C64uJfKt34+Vw8PD6vv
         QquQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpU0LgO/3gvlrzz+G5noJSkupI/57OaCuHxj+kPQgIG98lUndGuapuQFffYa/LGsQbFqJApJ+DW6b0qSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyz/lTiPrZdUIxX2puZA2fmdjsP4MzRmEJq2uBHrOHmXMfKS5
	B/ohpo79jA6tdVjubUp9LsdFvX3STdb4/KFc3rAZ0eebj45yd0vGmE2XyuJkylMzk6uD6I2OjEC
	+A5X6332PjpxhvO3VCSWz0Oo3Z4KHVW8KsKB9VOq4Ugu9dOd1D7E+TSVzsCN6HEJ3OdQ=
X-Gm-Gg: ASbGncsBRmsuMnW+MXhz0xi3eimICd5Ed0iGjuBwSKVzkU1cvq7mOgHDnk+fgOxmM+F
	eGjqDrq5GJzdFk6o8qtr8klh4vc2utKG+p7VWOVQ64D3tpFcb7E1FySmcAdofcuv4GZI5K5u0pO
	omBJ/HELVLNopx65kEa9IGYdD7aF3EEfcZ8up7U+JSvPNgkRbRXLNRecHVrcxQSG5+62eBFd14g
	JFaMWJK253BzcGIBBgNo2HYanAJU6HnX8lEdlSblAmq+3X4Z8SLyQhjYpRDIpXxBKx8Fu+2i43m
	i/D5PMrxiPXGJTztRcC3Zh5YARGjG8QMXMbrp/XbnkkefhcfYKg8QEq4XHEoN738QF0BITgNlOR
	pJoH9y+fV2gT8guJjRs0afHl+
X-Received: by 2002:a17:903:4291:b0:236:6f5f:caaf with SMTP id d9443c01a7336-23dede396bbmr57111545ad.15.1752281910323;
        Fri, 11 Jul 2025 17:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEkslTssGGwVbA+ubFmEhnufVz2ZPDP3EbIVkI8173qZsyR2UUDWX8SezkuEsaNcgc484+2A==
X-Received: by 2002:a17:903:4291:b0:236:6f5f:caaf with SMTP id d9443c01a7336-23dede396bbmr57111375ad.15.1752281909914;
        Fri, 11 Jul 2025 17:58:29 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:29 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:07 -0700
Subject: [PATCH 02/19] drm/msm/dp: remove redundant checks related to
 ST_DISPLAY_OFF in plug/irq_ipd handlers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-2-33cbac823f34@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=2318;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=lmjyDwDYFnlKQuJK43yWUhZMEmCS6vExO8kuvCtTUMI=;
 b=ZwqK2sAaMuPEEntJ5YT/sWXzkcT1wgWrynvhWeXOd8zBND2GunLXDSSk9GsE675dXMDZJs5qd
 +bKpFlE8FfmDETAg/krNMaady/F3h5fWvRM0d6dXwYiaKK8lPci61mL
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=6871b337 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=PbHRmTaTmGSOozFvvjEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rHB6muTGWkhYj2EKKr2Stv2bKlFV_e4s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX8xrrMNfIxr3a
 ZcUqx0XpiYT8Z961HVESTiH5Ovn1ALufQ1kmFU4wPg/rf5R4gWmUCgL1cQQYwP9NZAh/xFGG/50
 92cHyv22ZPqG2P/2FsdiSkGPIjBBW7wakasK8Jh3oF1f7I8J1Ekz3SZDzXjQ9//dNHN4LUocP4V
 stKyYih2QOtvRsExFT0pS09Q4db171VPhcM6JmVhtYrIidKcaEfL5d+hmxMPWDyjovTKWbZuIEb
 qr7AIjSNqOPWu+kLTrqBtQLqg9568860viR9/HK5gVpkhfNpu/vaBK8XfGOroxXFu2qcqUEFprj
 goBlAkOwxptapwbVlA/ModHORV6QfcCJ1HfkqJSg8xdlZfD/EQiBw46PSo4JQG51Y+I5Laso8H4
 heeuyUF/defIRJKMa8u49QhZMcc9yAwKKHxNaGBJRi+Zwig5j3O8k4E2V2F+XFp9S9j6o9wV
X-Proofpoint-GUID: rHB6muTGWkhYj2EKKr2Stv2bKlFV_e4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507120005

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

In commit 8ede2ecc3e5ee ("drm/msm/dp: Add DP compliance tests on Snapdragon
Chipsets"), checks were introduced to avoid handling any plug or irq hpd
events in ST_DISPLAY_OFF state.

Even if we do get hpd events, after the bridge was disabled,
it should get handled. Moreover, its unclear under what circumstances
these events will fire because ST_DISPLAY_OFF means that the link was
still connected but only the bridge was disabled. If the link was
untouched, then interrupts shouldn't fire.

Even in the case of the DP compliance equipment, it should be raising these
interrupts during the start of the test which is usually accompanied with
either a HPD pulse or a IRQ HPD but after the bridge is disabled it should
be fine to handle these anyway. In the absence of a better reason to keep
these checks, drop these and if any other issues do arise, it should be
handled in a different way.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
Note: Taken from https://patchwork.freedesktop.org/series/142010/
---
 drivers/gpu/drm/msm/dp/dp_display.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6945df782f7b..1072b5fc00ae 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -595,11 +595,6 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
 			dp->msm_dp_display.connector_type, state);
 
-	if (state == ST_DISPLAY_OFF) {
-		mutex_unlock(&dp->event_mutex);
-		return 0;
-	}
-
 	if (state == ST_MAINLINK_READY || state == ST_CONNECTED) {
 		mutex_unlock(&dp->event_mutex);
 		return 0;
@@ -728,11 +723,6 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
 			dp->msm_dp_display.connector_type, state);
 
-	if (state == ST_DISPLAY_OFF) {
-		mutex_unlock(&dp->event_mutex);
-		return 0;
-	}
-
 	if (state == ST_MAINLINK_READY || state == ST_DISCONNECT_PENDING) {
 		/* wait until ST_CONNECTED */
 		msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 1); /* delay = 1 */

-- 
2.50.1


