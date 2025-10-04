Return-Path: <linux-kernel+bounces-842092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFE5BB8EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F22189D46E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1691220694;
	Sat,  4 Oct 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkBXJq6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964921CFE0
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588744; cv=none; b=Njr5SyWjKBEBlFD8KQhYCPjCNBCDLvAGVz3xszFJbgOEDPsL1zfpYNyBbz0tfKJc+P6YKdp9AzrIsVKjNZiOqIHlgfPCn1zdgPBXMEcgPikrZLlk2YZ3k1bNudY2bfLCPIjXnPlq24pIOVSPocHwGkf+VWAnphOlRWEj4Mtj44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588744; c=relaxed/simple;
	bh=CU4IyP59fvnnZfxva5otQfWg9Fb1lMlbNTZnIUrWsf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eG8/TSB10Iuu8strkI7Bg1yi8/w9/lbjEVBdD7MaRTynhO5Dcxa6JfHdb8CShHXpKA9w5TqN9v7oYeviXlp1VtQjiDoYBg5sQZogDb8TpgkLt6+jIY/TJxg1MLp8Z51uryQZB4qfKcIxP4Y69eXMeHX8xcnqfTe6q3btAIUJ/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkBXJq6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AFBC4CEF1;
	Sat,  4 Oct 2025 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759588743;
	bh=CU4IyP59fvnnZfxva5otQfWg9Fb1lMlbNTZnIUrWsf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkBXJq6qkbO7i6nf0aUd10sBTVDkCgTv3MM5KKGAFvMNe+LrTaZkZVUqcQwC9PYiF
	 Wb3KBkVtzxQ7OVS52dpogzHlKwU5Y+f09n0kqG5h3wioBK4mzkgvbMAOD8uKBtakD5
	 noKvQQzr9PDABPOFAC6snZmrYUpJpIZynIiivBCXGU7AlydsgEx3T4QVTS8J1V/M8H
	 BRwBjlKjEn/Fn8rtq5S/5Fgyqrntx4VJ7Ye0Q1dWJrFT2/V8Kbo6Zzs7Cn32Cz8hV7
	 oh5rliLhdCjU4hTqSTBvOjDxjty6V33MStSgNShrZgu/LcaYnLvLp/EGjsr8mpPhqg
	 7MQpJXHhWpSDw==
Date: Sat, 4 Oct 2025 10:39:01 -0400
From: Sasha Levin <sashal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	konstantin@linuxfoundation.org
Cc: Dave Airlie <airlied@gmail.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm for 6.18-rc1
Message-ID: <aOExhd-d1Eq-X_uw@laps>
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
 <CAPM=9txjNo==nMA7XcjzLWLO155+1bk2THwPs_BmTLu_5kU_bQ@mail.gmail.com>
 <CAHk-=wgR61VxiHyOKXBJv_HinoFVA2av1EuSHg5NcRGC1fNq3w@mail.gmail.com>
 <CAHk-=wgX-2+hH5fM344_wKYNZS5CSf4ispS4X+s5xkma_Mdu_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgX-2+hH5fM344_wKYNZS5CSf4ispS4X+s5xkma_Mdu_Q@mail.gmail.com>

On Fri, Oct 03, 2025 at 01:02:43PM -0700, Linus Torvalds wrote:
>On Fri, 3 Oct 2025 at 11:09, Linus Torvalds
><torvalds@linux-foundation.org> wrote:
>>
>> If you get pull requests from the people you pull from that make it
>> harder for you to do a better job, please push back on them too.
>
>Side note: this is actually an area where maybe it's worth looking
>into just having automation.
>
>I've actually been fairly impressed with some of the more recent
>AUTOSEL AI summaries, and I wonder if it might help maintainers to
>have some kind of "summarize this pull request" infrastructure. I'm
>not so convinced about the code-writing side, but summarizing
>changelogs sounds useful but also rather less scary.
>
>And I'm not suggesting that because I would use it to summarize other
>peoples pull requests, but as a way to make it easier for maintainers
>to write summaries of their own pull requests when they have lots of
>different things going on.
>
>Adding Sasha to the participants, since he's been doing the AUTOSEL summaries.
>
>(Some of them have been just garbage, but a lot of them have seemed
>quite reasonable. So as a starting point - rather than as the final
>case - I think maybe some of those LLM's might be useful for other
>things than making amusing fake videos)

Thanks for looping me in and for the prod on consistency. I agree that writing
a clear commit message or pull request summary is often harder than the code
change itself.

With AUTOSEL we’ve seen that AI can help when it’s grounded: recent agentic RAG
approaches let us draft summaries from the actual commits, tags, diffstats, and
paths rather than free-form guesses. We still treat the result as a bot-edited
draft, not an authority.

Looping in Konstantin who looked at adding extensions such as these to b4 - we
should definitely look at adding more AI tools to support maintainer workflows
with good guardrails (including sourcing every claim from the input data,
failing closed on low confidence, ...).

Some more b4 ai ideas:

- b4 ai summarize <range|branch>: Draft a maintainer editable summary
   (headline, grouped highlights, notable fixes/reverts, stats), with links to
   source commits.

- b4 ai cover <series>: Generate a first-pass cover letter for a series or
   topic branch, preserving style knobs (indentation, bullets, length).

- b4 ai risks <range>: Surface cross-subsystem touches, large churn, and code
   with prior regression history.

- b4 ai validate <range>: Check that summary claims are supported by
   commits/tags. Flag low-confidence sections.

- b4 ai style --indent=2 --max-lines=...: Apply consistent formatting to the
   generated text without changing content.

-- 
Thanks,
Sasha

