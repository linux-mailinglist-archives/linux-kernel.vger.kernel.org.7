Return-Path: <linux-kernel+bounces-847608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BAABCB445
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D41B405393
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A9035950;
	Fri, 10 Oct 2025 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhICESxo"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE118A6CF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760055689; cv=none; b=p49VwG7tlYBcqGsb7fItOizqJS2qreauFp2fDqZYbM6/Cx/nW3KJuHA5w+4AGktavSVQ95owQkoSVixx+h9SIZpFeQGB2S9gWnS3ivqBJSJOllBPRD2NJDns7CquhtOtD8vik8k+NJ8mYx+QDDh3SKRZkoewGSlmTjzEYHNHjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760055689; c=relaxed/simple;
	bh=lwSnZjzI7WMbrxBCXF6bZqUJlkk0sDJDteEZzsG7vQg=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=pUOqGEizJ8i/DAuUlQGnzW3dztxvLN/aG77LOd0zxKqe5e3NhZ4w/4muE6FDQtGPTXcwuqq6af7o/0QTC8OJExhqon5p7v/+H7W1cEovcfA+c4zVKfDKjKU3ItvuOaaJZtNIbukyiP1qxAHlP6Zql4Fp2hK3cQOGc8DhtS0IHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhICESxo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-269af520712so29213635ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760055686; x=1760660486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rGp2wfDAFolkfVq9Qs1rE1NgIbJJDObk0zASInZr3ZY=;
        b=bhICESxoVQQt0bfMaRyeBWmcmn6Gwd1tw/tbcqf5nUMXMnSUVaXQZJNE56PTn85alB
         VowYsrJFPpKXsrYlnFpRYL5dhwbyHO8PL7ZeY8yCCPqFut7TPyN6W8PpfjO93r3rxVBu
         Yb9MZ5DqZQaTbzuS7/fsOUGFUjDR9UuIMBz9Az6ONr349o2bjUjMd/c0wPVb2QLstwTV
         xAAzRNPDp8V7wqnv0LDrA3VIuWepRDvsEYGopdrzE2I7YnYCjKsPl8ABBfXIrI2hG0FP
         Hh+Qf9L19XM1ay7i83y+x1nqBhuHSMKtEZBobWd2zQlqvAZHhecUhcxjT7VrJpRPbKfc
         qvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760055686; x=1760660486;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGp2wfDAFolkfVq9Qs1rE1NgIbJJDObk0zASInZr3ZY=;
        b=LQLtOKdeht1j2QKydrD6w/HhiGcTlo5AE0EWpVOaDchir56zlPJdzPVRpTtxbB8QTr
         HHu8GkSElgZ96pZ8KSYcG7VZEWoEPpfk6gds23SWN8hBVWqqPwn5uA5zwmKumJot7dtO
         z0BTDfbTuYvG9cG49qRj+/jo3L3fDhrv8wwytwt+u65IwUuIF6xg3wN5ceVLcSJAPT/7
         s8rsgW020UKeBBecB7OY+/5NLTOEbZaRzwOUwdoPK4URrYijbI7IrCa2FyjWyaaJEZOk
         eVPzWMX8eOzDBmQ2OXZJ46+GYitDfH9WBbsDjEmXVQML2OfWc6Ag3eFIlcBKvudeF3vf
         hSaw==
X-Forwarded-Encrypted: i=1; AJvYcCVQt92PplG3IFkTEGRpRzlSEX6ShcJRlL5RPOPWD8tq2u/XME8ZClAKCFBtp5N+zbX6pbzBRyA27yeajU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJqTrPi5Gtk1V6nBdR3zRVZoD2MTmujxMxX6UyRuKe0WSWmGOi
	rfEnoBwHrGfspr957lRAN3zHO9jBWKk8vX9qsDURZ2De4cl+T/ccPPkfRs4R7lFf7IzPhRET1zF
	ygGI6NVtCacT54YUc+82PWse2SQ==
X-Google-Smtp-Source: AGHT+IG451d95NRbSW/wlsg20bhmpTgeVeiEB2OFWXt7jX0fy0jXtG2MkrCaEHgibL5DvluwKHNfYT//yI41A2iPOw==
X-Received: from pjbbo24.prod.google.com ([2002:a17:90b:918:b0:334:1935:56cc])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c5:b0:27f:1c1a:ee57 with SMTP id d9443c01a7336-290273736d4mr132813845ad.16.1760055686189;
 Thu, 09 Oct 2025 17:21:26 -0700 (PDT)
