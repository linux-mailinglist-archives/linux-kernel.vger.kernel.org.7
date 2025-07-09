Return-Path: <linux-kernel+bounces-723514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8FAFE7D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472B57A6C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7132D780E;
	Wed,  9 Jul 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIzBKjCI"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A202D9EC7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060696; cv=none; b=sFi2O64oJdH25xTwGrrt+hrit6Z2EB5Q5qoj60lvq3C+w227JkAT5HX6R3o3EfbvWX/tEHL4frykQdkYrYLgChtr2YUKneGG2YYZIJ5BGb9QqsBGTLp+q2pdUdZmfhWb2rTkxyFrW8ThbkPQT4gEotxGSROn15++O5mgWZ/jlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060696; c=relaxed/simple;
	bh=l0yiT6vi8kNmvnaFH6vL9llbWszqITt9K9QRgcAtPgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tUkocUsLj0ROnYJZy2ocuzjcm74lGOYQyTjhrD/R4M35BExYRrRvtxU3OvpV6QuVT2I88UWFmzYv6c3KMqwu7Ty7TPQ2bguhvHGVpC6vCrZIFl2NKEwKyAh+q1D+wUSteND6VtwwM6WobAfNExczEnIQ+GkMCgyZ6Ht0v3XycE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oIzBKjCI; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-607c239c7f0so5442586a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752060693; x=1752665493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKz/jr4sAvlzW8F+pdFxeU0JpTncvrCm+GmYbMwH7v0=;
        b=oIzBKjCIyT7LMBvcK8DawbzM/FsZWc051YlR55RtrS/COmsfrsOU2TMIKAhlqp9Kko
         HwjK8+y8SZWMmyELf9hOiYUjzF3Of4HX36yeCTQjSuF/0k7Q8exJVsTEQBHg0wI8eR1S
         TP6J7hj4XxKXvz6MeWww9niCPcskTIYAyHE0Jsbr/ZRrBRttZiQDfFVLSEYjbms2Q4Ab
         ICp+igrpYMNJYFQQU5t2HKn07EHj116a76gYW/29HeNpe2lv2AErCJsBBhfmhNZQB/Oe
         SGI82sWWkIoU2MYQaHkU4xrw+a/hTeImjVpLzqw9PVhPsJ4niogxAPJ+AruJPNsz3asm
         5/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060693; x=1752665493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKz/jr4sAvlzW8F+pdFxeU0JpTncvrCm+GmYbMwH7v0=;
        b=YAbqpP1JUgWw/NG9mRLPqtGCWA6g9+svhA+0Ue0WQwteAh5dQclqlCAysXUpLjSVBB
         MU6HIMJyeJ7KyJucCIFNKyds2OrmYEXwNaOS7j/QWkvA+scDTod5oQ0bJPq0e/fPSzwE
         EigMzwFKzscIz+5WqnbHArWppIEcWt1isqMRD4DgKIUDd4K2skbbuS3dgZNw2dP0R+3C
         vAzeKDeXS/NfqbNdlSF8RFMnFPeqtDYek5hm4UxfSyBfLQTd+/fHp8FeCtbr3K8bentF
         rOuY0jeebGdVzu+BtN7iDH6xo9d4jjV3vrY7g7fqw2SMdae1hjvrG8kZvWGG7/Ht8zyT
         H9kA==
X-Forwarded-Encrypted: i=1; AJvYcCUMupLm54DnmcoDjcI/no/5HI8CmwATH6M+XQIDOMMo+qz1qeHTiV8MIEULeM8kKBnnoMx7AtlaKyyO21g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+OuUnp5BS9wIiH3ENALwKdqFsaraZrksYXCXahSpU4tx5LxH
	H+OlXZNqek6AncLuDqBphnrh2khwQonZnC0R4NrM4tMzQB3MT8fJSGIIZgWva0wDhHeBA2iani/
	LnlmtP3oQdUXAG1MhsA==
X-Google-Smtp-Source: AGHT+IFLvrS3jBzSiTmt44t7b5t9NsWfnRbSj5JtycWej5ry/u4kAdaGE1886+VS9sRjahoYLkPT0J9aqR8+j/0=
X-Received: from edji11.prod.google.com ([2002:a50:d74b:0:b0:609:464e:83f8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2745:b0:604:e85d:8bb4 with SMTP id 4fb4d7f45d1cf-611a714c11fmr1541664a12.21.1752060692970;
 Wed, 09 Jul 2025 04:31:32 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:31:31 +0000
In-Reply-To: <54fc10ce-c3b6-4571-93e7-eebfc538d0c7@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local> <aG0HJte0Xw55z_y4@pollux>
 <54fc10ce-c3b6-4571-93e7-eebfc538d0c7@lucifer.local>
Message-ID: <aG5TE3oq1w1cSdOy@google.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 02:19:38PM +0100, Lorenzo Stoakes wrote:
> On Tue, Jul 08, 2025 at 01:55:18PM +0200, Danilo Krummrich wrote:
> > On Tue, Jul 08, 2025 at 11:58:06AM +0100, Lorenzo Stoakes wrote:
> > > +cc Liam
> > >
> > > Hi guys,
> > >
> > > We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST), so
> > > it's slightly concerning to find a series (at v11!) like this that changes
> > > mm-related stuff and it involves files not listed there and nobody bothered
> > > to cc- the people listed there.
> >
> > What files are you referring to? Are you referring to:
> >
> > 	rust/kernel/alloc.rs
> > 	rust/kernel/alloc/*
> >
> > If so, they're indeed not under the "MEMORY MANAGEMENT - RUST" entry, which
> > so far seems correct.
> 
> Looking at these, they seem to be intended to be the primary means by which
> slab/vmalloc allocations will be managed in rust kernel code correct?
> 
> There's also stuff relating to NUMA etc.
> 
> I really do wonder where the line between this and the mm stuff is. Because
> if the idea is 'well this is just a wrapper around slab/vmalloc' surely the
> same can be said of what's in rust/kernel/mm.rs re: VMAs?
> 
> So if this is the rust equivalent of include/linux/slab.h and mm/slub.c
> then that does seem to me to suggest this should be considered an mm/rust
> thing right?
> 
> It'd be good to know exactly what is considered mm rust and should go
> through the mm tree and what isn't.
> 
> Maybe Alice has some insights on this?

The Rust standard library has three pieces:

- core. Defines standard types that can work anywhere. (such as ints)
- alloc. Defines standard types that require an allocator. (such as vectors)
- std. Defines standard types that require an OS. (such as File or TcpStream)

In the kernel we used to use both core and alloc, but we switched away
from alloc because it doesn't support GFP flags well. The 'RUST [ALLOC]'
subsystem originates from that transition from the Rust stdlib alloc to
our own implementation. It contains essentially three pieces:

- Two data structures Vec and Box.
  - The Box data structure is the simplest possible user of allocation:
    A Box<T> stores a single instance of the struct T in its own
    allocation.
  - The Vec data structure stores a resizable array and maintains a
    pointer, length, capacity triplet. There is a bunch of logic to
    manipulate these to correctly keep track of which parts of the
    vector are in use.
- The Allocator trait.
  - This trait defines what functions an allocator must provide.
  - The data structures Box or Vec require you to specify an allocator,
    and internally it calls into the allocator to manage the backing
    memory for its data.
- Three concrete implementations of the Allocator trait.
  - These are kmalloc, vmalloc, and kvmalloc respectively.

In my eyes, the further down this list you get, the more likely it is
that the patch needs to go through the MM tree.

Alice

