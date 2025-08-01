Return-Path: <linux-kernel+bounces-753851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DA7B188F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367F45A16AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2A221572;
	Fri,  1 Aug 2025 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euBIlkv0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F616F8E9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085388; cv=none; b=RUfXxZQRx0N74AHXXhPj7v9TTCVEIZmH35QKO0kLK7uC1GHqrnBNAKGmTvyhNuBE13FQMziNrc+Q7ZZ4JVw/IQpStm+xPcG4m9KQZ2WtyCPXDE0uPVH57Ysa9Q5Q6W7zIvITgRP2mIW6Eet+C2W96KtCbWaFWrSu+AcrM4s0KP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085388; c=relaxed/simple;
	bh=7hEZjfVHsVFrCWk4VRJ0IR8tJXn2+S/PfLITW43SYfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSfeqhCLx3LOyc7vXgK1SNyVZ3vKMr37J5RsnNWs95h1SgMepPBhw5HOf4gFclEKwAkA72zDOc7SG9iFxhy5VB6J7kpOElE/xxmLWxfHpqNTQ5yIATw2Z8Iyx4/ynSStmLsBNlU2w4v5QywYnLNz+g2J15G9miCA3N2Ai44mOs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euBIlkv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411E7C4CEE7;
	Fri,  1 Aug 2025 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754085387;
	bh=7hEZjfVHsVFrCWk4VRJ0IR8tJXn2+S/PfLITW43SYfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euBIlkv0O+49/YsuKNYZBMRVQ5nW8mZou3U+SHI2LFeLzs74k9Pu4KIMN0Fn/Vd1f
	 tkHnrJ756TQEXEAoos4csrWq8spYPKhskireuQAG3WPALynJNk3lX7GhYeeGQtR+gv
	 kfLQTweVz/J32yG0AqFIno461ivEeh6awd5VoKzgkB37/55e24576Ptq7y+as1ZdHB
	 LGT/OIBMbhMs0HRfbp+yzRKCnIr71XPEnkYPgnMkuoseCkkFTU1vwTHYWcEZsFRv92
	 sgXBr1hB+Kjou+IhLu5KMsxHH+19CnAme/c+7Vw8JFkOJRBM3sjcoJMaGcqcnUwzes
	 ZqOVvM9kzm49g==
Date: Fri, 1 Aug 2025 17:56:25 -0400
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, surenb@google.com, aarcange@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix kmap_local LIFO ordering for
 CONFIG_HIGHPTE
Message-ID: <aI04CQZZzgCDO2A5@lappy>
References: <20250731144431.773923-1-sashal@kernel.org>
 <20250801141101.9f3555a172609cb64fde7f71@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250801141101.9f3555a172609cb64fde7f71@linux-foundation.org>

On Fri, Aug 01, 2025 at 02:11:01PM -0700, Andrew Morton wrote:
>On Thu, 31 Jul 2025 10:44:31 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
>> With CONFIG_HIGHPTE on 32-bit ARM, move_pages_pte() maps PTE pages using
>> kmap_local_page(), which requires unmapping in Last-In-First-Out order.
>>
>> The current code maps dst_pte first, then src_pte, but unmaps them in
>> the same order (dst_pte, src_pte), violating the LIFO requirement.
>> This causes the warning in kunmap_local_indexed():
>>
>>   WARNING: CPU: 0 PID: 604 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>   addr \!= __fix_to_virt(FIX_KMAP_BEGIN + idx)
>>
>> Fix this by reversing the unmap order to respect LIFO ordering.
>>
>> This issue follows the same pattern as similar fixes:
>> - commit eca6828403b8 ("crypto: skcipher - fix mismatch between mapping and unmapping order")
>> - commit 8cf57c6df818 ("nilfs2: eliminate staggered calls to kunmap in nilfs_rename")
>>
>> Both of which addressed the same fundamental requirement that kmap_local
>> operations must follow LIFO ordering.
>>
>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
>> Co-developed-by: Claude claude-opus-4-20250514
>
>Well this is innovative.  I doubt if Co-developed-by: is appropriate
>for this (where's Claude's Signed-off-by:?)

Claude (or any other AI) can't legally sign off on code :)

>I'd support creating a new changelog tag for this case.

This is in the context of a proposal on workflows@:
https://lore.kernel.org/workflows/20250728105634.GF787@pendragon.ideasonboard.com/T/#t

The Co-developed-by: usage wasn't my proposal, but it looked like the
majority of folks were okay with it.

Input is definitely welcome!

>And really, if AI was recruited in developing a kernel patch, it would
>be helpful if the changelog were to have a paragraph describing just
>how the AI assist was used.  At least, until everyone knows all about
>this?  You probably already have a presentation or a web page, so
>adding a link to that would suffice, thanks.

Kees actually has a good writeup about his experience with AI tooling
here: https://hachyderm.io/@kees/114907228284590439 , my experience is
fairly similar.

Kees logged his prompts as part of the patch he sent in
(https://lore.kernel.org/lkml/20250724080756.work.741-kees@kernel.org/)
which was interesting, but I didn't see much value in doing that beyond
the demo purposes as this is not really reproducible.

-- 
Thanks,
Sasha

