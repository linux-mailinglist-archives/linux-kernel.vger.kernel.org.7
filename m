Return-Path: <linux-kernel+bounces-848615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE42EBCE2CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730763B39CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F92C158E;
	Fri, 10 Oct 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifLaA5dI"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11623594A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119173; cv=none; b=eRJOueKd1VNtAuzOViPhZ0D6l3L2xatzzsM9BbBeUAp8hhgksKaRh/AslIJrLLlgShcTAWcnizkU7q7nAMxNq0RnVsrRMe94RFU9TxW74YRU6+lWeVlkjUEowQTdNCsca2ir/Jjd124JF13ufkAceNsR1dofJcPavwzei2bN540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119173; c=relaxed/simple;
	bh=/O4J+xOHjAuEp3KBUHoVkp1FiMuNBMhKCunHsW3BgCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRHg/H0mgWm9r+bWdpcEVMLFS74KZy2o7Fg1E2PYWwT2LaV+8Miczt8NqLjI0Aq+MeGhzBs5ArE/Pf26Q2AffxEUX1X4XUreDdxOft60QtRAsaaQEUrwOfB/21IvNxkVck8HwcDqNjvOLnZuG/fouFqxPnBi2DdK4H+7QJwsA7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifLaA5dI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso3699075b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760119171; x=1760723971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsiTGDp45+d8REu3L6sx1lSo7GE9fyB7bHGlv479Ljo=;
        b=ifLaA5dIVqwF/YlIRqVqqDZg3OJn9+9dls/Csj1K2MIkaQiLnN4+r4WAyEhkFC9Tua
         sJ/XCkFik72ufEecrkIHy1vMyI5CS/H0+NgrIWYgWIxFkz8h4wAsHFJP6WQjhwl4jUmy
         JVgPd5xeKVS4lQogaSEGtb4yJIc5LIFmtaOe3WSSbbtlCrB79FUqf08F+YXGbyosMIlU
         eYrlm1RQsCa/wOoT8rOuvKAQXiVAtzjyJkOOkvRDs+dBB90Yc0rUVW3MYvyzK3zUPLmX
         fnCWT0qhuF4jDqFKnt1nj6OwRaJciYS+TJM8HGQBHEe/wfprdXwrJmOMAGALdoabMLCT
         sLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760119171; x=1760723971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsiTGDp45+d8REu3L6sx1lSo7GE9fyB7bHGlv479Ljo=;
        b=e1fWvQMbDmyU73++VRHYMQ8Od8ZJR23THmRgJIRQKbWjyS4HTvLpgldXBwFivbrBmv
         A4zc/m6vfEiQa7P0x4Z9Tkzl4ti7bWH7oaoSLDClZOF1UnMnHTp1FRgL6CBm3zZJEXEE
         rkMry7OPZZIkBrYwyzQN6Z0h5CHTAyDPaGeRwNNzPUDHeUBQzgnYpzUCuCbGq4mX14NV
         SoAMXHlJOleFEK4fia75xPqp7HxG7gwxzgB4kiPTi098jHQe8G/aPFf2+DttfDl0gc7T
         lkK1tlk2OrMJ9RIsRZbyPKgQKFyI6XKB3dGfTo8cz1RCPnGPcagaa3LddpW+P8QZZSI6
         VhTA==
X-Forwarded-Encrypted: i=1; AJvYcCVfI3F60kpkld3XryRkmgUPDx/HEldgFigkwvBC/HRimgEJmNBrJEmlecHNh/ju76xAft17Y7244L8Ut7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJl3cafWFso2YXIFmIS2pgvAO33c7hgTG+uivLeATUcg2wQ2tJ
	O8fwgnhVm2njrCy2UxpJ33ydtURIb/3Tg7PS49O6svnR1mcIHh0F8tXCNg5U09Rm6LGLlqqNHpb
	pgO6VoO2lTyKOLu/VtGZpKYvfmg==
