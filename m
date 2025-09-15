Return-Path: <linux-kernel+bounces-817639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0104B584CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A861A27E67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964C280327;
	Mon, 15 Sep 2025 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCgf5fI7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8071E1A3D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961664; cv=none; b=AN+mE0tLycE1o3JpaE544osFUXeq81U21xnXObLGLdmuI9H+QIm+5jIRx+XdH7ynP96r1nbREf3eaW0TClhMO6wmfGV/RCIoaoO58u6zjzfswisGhgCBi8da5chnnFjpNicCX8ifm5ZDIG5s6V0FsGUBjPgGyoT1yPr71h9/DzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961664; c=relaxed/simple;
	bh=KZP+TrVDa2mVg5swamZhXIKeV5ub+2+6pTwADOsgmwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N16pK3EOED/BI1NP35eD91fHWYqIBsqlu0SRVWkURQI25xLM4IbhoBVmkruVuo/jYqU5kJZPbCXMRGkXpu9qfcfrEzS0oaAsbNtguJ5pQ1ytPGtjzzOWOHyD4aaSu/TV6z82eIXVxQPB7sZJ3OKReJ/fhTO8OulFchU9NxBtts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCgf5fI7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FGJQ4E005036
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ljYBCGgfSqSCfxyG4JU8mZuZ
	nMjA7d2IeNHfomCZO2E=; b=kCgf5fI7kztNRrUDyuQZ4glDS6gFDqf86UUOpoNp
	TomWFzUUXpi5Su/qJU52IhNKGBtUfE+o2R6DQosAz8cvX0XF5v5SN9ncZzAY7yXH
	Gj97wANRKfgJhX1E4EWSKU446A5LKmD9MG4RxVKsM5slsysV5G39VMnewcc+5q5x
	2sxWW+KOKezJRhEJmQNBD+jqnlyXOj/PyvydaXBNw2KqpANxalZSjvCs6KmcQuEc
	kzrRBitxXtOE0P2HsaO0A3Uev2KfWBhnTGsx5wViB7wUJvizYCV1Yr6137udEoud
	fJrWVotLmcr1B34Qq0ZTLHmlBI6+FBuyi/03p5vAHCpw1Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g12ht9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:41:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-771c686372bso50651416d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961661; x=1758566461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljYBCGgfSqSCfxyG4JU8mZuZnMjA7d2IeNHfomCZO2E=;
        b=YnmwUNwzaIG7SRB+wB4SXqfD2o2oOr1x27WLHqDUihmXtLZhMMuiKOrH2fz5iBR/i+
         TB8YGW08gVuouydCU4NpRshxpVK2OLC/juImzj2VQ7QZEZBQMMEV0e7sZ5b17xpbtnV+
         tIlF6d2rGYbfo/5KEgMk9fL82rA3duG+Sp5OpV7UWEeUYC30l1hDAo68XovK06qPpXYj
         V0hGcSc5EMsAsrZYZ85NPuu8h4FxII70y0I+HdtXetDy8LcQiu/ecO8gKQJP7/m9FLO9
         vZ3X1wkkF9HTuu3WUIImwMbv32tVQAoat8oKRk91PEb1/Bwr/3k0Mun9bWqzjgwqkHwO
         Uzjw==
X-Forwarded-Encrypted: i=1; AJvYcCXD03iyy4NkfuMcwgfGbyJDsqoRPPvc+8KzyAZcXTJW4Xz1K+E+Lf2s9hNbM7z+BMPNfZy1IS/3EMrRKtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+4hEcaJF8bVg8tsdRzHwlCmnNcbvom6fI6Qvygqswop7a/db
	oV3cn5ZD4Wn+OPNHX0ul9+INrbOJG1MXFXujswYD+0aG6d22g2zsuf85NeQ81Mp4IkdRK/RWgiN
	CVWG3H/ODAB8hD5Mfk26hS66iZtbxdDVL0LeJBcC3qZgTohY6ZK0Q2MocxX3suz6HQts=
X-Gm-Gg: ASbGncs0fUVDhuZtor9iuKbl9A0dFkqFzI0705UYJsICq1pggbLrfnA7Fee4GfW6hk3
	F2pInZw4WOLbT8dymmcYsXAmxgUG5zszddsqFCnPnd5YaUQgmm0JrqJG4XI2JUSmaenqajOCFiY
	DUGKlCKKf2sBRNGUFnROTa3oTv1EaH+NMiU2EfKHhYD0v1aXL+cussi+/rVrX3b+AWrm/LNEGus
	B2kxo1zB3m+udThOzDCD8/JU4+pcCQdhLN8o+9f/dmIBh+9OCk1GEiGfUnatgl7bqp8j4Esb+IX
	0BOc0MZ719nWknUIB/AoFLG/aPttSb+HTCCl7I66xObocdfwiDHTMUrcAScJlVcBCvdbqnBvlmh
	M40UY1+3C4gL9jGA789+v+nKALgjV9U+7Ll5fS1KfoKr42+frr13H
X-Received: by 2002:a05:6214:1d09:b0:782:9454:ac7e with SMTP id 6a1803df08f44-7829454aefemr59893106d6.59.1757961660731;
        Mon, 15 Sep 2025 11:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ4P3hm3uzEP1hH4FxW3UdAgtApBC+WtCcYWvJh9nalHV5TC8f6T/4n1Oj9rePwfPz2OQYIQ==
