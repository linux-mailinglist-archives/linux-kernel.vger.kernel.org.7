Return-Path: <linux-kernel+bounces-840194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B39BB3CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73B63A5EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6753101A3;
	Thu,  2 Oct 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXf5HugE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88392797AF;
	Thu,  2 Oct 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405372; cv=none; b=qUBz2xvV2QOFep9EMmy3pF8UWJoRViKFY4yy7Vd1N3jbECvdwi/Ed/frqGbssRXheUBCFUTdh1GIplGLXBEePy8K7ngbYc+IGKfyu6cfft93GQfsbOfQu2bDywSbmSphQ45BucEzeCj8GsfE/3q/7jI1Nb/EHJhCMX409v4lBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405372; c=relaxed/simple;
	bh=vbNFbdJYlLnZG2wACTOj7jBkUXMZiUzzUteZi3K/WGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldezFmhXYMSBq6gSGGC5sGGO6TUAxaPknLCKDBxrE7ZmjyRjlSOWtFeXtRJZP9+qPbR0qiAD/o8YH/F/bm/RWGB7Vmrgp+2BYGNmVESKIr+KC6iW3uSVgj9zXVx01wqRGNOuIitAm2+tzPRGKUc+JIX97ud4bm5nhhGkiLKrpJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXf5HugE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B83C4CEFC;
	Thu,  2 Oct 2025 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759405372;
	bh=vbNFbdJYlLnZG2wACTOj7jBkUXMZiUzzUteZi3K/WGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXf5HugE2M/1uw3eIrVJdnXIOaGbLjiyduT4zq89pe0c9hylUVCAqHD5fjitAzcuB
	 6mAnIDaRYASpySLAhtVXPfY6LszYliFh8id6SuSjfQzJec0JWX54dr3gIzF411Xtcm
	 JXe509xlNkL8dC57yFEm7OVd545/1NZ+fyWecn4o5hUUN6JydaVLnOBeoc7z0ZtKhq
	 ktIn261RjE6P5OEdqnQE/O51+K16n2xGHpVhhUnYjkFVks4zcWKXmV/T6ASLQkoZEN
	 3yuY15Q110BLgK0oHcXF0PBghnVUt0gQuz+0Sl59GOZYAKnhRJueAVThQl6J3IyEFx
	 BsJ2WcJ6QLqvQ==
Date: Thu, 2 Oct 2025 12:42:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: angelogioacchino.delregno@collabora.com, conor+dt@kernel.org,
	krzk+dt@kernel.org, lgirdwood@gmail.com, matthias.bgg@gmail.com,
	robh@kernel.org, devicetree@vger.kernel.org, kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: ASoC: Convert MediaTek RT5650 codecs
 bindings to DT schema
Message-ID: <83df4958-8cdc-4ec4-a77a-0f6132513664@sirena.org.uk>
References: <20251001183517.83278-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TE5evtEICq1wpIvP"
Content-Disposition: inline
In-Reply-To: <20251001183517.83278-1-ariel.dalessandro@collabora.com>
X-Cookie: idleness, n.:


--TE5evtEICq1wpIvP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2025 at 03:35:17PM -0300, Ariel D'Alessandro wrote:
> Convert the existing text-based DT bindings for Mediatek MT8173 RT5650
> codecs to a DT schema.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--TE5evtEICq1wpIvP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjeZTYACgkQJNaLcl1U
h9CNRQgAgB0/gZ+KlQcFzodFTVNysydvUs64RjVNx19lW3i4SQf/GsUktr4RAh9g
9fM6ZQz7A8jXbMTRxjR6N+/ePk0Fi0UA+l68gKCNAA05qsLW/8+BQ+reEVHQ9lIi
CeSYhmUTlX3qcE7AM/bhjSPJxyEqCQM+hDt3Hwj7FYICOD+S1djW7oKo+sHmVsYN
Lwrxb3cL5cLE2ySupwT6rACvXkA3N969/9FkJI33fPBPM5gSdrxRcmEzxU9qlhQg
Tm7qISufYk0OjvRcd3+Nm6l2YNrbfolcFyCKWeM2lbPVd17Ryb2E0ft4F71DhL/y
6n1IvdgVe8vNJ7NEGDu1SYQctIoenw==
=0b63
-----END PGP SIGNATURE-----

--TE5evtEICq1wpIvP--

