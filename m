Return-Path: <linux-kernel+bounces-855849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BB6BE279B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214AA3AA8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84631690D;
	Thu, 16 Oct 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7/zcc9n"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867C30FF03
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607771; cv=none; b=mRr52k2bubEARDMLnBeJkYVu+eUbXR4HFfMq7YQmDx/t4fHNnYauG+bMHuqLFmIyRMwbgg6GNb0uwavv2yCVXs/Fv1uAp5CjNhNjZx7UHsB+LQ/vn8rAy9XvJj0msxDXm2v1WjfAIsJzE31/1Gul0LXPQO+dc2La/TUVoZGK4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607771; c=relaxed/simple;
	bh=/An5A5Z47gm9McZ86h5+c44EhezddxqJ6Ki8ImsDtRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjFzvmytU2TsJdY8LxEjWaTsCfZtx3A1UjetNBH6f00vzbChcnkG9rJcN0CUM9NIWr0spmD3sih+sZ9dmVSVehRCYINO42ZIebZkhOjkA0e4Ewv3OpnbPL8kz1vgxSi654D3pEcoqGmcZBGvPFLS1Ep0oH0yo6JwQ5n0Opy57J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7/zcc9n; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33255011eafso537845a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760607768; x=1761212568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LdgKKtvcfYNoBowTokM9ZaUlzxkF22P3gHH8+8NnAns=;
        b=P7/zcc9nNDlyg58BRVJ4ReysqITJa64ORsaKVU8gRKAD+8otvgvTdJPDpbl0vSt126
         5oE8XNQolIHWZXkNAnjI6a7wvEIc05PkGWPmcRHKKxzkSofnc1VSl/XDfSCt+iI4yrZb
         OdKwuwo1SBj3QTvI6TdQ24aPvFx7ElQpcguOKB9NSLMpGeHstxSBENW1sp9CDIzmmGAT
         vLwVHsujbgun1S5uTJUJ84kY6/BgY9PvZv7CwsgwMi916naHQWL8PqsOf2fkXC5Oz347
         LZu0nB14RLzrr5XzdC9tFD+XzLHSxgljRpnTG8zr59Ijh2yYPHp6im3f/6MnXVtggIH2
         ty7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760607768; x=1761212568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdgKKtvcfYNoBowTokM9ZaUlzxkF22P3gHH8+8NnAns=;
        b=oNaG3BeuM41VOt6L1I1dU9F5E9CgyIyvlbNscOcnFy6R0HLvv0CTitlR7zsvmo+gME
         x9tXQwnBkK7SMKsEB/bezbuQIPMaGeeajuQKgmiZ+apyawlboi2LMS1x3ezb0MSXkvzN
         VOFLWdJDem5Bguz/XWkYR9DxQY631wtSffdDZ0DHI9u17Dk9f5PKlK94A0NCJqEV5qKq
         WYEcS9hKpnc78hXLAPAEXJqhDJWX+36e3NzwEP0n1pgi4CFzzKZ0X2xWBrzIP0U4VjoQ
         qgMS0OtiPsq4DE1+QJMDvqkefeD1Y9jFeHGgb40jPmKH4xO1YGH2m5xmCrzi6CXxP9AC
         Kyhg==
X-Forwarded-Encrypted: i=1; AJvYcCVNIs9rKtPTjN2O4PqyjYjs0Atg2msucl7oSET8v3niNU0IJbc3STKZH4Prgizs/oYIcD1bWaEbhIea4Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyK7hHTeM5tyKARGz9Guv5fOK5O1ei5cfkMLrb2iuAeh8HGN0b
	/NXR93qgC9G+yanJzKpWPUHRmnlQjHJUyYLa5wP1vPFrtyueBRiYyoyZuxxnfqYU
X-Gm-Gg: ASbGncts5e409ot+gjbhCZoKVEBJ876j30oDSzHNvJrLqn0/+fnyvkr1W4LnUUOEQ7a
	5c/dHBFvTi0/j+EFSk7nbktUoGqMKxtZOe6X0eKh8OSIe3sir8lxCE3wSCbTai45i3Seu5816J3
	7eu+jg4teihwCACyqLGez+xxJ//g67HguXDUxnC/LJvEAmvvROKPKxeaNKSem2hFr65aEaf84XV
	Bh4XQlHLVSERyGL6e603XsIvU5dQHN/HJ4pDMVIghtVVTutscHCfmiLpZPI7hlpYko7vadPB1JB
	D2JmN4Bzyn3wLOM8UyhTpKqqAkUbVW74M6Emdjg6c5uWv3d/HjYELLG+kDoUQchSTnReaPEdOHn
	UYREQn/ng38zSbare23nZWc9G7hF5b+CD07bbw8nTpQ3EVljYTbqzxNkEGZ082t89IizAm3gBJk
	/6W997NtQ=
