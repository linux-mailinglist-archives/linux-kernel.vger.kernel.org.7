Return-Path: <linux-kernel+bounces-743191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35367B0FBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595E57BAD66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4F23AE96;
	Wed, 23 Jul 2025 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRvqJ29w"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6B23ABA6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303106; cv=none; b=aDrmzs8WTRkGXxHktSSlWDi/ROWQqvMK5/Qko7Mef9VpLgLYeQiz7iejKj7Y0ODLgXPXZOezUpuJxl5RB+U35bSF1H+XTlZq8c7i4egIzgaqphXciQVcs/8DnvIEwc44tDtfIN61cfz7BAuLivQJXNoPIQI7jzpGxLawqWIjspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303106; c=relaxed/simple;
	bh=9ksNRByA1R6WRpgBAqiFWOz1XaJlUuXPr+5odDMxUFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pHIpdXQJ5HEWMRySNBK5X0PYXDNn2QpmM+vFl31OT6wI4/kzRKYMz3RdYjgWIDTFmRSO6RGeW30y0EbbSJ0+n/nUd5D5yoEEdywd+Tsleoily/7x6CqN1+9F23qJ5Zbk6bM/p5Jg93LbltQ8E4xSCVlXLlodg9N6P1AUexeztQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRvqJ29w; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b39280167fdso235878a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753303104; x=1753907904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lngQW6Itt1q4DN9erl71oSaE8dVS9EZdINPQsN2S/U4=;
        b=tRvqJ29w0q4VvYfAxEoitAKpD7jlZys4VNC1KzEhXNP9b162/WAdaFrIbMMloTkwFq
         4pZUv6zsoZ2Rw5n8s5i16gge5w3fshkajdl9GrzR2gNLZxjztskyRC+N6WAeC8VyeRFg
         wBhAsz1WTk0zr3xqYac2iXeu29qtEmP9QicNa4CjjMpb8iIjOFHxE9h/DyyfvbnRqhhK
         ffqW79TWlOBb8bJhyxrkW6jptF/QcKZW46i/CO51JMDxxLXSeqfXGxKlIZr8WKZzBntD
         wKkHMzhJfCCcUCsrBLYd4rjLNydl2VrMYVoysA46qnaNIZZQSRN9fIih8NV9FKIRrAgr
         CxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753303104; x=1753907904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lngQW6Itt1q4DN9erl71oSaE8dVS9EZdINPQsN2S/U4=;
        b=GDZ3M+7JzjJTKG3M/fL/KvInot35ZdvDfA4zkz4t7DL5Donvt56UCpjFEFzbrs0Iyb
         j++FVSuSwwy0ZcLu06515YixzThMXAVcjKWjit4fy1z+aBDr8CTyiyxDzxFMCASfPKnz
         s53/J/hL5Ct7895iTq9wInYUCXWzHgNp+igvixULYEwt4/b7kgD65J405el/5wYOYu15
         aMzMutzetirnZE28R/r5wSSvZj1ukmKJWN6xZqj6eHaNKz3Wydt10YUKHz71ZFgBEzH+
         Ogm8fmlMiofsmdRUdnSPf6W6FcxfhC1rlst8ypoexIJ3pxYpGDvrwsRk7C6eKqrlQ6K2
         8hgA==
X-Forwarded-Encrypted: i=1; AJvYcCUcfhFtdI23U12H0ZxvfZOezpZKARK/XlHMQh8JJMPB7CJeidRaBLz8vUBSt0pDOYfMADGhF0YVvzxioD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gjHHJCLBuugDX03b5WDbJTgQFONfeTkCpDoygQ9IwczJEj/E
	GkTCFpfjrESthRJw8sM6NPy7Jl+K6W4smesp9wUtPHUoy6SMg3c+LkERen5QlmeXKp9ps/Wb00r
	m2MfrYg==
X-Google-Smtp-Source: AGHT+IEquxd/YBrG+cywa0a1Dg+V5VomOJUYvM7hrpfchOE4B9Vl3O0Q+2Xy8S7PqUmaL7IPxMeVUuFecvs=
X-Received: from pjbsw11.prod.google.com ([2002:a17:90b:2c8b:b0:31c:2fe4:33bd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c7:b0:312:e6f1:c05d
 with SMTP id 98e67ed59e1d1-31e5073f550mr6110372a91.2.1753303104581; Wed, 23
 Jul 2025 13:38:24 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:38:22 -0700
In-Reply-To: <20250707224720.4016504-5-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com> <20250707224720.4016504-5-jthoughton@google.com>
Message-ID: <aIFIPm5zENeKlgkw@google.com>
Subject: Re: [PATCH v5 4/7] KVM: x86/mmu: Only grab RCU lock for nx hugepage
 recovery for TDP MMU
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 07, 2025, James Houghton wrote:
> Now that we have separate paths for the TDP MMU, it is trivial to only
> grab rcu_read_lock() for the TDP MMU case.

Yeah, but it's also a largely pointless change.  For the overwhelming majority of
deployments, rcu_read_{un}lock() does literally nothing.  And when it does do
something, the cost is a single atomic.

I'm leaning quite strongly toward skipping this patch, as I find the code to be
much more readable if KVM grabs RCU unconditionally.

> We do not need to grab it for the shadow MMU, as pages are not RCU-freed in
> that case.

