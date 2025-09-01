Return-Path: <linux-kernel+bounces-793939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82DB3DA7E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27231898678
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466AC20FAAB;
	Mon,  1 Sep 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvYft1NT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454B18EB0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710051; cv=none; b=qF47E58UVHWtMWxo3FYZ/bOWQxh6azYncyNMh39dsv7R3sY6/12dbF8YxP2vPoEMWpuo7bCab5UmjUp33SDR2lSPZtJslFAfwAN8r6wEMjwqgcVdMUuczumNP0Yr30fAeD/tqFzwwWc2riEuZgVD9Fm8xM79d4P6vY7OVpN9CLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710051; c=relaxed/simple;
	bh=ZeFbSr4PbTwyBV2OZDCGcrnpJKQZAVSA0iWy33B9hkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvT1M8Mj/CtDnEPC0+901hR3EwHT+mk22SDVuVxUZ5cSlCC+/jY3pCRvV1zDQ7upOfek3GdOkIgcMfNut43Uq66PawRtlzN0HQRf8zPXYv7tnvlY1cBMNZ71kRb2Xxpgmyr1syfokptHv0w+DOnhiM5LbfeSulq2vDJYYteOxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvYft1NT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD57C4CEF0;
	Mon,  1 Sep 2025 07:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756710051;
	bh=ZeFbSr4PbTwyBV2OZDCGcrnpJKQZAVSA0iWy33B9hkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvYft1NTetVSsSX4p5CXUeKpmkLpiMxaAl1TTkydFWd6PqU8Xx1OHJJipNZB9g/hU
	 Q+sRzxY8fnQZMhwPyCihTGDq8ntIem3BjpvVz3NCFdlmwbhqQjDTOmU3um4Rkc2DuE
	 EPrDo+cptEIOJ2PFpAb9Us/eQ7mwmujATMjjfzgCAP3zHBGkNaYE0ijcyE1MfktsR0
	 TVwXkf1mK+aFAUopGFN0I+bjs83gtzJRHDY+Ffqc3I8cI+5ZuU2uqHvRh8VVyXYDby
	 0+iaSjKuzNuUiWOazmYBLsb1G6uBInMMhtu3tteE59SicP/ceX3qoBADDbjW1I4xUt
	 uBotJSPLxSEnA==
Date: Mon, 1 Sep 2025 09:00:48 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: John Ripple <john.ripple@keysight.com>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: break probe dependency loop
Message-ID: <20250901-airborne-marten-of-serendipity-b55e21@houat>
References: <20250820152407.2788495-1-john.ripple@keysight.com>
 <20250820152407.2788495-2-john.ripple@keysight.com>
 <CAD=FV=VfCWFViDE1a5-_KtH0Pfo2EnCJeo2k8MaWuRHhmMPMMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="hoexycmw3smg4mip"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VfCWFViDE1a5-_KtH0Pfo2EnCJeo2k8MaWuRHhmMPMMA@mail.gmail.com>


--hoexycmw3smg4mip
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: break probe dependency loop
MIME-Version: 1.0

On Fri, Aug 29, 2025 at 09:40:30AM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Wed, Aug 20, 2025 at 8:24=E2=80=AFAM John Ripple <john.ripple@keysight=
=2Ecom> wrote:
> >
> > The commit c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our
> > DSI device at probe") was intended to prevent probe ordering issues and
> > created the ti_sn_attach_host function.
> >
> > In practice, I found the following when using the nwl-dsi driver:
> >  - ti_sn_bridge_probe happens and it adds the i2c bridge. Then
> >    ti_sn_attach_host runs (in the ti_sn_bridge_probe function) and fail=
s to
> >    find the dsi host which then returns to ti_sn_bridge_probe and remov=
es
> >    the i2c bridge because of the failure.
> >  - The nwl_dsi_probe then runs and adds dsi host to the host list and t=
hen
> >    looks for the i2c bridge, which is now gone, so it fails. This loop
> >    continues for the entire boot sequence.
>=20
> Which i2c bridge are you talking about? You mean the one created by
> i2c_add_adapter() in drm_dp_aux_register()? I guess I'm confused about
> why the DSI probe routine would even be looking for that adapter.
>=20
> In any case, I don't _think_ your patch is valid. Specifically, if you
> notice ti_sn_attach_host() can return "-EPROBE_DEFER". That's a valid
> error code to return from a probe routine but I don't think it's a
> valid error code to return from a bridge attach function, is it?

It's not documented anywhere though, so we'd need to document (and
assess) if it's acceptable first.

We should also amend
https://docs.kernel.org/gpu/drm-kms-helpers.html#special-care-with-mipi-dsi=
-bridges

Maxime

--hoexycmw3smg4mip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLVEoAAKCRAnX84Zoj2+
dupqAX40hRyvkHZyIYywMCfPVV2IAYd6DnoXJ6H/p4qb5Xz2UwikqugDDzxJcmJ1
qaDvsaUBf2sKrCfvVaAcGQ3ULwYe+Zs3Aa4WJtjToWES91VYZVPd2gULYsnDqmP2
DNZQNQ6AtA==
=1bEs
-----END PGP SIGNATURE-----

--hoexycmw3smg4mip--

