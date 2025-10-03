Return-Path: <linux-kernel+bounces-841415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67085BB73E0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 087414ECF0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4826D4C6;
	Fri,  3 Oct 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RX0F19tG"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7628031D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503134; cv=none; b=hUDPWp3Jmo7eco4V/LmwpPg9QQhWDuBGo3Ge11ljxL5eokJ+A2TaT6OiKqxS9HsWBYHDU9xDZjgwoMhjnmSx/YxkJ95nfRL+SJfpBN2g+KI7k+R02lHHgUDq0EK/Veq24B1d5cZD3WXjNHYUc94ycsjLhNvV8uiz69A8ztWYtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503134; c=relaxed/simple;
	bh=4b0coGweLPmrVerXT4VS/6VDTPWKnMwazrzwdaJrH1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jbPRP8VoqpC3nOtocoy5Tv/lR2LVgnXeNtl8WPN5JnNfg4jPuDd879YmyumNOeIsfnqnsyxjl2NyvzAbMtT7JdSfzgz8iBHlznDOS9+gvbk5j+9TOXojDr26npJ/2zK/qczawWe78tgKoQkFpGaV83u/aY2cvSyMi3tvIF5aB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RX0F19tG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso2099840a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759503132; x=1760107932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpN9x5MKoIyJVB04EWmewZK/AQGVBuwB42Zza3jf0V8=;
        b=RX0F19tGIb2MEJDX7z0i77WkNRXwWMntO6bdbiNAowm6K9NlHf1budsrdlWuCI793Q
         bpWQ3JgdupE0kANZPJDHFgTpw1u0/fJkZ8qDUBXmAtkf5rFxUppc6EdVyItVt51mwKgU
         6namnLK4u7AWAqnRD6nPrxHGDR/Gn/vtMWm/es49OaEK98/fSB6NN3bxUZVO5fCS1jzx
         seAf9ORILLovIAi3Qnc+omy0oCji3xEQs2n6+7sa+HK5v69PtUIEzh+f+0Zbn3xaGajT
         YWbW1AQmI416p6siYI4mC28oUPJYPlaGD9cp+1xMBvZ9fm8ERdnpSTYIqcIhhapPRNb7
         epiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503132; x=1760107932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpN9x5MKoIyJVB04EWmewZK/AQGVBuwB42Zza3jf0V8=;
        b=hItozNb6iDZiJ6jnIPRCTp+5WA/wIXWcR+rIliR/sxa3DyzsQXjWgXk1AFujiVe07a
         KJbBIo2jYu0iiCSJcwlCSPMLczBT5FGd3kIJhEseGpBtMubP0AFvu3J4G6uQxXyDLL0q
         X3d0jaEdmzj0FY4WJbApoXsN35pQ6HcYiiuSrmHAZ7kUeIYB+9hlRzHX1Hra7UD1a4CZ
         FHkQbQIobL1GsNdUk6QXQ4qnff9zeZqcvXaSJHzWHXLmKxD9MMzieGJHohBA0AOkNMPd
         0u2B+BLFcBLZ6Yh12Uo/+FaIkAcCgWgyAOlbRx8+FdJagjuuM2lvEG5WtBLzGdrSyrZx
         HQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUstd91GU56K4vVtONJFgM9wdzPqO7S/3VWlPbp/q+2vNFP9N3hAL8qx+ciPnV3uIa6EohFdyh1NvghyXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4qB+4YBzb/dFi0BLeKSpTAtsa5kjdOZF2V6Fg2XP3Pi1GdTw
	xJ51eigAMCvahvkMT2K+2P3IkphrMulDnUE7/4DQcd0CPwg0IiOrjPtyVzWh2OI6/tOXmC/lsuk
	tT5M4jw==
