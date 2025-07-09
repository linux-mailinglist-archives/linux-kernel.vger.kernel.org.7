Return-Path: <linux-kernel+bounces-724571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4451EAFF478
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04B37AFE86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBD324501D;
	Wed,  9 Jul 2025 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFISVuME"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D9191F92;
	Wed,  9 Jul 2025 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099142; cv=none; b=b+QEqDV/3g27pynbWuRuCSXCZRFHj18BNHZFfGqkgO3h+/z36HdUpuExMwP1a6oyk7zWJzyrvtjuA8GgVspuL/HC1yEE/Ku5LHSSumGiKSBEleEelgqpXZZEH8LOPP9ArninO6Bk1vonQzx9yYVAiC0WC0Uip7DRUsZky2520/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099142; c=relaxed/simple;
	bh=tM2amfxutMMcLr6ADjVARG1A+z3whup2cIMhE2MUiWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IarMVrDFxxIT/hm5+7vv8ostgP0SLiQ3Tnw62/y8C6ixI0gE2nWlCIpzHXwObr5lnyWql9/4gkpqKBS/sfomiM//2EYc9Ws3Z4izs/FS3KkywsGircvIuhtgUX66onxEc5xrtmw11uc7ILmB2hacWnogIMpQIhgomCch/TizBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFISVuME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6652DC4CEEF;
	Wed,  9 Jul 2025 22:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752099141;
	bh=tM2amfxutMMcLr6ADjVARG1A+z3whup2cIMhE2MUiWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFISVuMEzS+yrHac7r0RY6AqbZCSJwcs6oB61cz60hqgXhybXouBMDqVlrJeEEypl
	 8qff8IceBaijnzdrBfXlW+4qBHS41ruIN7rsE1G7U5EyYVTY3FBf6HnF3iLFoi0P8D
	 v2gDVzj+LkBEI7xikS6iaqCc0+XO3B2KKQXEeS8g0OmRyz77mBpQFTa8G4P5/E/PGe
	 YblqsDTox4YH1tLQbNwcongTQzUSfG1ZNOoWEDNpwCyqJkQ1vqMICUirXtC7GUaJ9t
	 LWhipWTOs7LhMoNQczEqc8Yybo2EWly8IlebuAOSZ6m/wk4Cu5s3XfPMD6FuoP+Xr1
	 H/k1Su5UiPYjg==
Date: Thu, 10 Jul 2025 00:12:15 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v9 0/5] rust: DebugFS Bindings
Message-ID: <aG7pP1BTLQKInFrl@cassiopeiae>
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <DB7US8G7ISG0.20430M3P7I0K0@kernel.org>
 <CAGSQo01hORWAtrGaYp-_xxrAiN47JkJg=jiqnqdpw87QKzt9jg@mail.gmail.com>
 <DB7V19QE6KFB.3MR0BAOWXT7M7@kernel.org>
 <CAGSQo01drZoy1-j-+Y-BHHOX5AzCG4A5KiUOu5TJ40JOdfcB0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGSQo01drZoy1-j-+Y-BHHOX5AzCG4A5KiUOu5TJ40JOdfcB0g@mail.gmail.com>

On Wed, Jul 09, 2025 at 03:04:51PM -0700, Matthew Maurer wrote:
> On Wed, Jul 9, 2025 at 2:59 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Wed Jul 9, 2025 at 11:53 PM CEST, Matthew Maurer wrote:
> > > On Wed, Jul 9, 2025 at 2:47 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > >>
> > >> On Wed Jul 9, 2025 at 9:09 PM CEST, Matthew Maurer wrote:
> > >> > This series provides safe DebugFS bindings for Rust, with a sample
> > >> > module using them.
> > >> >
> > >> > Example interaction with the sample driver:
> > >>
> > >> I understand what you're trying to do here, i.e. showcase that values exported
> > >> via debugfs can be altered.
> > >>
> > >> The problem is that the current abstractions only implement read(), but not
> > >> write().
> > >
> > > I was trying to keep the initial bindings simple. Adding `write` is
> > > definitely something we could do, but I thought maybe that could be in
> > > a subsequent patch.
> >
> > Absolutely, yes! I didn't mean to ask to add it now. :)
> >
> > >> If you really want to showcase changing values, you can, for instance, create a
> > >> workqueue inside the sample driver and modify the counter periodically.
> > >
> > > This is supposed to be sample code, so ideally it should be as narrow
> > > as is reasonable in what subsystems it touches, no? If people would
> > > really prefer the sample schedule a ticking counter I can do that, but
> > > it already felt weird to be registering a platform driver in a debugfs
> > > sample.
> >
> > I'm not asking to do that. If the values don't change for now, because
> > there's no write() yet, that's perfectly fine with me. :)
> 
> Potentially I misinterpreted Greg[1], I thought he wanted to see how
> mutation would work.
> If we don't need mutation, I'm fine simplifying the driver to not have
> any mutation triggers and just export a few random things.

I mean, the most simple way would be to create the debugfs entries in probe()
and mutate them - still in probe() - right afterwards once. I think we should
do in any case. And AFAICT, this also covers [1].

> [1]: https://lore.kernel.org/all/2025070349-tricky-arguable-5362@gregkh/
> 
> >
> > >>
> > >> We really should not teach people to modify values by read() instead of write().
> > >> Also, without this workaround there shouldn't be a reason to export the exact
> > >> same value twice, i.e. no need for File<File<AtomicUsize>>.
> > >>
> > >> - Danilo
> > >
> > > How do you feel about the `Wrapper` struct, intended to simulate the
> > > driver doing its actual job and show how that would look? Is that
> > > similarly verboten, even though there's a comment on it saying this
> > > isn't how one should do things?
> >
> > Yeah, let's not do that -- don't give people ideas. :)

