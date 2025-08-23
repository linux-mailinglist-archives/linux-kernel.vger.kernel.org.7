Return-Path: <linux-kernel+bounces-782961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475BB327AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53212601518
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55A23ABB3;
	Sat, 23 Aug 2025 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czjZfWS0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8BD225A59
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938587; cv=none; b=EFMfyQExssg++QmHWYnzM0h8W4KKJ5tq8QcBOgSeZc0yvGzUvsv97pIItinU7vS5K9nm30OJW74s7Ph1GZQvNZspqeUAUWvrC7yFrgxIWtbKV2Ox4VCV4PWUkK9GYA9OzRf8bIrtno3b/nDHNMFz6+O055tslyfQOh04yogZ2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938587; c=relaxed/simple;
	bh=37X3jjXwUHjejovSWpjADkwKpBcCQqf/BM1PK964nAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQJUqel01dd8u5Q7ffWhOiPXQE56TLNP70CQcsPbX265uMKAObmpZFiRGe18DwA6jMlcvfQMo+Y8YYdZYILzqIzWz9GSfusUQXKQs8bPTblFCXSLSFi9ksMRz0I4+DF4WIm5zaEYf2sx+zNCI3sqhVDNSbt71X0uR+Nc4amT4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czjZfWS0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755938580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FnRHJFSV3SreC1w0p6QNKVoKyAgLeDGHlww9MpDPB0=;
	b=czjZfWS066rfOUrX6mq7EKcjUYQyFuDfdbDGRWuBERX+oxy6VpPDEQiX85jVMTHPVy/Fwk
	5alLGQNownGFB7WaUpDOxLkR8Ne44+wfGKbmkiCBE58Gn04dpuTPEsuvU0H8Fnzn5fEFS1
	k9J1Go1MJ6RWlKJ96ZC2MzMD3svKzzI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522--YDIAWJhOrCVtEj0BBmQHA-1; Sat, 23 Aug 2025 04:42:58 -0400
X-MC-Unique: -YDIAWJhOrCVtEj0BBmQHA-1
X-Mimecast-MFC-AGG-ID: -YDIAWJhOrCVtEj0BBmQHA_1755938577
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso20190705e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755938577; x=1756543377;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FnRHJFSV3SreC1w0p6QNKVoKyAgLeDGHlww9MpDPB0=;
        b=r0Nqo1TMlyeUmoXq/VLp5vHgPqMoa6148UZWIrH0Y/CJL6MxdY+0226A/6zvtx62FV
         huIzpXN9y39Ptj0GnRdZUqIVzC7NPFyGW8xyxXMnMfMWNKfK2gVVldEFS6m7fGvgmKPs
         e0P46ZuTBWtlTWsVFLkXUXm9ZvoMV2PA5mJ66csA1Kk4/40G3sKLF9S1mN38WDa9tVPb
         M4lyzsKgnyCuD6m2OMfSa6kcbjZpgiTeuLVK7rHOsiuh5X6H+UJTdR+/UENO0r7QMVCj
         0bd3yR3eguvnouZKBDMHCMxwkgLNew362aNEnnyvfvGWAXe1Yx8Qv3gzUG8yRbbqEr7v
         Y9GA==
X-Forwarded-Encrypted: i=1; AJvYcCXE1kXyeMszcug1orcIRv6TsG8uRcZ8/jXFUZVbAI4EHBolCU0gwpblHp3t9ezhbL9rd6tQqAVcoxqLdV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwisYV7g/1TaqnobfVL5UV+8rKYYTqmqBrt95xmU8phWruPLt3S
	qor0cCZQ77GGkcKe6OlvwYf8viPFeAZ7Gu8fABzAzNiNf7RQ9J6lXt+h7PuxwRZWf2Z0fMz3O82
	uyYHtfkiYuCeKt7SQdUjXTxddd1uypSa0J+A4TJ+dvDO5MkiGwkTBJMjKKoSpE4avDg==