Date: Thu, 09 Oct 2025 17:21:24 -0700
In-Reply-To: <20251007222356.348349-1-seanjc@google.com> (message from Sean
 Christopherson on Tue,  7 Oct 2025 15:23:56 -0700)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqz5xcnhaij.fsf@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Define a CLASS to get+put guest_memfd
 file from a memslot
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	seanjc@google.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Add a CLASS to handle getting and putting a guest_memfd file given a
> memslot to reduce the amount of related boilerplate, and more importantly
> to minimize the chances of forgetting to put the file (thankfully the bug
> that prompted this didn't escape initial testing).
>
> Define a CLASS instead of using __free(fput) as _free() comes with subtle
> caveats related to FILO ordering (objects are freed in the order in which
> they are declared), and the recommended solution/workaround (declare file
> pointers exactly when they are initialized) is visually jarring relative
> to KVM's (and the kernel's) overall strict adherence to not mixing
> declarations and code.

This is kind of dangerous, glad you highlighted this!

> E.g. the use in kvm_gmem_populate() would be:
>
> 	slot = gfn_to_memslot(kvm, start_gfn);
> 	if (!kvm_slot_has_gmem(slot))
> 		return -EINVAL;
>
> 	struct file *file __free(fput) = kvm_gmem_get_file(slot;
> 	if (!file)
> 		return -EFAULT;
>
> 	filemap_invalidate_lock(file->f_mapping);
>
> Note, using CLASS() still declares variables in the middle of code, but
> the syntactic sugar obfuscates the declaration, i.e. hides the anomaly to
> a large extent.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> ---
>  virt/kvm/guest_memfd.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 94bafd6c558c..130244e46326 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -307,6 +307,9 @@ static inline struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
>  	return get_file_active(&slot->gmem.file);
>  }
>  
> +DEFINE_CLASS(gmem_get_file, struct file *, if (_T) fput(_T),
> +	     kvm_gmem_get_file(slot), struct kvm_memory_slot *slot);
> +
>  static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>  {
>  	return gfn - slot->base_gfn + slot->gmem.pgoff;
> @@ -605,13 +608,12 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
>  	unsigned long start = slot->gmem.pgoff;
>  	unsigned long end = start + slot->npages;
>  	struct kvm_gmem *gmem;
> -	struct file *file;
>  
>  	/*
>  	 * Nothing to do if the underlying file was already closed (or is being
>  	 * closed right now), kvm_gmem_release() invalidates all bindings.
>  	 */
> -	file = kvm_gmem_get_file(slot);
> +	CLASS(gmem_get_file, file)(slot);
>  	if (!file)
>  		return;
>  
> @@ -626,8 +628,6 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
>  	 */
>  	WRITE_ONCE(slot->gmem.file, NULL);
>  	filemap_invalidate_unlock(file->f_mapping);
> -
> -	fput(file);
>  }
>  
>  /* Returns a locked folio on success.  */
> @@ -674,19 +674,17 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		     int *max_order)
>  {
>  	pgoff_t index = kvm_gmem_get_index(slot, gfn);
> -	struct file *file = kvm_gmem_get_file(slot);
>  	struct folio *folio;
>  	bool is_prepared = false;
>  	int r = 0;
>  
> +	CLASS(gmem_get_file, file)(slot);
>  	if (!file)
>  		return -EFAULT;
>  
>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
> -	if (IS_ERR(folio)) {
> -		r = PTR_ERR(folio);
> -		goto out;
> -	}
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
>  
>  	if (!is_prepared)
>  		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> @@ -698,8 +696,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	else
>  		folio_put(folio);
>  
> -out:
> -	fput(file);
>  	return r;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
> @@ -708,7 +704,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>  long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
>  		       kvm_gmem_populate_cb post_populate, void *opaque)
>  {
> -	struct file *file;
>  	struct kvm_memory_slot *slot;
>  	void __user *p;
>  
> @@ -724,7 +719,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
>  	if (!kvm_slot_has_gmem(slot))
>  		return -EINVAL;
>  
> -	file = kvm_gmem_get_file(slot);
> +	CLASS(gmem_get_file, file)(slot);
>  	if (!file)
>  		return -EFAULT;
>  
> @@ -782,7 +777,6 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
>  
>  	filemap_invalidate_unlock(file->f_mapping);
>  
> -	fput(file);
>  	return ret && !i ? ret : i;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_populate);
>
> base-commit: 6b36119b94d0b2bb8cea9d512017efafd461d6ac

