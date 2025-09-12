Return-Path: <linux-kernel+bounces-814600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA29B55646
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054CE1883AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DD232ED47;
	Fri, 12 Sep 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yeql+5pk"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19543322DA1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702089; cv=none; b=iDnTZnYpOpPwFIE19wZA2ZvCVU8xRUxHjFudygaOOExWqvYMNf4hlsyM1HrBRGtZ80SheORRwvy8/DtER5Bc29iqUq4NI87YtlK9yZNQVh85Q/4NWYHtlBMn6cBS2F9mati324QXLkQ1YxgEiIOADfvLNGmfKdG3j02klAhTCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702089; c=relaxed/simple;
	bh=KuQWDXlaZpYBi3YGWW3fX7XI+CI/DvkYxbxrWv9oMYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DHv4ZexyrPWm+zgAI3xGMiBLhfyExGU9ieg6tg+PNMHpVX+MibAfWAriAsIfXMfpOmDlzmI/AE2UHU0Yo0f1PEU+fYWcPVZpWHz0R7DbvCSsEKz1C/anArvCjd/xD0ziOUe4cstYJlZ/B12MQ3sTsGGlDPpGFSaMcMl97fbVBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yeql+5pk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b521995d498so1640797a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757702087; x=1758306887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9avk6DW0uWC9sgvdAlpenzteq4S17YKKxa+B5Lkt+c=;
        b=yeql+5pkxplmh/nJUlq+CqmQCtp8syEh6HVD4D5/vcJh7Y3s0H5hVO3c+IuXroFNqX
         idBmU+athEhgKH05hz8DW+ysDzpG+k7KB5icO9BzR94LndO47cZo6DK6LFC6sxQ4Nqoc
         wkYMdNhwWFICvV3+ZX4dEfOd1kkc79WA0hqcKUeg/PPQOX9HeO9GN/Gh2rI8v9yqgbql
         nPfogIisUpAa/QQVkn/pIPnPH42cBMNGi7JleydAlYQDxtFhSrSe4k4cQv66Tnre16Lv
         ilkMmG97ChhKzb8YrLuuK9EagzaqiBqO8wr1vDBRP+/7QcgIiVgJjv77J1fAfUoETGg0
         VX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757702087; x=1758306887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9avk6DW0uWC9sgvdAlpenzteq4S17YKKxa+B5Lkt+c=;
        b=cgloLCd+/0A97SUXg+sNSQKMjRqGwWXvINsW+5uKnRHbUMg0KpZXCwoVRenyfbJT72
         tEjWN+p8y/SfRlFmP8Z6/8E/NKthTtdFWUxG6LAELrVJ7GyQ9llXQBOR5+3OnpsVkxEw
         YxT1/JBKPDJeJZM1t4J1kJGCiypd00rp1YGqXXah+oVK64N78s6xRoqW4wX9NC+8ToLP
         e08rtpXC8PJIrB2rwlyedonr6dNu+OD260nWvlozwS344MPvA4O+Yw5aavwal41x8vlN
         xx56mq3ODwxalN2saQ8IWb4rwrzOSo73r5DBvUBruM3ua09u0iX60j1h7kpMHCPfb777
         YN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3k1nZ2Pzd9G2pmPfhgYywZWIuaAoVpiOCPsnlTSm+ETWIZtDjRRYTUbq4+Q05hNVh1zZIMOyEuWlvkh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4NDxQwqAQ2uWFgOn83KmMT/o24u7iCn6Jbb5lqw9+f96d4CO
	o8UXzMehkEH5UfUlF6EA+V9HY+juNbSGuXPAf9EF7AA9y5LFLE2I+IQhbxa1Xe5yhkiJDuCYn9W
	scFpbbg==
X-Google-Smtp-Source: AGHT+IFC7L13Y1FixY/H8lG9g0gfOdqBGxTPBHdlSsZpTSHjgZKbvR4Fyaf6NT57DoOlfRvzKDn0PGQH4Tw=
X-Received: from pgcc10.prod.google.com ([2002:a63:1c0a:0:b0:b52:19fd:897f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9189:b0:24d:d206:699c
 with SMTP id adf61e73a8af0-2602ce1be2emr4906126637.53.1757702087337; Fri, 12
 Sep 2025 11:34:47 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:34:45 -0700
In-Reply-To: <20250912155852.GBaMRDPEhr2hbAXavs@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1757543774.git.ashish.kalra@amd.com> <c6d2fbe31bd9e2638eaefaabe6d0ffc55f5886bd.1757543774.git.ashish.kalra@amd.com>
 <20250912155852.GBaMRDPEhr2hbAXavs@fat_crate.local>
Message-ID: <aMRnxb68UTzId7zz@google.com>
Subject: Re: [PATCH v4 1/3] x86/sev: Add new dump_rmp parameter to
 snp_leak_pages() API
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	nikunj@amd.com, davem@davemloft.net, aik@amd.com, ardb@kernel.org, 
	john.allen@amd.com, michael.roth@amd.com, Neeraj.Upadhyay@amd.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 12, 2025, Borislav Petkov wrote:
> On Wed, Sep 10, 2025 at 10:55:24PM +0000, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> > 
> > When leaking certain page types, such as Hypervisor Fixed (HV_FIXED)
> > pages, it does not make sense to dump RMP contents for the 2MB range of
> > the page(s) being leaked. In the case of HV_FIXED pages, this is not an
> > error situation where the surrounding 2MB page RMP entries can provide
> > debug information.
> > 
> > Add new __snp_leak_pages() API with dump_rmp bool parameter to support
> > continue adding pages to the snp_leaked_pages_list but not issue
> > dump_rmpentry().
> > 
> > Make snp_leak_pages() a wrapper for the common case which also allows
> > existing users to continue to dump RMP entries.
> > 
> > Suggested-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > ---
> >  arch/x86/include/asm/sev.h | 8 +++++++-
> >  arch/x86/virt/svm/sev.c    | 7 ++++---
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> Sean, lemme know if I should carry this through tip.

Take them through tip, but the stubs mess in sev.h really needs to be cleaned up
(doesn't have to block this series, but should be done sooner than later).

