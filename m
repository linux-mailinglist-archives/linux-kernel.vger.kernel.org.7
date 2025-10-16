Return-Path: <linux-kernel+bounces-855760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EDABE2364
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B05819C0262
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF762C158F;
	Thu, 16 Oct 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="6nnANU8Y"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3214D29B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604404; cv=none; b=lThePAjBbk4H2RpJnp7BI2a6+9s2neoulTPMUsrNyRwDrVRnmvCB3hnwduocgvsHQ9yNgg5cpspRouPeSESjkSEIUanxeDweMDJdZrEDxdt1sVMuYYU+uj1sUHpvfxZGRbHDgqdScSbOhD9kXtcXyx+LIju9N9wJLUFhfzK9NL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604404; c=relaxed/simple;
	bh=NnrcmzFkXtSy1OqvRrmhHUDsaiHNiSnJlYk78esVVzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/UopdBQu00zQodTiyybpOZxd5dJ9XyxDctRCbylhLPwVqSh/HeJK2A76QS1DGKILxaErkHWqMqqUGNn8lDXVjAw9toNlr7Pma3ynBtwpjhSsbDSKdvol473XBWZaQ2JkXaC4wEGkpm5O4zEV7PjSZXUOXDwaXxbk3O1/LcbDDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=6nnANU8Y; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8] (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 9C6DA685CAF;
	Thu, 16 Oct 2025 10:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1760604394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnrcmzFkXtSy1OqvRrmhHUDsaiHNiSnJlYk78esVVzo=;
	b=6nnANU8YeEHT1VoI/11CWAfGUbZfwrss8H9dYRN1mO7Yz3Y7M91EJ1VlgrqnksrEI7usD6
	1qMdUThysEs5uZa7N3Jdhry6Tk5s1e71iVe3jo5k9Dugt2+8xG56DIi1K1IfP2/10x69fz
	tIKfSlhdFyqYl/5j4E4gOdoHXucCwHw8q4vC6j9zdMeH9qzaM7j6D5nfaN7k/q2OEOFzY0
	yyefEpRtUc23/xQmrVy4SSjYGISgCCHFB3ipj166yE2sGMU6mAwFcws2Y32FNoyLiTgo0j
	FTbKzHsu2Z/pWHMj7INJI9zASPV1wjp4k/VblEZhRei3n4eE0pONd7QjLZm4MA==
Message-ID: <0b2fa71f1ccd49d66ca02b6c44ba8fe2135e9b6f.camel@svanheule.net>
Subject: Re: [PATCH v3] regmap: add cache validity to REGCACHE_FLAT
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	 <rafael@kernel.org>, linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2025 10:46:33 +0200
In-Reply-To: <a2f7e2c3-f072-40f7-a865-5693b82b636e@sirena.org.uk>
References: <20250109180256.6269-1-sander@svanheule.net>
	 <a2f7e2c3-f072-40f7-a865-5693b82b636e@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mark,

On Thu, 2025-01-09 at 20:11 +0000, Mark Brown wrote:
> On Thu, Jan 09, 2025 at 07:02:55PM +0100, Sander Vanheule wrote:
> > The flat regcache will always assume the data in the cache is valid.
> > Since the cache takes priority over hardware values, this may shadow th=
e
> > actual state of the device. This is not the case with REGCACHE_RBTREE
> > for example, which makes these implementation behave differently.
>=20
> This is causing spurious events to be generated by the audio drivers on
> Pine64 Plus, the audio drivers for that do use the flat cache (see
> sound/soc/sunxi):
>=20
> =C2=A0=C2=A0 https://lava.sirena.org.uk/scheduler/job/1056879#L1897
>=20
> I haven't investigated yet but I suspect this is going to have been
> triggered by the change from assuming all registers default to 0 if not
> otherwise specified to reading back from the hardware if the first
> access is a read.=C2=A0 That does seem a bit like a driver bug (I'm not c=
lear
> on the precise mechanism apart from anything else) but I worry that
> it'll be a widespread one where things do read/modify/write cycles.
> There may also be initialisation from suspend issues where we stop
> resetting values after resume.=C2=A0 We do need a plan for this, possibly=
 we
> should default to the old behaviour.
>=20
> It's definitely too late in the release cycle to apply the change in any
> case.

Apologies for the delay, it took me some time to get back to this properly.

Would you be open to providing a new type of flat cache with sparse
initalisation (e.g. REGCACHE_FLAT_SPARSE) to provide the behavior provided =
by
this patches? Most of the code could be shared with REGCACHE_FLAT.

REGCACHE_FLAT and REGCACHE_FLAT_SPARSE would both maintain the cache validi=
ty as
in this patch. On a read, _FLAT_SPARSE would return -ENOENT on an invalid c=
ache
entry. _FLAT would then always return 0 and the (zero-initialized) value,
ignoring the cache validity and maintaining the behavior drivers may curren=
tly
rely on.

If you would like existing drivers to transition to REGCACHE_FLAT_SPARSE, I
could also add a deprecation warning for users of REGCACHE_FLAT.

I can also just send a patch series, if that helps.

Best,
Sander

