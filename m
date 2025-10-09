Return-Path: <linux-kernel+bounces-846218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F82BC74D1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A615B34FDAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4B2135AD;
	Thu,  9 Oct 2025 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SYNWnuJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A82110
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980673; cv=none; b=ZUTds+cVddtW2UG+uvEvnhpqX3j5Zn4oW/0gDMVqFk9zTLj/vBgWeBFtlFvhNo7X67hYFwYiJY9pUlDDHDxZaoByD2OgvNeJnus7LH9lhS69A2ehTfzk/pHqEXFmNIiHuXXIRleACtTPaW3jhwJdkZJxz3BvGkkHaxHDrpDjXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980673; c=relaxed/simple;
	bh=clhg3FgfH2TU9dqly+qtqS8CLbUif4SzcXFPqfUobns=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kZn7pgbYUUqn1vLzL9Rt1zDKaIp9JTGBr2VWrBWW0d7D58OdtL4iofwmlJpCZtaXqDbXCtTVcGVeno8KY6JccXpfd2+AP42PAAiCYQb4uACmP+g49aoyqx0El/xuFixMKn1iJYAuaH+59VAGQnEBGUKhjB5piP1K+t8jKpldxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SYNWnuJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D026C4CEE7;
	Thu,  9 Oct 2025 03:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759980672;
	bh=clhg3FgfH2TU9dqly+qtqS8CLbUif4SzcXFPqfUobns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SYNWnuJDyPWSTD0a6vStnPhRzdR/bAngJ6LoxocENe2iqmrvnJEj1OoFxb51dZPdL
	 8OVnFtbXO89kfJ0gvN3pjuAm1NWbKfc2NuuOyLh5x+7Kz7Z0Gw8BxcxI3LBh7Oj49S
	 bqQVZyraZ9tk2vgx1p9z4JA75RzZJgy8GTbX7ugs=
Date: Wed, 8 Oct 2025 20:31:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Ilya Leoshkevich
 <iii@linux.ibm.com>
Subject: Re: [PATCH] mm/kmsan: Fix kmsan kmalloc hook when no stack depots
 are allocated yet
Message-Id: <20251008203111.e6ce309e9f937652856d9aa5@linux-foundation.org>
In-Reply-To: <20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com>
References: <20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 13:56:01 +0200 Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com> wrote:

> If no stack depot is allocated yet,
> due to masking out __GFP_RECLAIM flags
> kmsan called from kmalloc cannot allocate stack depot.
> kmsan fails to record origin and report issues.
> 
> Reusing flags from kmalloc without modifying them should be safe for kmsan.
> For example, such chain of calls is possible:
> test_uninit_kmalloc -> kmalloc -> __kmalloc_cache_noprof ->
> slab_alloc_node -> slab_post_alloc_hook ->
> kmsan_slab_alloc -> kmsan_internal_poison_memory.
> 
> Only when it is called in a context without flags present
> should __GFP_RECLAIM flags be masked.
> 
> With this change all kmsan tests start working reliably.

I'm not seeing reports of "hey, kmsan is broken", so I assume this
failure only occurs under special circumstances?

Please explain how you're triggering this failure and whether you think
we should backport the fix into -stable kernels and if so, are you able
to identify a suitable Fixes: target?

Thanks.

