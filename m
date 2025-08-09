Return-Path: <linux-kernel+bounces-760889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D8B1F1A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D38F1AA7B16
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31624729A;
	Sat,  9 Aug 2025 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npBGLZGl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FA246BAA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699751; cv=none; b=Vvo/aO4ZZdtWV0RTdAG2f4P+dh5FLSjIGx6dzeK1ruvxtKVhu1i4DmH+FlErCqNXAXu29buDOp1tG+kvBMrjGP9WDve7eYIBltI9KPE1d/SgerlLIE6b4+h6bGUwwWD5QDZwfsOUpsRMJeZeBR1I0aBAq/wwVlcqPdSo5AQqbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699751; c=relaxed/simple;
	bh=ggjVjCaXkx6Mamyc1EgH8Z1xDLiJkr291pJTB5zorsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIhXgfv88qPeyqK2eWVBGUGlBoxaJjKGz7WUuJwWxg7fdOUECfBXBY2xRLiaLoVqSRNF55/BY54zoQQHT10kcuy8YMmW6byjDv0PKjRhUeT4B3Bm//tEjKNODA+e7R67o4MIH/Orukmv0un6aeRj/jlzPj1q6VKjH5WEykaF+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npBGLZGl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578Ewkh9011668
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3eZyTM1lKAlxwHu0KgfbpHrzCleYc0+uy6KH19detY8=; b=npBGLZGlyc08LaU9
	kco4hlyvKU2rGweNbK6e3aJwO4lcjBj+EJeHiLv+73LNdhlCU6JX/eG4np2vuZGv
	+N1c2UGqOJFE8HnKbNzQ65/jM11QgmHEmx3zaH41+Y1Mq3F6so2XKaW2HQ/QeEfX
	ZHJ5R9GDF3elvWzYIU5eBP56zcnqXdUtpjYEjjJ+QI8uTqrZes3Wp8/uefdFgNJr
	+1YL567h9yr+WnujIu9aaX+kJ3VQQvAFyql3HzgJ5/qd8EL7/VYfA9uVx9WfyC3o
	kXSS0c6L2Fe516WBdcJwDLkZm8zFBF00MwHWFkPWHKiC7ykul2CFwJFHMgdqpUol
	qkUX4A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cpvy69dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23fd8c99dbfso22177945ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699748; x=1755304548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eZyTM1lKAlxwHu0KgfbpHrzCleYc0+uy6KH19detY8=;
        b=emK63tDsKoLm8nJenvPHgabsEPkENXsC3RxCvNg+PXwatenPI/3I+G38jqujwWbWeH
         Tb8fh7zgiLY3Zd34xOYzCeOcVKw+Hsj5sA7p+YqtQxziaZkh6CN/PlQ9X/UAYR36iLV1
         k5QZF13nWN7ICy8+AsfnQT8xMAFvEsMxPx0sdY4S5eXoe2EpQOs4GsaDXAVKwFxFmlEO
         Yfgk6iTKB5Nfha16fNsAJIgg5vDonesjaslTaNUFJo7UT/dg+4Q9c4reNibbt7w/Nsqy
         tZzzSEE4c/wB2Okp3odCcy/f5rQhfWO9N4nUuvuFZXcjpdaheI7/PE3EuXNJ0dfLgg0W
         N7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8g2+djT/mNrm14jD4IlH+zf/jjDE/IElhIjsI7PEYfKshdyogjrH89vP+sMOOY5wQg3KN+Ar2umFOltw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNAeCHR/vtjC5wlYzePLH3ogGZv/36Kg+eiwnCWOpkJ9gTIeG
	TYPy3Q/PnF5F/qx7Q4cCsZ8Us+3I1S/GCbLrYvT+io3mztguMmkJG5r5S5aOPuSlZLWDWcfH9oX
	sNXeyIm90nWvUQF+Iug/s/GfqFbbL7ySgizYLUCLFf6dvVkRl6Ajw0NPMtZKKnsLKXMo=
