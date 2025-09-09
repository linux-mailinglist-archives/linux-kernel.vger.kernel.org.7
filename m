Return-Path: <linux-kernel+bounces-808374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E926B4FEEC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F17F169FD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E879F343D94;
	Tue,  9 Sep 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b1bLkqxS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244B3019CD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426958; cv=none; b=jmH3MgzSSnwq3+Af1qdopoL7oGdzJN/DlSfYd998cCclrXbQPSBUheZf4oZyi8ZsJk9OTsFKdV3ZNQ/w/7jRM/cdrHSMR0cwhH/0Y5f4G7i6VtGA27VSRVlm254QYdgMNiEztXbaBU7opKgwWmMamLOf90rxNCWrIY6meGiss0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426958; c=relaxed/simple;
	bh=AVPGlzcwSVR8C40jUH/i++pO1DjiBxVBSm+tYmcj8rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9CQXA9lwTi5AZ/nk0oEAbFwz94AOMeufSlx7yaaWP94bMTsvn33KeN9omkq33gR/sZ1mkfin+hAEjqi46gok3ofvLDoZ8OMFGIpY0T+5zm75KjDEtoZ5Y+mPzfL/whTxRq69Lvzje0HvBq+SOguYNS2xHEqfNCU0tZ61gwipFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b1bLkqxS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899Ls2C011334
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EYu1rpz+ayR2SpOvoCVl+NKt
	GHzEbiyh3LtAwSa8Rr0=; b=b1bLkqxSWaFGTMVylB1j5y3Y6QjWykOVTq1IUWl4
	wfC3iYr9inLdBqRLg15wCKrAGHOIo4NqeCJCgknA3J4PYyMkOUkFmQB/MPpiK0WL
	uGbzBKpeVhtbn6+QChXxC+ymPMM3bvfGNZidE+4rsCzW2aIJvVO9OEfjq29ZR6GT
	U7OkiJYSp77OzGz9EAxDjlp7K9lsr4wZNE7kpNP1q9WnY0B0oVyIGJKRxkYy5Tir
	G201dvXruxguRVeTJ/gAsGpILLvN5NUGtAwRqWgbmmMWXY8O7TxU+0psfEyR6vbT
	qFceOllu65Tqo5Fi+pvM3Z40NteIIHXbDVPlzxI6Pj0shw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0rf4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:09:13 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-538ba4ec68dso1483270137.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426953; x=1758031753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYu1rpz+ayR2SpOvoCVl+NKtGHzEbiyh3LtAwSa8Rr0=;
        b=kuw5ufGHr302cgHGSHQJXFXeFiaCHd/oLickDOshNbTincIPuTOuJk/Rzyfqn4p6ev
         fQcsPzkSyLrhWamLl/RCQgq8XK5rnZvh6wWIXC4nGqG96HsBAtrSRUfkL27QN1wOlTvL
         gDirGaJjP1m5WnJXFCsiygBUchzoY/G2q5YTSK09aBnv/AnbT1ojnK4YVLWu3ai9yT6Y
         W4WZsLRvo8ecNbYOxR2Jcq9xsUB3SifFdqgz0Ecivw4bKxCp7bEmjEjXRp7+mM3w7Fpf
         yEWj9fbT5hDeLtEcXRYGuQ+1K4KX+zrsgbKOxwhiO9NwJ7X3eUroQcRbIi5dRnEg0jHP
         Axaw==
X-Forwarded-Encrypted: i=1; AJvYcCUeewum81T5pxQlJawXqFr+aBegkApTTK4QSOUkR03RFTLGbL/0O6gQmxCphLGIx15khzTMfb7nWC1Uf4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjC9m1ED1Xd8s60vdp2vAgrEgYU3bY1PxAMvuapPS52mSMecL
	dKMKO5AOvtGl3/Wi3wx8f/8tbfp7aiTIbfR8KmQkS/NpJXKJ0BiZvMq6F0svfePpWRuMq7F1kJj
	D/lS7cKJuN0Zh9ppPEolZKxMOjK7Yfs69Mxp7bxC7EgGjitHh0GHtJSsJfOf3l+CocWQ=
