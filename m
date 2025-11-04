Return-Path: <linux-kernel+bounces-885056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C1C31DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 996734EE3DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1342620DE;
	Tue,  4 Nov 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGX+m/bu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E02163
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270382; cv=none; b=EUbM2q2s/ftJwvTNqmJFMeW8EeHoUAb6rAXlEYhB8Avw+nG/99uVtuD5tcAYXIwOSayAInSXrb8Aj9ZSZVH8ZxZNXfJ0GkoSQYHHz8+mYv4F6F8Kfw1e0ag1EBZBcKAC4iUrUVyNRm1VnawEuf97vOO9s3yAQTapMGPQnf1bo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270382; c=relaxed/simple;
	bh=X7nbnpqTZEY8i7Mu8ZgmQcVXpO3RbTTTraj7HJK2ASU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRqI8ELEFcmWW8H283GsJLI+VtV7rKIVpGiEr0wPmKgiQocF2m12uHcxHnd5EupMWUMhmkha1RnWCDmV7SajqvMt3wntYJqb++iWukHtsMuNgIRQVlknrq9ISeAzNcbmYhC8A5kpYt48dye98L4He9B5kDVocDr3Etbkyaa2hxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGX+m/bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D271FC4CEF7;
	Tue,  4 Nov 2025 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270382;
	bh=X7nbnpqTZEY8i7Mu8ZgmQcVXpO3RbTTTraj7HJK2ASU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGX+m/buo+BDLsk+en9q5E9BmVMuAQ/XxyxN4Rny4PgbO3cvPa4DOhVcEsnEziD4r
	 zfH9NuE5GXZD7vAbOmI6tpyzviRnaSxKHO1hQefu6WYNo0rCZwPjxBIa0XoqPJvs1P
	 Ad8JAUvjm8/AaayXEfhBNIyHyQTQ8p0Yxenl9Nm0MbWrkQuqPR7xykqSMoUoU2M+U9
	 T8FjNoqCpBTGM6Ybr7yLpvJi5KzMfzHDBn1Jkc5O6vCuNAbhqJgi4BH/0znqTp8Q2H
	 Ci/2TDS6vSkX8Pt0kwk7mdyCtt/4yfiLuk8GGADKC+o53kFSpsbtDOPfIYxCwultIE
	 bkTEVlKn4A4Ug==
Date: Tue, 4 Nov 2025 15:32:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+2D55tAT0OVo2Bc"
Content-Disposition: inline
In-Reply-To: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
X-Cookie: If in doubt, mumble.


--H+2D55tAT0OVo2Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2025 at 05:20:59PM +0200, Andy Shevchenko wrote:

> Something bad happened to the regulator branch [1].
> First of all, the merge message contains unneeded details (at least the
> author's email signature). Second, the few lines series becomes 3kLoCs
> merge commit. I think the base was wrong and `b4` (if you use that one)
> took too much to merge.

I forgot to trim the cover letter but otherwise I really can't see any
issues and you're not in the slightest bit specific about what you think
is a problem.  The diffstat for the tree is:

 13 files changed, 1149 insertions(+), 780 deletions(-)

which doesn't doesn't correspond to "thousands" of lines.  I really
can't tell what on earth you are talking about here.

--H+2D55tAT0OVo2Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkKHKcACgkQJNaLcl1U
h9Coawf/anO2mMvtcmPROWSwe2R5UF1fDFkChebXt3k8QqNQOoeTCEMkOZL6rC1v
83exT9RTUDHTUeeZNUR8WL9wGVuemi1QwRK4fH0G965eHF3XCHXycyl8cjovhQA4
f3dXgXjNkRh9qcEI9Sd3sIORaqifKVjG1cHp1nev2mUrq2KtKxLd0O8otztRoxz6
wO0kjMzIBJMjh2W38ii3JtiegO0WYp0CwOxyekhBi8xtqBWQAs9Q4u321JRMod8d
1wxcGFaccJy5LVbeLGdfzhv6edzdxGeT0zRTkymUyqso9hgm8GkRyt+oZq1d4ImA
9QskyGxVRUhE0wLviC3OZJNEdAJhCQ==
=Ysef
-----END PGP SIGNATURE-----

--H+2D55tAT0OVo2Bc--

