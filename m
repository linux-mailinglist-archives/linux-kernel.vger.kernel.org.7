Return-Path: <linux-kernel+bounces-844261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38495BC1669
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5DDB4F59F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F972DF3DA;
	Tue,  7 Oct 2025 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="e3ICVuOR"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1272AD2F;
	Tue,  7 Oct 2025 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841233; cv=none; b=IC4HHkfDmeMgfKYrD+kfoaQk8JlDcyyeBmRhGGcpyxorvMiV95I9dHMRRaxTJ0Q6E94vb2KA4uKONEgaeFocc4NHnYelUzl3ZZdWH9M0ngpEwByqMe0rPzn2n1UMCzh4grqTVg4sNycKayxGaqaloMxGd5X5QpsJH/kf4Lliw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841233; c=relaxed/simple;
	bh=c+6ev8lGVHIuS9Fgc9kpY0G1q7d2ENYk5Qma+GHfWjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdik1RLClQadYnWT+FdTbW2JCX/cxydJXSyUDpqp/Ylq+sdE1Q9IdD60GH7TtW7WudlHKKQrFNjskd+J16Lay7C5UjGHVnIJcvbps8Qg67xpxgeQSnSVy4QkVWEkjZZ5XxWFNc4Nrmkv6GXueYxrzoBsF0OleGkPYKQdYA5XEE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=e3ICVuOR; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3ea3:0:640:1894:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id E06628160F;
	Tue, 07 Oct 2025 15:37:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YbkbHRALx0U0-zfyy7dBX;
	Tue, 07 Oct 2025 15:37:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759840658;
	bh=11vCPpW2xiVEBFoImljy4JjSFQTqP7bkvs9j7Br2/Mk=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=e3ICVuORs9C+my8Q4paC3iw7po2weA4/sPgA8kr0UcCeJQ11xCs4lwhBoCCRugNJH
	 nXY330+btQrs2B6CM0B4tecKGrUREwLu0V79g2OCk6bHX++VHyLams0xp+j8elFTG+
	 6Q/GYrgBQHBmZBupNep1FoDmC3Fl4voPUrrdR8oU=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 7 Oct 2025 15:37:32 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, tmgross@umich.edu, dakr@kernel.org,
 linux-kernel@vger.kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] rust: xarray: abstract `xa_alloc` and
 `xa_alloc_cyclic`
Message-ID: <20251007153732.654b9c6b@nimda.home>
In-Reply-To: <aOTzJyLA49xdckRr@google.com>
References: <20251006163024.18473-1-work@onurozkan.dev>
	<aOTzJyLA49xdckRr@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 11:01:59 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Mon, Oct 06, 2025 at 07:30:21PM +0300, Onur =C3=96zkan wrote:
> > Initial version of xa_alloc and xa_alloc_cyclic abstraction
> > patch series.
> >=20
> > Onur =C3=96zkan (3):
> >   rust: xarray: abstract `xa_alloc`
> >   rust: xarray: abstract `xa_alloc_cyclic`
> >   remove completed task from nova-core task list
> >=20
> >  Documentation/gpu/nova/core/todo.rst |  8 ---
> >  rust/kernel/xarray.rs                | 82
> > ++++++++++++++++++++++++++++ 2 files changed, 82 insertions(+), 8
> > deletions(-)
>=20
> We should send xarray patches to the linux-mm@kvack.org too.
>=20
> Alice

I suppose it should be added to the MAINTAINERS file? `get_maintainer.pl
rust/kernel/xarray.rs` doesn't give that address right now.

Thanks,
Onur

