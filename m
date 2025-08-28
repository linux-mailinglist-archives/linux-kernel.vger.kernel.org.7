Return-Path: <linux-kernel+bounces-789903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B95B39C59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF297C32C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAF73101B6;
	Thu, 28 Aug 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozAD7fvV"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9C17B425
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382985; cv=none; b=HwYVFPtlxPcT2YhOCqSRoSFVrkAoPC+9r6vnZ7jiKZMtZ7bV1DWxzR36rkCpLFgsynPDQnGoR4D7b0eikNSYcoVaEPjxuTnPSrabU48EyJk2GoZ3pwSdMkiE8UZ1dc7h+gDfaxHo3IropsgnsGWNXxd5BfUbNirw3/Ye7ZL1IUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382985; c=relaxed/simple;
	bh=3hgVzlfd4NToIgU3SDcM4IJcS4xyGL78KkaLtds3NOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FNyFahQO1F0CjWKe4GFRBT7PxXqZhOMhvnoRGHu85BDw+rqFATVSUUHi+kU0lTOWNzEh08ga1tQF7xFkmqNPBRZyPaLI3W+yqJL38EVZyzEJhfIB4N1ZKezMxn4yLyjA7gLFXo8uIMdgKfiDtZ0EZr3sDqIO/hK3edRO55X5WqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ozAD7fvV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b7d485153so1807775e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756382981; x=1756987781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HavNw+6wj7CZy0vJ8uYCxeS+2LLSGgwf2HHTPIdMtLo=;
        b=ozAD7fvVWjVXcSDNS2IAAJPee6NsjogZLTnbEFplX9ufPKM+ECWBi6riwDuA6zd11t
         9fQEQvtIWsBWTfEaJCFbMDInBzOiv9gXQ/rQB08hnEqGqLGYcQ37KbDL7JguKLNclF1Y
         uxdGNR5YN8qPF9qD8EnyXD3U+BMGkWwpaQoufBLL7su88NaJdMmFW4wVygs0RxNbJXD/
         8dsttHNo2G2LytOvnuV+kIZkH3glF6vaJofpeC2SiW9lai9kdyCFHXYx1g2jMmgttcGQ
         ak50nwnO1dlPkfpuaOcmzQqmQbdgCyKgf3zOdARlHY5fyB6hDzrpA7JtSZQbmh5v9fs0
         BRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756382981; x=1756987781;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HavNw+6wj7CZy0vJ8uYCxeS+2LLSGgwf2HHTPIdMtLo=;
        b=t/V1FlfltIUhDC/E6EmX26oMbLGT21kh3nbmu41DPU7kM455lqnxofY5byuA2up4Ix
         iKpT6LEWpv/wphzMx4a7tMc1wdtZeRNcmkMaSSV3LUZ/+WXfEn1RNdvYcmcfMQIu8TzI
         UVvJfNdDAPrE8vUy3/e9QlAygCCdi9Bg8yzogLWoZalfkaEPQp3C0swHYasZiL9svC9G
         H01LoQ+seRc5C/uecqWtBrzfzsseZ8XB9Ac8pOGSJqCDoENYJERW9IIwYjplgdXVF35j
         RlLAj4QMWbqa3BxyJSGv1gnhIatSbOjocErSWl+06fFMtjPZfDYJOR3TZRonW4gWTgSb
         XmSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUARH08Gs5bfvEdQwMbluvfyrQH8qQDIvNTfLb8Ys8/QnPVlwFW8zorIkig6uStjRh2DL6yu1GaVf5WiEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWe31kJd1AocPewu17PMf3IEAwj67ZaTn2wcGTSpksp9KhH5e
	S9g5x1M5yLIVXlQfD3gJJ+lqI8METBr6TbFAdsvTlRo1j0aXzn5vJtYmzLnzT89kJeqJ9dcvI7y
	cN0tTeaJcQpS1yw==
X-Google-Smtp-Source: AGHT+IHvhLLT/kC7PuOPio1cryunuDdCa/BS9BJvHCrzilaBbfUWPcBeesZqWuGm2DjaRZKle1v/SYyQ2ri+Dw==
X-Received: from wmhj12.prod.google.com ([2002:a05:600c:300c:b0:45b:7954:4bc3])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b26:b0:456:1ac8:cac8 with SMTP id 5b1f17b1804b1-45b517ad6c8mr197845955e9.15.1756382981471;
 Thu, 28 Aug 2025 05:09:41 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:09:40 +0000
