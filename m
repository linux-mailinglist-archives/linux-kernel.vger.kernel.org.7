Return-Path: <linux-kernel+bounces-848215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C1BCCE91
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C3F1A62A93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADB5261B98;
	Fri, 10 Oct 2025 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UPemSx+s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151F275B12
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099562; cv=none; b=IlQjZ40vVItMOQWdFCsNiZNsPEzEEh4JUL0sakzzmZ2ZYRKfZUSa1c5CBZzrSsVdDA0GsezkQcI1LsOv5AULHtLkO0QjPtOnOdNLLap8R3T8E3cn6tMDLTcz5gwphxmrxNtEyVieO2hg5IqtQ3A+/Iv19crXYvVvZYyoEY5yEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099562; c=relaxed/simple;
	bh=a1PHGAQlDDG7f3dDQQkAaeEAqNgPfeV7bZf5e1atO2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtrObd5b89qypfEhXuhlF9HQW35GV5U4mbydvzPqE9kPNUOEuCU6K2QNrbyN4Q38q8GuGJFAnNz7c8E9/Sgz2Gb0j9F4RkpNf2d7ATUXSEfPP83tSouBhiWoaPPwGgT1yjY5jD+HM7S41ECLScyrtaO0vOzKCzEuxaUxaekF9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UPemSx+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6Wgkq027241
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3FGswqZmb7o87pLL8dC6h4cU
	9CHmuuEKgRSZOOsTPV0=; b=UPemSx+stLLvTAMPbelFSkpNIdlZyfRbmoEetfLo
	AZnWLvARtetXEHFPcTlOJv+KLejfy5MhalbQe+tIUAdKCtqDjG2bQ4x5JtqjUKLe
	Qt2tLOf2xT5tSjObxqk/monVnGFEdLT5Tv86jlxQLnaP8Ndq9e8Rc+rmCQSr4FCY
	jO7xr95LIQDRjSzvNwDS7OlI9f44W4Eyt4Kq8YNuiUNb6nA8BUsf5/uWcW4BE+7o
	KjfCoMn3XEZUGZ9MVmWrp1uDloXlAjPkAmaw4zoc5ecAW6SRlsKpzUJb02PzbWJL
	0cQ4G+Hc68dR0/YJQiEoCChseGFRFrDfz+MixWI2W4uReA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4npcrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:32:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d8b8c3591fso86418541cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099558; x=1760704358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FGswqZmb7o87pLL8dC6h4cU9CHmuuEKgRSZOOsTPV0=;
        b=kaxc9Hcp78r82QRULHkBfZuSg6NZylG0pfuKNAi+isHpa0agBjdKDPBFi0HmVJu59I
         Sb7WP4CUSbP6KdV4i7wP5eN/eCVRiNJ32MZ0jFfdqr5/UJXirh/P9uL+yVNaHM1WW35F
         bS64PzM4TPNtPnNbrbpvM++lSdz1ptLZBm2hDUgWvfHFABXUDe2l/rb27zXLE+NIyPvo
         e78PV9mhhjRwBM0KVCuLNwzAtD09KV1uSZeTw4cwex0WOln/bN4nqrxqDNF0rbObSq0V
         23BlI/p25McZv3F/U1vySe+p7DPnt/oUjo3YBUmCpYvc90u8T9wlN/9a2D9sQSjgNu2r
         K++g==
X-Forwarded-Encrypted: i=1; AJvYcCUcCA9Mji7OANqdKe3VNGm8YgqdbSV4xUCl9ArkeiZ2/UqrLz6wN//0r7RIY4nAZIXXYLfT9nS62CDTGTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrV+nEGKD3KSjn8/LfNF2dlR5Ewe9kUj5+QqPT5TZX9XpxNJ4/
	zWO4wxsPSkBb8bu0GPtbqIU6rTyV0yWBXNqHgkFuPbvlrfTax1xK6pdTsgfy4v82+yOERgVjaHA
	rSne/lYm1F+PQEAmA2b8Oug1Df8blrNv/3wpjYChO8+G+nQx0iXwFwOmlweoFLj3y7+M=
X-Gm-Gg: ASbGncuC4WGPySz7F51LTfMoxlFdhcFVEtqItSkGD59GbB+pE7TmCtj4s17oQG3L3OT
	mQy0JpEgH4OWUSRe/rB79m6BVwFsBBsaM0luTIZcQIlHshctMsbyqs3/awQ0BgI3U5EeeWcSsev
	/1qN/bbv6xkVkKcFTa7R1qrRzhig+AsKuiQihW4H3zeWr9zSW3lKcQEfzYq30/BRxcfSSfuPrR7
	vbeMSUwekqEX5/WL0PVi5iUzvjQPdFtKBI3o7JRNJYWHiwV8FV/VE2VgCao+lrLQcFAdKlko2PJ
	I3nudDBRYIcuN+l8lzl1SHMckW/srkqxZtGNFqDQdEdPBrtqNz0r3R4uZrHzfs6v+7eLNSeBtE+
	X21bBwj5HXzr6Woa6xmzV+hYqUezn+e5k3dxFWNVscMuZU9vqHLM6
