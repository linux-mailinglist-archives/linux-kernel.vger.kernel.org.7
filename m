Return-Path: <linux-kernel+bounces-746717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262D4B12A5F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFC35443BC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2792242D88;
	Sat, 26 Jul 2025 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BHP6I2YA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D7A4501A
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753531526; cv=none; b=Dhxi+vUnFqRfU0nIHtb06OhRb7sZq2b73u4pfnoD4UeY5Z7O1xrBmEATw4PO3r0Zw+ASCOS45XNoMCy2t4E+uOM6mSajyDi9ZAGAbbuhFFZJYfGu0EbDFIjDo3nmpiBcaV1U27boQBNZ/y8cby9r8H3V4lDNbliAutVz6QQ9KL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753531526; c=relaxed/simple;
	bh=40gDhaF+mgeZ2DYJQ6bquL2ktTYwVRNBMOYLWfhAv4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwmQQTRhrX5DJSnNmqFDuY5m0NcTqG2GD/vnXWnGeP08dglmbFeC0a6+HkLrj+O2eE7Nqla1JMRVXSRhJmgISFD++XdAdBAobdu22bWCLHukRNGrX4nxyE818by2WbtfBU6a112LbrveIMwxd7aE/zffSvipoWnsjDYJLFl1hF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BHP6I2YA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q3W1HH025243
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DTIGg+kC61P58j186QXClRnL
	U812M4zddHYS5CcqKJU=; b=BHP6I2YAIqdJi7tJv2nQQJe7Is0zZkqGNEQjjuOH
	1wYHb08R2f91VnkqBvY9h0/mlhFa5BbA361u9hL4nV+TUfqSIU32qKfbxRZKaa8v
	55TP8DPqemAB8XZVDM1cBoWQOxk7LoSWKCjDXAsI58KUbKJ3RO1tsxNFt8uhFr/A
	f6/hLa+1ij3bXOx/31nxb69vRQ/AUPMDBtwKqmVkEeAp+NgTs/JuImttIqr1shJz
	oLgNwoDaFYQe1o/a66mX6KaTcPu7ibLA+qr/AOz5Q33gtRsY+zZwaDnQWn/LJQIQ
	0dKthinJR0wxwQDvb98XnzwfwBa8qn8sM8MzyaUFDilOEg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mqk0swb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:05:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7073b4fb53eso39356d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 05:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753531523; x=1754136323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTIGg+kC61P58j186QXClRnLU812M4zddHYS5CcqKJU=;
        b=LwdGNDXwDPGkz/nwJEWebv/32W+Rlzh/9TU+niTGKqkcVZQm/Rcpto0nMKf5vnwTus
         tTEtYGuTDz0A9bbiWa5UbEs1PiVy99A7iubc0fBInC/65WIBluJNfrfqDd7cvHLQderI
         k0wsv6/kY8qAxtPS6mgusyJ/H5zQZhyNWtZ2o9DHxkC/732HSl/6Mi7kBbwYoKhcL4qj
         EuiAOz2obY/gcjWOiOQGNYInv0LR6tyigcWBzkxLb2Ol3r8LuBQTDdDQjiPpF6yDo/Rk
         YUuHT/CJcKJ7osHvF0+iNPVPSvXp7RCNW58P3pDOqkegzSamxGDrfwzaQxrXQaudbzc8
         zGPw==
X-Forwarded-Encrypted: i=1; AJvYcCWcNFSKfM1zgenSZTvJikqeHRTtus4hBMhs5QIVs4Bhcy94+8MHjwtSkoya13KClvmSSo+8I9EZBxvDrQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBAr07EIlklOc4PX2YTMmCOIGLkiZ0BQtzbwJVcEA0rwVsZmAL
	rCGXyBPw1KbI5SDi4zOV7B/MSHjwCO9rtQ6uaDuJcUfRUWFjTdruwIVBBgzGu2rJkPxyFWU/iEB
	gy2NgiMqymyyKoGLjrw0kFurd1NHmNTfWD02l8O9gfAYZEFPpLQsFSgeEn7UJuK4hJtQ=
