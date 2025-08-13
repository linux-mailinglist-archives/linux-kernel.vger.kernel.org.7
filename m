Return-Path: <linux-kernel+bounces-766084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC318B24212
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB203B3C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8662D5C86;
	Wed, 13 Aug 2025 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHN/gFDO"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE4271468
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068368; cv=none; b=m0OUiRLIiGyUcwJvQct5ojD9tap+YTQL+Lx/QQ2M0+uvo0ydCe9Jhle8AAvcu8FaZi6piRVrX/Obu1w09FatwfH2SnrcNIIF4mXxwp6NUmZnaZIT+i0nH59hmhEeahN3D/6tluEyg7EbHNcfICPKkha29UaX0Bd5KpdGGmhqjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068368; c=relaxed/simple;
	bh=AvuJGqqlDBGaf++1QTwjiVlyO8wspUq8bXNzAJNClls=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BxKrWLSm1Wrifx+M5xrLBz4uHN+y/Va79om3COf6kdqXP07EWVPfl97P3BYAzGt6sZddEo3BPEVsqZAnu/NdYFqfVgyQM6mpN2KjRwLEUAAjWC4nN9uB/V5sSXklM06TYYIKs7lH2emDivzIEG2JellcMlEruSKwNwn8NE1UIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHN/gFDO; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8fdbd45e10so5063183276.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755068365; x=1755673165; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4c2Exxn9N8GOxJ4EP0dbpK/kCpIo2tAYpKzr78hu7S8=;
        b=cHN/gFDOsxaxCE+UFRawSGcAMWfyC0yyszzobvuye5ninC51IxvJ2LGtSihnrPHxwU
         RPzqzLBFkcAbEkwG00YCkaQ/Gzt2D/RUQZwyAeVKYXl0iIdWOz+hiiBvmG+f09A9xpP7
         e8RB4nVo5skkwS1tdDNx1cg7vUQLgNx1Iv+qcpKPmCoB1oWHPFceBXwwN1iLGTEuWKet
         Ns0NS6662AgtLw/9bMYB4zlQo+ni8Akpv6UkOjYBXsO6k/11l9F9b3yLy2TuccxyDaod
         mEUY2tjqn9MZl3suwtY6lSGlllPlG5sCOEvXVUruoayswdcJr02fctZUGC4ffbM0ZiDH
         6cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755068365; x=1755673165;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4c2Exxn9N8GOxJ4EP0dbpK/kCpIo2tAYpKzr78hu7S8=;
        b=HWLBT7PRDTK2C6KSlMIhC8+7q7Pa9oIX8HaqKg854tYjfpmr9UT5+8zc5XIHlq2IHp
         xQJSUaBfH+7BHrtIg33GdR/l57f1Q6vrnhAn7m68swbYIOW+Z4BAsPSCS7qz8LHu6z9N
         ImyHi2p6pNAKUEA5OSeqysDZw11/vggxYsdGDZJ/PqT9JeFb08rdhDvyBRxSHXX9cehU
         hgQ0jFc5HLg9wLm+17m2xdUs7Ec+aOTGouDKFjnj2iL4YHLGFkp0trDE9SINjyTJ63dG
         XxBjTfu//hLsopac2zk3ACSqMucOJPF66HBiH0GIg5HcGxm+Ryd+HffeLgTq33qRDRn4
         vLYw==
X-Forwarded-Encrypted: i=1; AJvYcCXq9hYD27zrPRthrgvjhgQGye2M1IJ676P9O4oi+G0OJ02WCUtga0d8XoYrjFEXrrtWJmSaIAJdyHofMcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh86XTqLlLpIhFnvHGTfHXz1GC/owtLy3XfnT+JudX1VNeOsOk
	X5LGZc3MhJ4hZwPLLP0Q8LfOnzoAnDWVFVcuzKu5kMi9aGkP60vKgaAdPxXUpjD3RQ==
X-Gm-Gg: ASbGncu7ckfc/ZuOXjXmIxSZvhejqYgXowpCLlrH9mTK0nh3Ijej4aGZ3YDFcu6t0t7
	8CJz45DgsLpKqGkx8n6CethWdLFnWHYNbKe1UfYKha2vtX/gClun45xYW4Awb+jeq9CHnpw4JWn
	7ZcoEO2TkTF9sLNBow4rcJCa0UwcEZQRSgI8eh5dW/27m6INxDQhyKjSZ2OiV2oXwU9tjxeEt+a
	l0XVIdA4ZJRebdiF285LUAFMGfDhoBHeplmWs4ElvScX/cahTrUoGAwX4bg660xWdNEgGEmcU1h
	nFaIhk3sip2niYyOMnUPOh0h38yWqrboev1m7DfoMkFgyEo0a+3gMQlFqBY47d2cBfswE/T9sXc
	aqRDmp4JadhmBmoGlYC1oRKZ8Yjrh2XX7ktLrn43gwuB5Twy2CdotlGs1NOi2jFd6Geo2k1n7tz
	6x8lN0T0JVJnGL9dUApw==
