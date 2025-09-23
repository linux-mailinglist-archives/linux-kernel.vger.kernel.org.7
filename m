Return-Path: <linux-kernel+bounces-828684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D1B95314
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D602F17187A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B3430F547;
	Tue, 23 Sep 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoGDgFtM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EEB2F0694
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618959; cv=none; b=FWFMWRMge92bTOP8m2l7kiRp375hoKtr8PhtVZLJ15GKl1Nit5ZRR4ksniuJ8jiCH8cqFjtcY4Uq/zzxISJIbWEe5GVKHRetPFt+7gD5wGPe36OrqeVrDTgBgXA8gApODMVRKHnPkTnwA/jfnnabGCVGMM2efKYoqS5WtK7PA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618959; c=relaxed/simple;
	bh=r4W0Q7yRk/k7WLrEVInb2E7qxaBJKWjWLrpOkCyodBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plpZzawqfvEBz1MnhH8Wq3y28vOsfKm2MW6p8yK1wkfhuWt0JQkxEmSSB+o1RMVlieSTXRiO4iQJ/3n3dfuZY2o6duaZD+uv/PJWY0+6ctFnmm7zvB76J2zSfWXEqkPX49i1GLJ+bbM7jljjk9MKo9Yfr0pyP/ATtDKFsJsAhaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoGDgFtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1553C4CEF5;
	Tue, 23 Sep 2025 09:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758618958;
	bh=r4W0Q7yRk/k7WLrEVInb2E7qxaBJKWjWLrpOkCyodBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoGDgFtMQq48xPvsST4FJIg46n8eXsOuP9ExIEtGDHMeBSocOKY1xAxDi+Vwzkz3B
	 nyLRFTPQG2AHLGiQ5LkzSyDlmgkZY5B6wKs7RUhzbuJNyTMBHFvPGezBjF+ffVUwB1
	 AZhdM9fGHLC+YH6AR1KFZQkJahAIJq7lPfEXVmWeWB5MFeNamh+IKKkBHFe97WepYl
	 oQGjz1PdSrrUpHzLOR3onl3QMfQP7yJOO2wRlFeYMYk0uH/AmvUF7t+EGB8nuN0DOR
	 3RIf87V6F1loyQ5nZcMTZQY6eyhLXFLmUNWqdI5zcXvsarigqZIRGG4wsOZwYQoDSD
	 I4pA/yjUWybOA==
Date: Tue, 23 Sep 2025 11:15:55 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/29] drm: Implement state readout support
Message-ID: <20250923-spry-aloof-bullfrog-4febcc@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <abd349f5-48eb-4646-aca3-d70dd9f4bff0@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="v2ib37ztbiu2x2yg"
Content-Disposition: inline
In-Reply-To: <abd349f5-48eb-4646-aca3-d70dd9f4bff0@suse.de>


--v2ib37ztbiu2x2yg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/29] drm: Implement state readout support
MIME-Version: 1.0

Hi Thomas,

On Tue, Sep 02, 2025 at 04:13:21PM +0200, Thomas Zimmermann wrote:
> Hi Maxime,
>=20
> there are a number of patches in this series that can be merged immediate=
ly,
> and likely should.

Ack, I'll do a first pass to apply the preliminary patches if (or when)
they get reviewed.

> Is the state-compare code really necessary? Doing this separately might e=
ase
> the review.

My understanding was that Sima wanted to be part of it, but I guess we
can introduce it later on if she agrees.

Maxime

--v2ib37ztbiu2x2yg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNJlSgAKCRAnX84Zoj2+
dg6/AYCLCBl5ysWRKi5mZbcjC5DsuKSAFM3rLn2lnmfAyFAr92hsAJ6rGxHuUd6Q
SYmr8ocBf0JO+ObyHDBSZ3MjWrzUJbbxREa2/2dgEuw6K6wK4JPF0bQLWr87nEE2
+04R+tcmpA==
=CCPk
-----END PGP SIGNATURE-----

--v2ib37ztbiu2x2yg--

