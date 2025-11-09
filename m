Return-Path: <linux-kernel+bounces-891859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311AC43AB3
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EA43AD31F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7208271A9A;
	Sun,  9 Nov 2025 09:28:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2BA944
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762680487; cv=none; b=OaTSmu2+rTvUtCPG/jz7VifQcJ0Wg32qmyeJK68SNF2yWLZJS6z34fBJohl8t30FS8soQ1R2qHS/TLBNcfWfQ2E4Vl0iG1gyc4s1j5Z4Y1BMi74WphoaeHUyh1U8NGYe2UoF0vjCi+E6pfcSi4eGDuCuRj+NRn00ltqeKxcCShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762680487; c=relaxed/simple;
	bh=A5v3l/GD3DEOP2m1ic7gUKIMwmkjectHNhp87e6tSRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/8LsAVLA4EVCZq34O0Oufy1VJ7QlHuz1i7L4MQlZRpK2Day6VYZ0+YJ5zB+iarsGi6uoCw7r7b6IBWQBb7J7xxZzogrgKyPlXKMnhnke/ZsTkV3vgHVp65jSRqPnzFm6eczj7NDeUBqzdWehPRdw+b2b9XsLnSviHdbv8rp3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB7332F;
	Sun,  9 Nov 2025 01:27:55 -0800 (PST)
Received: from [10.164.11.1] (MacBook-Pro.blr.arm.com [10.164.11.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 032313F63F;
	Sun,  9 Nov 2025 01:28:01 -0800 (PST)
Message-ID: <9ab2c883-9707-4c30-9922-c2ff83d35677@arm.com>
Date: Sun, 9 Nov 2025 14:57:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Guidance on contributing to MM subsystem
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <cb17f29e-b45a-4275-ab2b-1443d909d944@arm.com>
 <20251109141452.7097-1-swarajgaikwad1925@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251109141452.7097-1-swarajgaikwad1925@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/11/25 7:44 pm, Swaraj Gaikwad wrote:
> Hi Dev,
> Thank you so much for your reply and for sharing your experience.
> I do have some basic understanding of how parts of the MM subsystem work,
> but I’m still struggling with how to find meaningful issues or tasks to work
> on. For example, I’ve been trying to explore various parts of the code and
> read through documentation to get a better grasp of how things fit together.
>
> In other open-source projects, like on GitHub, there’s usually an “Issues”
> section where contributors can easily find bugs or tasks to work on. In the
> kernel, should I mainly focus on exploring TODOs, adding selftests, or
> improving documentation (especially for new or less-documented parts)? I
> also believe branches like mm-unstable and mm-new might have ongoing issues
> or regressions, but how do developers usually find or detect them? Would
> simply building these branches expose such problems through compiler errors,
> or should I try building with different configurations (for example, using
> defconfig and other configs) to uncover potential issues?

Yes this may be an option, to pick up mm-new and build it with
various configurations which are not extensively tested, and stress testing
with mm-selftests/mm-tests by Mel Gorman, etc. I had my first bug report
by just randomly testing CONFIG_LPA2 on arm64:

https://lore.kernel.org/all/20240415094003.1812018-1-anshuman.khandual@arm.com/

>
> Even though I’m beginning to understand how different parts of the subsystem
> interact, I’m not sure how developers usually identify new bugs or feature
> ideas to work on. Once I understand the code flow better, how can I
> effectively find such issues or areas where help is actually needed?

I would say to not pressurize yourself to find tasks, but focussing on
learning the code. Try to review patches - that will increase your
understanding of the code, and it will make you sit in the shoes
of the poster and think "what made them think of this work?". Leaving
aside very big functionality changes, most of the patches, in my experience,
are found by extreme understanding of the code and while reading it,
having an aha moment of "this looks stupid", "this is a bug" or
"surely there is a better way of doing this".

I'll give some examples.

https://lore.kernel.org/all/20251017160251.96717-1-dev.jain@arm.com/

I figured this out when reading mprotect code and observed that we are
doing an unconditional TLB flush (via mmu gather) for arm64 - pte_needs_flush()
was not implemented there. It is obvious (if you know about pte protections)
that we don't need to do that for a transition from PROT_NONE to any other.

https://lore.kernel.org/all/20250610035043.75448-1-dev.jain@arm.com/
https://lore.kernel.org/all/20250718090244.21092-1-dev.jain@arm.com/

On arm64, ptep_get() becomes costly due to collection of a/d bits for cont mappings;
I literally went around the codebase and checked whether we can batch process ptes
to avoid this cost.

https://lore.kernel.org/all/20250908075028.38431-1-dev.jain@arm.com/

I observed that khugepaged is operating only on writable regions. This didn't make
any sense to me - I scanned the history and couldn't prove that this is of any
use, hence posted on the list, and the community agreed (and the performance numbers
agreed too, as described in the cover letter).

One more interesting example -
https://lore.kernel.org/all/13945f06-f862-4f80-904a-f2a4ccff3e4b@redhat.com/

While reviewing an unrelated patch, David Hildenbrand reads the code and spots a problem
with the existing code, which was brought in by my patch, and I had to fix it in this:
https://lore.kernel.org/all/20251028063952.90313-1-dev.jain@arm.com/


As you can see, we "observed" all these things. The probability of making an observation
is directly proportional to the knowledge of the codebase (as is true with any other
skill). Which leads me to the conclusion - focussing on finding a task may be counter-productive.
Reviewing patches will force you to read the code and find potential problems with it.

>
> Thanks again for your time and guidance!
>
> Best regards,
> Swaraj Gaikwad