X-Google-Smtp-Source: AGHT+IE1fskk5Ct8giAk25LdMld1Y2juSnEz/FSK8HGfkykDmWOYPltY5Y/poj9FAus0Wc346J/rzQ==
X-Received: by 2002:a17:90b:1a8b:b0:32d:fcd8:1a9 with SMTP id 98e67ed59e1d1-33b513e6269mr40395810a91.32.1760607767989;
        Thu, 16 Oct 2025 02:42:47 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:5c03:23f6:3e52:49ba])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22887a24sm2282799a12.1.2025.10.16.02.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:42:47 -0700 (PDT)
Date: Thu, 16 Oct 2025 17:42:43 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: XueBing Chen <chenxb_99091@126.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bsearch: add mutex protection for thread-safe binary
 search
Message-ID: <aPC-E1ZQhiLaBbWS@google.com>
References: <20251016090640.6331-1-chenxb_99091@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016090640.6331-1-chenxb_99091@126.com>

Hi XueBing,

On Thu, Oct 16, 2025 at 05:06:40PM +0800, XueBing Chen wrote:
> Replace the __inline_bsearch() wrapper with a full implementation
> that includes mutex protection to ensure thread safety when
> multiple threads call bsearch() concurrently.

Adding a global mutex lock here will introduce a performance penalty
for all users of bsearch(), even those who do not require this
protection.

If a specific user needs synchronization, shouldn't they be responsible
for implementing it? For example, by adding a lock around their call t
bsearch() or implementing the necessary locking within their compare
function.

> 
> The original implementation lacked synchronization, which could
> lead to race conditions in multi-threaded environments when
> accessing shared arrays or using non-atomic comparison functions.

Could you please provide more details on the specific race condition
you observed? What is the use case, and how does this race manifest?

A concrete example, a reproducer, or a link to a bug report would be
very helpful to understand the motivation for this change.

> 
> Signed-off-by: XueBing Chen <chenxb_99091@126.com>
> ---
>  lib/bsearch.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bsearch.c b/lib/bsearch.c
> index bf86aa66f..9a5a2e949 100644
> --- a/lib/bsearch.c
> +++ b/lib/bsearch.c
> @@ -1,9 +1,12 @@
> -// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * A generic implementation of binary search for the Linux kernel
>   *
>   * Copyright (C) 2008-2009 Ksplice, Inc.
>   * Author: Tim Abbott <tabbott@ksplice.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; version 2.

The addition of the full GPL-2 boilerplate text seems redundant and is
unrelated to the patch's functional change.

>   */
>  
>  #include <linux/export.h>
> @@ -28,9 +31,29 @@
>   * the key and elements in the array are of the same type, you can use
>   * the same comparison function for both sort() and bsearch().
>   */
> -void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
> +DEFINE_MUTEX(cmp_mutex);
> +void *bsearch(const void *key, const void *base, size_t num, size_t size,
> +	      int (*cmp)(const void *key, const void *elt))
>  {
> -	return __inline_bsearch(key, base, num, size, cmp);

This patch replaces the wrapper with a full implementation for the
exported bsearch(), but the inline version remains unlocked.

Why should the non-inline version have this protection while the inline
version does not? This creates an inconsistency.

> +	const char *pivot;
> +	int result;
> +
> +	while (num > 0) {
> +		pivot = base + (num >> 1) * size;
> +		mutex_lock(&cmp_mutex);
> +		result = cmp(key, pivot);
> +		mutex_unlock(&cmp_mutex);

If the intent is to protect a cmp function that is not re-entrant,
shouldn't the user who provides that cmp function be responsible for
adding the lock inside it?

Regards,
Kuan-Wei

> +		if (result == 0)
> +			return (void *)pivot;
> +
> +		if (result > 0) {
> +			base = pivot + size;
> +			num--;
> +		}
> +		num >>= 1;
> +	}
> +
> +	return NULL;
>  }
>  EXPORT_SYMBOL(bsearch);
>  NOKPROBE_SYMBOL(bsearch);
> -- 
> 2.17.1
> 
> 

