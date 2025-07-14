Return-Path: <linux-kernel+bounces-730471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD921B0450A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E312216F390
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344325E471;
	Mon, 14 Jul 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SodZEKdQ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A51F94A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509228; cv=none; b=m2N+tjIbw44P5PRf8zsb7it1g3mVD0NQqmfe5otyincJnFHOHWH3mI5sllcog6IM1RRjbEjso41qBNmfhaLhDsbH8FFtpJSXVWCGRkI2mnqGFC2WrIXkByQ12doPhyR/L+YoGKrstGB7jl/srSb5yXWlOkTAIV+68OHXde+ELbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509228; c=relaxed/simple;
	bh=1f5iDYyg7pFvvJ/f+ZcV3C9Q8NHQkvJ8PD/thQfBxmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CwdLMvhABqAEVm/1yewCa511hkAtbThZmVqOiJY6NKUlJSIG02hbCBg3GNcqDq92xEkcR+y1AL99FFkE3sRjrLUdpOXbbSpYf+LuWRvo3oFvwN8Bnv0E5hxHG9P0LK1XbmcxmewPn5YKvkQXqwag4/Ca7ngY7MKSGXaPKlw9rJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SodZEKdQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so7504373a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752509227; x=1753114027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFzCpjpnT5pu45+vfCTcQUDn2FG9971MD381M8S0XxI=;
        b=SodZEKdQE0GWHn6ffjUAxgXa1zKkxMA1lzlhe/sxrDzi4aqd/ZVOVjXst0EgW5jRxq
         5O73Gh3cySRT6GRqoDihumtbSsuhOjrFbo4vfkuOzt5oisRThVHPk5UOnQVsEGQnVQ8H
         CF1CUnHi5rVLY8/EZpAYfx/OgbGSpmEtU01UcEVUmG49U7JOcu5Zh2yGgmagntaAP/QK
         dz+L84fwo0KgMREHFIkWm4KZqWewkKrZQvGBBU6mRGlNlZuPntGzZrKZ2Ypzj/qWjFLr
         Pi4Er8+TpTjsn9xXFv77bEtf+vOY3h/A2sLEnxcAHqRfajyO+dFcWO8D280h2x69O9GQ
         zMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509227; x=1753114027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFzCpjpnT5pu45+vfCTcQUDn2FG9971MD381M8S0XxI=;
        b=ku9fElsn0TulhZHmXlsrt1mmNrrAKLF/UhcunkJBuEW/C6HAgS4+bK4rpzCzHk8VAG
         7ys26WrikPK/eriLhszPbGF0WtfcvDMdULfn5yS8hyDj1A8qwcIkF9KbTfEXtJ88eZU8
         c68SIv2/Qt/fD4AxMWgAlz2A/cUMDe8do30yjJatkkC/6YQzpz20Cznaww/ty9VmY/l6
         EuiSup8pc9vC92j6hb4dXXE2nVeVQxrh1E/S5d76aR83GaOXyX0EKhHKX4PbJCLLVxXT
         fy8rYhetAAoJG23rfMrH3CEJoDq8LXBDD9MI9Y8b0mv8AaLS61LbPwO5JAN0ualhEvkt
         arhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF47oeNo8nbWCjiqtMo2G4IBTIwKFnYTpXhjGR9LMbo5mj7mTP0gK3gJr+YT/0SF42rhxoOr44pZu3FM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxnUcykLGDAeXgB2ZIqyIwwpdskq4KZGVLxKD9vz8pL45UR7rJ
	PCQ46dSdn2/pymO05hZebh6tul10arMGFJ7iM0YJDbALgAGDE+02rp+ald+KGp3VngEIxT+v+uD
	kuGiqpw==
X-Google-Smtp-Source: AGHT+IHCYeit5S+pWxOmcaU6ohQE+H1ByFTKj1agLfLUmaNctvSV0h1usGNpUPqkAAVw0zRAi41zSasIzbc=
X-Received: from pjq11.prod.google.com ([2002:a17:90b:560b:b0:2ff:84e6:b2bd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acf:b0:314:2a2e:9da9
 with SMTP id 98e67ed59e1d1-31c4f5922b7mr18899944a91.25.1752509226579; Mon, 14
 Jul 2025 09:07:06 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:07:05 -0700
In-Reply-To: <c5c964cd-947e-43ff-9c79-18c1555aea8e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703062641.3247-1-yan.y.zhao@intel.com> <20250709232103.zwmufocd3l7sqk7y@amd.com>
 <aG_pLUlHdYIZ2luh@google.com> <aHCUyKJ4I4BQnfFP@yzhao56-desk>
 <20250711151719.goee7eqti4xyhsqr@amd.com> <aHEwT4X0RcfZzHlt@google.com>
 <aHSgdEJpY/JF+a1f@yzhao56-desk> <aHUmcxuh0a6WfiVr@google.com> <c5c964cd-947e-43ff-9c79-18c1555aea8e@redhat.com>
Message-ID: <aHUrKWaixqJyhsUU@google.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kai.huang@intel.com, adrian.hunter@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@intel.com, binbin.wu@linux.intel.com, 
	dmatlack@google.com, isaku.yamahata@intel.com, ira.weiny@intel.com, 
	vannapurve@google.com, ackerleytng@google.com, tabba@google.com, 
	chao.p.peng@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 14, 2025, David Hildenbrand wrote:
> On 14.07.25 17:46, Sean Christopherson wrote:
> > On Mon, Jul 14, 2025, Yan Zhao wrote:
> > > On Fri, Jul 11, 2025 at 08:39:59AM -0700, Sean Christopherson wrote:
> > > > The below could be tweaked to batch get_user_pages() into an array of pointers,
> > > > but given that both SNP and TDX can only operate on one 4KiB page at a time, and
> > > > that hugepage support doesn't yet exist, trying to super optimize the hugepage
> > > > case straightaway doesn't seem like a pressing concern.
> > > 
> > > > static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
> > > > 				struct file *file, gfn_t gfn, void __user *src,
> > > > 				kvm_gmem_populate_cb post_populate, void *opaque)
> > > > {
> > > > 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
> > > > 	struct page *src_page = NULL;
> > > > 	bool is_prepared = false;
> > > > 	struct folio *folio;
> > > > 	int ret, max_order;
> > > > 	kvm_pfn_t pfn;
> > > > 
> > > > 	if (src) {
> > > > 		ret = get_user_pages((unsigned long)src, 1, 0, &src_page);
> > > get_user_pages_fast()?
> > > 
> > > get_user_pages() can't pass the assertion of mmap_assert_locked().
> > 
> > Oh, I forgot get_user_pages() requires mmap_lock to already be held.  I would
> > prefer to not use a fast variant, so that userspace isn't required to prefault
> > (and pin?) the source.
> > 
> > So get_user_pages_unlocked()?
> 
> Yes, but likely we really want get_user_pages_fast(), which will fallback to
> GUP-slow (+take the lock) in case it doesn't find what it needs in the page
> tables.
> 
> get_user_pages_fast_only() would be the variant that doesn't fallback to
> GUP-slow.

Doh, right, that's indeed what I want.

