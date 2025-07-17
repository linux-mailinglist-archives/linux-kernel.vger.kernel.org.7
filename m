Return-Path: <linux-kernel+bounces-734866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0214BB08756
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FB77A303C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1E253934;
	Thu, 17 Jul 2025 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+2qY54v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A66FB9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738588; cv=none; b=khZMB6KFUsvdsqiGmsRrjk5MUIB/hH6yh5r2Wwp0NpzCZA7Ya7rSIVKZ1AuE6wajPePhlU8+to/a00zUY79N8QNlk1ndI9kb38FWcVr4Yw34aPRn3hyfjNYNyHxV1vobksusqw6FfcIfkQD3DZnV0NYuJHVDRDusvfaGJhfEUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738588; c=relaxed/simple;
	bh=lCe8k0xLAnoePBb9VOg83ZvZf0tvpcfN4JNOrba3MHE=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=CMLP0HNC+IfpAGV/nhr0hfEdSiic3cBb1HBKFZ6UMVK0zcvtv5v5TP/s4uU+wOCIJRcEjYdIRcB9/X10U0ngOZMe1dFsIdMIiTzwVzH+XftNwbxXRB9TJL39Dr4cW9vAvIr2SBXSz/zaDbiWw98Q9GJNYfvoO2kX+iEA5f+xVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+2qY54v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039F1C4CEE3;
	Thu, 17 Jul 2025 07:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752738588;
	bh=lCe8k0xLAnoePBb9VOg83ZvZf0tvpcfN4JNOrba3MHE=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=d+2qY54vB9fy6aXCceheWQgbYj4RDBbgnnTkd9LQgLT5gM3rXYd8UJY5wruWLbvxs
	 wDWb0+dGU8ZYilizf8HyfMMEyihU5PzM2/0evDvD6RlSPD9S2HaVfqFxFPST74l2lX
	 N7PoRwu0VDlH8fzpvGHEkno8ER8h8N2HxC0aGD/G3zaK6ycEUcqEc7WoNRjZeXi+Wd
	 Nyg+2LjOYTDI0RQWcVreeAJDp3wvjchMYVy+0Ip95WrPvsZpv6HAouzCploJtmsdZr
	 uH30l+1yBhfT3Sk75XFswazp5gfWJLOAhcikgPxIAEuZBJh4/xVauerZB9SngmQcuS
	 FBCBbMiLyvFGA==
Content-Type: multipart/signed;
 boundary=2528c810b34643996ff67ed0beac53f10af6388f53f0aef94521334da5c0;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 17 Jul 2025 09:49:44 +0200
Message-Id: <DBE5Z1SRJ086.NA0KUAWX1MS3@kernel.org>
Cc: "Jyri Sarha" <jyri.sarha@iki.fi>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/tidss: encoder: convert to devm_drm_bridge_alloc()
X-Mailer: aerc 0.16.0
References: <20250716134107.4084945-1-mwalle@kernel.org>
 <20250717094153.35f854b7@booty>
In-Reply-To: <20250717094153.35f854b7@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--2528c810b34643996ff67ed0beac53f10af6388f53f0aef94521334da5c0
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

thanks for taking a look!

> However allocating an encoder using a bridge alloc function (while we
> used to call an encoder allocation function) looks counter-intuitive.
>
> We had discussed on IRC a different idea, adding a wrapper structure
> around the bridge. Quoting your proposal:
>
>   struct tidss_encoder_bridge {
>     struct drm_bridge bridge;
>     struct tidss_encoder *encoder
>   }
>
> and then in the bridge funcs go from drm_bridge to tidss_encoder_brigde
> and use the pointer to get the original private struct.

I was doing that until I've realized that meson/meson_encoder_* is
doing it the way this patch does it.

> That would be cleaner and more intuitive, but use a bit more memory and
> have an additional pointer deref, thus I think we can live with the
> patch you just sent, at least for now.

I'm fine with changing it to the wrapper struct. It's your/the
maintainers call :)

-michael

> In the long term it may be that more and more components of the DRM
> subsystem become dynamically allocated like bridges and panels [0] have
> recently become. So at some point it may make sense to add the bridge
> wrapper struct and then go back to drmm_simple_encoder_alloc() for
> allocation.
>
> [0] https://lore.kernel.org/all/20250331-b4-panel-refcounting-v4-1-dad50c=
60c6c9@redhat.com/
>
> Luca

--2528c810b34643996ff67ed0beac53f10af6388f53f0aef94521334da5c0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaHirGBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hiWAGAjuCe5nmNGmSFueL2hDyFq0YxawTOQe1d
ghvQSekNAqMr2ftu1BvmvDIUvgM3ijp2AX0Uj7SV8d25FWZSiysPfK1GsR59Oatd
fZ2/ldGnjlQzjbFURRkDtjk4mRTJteTVo/Y=
=unKS
-----END PGP SIGNATURE-----

--2528c810b34643996ff67ed0beac53f10af6388f53f0aef94521334da5c0--

