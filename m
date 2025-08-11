Return-Path: <linux-kernel+bounces-763572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B9B216CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F6968084E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C82DBF5E;
	Mon, 11 Aug 2025 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjFEMoh+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC42D4803
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945419; cv=none; b=fQ0+h9EFBrWqWbv7XRYw5nyu4QHM+LrNvcVb8TJNgD4bW6OTZLFT8VuuaS5GpBNQOj1xe0Ul0gAu5RmetbmVC5UUaorA/9qh0qmRWU9L7UZZv0+ELueJ0WoksY+aXEegYzJ3Q8pRMGsvmXmvn9vfvW8SLF/CV5l/jaM/inFs0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945419; c=relaxed/simple;
	bh=UK0NWKHuPko3+SuzR0r50GMkmrZaT31pWR9AVsnbm9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H6zQt/hA+DeNN99O3lEjgWDtqqJoyWF1HUejW+rw9ZkaUI2aAqlEE/l4FDUEF7yLH0qCFBGLJXC/DX1EvYANI94NBrABuLC5KJBVWXmhOvcTLUqOP4aPxNZWA3rD+7H5Mv3+mqrLr94e3FRiUWtZcWHa48MWhNUw6uf57m9YgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjFEMoh+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ecb3a3d0aso4621065a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754945417; x=1755550217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj1upr9MpZvI1rcVU/DWVgHHJAUXh71dix9PzGRZ79k=;
        b=hjFEMoh+GKoS/YNvqHnCU5JVT5Yv5DpAjg0giNg5BO5oztX2ZCVhCWHSz2tZ7drR98
         iSgMD/nsXB8kLqEQSfB7HJwDl07AlotAx3ADjuDrqZTeIPr96GZTHYe+KuVcAC+hrO3B
         C1iqxN9tZJCXQLM2XqjhGKFxvsIjBjhqFGsft6tLm2ya4nE8APUjFPih5sf3xxJYNrBf
         dwgNStR1Px2SL5dJsd4dYQ2usYPtVJXu5lJlUi+R2lo8RZC/URLGVH4lFl7nIZJUeWAI
         aCTW7/ukclja1ybXzpqiSJ1C05NE5aJ10jcb7GWNR2bPtmHsWHo7rMh6g3aDu1X7VR6o
         o1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945417; x=1755550217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj1upr9MpZvI1rcVU/DWVgHHJAUXh71dix9PzGRZ79k=;
        b=YciMM+wEXLU113qejMHPrXyBS2hMuYcC6tuFImA81UtSD1cdc/Ls1ZwoHAUq0FesXd
         Ra4zOY75d4J1TISL1bwEf6cPI4+Jx5tMDL5R25KCDuo9N84uackxIHFytYSADuFXDF/h
         OUzaiN79rkOM5p3kskYupwAJGu98VYxL/u2gC/gL4q7bs0MNRsAMOf1exfn0byvnuttE
         w6o3fAvoKUTxVYRqKyNPlScqh0bU6wosGNS+6GD99yHHe4Myu9nInBeYunxDaGDCpn5y
         0TUM7kwJ42lwo+rT0+/Y/OG7PpUviyIh2RQwPObDnmwscXnTqntCGJKbkRHwqmuieABH
         dXUg==
X-Forwarded-Encrypted: i=1; AJvYcCVB92Z9A6RznPFq25S8Kol5rW/wdvq/rDH8aL6WNriwWzMlBieaz+W2VHXfvzCYP4y5JYUFKL2SinMBD2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+owvr7blmHCG7cyD5N+oep0Ys/+6EEnAFH1h90Ubej4qMyaYt
	MXkRMAE8zgGC/RC7ZAwWHjmgpMhxLms/GNJCxVnNB+HoGokzQVp70WxQUmGUgf5W1VK0ueovjTo
	zRnwFig==
X-Google-Smtp-Source: AGHT+IF3SMcpDDd6oFa8M7hFXn80njr047YIQ9ybX/L/gNxKoCD48pHAQLZRJzHN8JTduu/jHLvxmTxiLeA=
X-Received: from pjnx5.prod.google.com ([2002:a17:90a:8a85:b0:31f:335d:342d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3885:b0:321:27d5:eaf1
 with SMTP id 98e67ed59e1d1-321c0a95a7fmr1160081a91.25.1754945417608; Mon, 11
 Aug 2025 13:50:17 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:50:15 -0700
In-Reply-To: <20250811203041.61622-2-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811203041.61622-1-yury.norov@gmail.com> <20250811203041.61622-2-yury.norov@gmail.com>
Message-ID: <aJpXh3dQNZpmUlHL@google.com>
Subject: Re: [PATCH 1/2] KVM: SVM: don't check have_run_cpus in sev_writeback_caches()
From: Sean Christopherson <seanjc@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zheyun Shen <szy0127@sjtu.edu.cn>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> Before calling wbnoinvd_on_cpus_mask(), the function checks the cpumask
> for emptiness. It's useless, as the following wbnoinvd_on_cpus_mask()
> ends up with smp_call_function_many_cond(), which handles empty cpumask
> correctly.

I don't agree that it's useless.  The early check avoids disabling/enabling
preemption (which is cheap, but still), and IMO it makes the KVM code more obviously
correct.  E.g. it takes quite a bit of digging to understand that invoking
wbnoinvd_on_cpus_mask() with an empty mask is ok/fine.

I'm not completely opposed to this change, but I also don't see the point.

> While there, move function-wide comment on top of the function.
> 
> Fixes: 6f38f8c57464 ("KVM: SVM: Flush cache only on CPUs running SEV guest")
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  arch/x86/kvm/svm/sev.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 2fbdebf79fbb..49d7557de8bc 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -716,15 +716,12 @@ static void sev_clflush_pages(struct page *pages[], unsigned long npages)
>  	}
>  }
>  
> +/*
> + * The caller is responsible for ensuring correctness if the mask
> + * can be modified, e.g. if a CPU could be doing VMRUN.
> + */
>  static void sev_writeback_caches(struct kvm *kvm)
>  {
> -	/*
> -	 * Note, the caller is responsible for ensuring correctness if the mask
> -	 * can be modified, e.g. if a CPU could be doing VMRUN.
> -	 */
> -	if (cpumask_empty(to_kvm_sev_info(kvm)->have_run_cpus))
> -		return;
> -
>  	/*
>  	 * Ensure that all dirty guest tagged cache entries are written back
>  	 * before releasing the pages back to the system for use.  CLFLUSH will
> -- 
> 2.43.0
> 

