Return-Path: <linux-kernel+bounces-771394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF5CB28669
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F937AA13C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6D9296BDF;
	Fri, 15 Aug 2025 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujw8AG/E"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA9A18FC91
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286087; cv=none; b=Oe8DA2afcx3SSZsoynxwQDdB53qBV8m0b2nvL9RGO3mV8v6mpt/+A6Ojw+47GP+EJGqHIGfJ/v5IksdHd4bKXQr9h2eEUlfjoeQokYaB03rhGCKhCFxWQasY9cYc7/5Kcjs7jRS2bthYBbJfQwlMbS8XxzDPMAGaBICN4O+lmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286087; c=relaxed/simple;
	bh=03ai3+jPXw+qIgPjJjhYeat8FHaMCcAxTtMV6J8Fauw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JD/joya9IuwsvjbyXYGRGqhcVDbl/worMbqh0j+kX45gxtD2B3/AT6DPTZhKsYhWZP68C4K3+Qg7pT4yY66+B4hkZOnigiytzlopGzVlF0n1guAH0bpEShqFO3SGfTdiPEfLuxsUyBz/Q2mCGOdUSBU9yTAqBDVWCEYib66eKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujw8AG/E; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326779c67so2159011a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755286085; x=1755890885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtxMP1qLySSUVXufrp6NxftESi55Z9nJ+C2xCceAidg=;
        b=ujw8AG/EyBE6stXLKMTbm3ehnQ3ocfhmgWd3ZJRIh2n/xHq6eVan/HhZnu/rEOHn/f
         1hbzBAa8BPYmYo98FgkWBN5EYsmsg2Uixs1mbz9y3KbjnD2lrxoTbg3zJeP4C/YlzOKw
         631IfSgOnBF3sBN7xIt0hWySpCG/ipacwYiiOH/E+D42Ec3PNck5PKd7Bs4WJYko4fxx
         DpotTIWxgYs8TM3HuBVagv2uc/GvoWF65QkpeFRQHtMvU0ey+/fM29bAA8dYnk4wfgda
         r9rWS8KCSNiua3Bx92LJ+bYmaPRKoUizzWNceGjUXK792P4dp6xVdBjRu0Ps+83ZAmyO
         0mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755286085; x=1755890885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtxMP1qLySSUVXufrp6NxftESi55Z9nJ+C2xCceAidg=;
        b=puNp/g7xU6xiIuXdnCJMqLe7K2z0z8CUudhSo7rfJc5sMTAe+k2SzPtB6mbCNu165r
         mm9jYoTZN6wSMZPswiywWCdu8cr6mxI3w45yAYVfT5bMF138CCLaO55jY1i7ipgOY104
         toM9EcZYWK6h9+jJJILBn2bc0wa31R/OokUwJe3c/WzRxwxauIrlWIu3ux4KcP5/B+qk
         5xBVoo3dWBqMNlWGp8gUCTtDaFYOH4hQZnYhGoXcLEROSoG9CcEr1i8fbPws/f62A/S7
         etzL0SyTr9GFmwXC2AJI6ByEQwTTneVQTwgm6efvDYZomq1KyELVSfqKAnK34uIgQCGt
         kYGw==
X-Forwarded-Encrypted: i=1; AJvYcCWx/P3+T1s/45c9PxfBfpLBAd5VbWfsVAa68KynSyXkxKK+DzhI79QJC0/Y/XUg2g9hpAy1SLSOlNVKUwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBHfrl1EMvgJ0gHTax7BoX2zXqM4EDU0xUHbbf7XNkcQX+9w6g
	ReR+6Ks1XewCmZTHNCemoK3iRoEodTmt8gMSgTN53viUZYL4K30zsBdQy9AYcRKOkt/SnYFL4SB
	SmMlM0g==
X-Google-Smtp-Source: AGHT+IFheb7H3vGWMwDpPa/ZTz43jwwEwav9YvOcV9yuk5MWwK/8m1Y/ywXNiBd1O4MgZl8Zxb99lnXh3Wc=
X-Received: from pjbph13.prod.google.com ([2002:a17:90b:3bcd:b0:31f:232:1fae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b10:b0:30a:4874:5397
 with SMTP id 98e67ed59e1d1-32341ebf8bemr4526630a91.9.1755286084895; Fri, 15
 Aug 2025 12:28:04 -0700 (PDT)
Date: Fri, 15 Aug 2025 12:28:03 -0700
In-Reply-To: <20250722110005.4988-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722110005.4988-1-lirongqing@baidu.com>
Message-ID: <aJ-KQ5811s2E5Dj9@google.com>
Subject: Re: [PATCH][v2] x86/kvm: Prefer native qspinlock for dedicated vCPUs
 irrespective of PV_UNHALT
From: Sean Christopherson <seanjc@google.com>
To: lirongqing <lirongqing@baidu.com>
Cc: pbonzini@redhat.com, vkuznets@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 22, 2025, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The commit b2798ba0b876 ("KVM: X86: Choose qspinlock when dedicated
> physical CPUs are available") states that when PV_DEDICATED=1
> (vCPU has dedicated pCPU), qspinlock should be preferred regardless of
> PV_UNHALT.  However, the current implementation doesn't reflect this: when
> PV_UNHALT=0, we still use virt_spin_lock() even with dedicated pCPUs.
> 
> This is suboptimal because:
> 1. Native qspinlocks should outperform virt_spin_lock() for dedicated
>    vCPUs irrespective of HALT exiting
> 2. virt_spin_lock() should only be preferred when vCPUs may be preempted
>    (non-dedicated case)
> 
> So reorder the PV spinlock checks to:
> 1. First handle dedicated pCPU case (disable virt_spin_lock_key)
> 2. Second check single CPU, and nopvspin configuration
> 3. Only then check PV_UNHALT support
> 
> This ensures we always use native qspinlock for dedicated vCPUs, delivering
> pretty performance gains at high contention levels.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