X-Google-Smtp-Source: AGHT+IFFulhZ6XtWtUEt5DU+FzApmeb72eQ72O6ZaO2RaynTOo8A78bn76Qqn2PHdxN8Dmi5RIdQ4MD/+FcahKppIg==
X-Received: from pjca12.prod.google.com ([2002:a17:90b:5b8c:b0:32b:35fb:187f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d93:b0:2ca:f345:5673 with SMTP id adf61e73a8af0-32da90145fdmr15350975637.27.1760119171293;
 Fri, 10 Oct 2025 10:59:31 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:59:29 -0700
In-Reply-To: <20251007221420.344669-10-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007221420.344669-1-seanjc@google.com> <20251007221420.344669-10-seanjc@google.com>
Message-ID: <diqzy0pifxj2.fsf@google.com>
Subject: Re: [PATCH v12 09/12] KVM: selftests: Use proper uAPI headers to pick
 up mempolicy.h definitions
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Include mempolicy.h in KVM's numaif.h to pick up the kernel-provided NUMA
> definitions,

mempolicy.h was actually already added in the patch before this, maybe
rephrase as

Use included mempolicy.h's definitions

> and drop selftests' definitions, which are _mostly_
> equivalent.  The syscall numbers in particular are subtly x86_64-specific,
> i.e. will cause problems if/when numaif.h is used outsize of x86.
>
> Opportunistically clean up the file comment

This is true

> and make the syscall wrappers
> static inline so that including the header multiple times won't lead to
> weirdness (currently numaif.h is included by exactly one header).
>

The inlining part doesn't appear in this patch, I think it was already
inlined right from the introduction in patch 6.

> Fixes: 346b59f220a2 ("KVM: selftests: Add missing header file needed by xAPIC IPI tests")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/include/numaif.h | 32 +-------------------
>  1 file changed, 1 insertion(+), 31 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
> index aaa4ac174890..1554003c40a1 100644
> --- a/tools/testing/selftests/kvm/include/numaif.h
> +++ b/tools/testing/selftests/kvm/include/numaif.h
> @@ -1,14 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * tools/testing/selftests/kvm/include/numaif.h
> - *
> - * Copyright (C) 2020, Google LLC.
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2.
> - *
> - * Header file that provides access to NUMA API functions not explicitly
> - * exported to user space.
> - */
> +/* Copyright (C) 2020, Google LLC. */
>  
>  #ifndef SELFTEST_KVM_NUMAIF_H
>  #define SELFTEST_KVM_NUMAIF_H
> @@ -37,25 +28,4 @@ KVM_SYSCALL_DEFINE(mbind, 6, void *, addr, unsigned long, size, int, mode,
>  		   const unsigned long *, nodemask, unsigned long, maxnode,
>  		   unsigned int, flags);
>  
> -/* Policies */
> -#define MPOL_DEFAULT	 0
> -#define MPOL_PREFERRED	 1
> -#define MPOL_BIND	 2
> -#define MPOL_INTERLEAVE	 3
> -
> -#define MPOL_MAX MPOL_INTERLEAVE
> -
> -/* Flags for get_mem_policy */
> -#define MPOL_F_NODE	    (1<<0)  /* return next il node or node of address */
> -				    /* Warning: MPOL_F_NODE is unsupported and
> -				     * subject to change. Don't use.
> -				     */
> -#define MPOL_F_ADDR	    (1<<1)  /* look up vma using address */
> -#define MPOL_F_MEMS_ALLOWED (1<<2)  /* query nodes allowed in cpuset */
> -
> -/* Flags for mbind */
> -#define MPOL_MF_STRICT	     (1<<0) /* Verify existing pages in the mapping */
> -#define MPOL_MF_MOVE	     (1<<1) /* Move pages owned by this process to conform to mapping */
> -#define MPOL_MF_MOVE_ALL     (1<<2) /* Move every page to conform to mapping */
> -
>  #endif /* SELFTEST_KVM_NUMAIF_H */
> -- 
> 2.51.0.710.ga91ca5db03-goog

