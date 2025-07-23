Return-Path: <linux-kernel+bounces-742584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA06B0F406
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F5E540D30
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDA2E7196;
	Wed, 23 Jul 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wp02TVxD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6F2E54A1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277477; cv=none; b=dORrWIeSgfNKY6tjIX9TaaF++T9CnE78cc1qDuxUolQHhGtV0dCklfoDCzVFRu+bv/T9TMY7VNN6yydfabnDMv+kkIwvO4tvOIafSxO9oCgOJVRe+lnnXeybmKt0/X1vhaYhG3p9QeUTT9ErjybZb9JPCnXDZxRPJ5/HxfriskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277477; c=relaxed/simple;
	bh=LbSeL39/+hVsRpMfZuJxRHEVbp5K7gof7zPnWzdBfWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m8YR0tqr0wOxl6kTK6IJuwbm1yds9FBFtR/gcH11tW2ewj8nfu+CPaFa47BZ076n6ca33yCh4Cawu0FfqIQNLueO7f5W/VRFfi7U4lkgVuKjRRiSSY+fajccNAG/pKH/zeUhADeaKnw9XqRpIod1Ha4n8uCAcSc7UWNa/qh+PYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wp02TVxD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9ImZI020118
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9SbDNK0Re1Bd83KQmagFa7zcRS3CLi3VXkytT1Mw+wg=; b=Wp02TVxDZb70ynk+
	wrpmaL7X+oqcMiuPP/sZnVEgUIfaLA+YlIe652yCTMYLcHzG7b2HFQw7H8G3jXUg
	2N1eViOaDDwZcKz0o3C6FWWZ5/bnXvthv7olQlAxutu9zKSoXGClsfZ5f/tTf6VO
	qokv8SwKhLO+NmF5TU7L/0iwV2u5k2s4l4hpLW2VwUJKcR292BzAOLiUEmx0DXw6
	98gIg3P37slieTwvIHu5M5dSqJVwzbd/h0bvpY5TK2lK4ewSXqRlvx3s1XdBXkp1
	2E5I4c9fR370nO6mQNXmsP3l53OOjAWx6gpNt/llTYM/wOz8RWewdA400+4g42ya
	Z9D+3w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3er3ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:31:15 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4e81805effeso526641137.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277474; x=1753882274;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SbDNK0Re1Bd83KQmagFa7zcRS3CLi3VXkytT1Mw+wg=;
        b=OxO4WElg9+8wNOfBEpBGM+rvnBV0mpd6k8oJDlevwWZNpO1FAx5RU7+JF7MEbBdnaR
         S8OJc1DFHMb+469v1cUfJRrXzunIWzPZDv+zi5Bn+wPtLOPWQMWYNGs3nn9JYZXxkZ1t
         NBgsqof824eKW59E+mSdPBNkidwP/JAW0nmcmK+lNxHp9K6QPO0+17HjTvBPlH3lkXgs
         mmfCDurEZ0p1gXmelanho/4DTZZnOZbPFn1CtQySXuZJFpXRN6+cxgbfdIW1QgywdCgz
         8U0tCCMMdpsYyaSbaaUKd1Mxef6D0PX+TaRwMAM+KPSqFzeQJ0DZM+rZHPbDDKJPhOGm
         hALw==
X-Forwarded-Encrypted: i=1; AJvYcCUz6gXN1Kuz9HiuRKbpqmUfP2RfQpA3r9BaQg9IATeM3ZkOnkT44aGsM/gP0+4YOyo53Tb3VULOkmkIPbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwpX5pmAxYIxQRtM8993ODeI87xEjXLtMixqsIkV1CgKhiElz
	FvAPWYf0R5aEehkga5zf4BPMVBYTqojhXaaDhBMZ0ecd8eO2mJVOM5j22sa9/ZO7ohx2/Pf8rLB
	YlRbxepnmBjIhxKGaHAkg1SpSvCZIF99ywvgArWzGE228Ebv2b7xCcydnjSaOiVuenck=
