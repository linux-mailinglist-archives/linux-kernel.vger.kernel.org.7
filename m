Return-Path: <linux-kernel+bounces-741302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17FCB0E295
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9B917F838
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EBB4685;
	Tue, 22 Jul 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q45HmErC"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CE27AC45
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205265; cv=none; b=oTRnIlbDcS9qCmRyuVIJIebsv5NehtUzHN73AmW2EVIOv/bxqX+bgcBtBvJhd5gEzGw3rCk3Ba0DO9zDWHYyk0rOHgLgFtzale197lu8hZimcykHODi5WI37W7vtXV87zuCAnAGZQ6FezHT1RK0PtL+vJ8Hu2jlyV0kQUyq+kt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205265; c=relaxed/simple;
	bh=syxL5yFIfrXhC+h4Uv6eBBsalk6IqK7By/q7/N6YndA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlSegg2uXkP67HQeKlP0GqnsHW/Oav9lg/ozxklnVyb0oPLrC8VljfR2hAepU5SfapnxAnYtzD5xQZL9JajIR7YMUxrAHC70sVPpAV4UBBYvl/FDejFZV0PzT3SYjkWU+5HUBWcHKFixPONRUkgZ1tCbcyUURtwSwRNQhpEz9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q45HmErC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23494a515e3so47203655ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753205262; x=1753810062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNuep+WR+auVA36XZo3u/qqPdLw6h3Tg29vPjRH6q58=;
        b=Q45HmErC57yTnIxKh43vbtFhCuYSIO86jfWOqskujsasYE5v5NWqQp/ZV8BfiAHy4I
         KlU0vvyZqPIVgHQlHT9d9yjC17Pw+VLtjIwPiIQLf7Opxpw4AYh/g+BWFSV/nShYpCLa
         CoE2bHjodyqbblCnxV6a1XYG15e8xoV0Sq/40NekF9+W3dF0yek3f92dR6F3742eSHkb
         5pqB1YdpgIVgx4jC7rtyIheMPCQiv1ND462D0m9z1rDiqq+VNjOc1Up/zRy3YFgNyOhj
         MqJl5wFWIXPVWJrxaVxLFR5Zm2DAu7frTdh+6qHsChmr+7+JKBwt9dL97hw6wd3r8oFg
         KpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205262; x=1753810062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNuep+WR+auVA36XZo3u/qqPdLw6h3Tg29vPjRH6q58=;
        b=HCoU1uEd3J8oXIHxLz86MubS23rrTZ/YgcXTprD6ACMOPJe3tRm5JhtjNJOu1BWt3Y
         kRrBVLmp2HSG51NJCKfPU8JoS7C0/J9zoJoDgUcllIUjnl8EM5aI08ZVF7AqSrC8M7jy
         1iZJ+bhvEhiVtOSAyCTox1F2mwH2/F1ofW7T5C+VO58LiXpoKgV1jj1cefqvj1ScRm3G
         vigUVNs2ElIs5v1xM//7qtac/FsPuQe38b369Tm9aofIFJJnBgVlkEAzJAag9wvQLd0y
         VK437bO7Uho+aRmS9WEK8X/Azi60ry9LHWDBo2vWsKzRn2eYsHh6B77B1PINRuhmq0Bm
         ZhIw==
X-Forwarded-Encrypted: i=1; AJvYcCW+7ImGGt++B9uBpBSGssrljIPDe+wXaQobcVCYecxra3HJTUKM/HTy7Efb0RKTI3MN/tuxsVhbbmy/BZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DdN1TjQom9ZtgaU4idib6Qp27LWmV5HitTh3j/PYrSDOoPrI
	20wy+rxDEMufHn68XSEtEpanUfPUUfw+c4EzpRXewV030Hr+qYZgDZGaY7uhDu/YRnMIwbYOFux
	GdVVkCg==
X-Google-Smtp-Source: AGHT+IGlPsKj2kXWks86x+28HfdK7Z/QqkDwZwVYgVnNVIpsClfKH/9J41q2BYHdfvNQBrCCOD4NuTpzbJE=
X-Received: from pjbcz15.prod.google.com ([2002:a17:90a:d44f:b0:312:f650:c7aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6c:b0:235:f51f:c9e4
 with SMTP id d9443c01a7336-23e24f49430mr394121175ad.12.1753205262126; Tue, 22
 Jul 2025 10:27:42 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:27:40 -0700
In-Reply-To: <20250722074958.2567-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722074958.2567-1-lirongqing@baidu.com>
Message-ID: <aH_KDFJsH3i7xF-e@google.com>
Subject: Re: [PATCH] x86/kvm: Downgrade host poll messages to pr_debug_once()
From: Sean Christopherson <seanjc@google.com>
To: lirongqing <lirongqing@baidu.com>
Cc: pbonzini@redhat.com, vkuznets@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 22, 2025, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The current host-side polling messages are misleading, as they will be
> printed when the hypervisor intentionally disables polling (by providing
> MWAIT to the guest) rather than due to version incompatibility. so
> Downgrade to pr_debug_once() to prevent spurious log messages.

I agree the messages are unfortunate, but the guest can't possibly know that the
host is correctly configured.  E.g. if MWAIT is allowed, but the host is still
intercepting HLT and the guest happens to choose HLT for idling, then the guest
is absolutely right to complain.

And there's really no reason for the host to NOT provide KVM_FEATURE_POLL_CONTROL.
The only thing the guest can do with MSR_KVM_POLL_CONTROL is to disable host-side
halt-polling, and for a KVM_HINTS_REALTIME vCPU, single_task_running() should hold
true the vast majority of the time.  I.e. a properly configured host won't actually
poll anyways, so providing KVM_FEATURE_POLL_CONTROL is basically a nop.

In other words, I agree using pr_err is annoying, but I don't think downgrading
it is quite right either.

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  arch/x86/kernel/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 9cda79f..c5f96ee 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -1136,8 +1136,8 @@ static void kvm_enable_host_haltpoll(void *i)
>  void arch_haltpoll_enable(unsigned int cpu)
>  {
>  	if (!kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL)) {
> -		pr_err_once("host does not support poll control\n");
> -		pr_err_once("host upgrade recommended\n");
> +		pr_debug_once("host does not support poll control\n");
> +		pr_debug_once("host upgrade recommended\n");
>  		return;
>  	}
>  
> -- 
> 2.9.4
> 

