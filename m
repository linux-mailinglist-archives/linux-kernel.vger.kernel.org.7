Return-Path: <linux-kernel+bounces-842908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB997BBDF22
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6E73BD208
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACA27817F;
	Mon,  6 Oct 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEK8hTWg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF110FD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752103; cv=none; b=hCbwLwrbBWsNqesN9ru/xc70T2fJ8ZsVrAnbywSlE1Vqcqj6h/lM0ri9C1qCNSWYLABh8DM1CXCljXJaAmQABtpp4eVonkUlF2/WxAiyCSHwIEXgWYzFeajC3vAjkX5IJ88kz/k2rRImjTWnj6rYx5p0c00X+RPo6hpuzMQDSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752103; c=relaxed/simple;
	bh=KJCCmXxR0Jo79346y4t9YN9VEcxsTs6ZNPs0qbDdQDg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VYrnBEcOqNCFUV4yroomwqoZv/45UKt2Lj8cfSh/sAN9tQ2Dxzcg97/e1dhfjUWBo1xtxGh4LxhQDhJcP/GYDmE1clmCwwVowF8BtymlhJdrYhcRAIZ1wxiDJYkWbZTtwQOmuJrwItrF3lXWeiuJ1ae/EtSzz6e2vuGR+AJMGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEK8hTWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83106C4CEF5;
	Mon,  6 Oct 2025 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759752102;
	bh=KJCCmXxR0Jo79346y4t9YN9VEcxsTs6ZNPs0qbDdQDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BEK8hTWgoyceSzzuNRsvb90TKd1ujqMybqezIlUMv6mRlyejsNlP5KZ2AX8cts41C
	 sTuJmAsW8UVhJmI12o9ggNBotjnFgJIkmwMgiDdG/jqrZPwac/23ale9Y0IRI3Bmjs
	 QyjfHywpCEYWM2esSAJGwkPhBUDLCnHsDnBxedjFiNBPjO/bRBIAqZc5/1xLzFE5lJ
	 Q/Nm472zV1PV4PSWTm0Rj3SrGymO2f41CqfeoHi1KGuAhxXSTbdlbVW2+ca0jBFoB/
	 cAlJAZOLgDb1GSCSTF1sYkarno0DtI61RUKNkdBlUFb/da6Gld2cnxBV9zAxtHj8mn
	 uKSeAKwIWl65Q==
Date: Mon, 6 Oct 2025 21:01:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Thorsten Blum
 <thorsten.blum@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Update for v6.18
Message-Id: <20251006210139.122cad3973a85f93601082fa@kernel.org>
In-Reply-To: <CAHk-=whpwrrkPCmPa1dnejVr8AcJVpfyh0CfD-3sNhUO47A1dQ@mail.gmail.com>
References: <20251003084426.f2de6028fd74e1af4e13d190@kernel.org>
	<CAHk-=wg6=DwTD7xT3=Zya-ytYrtS2969KtnTWRPskq5fx2Ev+g@mail.gmail.com>
	<20251006092743.295205e486acf1b69ca61b89@kernel.org>
	<CAHk-=whpwrrkPCmPa1dnejVr8AcJVpfyh0CfD-3sNhUO47A1dQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Oct 2025 20:09:02 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 5 Oct 2025 at 17:27, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hmm, I applogise this error. I locally ran build tests and it passed.
> > But I might missed something.
> 
> So this is why linux-next exists - to get testing with different
> configurations, different compiler versions, different architectures
> etc.

Yes, I have noticed the limitations of creating a local test environment,
and I would like to utilize linux-next.

> 
> Local build tests are good, and obviously necessary for some very basic testing.
> 
> And local build test can be perfectly sufficient - if it's some small
> obvious fix, it's often simply not worth it waiting for a few days for
> linux-next to get it merged and tested.
> 
> And no, linux-next isn't perfect, and won't find everything anyway.
> 
> And even the most trivial small change that quite reasonably didn't go
> through linux-next because it was so simple can also end up breaking
> things.
> 
> So none of this is some kind of "absolute black-and-white rule", and
> none of this _guarantees_ that everything always works.
> 
> Even when everybody does the best they can, something will
> occasionally be missed. I definitely accept that we're not perfect.
> 
> But big new features coming in during the merge window had better be
> extensively checked _some_ way.

Yes, that was my fault.

> 
> If I find problems in my fairly limited sanity-check build tests, I get unhappy.
> 
> It's one thing if it's some little mistake that I feel reasonably
> missed testing for some understandable reason.
> 
> But if I get the feeling that the problem was that there just wasn't
> enough care to begin with, that's when I go "nope, this will need to
> wait for another release and be done properly".
> 
> And that's what happened this time around. That wasn't some trivial
> little change, and it clearly didn't get a lot of coverage testing.

I'm very sorry about causing this.

> 
> It should have gone through linux-next, and the problem would have
> been found there instead of when I tried to merge it.

Next time I'm sure the features are at least tested on linux-next.
I'm trying to update my PR checker to check it too.

> 
>                Linus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

