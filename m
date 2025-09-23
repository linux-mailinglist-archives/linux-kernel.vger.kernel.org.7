Return-Path: <linux-kernel+bounces-828778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79611B956F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA22E5E25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA11320CBB;
	Tue, 23 Sep 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IYXCA+Qq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62950320CAC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623345; cv=none; b=QfSIgXLCEvonbR0oY25brlTE71X7WEQZ59S01+oKmEY98/ORTGDyDTA4lj3JswqTqrZUWeLJOZbse2HyovUd6pKC/70Jyeer9f9uJUN22tqGzvlYlWW3SDWPmTy3MUucxEOo7wjNHL33p0DLZn4AtRLCx5rrriCmV5OWTLVBNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623345; c=relaxed/simple;
	bh=BQBoqvsQzwnVUueFkq85z8CLpw+Ag7lMiQZGEVXRrSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMuxPA2mnhmZFWr3U5N19T7FlSZN/q5bgVVF7fQBMpEAUEWL5QbapK8FzZDf8BJd4hv5opZH1jPSI5wQoFJtdoY7LHEnHsK4CL/jJ4XvPiHl7bGU47knhNDazCh3j/NYv46/48PiXOwu1xSS8lzcyXkDVF46EqijpKxk5eLrBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IYXCA+Qq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8H83t001610
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vcQLzv4hN3x7E+ZxRBUC7E65OQflHJ1QFBu9EjsyneA=; b=IYXCA+Qq0srZd8W/
	Gr5cu4JztxLjqahviDuzLw/UMH1r06QyVJXnLA7meKiGzKONoQJTaRa5cXhU8zyZ
	SB65Omow9QTnivFMQBNA+scQfOdurRX/DUlMMmQv09phBfC4cBVO3RE7hKK1MfiM
	a/n7/zA/HBSqdKx+Ueg5cyd0hRrBGuV/vipCulMkamviJkvBjodC6dbABYGPw1ho
	wHZw3+BldyoW+IF/a6sPPdUrCnvBe7ZcyiGQ3Cm11/9eok0U+uqTcIasbGHs6MAe
	vlJxGIObenLSZI9xAlUrOsFh5684oi/qvbH5mqjlTM3bnnXbJtF2JiFoV5XKtDPM
	rBcTFQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fg2u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:29:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4cf47c9bab2so47779111cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623341; x=1759228141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcQLzv4hN3x7E+ZxRBUC7E65OQflHJ1QFBu9EjsyneA=;
        b=nR2O0YX0CCPevOeWhrejelIPHLE6nQVXpWi8tul0Ap3fR0bV2XVG7w/PKAG43D9BMw
         IaqPVqrY0N5fXnTZ2e6W1N5sm6uV39SyiyKrH2EfPuDFWivKtMjoLjtj+Ux8XOzqJgt6
         zcWtvSuGvxijx9vo7hROB9VW1S9LHfbB/uDfHHHs0gG8tpZgNu7YylRPyksMQFGbF14p
         KDLI6W/67L5WNeRk41QxAsNUE6cXb4kn+kDpzFkKP8UbiSPUfuVj3EpASCzWUtNvuvTm
         LQ1p5ParIuQvT42rQdJHbqzFjVEGDLv3HSPVIp4rdS57f3c1PycLTJOHuSR8KD2S3ma+
         EXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfYHDt2Ykc75slI5aN8dCLfM1dRyLLxDCdfcyaq7cCLgAPKxn7NEWL7r3hdIP3bxvQOv9n50VIXcQMzGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1M9msCM5qc5j1m4Y61UFuLjM5/SiDfAqelCzHWGnOHmC6mTS
	jhpR02vCYcNnUv4DldmGM/FhJJqlwqMGOCEUHwW2FkMdaRhI+BCtyNvIOpd47QqXv6sLLGoV5dn
	5pgK2YCJXlyEp1ovWdXKaKB+6Re9UgiYi7cN7dM2lProt6B0MUzlwTP5UtVwVgvBpnsQ=
