Return-Path: <linux-kernel+bounces-838286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D0BAEDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0193D2A0ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AFB19C54F;
	Wed,  1 Oct 2025 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYMrT5H3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A86323E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278291; cv=none; b=Un7E7yopP8sJ/CZqGexB7gh4vzCtAJtQc1MZG6KJym/eLWwuFKsBVssFQBiPqy5vFrVNtu5ThX4ccdhlRAadv7TAGPAl6f/mdIxBnnvxgel6jXr7AJXwpLyXYOnPmGk1GU5lU5CkYxmA9w4S8lu+NNHQ1i0cVZJzuJY7Sy0ARkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278291; c=relaxed/simple;
	bh=wdbGl3YtlYSj7rUi4uJ4rCJpgVcR+R3PUL10KRjlh0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O/A5bO9JahW+TosgElCtnSa4yIlR+TTxQPWEUhIRBl5NJaqX4WqR/3jk8zF9JxFBAMcy/eM09+iuAKsueZUuPgdkyI3N3PZt7tydIY0LrTw/RXQtxgVPgIkgY7uewWylliFt2b6vT7AfSDX+bOsZQDcJ517ODWkI3AQ2DM8TKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYMrT5H3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so5767214a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759278289; x=1759883089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpX7eK2KA+kl+z8v9XAKv4xAjG0zaOC9KjRE1zxocmk=;
        b=XYMrT5H3RBSkPZKEcYTetKn0sYs82V345JTYjstXRcnVG3uwNRTlD2cr73C6zdb/No
         T4B3DekaYrGZdqx8Un6oy6EhyamhcoDBCbPwK0np3g8k8c3n+roZweYujBXzZCHKW4Us
         hXNZ854nWJU17J2rM1ycJGwlCVIyvB3rH228L66zwyawfavSTH+J233WGfvwUmqMzTeo
         klLXyOd52r8ZjJDgcNKXmqHhSaCXrtx6qirqHongA66+ufIS1mj4A42sx0t/y6xB1oyW
         qdWM7t7ZQDpTIBjuhaMsYUlg8a9L+IowimN+lACbGN+CPTFRna+0cKBtOUC77fAluHmt
         /1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759278289; x=1759883089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpX7eK2KA+kl+z8v9XAKv4xAjG0zaOC9KjRE1zxocmk=;
        b=UABCxmOPse7fZGoSv2PNHwUwaI3HmCL4mU4avty3YMy+rV/Xv8TZMmUYsn9OrZZHif
         7w9Bi3JlRbKBOSC0Yxd7GeiFnBeRlNtQZ/lphKqz3SElodCi/Ldl94HR+lG3nEI3a33J
         BkaatvXywDWI30ZULFeTzIKA9m4U0PQF1IeDLbdQj3c03xq+hq9tvhuuipPYRuHN+g5/
         52QfHZvyGobjNRZkm6AMkOvgr3NvExNFjSEvyHxc7BwOcXwrW8UhOdNZyxAXjqGRows7
         a/PPNrmET6+2si7McVTuGlDwY3XbutXPDlyBMDlp2TrRiadKb0uZiCtMmbM+rPHz1j7Q
         1MTw==
X-Forwarded-Encrypted: i=1; AJvYcCWhAjXxGG+Ezcu1HlM3lq2xHfSNsIzc/k0tkSi7Dsb1e5qUBbI/cbNvIwMDIEIzEZuhGm69n6TCh06abRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbZ1tkcrTeDThm8ekyKBXAoM4MvNyh+ZzjohicrgPG7NV6X4Z
	et0nwBkHCkbzTzcG8cingVPIdo4PXvH7EPnG1sZQH+zWmYGcYXZ3KJlQjD3G48RzOipceJCXG5B
	JFSotLg==
