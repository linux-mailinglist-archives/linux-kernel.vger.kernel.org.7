Return-Path: <linux-kernel+bounces-753496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA92B183B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8911C83764
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1E526CE37;
	Fri,  1 Aug 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mv0TcpOl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5512690D5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058376; cv=none; b=KLQTVkRxWlJng1hSob6c8OMBu2kUsFFdG4J6VHQzwTVl69nVhkmM9L/4JkFX03JTHVeK3FIPwPPdVtC+Eh58np+ZexH8IaG1W3vRDP4rN+/MC1WxkONhBki5oDZlmpQKL1gb986YeamGfbE5upO3jVUexLhNHSlBaRo8hlGfksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058376; c=relaxed/simple;
	bh=7Cf1qA07q7PwBj+lCp1VPG920mv2XnQESOpVI60ySdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxT+o1FFgnTAsETUO/wefnMMbAQx3ucPk9nt3PDFO5597Pa6xxYGpX/H25+G/R+vPl304G9s+7q2JN567qZs7hRIVRS3HAtupcA0JUE9wgWkjK85bS7UBLL3eFFrfPhV3E37YCo6FSeRDpBwk8oG+wAXOup1ZLzhQ/fqjKAh2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mv0TcpOl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718kPEt024758
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 14:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EzvS1jMX5x8+R7F+NrDMwwT/fTPAvaYvo4kcmEWAh8w=; b=Mv0TcpOlW2B6528l
	q1fFdZ1HJ+9on7dRfi5X4/XNaFJsntPIpJbuj0G2513OWO2znFSjc+t6b7uC9o+1
	VgWUXg9WvZZN5zxQjlg0gTcchFScz8cc50Dt+K6fXBUL1DWQe8SaQzTWZTus0YGi
	R1qWeSYfHYHAirPrNlyE6VVp6RxqURJjpo+oKRp/rQI96e9dbpAuX212NleLRLP5
	KXuCWlVaCRpuW7bOfFIIHcqS23A7Ustp4WgBL7ut775P+EUW7F2W4DKjVJkigvXW
	OJMvoAuo1MT8bBv4Kw507RcOT9yjfguAMhUasvajj88LiKLnUvZGs+PziHVdqQCW
	1r5ToA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48887g4jsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 14:26:13 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4fd9730dfa2so13187137.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754058372; x=1754663172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzvS1jMX5x8+R7F+NrDMwwT/fTPAvaYvo4kcmEWAh8w=;
        b=ZbeGz2ZUVIkzapItIfAgNPzyH3WyYOIwsN6gS+E+9QTky6FzYS18KVmgjKeYyAbPkf
         /E6TsWBJI7+JcyMkj7W9YxoW1mGOw5uPKk0PgRTbIKHPUVWZ/ndZ/KhILAvzhFbDbQA8
         W2LCLKJu7Kocq7Cs3vy7mqMo7g5tgcCbq0jUKBd0fvITbdIzWoY9e3yIhHPLh5O1xRHJ
         aFGSn1P76dc9R6FftF6yZsOvM1IpdkF1bPUrbO4SlmwpKtN/7EomqZ54m9wozK77OUCK
         a6MfID+X6LY01qPrq3dxv9nxejDQszEyZaNbixps8GIF3n2qwfVzU7A8NKBElqqs3DwB
         hWug==
X-Forwarded-Encrypted: i=1; AJvYcCXFzx9zEwv5yqQlPYnTqsttVbeqE0DUzEpASVo2XonD8aGP4EKv4SmxUhefxgiaJ/hOgPogZeaJf1UuO6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0FYEmmWpPcI9kK0Iqz4KtKpPdTVzacFVQWqcFniDeEfVk+khQ
	GIOCU2h6aj9oHDkpLve4+CQsO8fuwk64aYAVRUawzoRDh1WE3MX6gLrgH47ITrOUB9+MN+c8IJe
	oLqhsYHMvJBznKCd4cxu8nT7CifeNVa7YyWF6l1wAQvJ7+twYUwf6p9jhCRwYCc1c5bE=
X-Gm-Gg: ASbGncvSv4jeE3wyiBEUkFWAbhocoBax2DhvmLruY94OokGm9j+Ill4HRwby5OlSwdt
	6WaETr6Y6QBx/5oEbu2Lk4t48VIMO7qqP/B9v6GjH+6qgk/zrWvcZC4CqCNrKmjLgXMQsC2zbs2
	PU576++JgWB+3vxUnAkGgI1wvBbbyWzPkK4vJQLO3Bex6dLCMDBS42yNXQJW3eR/KeOivxSXN/m
	55vHmGiLhAWXPolP+j3tz+QvhgHNVHNXez5f4w709bDr9gm9s1K1Z8EddGoerGdTy6hcbGvgGSM
	jVb/HgyaXc4qgRW6w+8u6rGpSQHePLyJO6g2SDa3SD5JxCy+AljtIOFjf5OHXWUri0p+cxoHaao
	3gafTU5iTYMRVdNgJMKW/LcEVfgeUtbZobjUAygyjWHDINX+Qf44LJGYjwqBQui8+fZSpa3qbaM
	OVi1rN5ZVYFTDvqLk/YRGDHg==
