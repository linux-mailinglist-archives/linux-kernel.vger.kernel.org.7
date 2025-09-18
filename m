Return-Path: <linux-kernel+bounces-817796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8017EB586B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A981B23139
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0F2C028C;
	Mon, 15 Sep 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKwN74iP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A835966
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971575; cv=none; b=QZ4E5pac8hhnY3h1Zxcw6cZDGQBoNjYyAyTeb3ab4h2y4eUWzrdFElxF7BDZdsILsUAX3+9eSV9lnaC1lE13niQmx9aslvRpvYgZn1xXzUXGtoSNZPhAvlY5CrDJ7c+hzYPQklgesKLQ/i/vHEryb9l+UJ2f+A513A17wxnp/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971575; c=relaxed/simple;
	bh=1sOTIRHTFzvVsuFrLFr5SOKUlmErsLY3WO0d1tNp5Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P84fidyFDchPRwU2ORMBZaB2fKJ03k+qXZzAiy8dtixMlcS1IWc6adIoW+f1rL8phkZZnTuV+s4xvGtSj7EsOA7hujmzHZQBIMjpUEe7Rj//zV5cXnXuzgRzj0QQk6rwuvaffxpIu8j/1V1AJ5am156LiDTJyu2TNj4Keikzw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKwN74iP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757971572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KM4RQD/H6XgF3hQHay54Rz4wcT8Td67zLaIIGzgIOjc=;
	b=YKwN74iPf5CBkvjsv4nTW9FxGGh6Pitb0isiJlbnhtNnp1Wx5W60fMvQNNeD/vCn/Kme7J
	r7JQcxnrHELMD81dGnPhort0mER5+HJ4x8jcVy6BNuPM1/VpbYC9ciS8+OPaZ7i70CpT5y
	0ynA/ojT6zGepQ+wwVSrHdGYHIciUBA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-imEe4QgvMxuCMs7AbazRuA-1; Mon, 15 Sep 2025 17:26:11 -0400
X-MC-Unique: imEe4QgvMxuCMs7AbazRuA-1
X-Mimecast-MFC-AGG-ID: imEe4QgvMxuCMs7AbazRuA_1757971571
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7829c46b2e4so34716766d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971571; x=1758576371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM4RQD/H6XgF3hQHay54Rz4wcT8Td67zLaIIGzgIOjc=;
        b=VTIYqXBqIHT/8tnt92FiC7vYr6RoDOlvoO+67Qt2kmqM/5XFa54q6tWE0sZTMwFQvl
         CH2uoEH6wuOIziJuCIX5KFCGWNYE6F8NOh0uFDqDvyNkqYb3rmgSH0d82TVKjsNt5oba
         2rwNLVjmXXkWZc3HY+0C02MoTKCHSG8CzCNAu0oRif4hGbdVd4MtllMm4TWpDS3KlcuF
         1JACJs2Uwv5QJstsr2c9rpOgrAZGfo4/DyomzH6P1YamRnEnZ6Fx4ogyXO4Kw2M7U3bG
         b0VtROo30vm5Q7HXqMjY+IdzgHkKIjN9M2hMUN3NGgCYjDXKUvcb2iIt75tq87DxJq9X
         H/eA==
X-Forwarded-Encrypted: i=1; AJvYcCWw2ctp1mG4MfFL/yGZOn1IMzXvR+UMXKMKN2F8QrfIrlDLo1opLayoocMu3wS6fV7XCYErASWaSjft1k8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/pkTh46LjOuycBAkVbZNmHkUauCIDr5j1Y2cxrAPMLxCMFbtD
	OYR9iXigemod6CKUIxaA7z82KdTeY3Lo/AHfAmXjXGjLlpVX/zMe4wbKeysd2/Lc0BQ4+nT8vQe
	ly6u/CRF80b8ScqLzCkTf6RdYIrPnb/GzkP1nUeYNdUlxevu9WqXswEJw+cL3vF/XCw==
X-Gm-Gg: ASbGncuxixtXOKgJmdrRqUoEaMCtaM2M7b7NYepZqK/sc06WdZ/bpv/UYitpUQgxAVa
	4k8hTJyC92nFvpVtgFO5yaGMtbmvnykkye+3+VrxgTgAj4LvIJPY/ykrfv6c3v81cgYHJlLOApa
	WvbicTtis25ORMdOKyMAiUZMspcgfgJI+v/1Nv8+DZCBXDtXvgPBNoquD6bpfRJqL7gRiSRNjWB
	i6VM/FvONJFdpa7WQ8dKxb1sCOHtl6kdQRsEbpmNKjoXa6t4epIetVPX/9Nq79GqEFzENEGeIEd
	zCaGBfh2JaU6W+mHqYxFK5VS91Sx97D/
