Return-Path: <linux-kernel+bounces-759907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C9B1E45E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD4F6252F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC5F263C8F;
	Fri,  8 Aug 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyNUOVF2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F14A11;
	Fri,  8 Aug 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641620; cv=none; b=ms2wAzYBnkfDpkOdQP0Brds2nX/QCOuO9hG80LeU8E03kUtdJ5QQaoZ3s6l+XcAebyubSN5uruIMwtPoaUL17uIiLMcPnIhWDe/CalqEmbLJZRj24trBlt0M2cueF2ZU8oipAprKgkGMNbUyUb4fkeF3W11rDX1fYOAy0rZCPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641620; c=relaxed/simple;
	bh=I4N4dl4z4DTanlVPL2QujXbcroCNfVZ626nIJSSpFiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SVxHsD/ZedWIXXAW4bbU5cPgKf7pO9URCfks4q4NtQT+wI012+Dp9rKyM48aNcAq4ZVUouMdibLd0lx3krlN6mUfFTi1SBg0TwnwjxBuRgmCbOVhOYSFSUS40AdsyKl79G/gjsdAGNfKAitrNaYLg94BIZszZIx12T1GmLG6XX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyNUOVF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D268C4CEED;
	Fri,  8 Aug 2025 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754641620;
	bh=I4N4dl4z4DTanlVPL2QujXbcroCNfVZ626nIJSSpFiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YyNUOVF2+JMpCtTSdb8Tzu5i1MtjbdZ8uiei45jk3ktyTaiUSFM45NW6Nl9LU4mjo
	 /pnWIfvIqWDfcKLmjFyI4q88IgbXWFmeobGRpnQokGetqt569wP9TY6F852u16i+Ij
	 GfpyrAUclOMfNX95OGy/H1q3i/Dsx00fBSz+SzFtFG4aJbXtJ01f6qKmQVm6IBrUVV
	 vGq8J/9srzbFYZ8G3Vd2Med5P/608rdPuzj87lAM8GKQpHAvv2rx6SsIJ7//HqnDN9
	 oM9vUBoMC0z+iSlDD3LdIf7i1SjlVgGJ4Av8d4vRMz6tJF9etn1lHMPiGZI/rxcV8n
	 wjb++0c3VeGqA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v6 0/7] rust/hrtimer: Various hrtimer + time additions
In-Reply-To: <20250724185236.556482-1-lyude@redhat.com>
References: <9bH1XUWr5rhB6Ke8MMK7YgWFGkRpE1LlW65AAIBFM3aTmjQgRgZq76rrlhRxLc65lzsr-yAHGZMum9kee-165w==@protonmail.internalid>
 <20250724185236.556482-1-lyude@redhat.com>
Date: Fri, 08 Aug 2025 10:26:40 +0200
Message-ID: <87zfca5idb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> This is a collection of various bindings that I added to hrtimer when I
> was originally getting it ready to be used in rvkms. I've mostly been
> waiting for Andreas's hrtimer series to go upstream before submitting
> these.
>
> All of these are currently being used within rvkms for vblank emulation.
>
> Previous versions:
>   Version 1: https://lkml.org/lkml/2025/4/2/1474
>   Version 2: https://lkml.org/lkml/2025/4/15/1750
>   Version 3 (only a revision of one patch): https://lkml.org/lkml/2025/4/15/1780
>   Version 4: https://lkml.org/lkml/2025/4/29/1715
>   Version 5: https://lkml.org/lkml/2025/6/13/1785
>

Thanks for working on this series!

I would really appreciate it if you put more details in your version
log. Everything takes longer when I have to search for changes between
versions.


Best regards,
Andreas Hindborg




