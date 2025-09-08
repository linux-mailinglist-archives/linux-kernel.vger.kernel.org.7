Return-Path: <linux-kernel+bounces-806668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A28B49A2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EB23B5BED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EAF2C21D9;
	Mon,  8 Sep 2025 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKbcjy73"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C52C0F69
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360417; cv=none; b=eUXlU9PUI1bml3gG448l/EaQzbOZt8NFpe9F6R+GXQ7/XS0rDDGefnfhm4LROTF5YSMj8UNMxPDMwyJpI2mnH+9CR/+7zvzWHU1bQla4ZNEJJl62Gvsc8emMCt8lRJmJaZZRdvfaS8n8VwplcaepPa0RkF7e4/twh/KSLY/QfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360417; c=relaxed/simple;
	bh=uzPVmN95UYA3m4eO5APKZbdkhOvUBX1OERZwHXJ9QPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLAJ0RDIuZNb4s8BpzztjEZBI7gz19H8QSNT4Ew2TMCfwz3hzCbNblSN6Hhl1MSTxLcn/h7PlEDkXI1HVLmaMfq68ueJU/xlzUqcnyfPwslLKtp9HP3WfXu9d5wuwR4vFe7oOM2WUpGwCV9lBCgCl9nS6zSSZ9ePllnLzWqPeVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cKbcjy73; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588DMK9F004866
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 19:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gt3lMrqxrsh5HFvqVveVdKW5qqiAGEIrNSWV3HoZYpQ=; b=cKbcjy73p7A/LPdP
	+dQiSLTysCusJfzF0jeou7kvxcNAVuTSbWsNmPUmz7KGTjPQawqk7l+5KQTY1+F0
	Sf6AWAhz0vJT5ld5jE9FsCg7+zMK7Yth19A0WBtsTpQvAX3iZIDCHMklvcP5Tqv6
	0nsWnpoF6ES7VeT4o2Oa72ytl6s9I0TvT8+6IpkIr0cvaXiXkW/Rbjm58YHyizYh
	BhyQG5Na11XYYW8tCMdfuU+ux0v3WOu41oaO85mLZN0qjvtNR+73xdgj0ke+8/B4
	cwO1cHJMfC4FWAZxJmQnq259HYMG1FqBqRo1SIQ3C24IhIKII0Dwr0opHHwPeZQG
	CVbdBA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37t8jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 19:40:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24c99f6521dso59843405ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757360413; x=1757965213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt3lMrqxrsh5HFvqVveVdKW5qqiAGEIrNSWV3HoZYpQ=;
        b=sCP+AuT6d1HADTdRH59Xub2u1Z3GWT+egpSt9/MFOLLwqbsJPEd+h0h+XZmkxC0KGm
         RGb3nQui0ieQmdmHC9qBK1czDqwwHG/kn9GkQ9CsQJheP8p+6JNGQmFdLX1ZnMEmEY61
         /ZpuxAGY8i1fzZM5VdXASBn0AnFfMbekUNgPX2JP8yijw1+aU02ZhoR99Se4hSda4sAC
         Cp+GV376Z9DMOPSug1PntNZbBUc8a1YLVv9yCWMB9hUQaI+oCkUEJbuN4f4jKs59FsJ5
         XE6rlm911j3iUJjcyE+N099A6kKngLA2trU7I2vY8k0fKq5BrWYwLBL/ZWFzm/w4mCxX
         rRxg==
X-Forwarded-Encrypted: i=1; AJvYcCWXGKeE1qECoiWdGTDYOwa8snjF+Z2hzTRQMR0fumS/B0mtoGtIEZKCBzX/GYNPZlyueHQ+ZBwhQbt+QLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1epPq0faZ82W2e07h8hYub7ObvtDrFkJkz+SVyPq0k0UJWbh
	640pUXDuP0p5McQ3yXN0+tY4ubIN0tIZ7dklBE1E7cGDZn62xnHbpKk5EJabDAVbrqLRFxnJpnb
	aee/CwhJuWifoaXs+6eNe7gQMJH+UlH/JpoUsI/+myTU430BKADH4XrEk+d2Ebw0RO9M=
