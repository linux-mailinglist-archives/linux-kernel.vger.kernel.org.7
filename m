Return-Path: <linux-kernel+bounces-817638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27029B584C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8950E4C5EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7912277814;
	Mon, 15 Sep 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCkD/Dgh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889C288C08
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961533; cv=none; b=TXMQWicKx+YUF5tEyAJvDk23lOnlqhZYzzbPVlqQRUpNB9LhKoOD01/5PEC6BhPCRWze0xLLPv7WJE/UJ+NKcKeYOMIJRcmnvuzFwl8SJh+soYLDys1XqNpTD4dvjUmYY/I74fBnQQfw/OWpBKr46n2K5oojvVVR+1tNf7NV958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961533; c=relaxed/simple;
	bh=mhm9fIkIcjl7a1cbDRAMTSEGmJq9IAmll8Fnn/A32CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9XRRpHuJ19YPIiw9YWyYRJtWnWoNKZZyY0hX78Vq2wF1XO4bhonPhXq1soiCehFBh2FNNY/b9LZKcRRmHWQjGtf5/tE7QGyhYkZSx8cIbSEQkiudsY843Z7hCZj7rLGmy06CQvOdEI9KMNC3lmh5JGz8KHqWAr155nEtyz9LXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCkD/Dgh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEL7wD006312
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7ZvFNed0T7k2vLP+CStAQL0NWTskP6Fm2LosIqYY0ko=; b=UCkD/DghafOnqoSw
	L3cbah4SNpTv3PPIg/jLwZ+4+X6VEQNW7+6LX4azpyoaMPAkNmdJoUf+uBAW9s2J
	UI3wrsiUlAe0TXYu3XXa97tlPrfMooiNmP9X0vtATkSaVzEt9fHgUTvOxvFtbtmx
	WzQVISyC8EDf1yZrSRYc2H5jjbZx+1hCfi1TuKwgrXHKMxQpsXQilqRQ3rEvhE02
	lViX/S5QlfSJjJumva0c/nYZV5shquw3qUH0WXA1WFBwID5PKW6AEi+U6hEY23Cv
	eUHKp9rKgVR7+Tjs6lSlJ6C8Mf/tEG2K7qai8TuzKYVqTo1KipD9oANDd0HWvNNh
	0QMZxQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951che19p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:38:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-77a517cbfa2so35062526d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961530; x=1758566330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZvFNed0T7k2vLP+CStAQL0NWTskP6Fm2LosIqYY0ko=;
        b=uU07Iolx2cBrbu+ucqbevePCTwy2XW2n+y6BSD1sGae8RlDjh7GL7b4MndlIslsUaL
         qR9Dms0incWAGSwgfgXEVmHhl21ZFz1ECTt+C1Gmxp+EUFrMOJKe4K196gGY1MFQllac
         H4pdZdptS0eNnse/SbMyNt8kOI4dOXPZ7mQln99hP75cuMipmOWz/5y9il2tZWr0z57L
         NB854153GA/o9ibl1ncJ0zXtMRp4iQgaJgcYxTIbTtnDypC8FPdGL/D+e42pC9sfksU6
         JD0xuiTbt/shjxshli7VyQEFzMEzk7lvQVDf4GYyoQRx2F6HTA5UYqI8XkChzusCNh3a
         +j7A==
X-Forwarded-Encrypted: i=1; AJvYcCWFdfeTvutU3uR9gw+lCJ9birPKfunRHU38tuYd7JQrKOpFIUQMXKpisblrBGoW0u6J2GPc76bl3Ux22dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbMWBL8KYizOlEFeUgA3CmT3pHokF4jPAIGHPoEHaGCLQ5Ovw
	sEPxdCRcRvu+UM8KxcfWK5z/s3jh8QYh3EAY5s16PImC2j5CV0u/L+jID1czexCvByy1BnObx0h
	wHi7W5z+79tStj3iuqh+K6NeIfOoEMFOiPpPqKdAhrvLec71c6oS0aafvigpqD3eN76o=