X-Received: by 2002:a05:6102:3ca3:b0:4e5:9c06:39d8 with SMTP id ada2fe7eead31-4fbe7eede93mr8246345137.5.1754058371978;
        Fri, 01 Aug 2025 07:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtV8DSsj9RYUgiFZC2c162wgAzqi/wUqPBz85jhmoN0PI6WRYnMuJqyzF2EbQRO88PjZQP5g==
X-Received: by 2002:a05:6102:3ca3:b0:4e5:9c06:39d8 with SMTP id ada2fe7eead31-4fbe7eede93mr8246299137.5.1754058371520;
        Fri, 01 Aug 2025 07:26:11 -0700 (PDT)
Received: from ?IPV6:2001:14bb:11f:12ba:7035:8684:db73:a472? (2001-14bb-11f-12ba-7035-8684-db73-a472.rev.dnainternet.fi. [2001:14bb:11f:12ba:7035:8684:db73:a472])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272f35sm6403761fa.3.2025.08.01.07.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 07:26:10 -0700 (PDT)
Message-ID: <7ea6294d-1958-4586-975b-beb3e5114a4b@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 17:26:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm: writeback: drop excess connector initialization
 functions
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
        Louis Chauvet <louis.chauvet@bootlin.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
 <20250801-wb-drop-encoder-v1-7-824646042f7d@oss.qualcomm.com>
 <b92e89d2-5bd8-4228-872e-6e5ae9b4b054@bootlin.com>
 <DM3PPF208195D8D03E1F9D3E7EB4D07C1D6E326A@DM3PPF208195D8D.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <DM3PPF208195D8D03E1F9D3E7EB4D07C1D6E326A@DM3PPF208195D8D.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vdn3PEp9 c=1 sm=1 tr=0 ts=688cce85 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=CdbOqKgfPjM6tkZZvDYA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: Cs30iFQR829uQ-BdE8cyspvzwGGN87HO
X-Proofpoint-GUID: Cs30iFQR829uQ-BdE8cyspvzwGGN87HO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwOSBTYWx0ZWRfX7KPPG769uC/i
 J4QXhJmo1ESVN65tnfPWTO3xx7DXnRJ0GBR+XHROkBwKLxSOEyWp0WhfIWkIOE/2na9wnbB0Qau
 k7G/3nf/edfwjHapvL6u+5IWo5SClhupaTkKm96zlxq+iz38Gk7G9IwSnTnNdlfVjjR7pOjm2AM
 vPAFxQl8QVJ8R1CUEH1LB7Ei1wUBEM1oC5L4Q93FMCVGniLTZocpQ15fOVIKU9+NN5hulgi7hYN
 WDn/Bj/LBzhiZg76cs/DygR6q0FRjm1x7+Cm38DxrR8JKn7xHS9zQ1oI1JUfAf1B26oPDbgklNX
 TN80VGPmbFJ20J+ihKruYQjxtjLcvuDS38zpctoZMMqGwO4VaP67Ij6VNLMAF0Zf0eneeYLxQrS
 nI2S8D3pUxJ8sAIZKxEtcJH6Y6oXXxmU7aesP81D9lzStf4oY6onQnPhcx/N/Gtef3yVrDme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010109

On 01/08/2025 17:22, Kandpal, Suraj wrote:
>> Subject: Re: [PATCH 7/8] drm: writeback: drop excess connector initialization
>> functions
> 
> This should be drm/writeback

No:

$ git log --oneline --no-merges next/master 
drivers/gpu/drm/drm_writeback.c
fb721b2c35b1 drm: writeback: Fix drm_writeback_connector_cleanup signature
09cba36cc840 drm: Include <linux/export.h>
ddd147d91d50 drm: writeback: Fix kernel doc name
ff3881cc6a58 drm: writeback: Fix use after free in 
drm_writeback_connector_cleanup()
1914ba2b91ea drm: writeback: Create drmm variants for 
drm_writeback_connector initialization
2f3f4a73631b drm: writeback: Add missing cleanup in case of 
initialization failure
135d8fc7af44 drm: writeback: Create an helper for 
drm_writeback_connector initialization
02c50fa60ca5 drm/writeback: remove pointless enable_signaling implementation
720cf96d8fec drm: Drop drm_framebuffer.h from drm_crtc.h
7933aecffa28 drm: introduce drm_writeback_connector_init_with_encoder() API
57b8280a0a41 drm: allow passing possible_crtcs to 
drm_writeback_connector_init()
38d6fd406aaa drm/writeback: don't set fence->ops to default
b1066a123538 drm: Clear the fence pointer when writeback job signaled
0500c04ea14a drm: drop use of drmP.h in drm/*
9d2230dc1351 drm: writeback: Add job prepare and cleanup operations
e482ae9b5fdc drm: writeback: Fix leak of writeback job
97eb9eaeb95b drm: writeback: Cleanup job ownership handling when queuing job
71a5cb3eb758 drm: writeback: Fix doc that says connector should be 
disconnected
cde4c44d8769 drm: drop _mode_ from drm_mode_connector_attach_encoder
73915b2b1f25 drm/writeback: Fix the "overview" section of the doc
b13cc8dd5884 drm: writeback: Add out-fences for writeback connectors
935774cd71fe drm: Add writeback connector type



-- 
With best wishes
Dmitry

