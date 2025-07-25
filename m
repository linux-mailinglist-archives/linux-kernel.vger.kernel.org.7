Return-Path: <linux-kernel+bounces-745139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCC2B11588
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CED3A84FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C991957FC;
	Fri, 25 Jul 2025 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9PMn74V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A318BBAE;
	Fri, 25 Jul 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753405586; cv=none; b=jmvUzVmjpumVDgdM/6TEYBfHG05OmDZqrMTFbzTvYQoqmUC5nYDmd8/fuwByCx+81mW4o6mQnwhZQgPIPg+TM44PqQ8uovGdTZHm1cJJfuP2FPiglwOZptFjfGT43LZw5Hly1XIsERY4foxtD+ZYmD2ZIur9XaWz1WfzUqxLvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753405586; c=relaxed/simple;
	bh=XRod0fl1x5YkTgo5sRuAN3KnxoLUBTn38asgNRfFLg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEAU4oOj/kFf5iOHWBGj8vBlt7lVFGNyt6a/bva+owPad1xiU4VFs7ZJNkAb/OYHRtfaxRv+hNiZyAeE+NTm6bubmvVUxcIEFZdvf5t+ydHwsFum8qi8QbhoP+cuXRy0FzzAYEVw1P6WuQ7UTzXcX8cmogWm1GTtBd663kTm+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9PMn74V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B63AC4CEED;
	Fri, 25 Jul 2025 01:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753405585;
	bh=XRod0fl1x5YkTgo5sRuAN3KnxoLUBTn38asgNRfFLg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9PMn74VGXda+ufmUKF1tASCMGoOASBy2/J9Wbj2ntkUHcAjkwFIfmC7NxjSo5fcB
	 Vhe2yZJvVczzXpiU86tyq8s7R1McsbeBeo7MBQwGtBwrHtsWA/85obea/sgqMqVv73
	 VUxpGDWULHfpMiN2Mhs/pdGc8bt2Cit/y+jSIycpACkJ1JmUl+6c268SA2ILUS6z52
	 NG+HC0i0O+U8L1ZTge0gqR9W34ENfsKk61SRDUwxhSu0cm/5XqjA32D2f3mBT94+iM
	 HZJP2QgOaL48OGjM7VWo/D2NzuaB68Si4ECuSalFxivhgXUxg3jMPFt9XxQe6NUVva
	 EfpMzgIO2pRPQ==
Date: Thu, 24 Jul 2025 21:06:23 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <aILYj62tF_1mDjDO@lappy>
References: <20250724175439.76962-1-linux@treblig.org>
 <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202507241651.5E9C803C70@keescook>

On Thu, Jul 24, 2025 at 04:54:11PM -0700, Kees Cook wrote:
>On Thu, Jul 24, 2025 at 07:45:56PM -0400, Steven Rostedt wrote:
>> My thought is to treat AI as another developer. If a developer helps you
>> like the AI is helping you, would you give that developer credit for that
>> work? If so, then you should also give credit to the tooling that's helping
>> you.
>>
>> I suggested adding a new tag to note any tool that has done non-trivial
>> work to produce the patch where you give it credit if it has helped you as
>> much as another developer that you would give credit to.
>
>We've got tags to choose from already in that case:
>
>Suggested-by: LLM
>
>or
>
>Co-developed-by: LLM <not@human.with.legal.standing>
>Signed-off-by: LLM <not@human.with.legal.standing>
>
>The latter seems ... not good, as it implies DCO SoB from a thing that
>can't and hasn't acknowledged the DCO.

In my mind, "any tool" would also be something like gcc giving you a
"non-trivial" error (think something like a buffer overflow warning that
could have been a security issue).

In that case, should we encode the entire toolchain used for developing
a patch?

Maybe...

Some sort of semi-standardized shorthand notation of the tooling used to
develop a patch could be interesting not just for plain disclosure, but
also to be able to trace back issues with patches ("oh! the author
didn't see a warning because they use gcc 13 while the warning was added
in gcc 14!").

Signed-off-by: John Doe <jd@example.com> # gcc:14.1;ccache:1.2;sparse:4.7;claude-code:0.5

This way some of it could be automated via git hooks and we can recommend
a relevant string to add with checkpatch.

-- 
Thanks,
Sasha

