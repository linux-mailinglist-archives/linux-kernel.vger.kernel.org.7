Return-Path: <linux-kernel+bounces-848579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66580BCE13E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC45F34517B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50B221287;
	Fri, 10 Oct 2025 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afzOI2F1"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853218EAB
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117256; cv=none; b=KXMtv/48Cc2+2b3SANqgYXPlJ+B+l7QupOAMlGDFMSkyc5ptO9XMvlArcdm7oaPCoouicZcR9pHSLiO5LMRLJcq/UG3jowEW8eLJvAOmGB6Qxemnuuh7o/aINPFHX1ivOTmmPYxcVKeQTHMKK7RKKEMrv0qKPp8/D5rStMd3Huk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117256; c=relaxed/simple;
	bh=ml7tkRYI4xUtnVPnGG3PEMXwN8cqSfZjMGoJtLfhFCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVQoio3v10k9UjH6I1viNKC4nr/sDkKLj4qWp/hqdWKZ+9nDGBti3FBGgnQ5qZtfmT2HNbMJLtD1RSKX6AJ/pMkdcVoMknEprN2+N07eSKmqEsz7bb4PBDL+/oisATNGrLt4fjwFFkUl7Te6qNBHq60p6LxlmkfStXJf7lw6U4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afzOI2F1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ec2211659so4939111a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760117254; x=1760722054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pH+3AD8kiJqRKCGYKWcLo8VESpsbXYEFy+dJrOPNWBo=;
        b=afzOI2F1k7v90/qFAEODJJM8nGz2T5WQ4bchp1NxZP6hKYZxcB59/4MCHhFe7yFCT8
         nCLDcAnPkS6Xw+CFEw9qHrS4XZfmZuuECK0pbwyP0YZU/4sTkes2oGVe4mUxBLS5Ahtq
         p0FgupSNiQMHcR8f6C2MBB+F5dKOgpLn0ZXwDNRrjXdAIw4DrBvz/e2i6DoPS7xs7M/l
         vsDMBbQI2pYGnU3P+lY8lF+p3zM+UKSKplNoVHkzORJLrCGOO/jtSVA5N0BVoyJLv7Gj
         QxXZ2iDjJfzmdErBUOES00pMPAcksVAubrfM2k0SyRkugF+dKW9yPNaM7zdXC7h2ejz5
         KfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117254; x=1760722054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pH+3AD8kiJqRKCGYKWcLo8VESpsbXYEFy+dJrOPNWBo=;
        b=Ve/leuTMEf73qaWZdGTDercOYCZkvJgqRYrYWlFULRElYJ0gzRnIlF8dDiO47Wlb9o
         xlkaBaed1qRF2Fqb+XFke9kBMO4mVVBguc2avdPL3m76lyeWNAttBUZh44544YJYj9uC
         HbcmIsVAvhvbVgovbFVdMQlCwMZRmZYhPT8Dm2NLRtrMRjIkl+UWtPzXOjAbi68qV2pP
         0wNdDzcNPCWUok4xCfsCliTBG3mipjX1sNgcfqzglUpFrQSnKxwNFAQzXcDV3st5g0wl
         zUKqFGX2yQTxVnd1v0/QUmpnpfHWaY3XKG+34UE8jTe35Pd/Xsi0z0yqPe7gAG+VMQNL
         8BAw==
X-Forwarded-Encrypted: i=1; AJvYcCVvcLZ+ZKycLrwypYOp3/BzFlMak8rBQ/lP6o4Xc6Bn/XHNamyVcbyz3CpX7dY12tJvhkihafJTTpt6tbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtwH1JRExW+6IMSUavh/gAaQjaoRiYh1wz4mtZ17gQeZJ8sSo
	3M5zxRKLSNvHmHRtZWnRXZXCwtH2zIrPQsXiPB7g7E6KGCk80OBF9K4s8LZA8igPCEbym4/E4/i
	LKRTPAA==
