Return-Path: <linux-kernel+bounces-761010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D02B1F2FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D95F582CA5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B2279791;
	Sat,  9 Aug 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3azN5yR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C557224225
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754726132; cv=none; b=oovOj65+ZqsYdnYmaA+RRTjiz+waCFFFPejYMOfwdCJMRhOwZCcVKaCdZHk37CQLZqiaWvfYAmPjoKlmOQ3b//XmAyclltATTCshV1/FcfagBozI3n5xzYINRpuWtRAqnkxFzCJgivK5hcfOD45WP6DXZWWTb/rJSvHCcY7SAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754726132; c=relaxed/simple;
	bh=MEvMm/z0NSKa6tXqHI5JCOKaEI6VhdKm81fYs4KeO+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQSNlKOuXumYVlKt9GuIIuCH0wr8VOYXwdYibmKsvjzObbA2sFwG4ddCaTqv2d4qkryBNJDz4Y2uWHNZwVYfp/5dMrF9obwIFrnyfwJtrMwYOFKbb1Hk9SVfXlAQgwxE468OephTKAPrn1Gptj7/U/drT9Qd3leoA1kGvO4Ypag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L3azN5yR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793MFqT013513
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Bpy41yTW5kRsP7L2ucrV9Bxz
	+ufAx1/nlB3z+r30uRs=; b=L3azN5yReOvTEHISGrnQ1UntSANurOTQT5AqzaY9
	PQLv+vKNoOlcpr7LTQiuHi2gMPlcGhAGYBYi5siKR6d8IoeWxWBcLA5QTA0XzbDW
	XlhacyWDqFfoRMH9YDI2i2Xeq/UY8KInMwyT/Z8CzT0bAQWBN2quRFpSIQ8u7PRa
	slxPcjxFlSY+EJ+liNs8DQtMertIXlSplXdSNrkFBmiet6O359ajuJoCPDsukY6J
	+J3s+ywvucLrI7+I7qJ7ozOQPTOEdNmSWr9ymB7CfYLxO1kbRnp62WIUqXDTrEsM
	ayjKPZ2AYiD12ZAm8iwFPE649siuQ8W535y/Wz6JJqE93A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fggj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:55:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b06d08d61bso86182351cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754726129; x=1755330929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bpy41yTW5kRsP7L2ucrV9Bxz+ufAx1/nlB3z+r30uRs=;
        b=AhRaBrOXDNcsC3rwBcRzTONPTwCvuSPBrpjI2xweWmbUsX+a7w3e8IHwlYblLvrZ5y
         y0tyPP1V1j/MaOAWfg4MLT9mtfDeSMca5WntPvIC2fP4s+v4GkEckWW9CKYIl/3O4meF
         /sDhYWg4DEO6w3999kfrGfE4R/NKFb4RzzfTuvrKPR66SZvyhwTLEUMte4e5rX7PZKx3
         V20mt8hwnLQaW80OMoSkua18ju3Et4BMs3zv4SgiXbLuxIhGJNodtAyybLJQi8XkWjGG
         wvL3xt5oJAJ18IhFYY/OfWPENtXhJ1lDABgPVhKfw3RuXNTS5RJKdKsTqIlj6FXr4gKi
         k+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWq7h1Y3xsOEeWgx81hhtgGIH0EXl+k8kTOiZlE09e8F+UH448nJD/gtCCB6uNnLxR1QdWnA0pRz2uEMsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbi+AH1jc69pU2yjKFfmxQI3EuCU1Ilk6qgLq7xvkTuglqm+5m
	n6yLrE9xRuPRqn8HA7UvlGT0RWfncZB16/ePBXLgx02A1X98quWWldRK/Y7H/zuvE1lRmc8UBNX
	/GzSJMPJSrFYaQIYk6ni+HXHZJS6mZ1+65UIEPxyZ5ndLv2PkyAN7KL19qnnWswl6wgk=