X-Google-Smtp-Source: AGHT+IGB8+DtY8l2es3xfQ1AnhxzKizng1sEXEebwAXM8umoPlukJ8aYL7FjuHimETfAZ2KECwCAgA==
X-Received: by 2002:a05:6902:2a8d:b0:e90:6e1f:56b3 with SMTP id 3f1490d57ef6-e930bf3ea4emr2208666276.7.1755068365140;
        Tue, 12 Aug 2025 23:59:25 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e905a067e86sm3927980276.7.2025.08.12.23.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:59:23 -0700 (PDT)
Date: Tue, 12 Aug 2025 23:59:11 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
    david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
    Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
    dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: shmem: fix the strategy for the tmpfs 'huge='
 options
In-Reply-To: <e6898dca-d6c6-465c-a373-8298858839ab@linux.alibaba.com>
Message-ID: <3705f034-808a-4afe-5dde-4b4e9815a8d0@google.com>
References: <701271092af74c2d969b195321c2c22e15e3c694.1753863013.git.baolin.wang@linux.alibaba.com> <e6898dca-d6c6-465c-a373-8298858839ab@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 Aug 2025, Baolin Wang wrote:
> On 2025/7/30 16:14, Baolin Wang wrote:
> > After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
> > we have extended tmpfs to allow any sized large folios, rather than just
> > PMD-sized large folios.
> > 
> > The strategy discussed previously was:
> > 
> > "
> > Considering that tmpfs already has the 'huge=' option to control the
> > PMD-sized large folios allocation, we can extend the 'huge=' option to
> > allow any sized large folios.  The semantics of the 'huge=' mount option
> > are:
> > 
> >      huge=never: no any sized large folios
> >      huge=always: any sized large folios
> >      huge=within_size: like 'always' but respect the i_size
> >      huge=advise: like 'always' if requested with madvise()
> > 
> > Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
> > allocate the PMD-sized huge folios if huge=always/within_size/advise is
> > set.
> > 
> > Moreover, the 'deny' and 'force' testing options controlled by
> > '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
> > semantics.  The 'deny' can disable any sized large folios for tmpfs, while
> > the 'force' can enable PMD sized large folios for tmpfs.
> > "
> > 
> > This means that when tmpfs is mounted with 'huge=always' or
> > 'huge=within_size',
> > tmpfs will allow getting a highest order hint based on the size of write()
> > and
> > fallocate() paths. It will then try each allowable large order, rather than
> > continually attempting to allocate PMD-sized large folios as before.
> > 
> > However, this might break some user scenarios for those who want to use
> > PMD-sized large folios, such as the i915 driver which did not supply a write
> > size hint when allocating shmem [1].
> > 
> > Moreover, Hugh also complained that this will cause a regression in
> > userspace
> > with 'huge=always' or 'huge=within_size'.
> > 
> > So, let's revisit the strategy for tmpfs large page allocation. A simple fix
> > would be to always try PMD-sized large folios first, and if that fails, fall
> > back to smaller large folios. However, this approach differs from the
> > strategy
> > for large folio allocation used by other file systems. Is this acceptable?
> > 
> > [1]
> > https://lore.kernel.org/lkml/0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com/
> > Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> > Note: this is just an RFC patch. I would like to hear others' opinions or
> > see if there is a better way to address Hugh's concern.

Sorry, I am still evaluating this RFC patch.

Certainly I observe it taking us in the right direction, giving PMD-sized
pages on tmpfs huge=always, as 6.13 and earlier releases did - thank you.

But the explosion of combinations which mTHP and FS large folios bring,
the amount that needs checking, is close to defeating me; and I've had
to spend a lot of the time re-educating myself on the background -
not looking to see whether this particular patch is right or not.
Still working on it.

> > ---
> 
> Hi Hugh,
> 
> If we use this approach to fix the PMD large folio regression, should we also
> change tmpfs mmap() to allow allocating any sized large folios, but always try
> to allocate PMD-sized large folios first? What do you think? Thanks.

Probably: I would like the mmap allocations to follow the same rules.

But finding it a bit odd how the current implementation limits tmpfs
large folios to when huge=notnever (is that a fair statement?), whereas
other filesystems are now being freely given large folios - using
different GFP flags from what MM uses (closest to defrag=always I think),
and with no limitation - whereas MM folks are off devising ever newer
ways to restrict access to huge pages.

And (conversely) I am unhappy with the way write and fallocate (and split
and collapse? in flight I think) are following the FS approach of allowing
every fractal, when mTHP/shmem_enabled is (or can be) more limiting.  I
think it less surprising (and more efficient when fragmented) for shmem
FS operations to be restricted to the same subset as "shared anon".

Hugh