X-Gm-Gg: ASbGnctlEBv57sAmQBtBZ60AByc2vIWgmALOpkBuZFqhdtD/EAiA1LoVCa1XaNxsrRp
	su2MgldNeoC/z/I/mwbEc16IXFhyY22lDsZt+gTMnOZ3IKHf4iJz8Zi8TMBdXmXNofUHB63IzbH
	0agtCoWeeVVAt7kt71c66iYAPdLKy4jVclv4Bs4UfJdqFOZIPhIg/qUj2eHTkUblDMgvMjrltN4
	tmzXaP7VVL65lgxct8OuZLZbrI8r1eIZdHj/2rMPsgH3y9ZmOslnoguVRytJN6X3Vtnxnp1K+Ml
	QMqvNec639IZWaaJv8E2hd46w1fUAEdQpTrR07AEmSVC9MPa+1KtNe26/YCw3uBjmHuYFIXQx5H
	DSZRMsvRgVYLIgGOU5xIcO0tG1X2ROTqGIAg1iwLcY7eOKHSXUjWF
X-Received: by 2002:a05:6214:29ee:b0:707:14d5:ee74 with SMTP id 6a1803df08f44-707204b2a68mr71727796d6.3.1753531522548;
        Sat, 26 Jul 2025 05:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqLS1jVGgdye44ecBKfrqDjWtpGZOfSZrTK9StpLefqH75rrfs9TCl1Ca6g9vIQ221L1XPHA==
X-Received: by 2002:a05:6214:29ee:b0:707:14d5:ee74 with SMTP id 6a1803df08f44-707204b2a68mr71727076d6.3.1753531521882;
        Sat, 26 Jul 2025 05:05:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6337f3d5sm406862e87.165.2025.07.26.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 05:05:19 -0700 (PDT)
Date: Sat, 26 Jul 2025 15:05:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, l.stach@pengutronix.de, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 11/14] drm/exynos: exynos_dp: Apply
 analogix_dp_find_panel_or_bridge()
Message-ID: <lhzh32ji4gy44kh6ymobbyp6xdwkx5hwfwdhdx3fy25vaeigin@6ofhouk6nd4h>
References: <20250724080304.3572457-1-damon.ding@rock-chips.com>
 <20250724080304.3572457-12-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080304.3572457-12-damon.ding@rock-chips.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDEwNCBTYWx0ZWRfX0rR6yxdg9UaQ
 QJBWas9Y5OrTXFMc/E+8kRXSeFl3qoXsY0ybCNyrw4Oaxer/bY6wGZJg4paUu6y5nV9DwlR+OrX
 7FVYQtx8Jt39Jbh1PxzZ3BWqetc8JlVbr0x9qFnAgvH+dmegDImwiWL6H2pVRj/MeHowVkF0B94
 afA8Ix5jFcQzoWEAOQc5+XoBNjmPKBah5tVk3Vi4UEVELRQpaaQWNuZSIFsaYXXjSb8pDYqAbOp
 CEo6QsxGRb4WD+AQhjtOnWT7yTvWXMoDx7CiCR9/nig74d7jQSdmHiy5v73iHOCQm7aB71Q8/rt
 ExFI/cCoC4PSlAaD2Fwo1S7CaQ5fqNH8UXQ8VU5lguMsyOU+foZIcVEzSy8KJDU21R5qYLkCDFB
 Uby6htK/BcjbJYqzVu0dZWfgSVdpb1qHfeaJFZzLBGcshUUcP09tCEOwCiSCunElh2iyfvVJ
X-Authority-Analysis: v=2.4 cv=fqPcZE4f c=1 sm=1 tr=0 ts=6884c484 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=xX9fryL7oNgbU_NKkWoA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: FZWtiDFL7NYFuEQ9d9-bbDrOPBN-1Fuw
X-Proofpoint-ORIG-GUID: FZWtiDFL7NYFuEQ9d9-bbDrOPBN-1Fuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=694 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507260104

On Thu, Jul 24, 2025 at 04:03:01PM +0800, Damon Ding wrote:
> Apply analogix_dp_find_panel_or_bridge() in order to move the
> panel/bridge parsing from Exynos side to the Analogix side.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/exynos/exynos_dp.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

