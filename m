Return-Path: <linux-kernel+bounces-816991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CCCB57C14
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B8416AB14
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320F29D289;
	Mon, 15 Sep 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nzpHhmN7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56280288C1E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941005; cv=none; b=rWDtnWVuqgxid0eS9mqwBaPj+XWILJ+Oy87BY3G28YmUMQ0z5BV9rPTKnWxlBR4gqYvduTqsx009KGi3uNLa//B0cmli7ZbQCPy8Yl2oUWyX5roHCXk4oKS8/cJjm7jHxycSSEqrit/+P3IAOeDJKb1N7b8ysvfHG/SSYC1TyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941005; c=relaxed/simple;
	bh=7GqE30NzV8yX5tSWEnrWhVc91T5HlECnM6AB5PFdwWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLucAZikU4MQveJaKZ7rzsnvVNm1ckb6nJ5kiloTRiWZt4N5hutCVilNgDp5zJe/lP4K0apFsmqQjHOMRHvb01wSwG9WP57G3/fronbq7st40Wrs8Owgn1SKXhiMRexVhecPRUtFmlcBKVsA2v83xPrfgeLZIrMHG+WkAstEPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nzpHhmN7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9QLdw021860
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m2tfMPHRoZs9jwXa+IEmf+UL
	q8xGItfcLy2e5D4Z1OY=; b=nzpHhmN7I6f5nFmSf1S6m/UkblPTxPAUlkkgyQeU
	Q+oETxYMCNv8UsoiLs5mUruZgLgFFq5JN1jjwe4OhPdqsUTSLko6TIm7leSXB8a9
	aZdbvTMebGd1HS5X/2XqVwo5GRUxPh4VjMKG97TVUQKt8bj2gVss4WqlIu0UMsHN
	KF6dyLC7HTWemXMP9He8l/kHnczWSORSBAaJYqF0M6vtHIXW8J4thUxZceXTD7hD
	l6yXLIz8tQVefiQT9au2QMM4wd0PssL58BajfjJCG28rNdVdJD72Oz4+0jKsrLJO
	lnz0CltBzLrbgoyGWU2Wqm774vjnAD23uN27cp9lzKERfQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n0jhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:56:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f112dafeso111566231cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941002; x=1758545802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2tfMPHRoZs9jwXa+IEmf+ULq8xGItfcLy2e5D4Z1OY=;
        b=Q8VGp9o9Meg1N3tdUBlTaNa8iLr5EpyiuTUtVxlZ9iHEN0b/xeDCoIhgrcSC6eeel2
         l+DT52chohVcRYmIl1/FlzAZrlVNQZNcW+w5IWMC/83OyNGcqU3zic3I4dEdqPzZPsZj
         Lm8gOE+k8eQUnY0hjNj3Wic2rsdvp6KgzYL02f2XaBW3ZgxIyACaCdEfwEUBWhnoVCeO
         XxXvDCnoa1GM7fCny/zU0waMl+kdKfC2hCZe5rx9dFR5d12Gb4+kpjRMapzFO3DF2ihU
         AXqnwuTz5qphY1gBgjZnMnAG/pUUJGiW4LqmL/rihTYwoWuGdpM4WNmrQTaXupCAra0R
         78Bw==
X-Forwarded-Encrypted: i=1; AJvYcCW3R8cSE/W6c7XoqgSCwkAEAlrsHGDkFaZwn4EwCF+0H/1C8GCTxbJLqO6b6prYPDSRFbsbc3A05QwEK/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziu8tDOPNEjWCyH6nLdi5MnXIJwtJKJIfTZXV7DyH0+JoVFGtx
	LCPEjrlFVwtI/kG5TuyyKpkkFavMQcrZ2gF8mnUFbtbryaqQ1o04KQymsQ1VGLJyU7eTbyAU5uA
	/nTmullpz26UvSEEmZQUCVrMd06grTmAr2nxUm/4p6mnfX0mtli0Popen4ToilV8dkqo=
