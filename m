Return-Path: <linux-kernel+bounces-761002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81843B1F2D8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294BAA0172F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A613279789;
	Sat,  9 Aug 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZkUez9eV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CB279DAA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754724373; cv=none; b=QRLjfGJJsNyEfLfhrxDKS26k0vHGo+17VOmKwgUGJOXCfQuixHYzBsR3+qCVqa1SegOacg43ZzilbLAKayI1yQvMwMztHhg5itjW7kJLab79tje0sB0FPwh5oO4hNDes7XAIjoRDS1eQltpsU6830XZytm4zkoJE0ziEV81R9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754724373; c=relaxed/simple;
	bh=7J6tdlkbK43Qp96z2+wn+XZqS6/a8AGWQS9M1yWMwB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k66UTrHVZHQxxlj4WJewwHO5JBv+czXnXQB04Ywl9n2FnqePxBoJxntHoqvSWnP5OARNTg+EfUqBMsieXUkPrMhZ5mC0mqnDjRE3TczoTKjRn66a+nN3xHpZeuHZUrJeg27WKdPxtJAGkY9TGTV3FgnRdsApIX96yvJoJtYm368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZkUez9eV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793VAU1009791
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Fn5zSngvFk1cTroUj6eTtc01
	4LhJeakMsMKQPeY16BU=; b=ZkUez9eVPvdmJ8FupuRJ+mGBOBtBUGEamj8LZJIi
	/IoKhbx1M5RyWZbUYDUP6th5sHtllSZun5kSDEzXZkXuT/vqzcLh1HaJ4GAvhaNM
	NQV8PqwxyupYFLoqhQUJXc1xCWBQV6dSqWR8rygQm5Wkk6Mi1JMRW3T0NfnShVwn
	ufLwptxyAj+7pLKtahzzcRL3ql181u3XUV1I3y4sx3Jwb4fGWjrrXcEO4MnaZ7LB
	z4WzKhy18qdEQ6MUhzPyLXM6QNMdOi4DAdW4K7RjgY7Zp4NNNRb2MUfKRcYvadL3
	eAcT0FefR5Xu2W0jsCEkaJDrfAxcQ4Rod9Xmkctm4Kd9AA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmgfdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:26:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70732006280so55506106d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754724370; x=1755329170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn5zSngvFk1cTroUj6eTtc014LhJeakMsMKQPeY16BU=;
        b=Vi/2ojsbbH/YT2mAKbZ3xy+XQv33VUwsgp0hiboZIogg/8KaUHYhEozVjA23wlck5E
         e9AwzGET4vNd6ByFKG0f20jlcYHbpyI93i+bGwTq3O+GWO137kJudUePqpP+2r9kimD9
         HM+7uNRUs8TzX/6Qqwp6NfxM94gAvoenOVvJhkTPyw3Nq+5AIOciABEaypaDEGlEurFo
         49txXSLAcKdQn3+tqJw0xwEU+BylqZt6U0VznZ/Jq4wgBjfjMeUwUsamdNUGmy2/+66H
         qWyutuBMhf8pXX2xKTqbbArtlK07/A7iHpTJ+yaAaol9LiDab1kL2erTRBAskTn5wznr
         IQUw==
X-Forwarded-Encrypted: i=1; AJvYcCXpTiUm9mdsuAx5v6cC8gnFj/lyy2jEi1CiF8c3IEXpYQJbEtKoLlBivdMXL1ZbkyUFNQ7updLHjz2Eyzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3B8Mk/60YXdW6Y/FF1ce9mLlDQdw+8r/VzYKOM6ccTFMM8ash
	8+7+9c9kxOSM6BcIMAyTJ6EFIlWyCKHrQdt0chYeUubKRwluspnequuADx2Kw4rmf3v5SLVO1fM
	2aTHUK3jmLYutVkvT/WeauVy89kpr2BdFsVV1xyr/6YdNSbfeAffqpe3WwOsoYfcy1qY=
