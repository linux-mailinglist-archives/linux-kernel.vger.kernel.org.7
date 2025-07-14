Return-Path: <linux-kernel+bounces-729309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F188B034C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE41D7AC9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A071DF24F;
	Mon, 14 Jul 2025 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dX3MqPN+"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A219F11B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462112; cv=none; b=IVGxL60b+WpxvW5Vv6mQM04m5gdQJquhZzuwHtZGEbnrR0IkrnqjtRYc2FvS8KAPiGe5XGcrZzRI3qfQJySgiB+zNdHcrAG03fib2gXEBCO3Qo2QNOOLGqTxTLHdW9A0LA4Dh/c27+2VCZvCLARCRJrZdk7cokqeSiWWqL6ETjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462112; c=relaxed/simple;
	bh=Aq1rM+qcFw92PCMfk8PfrQHMyDeO9MCGzHbY26d4ThY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJe/I0hdhCtUCMHPdTpivzv6E3V3zPv8YSQ3+sQJ2EaGHnGhxdcJ5uL3TuTaDhW58LaamYoxv+PKCWFZ3sgEFwnJZcHqe9MmPuobVn0xHDD5F6CPN5Kbv2nI46rNwNljjf+fFCvvAESJ4wEE0Nm16OPoTZ0gq5nOTcKZhEOKlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dX3MqPN+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-187.bstnma.fios.verizon.net [173.48.102.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56E31DEx013642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 23:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752462075; bh=az4g3hsulj8mW1Cfag3L68fybzF+wNymkzqJ+vgeBNQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dX3MqPN+Eg+4Cjp6dFe9w9AYNzd+LEAVyIxXP+pWdSWPvyEaJ9NC421TY2v0MIvCr
	 MN4yXD7vPS9h71NBg2gLaa/aE9UXtvIS/zeRt3mo7mtzjJUUb1pRBCnMoifA9xiXGZ
	 dDIq7e8cvIoVE/3NIZ4fib75XHcwi4JZtMPR+7HKHw6I9wXAaAN/N9LtiNXVCjZXXp
	 m9sgXqf99nk9/+s+ghSlFHDD4cXlwUhxX7mVIuWfFdQEqFTG+4ToQ4bkIHa3nX2ZMz
	 CY7dNGUYdjm/zWgxRWAxESjT41iUVpc6wHFEUgPxXSidaDE719K+Nd+4+RjsuvIe0W
	 CYCoLoxoUNdRw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3704C2E00D5; Sun, 13 Jul 2025 23:01:13 -0400 (EDT)
Date: Sun, 13 Jul 2025 23:01:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
Message-ID: <20250714030113.GA23343@mit.edu>
References: <20250623073304.3275702-4-libaokun1@huawei.com>
 <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
 <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
 <mfybwoygcycblgaln2j4et4zmyzli2zibcgvixysanugjjhhh5@xyzoc4juy4wv>
 <db4b9d71-c34d-4315-a87d-2edf3bbaff2d@huawei.com>
 <e2dgjtqvqjapir5xizb5ixkilhzr7fm7m7ymxzk6ixzdbwxjjs@24n4nzolye77>
 <272e8673-36a9-4fef-a9f1-5be29a57c2dc@huawei.com>
 <kvgztznp6z2gwuujrw5vtklfbmq3arjg54bpiufmxdwmuwjliw@og7qkacbdtax>
 <9ecfe98f-b9d5-478a-b2a5-437b452dbd58@huawei.com>
 <6bf7irhdjrsvuodga344g2ulha52z65f2qf2l3tuldvwbb5pf6@cz7m2gypd4su>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf7irhdjrsvuodga344g2ulha52z65f2qf2l3tuldvwbb5pf6@cz7m2gypd4su>

On Thu, Jul 10, 2025 at 04:38:33PM +0200, Jan Kara wrote:
> 
> Yes, apparently both approaches have their pros and cons. I'm actually
> surprised the impact of additional barriers on ARM is so big for the
> single container case. 10% gain for single container cases look nice OTOH
> realistical workloads will have more container so maybe that's not worth
> optimizing for. Ted, do you have any opinion?

Let me try to summarize; regardless of whether we use
{READ,WRITE})_ONCE or smp_load_acquire / smp_store_restore, both are
signiicantly better than using a the spinlock.  The other thing about
the "single-threaded perforance" is that there is the aditional cost
of the CPU-to-CPU syncing is not free.  But CPU synchronization cost
applies when that the single thread is bouncing between CPU's --- if
we hada single threaded application which is pinned on a single CPU
cost of smp_load_acquire would't be there since the cache line
wouldn't be bouncing back and forth.  Is that correct, or am I missing
something?

In any case, so long as the single-threaded performance doesn't
regress relative to the current spin_lock implementation, I'm inclined
to prefer the use smp_load_acquire approach if it improves
multi-threaded allocation performance on ARM64.

Cheers,

							- Ted

