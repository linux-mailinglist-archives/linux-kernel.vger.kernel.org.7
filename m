Return-Path: <linux-kernel+bounces-747453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E35B13404
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA29F1896A68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A6C21A95D;
	Mon, 28 Jul 2025 05:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG6J5+7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AB217739;
	Mon, 28 Jul 2025 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753679428; cv=none; b=FAMPqFq4CQg8VRS/U2xvtHEk5vE2VswY7jAmCfDmxoWr3G88oRAQEMIwTzQEy8TlZ9GmDyO+GheCnWRt4S8pmDXXYlzxjB2D/l0H1UiN2xYr+bDcSM4tHybKYUcnP5bhiNxoC88ltZ0aMgeNjjg+yNI2Ym8dRufI4OW/pk67ie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753679428; c=relaxed/simple;
	bh=I/lgky1vlEmkeZnYPRgBTs0w71g5CtPXfUUhevI4LPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDc9smjmhuW6COL0+r4muR7RcDc+Cu5qlqtsBmjNVtiRL9SodkI/g3DNosZtJUhcUl+NFHfgJmceiYt/G4hLxSeh2DXfB5nKQmvyo+YoG8SrPSNP9fwG2o+H3KLf1LWB/93kiBXj2BZDq240Tww7ryo7jycrpRvWrYXaP+ssSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG6J5+7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3525AC4CEE7;
	Mon, 28 Jul 2025 05:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753679427;
	bh=I/lgky1vlEmkeZnYPRgBTs0w71g5CtPXfUUhevI4LPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MG6J5+7He9A/gunZctHzh0TGLaadwGoomLAg5AUDrmRA6SnZQu/HQI0zpQz9P8g94
	 gZhBzb3UOV5M4hrZiNYQqzJ5yBQ76ipQg/ztPC8wNLE5SljYznmzlXTvzNDtWSlfaD
	 4nYyZnWWQ1mtL97+ed8VSNBkvHnvvvcYlxS2HGvEsWdN9sJQqvKONv4qLSNLN2Svnw
	 gWRNB+0x7Jmq3XGOKEMQ6gLWS/TGqJsuL251BHkcEQuuv9rbQ7YpS2xnJK7xgDt1/r
	 1o1xyK+VJeJGEHHC5ibbpS8CUG+ntPxNqWzfRd8JoCdubBQmO+XZkUKoqYZkEFUJCw
	 VA9VQbvTmGAow==
Date: Mon, 28 Jul 2025 01:10:25 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 3/4] agents: add coding style documentation and rules
Message-ID: <aIcGQR8tjmjr8dlb@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-4-sashal@kernel.org>
 <202507271939.D78EC559@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202507271939.D78EC559@keescook>

On Sun, Jul 27, 2025 at 07:40:36PM -0700, Kees Cook wrote:
>On Sun, Jul 27, 2025 at 03:58:01PM -0400, Sasha Levin wrote:
>> +++ b/Documentation/agents/coding-style.rst
>
>All of this is redundant.
>
>> +**No trailing whitespaces**
>> +  Never leave whitespace at the end of lines. Git will warn about patches that introduce trailing whitespace.
>
>If this isn't covered elsewhere in Documentation/, it should be. :)
>Also, "all files end with a newline"

This is a funny one. Yes, it's in the docs, but from my experiments the
tools kept "ignoring" this instruction.

I've asked around and the explanation that I got is that to manipulate
files agents call out to external tools, and often these interactions
are not perfect (if you use Claude you might have seen errors such as
"Error: Found 2 matches of the string to replace, but replace_all is
false.").

The end result is that those mis-interactions end up doing something
that the agent itself didn't intend on doing, such as adding trailing
whitespaces or having super long lines.

If we call these common issues out explicitly then the agent would also
look back at the code it generated to make sure that it doesn't actually
have any of these issues after code was edited.

>> +**80 character line limit**
>> +  The preferred limit on the length of a single line is 80 columns. Statements longer than 80 columns should be broken into sensible chunks, unless exceeding 80 columns significantly increases readability and does not hide information.
>
>And this is why redundancy is bad: our line limit is 100, not 80.

Hrm, it is?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n104
claims:

	The preferred limit on the length of a single line is 80 columns.

	Statements longer than 80 columns should be broken into sensible chunks,
	unless exceeding 80 columns significantly increases readability and does
	not hide information.

-- 
Thanks,
Sasha