X-Google-Smtp-Source: AGHT+IGLlaru28z5BZejE+3H8K3desl6vTwTOLea5xBA+YbUfKPv8Q3V+etJLSLVdLEu9RSlY4xKC/8mIr8=
X-Received: from pjbpb16.prod.google.com ([2002:a17:90b:3c10:b0:330:49f5:c0b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c3:b0:32b:d8af:b636
 with SMTP id 98e67ed59e1d1-33b51377d87mr16939056a91.19.1760117253944; Fri, 10
 Oct 2025 10:27:33 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:27:32 -0700
In-Reply-To: <20250902080307.153171-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250902080307.153171-2-shivankg@amd.com>
Message-ID: <aOlCBEw1DpdLlWA1@google.com>
Subject: Re: [PATCH V2 kvm-next] KVM: guest_memfd: use kvm_gmem_get_index() in
 more places and smaller cleanups
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: pbonzini@redhat.com, david@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

TL;DR: Please split this into three patches, call out the use of
kvm_gmem_get_index() in kvm_gmem_prepare_folio, and unless someone feels strongly
about the ULONG_MAX change, just drop it.

On Tue, Sep 02, 2025, Shivank Garg wrote:
> Move kvm_gmem_get_index() to the top of the file and make it available for
> use in more places.

Not just "in more places", specifically for kvm_gmem_prepare_folio().  And this
also has kvm_gmem_prepare_folio() _use_ the helper.  That detail matters, because
without having actual user, such code movement would be completely arbitrary and
likely pointless churn.  E.g. AFAICT, it's not needed for the NUMA support or
even for the WIP-but-functional in-place conversion patches I have.

> Remove redundant initialization of the gmem variable because it's already
> initialized.
> 
> Replace magic number -1UL with ULONG_MAX.

This is quite clearly three distinct patches.  Yes, they're trivial, but that's
exactly why they should be split up: it takes so, so little brain power to review
super trivial patches.  Bundling such patches together almost always increases
the total review cost relative to if they are split up.  I.e. if split, the cost
is A + B + C, but bundled together, the cost is A + B + C + X, where 'X' is the
extra effort it takes to figure out what changes go with what part of the changelog.
And sometimes (and for me, it's the case here), X > A + B + C, which makes for
grumpy reviewers.

Case in point, it took me way too long to spot the new use of kvm_gmem_get_index()
in kvm_gmem_prepare_folio(), due to the noise from the other changes getting in
the way.

More importantly, bundling things together like this makes it an all-or-nothing
proposition.  That matters, because I don't want to take the ULONG_MAX change.
The -1 pattern is meaningful (at least, IMO), as KVM is very specifically
invalidating 0 => 0xffffffff_ffffffff.  I don't love hiding those details behind
ULONG_MAX.  I realize it's a somewhat silly position, because xarray uses ULONG_MAX
for it's terminal value, but it gets weird in the guest_memfd code because @end is
used for both the xarray and for gfn range sent over to KVM.

Amusingly, the -1UL is also technically wrong, because @end is exclusive.  AFAIK
it's not actually possible to populate offset -1, so it's a benign off-by-one,
but I think super duper technically, we would want something absurd like this:

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index cfbb2f1aa1ab..f4d15cda2029 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -231,12 +231,13 @@ static void __kvm_gmem_invalidate_begin(struct gmem_file *f, pgoff_t start,
                                        pgoff_t end,
                                        enum kvm_gfn_range_filter attr_filter)
 {
+       pgoff_t last  = end == -1UL ? ULONG_MAX : end;
        bool flush = false, found_memslot = false;
        struct kvm_memory_slot *slot;
        struct kvm *kvm = f->kvm;
        unsigned long index;
 
-       xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
+       xa_for_each_range(&f->bindings, index, slot, start, last) {
                pgoff_t pgoff = slot->gmem.pgoff;
 
                struct kvm_gfn_range gfn_range = {

> No functional change intended.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
> Applies cleanly on kvm-next (a6ad54137) and guestmemfd-preview (3d23d4a27).
> 
> Changelog:
> V2: Incorporate David's suggestions.
> V1: https://lore.kernel.org/all/20250901051532.207874-3-shivankg@amd.com
> 
> 
>  virt/kvm/guest_memfd.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b2d6ad80f54c..1299e5e50844 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -44,6 +44,11 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
>  	return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
>  }
>  
> +static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
> +{
> +	return gfn - slot->base_gfn + slot->gmem.pgoff;
> +}
> +
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  				    pgoff_t index, struct folio *folio)
>  {
> @@ -51,6 +56,7 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>  	kvm_pfn_t pfn = folio_file_pfn(folio, index);
>  	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
>  	int rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
> +

Spurious whitespace change.  Yes, a newline should technically be there, but if
we make a change, I would prefer:

	int rc;

	rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
	if (rc) {
		...
	}

So that the check of the return value is tightly couple to the function call that
set the return value.

>  	if (rc) {
>  		pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx GFN %llx PFN %llx error %d.\n",
>  				    index, gfn, pfn, rc);
> @@ -107,7 +113,7 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	 * checked when creating memslots.
>  	 */
>  	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, 1 << folio_order(folio)));
> -	index = gfn - slot->base_gfn + slot->gmem.pgoff;
> +	index = kvm_gmem_get_index(slot, gfn);
>  	index = ALIGN_DOWN(index, 1 << folio_order(folio));
>  	r = __kvm_gmem_prepare_folio(kvm, slot, index, folio);
>  	if (!r)
> @@ -327,8 +333,8 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	 * Zap all SPTEs pointed at by this file.  Do not free the backing
>  	 * memory, as its lifetime is associated with the inode, not the file.
>  	 */
> -	kvm_gmem_invalidate_begin(gmem, 0, -1ul);
> -	kvm_gmem_invalidate_end(gmem, 0, -1ul);
> +	kvm_gmem_invalidate_begin(gmem, 0, ULONG_MAX);
> +	kvm_gmem_invalidate_end(gmem, 0, ULONG_MAX);
>  
>  	list_del(&gmem->entry);
>  
> @@ -354,10 +360,6 @@ static inline struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
>  	return get_file_active(&slot->gmem.file);
>  }
>  
> -static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
> -{
> -	return gfn - slot->base_gfn + slot->gmem.pgoff;
> -}
>  
>  static bool kvm_gmem_supports_mmap(struct inode *inode)
>  {
> @@ -940,7 +942,6 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>  		return ERR_PTR(-EFAULT);
>  	}
>  
> -	gmem = file->private_data;
>  	if (xa_load(&gmem->bindings, index) != slot) {
>  		WARN_ON_ONCE(xa_load(&gmem->bindings, index));
>  		return ERR_PTR(-EIO);
> -- 
> 2.43.0
> 