X-Gm-Gg: ASbGncuryoyQi9nZs6JW125ODqM+BfV/DQgheWrwBEenGk/Z0GXaXGw2k2JMnHPI9ZI
	mEPVxw5PdpIGPba3nsxeza/PTkGINKz6ha2ToC/Y62jAA3h9C6QGSnOrGY+94nA4QguNC5rekR/
	VxsaXAQgOEDcp7OFs2r7DnFaC9hKt9xtGVWHIk9oPogLjn9NNkJ7gZGG6QVYevq7LahWGm1u2aV
	YxE4K12sYslfBvQJJd+ozF0EibGbzJKQg1/oKKZmS6bp8fsdaqdHVOMAeL7/b9cJbmcUUH8hXrK
	+kBhlT/55BafMiP+Qg3ioYp0Rk/xtqQne2LuzW5FxFGrFNefuS4=
X-Received: by 2002:a05:600c:5493:b0:459:d709:e5a1 with SMTP id 5b1f17b1804b1-45b53af6c77mr48705515e9.6.1755938576703;
        Sat, 23 Aug 2025 01:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6NjHGHYqMJ8ulZ9is0JehUqd1MHmd37Qkuu9GJeF/qPZl1+eYwVAU/3Y3IK1AImm7nVQHsw==
X-Received: by 2002:a05:600c:5493:b0:459:d709:e5a1 with SMTP id 5b1f17b1804b1-45b53af6c77mr48705185e9.6.1755938576230;
        Sat, 23 Aug 2025 01:42:56 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57444963sm31535055e9.3.2025.08.23.01.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 01:42:55 -0700 (PDT)
Date: Sat, 23 Aug 2025 10:42:51 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, wangzijie
 <wangzijie1@honor.com>, Alexey Dobriyan <adobriyan@gmail.com>, Christian
 Brauner <brauner@kernel.org>, passt-dev@passt.top, Al Viro
 <viro@zeniv.linux.org.uk>, Ye Bin <yebin10@huawei.com>, Alexei Starovoitov
 <ast@kernel.org>, "Rick P . Edgecombe" <rick.p.edgecombe@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] proc: Bring back lseek() operations for /proc/net
 entries
Message-ID: <20250823104251.49a8caba@elisabeth>
In-Reply-To: <20250822160904.6c5468bce2200cf8561970d7@linux-foundation.org>
References: <20250822172335.3187858-1-sbrivio@redhat.com>
	<20250822160904.6c5468bce2200cf8561970d7@linux-foundation.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 16:09:04 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 22 Aug 2025 19:23:35 +0200 Stefano Brivio <sbrivio@redhat.com> wrote:
> 
> > Commit ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek
> > as ones for proc_read_iter et.al") breaks lseek() for all /proc/net
> > entries, as shown for instance by pasta(1), a user-mode network
> > implementation using those entries to scan for bound ports:
> > 
> >   $ strace -e openat,lseek -e s=none pasta -- true
> >   [...]
> >   openat(AT_FDCWD, "/proc/net/tcp", O_RDONLY|O_CLOEXEC) = 12
> >   openat(AT_FDCWD, "/proc/net/tcp6", O_RDONLY|O_CLOEXEC) = 13
> >   lseek(12, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   lseek(13, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   openat(AT_FDCWD, "/proc/net/udp", O_RDONLY|O_CLOEXEC) = 14
> >   openat(AT_FDCWD, "/proc/net/udp6", O_RDONLY|O_CLOEXEC) = 15
> >   lseek(14, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   lseek(15, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   [...]
> > 
> > That's because PROC_ENTRY_proc_lseek isn't set for /proc/net entries,
> > and it's now mandatory for lseek(). In fact, flags aren't set at all
> > for those entries because pde_set_flags() isn't called for them.
> > 
> > As commit d919b33dafb3 ("proc: faster open/read/close with "permanent"
> > files") introduced flags for procfs directory entries, along with the
> > pde_set_flags() helper, they weren't relevant for /proc/net entries,
> > so the lack of pde_set_flags() calls in proc_create_net_*() functions
> > was harmless.
> > 
> > Now that the calls are strictly needed for lseek() functionality,
> > add them.  
> 
> Thanks.  We already have
> https://lkml.kernel.org/r/20250821105806.1453833-1-wangzijie1@honor.com
> - does that look suitable?

Sorry, I didn't spot that one. It sure does!

-- 
Stefano


