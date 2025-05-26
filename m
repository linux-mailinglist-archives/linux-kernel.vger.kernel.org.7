Return-Path: <linux-kernel+bounces-663181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 106AAAC44AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 23:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2CF3BB425
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 21:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7C41DE3BE;
	Mon, 26 May 2025 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="JFM4E4uW";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="avm+Govr"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC88C120
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748294170; cv=pass; b=AFuhix2cbbQbZo/zM8ZvHiprHqHjaMcctGWENcbDbEFUuK57Ow3sFh5F9ScVk4bVp3NrQm4kZ4DtO/QfzQB78KLDwtMqcVm5EVInfKUtf9ogu0Bs3D3pntB25wecUBt0b+Ko+Cmr+8uX6YN6e0eAwRnxXAjUUiD1x0TazUdTGtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748294170; c=relaxed/simple;
	bh=5kG/q9PVvle8mmD+HvY+yY22kbs17cbhqjTvD5A5A8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrKk5rvJBM2EiyVqj8IXjea83RcS8ezl/hCJpqkHKj+4r6RoiEieRuu6Qe8muiJjxgGugP8CilBO7fTHOFZ8KxOrUFIQjI4tOWfQAbRuE//PGpTY7IFP+OPpxpJB1gD7uxw67GvUAs7fuqwu9IrK9mh6Ny4OIKivELgbpgyyFi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=fossekall.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=JFM4E4uW; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=avm+Govr; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fossekall.de
ARC-Seal: i=1; a=rsa-sha256; t=1748293984; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SBnCxxSXiIiddnKsNUoos8EzazWtIvC4bKbWPUepcnmdhmXdHyJi8hPakBcnU7kHLV
    1FH5Z83svo2oEQFRPYmvgJI37fZjG2rwiJhy7HsneKGaOgZuYb3fpp4fzv6Ix79ZCyv5
    5I2AVD8CGGlmj3N1cqi9jz2qnzK9izi7HjDKtDa3Vqjf5uD+LinpXpvg8RIiP4XhMxYE
    s6uH2RutFF9AlHkJB2CGpynPnTNUN3479IG47Vfhj+WuKF6leMwJxXcolQ8LICmPPHWi
    1yOIRzD853qP4Gr5NfJKKKPM8hb65JCdhTwdW/CM1Y+Ehmvy5KBKoWl8VI14x1mo2TqY
    tUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748293984;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AVwR3RqXfhEXlhoGhmwUftz4FLAY7joifHIAsoI1opk=;
    b=OvFyu0tIjcvYj39AWAaPt7ni0JoeD6LVrR7n650YRZzHcdXAZCSXmod9hGXMHs/mmq
    jIe1OFQAEDuFeDJRoLAD+m1093+HWk/mYBEjJbUxkkG2osuNFgYTH0QVAXedz1tikvdc
    PwNVQIQSLaWW5HWAID7+0XwpLB4g6PYIVC3r/ZFsANctmHz89HIMjvdIIP3jf4qpo44V
    YxJdqXYBkI+sINKQ7vTFr+bdkBIqWdzBD/awRVrg6iI0p28vEyQvO411OKNxH/DwxaV5
    3v2aonPLcLUu21m/zZTuMOC/vwOcZ8DQYjrp2EWhVRTgwWLh2cBpRGKzgsmIuHKfIFXD
    TGow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748293984;
    s=strato-dkim-0002; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AVwR3RqXfhEXlhoGhmwUftz4FLAY7joifHIAsoI1opk=;
    b=JFM4E4uWQrv7IX07x09XDxvaleGSg846j1gzsnGypyamNDo0kP8UKj9pHKHgHS80G2
    wFEaccJ6FLcGXlYnoT0gSshqnBWB2GBcTSrg598ktHY/O7mVfp0l9y36RGTU16m4qviK
    7zvqx20kzI0G9brqLkMt2kn/TW9NPps/sR8ig786i/brSpbrRdDelRBSgkV6iZEhz9AE
    Bsi5qgRZztzaogMEu4sSnUnV5ixy2DY3dED28gZIm1eRj10N6umG5McmY8sCD916Tc8A
    fWPKzm+Whivq9kQmjl94VChlLILuGoHSj4VC9bwnpHgSONZ2yzZJOiXKA7GJZPm8L/5s
    W0nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748293984;
    s=strato-dkim-0003; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AVwR3RqXfhEXlhoGhmwUftz4FLAY7joifHIAsoI1opk=;
    b=avm+GovrShQDZ5jb9fbwW3Txdkh+3LcP/cFmWcO5Jq1kKqSnyvhDQH/VtyYZvzOHsG
    PvVYJwo4CElmkKKajlAQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3514QLD3ZDy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 May 2025 23:13:03 +0200 (CEST)
Received: from koltrast.home ([192.168.1.32] helo=a98shuttle.de)
	by aerfugl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <michael@fossekall.de>)
	id 1uJf83-0001y1-0A;
	Mon, 26 May 2025 23:13:03 +0200
Date: Mon, 26 May 2025 23:13:01 +0200
From: Michael <michael@fossekall.de>
To: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] [BISECTED] drm/sun4i: hdmi: No HDMI output with
 BananaPI M1 on 6.9
