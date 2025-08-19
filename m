Return-Path: <linux-kernel+bounces-776302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7366BB2CB87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF195521B92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1D030E0CB;
	Tue, 19 Aug 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RZ8hcMn"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551EB30DD3E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626243; cv=none; b=VYmnUj44YvEQz1VrX5zSJQN6wgVTZHUmKANbWcaxAAY8/dhYgayuMVq9pqgf6Bnuh83bXNEd94GnHu5ybyqDNd96lWmCuMxmfwoyGNfZyMyez8CXlySrdHU54xeIrePN13ClNB2/zNeEDMmmuMe6YEBiZ4tZutXoznXIq18onLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626243; c=relaxed/simple;
	bh=Lekw3wykeuF3Waa5M9M8csKwjmFTtD+8UG+rgUe1cR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0TBwICcibExGg0RmAdfFH9YBVJXuBuBdj4gmGlSTc/2HksS9NZNbI//Au0vCT6U230IwSPGJdDyB88oo3KEl4oQa1WGTewYUvHUXyyIXOR4xE6VQyx9oSCbOqgXz27AWFP/uIv1wGk3kbH2ImV/YKavQWn/KxiVmfa2/yL45Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RZ8hcMn; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4704f9dfc0so102711a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755626241; x=1756231041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=awFHWzNWAp5SYh09L94PKcRcaUavFe5/Zi4ooub4Zj0=;
        b=1RZ8hcMnY0UkisAccNUEIDq/XVdQshTWeDhlsOTmUmQQZyaenu3QYnjjtQ02U31thh
         hNJqo4/3s/98whJCPC1EFGc7F4W2IcXWvQdUY3JgJkkog8pBWYqADosYUYyvZQesHWxk
         IFkFNLV8RrtWi7NB7dM9Mx7O8JaSTh1sFoPQJidXKTCYXDou4n9Ued/Gpd6zrr+O7nZ5
         3gCP8QD241kALBCqMhKEwUlifjVjTlZFfKKaWWd3G3WgSp2zHmSfFKxSsch63qDNpsuq
         HHFX7JMzffuYvVstdQnAMywKs5qKhGYU9BiQLUAQYfIhUd4hN8qOHARstmFE+hVLxAGO
         Ab9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755626241; x=1756231041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awFHWzNWAp5SYh09L94PKcRcaUavFe5/Zi4ooub4Zj0=;
        b=cy+xFK5PJ5nJQa42sneXlhqy0GFTJihqWQflTp7iFzbdeCGzVEXUERUEJKPQaVv6im
         QNtUP2gkpTKJWtyygBvRuLAM2upK4cLjLTkYvBttoVD+394Sf2bmnJht2hILLA2NrI/i
         xyTpCLOUgrs4t49e9nVcmzWRU093F0guoxE9E2Ky+gk2SBvVIyYlLc+izOCFDP5Kfqpu
         6Wu2WLyJdzJdvilpRTsKUOeFVHiQb1bID1fLx679fcDKSz3UQnsSIYb+DfCHc/dbhadb
         +gex8xuKw8linyx9I8NXyOC4PyzbYvn53I4JXCdSr3ga4Xx2PxIL72WTNOYQ/VZnS1wx
         F+jg==
X-Forwarded-Encrypted: i=1; AJvYcCVfWe/AaEK1hm3PGNK6JFXktbpwJgVTT3YQ9ads8JeskJZuRXfygkLUI9assEQ//tRtBKNx5RmfHuSBD8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFasnQYOnsBm/INVD8yuzzrRK3jyls+9ePAYmAIUg1SR8dFWJy
	7WgzlbJJYagRFsg9dPzHU5mPb8CFpc4hWXQ8PaHxjwZ+z7h/qDVCiBP1Jitg9s6XAga479Qir9L
	Ru6ujvw==
X-Google-Smtp-Source: AGHT+IEojSr7GoNvTuxvzXZluQEK52TmYYgrRBoN6UydB/hS70lcHeVWVE771Bsmo2VW75hUu7alv8ngTns=
X-Received: from plhy2.prod.google.com ([2002:a17:902:d642:b0:240:770f:72cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1acc:b0:23e:3911:433e
 with SMTP id d9443c01a7336-245edfd8310mr3177075ad.5.1755626241631; Tue, 19
 Aug 2025 10:57:21 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:57:20 -0700
In-Reply-To: <20250707224720.4016504-2-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com> <20250707224720.4016504-2-jthoughton@google.com>
Message-ID: <aKS7ANG-_EJyEY6U@google.com>
Subject: Re: [PATCH v5 1/7] KVM: x86/mmu: Track TDP MMU NX huge pages separately
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 07, 2025, James Houghton wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4e06e2e89a8fa..f44d7f3acc179 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -65,9 +65,9 @@ int __read_mostly nx_huge_pages = -1;
>  static uint __read_mostly nx_huge_pages_recovery_period_ms;
>  #ifdef CONFIG_PREEMPT_RT
>  /* Recovery can cause latency spikes, disable it for PREEMPT_RT.  */
> -static uint __read_mostly nx_huge_pages_recovery_ratio = 0;
> +unsigned int __read_mostly nx_huge_pages_recovery_ratio;
>  #else
> -static uint __read_mostly nx_huge_pages_recovery_ratio = 60;
> +unsigned int __read_mostly nx_huge_pages_recovery_ratio = 60;

Spurious changes.

>  #endif
>  
>  static int get_nx_huge_pages(char *buffer, const struct kernel_param *kp);

...

> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index db8f33e4de624..a8fd2de13f707 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -413,7 +413,10 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
>  void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
>  void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_level);
>  
> -void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
> -void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
> +void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
> +				 enum kvm_mmu_type mmu_type);
> +void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
> +				   enum kvm_mmu_type mmu_type);
>  
> +extern unsigned int nx_huge_pages_recovery_ratio;

And here as well.  I'll fixup when applying.

