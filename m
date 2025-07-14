Return-Path: <linux-kernel+bounces-730917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49323B04C70
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FA84A36EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337B1DED40;
	Mon, 14 Jul 2025 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WUZGo1tN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF36277CB0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536331; cv=none; b=lTXixs5rK3OOXafg64TLzmD0ehKopYq5umdy+Lf/3GNvrXJ7wI882Vs5dsWy9TK8grDx39r7ieUVZix+x/US0fhmL5wV6sLoSiOBb6hQN5iw30ujnqpfBQ+EMBSZu5FqkXxoEwtfJC/Xf7D/JmmJVWC12j6unu8/jJGrJFTOsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536331; c=relaxed/simple;
	bh=GmMQmFSg0AJVI5JP9hjR+rt4PIAIy16GY7WuNnosvI0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gU41wNtk24pNZ6qdR4BsEETIZnGKMhhZvGUcH8Qw6wcMxjDI+yc55hLBgOYCao5L2dlICtIxRq7M5GFr11KFXL04asmgWwlrccBIYdcA2H0WYUfiRNg5Ur29UC0I9FN4dsSn0et66qZcYo8K4Y9fvCVeVYwOXLAQ3sxtNdFStdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WUZGo1tN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64E9C4CEFE;
	Mon, 14 Jul 2025 23:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752536331;
	bh=GmMQmFSg0AJVI5JP9hjR+rt4PIAIy16GY7WuNnosvI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WUZGo1tNinaRtIURCuY6icV/ahZodUH+zw5nhZ7YKkBgniM+Br6WIt2YPGLESwSY8
	 b0aZ67BGp12GMtTR4mFNIZL8im5I208cPZzvo9EB/QEOkyHxmwPztZALCrz4xVLnqc
	 jaFuY0str56bhfBKjHenIW9lqm8s7f9zuJGb/TKY=
Date: Mon, 14 Jul 2025 16:38:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, Marco Elver
 <elver@google.com>, Alexander Potapenko <glider@google.com>, Andrey
 Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Oscar
 Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Matt
 Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] stackdepot: Make max number of pools boot-time
 configurable
Message-Id: <20250714163850.e58dd109d4c9e0d191995405@linux-foundation.org>
In-Reply-To: <20250714143332.264997-1-matt@readmodwrite.com>
References: <20250714143332.264997-1-matt@readmodwrite.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 15:33:32 +0100 Matt Fleming <matt@readmodwrite.com> wrote:

> From: Matt Fleming <mfleming@cloudflare.com>
> 
> We're hitting the WARN in depot_init_pool() about reaching the stack
> depot limit because we have long stacks that don't dedup very well.
> 
> Introduce a new start-up parameter to allow users to set the number of
> maximum stack depot pools.
> 
> ...
>
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -42,6 +42,8 @@
>  	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
>  	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
>  
> +static unsigned int stack_max_pools = DEPOT_MAX_POOLS;

Geeze that was all quite the mouthful.  Can't we just do this?

--- a/lib/stackdepot.c~a
+++ a/lib/stackdepot.c
@@ -36,13 +36,11 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
 
-#define DEPOT_POOLS_CAP 8192
-/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
-#define DEPOT_MAX_POOLS \
-	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
-	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
-
-static unsigned int stack_max_pools = DEPOT_MAX_POOLS;
+/*
+ * The pool_index is offset by 1 so the first record does not have a 0 handle.
+ */
+static unsigned int stack_max_pools __read_mostly =
+	MIN((1LL << DEPOT_POOL_INDEX_BITS) - 1, 8192);
 
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
_

(please add this to the next version)

(but why do we do this min() at all?  Why not simply use (1<<DEPOT_POOL_INDEX_BITS)?)

(shouldn't that 8192 be 8191?  Seems oddly inconsistent)

> @@ -101,6 +103,33 @@ static int __init disable_stack_depot(char *str)
>  }
>  early_param("stack_depot_disable", disable_stack_depot);
>  
> +static int __init parse_max_pools(char *str)
> +{
> +	const long long limit = (1LL << (DEPOT_POOL_INDEX_BITS)) - 1;

Expands to
limit = (1LL << (((sizeof(depot_stack_handle_t) * 8) - (2 + 12 - 4) - 5))) - 1;
which is 131071.

This seems a reasonable limit.  If we are to have any limit at all. 
Why do we have a limit?

> +	unsigned int max_pools;
> +	int rv;
> +
> +	rv = kstrtouint(str, 0, &max_pools);
> +	if (rv)
> +		return rv;
> +
> +	if (max_pools < 1024) {
> +		pr_err("stack_depot_max_pools too low, using default\n");
> +		goto out;
> +	}
> +
> +	if (max_pools > limit) {
> +		pr_err("stack_depot_max_pools too high, using default\n");

If user hits this they're going to tear hair figuring out the actual
limit.  So how about "stack_depot_max_pools exceeds %d, using default
of %d".



