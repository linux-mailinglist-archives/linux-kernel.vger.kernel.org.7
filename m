Return-Path: <linux-kernel+bounces-755761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0DB1AB77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51F1162211
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19035290BA2;
	Mon,  4 Aug 2025 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF1k560N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68C1E1DEC;
	Mon,  4 Aug 2025 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754350244; cv=none; b=oSDvjAialRLxGo/0o98dEl8N6ijQWjKWfJFd3Ec3PwJMKjKv4VnQ8ZCqPxw1sFwSsqDmGM4krGpUdlgEIWBDpnt49JhSafjWOFoZCrlCbht82UWq9TckExPSYv2HPSah1fvJ5MtBAWyGr7pP2TeaYvRyWRbGe8Ie1KmZ45cUbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754350244; c=relaxed/simple;
	bh=NYjzkyjb84ln5UC1RkC1zUZJoWNYCApeTT/I1dkOym8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egRieDhdD699zkq6Ee4gHCvpNAddA0vLdBidggHaIIRP6dJKkOAj92XlCa/8OOzFibAuV4VuBr70acbFdOFPNMKrZ510OOkMFZ8dOW5lcAGic2hFi5JgKotzKIwAqF473JW0rRFP7lx3hrNhwkQDWMJ8El8q/LCRvbRHCCESRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF1k560N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E9DC4CEE7;
	Mon,  4 Aug 2025 23:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754350243;
	bh=NYjzkyjb84ln5UC1RkC1zUZJoWNYCApeTT/I1dkOym8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vF1k560N5yjLb2CTzkSN+C/4SKi1wFqN/OSe1Z5mctBEopx1U6ISqTWRaJNQpZOns
	 /PIbKYVRtDxPB2HKjbqZgcb3sT/0rqTp+MrG73RN1u2YuQW5YZgLWKTgnU3EdiqQEE
	 l6onp8tf8n0r0v4tJ8VdryQL+tlkD8DuVrB/TyIXN8rAoFm6wwqr5fpXp5ox5jOgy8
	 qAD7Pe3P5jE1fXEUc4flmxFY5ZOTaLQT/DYNbLZzb//YsMIhbhXwqaIvs8OF2XtZ13
	 cmgV+AudnUPO3LDNZMQdrYpbmwps+viu1XbUQxLloAbfvIbYYaFC6Hzsp8dwqUZHTX
	 a+FqOHrsI9CCw==
Date: Mon, 4 Aug 2025 19:30:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: dan.j.williams@intel.com
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <kosina@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aJFCoewqTIXlhnJk@lappy>
References: <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
 <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
 <2025072832-enrich-pampers-54b9@gregkh>
 <1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com>
 <aId1oZn_KFaa0R_Q@lappy>
 <aJB8CdXqCEuitnQj@tiehlicka>
 <aJC0ssMzX0KWnTkG@lappy>
 <alpine.LRH.2.00.2508050000580.22517@gjva.wvxbf.pm>
 <20250804181447.0c518b14@gandalf.local.home>
 <689139fe23f49_55f0910076@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <689139fe23f49_55f0910076@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Aug 04, 2025 at 03:53:50PM -0700, dan.j.williams@intel.com wrote:
>Steven Rostedt wrote:
>> On Tue, 5 Aug 2025 00:03:29 +0200 (CEST)
>> Jiri Kosina <kosina@gmail.com> wrote:
>>
>> > Al made a very important point somewhere earlier in this thread.
>> >
>> > The most important (from the code quality POV) thing is -- is there a
>> > person that understands the patch enough to be able to answer questions
>> > (coming from some other human -- most likely reviewer/maintainer)?
>> >
>> > That's not something that'd be reflected in DCO, but it's very important
>> > fact for the maintainer's decision process.
>>
>> Perhaps this is what needs to be explicitly stated in the SubmittingPatches
>> document.
>>
>> I know we can't change the DCO, but could we add something about our policy
>> is that if you submit code, you certify that you understand said code, even
>> if (especially) it was produced by AI?
>
>It is already the case that human developed code is not always
>understood by the submitter (i.e. bugs, or see occasions of "no
>functional changes intended" commits referenced by "Fixes:"). It is also
>already the case that the speed at which code is applied has a component
>of maintainer's trust in the submitter to stick around and address
>issues or work with the community.
>
>AI allows production of plausible code in higher volumes, but it does
>not fundamentally change the existing dynamic of development velocity vs
>trust.

Right: I think that the issue Jiri brought up is a human problem, not a
tooling problem.

We can try and tackle a symptom, but it's a losing war.

>So an expectation that is worth clarifying is that mere appearance of
>technical correctness is not sufficient to move a proposal forward. The
>details of what constitutes sufficient trust are subsystem, maintainer,
>or even per-function specific. This is a nuanced expectation that human
>submitters struggle, let alone AI.
>
>"Be prepared to declare a confidence interval in every detail of a patch
>series, especially any AI generated pieces."

Something along the lines of a Social Credit system for the humans
behind the keyboard? :)

Do we want to get there? Do we not?

-- 
Thanks,
Sasha

