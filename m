Return-Path: <linux-kernel+bounces-874031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5524C155A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DAA1B2128C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C164341AC8;
	Tue, 28 Oct 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbKhzdPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE33340DA1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664096; cv=none; b=MT6RHKlyuUkhaewTFiRyt3WXLkTfxxQ0QqWNzfHnrULh/fIc38BkioVW/PSaBKAYR/3tfuxeTjUjrvXHAwRQqXDW2xcqonQX4auUGf4Du2zNWTLAtzy5xj+HRKCDoA2ryyoPaJ2CG5SQGD5Qjp59JaqRZ+BI9eItuIB91ij5ssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664096; c=relaxed/simple;
	bh=nC5h8Ln9RiB4A32t/cW1wNQwvbwaWDrUshVJEGXjFc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNXGwlYeryFWICsbEq2dki+YawWjOg/jgYdqmmPaxPqgkqkDEsnz2pX+qaM+zyZrGkq4RbCMkaDwXAwsWEjA+M6NA3yTo4QdPIQES8VgRo4PMBDjZtxDPbVLhZS2AJeks2nO1snKDxtXxIlScabG9Uxt6ks7I87t0fCalzuExCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbKhzdPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD92C4CEE7;
	Tue, 28 Oct 2025 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761664096;
	bh=nC5h8Ln9RiB4A32t/cW1wNQwvbwaWDrUshVJEGXjFc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbKhzdPgXB6ebEOtYoiN0anfPBW7d1hKD0//YiiPI3FuBSIyfyD9VBl77gtua8cu8
	 4RwdhGEvDTAaZY7L/D+CCB6bRrc951CgS4CC9y/yCrA119TKIAnFWCAyyKa+9nbsYt
	 v8rzUMm76rCFx3tTG/fndXoJh9ZtnTiDirpoj+GLgGU/rySShcDsHGryvdZBMWH/xO
	 A9ji6Y6VaBlnxY14gXdiBqRaOIn7+otKFBPj45AapTN2uMOG3uLJKQyMHQl+pDfCKB
	 YU9uZftiy3bTTLXxX1hQJzLT077SVX7AKputTk8wfh1XIADHdDmTS9uX7yIPLkzLvb
	 LztIRjbGUtr8A==
Date: Tue, 28 Oct 2025 15:08:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Algea Cao <algea.cao@rock-chips.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Daniel Stone <daniels@collabora.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 0/6] Add HDMI CEC support to Rockchip RK3588/RK3576
 SoCs
Message-ID: <5678895e-2647-42db-b3f0-86a21b9bc225@sirena.org.uk>
References: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
 <6f3f126d-72c1-48cb-a9c8-8d354af2a3d5@sirena.org.uk>
 <410fa913-e86b-4ffd-9d79-ce804f0271ff@collabora.com>
 <63003a7e-8d3d-433a-8a44-54fe8740bc3a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hHHi8VVPfq5V2b8D"
Content-Disposition: inline
In-Reply-To: <63003a7e-8d3d-433a-8a44-54fe8740bc3a@collabora.com>
X-Cookie: Your canceled check is your receipt.


--hHHi8VVPfq5V2b8D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2025 at 04:57:03PM +0200, Cristian Ciocaltea wrote:

> This seems to have been already addressed:

> https://lore.kernel.org/all/20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com/

Ah, good.  Hopefully that lands soon, do you have any idea what's
holding it up?

--hHHi8VVPfq5V2b8D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkA3FYACgkQJNaLcl1U
h9AVOQf/TT3cHQKKcbpTXY1jqeGzTtOf4Q+lasiQNfgPQnTeq/V2uYagmZRlgVFc
9SDXeRkcFN/u7GiPt9+nQ4tWJaWkAV3BOnqPndzPF4mCtBqDuI68jq1wdjnY2ILB
ptsrNz1xkUu+oJlsPWALqlSsQHWGNsYENLDExWjs4/MkM45mOHEH2b/jPAoD4GTT
lmp2TmEYZ03SR8wl362H8XVg8GAHFZLVVdetTwdB3TknjZf5aJD8L3cf0uSqkufw
3lk0lx+xFMh6hk3IBLAiuqdhVMDEkUaSEpgy5lHGhpSraZYjJ6cvcyV/s8m7lGl4
s9ZOEfXvUgqO8XcY36AaBaNolFqsSw==
=AwHR
-----END PGP SIGNATURE-----

--hHHi8VVPfq5V2b8D--

