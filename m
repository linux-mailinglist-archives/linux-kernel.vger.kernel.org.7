Return-Path: <linux-kernel+bounces-843504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21611BBF9AB
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2CB434BCF6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C91F4615;
	Mon,  6 Oct 2025 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdqDZ4zK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0D7E0E4;
	Mon,  6 Oct 2025 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787332; cv=none; b=ewGWbaeGoXINOzkKnSBCjA/Z1A1ZIHGh/FTMvevXBvJ9NEV4/5RYtibY25SAohbcStsNk1TDNXUoQhVJ46GhuncUKOVGLMxN0r3C+8ESXMNSsB6PFb4EqI/4CRhxqu7f5X53TRGpav/HSo83pTeijO5fNc3k6TDcvkUQjVixj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787332; c=relaxed/simple;
	bh=FhFXbAt5Tcrp873gzHLu0KNZO7CFL3/ohu5dfI2mcrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEiosg1xea4xWtl+iJxdZMFt980HgVsjaKdRfztNXQsP2CZ9XoWJLgesoT3NUZzw7LxmHLnldG4XuYxjIpqDcLaZPrAeKZs8wWm0hAVKrfze8PTJrlc5GEZED87HplKXNPpRGxI5no+3zZL9s5S8wBfo8l4FmczhVhnNxahEpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdqDZ4zK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634EDC4CEF5;
	Mon,  6 Oct 2025 21:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759787332;
	bh=FhFXbAt5Tcrp873gzHLu0KNZO7CFL3/ohu5dfI2mcrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdqDZ4zKVFTBCMWdOVe7baTqd3UTWp46I5Mo1h1tRN9BzY8iVZaz0dO4yojmiLEYW
	 MxDZoNhZ5XvpCP6rs9px2qnvE3mILjBd1/aZh4/zflOh7UKqK1Zazg51Q4NE+2FqQM
	 k8Dj4EaYBHL9vCTRt0IedbhA7DTO00Q2sNgOG4yNpq7bJckDa4GK3Ysprk8ygj/N85
	 s7yRFUy1x+CWTlcIAbJZOnxkzZXOMOfaTxN8c7tCErq22ifn5xaTWltDoxkP86oULz
	 LjpgSqteUgFdfxje/ENISip9InY9Fq7nWyhDibZaQ97Q4Ct8o+T440hgJLupBX3GD+
	 Xy0nblr4SzKTA==
Date: Mon, 6 Oct 2025 14:48:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Nicolas Schier <nsc@kernel.org>, a.hindborg@kernel.org,
	alex.gaynor@gmail.com, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
	gary@garyguo.net, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, sam@gentoo.org
Subject: Re: [PATCH v2 6/6] kbuild: enable -Werror for hostprogs
Message-ID: <20251006214845.GA3234160@ax162>
References: <20250814-kbuild-werror-v2-6-c01e596309d2@linutronix.de>
 <20251005011100.1035272-1-safinaskar@gmail.com>
 <20251005205335.GA2561157@ax162>
 <CANiq72kDT_uDpmvMyMEXodSXP3rsevjzW7G134H9A7Pmx6_7nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kDT_uDpmvMyMEXodSXP3rsevjzW7G134H9A7Pmx6_7nA@mail.gmail.com>

On Mon, Oct 06, 2025 at 01:27:33PM +0200, Miguel Ojeda wrote:
> On Sun, Oct 5, 2025 at 10:53 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Thomas and Nicolas, thoughts?
> 
> I think it would be good to eventually split the hostprog flags into 2
> sets: the ones that are used for bootstrapping, and the ones that go
> after that.
> 
> That way, we can get the best of both worlds, if I understand correctly.

Does that buy us much? We would not want -Werror applied to
scripts/basic or scripts/kconfig without consent from the user. W=e
could provide that at that stage of the build (with an adjustment of
where scripts/Makefile.extrawarn was included) but CONFIG_WERROR would
not be.

Given how frequently fixdep and kconfig are built, I am fairly confident
that new warnings wtihin them would be reported quickly, even without
-Werror, so I do not see it as too much of a loss. All other host
programs should be covered by that diff.

It may still be worth doing for other reasons but I would have to see
what such a change would actually look like in practice before
committing to it.

Cheers,
Nathan

