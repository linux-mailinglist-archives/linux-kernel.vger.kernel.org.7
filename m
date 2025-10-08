Return-Path: <linux-kernel+bounces-845496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433DBC5281
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8EF84EDD18
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED128315A;
	Wed,  8 Oct 2025 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIfpuXSL"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F651A23BE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929316; cv=none; b=NM1YDpBaH1ir1pHPe1SWfUUeqthIroWFDfIbtADgBuuyTmhIMCp0TaXaolNj/pNQEubQDVdZpTt4cAZ1B7g2qGo9M1Zqxfroh/PTsnw3YzLUXUjxGsv+u5VHATC5HQTiWBClohmwEeBl242eQAZ5oHege0mLp1xeztaccAmLXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929316; c=relaxed/simple;
	bh=CKys8xJDsixk4GZcRnoL31wC6RicgzU4/uO8xbMBzzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rYb6tn2JxvEu+7Krq8zzJbHSqeuX371GSDSiMIfTQXbJ7swk+hXMJVHxwPRGKeMQ6dqwFR5CmDTD1RCB0XU7wc2Ot8LzUkPMhNSeUrUPfh+pm4qOUoE4LfnoRJLRB4SfmlbjuihnV9Tl+vE7Af4d7a1UXGDxxJqbqtvYqP3JSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIfpuXSL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e473e577eso39229785e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759929313; x=1760534113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3GMh8gF1Uu4hd329Ty2DF0Ok3lYIutJuQKHJlpedSPk=;
        b=ZIfpuXSLr3xdcpb5YfJg5fSuh09LvdzmtOEF3aTDyXSAxM/rOO2Of7onvS3VH4EH60
         q5aJRjEsJ17CIocEu0jsjJwXU5DmeHeWVsD8Hn/XaIGFGFOg7gw/QILQdMbNsMWU968E
         Nfy8n+OH2JkoZnCbC2zKSd37uwWsqYeUnI0KMkMazlQbCS2yRKAmKuxNjN3E8p3HQJGE
         ykwq7mvj5mwErIjwbo5QPyoXiwI1snZsAJPlTVKXepf0ru0tXBqlkJA3i33VnxV+lFl6
         ybgXnw7d9mdeXO149uqsVWRp+X5Ln9gI+DwAQrsyfqPxa2u5rbh4KqhSsoOvNrk1CmBu
         MY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929313; x=1760534113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GMh8gF1Uu4hd329Ty2DF0Ok3lYIutJuQKHJlpedSPk=;
        b=pQ9+RVqHr3BJ0Sw8Gw+PQ0g3CTXrsIh9Igt6Ov0m8B+spUGqNRXl4cne67gMYZx3v9
         GsWWJACiZsevG+G08nlrwrZqW6NxB7vqv/nnvZGkGjCUgsNmUxp/l0QSCQomduunpsW9
         F3GTtsSW+NIVqXxbWYITicKA91KK2+KxXdY/TjSbURWpKcNT1whGplTbT9V82Ryq261B
         v5Xm+03kps3vJzQmlwLFZZ+F6JnspUPumDhOHkcgFXtg/3gt9gUpceql9jahb2h0PSkb
         QAm8+XxYSsMszf4YOTbg+LQxoBZFAIPTV/MM4roXJzyrmjgYxEAZtPARdjcCxvbU2TFr
         24Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWop2CWSRz3Q0zr5iWwXIyD8d8D42rjxN1HsPlSyibNjzu/mmhjbrpwourjDhvKphi4XKK7Yza1ipQup6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc325qfHXpThAouu/jYmibbszP1QA7pg6VNdoWXjjxRHNAESMx
	dkYQivSS3/6QQW3+e975gOjNsj3tIHg2GmLG8A8IntguSkErCkA53/bf5ueNIqu+RD7FH9c7dWM
	ZJ5XSQSCfWuCKA4+6kg==
X-Google-Smtp-Source: AGHT+IE89beyKsvULLcf3UqV4s6rtxpjy11EnRj5cgsae6DgqsLnVq5SrKgEBnb7OKFnTiIg04Lj/tLVIr0qKRI=
X-Received: from wmbz6.prod.google.com ([2002:a05:600c:c086:b0:46e:1bcf:3f8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c162:b0:45f:2cb5:ecff with SMTP id 5b1f17b1804b1-46fa9b02fa3mr29367005e9.31.1759929313030;
 Wed, 08 Oct 2025 06:15:13 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:15:12 +0000
In-Reply-To: <20251008125427.68735-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007162136.1885546-1-aliceryhl@google.com> <20251008125427.68735-1-acsjakub@amazon.de>
Message-ID: <aOZj4Jeif1uYXAxZ@google.com>
Subject: Re: [PATCH] mm: use enum for vm_flags
From: Alice Ryhl <aliceryhl@google.com>
To: Jakub Acs <acsjakub@amazon.de>
Cc: djwong@kernel.org, jhubbard@nvidia.com, akpm@linux-foundation.org, 
	axelrasmussen@google.com, chengming.zhou@linux.dev, david@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, peterx@redhat.com, rust-for-linux@vger.kernel.org, 
	xu.xin16@zte.com.cn
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 08, 2025 at 12:54:27PM +0000, Jakub Acs wrote:
> redefine VM_* flag constants with BIT()
> 
> Make VM_* flag constant definitions consistent - unify all to use BIT()
> macro and define them within an enum.
> 
> The bindgen tool is better able to handle BIT(_) declarations when used
> in an enum.
> 
> Also add enum definitions for tracepoints.
> 
> We have previously changed VM_MERGEABLE in a separate bugfix. This is a
> follow-up to make all the VM_* flag constant definitions consistent, as
> suggested by David in [1].
> 
> [1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/
> 
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xu Xin <xu.xin16@zte.com.cn>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> Hi Alice,
> 
> thanks for the patch, I squashed it in (should I add your signed-off-by
> too?) and added the TRACE_DEFINE_ENUM calls pointed out by Derrick.

You could add this if you go with the enum approach:

Co-Developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>

> I have the following points to still address, though: 
> 
> - can the fact that we're not controlling the type of the values if
>   using enum be a problem? (likely the indirect control we have through
>   the highest value is good enough, but I'm not sure)

The compiler should pick the right integer type in this case.

> - where do TRACE_DEFINE_ENUM calls belong?
>   I see them placed e.g. in include/trace/misc/nfs.h for nfs or
>   arch/x86/kvm/mmu/mmutrace.h, but I don't see a corresponding file for
>   mm.h - does this warrant creating a separate file for these
>   definitions?
> 
> - with the need for TRACE_DEFINE_ENUM calls, do we still deem this
>   to be a good trade-off? - isn't fixing all of these in
>   rust/bindings/bindings_helper.h better?
> 
> @Derrick, can you point me to how to test for the issue you pointed out?

I'm not familiar with the TRACE_DEFINE_ENUM unfortunately.

> +#ifndef CONFIG_MMU
> +TRACE_DEFINE_ENUM(VM_MAYOVERLAY);
> +#endif /* CONFIG_MMU */

Here I think you want:

#ifdef CONFIG_MMU
TRACE_DEFINE_ENUM(VM_UFFD_MISSING);
#else
TRACE_DEFINE_ENUM(VM_MAYOVERLAY);
#endif /* CONFIG_MMU */

> +TRACE_DEFINE_ENUM(VM_SOFTDIRTY);

Here I think you want:

#ifdef CONFIG_MEM_SOFT_DIRTY
TRACE_DEFINE_ENUM(VM_SOFTDIRTY);
#endif

Alice

