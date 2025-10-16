Return-Path: <linux-kernel+bounces-856156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065B6BE3405
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BC53B1B51
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E743254A6;
	Thu, 16 Oct 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="bByt4urM"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49541324B1E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616527; cv=none; b=iOm82tJYm1jEp3/v7frae1MAcDb/mskT5/tMETxQD5x2v7cdFde2dV6p92EFJOfuQdt1tJP/+onoA32bgzrt0W2Q1Enegk4tXs22F0dR7vA0ehHQoRhVvaT67mjWV4RzCwxxTu9udYRG3gbAcu8MvRtEpkrc38xgUcz0ViALKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616527; c=relaxed/simple;
	bh=pWlF+KPQTQ5T7UHWILRFGoRUa5cKcyGpU+QQR1XzEpw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQP1hVdH0iomZDrtkev82pb4+MsofiCvnTnjdWzQgBzhL/u7lA3kgWWXddxLibbEpguk2XLz38wDV6axKVHnn26lr90npdsNzXs02CJvc4atow/T9nNZhhya5or3Yvmsw3lmf1aSNRObF2kWH7EOyUyduuEpDRJlLl5axDcdLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=bByt4urM; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8] (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id CD9FF686023;
	Thu, 16 Oct 2025 14:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1760616523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWlF+KPQTQ5T7UHWILRFGoRUa5cKcyGpU+QQR1XzEpw=;
	b=bByt4urMHNgWZXLyOGD94iwaWF0NhFgdosbEia2gZ7JgG7sQViZRPrDF2IXS2Qduc6H83K
	o6KzXoVMQ25lH/vlSGAYj8ozxliQGh4SvQBRQB4MYzrFjfN+kgWl1u4SewDO2A+uwiVdqM
	pqXERkNQ/lKDoRmecdeQgGhvuN/KmGCKZ3B9oM6I9RNTQ8T0yG/DC1637c681wO7hBmR0k
	ywxc/HnlLg/deIb+hT5lq037b0mwBMM4mW2s9KCkdA0SaA51pF3GHcAMip0JA8ZLJ5Xy6+
	SxpsyU+f2gW2wl+I9Nt3qdwhCmUsXBhAD07Ec6c8AVTR9h55sFb4fZ3qecDRnA==
Message-ID: <187bc058ff944dbde0e876efa6e72046bcc2a124.camel@svanheule.net>
Subject: Re: [PATCH v3] regmap: add cache validity to REGCACHE_FLAT
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	 <rafael@kernel.org>, linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2025 14:08:41 +0200
In-Reply-To: <ca528e3e-39f1-41cc-9f46-ad787af48a77@sirena.org.uk>
References: <20250109180256.6269-1-sander@svanheule.net>
	 <a2f7e2c3-f072-40f7-a865-5693b82b636e@sirena.org.uk>
	 <0b2fa71f1ccd49d66ca02b6c44ba8fe2135e9b6f.camel@svanheule.net>
	 <ca528e3e-39f1-41cc-9f46-ad787af48a77@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 12:53 +0100, Mark Brown wrote:
> On Thu, Oct 16, 2025 at 10:46:33AM +0200, Sander Vanheule wrote:
>=20
> > Would you be open to providing a new type of flat cache with sparse
> > initalisation (e.g. REGCACHE_FLAT_SPARSE) to provide the behavior provi=
ded
> > by
> > this patches? Most of the code could be shared with REGCACHE_FLAT.
>=20
> Taking a step back for a minute, what's the actual problem you're trying
> to solve here?=C2=A0 Why use a flat cache rather than a maple tree cache =
for
> your application?

The device I want to use this for has a small contiguous register space, so=
 a
flat cache should be sufficient. The driver can also works with maple (or R=
B-
tree) cache.

The problem with the current flat cache, is that it provides different cach=
ing
behavior than the other cache types. I want to keep the register values wri=
tten
by the bootloader, so I can't provide defaults. That means a flat cache wil=
l
seed these registers with 0x00 values, which don't reflect the hardware sta=
te.
Any RMW operation can then cause the part of the register to be cleared, as=
 the
read comes from the (invalid) cache.

This difference in caching behavior isn't (wasn't) immediately clear to me =
from
the documentation. Don't the different cache types exist to optimize speed =
or
memory for different use-cases? Because then I would only expect difference=
s in
memory/speed, not in way the cache is initialized.

Best,
Sander

