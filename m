Return-Path: <linux-kernel+bounces-740863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DABB0DA28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302EF7A4C99
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A302E4266;
	Tue, 22 Jul 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYkIGOCR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB1B667
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188837; cv=none; b=oMgR9y7/5CSqnN/lSXGxm/iKw7+jYTDAnri2W0m1rSXf+hXPy+/EuYNujtl1ib0Ve8AjeANTFFKd54FLFMX767F3Cf1iD/bvgDpnV0Ko1dvk5kL/S/v9CRxLrg7SPYNqdjhQ69h2cBmYlaPrGqEiv57C93l+68rDsHTIjRIyzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188837; c=relaxed/simple;
	bh=l36K1arYiCPZuEsEChdSPm/wgV9PJ5GgyMMrjLPPdys=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Tirr3HeVo2at89HeU07aA9HBfTBV3QIDMB4XRN5q3l9Z6LKIwPSYlORnywCTK5Lm4X/58zIyR/vRiIjvdWSmZGknbv5QPqvQJMCSdFLCUsSr48vpmwrkW7pO2NnSTNYUGIWNhYQlue1FMRg29/S31ezm7Fk0Vl7pX52U4F6Udmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYkIGOCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A56BC4CEEB;
	Tue, 22 Jul 2025 12:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753188836;
	bh=l36K1arYiCPZuEsEChdSPm/wgV9PJ5GgyMMrjLPPdys=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=fYkIGOCRlImvJJtBzEwQb6Bk5uiYGRbwN/JRMt5gkmj9bwHltVcsWQXO+j0l9/2Xr
	 ZIayfwC4znACkCcOP6pc3uvvmy36X0i2UYksFwxVjavrIwIZI92HOFjMIZqwVEnxTd
	 jXRy+MVECjq7qiibmuELUDkxQITc520xDW1TUCJbJKGMx2MkQHcuGE4O9P8x1ZMJOX
	 cW3lt9nIRjt+dyYa+2tPh0pLKeZV+nPti49J7ryozKsBtFXVubBXpy8QYRoJSo6Q97
	 kFzUJ/oKuzEydTt1VkhdRnZ7LYXxuwzV8gwz6DTAR7DRmesdiOVWA95PbcaUYuqmqM
	 FjF1NgJ2mrXlw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 14:53:52 +0200
Message-Id: <DBILKMS2C1HI.QDSXTIXBVWV2@kernel.org>
Subject: Re: [PATCH] Revert "drm/nouveau: check ioctl command codes better"
Cc: "Lyude Paul" <lyude@redhat.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Arnd Bergmann" <arnd@arndb.de>,
 "Satadru Pramanik" <satadru@gmail.com>, "Chris Bainbridge"
 <chris.bainbridge@gmail.com>, "Ben Skeggs" <bskeggs@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Dave Airlie" <airlied@redhat.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Arnd Bergmann" <arnd@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250722115830.2587297-1-arnd@kernel.org>
In-Reply-To: <20250722115830.2587297-1-arnd@kernel.org>

On Tue Jul 22, 2025 at 1:58 PM CEST, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> My previous patch ended up causing a regression for the
> DRM_IOCTL_NOUVEAU_NVIF ioctl. The intention of my patch was to only
> pass ioctl commands that have the correct dir/type/nr bits into the
> nouveau_abi16_ioctl() function.
>
> This turned out to be too strict, as userspace does use at least
> write-only and write-read direction settings. Checking for both of these
> still did not fix the issue, so the best we can do for the 6.16 release
> is to revert back to what we've had since linux-3.16.
>
> This version is still fragile, but at least it is known to work with
> existing userspace. Fixing this properly requires a better understanding
> of what commands are being passed from userspace in practice, and how
> that relies on the undocumented (mis)behavior in nouveau_drm_ioctl().
>
> Fixes: e5478166dffb ("drm/nouveau: check ioctl command codes better")
> Link: https://lore.kernel.org/dri-devel/CAFrh3J85tsZRpOHQtKgNHUVnn=3DEG=
=3DQKBnZTRtWS8eWSc1K1xkA@mail.gmail.com/
> Reported-by: Satadru Pramanik <satadru@gmail.com>
> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to drm-misc-fixes, thanks!

  [ Add Closes: tags, fix minor typo in commit message. - Danilo ]

