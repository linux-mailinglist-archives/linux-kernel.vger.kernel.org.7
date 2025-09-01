Return-Path: <linux-kernel+bounces-795218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE29B3EE6D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE84B1B2140F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED28C32A836;
	Mon,  1 Sep 2025 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="waO5M7TU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959E1E5213;
	Mon,  1 Sep 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756754598; cv=none; b=AtzxxEnD8cQTbf4D+RdIi+RtjZ0ie/hH4aMt9bWyktVkP+ZUIlVMKSCYjm/MFFyEeKu1e1hORIoBkBzC5nX1vwxCWsszk/tbfoBeeTOEZZ8Xm6Xis4I5/xv7407rN0lzQxTNspT4hM7KrJWMA5qUpX8Q/QE4vhVne0pjvLXoHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756754598; c=relaxed/simple;
	bh=/4asbQkP1eDqEbveKkGpr0ywUBl4RSN7gR/XJ53xGVw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tHp2YDp5nvu+qavXlm+d2xBl2jlNMaNZk3GhrkPckXY8vav7tEixUsc5YvtLPpWcbhuEEalkSFaNhLQWn/rMQT3oMO4ultuJ7rXQXkzyOSg3ucLV2Iex2qmqonID1XqkPLnxEuRmN0rNCxdvKne+IWIBhgHkhCv+Z46U1KVkDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=waO5M7TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BD1C4CEF0;
	Mon,  1 Sep 2025 19:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756754597;
	bh=/4asbQkP1eDqEbveKkGpr0ywUBl4RSN7gR/XJ53xGVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=waO5M7TU9BYoRGjtorAnNJETXm72HFsA3Y0tFfhW85iW307Pc3Fq86bh7keOgjgLE
	 ktpXe34fCWJ/hIBD3X4zZpOX2irMQA3Ga0Vr8rilIjKxKv0uR7kEYqCu1sIk7u49Cu
	 IOOyVz6paX9t7Kdqkgl01NvAx2e8rkGiaTJ3GKyI=
Date: Mon, 1 Sep 2025 12:23:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, scott@os.amperecomputing.com,
 jhubbard@nvidia.com, pankaj.gupta@amd.com, leitao@debian.org,
 kaleshsingh@google.com, maz@kernel.org, broonie@kernel.org,
 oliver.upton@linux.dev, james.morse@arm.com, ardb@kernel.org,
 hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
 yang@os.amperecomputing.com, kasan-dev@googlegroups.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v6 1/2] kasan/hw-tags: introduce kasan.write_only option
Message-Id: <20250901122316.6b7d8d7fdcf03bdb2aa4960a@linux-foundation.org>
In-Reply-To: <20250901104623.402172-2-yeoreum.yun@arm.com>
References: <20250901104623.402172-1-yeoreum.yun@arm.com>
	<20250901104623.402172-2-yeoreum.yun@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 11:46:22 +0100 Yeoreum Yun <yeoreum.yun@arm.com> wrote:

> Since Armv8.9, FEATURE_MTE_STORE_ONLY feature is introduced to restrict
> raise of tag check fault on store operation only.
> Introcude KASAN write only mode based on this feature.
> 
> KASAN write only mode restricts KASAN checks operation for write only and
> omits the checks for fetch/read operations when accessing memory.
> So it might be used not only debugging enviroment but also normal
> enviroment to check memory safty.
> 
> This features can be controlled with "kasan.write_only" arguments.
> When "kasan.write_only=on", KASAN checks write operation only otherwise
> KASAN checks all operations.
> 
> This changes the MTE_STORE_ONLY feature as BOOT_CPU_FEATURE like
> ARM64_MTE_ASYMM so that makes it initialise in kasan_init_hw_tags()
> with other function together.
> 
> ...
>
>  
> -	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s)\n",
> +	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s, write_only=%s\n",
>  		kasan_mode_info(),

This lost the closing ")" in the printk control string.  I fixed that
up while resolving rejects.