X-Gm-Gg: ASbGncsKHvpZ3f4xRL9H3mO8MmpJrqREwiLBLbMGEwHH7RmS81ZaLgR0a9gqgUEPgtn
	RLsLILgeUS+wpg/3Ko2K6nZUCAVLh00GtjEzjR7Cl+X/P5Q0J5TajTSMaCAu0p4C2r5zmTwJ9AM
	uB8r86jlmgl302DLisLhqgSZwGxW+Ehcn/rwRBywKDhdninhegeGcNVQaE9XXtXZ1WEoboBhFd6
	lcrymoUE0NKMQ/fNC/DjDsHXe8KJwT2qWRiKlbS9XGAzqq+uFrm3GzmEMApEa5vfO3HqBunc7vK
	1mliEFeOjgrXZyRJtEtQTuMVOBBhXuM3NQFvF1HOu12dWqBEjHl/aqFBVdxs4ZplgjiWYiVJtiB
	EJqkucU7kkZN/daBKNPVhhHXQ9pywr58AqKMW9jsunrl856/laYut
X-Received: by 2002:ac8:7c45:0:b0:4b0:aba1:d716 with SMTP id d75a77b69052e-4b0bfcba7b7mr22351611cf.51.1754726129083;
        Sat, 09 Aug 2025 00:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWh0wH/XYu6MxnL9BGa8/d04wIKlcDPKSSS431MPGMBx8HxPe0UWHgnixqCdznmpzQTN6fsw==
X-Received: by 2002:ac8:7c45:0:b0:4b0:aba1:d716 with SMTP id d75a77b69052e-4b0bfcba7b7mr22351431cf.51.1754726128504;
        Sat, 09 Aug 2025 00:55:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333bab6a92bsm27111fa.45.2025.08.09.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:55:26 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:55:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
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
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 8/8] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
Message-ID: <bxobv4ofetrhnxa7n45fmm3sllqgy37fzgxnyutm3osjqg4yhl@tvdsf6mghuqk>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
 <20250801-wb-drop-encoder-v1-8-824646042f7d@oss.qualcomm.com>
 <3c522dd8-0e56-4ab3-84da-d9193137d4fe@bootlin.com>
 <DM3PPF208195D8D863A5A2E8A151A77A7B3E32FA@DM3PPF208195D8D.namprd11.prod.outlook.com>
 <DM3PPF208195D8D9DF6BA02300F667B1967E32FA@DM3PPF208195D8D.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF208195D8D9DF6BA02300F667B1967E32FA@DM3PPF208195D8D.namprd11.prod.outlook.com>
X-Proofpoint-GUID: Y870MHw-r-ulDminv40hPcr1BkMWEVUp
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6896fef2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=ft45mRQNhs6EWNLFJ_8A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX52jrP2w5ZETm
 MjZctEDUDRdj2sVLzPHU7ehhqEfotOrVod3GS94kXFBYsCe5okyOiOkF8VpSg85fLI5qk2awrGz
 fJbIvrzG7w5cc1c5J242DHv7vSOsEunAua89bd52uutuZLe2OSkSkZXcikZOMPjFE60JxzYOequ
 I51Rx9XmD9rt9X634ABPDcmKZ4YMvp25HXX+gTriXBWSuWKYWsRaECzvQ+7nZt33R+EO+5hV92S
 VO1QttP688HMeFO02yjBBPyuVgRAgTogM+ndxc4y6iV8o5dC5yq8/e5EgoKKMwOougJihxQe90Y
 YoDKt+38Jn1QJZP/h1+HhHkoT2cdgydWwX07aT8yMJTVz/zdfrLUhYH3X5U0hMgsAuMSALPflxs
 FH5F4TJJ
X-Proofpoint-ORIG-GUID: Y870MHw-r-ulDminv40hPcr1BkMWEVUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On Fri, Aug 08, 2025 at 05:24:19AM +0000, Kandpal, Suraj wrote:
> 
> 
> > -----Original Message-----
> > From: Kandpal, Suraj
> > Sent: Friday, August 8, 2025 10:35 AM
[...]
> > Subject: RE: [PATCH 8/8] drm: writeback: rename
> > drm_writeback_connector_init_with_encoder()

Please fix your email setup to not include this splats.

> > 
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > LGTM,
> > Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> 
> One thing I noticed was after the Rename both drm_writeback_connector_init
> And drmm_writeback_connector_init have identical comments both allowing custom encoders
> To be used now is that what we were aiming for with the only difference being the 
> ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup,
>                                        wb_connector);
> call ?

No, there is also a difference in drm_connector_init() vs
drmm_connector_init().


-- 
With best wishes
Dmitry

