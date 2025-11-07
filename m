Return-Path: <linux-kernel+bounces-889621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE105C3E0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAC91887D99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990A32DF6F7;
	Fri,  7 Nov 2025 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCswt0EE"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9026CE02
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477066; cv=none; b=kgmHddtRtrVocDQfGqlCHMHjlnmiExQ33T61kAAADPuBInmQlPWCbVbrG4xnrREY7cFRV3yeTHdHLHUYpEr3BWRQJmqTWWTbx8R2TD/0I0AaY4SfzrYF2DW36wl6vbgvOPlShDRUGUoztIT3tClblzOmPrWbIyxoUfWgX0jN6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477066; c=relaxed/simple;
	bh=QIx6rKMBFfDiS4HvXP04MT76FwtFqaWP2qYF1ZDThYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5McYzFF/S6lX3XgCdimOHcsPDPTVb2KNxn6weIMMVaRNml/o61PT2G7YV8gSJBJ8rFi5bPMxJ/+R3fboCUTMCYN/SU6hez/dk1RtsZl71R4schGmx4pXkQWZt1KiWuEBW/dYmz5eqpfXXneC8YpWUhUEpLO1LnIluj+FZuVTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCswt0EE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b22b1d3e7fso22599385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762477053; x=1763081853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmTmAuWcZZ8TrHlA0PNPFsEDtNa6QN4lB5lfJtGBXPQ=;
        b=XCswt0EEjW91IQUjsE6B0RaR0qEti4w3ukxxGi7xg1IPt0ad1+TbTSMf+2/gfvTIkD
         DUia/NPO/8SZOqhBS6PfYCa3bQPXR6mV9jb5YVovpRRpfWieaSgc6BQUVGO8Df71RzJS
         es7n4stLPdSbVLFCPuVcrQZYs3B5PDtIJPmUCjTIUKJ8UOwBbhI0w7Tg1maU9XhoHESg
         M9rIOS34rjtIzcKE0+aP3nyjCJLta8AV6Ef99Hjlkdzx5FcS1aU1rv0kBI+8PzrSRJvd
         NHChOPsniQtkA8qw6MYPEQ9HhjErxXOgm+qIKsG89YBLZkEhzspGrSWsnkSuA/81PH32
         mC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477053; x=1763081853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmTmAuWcZZ8TrHlA0PNPFsEDtNa6QN4lB5lfJtGBXPQ=;
        b=kc8PnZNJxEx+oXqeTbfp+W3Tp4vQqOW/O4CjVCWMbG9exkxvj/eALR/jIZtwlwD41H
         NUBBYWR0oSGpb9P6TFL0PP6gFscfdZhSkgZ0YHiNuY45q4Q+RRxA8IyfZzwmFqh2Rtfg
         /C518N/jCzbSJ4TWvV/npocakUtGOyRW8MYWIRcQiClyLwEjgtXg2fbecHKQJ5jVHUsx
         gN8tSBfBjeeDWig7knx34TqgqeyegAcZLr+b+sJkoAfAyqFJfp5oqr4KEi7fSrO6/U4X
         7UhFRI+9zLB3/dQl7/Cmmj/VI1HZIDcrPfGe1/xZkacAxa1sbMdI6hBC8IGlQ0vnPE+p
         s+NA==
X-Forwarded-Encrypted: i=1; AJvYcCUNsRVt40jdXYLJ6l/1n9nhhLG69THX4CUxliFAfxZjpTGUY+xOJRmHa2tQH5JdkpOUIbB+tyFXENQZEq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUoaxJDv9LnBzrtlVoe7aPXV9/8V38GPEoDE2+Bf43WULu8Zb
	nx8jy3KNxtmJvcAarYAOTpcsYFM+gsPTA/jR/5So/9I7qhojqQx2uxOD
X-Gm-Gg: ASbGncujoPEvhEmJmDninpXGh3wAjdEbW9kC5gZs0p8SH297xsF/hDfjIz72ptQGLzO
	eeAFrHSZ6Eepzob8YTxA0Kvv9A5Yfoehv7Mjk6WIwF8PVwASu2gYBXP97+23Xp0rymVHuKUEGlp
	okNJasI4Rt/K/NrKHyZjBxiRtxwSzWzqsju53g8Uvd0qFcIWLsJphDOOp0zBD4pDzPtPzGjmDhX
	mgUnD8WOiSP7K0YkF985inOrrshELegNeFjgo0BBmVMrJiSlcwMryzzMM8DG7Edie5LK6f6vgFS
	tWVOBh8TWuI2zsNmY6CP354CIEMsnaYpIfaEU2EH35obrFTtGaNOE3rWVx1AwaQsaYKyT0P4QOH
	UVsMFtMsEEB+STyAmI1CLI+YniE5pq6B9Lds3gm/qd8Xd17L/BNBubFh/6tnMKvLBlGV6I/81
X-Google-Smtp-Source: AGHT+IGSPrynqp7inqEF4hBhUuDdjVXrb1BDsz7SS+ixO0ukO9wh+YU5CvVH5IrgWRaBImngE8S1zA==
X-Received: by 2002:a05:620a:4541:b0:88b:72c0:aaec with SMTP id af79cd13be357-8b2453689fdmr201926585a.88.1762477053268;
        Thu, 06 Nov 2025 16:57:33 -0800 (PST)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355e9a35sm300204985a.20.2025.11.06.16.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:57:32 -0800 (PST)
Date: Thu, 6 Nov 2025 19:57:30 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Tyler Hicks <code@tyhicks.com>,
	Allen Pais <apais@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 3/9] rust: percpu: Add C bindings for per-CPU variable
 API
Message-ID: <aQ1D-skdKLV6xmJo@yury>
References: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
 <20251105-rust-percpu-v4-3-984b1470adcb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-rust-percpu-v4-3-984b1470adcb@gmail.com>

On Wed, Nov 05, 2025 at 03:01:15PM -0800, Mitchell Levy wrote:
> Add bindings necessary to implement a Rust per-CPU variable API,
> specifically per-CPU variable allocation and management of CPU
> preemption.
> 
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> ---
>  rust/helpers/helpers.c |  2 ++
>  rust/helpers/percpu.c  |  9 +++++++++
>  rust/helpers/preempt.c | 14 ++++++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41d..2fc8d26cfe66 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -31,9 +31,11 @@
>  #include "of.c"
>  #include "page.c"
>  #include "pci.c"
> +#include "percpu.c"
>  #include "pid_namespace.c"
>  #include "platform.c"
>  #include "poll.c"
> +#include "preempt.c"
>  #include "property.c"
>  #include "rbtree.c"
>  #include "rcu.c"
> diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
> new file mode 100644
> index 000000000000..a091389f730f
> --- /dev/null
> +++ b/rust/helpers/percpu.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/percpu.h>
> +
> +void __percpu *rust_helper_alloc_percpu(size_t sz, size_t align)
> +{
> +	return __alloc_percpu(sz, align);
> +}
> +
> diff --git a/rust/helpers/preempt.c b/rust/helpers/preempt.c
> new file mode 100644
> index 000000000000..2c7529528ddd
> --- /dev/null
> +++ b/rust/helpers/preempt.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/preempt.h>
> +
> +void rust_helper_preempt_disable(void)
> +{
> +	preempt_disable();
> +}
> +
> +void rust_helper_preempt_enable(void)
> +{
> +	preempt_enable();
> +}
> +
> 
> -- 
> 2.34.1

