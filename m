Return-Path: <linux-kernel+bounces-753571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E57A4B184B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF6018972EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDA26CE37;
	Fri,  1 Aug 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BULsacfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606723535C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061142; cv=none; b=XExt/1XDvzCOYNWx6RaL97jp+3XnmK7CT761VGfXAn3EjzV74ZUeO0n99rm0XSyIxHDCcNVLrVuLd27YF3vvBYB0g1bo0rUZLYt8gdi+XI44ZMpJ9s4U3GJjPE0iXxd0mFSBNITo6iQJtu+/ubh0d1Vji9IaEEeSshb1d5OZiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061142; c=relaxed/simple;
	bh=T0JRaAlYPGwVaZX/So46uAmuoyfpyO2EumWKx4Gi5y4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=BhhV75rKxaqMMBePqiUYz9VypniBTu16iXQn5Pq4a4X5N4zi9DDb5iMp7r83v6dD0RF2FHUP1dsFp6uZkWkRXtU5Cjr5Z4zOzNDr1ag3gdWsBVXMmV8Bwh6PCnQSznrMP/sph9zhcIlADfLILovbk7mg+ZKoo2kKDcig6fH/Fzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BULsacfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CAEC4CEE7;
	Fri,  1 Aug 2025 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754061142;
	bh=T0JRaAlYPGwVaZX/So46uAmuoyfpyO2EumWKx4Gi5y4=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=BULsacfXSD2H8x/IZT4JCsYTNY4qzwz6L02PaOi3fuYjonBwlTNJ2g3akEI/zjUzO
	 zmNhSAEHPKqcQ+DXR5pTiK/D513Oubh51m0NmFU+rkorpgmvtA3sivxaM5aDT8JI0A
	 a6nbYGkWYhz64MPTDMWl40l1tl7NEbiRhACsNpbzDPhiuMxKfiHuPZGzMoPbWBBV2l
	 2BSQFXP7SY94xi7Qt9JD7TjP/2nt0nAThMowJeTJtMToMj8l6RqcFqN6dG5SFxNZ9T
	 Lvv+/9o1keUCpZiWwCjCgCShotsOAYydWSrtIgWnjgF41ltt/+Py/V2bAx4AscNvLy
	 4Yq7TKBVANNUw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 17:12:19 +0200
Message-Id: <DBR6S322NP7E.1T932OJTX6A63@kernel.org>
To: "Timur Tabi" <ttabi@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/nouveau: Remove surplus struct member
Cc: "phasta@kernel.org" <phasta@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250801074531.79237-2-phasta@kernel.org>
 <809d2ff29bb87f782f7a813d67d3d604882db320.camel@nvidia.com>
In-Reply-To: <809d2ff29bb87f782f7a813d67d3d604882db320.camel@nvidia.com>

On Fri Aug 1, 2025 at 4:50 PM CEST, Timur Tabi wrote:
> Does mean that the TODO has been done, or that someone completely forgot =
and now your patch is
> remove all reminders?
>
> If it's the format, maybe add a fixes: tag for the commit that resolved t=
he TODO?

The TODO was introduced by commit ebb945a94bba ("drm/nouveau: port all engi=
nes
to new engine module format") from 2012.

It's a bit hard to know what exactly resolves "this will be reworked in the=
 near
future" for a commit with the following diffstat. :)

	146 files changed, 14219 insertions(+), 11099 deletions(-)

The last remains of accel_done were removed with commit
4e2ec2500bfc ("drm/nouveau: Remove file nouveau_fbcon.c"), but I don't thin=
k we
should mention this commit, given that apparently no one knows what was int=
ended
to be reworked here [1].

We could mention the above in the commit message, though it will also be
available through the lore link in the commit message once the patch is app=
lied.

NIT: Please don't top post, use interleaved style [2] instead.

[1] https://lore.kernel.org/all/481a2808c235f95726d17803503b2b6dc2746dc3.ca=
mel@mailbox.org/
[2] https://docs.kernel.org/process/submitting-patches.html#use-trimmed-int=
erleaved-replies-in-email-discussions