X-Google-Smtp-Source: AGHT+IEbTJH04br7v19Ddhz6CwxncgpPh5C9LtMO0MpANPdZxHKsfM3i1TAb2fiklX0x6gfHWXFhHnT87mw=
X-Received: from pjzm1.prod.google.com ([2002:a17:90b:681:b0:327:50fa:eff9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c8b:b0:32b:baaa:21b0
 with SMTP id 98e67ed59e1d1-339a6e6d5c9mr1452538a91.6.1759278288907; Tue, 30
 Sep 2025 17:24:48 -0700 (PDT)
Date: Tue, 30 Sep 2025 17:24:47 -0700
In-Reply-To: <aDbdjmRceMLs1RPN@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <237590b163506821120734a0c8aad95d9c7ef299.1747264138.git.ackerleytng@google.com>
 <aDU3pN/0FVbowmNH@yzhao56-desk.sh.intel.com> <e38f0573-520a-4fe8-91fc-797086ab5866@linux.intel.com>
 <aDbdjmRceMLs1RPN@yzhao56-desk.sh.intel.com>
Message-ID: <aNx0z2XZaJZxQ44W@google.com>
Subject: Re: [RFC PATCH v2 06/51] KVM: Query guest_memfd for private/shared status
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Fuad Tabba <tabba@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ira Weiny <ira.weiny@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, David Hildenbrand <david@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 28, 2025, Yan Zhao wrote:
> On Wed, May 28, 2025 at 04:08:34PM +0800, Binbin Wu wrote:
> > On 5/27/2025 11:55 AM, Yan Zhao wrote:
> > > On Wed, May 14, 2025 at 04:41:45PM -0700, Ackerley Tng wrote:
> > > > @@ -2544,13 +2554,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > > >   		return false;
> > > >   	slot = gfn_to_memslot(kvm, gfn);
> > > > -	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot)) {
> > > > -		/*
> > > > -		 * For now, memslots only support in-place shared memory if the
> > > > -		 * host is allowed to mmap memory (i.e., non-Coco VMs).
> > > > -		 */
> > > > -		return false;
> > > > -	}
> > > > +	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot))
> > > > +		return kvm_gmem_is_private(slot, gfn);
> > > When userspace gets an exit reason KVM_EXIT_MEMORY_FAULT, looks it needs to
> > > update both KVM memory attribute and gmem shareability, via two separate ioctls?
> > IIUC, when userspace sets flag GUEST_MEMFD_FLAG_SUPPORT_SHARED to create the
> > guest_memfd, the check for memory attribute will go through the guest_memfd way,
> > the information in kvm->mem_attr_array will not be used.
> > 
> > So if userspace sets GUEST_MEMFD_FLAG_SUPPORT_SHARED, it uses
> > KVM_GMEM_CONVERT_SHARED/PRIVATE to update gmem shareability.
> > If userspace doesn't set GUEST_MEMFD_FLAG_SUPPORT_SHARED, it still uses
> > KVM_SET_MEMORY_ATTRIBUTES to update KVM memory attribute tracking.
> Ok, so the user needs to search the memory region and guest_memfd to choose the
> right ioctl.

I don't see any reason to support "split" models like this.  Tracking PRIVATE in
two separate locations would be all kinds of crazy.  E.g. if a slot is temporarily
deleted, memory could unexpected toggle between private and shared.  As evidenced
by Yan's questions, the cognitive load on developers would also be very high.

Just make userspace choose between per-VM and per-gmem, and obviously allow
in-place conversions if and only if attributes are per-gmem.

I (or someone else?) suggested adding a capability to disable per-VM tracking, but
I don't see any reason to allow userspace to opt-out on a per-VM basis either.
The big selling point of in-place conversions is that it avoids having to double
provision some amount of guest memory.  Those types of changes go far beyond the
VMM.  So I have a very hard time imagining a use case where VMM A will want to
use per-VM attributes while VMM B will want per-gmem attributes.

Using a read-only module param will also simplify the internal code, as KVM will
be able to route memory attributes queries without need a pointer to the "struct
kvm".

In the future, we might have to swizzle things, e.g. if we want with per-VM RWX
attributes, but that's largely a future problem, and a module param also gives us
more flexibility anyways since they tend not to be considered rigid ABI in KVM.