X-Gm-Gg: ASbGncu0cFUYRCmaUtbupEmUuM5QYQDR1x3rdr3T9sDXvwZjVPJ256OjjOZhblUO2Ku
	SDDnbqj2VFQLHSo549xPsgyyEvRklLxOgZDRcJ+/wuMHx535sHGzoptBaZIql2UFGWjEvRIirsL
	EsfWPM90PSx/o8C94s2Iu5gnw7hM/oxCMBFSrx64Ssdbt5Gg4XUwichoTRnN0QuMB7471Y97eOJ
	C5R1m/8WkgLiJg+93I0HHiZZFjr/DWIengA8tvPfMSjGOhIBDwGarNOjuwpnxTsppiFo8eu+d1/
	K1uD6OaUAYpuSmwQbjV2/YmhtILNaFsVZZZVV49fEDDRnwT0Wn7hLExyVFIFWOh/UkOcI3ecCEl
	AG9seLTsQQTffps/pS+K/8Y32
X-Received: by 2002:a17:902:e786:b0:23f:f96d:7581 with SMTP id d9443c01a7336-242c2039e50mr64543035ad.20.1754699748047;
        Fri, 08 Aug 2025 17:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcMrJNf4hYbUM6Mca4QfD0ZQhsL/38byXKglBB4WfSR1lbVjH3mDxc+Vqs9SUlmhl07AwLRQ==
X-Received: by 2002:a17:902:e786:b0:23f:f96d:7581 with SMTP id d9443c01a7336-242c2039e50mr64542765ad.20.1754699747607;
        Fri, 08 Aug 2025 17:35:47 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm219865355ad.39.2025.08.08.17.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 17:35:47 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 08 Aug 2025 17:35:21 -0700
Subject: [PATCH v2 09/12] drm/msm/dp: remove redundant checks related to
 ST_DISPLAY_OFF in plug handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-hpd-refactor-v2-9-7f4e1e741aa3@oss.qualcomm.com>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
In-Reply-To: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754699734; l=1745;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=L/K5K5k1xBQ/wx+huy+cI13UFEAuqZN8YUVxLinE3Yk=;
 b=bDAongJDXX6a6O+352pvsIP13wU3uFnz7DQHr8iAWYbGG6fO0Ff2FBG7AzARKFuAkqFwsvxpz
 WAmus7KaTCSAThVoDDaKKbokeJY6sI8CUyT3NiIbYW7Lmqljm/T3ElI
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=TJpFS0la c=1 sm=1 tr=0 ts=689697e4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=3iXaqZgdguojTDSw8eMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5IBZJnDFw_WaD6iEP9vByfkpFKcAGyyg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NiBTYWx0ZWRfXyrkl1XkoH3t8
 29FfWVXdpuSbIS880yW3FQtblESLCj8MOIzg5cmMeJwKxV9sq0/Js+Nufn56YUYUa/FR9N6mg09
 6/G1/lP4sj05qBlESrNOVyVK/c88BWMpPl0NxoMXl+t7k00SX+6oTCzOeN/qqmHKAq02pLwndxp
 0YMG51gJ6IqRsrvyBFngasFLRU7oceKdywkDXnq3z0CryqnVi+t+/FruvgYAPAjgHzDMXaSRQ39
 OL1KduvVjK17zV30LffMz076pGwlpTCIEUdmYJA4Ke4qUkxSkokXBY/9wfWs4/mHWVQkfs5+tlp
 /2Dq6XkrpLx9csqrONUZkeyJrUEn/mhqPXSUsL9fXYEzUwlE9Q9MXerXx/LgLNdcCdQ5wLcMLhG
 /rna1ASp
X-Proofpoint-ORIG-GUID: 5IBZJnDFw_WaD6iEP9vByfkpFKcAGyyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070046

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

In commit 8ede2ecc3e5ee ("drm/msm/dp: Add DP compliance tests on Snapdragon
Chipsets"), checks were introduced to avoid handling any plug event in
ST_DISPLAY_OFF state.

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
 drivers/gpu/drm/msm/dp/dp_display.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index eabd6e6981fb..dd3fdeaacc91 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -495,9 +495,6 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
 			dp->msm_dp_display.connector_type, state);
 
-	if (state == ST_DISPLAY_OFF)
-		return 0;
-
 	if (state == ST_MAINLINK_READY || state == ST_CONNECTED)
 		return 0;
 

-- 
2.50.1