X-Gm-Gg: ASbGncsK7+yEr3XcrCzXLiQT8Y8YUre0AriUei2mG9TH3GNUrWXpmQbPJmfv5DLxB15
	PL9HBvHxd+7UQGa6eAsCWrxywRPlheaQONg3hqvmBHPMhwcomPx76/xoau7X1PDApfyF9NBg8qT
	c/zyQEsyVTMwsuLTkeBNU3XzWGYi+J3R+ueEpM1HvtEE6AXuqu6A0dwLRJF0j9o4jNnrjWsB8B6
	57NduZaxn6q7GtBxUEWc1tz4CIKYEqIealOpl9fy5qCm2OEhKfqKx/6dCyGUMOtxlOvG7riYyHv
	NJDa0Y4vXpk0Ur0reZEob43VQe5pnyZyzJ2qQ+kxEmXmWm9ieYfUAr/uDIZNpoCltmErk0iGsSo
	k16kIbIeUN4bAMK7zro4Mf4FHuXxWb2027JGsg72zQ9jVtG6j7NvE
X-Received: by 2002:a05:6102:ccf:b0:51e:92cc:6e6a with SMTP id ada2fe7eead31-53d160d3f9cmr3496652137.33.1757426952554;
        Tue, 09 Sep 2025 07:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyuKF9ZBGLqEfAfogvaq5jLi8aIGvizJ1KZg/LwAwtCivtLJUEnFV5T1DNQ2HVkHyvZqaCww==
X-Received: by 2002:a05:6102:ccf:b0:51e:92cc:6e6a with SMTP id ada2fe7eead31-53d160d3f9cmr3496589137.33.1757426951750;
        Tue, 09 Sep 2025 07:09:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cafaa64sm551811e87.43.2025.09.09.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:09:10 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:09:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harikrishna Shenoy <h-shenoy@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
        andy.yan@rock-chips.com, mordan@ispras.ru, linux@treblig.org,
        viro@zeniv.linux.org.uk, aradhya.bhatia@linux.dev, javierm@redhat.com,
        tomi.valkeinen@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devarsht@ti.com, u-kumar1@ti.com,
        s-jain1@ti.com, lyude@redhat.com, luca.ceresoli@bootlin.com
Subject: Re: [PATCH v6 1/6] drm/bridge: cadence: cdns-mhdp8546-core: Remove
 legacy support for connector initialisation in bridge
Message-ID: <gptscrssnl7lck6ga6bzu4grcjcbokbdznbg4skbpvrmuo57ex@4zjugogguuw4>
References: <20250909090824.1655537-1-h-shenoy@ti.com>
 <20250909090824.1655537-2-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909090824.1655537-2-h-shenoy@ti.com>
X-Proofpoint-ORIG-GUID: x8hqWwX4yGgYss6VEzyBVp_lfzODCF0s
X-Proofpoint-GUID: x8hqWwX4yGgYss6VEzyBVp_lfzODCF0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX3jJG/KVhnb19
 fPeddqsvAxbQ6BWwctM1o/sOCG8Afg5Wj0bdWk9lxU8jqw5d+mhiGT2W6TtLVjnI1Enz+4ZHtgn
 fUWZysGjXL2ylUVfi2HraNn+bEFAsSAiK0uYVnOe1iGnlkrBaSAYSEg9YYqi56xy1sVqAyzoAXI
 3gPW1jt0tQWhIlN7emF5FhSq/3f2dxZDyCEXEv8AWAbkcVl9zQCxOiqV4y7oPTZud9WS/Klspfx
 F0FmQ0xyG3Y6HP3UqrLEPrkJxYgDOGi0GHmn+3LNTXP0DWb0fXSNGZL8c2xJdoizhkZIGhqQrBU
 eBzhSWuATF6mvm1SqKqvubYvllVygidEQwHBvblRoZAzC3WFunm204tdcCWNot2N2GVK57GZm5D
 scRF+Hx0
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c03509 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=7EYWOy9vIozSJFQcaasA:9
 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Tue, Sep 09, 2025 at 02:38:19PM +0530, Harikrishna Shenoy wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> Now that we have DBANC framework, remove the connector initialisation code
> as that piece of code is not called if DRM_BRIDGE_ATTACH_NO_CONNECTOR flag
> is used. Only TI K3 platforms consume this driver and tidss (their display
> controller) has this flag set. So this legacy support can be dropped.
> 
> Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")

I'm not sure, why do you have this Fixes tag. Other than that:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 187 +-----------------
>  1 file changed, 10 insertions(+), 177 deletions(-)
> 

-- 
With best wishes
Dmitry

