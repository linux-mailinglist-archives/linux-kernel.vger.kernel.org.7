Return-Path: <linux-kernel+bounces-788559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C75B38668
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466523A5D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6992750E2;
	Wed, 27 Aug 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fb//LxOD"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1BE18A6AD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307957; cv=none; b=ktx6gz9MnF1TkR7H6Osu7pY9r5oOzBA4O4IZryDzvO4MtfxCVmVLDuAmPHQE5LZWpqNiScR4GQxZRkn9O/q5Kjwu8NEjrGPuUTPtGCr1aBI0UBqMDTpMoXOwyGbrFEcweUOT0hQDQkwC9fdUAWC8JnVJ5f/uhFhJdf7zxIcK6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307957; c=relaxed/simple;
	bh=Kt3Udn/8Xkz3eQMsYEXGabwKtkHaEJrBLbjoYi4NyTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EBKgIDemipoRu/rqTpPEvYr8LMIcrDr/J6teL6GAPLwoyVcdEkdCS0Yr9fOwp9Mq+n2GT2jdR9dhGYjfxJPUy+TbWENER7jA9jVH9ZpoifyIAZvLEAhiEBbRxNdoUcLg5VTxmfKd9K5oQgt4t8XmOq6ya1sXb+SEXNmpDVIfqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fb//LxOD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0caae1so35698225e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756307953; x=1756912753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=26+u1vZm8GxbnUTWqM0HadqqbzPHef0N7bih2NyHOqQ=;
        b=Fb//LxODdNE45K7JFBVLaL77L4J9daosZNWIjbhLmV0M2B2Lx6g2G7qwBVnc6xLxk6
         rdgaHSwakH3kNmXiyg5B/WmlPLay3vWdLg3U/fuTNjuo8MYy+Imy5ynvsge4NpgIRRZG
         zQ/aQ4FId9xlbXqEF6TMy1kA7bQ40cqMJEkd34Ads5G2TsxNp7/bfe8frM8c7zNuGG7R
         l41eJueS0Ajo7gcXegN/YNJEBAOVAHg0fCklpKrb8gObea2bL2g6sCRa70xuw+RpLYwA
         y4XIevvOTuMM1puedm+CoEmdFiHRes2/Bm1buPEbuk0M1i7aOhWSGUhM7FRbz3ToYabB
         aqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307953; x=1756912753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26+u1vZm8GxbnUTWqM0HadqqbzPHef0N7bih2NyHOqQ=;
        b=gOmgvinCo1WyCsy2Hnh6JhHGTvoQGrIrMwlYmdEQgjSroW2pO1wnm58g9diQVySHw6
         wsi8NynQZgXxmHejL3o1p52t10AzEPsPPKiiqYzM102LUWyrUKJCCKQ5gN8QpMUgxQhe
         rpZfX9KpIhrmjLSCz9dVFd28wyAcqnP0J0AvAEAlCu70jpbiiLzL95+q05+wlfJR5Y9e
         IC40c6BYjB9gGLfKa125hdp7sfpC2LjiZY6OMsGcQHNPfGJDhabBSBZ5JFh3Yx661gIJ
         ofFT5N33vYMWEgfdjZ5YsTsvrzjjbxAxsUn6SiwSFIo06pXrkGPdLozwki1cWwfUYwP9
         idaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUWEOMYuXwdmzSn2JppNO7XrIJQonLpc8hT7ie8yM/BD4J7tNI4i1VhR0BLyYz/x0dCvvdoiVGKuhaC+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50kKUeS/jli+7h2uf2zWXEYzgKuh+zYeJdljiVXVXHa2PJoZF
	jyvFjChLj0Gdmyvls0u5IaFYJ1sAg4qPUBfrx6FHBYOKPSVmVQM3AF3kMbxYnIkcXFMDpGRIMRU
	FccVOJmOCvjJbVw==
X-Google-Smtp-Source: AGHT+IEKQVr/X7PUctYr0S2ZQywjoScHzWuQZ6wJrsqpJVFUkj/CHPN4LgbezPeCJmgfoN7X2qZ2PUA/itWFng==
X-Received: from wmbel18.prod.google.com ([2002:a05:600c:3e12:b0:45b:732e:5a16])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e8a:b0:459:ddad:a3a3 with SMTP id 5b1f17b1804b1-45b517ddbd5mr183215045e9.25.1756307953668;
 Wed, 27 Aug 2025 08:19:13 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:19:12 +0000
In-Reply-To: <xz2m4q24kgig36wu3enk6qlsxo5xywsaffgivyubadsps5topi@6yupqs7b7cze>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-2-5d3a94ae670f@google.com> <xz2m4q24kgig36wu3enk6qlsxo5xywsaffgivyubadsps5topi@6yupqs7b7cze>
X-Mailer: aerc 0.20.1
Message-ID: <DCDB7IYZS73V.2KL54A53D1O1L@google.com>
Subject: Re: [PATCH 2/3] tools: testing: Use existing atomic.h for
 vma/radix-tree tests
From: Brendan Jackman <jackmanb@google.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, <linux-kernel@vger.kernel.org>, 
	<maple-tree@lists.infradead.org>, <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Aug 27, 2025 at 12:56 PM UTC, Pedro Falcato wrote:
> On Wed, Aug 27, 2025 at 11:04:42AM +0000, Brendan Jackman wrote:
>> The shared userspace logic used for unit-testing radix-tree and VMA code
>> currently has its own replacements for atomics helpers. This is not
>> needed as the necessary APIs already have userspace implementations in
>> the tools tree. Switching over to that allows deleting a bit of code.
>> 
>> Note that the implementation is different; while the version being
>> deleted here is implemented using liburcu, the existing version in tools
>> uses either x86 asm or compiler builtins. It's assumed that both are
>> equally likely to be correct.
>> 
>> The tools tree's version of atomic_t is a struct type while the version
>> being deleted was just a typedef of an integer. This means it's no
>> longer valid to call __sync_bool_compare_and_swap() directly on it. One
>> option would be to just peek into the struct and call it on the field,
>> but it seems a little cleaner to just use the corresponding atomic.h
>> API. On non-x86 archs this is implemented using
>> __sync_val_compare_and_swap(). It's not clear why the old version uses
>> the bool variant instead of the generic "val" one, for now it's assumed
>> that this was a mistake.
>>
>
> I don't think it's a mistake. Namely we're checking if the cmpxchg occured.
> So in the new version you'll have trouble incrementing i_mmap_writeable from
> 0 to 1, where in practice you should (AIUI) see 0 -> 1 (old val = 0, retry) -> 2,
> which is obviously not correct here.
>
> At the very least you'll need some:
>
> do {
> } while(atomic_cmpxchg(&mapping->i_mmap_writeable, c, c+1) != c);

Oops, yeah my code is total nonsense here - thanks for paying attention.
I guess I "got away with it" because there's probably no actual races
going on when I run the tests...

Anyway I'll apply my brain properly next time I get the chance and send
a v2.

Thanks for the review!