Message-ID: <aDTZXagQ28OdNtLh@a98shuttle.de>
References: <aCJZmm8rC0RwbcBX@a98shuttle.de>
 <20250526-refined-dog-of-blizzard-b48f11@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250526-refined-dog-of-blizzard-b48f11@houat>
Content-Transfer-Encoding: 7bit

Hi,

On Mon, May 26, 2025 at 07:30:35PM +0200, Maxime Ripard wrote:
>On Mon, May 12, 2025 at 10:27:06PM +0200, Michael wrote:
>> with v6.9 and later there is no output on the BananaPI HDMI connector.
>>
>> I have bisected the issue to the following commit:
>>
>>   358e76fd613a ("drm/sun4i: hdmi: Consolidate atomic_check and mode_valid")
>>
>> With this patch, sun4i_hdmi_connector_clock_valid() is occasionally called
>> with clock=0, causing the function to return MODE_NOCLOCK.
>> In the old sun4i_hdmi_mode_valid() before the patch, mode->clock is
>> always!=0, maybe that gives someone a hint.
>
>This doesn't make sense to me, if only because the two callers of
>tmds_char_rate_valid (hdmi_compute_clock and
>drm_hdmi_connector_mode_valid) have, right before calling it, checks to
>make sure the clock rate isn't 0, and would return MODE_ERROR or EINVAL
>in such a case.
>
>https://elixir.bootlin.com/linux/v6.15/source/drivers/gpu/drm/display/drm_hdmi_state_helper.c#L234
>https://elixir.bootlin.com/linux/v6.15/source/drivers/gpu/drm/display/drm_hdmi_state_helper.c#L553

Before 6.14, sun4i_hdmi_connector_clock_valid() was also called from 
sun4i_hdmi_connector_atomic_check()...

>Do you have some logs (with dri.devel=0xff)? Does it happen with 6.15 as
>well?

It does not happen with 6.15, as it was fixed in 6.14 with 84e541b1e58e 
("drm/sun4i: use drm_atomic_helper_connector_hdmi_check()").

For completeness:

358e76fd613a:

[    1.091807] sun4i-drm display-engine: [drm:drm_atomic_check_only] checking (ptrval)
[    1.091850] sun4i-drm display-engine: [drm:drm_atomic_helper_check_modeset] [CRTC:47:crtc-0] mode changed
[    1.091876] sun4i-drm display-engine: [drm:drm_atomic_helper_check_modeset] [CRTC:47:crtc-0] enable changed
[    1.091898] sun4i-drm display-engine: [drm:drm_atomic_helper_check_modeset] [CRTC:47:crtc-0] active changed
[    1.091927] sun4i-drm display-engine: [drm:drm_atomic_helper_check_modeset] Updating routing for [CONNECTOR:66:HDMI-A-1]
[    1.091953] sun4i-drm display-engine: [drm:drm_atomic_helper_check_modeset] [CONNECTOR:66:HDMI-A-1] using [ENCODER:65:TMDS-65] on [CRTC:47:crtc-0]
[    1.092019] sun4i-drm display-engine: [drm:drm_atomic_helper_check_modeset] [CONNECTOR:66:HDMI-A-1] driver check failed
[    1.092042] sun4i-drm display-engine: [drm:drm_atomic_check_only] atomic driver check for (ptrval) failed: -22
[    1.092070] sun4i-drm display-engine: [drm:drm_atomic_state_default_clear] Clearing atomic state (ptrval)

358e76fd613a^ :

[   14.402623] sun4i-drm display-engine: [drm] 	crtc=crtc-0
[   14.402630] sun4i-drm display-engine: [drm] 	self_refresh_aware=0
[   14.402638] sun4i-drm display-engine: [drm] 	max_requested_bpc=0
[   14.402647] sun4i-drm display-engine: [drm] 	colorspace=Default
[   14.402657] sun4i-drm display-engine: [drm:drm_atomic_check_only] checking 31bd6e91
[   14.402714] sun4i-drm display-engine: [drm:drm_atomic_helper_check_modeset] Updating routing for [CONNECTOR:66:HDMI-A-1]
[   14.402741] sun4i-drm display-engine: [drm:drm_atomic_helper_check_modeset] [CONNECTOR:66:HDMI-A-1] keeps [ENCODER:65:TMDS-65], now on [CRTC:47:crtc-0]
[   14.402767] sun4i-drm display-engine: [drm:drm_atomic_add_encoder_bridges] Adding all bridges for [encoder:65:TMDS-65] to 31bd6e91
[   14.402792] sun4i-drm display-engine: [drm:drm_atomic_add_encoder_bridges] Adding all bridges for [encoder:65:TMDS-65] to 31bd6e91
[   14.402826] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   14.402846] [drm:sun4i_backend_atomic_check] Input size 1024x600, output size 1024x600
[   14.402862] [drm:sun4i_backend_atomic_check] Input size 1024x600, output size 1024x600
[   14.402877] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[   14.402894] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[   14.402906] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[   14.402922] [drm:sun4i_backend_atomic_check] Starting checking our planes

Sorry for the noise :)

>
>Maxime

Michael

#regzbot fix: 84e541b1e58e