X-Gm-Gg: ASbGnct6P+n+a7PNj40fRTf0BmE/olGwVzmCOUu3XCtu6n9mF8HG/4S43Ls4+QZM9j4
	DT1EJEAU6yrqP2Y80Wd2EcSt5FeEhs3uHUpUDIxMCVNPk6NDypzL/q+55vRD2JnPjCKIi5Bb9yT
	0/OYaIyju3Fb2l2Agak5YAFvYe5KYtE3J+QXsdFdNQKicfMgmVPhf/GRSVa/vzTISxJVPINpDqI
	VR5gExBxyS8Q1MBwFhYYqTVpmiDb9bQnAMyWla71JhyyGTs5ZmQGDY4DDZ6CWJ0EHHkzkpqlPC5
	G5hCbjDmd2a9q2kWesDLiThC2cqhEUptHSXJ9P5CmcxV8TCP81wDLcvbs+r2wIJJ8T84Cyzt7Jc
	Zi6wNiK9JjnuLmJr1xpr/9HPaM14EvqS+os9mJd1SvN0UjIRR3eqY
X-Received: by 2002:a05:6102:4247:b0:4e5:a394:16cb with SMTP id ada2fe7eead31-4fa1504c022mr1124319137.7.1753277473636;
        Wed, 23 Jul 2025 06:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHgHJ09XAo/u0keorRW6Ld0UmatwQDlzD5XxfzVALH27XPrtvZ5AfHxDILlDuD3WL99C+7vg==
X-Received: by 2002:a05:6102:4247:b0:4e5:a394:16cb with SMTP id ada2fe7eead31-4fa1504c022mr1124229137.7.1753277473147;
        Wed, 23 Jul 2025 06:31:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a4da8a6f9sm454935e87.9.2025.07.23.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:31:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
In-Reply-To: <20250719-fix-cec-bridges-v1-1-a60b1333c87d@oss.qualcomm.com>
References: <20250719-fix-cec-bridges-v1-1-a60b1333c87d@oss.qualcomm.com>
Subject: Re: [PATCH] drm/display: bridge-connector: correct CEC bridge
 pointers in drm_bridge_connector_init
Message-Id: <175327747217.3825714.6617340923378529554.b4-ty@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 16:31:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: oO5w13BKPdDYLF7abGzuqEHzAVXf7F7x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNiBTYWx0ZWRfX0DtPtEvy5OJ/
 EvFtirzvRepKpymlKsKfnb3hoPKopRw8f69FVfuwnE9kx0bJyB+Kutxl/AqvySbyXTfw1sL2yci
 gc4PJW4jgeBGdPBONB6hM/iUO+elKJsfWFswMjdAJjMEjQnUyOf0ZMwOtRPsVq/l9Wed3mBHDz1
 W29ppoAqxYaVK4QnREAA6nhHfJrkdl23raX285CSIz9qg0v8tsTVjerUrCQ0KgC96TY3EagcXnZ
 w1zDzpPHRZ7IYYV3rGYzczsoJCrRwNGRz/hwzYTVHgvl+yZgVrqokuyVyGqUobRIKABv8cO0Xc5
 RwlBjWqU8Nz0LFialugLfDjiYl85G9zdIvcO3QCTPPRGMPUw/q+K+JQeFVOW1m/kTlmhd4nfWgi
 aJWL5Y0OhYdZLQ1TI0HbLyXOKFTYd/OYN99eVP5kI+qgBf5M/aoQpqCOcRuEOKU2NdQ1x0Ix
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=6880e423 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=seG0_iZ--NnEr864CCQA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: oO5w13BKPdDYLF7abGzuqEHzAVXf7F7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230116

On Sat, 19 Jul 2025 13:58:13 +0300, Dmitry Baryshkov wrote:
> The bridge used in drm_bridge_connector_init() for CEC init does not
> correctly point to the required HDMI CEC bridge, which can lead to
> errors during CEC initialization.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm/display: bridge-connector: correct CEC bridge pointers in drm_bridge_connector_init
      commit: 92e34a5241ddf4b084df20e6953275d16f156aa8

Best regards,
-- 
With best wishes
Dmitry



