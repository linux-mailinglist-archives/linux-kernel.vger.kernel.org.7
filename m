Return-Path: <linux-kernel+bounces-854551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E214BDEAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1286F1887B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1AB327783;
	Wed, 15 Oct 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m8Ob9jb/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABB13C8EA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533984; cv=none; b=LHgYRbwa51ZdeG3XHyoVP8/sGm55Vn2dsjw8B6cz9f7E6YpAAzby/hqQr25KpcOjuYTgAuFaNlXaVIzX3ZtKMG/6ouXPUAcJJlbQJUEUL+pYgZgb0z+HnFGyuwIpwMJOUqYtkiw7g++9/APQ4mxdEBBD6UnS8Qch/GzJUZxAZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533984; c=relaxed/simple;
	bh=CbnARJ1NcaAYMxMWl6wrepneykP7YTXb9rnB9JY3DjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZv9AZKp6xdlYnaFagh9v0UC9jXN+JBOXqBWfKHNr9XPBxpOtG/4lAqlWgSKRgB1b+byKFqPEA1ImXiN9CEfdsFXNjQPMpfZBVJpmWIoTQa9YI/3gNcSRsAep0/UpNSj731q5aBcjLW6HPuZS6+4d9rOP+vf0qylX9sipCDfXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m8Ob9jb/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760533979;
	bh=CbnARJ1NcaAYMxMWl6wrepneykP7YTXb9rnB9JY3DjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8Ob9jb/yqmdZN5gbXCzgVebh2Me0gTPCS7skTCvVHKVKZb+E7d3Ne+V6rwVXRlDt
	 VYSG1AI2Zntyba9pSD9ieku+zAV8xZnQZKl1w135SeDH5V4jRI+7aCCI29CMlO7vgi
	 EB2NhMEXtEfUYG/7m5wKCKYVi2mOj9ZciBV77NvzD2jEhcQknQBWaf5TS/Gqz67Q2G
	 6WKnH7+N7X6nLqyebw7YxBL1E6GQZIu4uWTpxiRS5TaV9n6PV6zCSts1MNZuwssU6O
	 IGZzlxOQrCxo4Rfk1xY97c/4o8aeVa8stN4cxnQC+n8Zo7D1h0zeDOcmkFdwD1x9B8
	 boa/A3UcsyrGg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 27C4F17E05FE;
	Wed, 15 Oct 2025 15:12:58 +0200 (CEST)
Date: Wed, 15 Oct 2025 15:12:55 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mcanal@igalia.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?B?TWlrb8WCYWo=?= Wasiak
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>, Nitin
 Gote <nitin.r.gote@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Christopher Healy <healych@amazon.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH v3 07/10] drm/panthor: Introduce huge tmpfs mount point
 option
Message-ID: <20251015151255.6f314a11@fedora>
In-Reply-To: <6f1fb1a5-5d6f-4ebf-bf12-3481d360fb7f@collabora.com>
References: <20251004093054.21388-1-loic.molinari@collabora.com>
	<20251004093054.21388-8-loic.molinari@collabora.com>
	<20251006092856.02fbfd9e@fedora>
	<6f1fb1a5-5d6f-4ebf-bf12-3481d360fb7f@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 15:09:31 +0200
Lo=C3=AFc Molinari <loic.molinari@collabora.com> wrote:

> On 06/10/2025 09:28, Boris Brezillon wrote:
> > On Sat,  4 Oct 2025 11:30:50 +0200
> > Lo=C3=AFc Molinari <loic.molinari@collabora.com> wrote:
> >  =20
> >> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/p=
anthor/panthor_drv.c
> >> index fdbe89ef7f43..a2be3b904ca2 100644
> >> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> >> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> >> @@ -1623,6 +1624,12 @@ static const struct drm_driver panthor_drm_driv=
er =3D {
> >>   #endif
> >>   };
> >>  =20
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +bool panthor_transparent_hugepage;
> >> +module_param_named(transparent_hugepage, panthor_transparent_hugepage=
, bool, 0400);
> >> +MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount p=
oint with Transparent Hugepage enabled (false =3D default)"); =20
> >=20
> > nit: I'd go for a slightly shorter name, like [panthor_]enable_thp. =20
>=20
> For v4, in order to be consistent with the "transparent_hugepage*"=20
> kernel parameters, I'd prefer to keep the "panthor.transparent_hugepage"=
=20
> (and "panfrost.transparent_hugepage") module parameter name
>=20
> I could keep the parameter name as is and change the variable name though.

Fair enough. Let's just keep things as they are in this version.

>=20
> > The patch is
> >=20
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> >=20
> > regardless.
> >  =20