X-Gm-Gg: ASbGnctZh+yaf+WQ9ocUIL12CEPKRVA8PKuB0AJiM94/F1oc3s8LFC/l0XuhJoGOOZJ
	8g4Z11zs0kiLuRxEFNvUYmyV6x2CUiNlkZ3MDfdO4SgF4auXdA/pe0+jSJsRirUT4qAMSLvufv3
	hNpK8KslfmLp3wZqOib34JLhlMnec9xFCUp1jsyl15QsO+265dBKVENSM6IFr/d1/VNnCwZ99wC
	wjI9lxX2VlUlsgefom/+epnN0882N+pVXk0frv/7slYf4KZImhBBzhA6/h+uJeFx67zYN0I6wo4
	kXfEAny3ri45aoi7M8uGoGKpj/FlEVtwUn/miguEg7TYPogFDMVRXUOrz1IOTwoqr2Mnd/67MNr
	fdIT/ukE7BbMp4BKPKxE7QmRuV0YDDf67ZYF+mcmxbBaocLYKZeg+
X-Received: by 2002:a05:6214:3307:b0:709:b6d0:946e with SMTP id 6a1803df08f44-709b6d09645mr1636226d6.27.1754724369567;
        Sat, 09 Aug 2025 00:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm3MfVvK4EIf4H1uoz2bYlt0vMPAaOJ10CZbYEnFJEmJp/EYCEmQWeipcOqLyUae5jc+e59A==
X-Received: by 2002:a05:6214:3307:b0:709:b6d0:946e with SMTP id 6a1803df08f44-709b6d09645mr1636046d6.27.1754724369092;
        Sat, 09 Aug 2025 00:26:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a9273sm32441521fa.24.2025.08.09.00.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:26:08 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:26:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v2 11/12] drm/msm/dp: drop the entire HPD state machine
Message-ID: <7vgdlv3kqttwav3ckqlb6xul6o3dpob5iokyqtdvnk3vvfbx4x@kg2gajwovdzi>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
 <20250808-hpd-refactor-v2-11-7f4e1e741aa3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-hpd-refactor-v2-11-7f4e1e741aa3@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=6896f812 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=K4FjR5uwuDtgQbbanG4A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: cHcW8aDfK_zqHaMbMQ7bxyPSZZWNAPhU
X-Proofpoint-ORIG-GUID: cHcW8aDfK_zqHaMbMQ7bxyPSZZWNAPhU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfXzFNnPt1eXW/+
 KrnaFJAK7HUkVLrkC00S6JrYAOyMMtMiPYAoiXiuunc+o4hnKCbWemovW3FQmfOJMXGSW9x7vXB
 JmqQT56YEZXWNsKXS30olQMooBitNfx28eFXgthDtjoYxy7P9gAMIUBNzJN+cZq5eIiOYmM+H03
 J/jA1lvbfu5Wfar1W3QlfTrKpvz7V1PeWapw559ldowYd3dmeAgXr1LwnRvOPittvdrr+z1aGbM
 aOdA6IYx3kzjyf3aXAD5LvaCb0a9Nwt9kzFMZQ1tWdY0aGXFnRd/UVwM62aZsWgEsRqyMz20CQ/
 /XSEOpqwcdwLhHfuxVZafDLwZYQhde4fidvO85+XWisb0bg3qUZw7ZamZ/KN7lhdpdYd7VSpdz5
 3xg0C5Tg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000

On Fri, Aug 08, 2025 at 05:35:23PM -0700, Jessica Zhang wrote:
> Since internal HPD IRQ event handling has been moved to being handled by
> the DRM framework detect() and hpd_notify() callbacks, there is no need
> for the MSM driver to track the HPD state separately.
> 
> Drop all references to the HPD state machine and replace existing checks
> with checks for link_ready or sink_count.

After this patch there should no more difference between 'internal_hpd'
and 'external_hpd' cases. However, the code still tries to make the
difference for some reason. There are several places where the driver
calls msm_dp_display_send_hpd_notification(), e.g.
msm_dp_hpd_unplug_handle(), msm_dp_display_process_hpd_high(), etc.
These functions are called from msm_dp_bridge_hpd_notify(), which means
that we can end up with the lock ups because of the event loops.

> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  22 ------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   1 -
>  drivers/gpu/drm/msm/dp/dp_display.c | 148 +++++++++---------------------------
>  3 files changed, 34 insertions(+), 137 deletions(-)
> 

-- 
With best wishes
Dmitry

