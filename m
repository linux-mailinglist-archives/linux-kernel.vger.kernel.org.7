Return-Path: <linux-kernel+bounces-745173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B388AB11613
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E450916D23A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CF41FDE19;
	Fri, 25 Jul 2025 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZdntdGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25636632;
	Fri, 25 Jul 2025 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408335; cv=none; b=UMnv8WCENOBAp54+u3Yj5JXQEWQbs97nYBOHDb7iNtG8l9PsCZxSBxreuOs4j660NMVdHb4dIQkb323YAI5pgoydxwFHXFpZ3lfrBCkEZSxpfyfv5pDVfpp7mjmCZzpcNfpWx8kMdzSE2oHatLOCfHtPGriOQ3YcR9Qv3PV5bDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408335; c=relaxed/simple;
	bh=/NI2ha6nY6GkI8LsYbs7JqwG+hZm8ryAYwsWBGiCVZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrdjx3vq38waDcnIL90szR/JtDUiFCQ2C851/gF86y7FWMnizFIzXk1Tjz/b7vNMWLSKDiab7FQMabzAhx6rrT7A3R+M15fgVy6nBaDsFbFAba8rC6PeLRCQpQ5zarosxoGlf7e10yCys1isPkftJW1Gh++TfeSxr/dV/QN35j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZdntdGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EEEC4CEED;
	Fri, 25 Jul 2025 01:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753408334;
	bh=/NI2ha6nY6GkI8LsYbs7JqwG+hZm8ryAYwsWBGiCVZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZdntdGbql0vAlnOPcmXUnTPMwgWL/BoLDgx1wmsVsypNcM+d+mX/wZKnNgGf/e5d
	 wo8VK4rLuKCuDEqV8g2t2cNgeAy2TVe4PvdpyY/kmj1gA6sAiCoNqu7iNLlz2w1IIg
	 vU9p52m0FLe5AKCXMnjaDCqQZCZ9q9u8CuTwqy+FcMrHHNVLJtgsua1OlQ8tjSNMvE
	 4O6Hexz45U048wWiBPyusFQyn2nFChezo+jJ6IFHV66tIBV1dYFIBmRihg7u+Uk01+
	 EZxrN+mXuLoX/f+UZWwW/NLs803noTSI50CwwiQ/+yd0SJ5r8rmaZqCxbO+XkgoZMG
	 geBdyDfP8CAoA==
Date: Thu, 24 Jul 2025 21:52:12 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <aILjTKk_v8NPxlVJ@lappy>
References: <20250724175439.76962-1-linux@treblig.org>
 <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
 <aILYj62tF_1mDjDO@lappy>
 <aILb-zDiDr4b9u9S@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aILb-zDiDr4b9u9S@gallifrey>

On Fri, Jul 25, 2025 at 01:20:59AM +0000, Dr. David Alan Gilbert wrote:
>* Sasha Levin (sashal@kernel.org) wrote:
>> On Thu, Jul 24, 2025 at 04:54:11PM -0700, Kees Cook wrote:
>> > On Thu, Jul 24, 2025 at 07:45:56PM -0400, Steven Rostedt wrote:
>> > > My thought is to treat AI as another developer. If a developer helps you
>> > > like the AI is helping you, would you give that developer credit for that
>> > > work? If so, then you should also give credit to the tooling that's helping
>> > > you.
>> > >
>> > > I suggested adding a new tag to note any tool that has done non-trivial
>> > > work to produce the patch where you give it credit if it has helped you as
>> > > much as another developer that you would give credit to.
>> >
>> > We've got tags to choose from already in that case:
>> >
>> > Suggested-by: LLM
>> >
>> > or
>> >
>> > Co-developed-by: LLM <not@human.with.legal.standing>
>> > Signed-off-by: LLM <not@human.with.legal.standing>
>> >
>> > The latter seems ... not good, as it implies DCO SoB from a thing that
>> > can't and hasn't acknowledged the DCO.
>>
>> In my mind, "any tool" would also be something like gcc giving you a
>> "non-trivial" error (think something like a buffer overflow warning that
>> could have been a security issue).
>>
>> In that case, should we encode the entire toolchain used for developing
>> a patch?
>>
>> Maybe...
>>
>> Some sort of semi-standardized shorthand notation of the tooling used to
>> develop a patch could be interesting not just for plain disclosure, but
>> also to be able to trace back issues with patches ("oh! the author
>> didn't see a warning because they use gcc 13 while the warning was added
>> in gcc 14!").
>>
>> Signed-off-by: John Doe <jd@example.com> # gcc:14.1;ccache:1.2;sparse:4.7;claude-code:0.5
>>
>> This way some of it could be automated via git hooks and we can recommend
>> a relevant string to add with checkpatch.
>
>For me there are two separate things:
>  a) A tool that found a problem
>  b) A tool that wrote a piece of code.
>
>I think the cases you're referring to are all (a), where as I'm mostly
>thinking here about (b).
>In the case of (a) it's normally _one_ of those tools that found it,
>e.g. I see some:
>   Found by gcc -fanalyzer

I think that the line between (a) and (b) gets very blurry very fast, so
I'd rather stay out of trying to define it.

Running "cargo clippy" on some code might generate a warning as follows:

warning: variables can be used directly in the `format!` string
   --> dyad/src/kernel/sha_processing.rs:20:13
    |
20 |             debug!("git sha {} could not be validated, attempting a second way...", git_sha);
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
    = note: `#[warn(clippy::uninlined_format_args)]` on by default
help: change this to
    |
20 -             debug!("git sha {} could not be validated, attempting a second way...", git_sha);
20 +             debug!("git sha {git_sha} could not be validated, attempting a second way...");

As you see, it proposes a fix at the bottom. Should I attribute "cargo
clippy" in my commit message as it wrote some code?

Would your answer change if I run "cargo clippy --fix" which would
automatically apply the fix on it's own?

We'll be hitting these issues all over the place if we try and draw a
line... For example, with more advances autocompletion: where would you
draw the line between completing variable names and writing an entire
function based on a comment I've made?

-- 
Thanks,
Sasha

