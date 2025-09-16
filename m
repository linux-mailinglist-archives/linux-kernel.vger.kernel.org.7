Return-Path: <linux-kernel+bounces-817931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD471B588F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D038487110
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F61C6A3;
	Tue, 16 Sep 2025 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bfrvjN6A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E298F507
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981474; cv=none; b=ptuKSSjEFjCOVtYmKiUZ3AUiiXlaYzDHgcEyADPsRxs6WNrGXBp/6lL0k17SFO69X+lz59mIArJuRy163CmrBr/4CjsctWLR6KEV9bPgUyYI9OHAwUKCazaqWn7c1dC5zxF4DpadAGCS3W6ZmBsr5JFNBcKfX6StB4BFgDXaKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981474; c=relaxed/simple;
	bh=fQf0ppc42EwsOf0ekWpZyi02hc7MO+o0unxS4+mjbmQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=drF7CPibckmW2ngEKGb3M/wwb9/A5kE7E3pncgbRh7NyhgkARKjNxzZretPY8jLSxoVxuhroyVUg+2LIwW26+QR3DUH6HpPC03wjPVljGk3pEi9XtjylrkWZZQYmDZH/s7nQ3Skq+Q91p3QzH9fm2ZCu6vgbFX2NM8FmrmTQyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bfrvjN6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5625C4CEF5;
	Tue, 16 Sep 2025 00:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757981473;
	bh=fQf0ppc42EwsOf0ekWpZyi02hc7MO+o0unxS4+mjbmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bfrvjN6As3FbUsPhLt9BCR9kK5UpprOa4pIBTdb4pS8bHCS6JXgKAEY41LwWtgB46
	 tvMb718/Mk96EUkT91bK54C8a3Jq+5PnN7ZGUwl8SQeDE8RTaK29+cpHVbPxbDsZk5
	 QOtoOJH/EW+xxZgvSjoejTWo3UQRemd8Vk/oKUH8=
Date: Mon, 15 Sep 2025 17:11:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
 usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev,
 harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com,
 pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters
 in /proc/allocinfo output
Message-Id: <20250915171112.f71a7606a7f9fd3054662bed@linux-foundation.org>
In-Reply-To: <20250915230224.4115531-1-surenb@google.com>
References: <20250915230224.4115531-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 16:02:24 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> While rare, memory allocation profiling can contain inaccurate counters
> if slab object extension vector allocation fails. That allocation might
> succeed later but prior to that, slab allocations that would have used
> that object extension vector will not be accounted for. To indicate
> incorrect counters, "accurate:no" marker is appended to the call site
> line in the /proc/allocinfo output.
> Bump up /proc/allocinfo version to reflect the change in the file format
> and update documentation.
> 
> Example output with invalid counters:
> allocinfo - version: 2.0
>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
>            0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
>            0        0 arch/x86/kernel/alternative.c:127 func:__its_alloc accurate:no
>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create accurate:no
>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
> 
> ...
>
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1009,6 +1009,10 @@ number, module (if originates from a loadable module) and the function calling
>  the allocation. The number of bytes allocated and number of calls at each
>  location are reported. The first line indicates the version of the file, the
>  second line is the header listing fields in the file.
> +If file version is 2.0 or higher then each line may contain additional
> +<key>:<value> pairs representing extra information about the call site.
> +For example if the counters are not accurate, the line will be appended with
> +"accurate:no" pair.

Perhaps we can tell people what accurate:no actually means.  It is a
rather disturbing thing to see!  How worried should our users be about
it?

