Return-Path: <linux-kernel+bounces-738281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708C7B0B6AD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43B23BB074
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF24C21B9E5;
	Sun, 20 Jul 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="B5lqnyDC"
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4B19049B;
	Sun, 20 Jul 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753025145; cv=none; b=IDOR6jR6z1/6su1Q/jCUtjYa1SV2DwmgXz4Bks+ats7ug7SPmWsvirs67Map/G42PkbkmpoJ3U0WgyAXI35W2mB2iI/pDUcRJv4tuvPDaqmgMJnZ+iaOHlV9RmupOkMlXcU4kzWTiIuXBLTmhjCUMuLF8EFtvlsuBJzXKx/Bmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753025145; c=relaxed/simple;
	bh=uklG1HH6Nla92HVa7baSiFuu87JGy5bL2PCwTZplo3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcLbMjtbnZ97GVhZz/zp8T+/8lWEIYUdSLngksScBDAGOnA9Ep5Tu1GjQSPzYzxlQkXKN++WMZ6UwVHg4Sb9mj5JLXWK99tnYAQoAVqWh1aoiaDDWtwLlnskssqh0/QEu8rf86/FYeT84jdTDDuXvkoHQMYtAVPq26ZtSMOBAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=B5lqnyDC; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1baa:0:640:41d2:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id D584880CAB;
	Sun, 20 Jul 2025 18:17:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NHSJgBjMZa60-PKKBOdlr;
	Sun, 20 Jul 2025 18:17:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753024647;
	bh=Hj7V4Z7PBdVEu39SNeu0UOxNfchWsPyzVJHxT+Qdctc=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=B5lqnyDCzrXD9KG8vgTMKl/8o5Q4t0zQs4DXJu3h2PTqBWhCSdUnCEIMNJcgN7O7p
	 XW3PP9QL62AStUYmIddVKCoWzZDmNJhXkPuPIYOiZym41LJd8MQbt4FcICzX7LvPQk
	 XIjt9OcmS8gss0jbcoAPKdW3V+IKdIuQ3xGYcG2U=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sun, 20 Jul 2025 18:17:21 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: "Benno Lossin" <lossin@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <dakr@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] rust: make various `alloc` functions `const fn`
Message-ID: <20250720181721.54ab9faf@nimda.home>
In-Reply-To: <DBGYNQJJ0JI6.P280ZLVZUSO6@kernel.org>
References: <20250720094838.29530-1-work@onurozkan.dev>
	<DBGYNQJJ0JI6.P280ZLVZUSO6@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Jul 2025 16:43:49 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> On Sun Jul 20, 2025 at 11:48 AM CEST, Onur =C3=96zkan wrote:
> > This patch series makes various functions in the
> > `alloc` crate const fn.
> >
> > Each patch corresponds to a different module within
> > the same `alloc` crate.
> >
> > Onur =C3=96zkan (3):
> >   rust: make `allocator::aligned_size` a `const fn`
> >   rust: make `ArrayLayout::new_unchecked` a `const fn`
> >   rust: make `kvec::Vec` functions `const fn`
> >
> >  rust/kernel/alloc/allocator.rs |  2 +-
> >  rust/kernel/alloc/kvec.rs      | 10 +++++-----
> >  rust/kernel/alloc/layout.rs    |  2 +-
> >  3 files changed, 7 insertions(+), 7 deletions(-)
>=20
> This looks sensible, any particular reason for why you need them
> const?
>=20
> For the entire series:
>=20
> Reviewed-by: Benno Lossin <lossin@kernel.org>
>=20
> ---
> Cheers,
> Benno

Personally, I don't have a specific reason. I thought the change is
harmless and might extend functionality for other people in the future.
It could also (although less likely) help the compiler optimize things
further.

Regards,
Onur

