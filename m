Return-Path: <linux-kernel+bounces-753779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B5B187CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F37AA3422
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79E28CF64;
	Fri,  1 Aug 2025 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oLva7SuN"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00991C2C9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076817; cv=none; b=crrdVBk/dQdxcJdrhob2xzwkhAsDTRcPHGGYmwsyrBfIdF19Tt0IdxkdUlYwL02dthIUrmfak541AhHJEWxC3IrV/2DuO3QTDnuEUONywueV3s5FZW3sN7YNuUxgBjTI4lvYyKH0Q5hqpskrxOJEMDPH3Kmgc1kAxP6t33fowLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076817; c=relaxed/simple;
	bh=2GTeXBvWxBrQMAL5a4cYok7pXa7FvGdxed73lo7uemI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAgmJWhmbfZtly/ZoRQxRQmRFi1RqPkBWu8Jf2qYDV3KEftzNYIZRYfCVtL62NweupDtx/QWjP5L4lcEjeMPsY7gVoxZXNn9ToqCb9alAJ2zbT4U/CZMe9xIpz3ObdnlJb57dLAOgFmN/fpHqqFprj9IF4b1joHWuljG+tL9Qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oLva7SuN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4btx2F1VR0z9sd6;
	Fri,  1 Aug 2025 21:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754076805; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWaNLhbm24FN2VPxqLS0wEWVP3ckHjc8299w5KEB5CM=;
	b=oLva7SuNT6tG4OnBJa4DIwGdgJee+Xi/k6nkZqFA27OyTG4xVhvDr2FZ3QNHzWzTJPDgW6
	UXPi0gQBJj/z3AWvs7XOEUcv6XRqbmv7wHga/9WMH8GRsCxVkaXHuaBlVLssknjafQqcNu
	04PyyEWVyG1RMzDZMiJ8WJSWD16P2OXKNweUWT13DnDJk1AY9zrWCf6aAkv7UG6IQgFJKK
	4lmi7CSfnP8EQT5pMFz3f78IJA81j8cBCIA5vFED9Mvez0Hh3b579ncTZQGz98a+qm8Lu1
	lKMpWONxvlUtKBf59G5KNThsqkOmTeOhBSzw3y0GFEcQ6QQXZD+jZypzxDe0bw==
Message-ID: <f429ce1c4c818d5e622bb6e9dc485e8e6b776e56.camel@mailbox.org>
Subject: Re: [PATCH] drm/nouveau: Remove surplus struct member
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Timur Tabi <ttabi@nvidia.com>, "dakr@kernel.org" <dakr@kernel.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "phasta@kernel.org"
	 <phasta@kernel.org>, "nouveau@lists.freedesktop.org"
	 <nouveau@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 01 Aug 2025 21:33:22 +0200
In-Reply-To: <39dac3cf6ecef55a0e3dac7a381670491f09b8aa.camel@nvidia.com>
References: <20250801074531.79237-2-phasta@kernel.org>
	 <809d2ff29bb87f782f7a813d67d3d604882db320.camel@nvidia.com>
	 <DBR6S322NP7E.1T932OJTX6A63@kernel.org>
	 <39dac3cf6ecef55a0e3dac7a381670491f09b8aa.camel@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 13c93f890bca2754489
X-MBO-RS-META: xa1yr743g3p4es4ok5cfrhg7m5n13iux

On Fri, 2025-08-01 at 15:42 +0000, Timur Tabi wrote:
> On Fri, 2025-08-01 at 17:12 +0200, Danilo Krummrich wrote:
> > On Fri Aug 1, 2025 at 4:50 PM CEST, Timur Tabi wrote:
> > > Does mean that the TODO has been done, or that someone completely for=
got and now your patch
> > > is
> > > remove all reminders?
> > >=20
> > > If it's the format, maybe add a fixes: tag for the commit that resolv=
ed the TODO?
> >=20
> > The TODO was introduced by commit ebb945a94bba ("drm/nouveau: port all =
engines
> > to new engine module format") from 2012.
> >=20
> > It's a bit hard to know what exactly resolves "this will be reworked in=
 the near
> > future" for a commit with the following diffstat. :)
> >=20
> > 	146 files changed, 14219 insertions(+), 11099 deletions(-)
> >=20
> > The last remains of accel_done were removed with commit
> > 4e2ec2500bfc ("drm/nouveau: Remove file nouveau_fbcon.c"), but I don't =
think we
> > should mention this commit, given that apparently no one knows what was=
 intended
> > to be reworked here [1].
> >=20
> > We could mention the above in the commit message, though it will also b=
e
> > available through the lore link in the commit message once the patch is=
 applied.
>=20
> It's your call, I'm just leery of removing a TODO without any mention of =
whether it's actually
> done.

We can't really tell whether "it" is done or not, because the original
author didn't write down *what* exactly needs to be done, which makes
the TODO kind of useless.

Since that information is lost forever, removing it arguably is
alright.

P.

>=20
> > NIT: Please don't top post, use interleaved style [2] instead.
>=20
> Sorry, coffee didn't kick in yet.