X-Gm-Gg: ASbGnctqHhODRTNl226oY27J7rn1I4f7x+AtEAxPY+Fo+xzaiuicml4Lq3OYhdx3IeX
	MjBAXlVbEgsc2RkKHOHX30wCZpDg/CDrbpBWsrYY65JZhdOmEGJbgtFePsgmp2E7Ivsu/3+gC6u
	1ycqqfyTefKBUmSWZRPqyepwgdsCfDrrnoL/zFLrB1gb4ejqLs/Wbd34O9kgR+y5HnpU4MQKBDw
	incOzkcZ8ThgMpbanhngvblyHfEPUng20RFm22sjaoHAWq92GA3HuGHfPge6/5UDOpouo6a1Ogh
	g8ojg5Hi8YGQon0xHhvCT2cQ4kANIbwZ5bNm5Q3bPHOQUHNGXN/36XevS69GIPcj
X-Received: by 2002:a17:903:1a0c:b0:249:3eec:15bf with SMTP id d9443c01a7336-25173118fc0mr96729965ad.33.1757360413551;
        Mon, 08 Sep 2025 12:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjqeusIpL04rY8ls8FwSDva5Pe9CV1TXx4tgUoWYbubTFCMLO7Q0B6W23F5L1gZoCDbDDvPA==
X-Received: by 2002:a17:903:1a0c:b0:249:3eec:15bf with SMTP id d9443c01a7336-25173118fc0mr96729515ad.33.1757360413073;
        Mon, 08 Sep 2025 12:40:13 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea5e8sm104008475ad.104.2025.09.08.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:40:12 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 01:09:36 +0530
Subject: [PATCH v5 1/6] drm/msm/adreno: Add speedbins for A663 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-a663-gpu-support-v5-1-761fa0a876bf@oss.qualcomm.com>
References: <20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com>
In-Reply-To: <20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757360399; l=898;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=uzPVmN95UYA3m4eO5APKZbdkhOvUBX1OERZwHXJ9QPs=;
 b=2DYkGp/UEYjw1rxjpzCBGWBOfgtQjv0WWe52H42SW/jHnoiESuLk5OX/bOjRguHDDaOhH99Ck
 zF+SzknO2X0DkRR7baMmQbI8lbEfJ2BsQEJwiQPu9s0NvgMYJLYWhL3
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: vznPIb9rsUMJXwIgJ1aGQpHbownYuvRD
X-Proofpoint-GUID: vznPIb9rsUMJXwIgJ1aGQpHbownYuvRD
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68bf311e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=92do0itG5Mw8xxZS-WcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX/vYIijYbWniT
 WzshvPkxETRbKg45q31wYeJMlyxRhLuRZhw6veHsK2yE6qHCW37wYkL+a1Z9A41y4w3AsN6etUL
 EQ9cKNjjtUHbJUTqfgoGAXe1UZ5OzTDhq7ICiI4ezNIcudOtx8sNbEVFcU7Q0hBRlMez1yaHCY7
 hucmYhKGM88Y4VhGHwBdyxXZypDIKdoFF0Sy0tsNwbXrz8yhFK1RR61GVcQRud+ut3ssJ9LKBJy
 nkZZZRU4wfD/o0u4tZ6EOsL3EkrwW4Xs+8XJS1Nic3RSkKbuZ89iI9KY3WpRgU7I0FJwAksCuid
 u6EdFAbpyMypZgaqVdbbJHSCLYMvIz80rMOuw5jJQTHiNAi3RNtbNGaly0FgB7KM0kCuHiDGngS
 pHP6DmJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Add speedbin mappings for A663 GPU.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 00e1afd46b81546eec03e22cda9e9a604f6f3b60..2b1c41f6cfeee912ba59f00c1beb4a43f0914796 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1024,6 +1024,11 @@ static const struct adreno_info a6xx_gpus[] = {
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00300200,
 		},
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 169, 0 },
+			{ 113, 1 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x06030500),
 		.family = ADRENO_6XX_GEN4,

-- 
2.50.1


