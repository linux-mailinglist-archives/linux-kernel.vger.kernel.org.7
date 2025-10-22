Return-Path: <linux-kernel+bounces-864837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D253FBFBAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0357D35029B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243D33EB1A;
	Wed, 22 Oct 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzspcW4/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECAF32E6A5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133263; cv=none; b=ipPnk4liHMeKz/KGqM/JdCuF2KiqlBTK8oZEaxj4OvgEnRY1NqIuEfbozE1B2m/wxyCzAFtb+svOKnUJoYEK1jDHDfhe9woKMO/x7avG2dP7X5mbwZp4xZznfXr/Chi8G92MP7FYMXlnwGkie2uTG8E15TkTj8B91QsmEmLkW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133263; c=relaxed/simple;
	bh=Z2XOzaBlqhEDONKoXE/pXMZHExzl/QDdtOnLEBT/1+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itDYDwTXyuusbk0Rgh+cWxbKXqDtkB/1IMsfyqK+vyJDFSgNMjxNrKCuQu5Ms1QTclThYbWZj9RfyfZIJ5gDMTyAkUU8GAofAXcEnEpzoDA5R2VPlbdfVTArSV1rTeof2bYIJkZVKkIHnA5sRPWFxYJBdb3GIEdMyiMTjiIhuAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzspcW4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11902C4CEE7;
	Wed, 22 Oct 2025 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761133263;
	bh=Z2XOzaBlqhEDONKoXE/pXMZHExzl/QDdtOnLEBT/1+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzspcW4/o5KoI0A4n0LrdDNzrxmMecLrVr/mO2UOxLUKNuiyMExL7rUcHdzYsLuRC
	 2beepoH09TGSyp63DA3/mhclZKwPc9dzj7WoSt+O9BcsWN+ncXH/wni/Mr7BMsZ4KI
	 ZBlLaCvQXB8W0RT4ITIsqnoy50O5YUxotHcC19+UIsUUzkjTlC0CcBlyqqf2VAsi38
	 tjmJ2CcoGeK7DuvIWXJP8IRqQNgRMr/NpBwXUHBmp2s+Ptfdlw4FcH9uZIFqzqXvuJ
	 f6RSWqiIml2o+6R9+X9okzVy4WvNEhjSYo9GMukabl+mPVaptZyHrP1m2g/0oMoteE
	 ZUrGCDmflUfiA==
Date: Wed, 22 Oct 2025 12:40:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, muchun.song@linux.dev,
	osalvador@suse.de, david@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com,
	Aishwarya.TCV@arm.com, torvalds@linux-foundation.org
Subject: Re: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in
 hugetlb_vmdelete_list
Message-ID: <4d589897-acab-4276-ba4c-7e6fb5bec70a@sirena.org.uk>
References: <20250926033255.10930-1-kartikey406@gmail.com>
 <7a1d0eb0-ab08-4fa8-bdab-b193b69a8c9d@sirena.org.uk>
 <9d20e689-c06e-43f8-811f-3e66f3e86d2b@sirena.org.uk>
 <20251021141047.532542aecdb0dc5fdb95696a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4OqZh1KoSvhKKNwO"
Content-Disposition: inline
In-Reply-To: <20251021141047.532542aecdb0dc5fdb95696a@linux-foundation.org>
X-Cookie: Remember the... the... uhh.....


--4OqZh1KoSvhKKNwO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 02:10:47PM -0700, Andrew Morton wrote:
> On Mon, 20 Oct 2025 18:52:11 +0100 Mark Brown <broonie@kernel.org> wrote:

> > This issue is now present in mainline:

> > Raspberry Pi 4: https://lava.sirena.org.uk/scheduler/job/1976561#L1798
> > Orion O6:       https://lava.sirena.org.uk/scheduler/job/1977081#L1779

> > and still bisects to this patch.

> Thanks.  Were you able to test the proposed fix?

I didn't, there were a lot of new versions in quite a short period.

--4OqZh1KoSvhKKNwO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj4wskACgkQJNaLcl1U
h9AeYgf8C223EQT2jxvLW57wso/4kvwPmy4zRY/uaqEPumCiV7M9VBew8qU3ElRx
9ziipdHzaoTM6Y1X3zjCB87u7RARUOPU8OsIYP0Il6lfDHCvoM/5WlA1xoux/fpA
x0+MOO8PTWqA51s4oc3PFg7xxKcJRmJnC6/FZQfoPXeceAHBb9zhPU94O9TbZHtH
9DfgG6IyFGyDkHePEVqO9pNl9qr9kxBIr+u7ZPMzERrcv8uIUreD7FV648Mq+ays
YNS9HEbWt+Ow9KB2I5a6lDUIPHcBqjlQYqzcCgBUBso4twnH8ZNLQQHuf3fSSw3e
RwQGXibOaeFS/9Zu+QXO5Xvl85jJxw==
=MsU9
-----END PGP SIGNATURE-----

--4OqZh1KoSvhKKNwO--