X-Received: by 2002:a05:6214:3c85:b0:769:cd09:9d77 with SMTP id 6a1803df08f44-769cd099fafmr170285286d6.4.1757971571193;
        Mon, 15 Sep 2025 14:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkORZIzaSeYsztcwaPnCJ3V7jNeNP5xXWbRprE054mUcehDj+b7ToSI1uNg2GLUniMgON4ow==
X-Received: by 2002:a05:6214:3c85:b0:769:cd09:9d77 with SMTP id 6a1803df08f44-769cd099fafmr170284896d6.4.1757971570738;
        Mon, 15 Sep 2025 14:26:10 -0700 (PDT)
Received: from x1.local ([174.89.135.121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-76e576ee0fcsm60107386d6.69.2025.09.15.14.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:26:10 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:57 -0400
From: Peter Xu <peterx@redhat.com>
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"tabba@google.com" <tabba@google.com>,
	"vannapurve@google.com" <vannapurve@google.com>,
	"Roy, Patrick" <roypat@amazon.co.uk>,
	"Thomson, Jack" <jackabt@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Subject: Re: [RFC PATCH v6 0/2] mm: Refactor KVM guest_memfd to introduce
 guestmem library
Message-ID: <aMiEZfkx5sRMU7it@x1.local>
References: <20250915161815.40729-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915161815.40729-1-kalyazin@amazon.com>

Hello, Nikita,

On Mon, Sep 15, 2025 at 04:18:16PM +0000, Kalyazin, Nikita wrote:
> This is a revival of the guestmem library patch series originated from
> Elliot [1].  The reason I am bringing it up now is it would help
> implement UserfaultFD support minor mode in guest_memfd.
> 
> Background
> 
> We are building a Firecracker version that uses guest_memfd to back
> guest memory [2].  The main objective is to use guest_memfd to remove
> guest memory from host kernel's direct map to reduce the surface for
> Spectre-style transient execution issues [3].  Currently, Firecracker
> supports restoring VMs from snapshots using UserfaultFD [4], which is
> similar to the postcopy phase of live migration.  During restoration,
> while we rely on a separate mechanism to handle stage-2 faults in
> guest_memfd [5], UserfaultFD support in guest_memfd is still required to
> handle faults caused either by the VMM itself or by MMIO access handling
> on x86.
> 
> The major problem in implementing UserfaultFD for guest_memfd is that
> the MM code (UserfaultFD) needs to call KVM-specific interfaces.
> Particularly for the minor mode, these are 1) determining the type of
> the VMA (eg is_vma_guest_memfd()) and 2) obtaining a folio (ie
> kvm_gmem_get_folio()).  Those may not be always available as KVM can be
> compiled as a module.  Peter attempted to approach it via exposing an
> ops structure where modules (such as KVM) could provide their own
> callbacks, but it was not deemed to be sufficiently safe as it opens up
> an unrestricted interface for all modules and may leave MM in an
> inconsistent state [6].

I apologize when I was replying to your offlist email that I'll pick it up,
but I didn't.. I moved on with other things after the long off which was
more urgent, then I never got the chance to go back..  I will do it this
week.

I don't think it's a real safety issue.  Frankly, I still think that latest
patchset, as-is, is the best we should come up with userfaultfd.  If people
worry about uffdio_copy(), it's fine, we can drop it.  It's not a huge deal
at least for now.

Btw, thanks for help pinging that thread, and sorry I didn't yet get back
to it.  I'll read the discussions (I didn't yet, after back to work for
weeks), but I will.

> 
> An alternative way to make these interfaces available to the UserfaultFD
> code is extracting generic-MM guest_memfd parts into a library
> (guestmem) under MM where they can be safely consumed by the UserfaultFD
> code.  As far as I know, the original guestmem library series was
> motivated by adding guest_memfd support in Gunyah hypervisor [7].
> 
> This RFC
> 
> I took Elliot's v5 (the latest) and rebased it on top of the guest_memfd
> preview branch [8] because I also wanted to see how it would work with
> direct map removal [3] and write syscall [9], which are building blocks
> for the guest_memfd-based Firecracker version.  On top of it I added a
> patch that implements UserfaultFD support for guest_memfd using
> interfaces provided by the guestmem library to illustrate the complete
> idea.

