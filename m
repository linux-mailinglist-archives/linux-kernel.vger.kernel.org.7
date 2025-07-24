Return-Path: <linux-kernel+bounces-744915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86329B11270
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3F93BE8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69802EACE9;
	Thu, 24 Jul 2025 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEDgRHpi"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C087271A9A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389474; cv=none; b=MCdP+4DW3/Y5S5rSLya4bogFgOEuezKt2113IdLyNwCs9GA4wqv5NspnGLqV3ISP6Y/U//WUEmsQehULw/badH5QCj9giLQahTmsnV0Dz++Cg33YnRbuDhK7EeWVpF04otCnaheGgXD8c3FsZxIX6RNLoCss9+8T8q7a35Jy1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389474; c=relaxed/simple;
	bh=3iJhYIBCliLx6cvM/xxvbhRa/DzQUN/C5dE3qUgVnlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sWNayyBogQ10m+6iUtZyOadUkO7PLqmQw0bNonOW8fVjAkYFAeVPVkD0npnZcIvs7/numE5wC4EVA1wSIhTYgCT5bLYSzwNRCi+jgXc4Zg7xbMMCa9TvMxWYM5qtzJRjNq3LN0hPgsiYMU30jCHTIOnbLjuCCZrum5JHi08MxXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEDgRHpi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so2113637a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753389471; x=1753994271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BadAfBHN4AUhi6edketoROygiJlH6yDIJ6nBg0r11k=;
        b=AEDgRHpiZSiaa2R157mKgOMG31T0HVziN7qk7TufZp1bkvwwAIZbCP0d0D5jsLvp9R
         1Rp8+5y6zqe9Ojrkf5YbiN/D+oaD22iI2y0yeyHGCNOH1k5FL13YyKGiimEoPvlL+eIP
         MZ8cMaoWTsFKiKZfnWUO0nj1RdUVDhkaH5YNP5KhIkBKsPuUAZo1JWJfkNS7jU5UUZYL
         rQp3gYS81Q+guaCJUjVx95rwWqfl7j8VaAvQcQV6f/jazpC8e7bf3xFsY7z2bTvHUxZj
         o2RO/hczvkRGw8PqRTX/ejvruh6KlB4jAgM/qMEexe2TZN6AUU2aXlM5ozKI2hoTtbob
         l9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753389471; x=1753994271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BadAfBHN4AUhi6edketoROygiJlH6yDIJ6nBg0r11k=;
        b=DRDzOwqFgK4+SNADlxzSDpZ32d4ZyGkCWVnG2YEh8lttSI743ZhfhuwWBhkbOatN/n
         qEN2L13W2+QsVNKyUxXmYDiA2SMMJBzjE3LLL5qie1CCEgFmeTpIdUqhosFL7EL2a2kV
         OtIoRDVmIPIgtFnJUXlrevC0EJXF68j6EOaW8I3wEJua4KUM/qpg99k3aQQNE15cgSIs
         pTa++YbYWRAOiy/kXkgSVuqYL/63aqxaG8elIDoIi3PnbNV18uGN3a0izBgPkRD5aAx2
         YnvQIWeMk88o6IwdkGONUrMPRepCWFUxpNXlEAka7NqMy/7bKywCZrbsmZ2Zys8EMpD/
         PIcw==
X-Forwarded-Encrypted: i=1; AJvYcCX+SUSmt6f2sMcLtnvPv3Gnd0WgUjCg+f3HYb0t4y3T//KfnamcrxCL29aNH4AA4jWBjU2pXapfC5XPj18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5yEtsNKNwAPy8vmoXpBzOkQujJSU89yxLIWhPkTAJBBkXCI4
	51kH+STv3T/xKEiNTJR/Y3D+sKIW6bdAW4uUj4RlBble3yFjias/E/YiWutKm+jAf276BGV3knG
	ttaCtfA==
X-Google-Smtp-Source: AGHT+IHE6eAlwl7jscbkUzp5U5t1vNbnbqNXqGFHZeQed0+nu225pCuYGNqmuyqiKrC1WFWx4eys1B4+PuU=
X-Received: from pjyr5.prod.google.com ([2002:a17:90a:e185:b0:31c:2fe4:33be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5487:b0:311:f99e:7f4a
 with SMTP id 98e67ed59e1d1-31e507cddb3mr11188514a91.26.1753389470881; Thu, 24
 Jul 2025 13:37:50 -0700 (PDT)
Date: Thu, 24 Jul 2025 13:37:49 -0700
In-Reply-To: <20250714103441.496787279@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714102011.758008629@infradead.org> <20250714103441.496787279@infradead.org>
Message-ID: <aIKZnSuTXn9thrf7@google.com>
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, pbonzini@redhat.com, 
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, jpoimboe@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 14, 2025, Peter Zijlstra wrote:
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -361,6 +361,10 @@ SYM_FUNC_END(vmread_error_trampoline)
>  
>  .section .text, "ax"
>  
> +#ifndef CONFIG_X86_FRED
> +
>  SYM_FUNC_START(vmx_do_interrupt_irqoff)
>  	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
>  SYM_FUNC_END(vmx_do_interrupt_irqoff)
> +
> +#endif

This can go in the previous patch, "x86/fred: KVM: VMX: Always use FRED for IRQs
when CONFIG_X86_FRED=y".