X-Received: by 2002:ac8:584c:0:b0:4b5:ea1f:77f4 with SMTP id d75a77b69052e-4e6ead859f5mr149627101cf.64.1760099558323;
        Fri, 10 Oct 2025 05:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8GKqXID6v9hnF8T8Cy7rBeFnt2STh9JPsXFF8UUnC7ioTi8qpCFti2jz2aTU4mL9cnzn72A==
X-Received: by 2002:ac8:584c:0:b0:4b5:ea1f:77f4 with SMTP id d75a77b69052e-4e6ead859f5mr149626551cf.64.1760099557749;
        Fri, 10 Oct 2025 05:32:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea14d46sm5982581fa.34.2025.10.10.05.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:32:35 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:32:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harikrishna shenoy <h-shenoy@ti.com>
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
Subject: Re: [PATCH v7 3/6] drm/bridge: cadence: cdns-mhdp8546-core: Set the
 mhdp connector earlier in atomic_enable()
Message-ID: <5nzkzfl33tw27pjqjxt6ao5pbkd6akvjehzveoarpz5lczq6zm@2fe63bzzmqyr>
References: <20250929083936.1575685-1-h-shenoy@ti.com>
 <20250929083936.1575685-4-h-shenoy@ti.com>
 <gtj43rfr2dgegutffma34w5bhvdmvx44jhwxgxb3ficqh5tm53@2iyr6ho3qfdh>
 <429400d3-e369-cf6a-3e9c-3d00622d7f29@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429400d3-e369-cf6a-3e9c-3d00622d7f29@ti.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1zs/Bcua5IMy
 zFjs1KBFQ6GaFAHQ9dJq5mLE3sj1+RiULdhOG3Fe4w/nFWJGT9YYW7ajr7hL9ZaGr4/O3AgH3D1
 fTvrdL2VcE3zqQOcM1nSFk3TZETJZr+mjdDOq43lWR5vgfSmcC4VYnRk3KfhEK7qBoiAnZmjyJZ
 kmrfj4qMrr0E1pEobja+btCe6qdFsHyutunCerde8ZPVdWQCTBozBFqr4ZGQV9hJ3v6Tznsv83q
 GNFi1O6EehGsxCPCUffmwToABX6igdiRxBHeqobgkTalEQMbEpLkQT/qnjw7+fHutmvObRY78g7
 VPdAUd+vtoF2A8EF1QdX2ZQPDMl5mRDPRu6y0T17d//f+qhN2LnEh9eEBQ+7jRt2x4yye69uBJO
 nEykemwpEiYk7VybYJ0EtwFmSJWiyg==
X-Proofpoint-ORIG-GUID: pJ8A3m7Scq58mH3a4ulGVJb_dvEkSdnP
X-Proofpoint-GUID: pJ8A3m7Scq58mH3a4ulGVJb_dvEkSdnP
X-Authority-Analysis: v=2.4 cv=VK3QXtPX c=1 sm=1 tr=0 ts=68e8fce7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=sozttTNsAAAA:8 a=991EO4SM7AfkRsUnTd0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Fri, Oct 10, 2025 at 02:48:10PM +0530, Harikrishna shenoy wrote:
> 
> 
> On 06/10/25 04:42, Dmitry Baryshkov wrote:
> > On Mon, Sep 29, 2025 at 02:09:33PM +0530, Harikrishna Shenoy wrote:
> > > From: Jayesh Choudhary <j-choudhary@ti.com>
> > > 
> > > In case if we get errors in cdns_mhdp_link_up() or cdns_mhdp_reg_read()
> > > in atomic_enable, we will go to cdns_mhdp_modeset_retry_fn() and will hit
> > > NULL pointer while trying to access the mutex. We need the connector to
> > > be set before that. Unlike in legacy !(DBANC) cases, we do not have
> > > connector initialised in bridge_attach(). Now that we have the connector
> > > pointer in mhdp bridge structure, so set the mhdp->connector in
> > > atomic_enable() earlier to avoid possible NULL pointer dereference
> > > in recovery paths like modeset_retry_fn() with the DBANC flag set.
> > > 
> > > Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
> > 
> > This Fixes tag means that this patch can be attempted to be backported
> > back to v6.5 (even w/o cc:stable, etc). I know that it is a pain, but
> > please move all Fixes to the top of the series. Yes, you want to drop
> > non-DBANC case first and then fix everything. It doesn't look like it is
> > a correct approach for the sake of maintaing the -stable branches.
> > 
> Hi Dmitry,
> 
> The patch which drops non-DBANC case can be moved after fixes, but for
> making fixes i need the pointer structure so adding fixes tag to PATCH 2/6
> "drm/bridge: cadence: cdns-mhdp8546*: Change
>  drm_connector from structure to pointer"
> Let me know your thoughts on this, will re-spin accordingly.

You still can have a pointer to drm_connector. Just make sure that it
points to the internally-created one if the driver did create it and to
the external one if DBANC flag has been passed.

The easiest way to ensure correctness is by reordering patches: move the
fixes to the top of the series and make sure that they are correct
first. Then drop the old code dropping drm_connector creation.

> 
> Regards.
> 
> > > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > > Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> > > ---
> > >   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 20 +++++++++----------
> > >   1 file changed, 10 insertions(+), 10 deletions(-)
> > > 
> > 

-- 
With best wishes
Dmitry