I hope patch 2 exactly illustrated on why the uffd modulization effort is
still worthwhile (to not keep attaching "if"s all over the places).  Would
you agree?

If you agree, we'll need to review the library work as a separate effort
from userfaultfd.

> 
> I made the following modifications along the way:
>  - Followed by a comment from Sean, converted invalidate_begin()
>    callback back to void as it cannot fail in KVM, and the related
>    Gunyah requirement is unknown to me
>  - Extended the guestmem_ops structure with the supports_mmap() callback
>    to provide conditional mmap support in guestmem
>  - Extended the guestmem library interface with guestmem_allocate(),
>    guestmem_test_no_direct_map(), guestmem_mark_prepared(),
>    guestmem_mmap(), and guestmem_vma_is_guestmem()
>  - Made (kvm_gmem)/(guestmem)_test_no_direct_map() use
>    mapping_no_direct_map() instead of KVM-specific flag
>    GUEST_MEMFD_FLAG_NO_DIRECT_MAP to make it KVM-independent
> 
> Feedback that I would like to receive:
>  - Is this the right solution to the "UserfaultFD in guest_memfd"
>    problem?

Yes it's always a fair question to ask.  I shared my two cents above.  We
can definitely also hear about how others think.

I hope I'll keep my words this time on reposting.

Thanks,

>  - What requirements from other hypervisors than KVM do we need to
>    consider at this point?
>  - Does the line between generic-MM and KVM-specific guest_memfd parts
>    look sensible?
> 
> Previous iterations of UserfaultFD support in guest_memfd patches:
> v3:
>  - https://lore.kernel.org/kvm/20250404154352.23078-1-kalyazin@amazon.com
>  - minor changes to address review comments (James)
> v2:
>  - https://lore.kernel.org/kvm/20250402160721.97596-1-kalyazin@amazon.com
>  - implement a full minor trap instead of hybrid missing/minor trap
>    (James/Peter)
>  - make UFFDIO_CONTINUE implementation generic calling vm_ops->fault()
> v1:
>  - https://lore.kernel.org/kvm/20250303133011.44095-1-kalyazin@amazon.com
> 
> Nikita
> 
> [1]: https://lore.kernel.org/kvm/20241122-guestmem-library-v5-2-450e92951a15@quicinc.com
> [2]: https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding
> [3]: https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk
> [4]: https://github.com/firecracker-microvm/firecracker/blob/main/docs/snapshotting/handling-page-faults-on-snapshot-resume.md
> [5]: https://lore.kernel.org/kvm/20250618042424.330664-1-jthoughton@google.com
> [6]: https://lore.kernel.org/linux-mm/20250627154655.2085903-1-peterx@redhat.com
> [7]: https://lore.kernel.org/lkml/20240222-gunyah-v17-0-1e9da6763d38@quicinc.com
> [8]: https://git.kernel.org/pub/scm/linux/kernel/git/david/linux.git/log/?h=guestmemfd-preview
> [9]: https://lore.kernel.org/kvm/20250902111951.58315-1-kalyazin@amazon.com
> 
> Nikita Kalyazin (2):
>   mm: guestmem: introduce guestmem library
>   userfaulfd: add minor mode for guestmem
> 
>  Documentation/admin-guide/mm/userfaultfd.rst |   4 +-
>  MAINTAINERS                                  |   2 +
>  fs/userfaultfd.c                             |   3 +-
>  include/linux/guestmem.h                     |  46 +++
>  include/linux/userfaultfd_k.h                |   8 +-
>  include/uapi/linux/userfaultfd.h             |   8 +-
>  mm/Kconfig                                   |   3 +
>  mm/Makefile                                  |   1 +
>  mm/guestmem.c                                | 380 +++++++++++++++++++
>  mm/userfaultfd.c                             |  14 +-
>  virt/kvm/Kconfig                             |   1 +
>  virt/kvm/guest_memfd.c                       | 303 ++-------------
>  12 files changed, 493 insertions(+), 280 deletions(-)
>  create mode 100644 include/linux/guestmem.h
>  create mode 100644 mm/guestmem.c
> 
> 
> base-commit: 911634bac3107b237dcd8fdcb6ac91a22741cbe7
> -- 
> 2.50.1
> 
> 
> 

-- 
Peter Xu


