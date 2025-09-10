Return-Path: <linux-kernel+bounces-810526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CAB51BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521995E4E01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D987327A07;
	Wed, 10 Sep 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JeVsbrXe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ECA324B0A;
	Wed, 10 Sep 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518573; cv=none; b=LDBuPpYxx1Y/KTO0muXVY8iyoMScstZDXEjbI2yRJr7YHDxi184jcjoodo4z4AkD71ABQ9iH61/wSkgEAPoep1xsaDpmW9mC1YqUTyKGv7qnMSaXJXcsKtftxnEhm7hlWm92OtvhBvQf4qGBnx8cb5d1TZULW+F1ZgXMDHowITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518573; c=relaxed/simple;
	bh=TYMu5BOHm/qQcAr0Dy+e6bh+1PiSeQZinlkSqNeX0as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBMAtQigTCjF9YqBtO+tMKb6o34xsvTbI1gIZlTOQiNoRwJ7XoOYVavV2BM6F/xDsRSd6XqZ7IoHHGhGoDPn6ooY6zgu8czSyHD8imIMRo1VDfjNUfVdoF+0gjIQIz9Qo0xDZBIMI3qNQ0DK5rIqnfBlE7E31UwzfskTz0mTeHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JeVsbrXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D21C4CEF0;
	Wed, 10 Sep 2025 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757518572;
	bh=TYMu5BOHm/qQcAr0Dy+e6bh+1PiSeQZinlkSqNeX0as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JeVsbrXeGHTG8TtxnWuyKXMML5DRNaa9jEfse/JO1JMSU3bLHFY4fBYGjf6MK396p
	 80rIRkJ4SlrzH8FntM1DnZFqA3IAXqYxTvfSovUfX7wKikZs46r1GukmPNjRvDuZNG
	 RJF3LJVzQ7XSxGjz8yJplS+uWJwJ00ttnUIX/iDo=
Date: Wed, 10 Sep 2025 17:36:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
Message-ID: <2025091027-granny-squatted-c5b5@gregkh>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <45f6f6e0-bd1e-41e7-8c8e-bb556644a873@de.bosch.com>
 <DCO4MP8YT3A8.2PFXX7VJ1STD@kernel.org>
 <2025091014-explicit-grafted-e849@gregkh>
 <ef5c0c7b-3fb3-4099-966c-62cf08d9b2b4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef5c0c7b-3fb3-4099-966c-62cf08d9b2b4@kernel.org>

On Wed, Sep 10, 2025 at 05:23:26PM +0200, Danilo Krummrich wrote:
> On 9/10/25 5:22 PM, Greg Kroah-Hartman wrote:
> > On Tue, Sep 09, 2025 at 10:29:13AM +0200, Danilo Krummrich wrote:
> >> On Tue Sep 9, 2025 at 9:29 AM CEST, Dirk Behme wrote:
> >>> On 04/09/2025 23:13, Matthew Maurer wrote:
> >>>> +#[cfg(not(CONFIG_DEBUG_FS))]
> >>>> +impl<'b, T: 'b> Scope<T> {
> >>>> +    fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
> >>>> +    where
> >>>> +        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
> >>>
> >>> Inspired by Greg's & Danilo's discussion I tried building with
> >>> CONFIG_DEBUG_FS disabled. And get
> >>>
> >>> error[E0412]: cannot find type `Entry` in this scope
> >>>    --> rust/kernel/debugfs.rs:351:37
> >>>     |
> >>> 351 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
> >>>     |                                     ^^^^^ not found in this scope
> >>>
> >>> And giving it some Entry (for my 1.81.0)
> >>>
> >>> error: hidden lifetime parameters in types are deprecated
> >>>    --> rust/kernel/debugfs.rs:352:37
> >>>     |
> >>> 352 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
> >>>     |                                     ^^^^^ expected lifetime parameter
> >>
> >> Yeah, I caught this as well and fixed it up on my end with the following diff:
> >>
> >> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> >> index ecfcce845d3f..1f25777743db 100644
> >> --- a/rust/kernel/debugfs.rs
> >> +++ b/rust/kernel/debugfs.rs
> >> @@ -348,7 +348,7 @@ pub struct File<T> {
> >>  impl<'b, T: 'b> Scope<T> {
> >>      fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
> >>      where
> >> -        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
> >> +        F: for<'a> FnOnce(&'a T) + 'b,
> >>      {
> >>          try_pin_init! {
> >>              Self {
> >>
> > 
> > Can you send this as a fix-up patch?
> 
> If you don't mind I would fix this (and one other nit) up on apply. :)

I've pushed these to driver-core-testing if you could fix it up as I
don't know what the other change was?

thanks,

greg k-h