X-Gm-Gg: ASbGncv7j1MOU+qsRYWdNMI9UGE/+5qO97w+2xLxRhMNMiEgAqqypt1AWFtj1DrtX97
	1TKE0FrywLB3IiIhK0n2vZonSVXeWHA4o9MduXYnmLGEQhTdTrGDvcKGhvVGySkyKuT3WOjv65u
	PUL65bpBhHdtx3lWug0/k76ULdnZXAmK+HnKv3lQ4fBL1yUPQOesNySb5wjcXEX02LRc3uDXAMF
	iFlEcYNasHry7/q9s2chjCbftg5f7HGIn5cEYA01nfoZ2xtYBElrK/rgq5okTHqj8ezWgCz+s4J
	RWXO2nF8zjSJI9RMbC/4yrw7t/B8sDbyh2IrrHra/RpVJ43UTiW3NPG6T8ZYA3+OBudrjneWQE/
	UtiByxGY8QIhpoqdGLD4FGNhk42QEQNCFQNf2FMQL/w7bXAF4FjPb
X-Received: by 2002:a05:622a:598d:b0:4b2:9584:adc2 with SMTP id d75a77b69052e-4b77d077573mr164748341cf.61.1757941001763;
        Mon, 15 Sep 2025 05:56:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLK0oYa+0o/6GNpGLpG+J51+rCcujNS2C4a6rgPnLc7T4L1xtO4j4u4qgjjcc/oSaO1vTyQw==
X-Received: by 2002:a05:622a:598d:b0:4b2:9584:adc2 with SMTP id d75a77b69052e-4b77d077573mr164747721cf.61.1757941000979;
        Mon, 15 Sep 2025 05:56:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571459c1482sm2816436e87.0.2025.09.15.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:56:40 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:56:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/29] drm/bridge: Implement atomic_print_state
Message-ID: <sb26c3jupnaxq354evjiy66ylnv3c2mumlcdiqe2zn3gwpnjae@4sol23rjv4eu>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-6-14ad5315da3f@kernel.org>
 <056b0335-f104-4b67-9882-6beaecd21c76@suse.de>
 <20250902202212.GU13448@pendragon.ideasonboard.com>
 <20250915-intrepid-quaint-bullfrog-bb68b8@penduick>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-intrepid-quaint-bullfrog-bb68b8@penduick>
X-Proofpoint-GUID: 6AbUxjCAq7ZOLZTqTcuu2s5aKgjSFzdT
X-Proofpoint-ORIG-GUID: 6AbUxjCAq7ZOLZTqTcuu2s5aKgjSFzdT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX3RJ/qWw3PADi
 ZLv/kSEAgvq8lQmQyzaMUe+TMjD/ZGpB5hQCKpCZQiYe0lNaix+GaX2o5B1R9JG4GdSy/iEaYVW
 IT/BVQID18pSVt7c/P+YYmSCSCV64avWXIFlDpgfXAr013BLS5fKPiNwWTwOmQS4uBvt89L3WEy
 aOUTjbgNBnggnzdF6pGDWFQSktVfZw78iR6fkdoISp5atR46MvJBhOD0uDZEzIRcnI5ybJFgurq
 je0JRlzeUBn9DssE2o7qWnYJU2HJn4yp1G3/iQnnmzUXbcBTH0SjT0wneivTum5L/alJZn8p/sg
 WD+ar6puV9eMw8Sp8xIl3Qd7spszlTU6CujfZPHwQfXeojgYPDfD3//4q0d6gK/5XFClUsBADbr
 9fzQIw5x
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c80d0b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=P1BnusSwAAAA:8 a=aqNsKDukHhMFCnqKvA4A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

On Mon, Sep 15, 2025 at 01:28:46PM +0200, Maxime Ripard wrote:
> On Tue, Sep 02, 2025 at 10:22:12PM +0200, Laurent Pinchart wrote:
> > > > +	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
> > > > +
> > > > +	drm_printf(p, "bridge: %s", drm_get_connector_type_name(bridge->type));
> > 
> > It would be nice to identify the bridge more precisely, but bridges have
> > no object ID :-/ The raw pointer may not be very useful. I wonder if we
> > should give an object ID to drm_private_obj instances, even if we don't
> > expose them to userspace. That's not a topic for this series of course.
> 
> I agree, and would have liked to have something a bit more descriptive
> indeed. But bridges have neither a name or an ID, so I couldn't come up
> with anything better :/

For debugfs we ended up printing the symbol for the bridge->funcs and
the OF node path in order to identify the bridge.

> 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thanks!
> Maxime



-- 
With best wishes
Dmitry