X-Received: by 2002:a05:6214:1d09:b0:782:9454:ac7e with SMTP id 6a1803df08f44-7829454aefemr59892716d6.59.1757961660101;
        Mon, 15 Sep 2025 11:41:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1be24e79sm29178661fa.59.2025.09.15.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:40:59 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:40:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
Message-ID: <zvqtehg66dbrrdmik6ylo2kdk74umfzo5hbfkizwsb352nlyqv@jgouvmbfwa4x>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
X-Proofpoint-ORIG-GUID: f3lggWjReObu4UFaeNczotDv7UcWjnl4
X-Proofpoint-GUID: f3lggWjReObu4UFaeNczotDv7UcWjnl4
X-Authority-Analysis: v=2.4 cv=E5PNpbdl c=1 sm=1 tr=0 ts=68c85dbe cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=je0mVrs27Alq3b4RgjgA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX8OaXOHPFH4Lk
 mUReDl+NfBQMyIxiigQyfJw2VJdBEmE4kdGVXgMTCkUJESd1t+FMjpgtJJw8HJrOKslp5N8zUOl
 oxqzl3xue9hznSGdKPQ6LA0aBNV3idX87g8++orWoJafwOoSGJ9S78Jwo4M1AfY62BXVOFpCEM7
 mgUlSgRzC2bngFMCEGWEcmZYcjqdX6MS4LKuyABEE+16NivjVJzZLboTrFkSRzt0Ce42NUbkYLr
 om/dkNW7wNMG3BRVK/qd8cwtf6EbiW6LKW+AHOKhvuIlAlTdwPmsh5UulNa1DyDcL30up1TVVQj
 oHVLw9Me+tQJiijLzlFBYkAQMJk0T4fImOFrLw8xi9wxN4C1oaQTjH19CSki+PUtmTH24u9fViI
 8AncMtsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

On Tue, Sep 02, 2025 at 10:32:38AM +0200, Maxime Ripard wrote:
> In order to enable drivers to fill their initial state from the hardware
> state, we need to provide an alternative atomic_reset helper.
> 
> This helper relies on each state having its own atomic_state_readout()
> hooks. Each component will thus be able to fill the initial state based
> on what they can figure out from the hardware.
> 
> It also allocates a dummy drm_atomic_state to glue the whole thing
> together so atomic_state_readout implementations can still figure out
> the state of other related entities.
> 
> Link: https://lore.kernel.org/dri-devel/CAKMK7uHtqHy_oz4W7F+hmp9iqp7W5Ra8CxPvJ=9BwmvfU-O0gg@mail.gmail.com/
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 382 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_mode_config.c   |   1 +
>  include/drm/drm_atomic_helper.h     |   1 +
>  include/drm/drm_bridge.h            |  21 ++
>  include/drm/drm_connector.h         |  26 +++
>  include/drm/drm_crtc.h              |  19 ++
>  include/drm/drm_plane.h             |  27 +++
>  7 files changed, 477 insertions(+)
> 
> +	drm_for_each_encoder(encoder, dev) {
> +		struct drm_connector_state *enc_conn_state;
> +		struct drm_crtc_state *enc_crtc_state;
> +		struct drm_bridge *bridge;
> +
> +		/*
> +		 * It works a bit differently for bridges. Because they are
> +		 * using a drm_private_state, and because
> +		 * drm_atomic_private_obj_init() asks for its initial state when
> +		 * initializing, instead of doing it later on through a reset
> +		 * call like the other entities, we can't have reset xor
> +		 * readout.

Would it make sense to unify the way the bridges / priv_obj handle the
state with the rest of the object types?

> +		 *
> +		 * We'll need a mandatory reset to create that initial, blank,
> +		 * state, and then readout will fill that state later on if the
> +		 * driver implements it.
> +		 *
> +		 * This also means we don't need to call the readout state
> +		 * function if we don't have the bridge enabled (ie, if no
> +		 * drm_connector_state->best_encoder points to bridge->encoder,
> +		 * and / or if drm_connector_state->crtc is NULL).
> +		 *
> +		 * In such a case, we would get the blank state reset created
> +		 * during registration.
> +		 */
> +
> +		enc_conn_state = find_connector_state_for_encoder(state, encoder);
> +		if (!enc_conn_state)
> +			continue;
> +
> +		enc_crtc_state = drm_atomic_get_old_crtc_state(state, enc_conn_state->crtc);
> +		if (!enc_crtc_state)
> +			continue;
> +
> +		list_for_each_entry(bridge, &encoder->bridge_chain, chain_node) {
> +			const struct drm_bridge_funcs *bridge_funcs = bridge->funcs;
> +			struct drm_bridge_state *bridge_state;
> +
> +			bridge_state = drm_bridge_get_current_state(bridge);
> +			if (WARN_ON(!bridge_state)) {
> +				ret = -EINVAL;
> +				goto err_state_put;
> +			}
> +
> +			if (bridge_funcs->atomic_readout_state) {
> +				ret = bridge_funcs->atomic_readout_state(bridge,
> +									 bridge_state,
> +									 enc_crtc_state,
> +									 enc_conn_state);
> +				if (WARN_ON(ret))
> +					goto err_state_put;
> +			}
> +
> +			drm_atomic_set_old_bridge_state(state, bridge, bridge_state);
> +		}
> +	}
> +

-- 
With best wishes
Dmitry