X-Google-Smtp-Source: AGHT+IFOx/1HIGJBL3nY8+UsIOfKhr1DvTj0RUho954nMJOAkqUQ2/whOS9dK57jpBCvFyocW4al5BM6oPo=
X-Received: from pjyo11.prod.google.com ([2002:a17:90a:eb8b:b0:327:50fa:eff9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d12:b0:338:3789:2e89
 with SMTP id 98e67ed59e1d1-339c2720709mr4203886a91.10.1759503132338; Fri, 03
 Oct 2025 07:52:12 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:52:10 -0700
In-Reply-To: <4d16522293c9a3eacdbe30148b6d6c8ad2eb5908.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <4d16522293c9a3eacdbe30148b6d6c8ad2eb5908.1747264138.git.ackerleytng@google.com>
Message-ID: <aN_jGnu2KQnxDniD@google.com>
Subject: Re: [RFC PATCH v2 32/51] KVM: guest_memfd: Support guestmem_hugetlb
 as custom allocator
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Fuad Tabba <tabba@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ira Weiny <ira.weiny@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, David Hildenbrand <david@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

Trimmed the Cc to KVM/guest_memfd folks.

On Wed, May 14, 2025, Ackerley Tng wrote:
> @@ -22,6 +25,10 @@ struct kvm_gmem_inode_private {
>  #ifdef CONFIG_KVM_GMEM_SHARED_MEM
>  	struct maple_tree shareability;
>  #endif
> +#ifdef CONFIG_KVM_GMEM_HUGETLB
> +	const struct guestmem_allocator_operations *allocator_ops;
> +	void *allocator_private;
> +#endif

This is beyond silly.  There is _one_ "custom" allocator, and no evidence that
the "generic" logic written for custom allocators would actually be correct for
anything other than a hugetlb allocator.

And to my point about guestmem_hugetlb.c not actually needing access to "private"
mm/ state,  I would much rather add e.g. virt/kvm/guest_memfd_hugetlb.{c.h}, and
in the header define:

  struct gmem_hugetlb_inode {
	struct hstate *h;
	struct hugepage_subpool *spool;
	struct hugetlb_cgroup *h_cg_rsvd;
  };

and then in guest_memfd.c have

  struct gmem_inode {
	struct shared_policy policy;
	struct inode vfs_inode;

	u64 flags;
	struct maple_tree attributes;

#ifdef CONFIG_KVM_GUEST_MEMFD_HUGETLB
	struct gmem_hugetlb_inode hugetlb;
#endif
  };

or maybe even better, avoid even that "jump" and define "struct gmem_inode" in a
new virt/kvm/guest_memfd.h:

  struct gmem_inode {
	struct shared_policy policy;
	struct inode vfs_inode;

	u64 flags;
	struct maple_tree attributes;

#ifdef CONFIG_KVM_GUEST_MEMFD_HUGETLB
	struct hstate *h;
	struct hugepage_subpool *spool;
	struct hugetlb_cgroup *h_cg_rsvd;
#endif
  };


The setup code can them be:

#ifdef CONFIG_KVM_GUEST_MEMFD_HUGETLB
	if (flags & GUEST_MEMFD_FLAG_HUGETLB) {
		err = kvm_gmem_init_hugetlb(inode, size, huge_page_size_log2)
		if (err)
			goto out;
	}
#endif


Actually, if we're at all clever, the #ifdefs can go away completely so long as
kvm_gmem_init_hugetlb() is uncondtionally _declared_, because we rely on dead
code elimination to drop the call before linking.

>  };
> +/**
> + * kvm_gmem_truncate_indices() - Truncates all folios beginning @index for
> + * @nr_pages.
> + *
> + * @mapping: filemap to truncate pages from.
> + * @index: the index in the filemap to begin truncation.
> + * @nr_pages: number of PAGE_SIZE pages to truncate.
> + *
> + * Return: the number of PAGE_SIZE pages that were actually truncated.
> + */

Do not add kerneldoc comments for internal helpers.  They inevitably become stale
and are a source of friction for developers.  The _only_ non-obvious thing here
is the return value.  

> +static long kvm_gmem_truncate_indices(struct address_space *mapping,
> +				      pgoff_t index, size_t nr_pages)
> +{
> +	struct folio_batch fbatch;
> +	long truncated;
> +	pgoff_t last;
> +
> +	last = index + nr_pages - 1;
> +
> +	truncated = 0;
> +	folio_batch_init(&fbatch);
> +	while (filemap_get_folios(mapping, &index, last, &fbatch)) {
> +		unsigned int i;
> +
> +		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +			struct folio *f = fbatch.folios[i];
> +
> +			truncated += folio_nr_pages(f);
> +			folio_lock(f);
> +			truncate_inode_folio(f->mapping, f);
> +			folio_unlock(f);
> +		}
> +
> +		folio_batch_release(&fbatch);
> +		cond_resched();
> +	}
> +
> +	return truncated;
> +}