X-Gm-Gg: ASbGnctZVkLHeprLULWtYEWb+QwmQb1eYqPMeFTadEslOFBRajNslPW7WVuC7tYYUJf
	dSJu1z6gz6Qv6/G/pgYCkfTPIW8MAtgCwgred5g1L4eSSHQK+FpcI8PO/wnNWXc0on91jbaxxgw
	Y/OeLxjRKCWcrCBqPHtlv5DVeCQUbD8okZsib+4nv7nozHxVDu5Fjn10BbyrOqObOQ0FqAV2hbL
	pEmfg15y4YsZ9SBVOA757CzPiY6Hcdq5xnuKlMP3RPdiIcOs00QoqVHuA+aUO1/BFax7b+3RjLP
	jJT8Qw5+MDWwAieIprwoyNipVvBSm93TctnfyZn4HOnuynBQrnHmFWtiKmMDG0a0/rWUISv4YOT
	IuARedswE75hQ9oTH/VMfQ0SgryZMuj43RT7TAax7kS7MRf7Hvtm+
X-Received: by 2002:a05:622a:2590:b0:4b4:8f6b:d243 with SMTP id d75a77b69052e-4d36773dd7bmr19799391cf.7.1758623340885;
        Tue, 23 Sep 2025 03:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdyNNd5NWlS3tfjYoQk1LprFDWXpjh2LHV0xGI85+jVgfKpzm2hdXkVtJbSIeE2eHrY+9ApA==
X-Received: by 2002:a05:622a:2590:b0:4b4:8f6b:d243 with SMTP id d75a77b69052e-4d36773dd7bmr19799151cf.7.1758623340251;
        Tue, 23 Sep 2025 03:29:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57fcb8914b3sm901237e87.99.2025.09.23.03.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:28:59 -0700 (PDT)
Date: Tue, 23 Sep 2025 13:28:57 +0300
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
Message-ID: <osdt4teotc6qvja734dyo7be35nzy5lo4sw4dcniaqicqb3o5l@gabq5adeliha>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
 <03240fae-544f-4753-96c5-a116b4b5a318@suse.de>
 <20250915-active-placid-bustard-6e1faa@penduick>
 <2ry3txigq3jyivtyz7i4c76g74vdgvlozsjkeswxalhu2vs5yx@jqswyjle632h>
 <20250923-debonair-earwig-of-abracadabra-940fa8@penduick>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923-debonair-earwig-of-abracadabra-940fa8@penduick>
X-Proofpoint-ORIG-GUID: 6pwXv-jEEHevDDiz9aidjbxN6Tko-1Qi
X-Proofpoint-GUID: 6pwXv-jEEHevDDiz9aidjbxN6Tko-1Qi
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d2766e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=dLeCnL7T2w2gXzoZ4OcA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfXwZSc3j7alSzm
 jYAOl1rj9ZjD0XjNsxgHTU7jKklY7vz2rZPIZMRy+Ozcte/Kaz/611tJXkbtJiaOwxWty+C7A0k
 661s6pX6kLZEUvkzsL/r+dff+4Phrjvn8o6UT2HnI32Kr5vxhIUk+ALiBWW0N3dcY4MYt0ZU9YE
 vkkGeeCoTOls1ifrkZuGFYCJIBw5S99yMkRG6JbF6IegQNHjP4YNx1dLmpmbGN4JOuf7qDyLhmt
 tROQNViOKojm9U5TYMmFX/LLW7eNfY8NHBtVjWbdjai+gVQFBailhxHBTMzahGOqvlrwy1P4zRr
 M35zhhQO+SDPJ1FHVwYd8OtA1i16F5X3VQDg0JCZcJhTU8Crj4bAaOtcxf8d6hlucX+mREdg5vv
 WTFKwftZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Tue, Sep 23, 2025 at 11:38:17AM +0200, Maxime Ripard wrote:
> On Mon, Sep 15, 2025 at 09:38:44PM +0300, Dmitry Baryshkov wrote:
> > On Mon, Sep 15, 2025 at 10:42:22AM +0200, Maxime Ripard wrote:
> > > Hi Tohmas,
> > > 
> > > On Tue, Sep 02, 2025 at 03:44:54PM +0200, Thomas Zimmermann wrote:
> > > > > +/**
> > > > > + * drm_atomic_build_readout_state - Creates an initial state from the hardware
> > > > > + * @dev: DRM device to build the state for
> > > > > + *
> > > > > + * This function allocates a &struct drm_atomic_state, calls the
> > > > > + * atomic_readout_state callbacks, and fills the global state old states
> > > > > + * by what the callbacks returned.
> > > > > + *
> > > > > + * Returns:
> > > > > + *
> > > > > + * A partially initialized &struct drm_atomic_state on success, an error
> > > > > + * pointer otherwise.
> > > > > + */
> > > > > +static struct drm_atomic_state *
> > > > > +drm_atomic_build_readout_state(struct drm_device *dev)
> > > > > +{
> > > > > +	struct drm_connector_list_iter conn_iter;
> > > > > +	struct drm_atomic_state *state;
> > > > > +	struct drm_mode_config *config =
> > > > > +		&dev->mode_config;
> > > > > +	struct drm_connector *connector;
> > > > > +	struct drm_printer p =
> > > > > +		drm_info_printer(dev->dev);
> > > > > +	struct drm_encoder *encoder;
> > > > > +	struct drm_plane *plane;
> > > > > +	struct drm_crtc *crtc;
> > > > > +	int ret;
> > > > > +
> > > > > +	drm_dbg_kms(dev, "Starting to build atomic state from hardware state.\n");
> > > > > +
> > > > > +	state = drm_atomic_state_alloc(dev);
> > > > > +	if (WARN_ON(!state))
> > > > > +		return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > +	state->connectors = kcalloc(config->num_connector, sizeof(*state->connectors), GFP_KERNEL);
> > > > > +	if (WARN_ON(!state->connectors)) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto err_state_put;
> > > > > +	}
> > > > > +
> > > > > +	state->private_objs = kcalloc(count_private_obj(dev), sizeof(*state->private_objs), GFP_KERNEL);
> > > > > +	if (WARN_ON(!state->private_objs)) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto err_state_put;
> > > > > +	}
> > > > > +
> > > > > +	drm_for_each_crtc(crtc, dev) {
> > > > > +		const struct drm_crtc_funcs *crtc_funcs =
> > > > > +			crtc->funcs;
> > > > > +		struct drm_crtc_state *crtc_state;
> > > > > +
> > > > > +		drm_dbg_kms(dev, "Initializing CRTC %s state.\n", crtc->name);
> > > > > +
> > > > > +		if (crtc_funcs->atomic_readout_state) {
> > > > > +			crtc_state = crtc_funcs->atomic_readout_state(crtc);
> > > > > +		} else if (crtc_funcs->reset) {
> > > > > +			crtc_funcs->reset(crtc);
> > > > > +
> > > > > +			/*
> > > > > +			 * We don't want to set crtc->state field yet. Let's save and clear it up.
> > > > > +			 */
> > > > > +			crtc_state = crtc->state;
> > > > > +			crtc->state = NULL;
> > > > 
> > > > Chancing the crtc->state pointer behind the back of the reset callback seems
> > > > fragile. We never how if some other piece of the driver refers to it
> > > > (although illegally).
> > > 
> > > I agree that it's clunky. I'm not sure who would use it at this point
> > > though: we're in the middle of the drm_mode_config_reset(), so the
> > > drivers' involvement is pretty minimal.
> > > 
> > > I did wonder if changing reset to return the object instead of setting
> > > $OBJECT->state would be a better interface?
> > > 
> > > > For now, wouldn't it be better to require a read-out helper for all elements
> > > > of the driver's mode-setting pipeline?  The trivial implementation would
> > > > copy the existing reset function and keep crtc->state to NULL.
> > > 
> > > I also considered that, but I'm not sure we can expect bridges to have
> > > readout hooks filled for every configuration in the wild.
> > > 
> > > But maybe we can look during drm_mode_config_reset() at whether all the
> > > objects have their hook filled, and if not fall back on reset for
> > > everything.
> > > 
> > > It would make the implementation easier, but missing bridges
> > > implementations would trigger a mode change when it might actually work
> > > just fine since bridge state is pretty minimal.
> > 
> > DP bridge drivers have a pretty big state (DPCD and all the features).
> 
> I meant drm_bridge_state. Subclasses would have their own implementation
> anyway.
> 
> > Other bridge drivers randomly leak state to the non-state structs.
> 
> I'm not sure what you mean by that though. Can you expand?

I think I've seen bridge drivers which stored subclassed drm_bridge
instead of drm_bridge_state or stored the data in the long-living data
structures. YEs, that's a bug, which should be fixed on its own.



-- 
With best wishes
Dmitry

