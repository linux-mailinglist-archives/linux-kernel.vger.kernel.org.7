Return-Path: <linux-kernel+bounces-753792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E6B187FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9059C627EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00761204863;
	Fri,  1 Aug 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W4canb2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1CDF71
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079209; cv=none; b=BK8lKcW++DdPNv33cFKjj7pC82TE/sQUVj05I+94chOVZLmmTDscR3OapIQ0AJHDAAuzsdADdIOJLUikGgKGiO1e/Xmnp/heksfw9pIQzyv818lHUI86TSxThUCq7hRkv3kMnkO6ZfJibClrC9wyO7mR9F0DC6QRncY836VFj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079209; c=relaxed/simple;
	bh=Qg0kvxsXNNpQlr8Zn+FdmlEiWcpF6OIoZvDXUYGqrFg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HuLmPkpPV19VGkPOfRCwPvW77YfMIEUEWr+K2ZyNHDlwLy4X9ddgJcThVdTtaqx4HO2iDRyVw7/YTdOxrI8YfE3CyqN5KWD6ik01HxjYQ72Buw2j9rcw+h+iwo2nfup3UuC2Nad8Ey/R3PDamuOHBiO0PnMEiLjdVPHmv4E0TIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W4canb2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348F2C4CEE7;
	Fri,  1 Aug 2025 20:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754079208;
	bh=Qg0kvxsXNNpQlr8Zn+FdmlEiWcpF6OIoZvDXUYGqrFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W4canb2SF5TnJOwxq82Fn+CSgL8a8vreR9ladXrIK9QT/uR42ZpwLxtto1soRZkt1
	 MFi7dhpFK8Vrhxx7lo0QSpzhKWWGZrVqGPAmDvuDVpZlHuJ55EcSjbArnQLym4WYkv
	 E8cngteSQ17Jk4ZPH81ClCD3K2q1Yc4wV8oFOHa0=
Date: Fri, 1 Aug 2025 13:13:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: thomas.weissschuh@linutronix.de, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kunit: kasan_test: disable fortify string checker on
 kasan_strings() test
Message-Id: <20250801131327.8627459bf3d94895d42b95b2@linux-foundation.org>
In-Reply-To: <20250801120236.2962642-1-yeoreum.yun@arm.com>
References: <20250801120236.2962642-1-yeoreum.yun@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Aug 2025 13:02:36 +0100 Yeoreum Yun <yeoreum.yun@arm.com> wrote:

> Similar to commit 09c6304e38e4 ("kasan: test: fix compatibility with
> FORTIFY_SOURCE") the kernel is panicing in kasan_string().
> 
> This is due to the `src` and `ptr` not being hidden from the optimizer
> which would disable the runtime fortify string checker.
> 
> Call trace:
>   __fortify_panic+0x10/0x20 (P)
>   kasan_strings+0x980/0x9b0
>   kunit_try_run_case+0x68/0x190
>   kunit_generic_run_threadfn_adapter+0x34/0x68
>   kthread+0x1c4/0x228
>   ret_from_fork+0x10/0x20
>  Code: d503233f a9bf7bfd 910003fd 9424b243 (d4210000)
>  ---[ end trace 0000000000000000 ]---
>  note: kunit_try_catch[128] exited with irqs disabled
>  note: kunit_try_catch[128] exited with preempt_count 1
>      # kasan_strings: try faulted: last
> ** replaying previous printk message **
>      # kasan_strings: try faulted: last line seen mm/kasan/kasan_test_c.c:1600
>      # kasan_strings: internal error occurred preventing test case from running: -4
> 

We don't want -stable kernels to panic either.  I'm thinking

Fixes: 73228c7ecc5e ("KASAN: port KASAN Tests to KUnit")
Cc: <stable@vger.kernel.org>

What do you think?

We could perhaps go back earlier in time, but 73228c7ecc5e is 5 years
old.