In-Reply-To: <9cefb766-d6ca-4c82-84ae-8a47b1fc6e84@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com> <9cefb766-d6ca-4c82-84ae-8a47b1fc6e84@lucifer.local>
X-Mailer: aerc 0.20.1
Message-ID: <DCE1SYEUTLM5.3L54LZGH0QVAL@google.com>
Subject: Re: [PATCH 0/3] tools: testing: Use existing atomic.h for
 vma/radix-tree tests
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	<linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>, 
	<linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu Aug 28, 2025 at 10:28 AM UTC, Lorenzo Stoakes wrote:
> On Wed, Aug 27, 2025 at 11:04:40AM +0000, Brendan Jackman wrote:
>> De-duplicating this lets us delete a bit of code.
>
> Thanks very much! This is nice stuff.
>
>>
>> Ulterior motive: I'm working on a new set of the userspace-based unit
>> tests, which will need the atomics API too. That would involve even more
>> duplication, so while the win in this patchset alone is very minimal, it
>> looks a lot more significant with my other WIP patchset.
>
> I hope that my + Liam's work helped inspire you :)

Certainly! Unfortunately after spending most of the last week on it I
decided I need to cut my losses for the time being. I can see where it
needs to get to but it's hard to say how many more days I'll have to
pour into fiddling around splitting headers and moving definitions etc
etc etc. This unknown number of days is hard to justify investing right
now, given that I think there's a high risk people see the amount of
code movement and go "please immediately step away from my codebase":

=E2=9D=AF=E2=9D=AF  git diff --stat origin/master..buddy-tests
 include/linux/buddy.h                    |   58 ++
 include/linux/gfp.h                      |   36 +-
 include/linux/mm.h                       |   13 -
 include/linux/mm_types.h                 |  103 ++-
 include/linux/mmzone.h                   |  942 +-------------------
 include/linux/mmzone_types.h             | 1080 ++++++++++++++++++++++
 include/linux/nodemask_types.h           |    2 +-
 include/linux/page-flags.h               |   52 +-
 include/linux/page-isolation.h           |    8 -
 include/trace/events/kmem.h              |    1 +
 kernel/bounds.c                          |    9 +-
 mm/Makefile                              |    2 +-
 mm/buddy.c                               | 3618 ++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++
 mm/buddy.h                               |  738 +++++++++++++++
 mm/buddy_internal.h                      |  136 +++
 mm/compaction.c                          |    1 +
 mm/internal.h                            |  300 +++----
 mm/page_alloc.c                          | 4403 +++-----------------------=
----------------------------------------------------------------
 mm/page_isolation.c                      |    1 +
 mm/page_reporting.c                      |    1 +
 mm/show_mem.c                            |    1 +
 mm/vmstat.c                              |    1 +
 tools/include/linux/atomic.h             |   19 +
 tools/include/linux/bitops.h             |    9 +
 tools/include/linux/cache.h              |    2 +
 tools/include/linux/llist.h              |  317 +++++++
 tools/include/linux/math.h               |   12 +
 tools/include/linux/spinlock.h           |    1 +
 tools/testing/buddy/.gitignore           |    7 +
 tools/testing/buddy/Makefile             |   18 +
 tools/testing/buddy/buddy.c              |   40 +
 tools/testing/buddy/buddy_internal.h     |  256 ++++++
 tools/testing/buddy/linux/mm_types.h     |   54 ++
 tools/testing/buddy/linux/mmdebug.h      |   13 +
 tools/testing/buddy/linux/nr_pageflags.h |   12 +
 tools/testing/buddy/linux/seqlock.h      |    5 +
 tools/testing/shared/linux/lockdep.h     |    3 +
 tools/testing/shared/linux/maple_tree.h  |    6 +-
 tools/testing/shared/shared.mk           |    6 +-
 tools/testing/vma/linux/atomic.h         |   17 -
 tools/testing/vma/vma_internal.h         |    3 +-
 41 files changed, 6776 insertions(+), 5530 deletions(-)

Anyway, at least it resulted in a nice little cleanup for the existing
tests. And maybe I'll get back to it soon when I'm back to being
frustrated about how hard it is to be sure my page_alloc.c code works.

