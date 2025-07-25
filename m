Return-Path: <linux-kernel+bounces-745205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD813B1168F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C007B5275
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3912236430;
	Fri, 25 Jul 2025 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGB7kjpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BB3A8F7;
	Fri, 25 Jul 2025 02:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411185; cv=none; b=NdX+OoqBrRhfg5LBOafPyT2cDW0R6+qr4KOk6KPCJ6ZyEjnaO/sQ0oQq7CytE/MN6jN3CodPgM7c7irsjB1+Njy7FmM5nOrJWHaE5uxqYbphasTWpsXIW2LlJn2KhDmflWgan9Sfx3S3GN7MPJBQJq+hzUa6+t3xnEHLZbLd1Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411185; c=relaxed/simple;
	bh=Ow3KMkXlS1cfsNBNVW27FA6tZxf1vHi8wn/vQ24Yy2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAUxYxZDYbLANXZPKwFnHnmagIbuU5z1dEy2aviDbpnB2Qfd8inwimbmlADrvFvKXjeuosDXCYGRoCByPj5oXovTIRVEeZZrgDH7RlTiSGf88k+cOVLFyf/P6O0QHQ5ZFM0e6tm/B7CyPqowstQbY7RjuvTACNXENQ42rz8tnQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGB7kjpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E778C4CEED;
	Fri, 25 Jul 2025 02:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753411183;
	bh=Ow3KMkXlS1cfsNBNVW27FA6tZxf1vHi8wn/vQ24Yy2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGB7kjpMtTrnJmR1Gy7RDi4tAvvYOh9XZt9Q7lLsa1ziTie/R7yUrIhdNPJ9+01zA
	 GQBb3ATO4KASaCiivQdXKXK5HPwre9Um3r2GEO+4Dc41KXboaq0o7cfahTLAhG46C9
	 +n+/K5QCOHkE/vvJkh/juLqe0QXKQLxxjsbiiDrj6W9neh7EmKuR42v0EVarCNeNIW
	 7pMzDDq3BKhOojce8qD7AeHtpdg3i61RuZwS0nizjwjARDfgXfQgMrPZE6PFF5JmQe
	 gyRYgdYdhiVDCUqxvaS/OyGP8rRTAk87YLC6boN32KTQWFCXjgoE37NYcGaAvGo3S3
	 i5x3nomtYMZJA==
Date: Thu, 24 Jul 2025 22:39:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
	Kees Cook <kees@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <aILubaRfgKCHBzPH@lappy>
References: <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
 <aILYj62tF_1mDjDO@lappy>
 <aILb-zDiDr4b9u9S@gallifrey>
 <aILjTKk_v8NPxlVJ@lappy>
 <20250724220241.21b5d5f8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250724220241.21b5d5f8@gandalf.local.home>

On Thu, Jul 24, 2025 at 10:02:41PM -0400, Steven Rostedt wrote:
>On Thu, 24 Jul 2025 21:52:12 -0400
>Sasha Levin <sashal@kernel.org> wrote:
>
>> We'll be hitting these issues all over the place if we try and draw a
>> line... For example, with more advances autocompletion: where would you
>> draw the line between completing variable names and writing an entire
>> function based on a comment I've made?
>
>It's not much different than the "copyright" issue. How much code do I have
>to copy before I start infringing on someone's copyright?
>
>But if you start using tooling to come up with algorithms that you would
>not think of on your own, then you definitely should document it.
>
>Heck, I do it now even for algorithms I get from a book. I'll credit Knuth
>on stuff all the time. Same should happen if you get something from AI.
>
>It's one thing if it finds a bug or formatting issue, it's something
>completely different if it starts coming up with the algorithms for you.
>
>And even if it is trivial, if you had it do most of the work, you most
>definitely should disclose it.

Steve, I'm advocating for disclosing more, not less :)

I think that if we try to draw a line, we have no way of doing it
without it being vague and blurry (and quickly become outdated as tech
around us keeps moving).

Adding metadata for the relevant toolchain bits (let them be the
compiler I use, the kernel-specific tooling I ran on the patch, or the
LLM that was used to generate code) has benefits beyond just LLM
disclosure.

-- 
Thanks,
Sasha

