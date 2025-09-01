Return-Path: <linux-kernel+bounces-793890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80510B3D9C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B32617A00A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2255E246770;
	Mon,  1 Sep 2025 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPOR8vdC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F518EB0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707624; cv=none; b=UKfVH7pJ/DV3coq7yuTnpEkKsCrgJRgID5SU5TYSaptmnWn069Yo++pEzAz/ifJO3bzRxc2MNKtxQpJ5uVa2SoX5ofLC+XUHZGlVKFb67Ty+Gm6LcjhaueaBLUJJIjuUW9I1D9woF40pvuirWBRECky+nGl7DA+3OlQwYa8ohoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707624; c=relaxed/simple;
	bh=+Ueec6t83OWJF3k7tHZt6/fcZU8oeWGgL0qu2zp6ws4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=FN/0VAyX5XZV8ahClDT/7dbA9sYszyKBEo7dvO6vDhCTTsYT9yDj+dp+hnsc43bcNWJQfJfKSxSWvfQSitJj1nz0bbVRN6mQjixSsEZsKC9AHPqJFuJJU54NESTeYeVPF0/0xTDFDITdNSKj49vBBxX5HJk25bP2Ah9TaMmyccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPOR8vdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0CBC4CEF0;
	Mon,  1 Sep 2025 06:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756707624;
	bh=+Ueec6t83OWJF3k7tHZt6/fcZU8oeWGgL0qu2zp6ws4=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=DPOR8vdCFImIed5vqRWeN8lwJCnyEw+WEzf3y685ZXhP5eSidPaoB5GIHrC0atCkz
	 4+gKU3s1AtJE/SCRr8eSwJwDJHU+qnWqJilr7AjWYPlEgTg7XUtZMKGK1bnU2eg5Xx
	 JhfTWYmop5673CK3f8qhwcjkjUXWne898FNfyuFimj/RgzRbb9tDklgPywblx8E3UT
	 nIxeYW/q6QTkxsA4mVh17SVrwisw96y9XX13gOTyjcp1sEPQVnOMCKJvzHqtn5uxJq
	 e0lSsIX7nSgTRQ2hpnXboMkDSEUpjfUVauFSUnmoReXjw3RwNSUP8v7m3OGFYQt4wu
	 NsEsRpz/H8Bmw==
Content-Type: multipart/signed;
 boundary=682104e96c29f8012d4fb844ebf0d9c883ce3dc154d455a174da7b9dfef1;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 01 Sep 2025 08:20:19 +0200
Message-Id: <DCH8VNHTN1LM.3068OZU8IMK3Q@kernel.org>
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: fix REFCLK setting
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Devarsh
 Thakkar" <devarsht@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Doug Anderson" <dianders@chromium.org>
X-Mailer: aerc 0.16.0
References: <20250821122341.1257286-1-mwalle@kernel.org>
 <CAD=FV=Xt-DPHRddZM=t-KTWiGouNfm_QpPps3MA6csd+j=YO+A@mail.gmail.com>
 <CAD=FV=XCOPeEgpjvCuDjT=OjEk1P8vszL6iJqkY-DcpXtpXTjA@mail.gmail.com>
In-Reply-To: <CAD=FV=XCOPeEgpjvCuDjT=OjEk1P8vszL6iJqkY-DcpXtpXTjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--682104e96c29f8012d4fb844ebf0d9c883ce3dc154d455a174da7b9dfef1
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Aug 29, 2025 at 12:52 AM CEST, Doug Anderson wrote:
> > On Thu, Aug 21, 2025 at 5:23=E2=80=AFAM Michael Walle <mwalle@kernel.or=
g> wrote:
> > >
> > > The bridge has three bootstrap pins which are sampled to determine th=
e
> > > frequency of the external reference clock. The driver will also
> > > (over)write that setting. But it seems this is racy after the bridge =
is
> > > enabled. It was observed that although the driver write the correct
> > > value (by sniffing on the I2C bus), the register has the wrong value.
> > > The datasheet states that the GPIO lines have to be stable for at lea=
st
> > > 5us after asserting the EN signal. Thus, there seems to be some logic
> > > which samples the GPIO lines and this logic appears to overwrite the
> > > register value which was set by the driver. Waiting 20us after
> > > asserting the EN line resolves this issue.
> > >
> > > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > nit: officially you're supposed to move your Signed-off-by all the way
> > at the bottom of all the other tags any time you post a patch. I don't
> > think it's important enough to re-send, though.
> >
> > In any case, thanks for re-posting. I guess it kinda stagnated. I'll
> > give this another week on the list and then plan to apply to
> > drm-misc-fixes unless there are any other comments.
>
> I realized that this is lacking a Fixes: tag. I went back and
> confirmed that even in the first version of the driver, AKA commit
> a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver"),
> we still had no delay between these two lines:
>
> pm_runtime_get_sync(pdata->dev);
>
> /* configure bridge ref_clk */
> ti_sn_bridge_set_refclk_freq(pdata);
>
> ...and the last line of the runtime resume function was turning on the
> enable. So I believe this means that the bug has always been there.
> Does that sound right to others? If so, I'll add that Fixes tag when
> applying.,..

Yes, that's right. Thanks for amending the patch.

-michael

--682104e96c29f8012d4fb844ebf0d9c883ce3dc154d455a174da7b9dfef1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaLU7JBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j4RAGAnUlorq1ruoUXSrDpLf3RlZnc/e3t9Nt2
P2IgL7Nj3zxtBLDXprxO3jMP4bfu07CEAYCYZW3ZN5wl/85JGbuMBAM7/L8ZT4dN
69oEiasczPIdwr6g+vPpUaemZ1PgMTgbW5g=
=FEW4
-----END PGP SIGNATURE-----

--682104e96c29f8012d4fb844ebf0d9c883ce3dc154d455a174da7b9dfef1--

