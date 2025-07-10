Return-Path: <linux-kernel+bounces-724909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D95AFF868
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9BC1C4300A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10207280331;
	Thu, 10 Jul 2025 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwZ+a6P5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63212CDA5;
	Thu, 10 Jul 2025 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125272; cv=none; b=tZowr5p3dNr/y5ABOm9E0CK32ApqQwMEcSrqBVmb/YG2Tk7uMj/eKZQAAHEmpmRMCLPIUXs7wfPG8cyoXSPGGwkipvziA2LithQuFIBjbIz/KpJMDXCOdf4CfLI0hENVvlS+DwEUoJyyIJARzJ0c7maZfnnpjstyndZ0+cQq/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125272; c=relaxed/simple;
	bh=r9edKPVJq03d+TJPTtInkjRRF3jgsnWjS8Sw7En99ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC4mfOeVQdwrIlDcYu0YYJxnLiW5RsFeFwv/ZoP9VXZNiZbEl3nfq8Ww4E0rI+shEABifWncSgqmfKjErKcO817G8LvbvSP5Maoz4+56YzCOX1qujolTnQJG37PQ3H6qha6FltGgu/nsAiIZ44iaaI+DwW12a387mDMBxNbdHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwZ+a6P5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51060C4CEE3;
	Thu, 10 Jul 2025 05:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752125271;
	bh=r9edKPVJq03d+TJPTtInkjRRF3jgsnWjS8Sw7En99ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwZ+a6P55fpp+JV0ySHcd6kgX/zyBWnaiteUP100GeJf+qRcM5K/6fc2F4T7u6T17
	 vBeEDSUNvg7+/iifNHBdV+v7oOYCvYoB/p+YqZoUXbs4j1nP0SDqPayltqRU5qpyFW
	 poCiAbBt3byntGiIzV18EYpx1BgKU2c8A9hea0aY=
Date: Thu, 10 Jul 2025 07:27:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v9 0/5] rust: DebugFS Bindings
Message-ID: <2025071014-radiantly-dreamland-4017@gregkh>
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <DB7US8G7ISG0.20430M3P7I0K0@kernel.org>
 <CAGSQo01hORWAtrGaYp-_xxrAiN47JkJg=jiqnqdpw87QKzt9jg@mail.gmail.com>
 <DB7V19QE6KFB.3MR0BAOWXT7M7@kernel.org>
 <CAGSQo01drZoy1-j-+Y-BHHOX5AzCG4A5KiUOu5TJ40JOdfcB0g@mail.gmail.com>
 <aG7pP1BTLQKInFrl@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG7pP1BTLQKInFrl@cassiopeiae>

On Thu, Jul 10, 2025 at 12:12:15AM +0200, Danilo Krummrich wrote:
> On Wed, Jul 09, 2025 at 03:04:51PM -0700, Matthew Maurer wrote:
> > On Wed, Jul 9, 2025 at 2:59 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > >
> > > On Wed Jul 9, 2025 at 11:53 PM CEST, Matthew Maurer wrote:
> > > > On Wed, Jul 9, 2025 at 2:47 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >>
> > > >> On Wed Jul 9, 2025 at 9:09 PM CEST, Matthew Maurer wrote:
> > > >> > This series provides safe DebugFS bindings for Rust, with a sample
> > > >> > module using them.
> > > >> >
> > > >> > Example interaction with the sample driver:
> > > >>
> > > >> I understand what you're trying to do here, i.e. showcase that values exported
> > > >> via debugfs can be altered.
> > > >>
> > > >> The problem is that the current abstractions only implement read(), but not
> > > >> write().
> > > >
> > > > I was trying to keep the initial bindings simple. Adding `write` is
> > > > definitely something we could do, but I thought maybe that could be in
> > > > a subsequent patch.
> > >
> > > Absolutely, yes! I didn't mean to ask to add it now. :)
> > >
> > > >> If you really want to showcase changing values, you can, for instance, create a
> > > >> workqueue inside the sample driver and modify the counter periodically.
> > > >
> > > > This is supposed to be sample code, so ideally it should be as narrow
> > > > as is reasonable in what subsystems it touches, no? If people would
> > > > really prefer the sample schedule a ticking counter I can do that, but
> > > > it already felt weird to be registering a platform driver in a debugfs
> > > > sample.
> > >
> > > I'm not asking to do that. If the values don't change for now, because
> > > there's no write() yet, that's perfectly fine with me. :)
> > 
> > Potentially I misinterpreted Greg[1], I thought he wanted to see how
> > mutation would work.
> > If we don't need mutation, I'm fine simplifying the driver to not have
> > any mutation triggers and just export a few random things.
> 
> I mean, the most simple way would be to create the debugfs entries in probe()
> and mutate them - still in probe() - right afterwards once. I think we should
> do in any case. And AFAICT, this also covers [1].
> 
> > [1]: https://lore.kernel.org/all/2025070349-tricky-arguable-5362@gregkh/

Ugh.

Yes we need write.  And read, and custom file-ops, and the like as
that's what debugfs is doing today for C code!  We need this to be as
simple as, or almost as simple as, what we have today in C or no one is
going to use this stuff and go off and attempt to write their own mess.

While I would love to have something as simple as:
	void debugfs_create_u8(const char *name, umode_t mode, struct dentry *parent, u8 *value);
like we do today.  I understand that this makes all sorts of
"assumptions" that Rust really doesn't like (i.e. lifetime of *value and
the like), BUT we MUST have something like this for Rust users, as
that's going to ensure that people actually use this api.

Look at an in-kernel function today, like ath9k_init_debug() that
creates a metric-ton of debugfs files and binds them to different
variables that are owned by a structure and more complex data structures
and memory dumps and other random file interactions.  We need, in Rust,
a way to do everything that that function can do today, in a SIMPLE
manner that reads just as easily as ath9k_init_debug() does.

So no "we will add write support later" stuff, sorry, real drivers
require write support in debugfs.

thanks,

greg k-h

