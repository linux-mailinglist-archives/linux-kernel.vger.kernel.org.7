Return-Path: <linux-kernel+bounces-819636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00FB5A3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5CE487799
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4C92877C1;
	Tue, 16 Sep 2025 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyml6Vna"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0A2882C5;
	Tue, 16 Sep 2025 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057843; cv=none; b=o5Z7d0IKvTljyLNRfbntuPu6cQkeHCx0y6TNduC+dgqq6nHTtqyN6K9W7BrqRt3wDy43fbfZzG26+W7HC/1Dlh64PVLQ01TYuVohRqf248ftpSa9a9cq5b9TBeaVlFKF+7M2R+kqvOr/D6RWtVonlfzBtXh4d8ZTvBt4SIQfZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057843; c=relaxed/simple;
	bh=Bsn4ypPMfuiV5NKNpmlXvY24AALUkCPIKhmhGYho/EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7bTQR8J6BmnfYl9xtVYnqRzRVieQ3MrRQPvA4NOCSHJDDOMskGEMleqzzKbDcCbJqDev0zfLf6IhUNM6F9bZoxwLbJUjZP0E3y3bXr4C8m6+E8pa9yabvcqghC5AZYStCCHjnG1PKtfiWQ/smsGlMDyAEKelycd1Ukqsv638S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qyml6Vna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7D9C4CEEB;
	Tue, 16 Sep 2025 21:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758057842;
	bh=Bsn4ypPMfuiV5NKNpmlXvY24AALUkCPIKhmhGYho/EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qyml6Vna2GlmWkaHpV2CzqTk/TiBPjZFisqocFlAqeSVjcfs9QIL2KzoA2KrY5pth
	 b7MhxxY7U5YhZNnxStCjrINja9Rv8OsCLHAjxZEYv5tOw0bmp30+g9oKjw02QZIG+6
	 mkHMJpbEAVYH3laODVT6tYnMxROLMQDMQ252ByfrlVf/HnMeJqzvTO9vXw7TDhY9bn
	 rQo5KY91IqevgCelioj87QElpShoX32TVqKGe5FU68bOYlLZm/o2FzLy19YpqJWfaW
	 OXGbe76phmRsRCy/t3kTfprp4UeQQd6ea5WaxuMFsTEZ2SdWulXiPZH852bB7Mj7KU
	 Yu5AuBqGksktg==
Date: Tue, 16 Sep 2025 22:23:54 +0100
From: Will Deacon <will@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com, corbet@lwn.net,
	catalin.marinas@arm.com, akpm@linux-foundation.org,
	scott@os.amperecomputing.com, jhubbard@nvidia.com,
	pankaj.gupta@amd.com, leitao@debian.org, kaleshsingh@google.com,
	maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v7 1/2] kasan/hw-tags: introduce kasan.write_only option
Message-ID: <aMnVarvAvQuJCWXy@willie-the-truck>
References: <20250903150020.1131840-1-yeoreum.yun@arm.com>
 <20250903150020.1131840-2-yeoreum.yun@arm.com>
 <aMm69C3IGuDHF248@willie-the-truck>
 <aMnGUr9zeutyPpAg@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMnGUr9zeutyPpAg@e129823.arm.com>

On Tue, Sep 16, 2025 at 09:19:30PM +0100, Yeoreum Yun wrote:
> > On Wed, Sep 03, 2025 at 04:00:19PM +0100, Yeoreum Yun wrote:
> > > +	switch (kasan_arg_write_only) {
> > > +	case KASAN_ARG_WRITE_ONLY_DEFAULT:
> > > +		/* Default is specified by kasan_flag_write_only definition. */
> > > +		break;
> > > +	case KASAN_ARG_WRITE_ONLY_OFF:
> > > +		kasan_flag_write_only = false;
> > > +		break;
> > > +	case KASAN_ARG_WRITE_ONLY_ON:
> > > +		kasan_flag_write_only = true;
> > > +		break;
> > > +	}
> > > +
> > >  	kasan_init_tags();
> >
> > I'm probably missing something here, but why have 'enum
> > kasan_arg_write_only' at all? What stops you from setting
> > 'kasan_flag_write_only' directly from early_kasan_flag_write_only()?
> >
> > This all looks weirdly over-engineered, as though 'kasan_flag_write_only'
> > is expected to be statically initialised to something other than 'false'.
> 
> For the conherent pattern for other options.
> Since other options manage arg value and internal state separately,
> I just followed former ancestor.

I'm not sure it's the best option to blindly follow the existing code
here. To pick another kasan "mode" at random, 'kasan_flag_vmalloc' is
initialised differently depending on CONFIG_KASAN_VMALLOC and so
allowing for the default value to differ based on the kernel
configuration makes sense.

But that doesn't apply here.

I'd recommend starting simple and just having the 'flag', especially as
you already made a small mistake because of mixing up the 'flag' with
the 'arg'.

Will