X-Gm-Gg: ASbGncuhaBJuM8Oviet/XxVPj8zWt48CLnutafaeIYc0JnZkgUpZilRQcd+o7ZodMc7
	WGZ2RDSY3c/JEdLD9uBkq529UIXZQ1whDHednZpuqJAm1TBM48sfGIvt4mTWy+JtsWpfsrFnv9R
	cwLjIkyYHZc6g5eHNTExDqrmvNWOM9N6glIv0dMzOac5jMJ4p2YL9hXMH7H93DOlgVl6S4S/XXY
	X8DACspFoYpIDOUIqG7i+ZTNcUaNGG2jsbR81U+NC1jhKPYpfSLBOtcoZ9SpClsnLSuy/soW46M
	ikLa1ZYOlQ4xkg8qPuSlucxEw3O8Xg0MJH3AH1iOg/mUxxfECAF4QZZqDMPZDQdMHu5tzlXR2cd
	+j2OekP9DdFzCbrYh+VM1zw6Z17SXAlYjynOYEMDyQBjQEWh91khS
X-Received: by 2002:a05:6214:2aae:b0:785:c012:cc71 with SMTP id 6a1803df08f44-785c012ce25mr34397446d6.22.1757961529746;
        Mon, 15 Sep 2025 11:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFcYo39nIFSQwMRtH9wQGOFkG81XgQRHt/zFW69OUnDfhWL6P6ACP456SvE2c5pQ25KFKQUQ==
X-Received: by 2002:a05:6214:2aae:b0:785:c012:cc71 with SMTP id 6a1803df08f44-785c012ce25mr34397106d6.22.1757961529254;
        Mon, 15 Sep 2025 11:38:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1b39db54sm28662261fa.55.2025.09.15.11.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:38:47 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:38:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
Message-ID: <2ry3txigq3jyivtyz7i4c76g74vdgvlozsjkeswxalhu2vs5yx@jqswyjle632h>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
 <03240fae-544f-4753-96c5-a116b4b5a318@suse.de>
 <20250915-active-placid-bustard-6e1faa@penduick>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915-active-placid-bustard-6e1faa@penduick>
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c85d3b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=Cyg6RtkmpQHzVPyx2I8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: FT3BGS-pWtJKaj6kTcaYB3trgkf6bexu
X-Proofpoint-GUID: FT3BGS-pWtJKaj6kTcaYB3trgkf6bexu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfX1RCRekgB5iwg
 y17jYsG/wHzBXymvDp4ADnQadV7xeySdSTcYCYJPgLiKnC1moqpf7gXXaGUk1cPtlCR26AzbdUq
 0GjTLDpM18mzWRiEgvc7POm5mH0fMXvAojWbOxd+wgftIn4QI/9P8+H0cCJGYDffM/aVdW6QK3M
 xDNDHEmNrTGG68ZWSpyMzzSts8/QS8ZE7cRiSwjke/aQhyycRwf3iP5qVBpQjpLXQDGT2wPDG6B
 x1og+z1IKennSwFKRwdFMb6YiDXWcU9zgIWM4MDlYXdosTg6Wd9oqeK7Hlq7YhAAKspxMkxAqrl
 fIVDs+Ez1MlcVx2cVRoJjG7p4Eu3BusWtB4PQjfyaLAFPTrC/7oPm8MqEzHLv36Jj07ZrCzKEIU
 bH9XRdCM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On Mon, Sep 15, 2025 at 10:42:22AM +0200, Maxime Ripard wrote:
> Hi Tohmas,
> 
> On Tue, Sep 02, 2025 at 03:44:54PM +0200, Thomas Zimmermann wrote:
> > > +/**
> > > + * drm_atomic_build_readout_state - Creates an initial state from the hardware
> > > + * @dev: DRM device to build the state for
> > > + *
> > > + * This function allocates a &struct drm_atomic_state, calls the
> > > + * atomic_readout_state callbacks, and fills the global state old states
> > > + * by what the callbacks returned.
> > > + *
> > > + * Returns:
> > > + *
> > > + * A partially initialized &struct drm_atomic_state on success, an error
> > > + * pointer otherwise.
> > > + */
> > > +static struct drm_atomic_state *
> > > +drm_atomic_build_readout_state(struct drm_device *dev)
> > > +{
> > > +	struct drm_connector_list_iter conn_iter;
> > > +	struct drm_atomic_state *state;
> > > +	struct drm_mode_config *config =
> > > +		&dev->mode_config;
> > > +	struct drm_connector *connector;
> > > +	struct drm_printer p =
> > > +		drm_info_printer(dev->dev);
> > > +	struct drm_encoder *encoder;
> > > +	struct drm_plane *plane;
> > > +	struct drm_crtc *crtc;
> > > +	int ret;
> > > +
> > > +	drm_dbg_kms(dev, "Starting to build atomic state from hardware state.\n");
> > > +
> > > +	state = drm_atomic_state_alloc(dev);
> > > +	if (WARN_ON(!state))
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	state->connectors = kcalloc(config->num_connector, sizeof(*state->connectors), GFP_KERNEL);
> > > +	if (WARN_ON(!state->connectors)) {
> > > +		ret = -ENOMEM;
> > > +		goto err_state_put;
> > > +	}
> > > +
> > > +	state->private_objs = kcalloc(count_private_obj(dev), sizeof(*state->private_objs), GFP_KERNEL);
> > > +	if (WARN_ON(!state->private_objs)) {
> > > +		ret = -ENOMEM;
> > > +		goto err_state_put;
> > > +	}
> > > +
> > > +	drm_for_each_crtc(crtc, dev) {
> > > +		const struct drm_crtc_funcs *crtc_funcs =
> > > +			crtc->funcs;
> > > +		struct drm_crtc_state *crtc_state;
> > > +
> > > +		drm_dbg_kms(dev, "Initializing CRTC %s state.\n", crtc->name);
> > > +
> > > +		if (crtc_funcs->atomic_readout_state) {
> > > +			crtc_state = crtc_funcs->atomic_readout_state(crtc);
> > > +		} else if (crtc_funcs->reset) {
> > > +			crtc_funcs->reset(crtc);
> > > +
> > > +			/*
> > > +			 * We don't want to set crtc->state field yet. Let's save and clear it up.
> > > +			 */
> > > +			crtc_state = crtc->state;
> > > +			crtc->state = NULL;
> > 
> > Chancing the crtc->state pointer behind the back of the reset callback seems
> > fragile. We never how if some other piece of the driver refers to it
> > (although illegally).
> 
> I agree that it's clunky. I'm not sure who would use it at this point
> though: we're in the middle of the drm_mode_config_reset(), so the
> drivers' involvement is pretty minimal.
> 
> I did wonder if changing reset to return the object instead of setting
> $OBJECT->state would be a better interface?
> 
> > For now, wouldn't it be better to require a read-out helper for all elements
> > of the driver's mode-setting pipeline?  The trivial implementation would
> > copy the existing reset function and keep crtc->state to NULL.
> 
> I also considered that, but I'm not sure we can expect bridges to have
> readout hooks filled for every configuration in the wild.
> 
> But maybe we can look during drm_mode_config_reset() at whether all the
> objects have their hook filled, and if not fall back on reset for
> everything.
> 
> It would make the implementation easier, but missing bridges
> implementations would trigger a mode change when it might actually work
> just fine since bridge state is pretty minimal.

DP bridge drivers have a pretty big state (DPCD and all the features).
Other bridge drivers randomly leak state to the non-state structs.

> 
> Idk.
> 
> > > --- a/include/drm/drm_bridge.h
> > > +++ b/include/drm/drm_bridge.h
> > > @@ -490,10 +490,31 @@ struct drm_bridge_funcs {
> > >   	 * The @atomic_post_disable callback is optional.
> > >   	 */
> > >   	void (*atomic_post_disable)(struct drm_bridge *bridge,
> > >   				    struct drm_atomic_state *state);
> > > +	/**
> > > +	 * @atomic_readout_state:
> > > +	 *
> > > +	 * Initializes,this bridge atomic state.
> > > +	 *
> > > +	 * It's meant to be used by drivers that wants to implement fast
> > 
> > 'want'
> > 
> > > +	 * / flicker-free boot and allows to initialize the atomic state
> > 
> > I think we should only call it flicker-free boot. Fast boot is misleading.
> 
> I agree, but it's also how it's been called by the only implementation
> of it we have so far (i915), and the name of the module parameter that
> controls it.

I hope to be able to try implementing this for drm/msm (at least it will
allow us to check how does that play with bridges).

> 
> Maxime



-- 
With best wishes
Dmitry

