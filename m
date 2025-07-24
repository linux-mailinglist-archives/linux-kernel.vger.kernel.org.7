Return-Path: <linux-kernel+bounces-744986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEE5B1134A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9F53B11A4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA5230D0A;
	Thu, 24 Jul 2025 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wOBTkMrE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B178E215055
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393923; cv=none; b=S30k7MqC3WLlVSmZxsUyeaMN034UONPPUUQFQpzfC82+UP0d0yCOfw8zCI++jkIRemsGJ68gOR1ZBoZz5jxwSv4/RDTNkF9RH9QA13qU0eGDl7q02WI4pnbGt2+ZvdhZk9XIvXf0iwvS5R+dsXU03jptqE6iwbP0m7V96bpDOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393923; c=relaxed/simple;
	bh=5OoEe7SZSPXZs8wT2btyJqWHG+JKmXeljHTTSsOV8iU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=grukTCxx5jq6FA0RIXDY6SAWvjmmDjx7HSPafqsN+pUMGN/DARkACX3JwfqoTbxlJ0sE2tYP1ha0X8TYlQGJNUeYV0C4lPtOjjscXsay9qeLLnkb75g30E4ck9+LDdWI7pJJu/PN2dotGPIadUvbXJta256c6JoyyyrTVfn00AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wOBTkMrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA02C4CEED;
	Thu, 24 Jul 2025 21:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753393923;
	bh=5OoEe7SZSPXZs8wT2btyJqWHG+JKmXeljHTTSsOV8iU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wOBTkMrEHUl82WmHclcL0OScUCkn29r07y/G/QTwxdXEwaWVPFCPdpJTBULmwO3Ue
	 TwICs8wRfXFYuLOu2HC6Izk8GmBDdLZ2xldi/NmvtRNvUeqf8dQ457NJmmZqAQOanS
	 8/MjVB2Y49HPyHZDBZ8savtZ0rPFPiX+Ap28U/6E=
Date: Thu, 24 Jul 2025 14:52:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jann Horn <jannh@google.com>
Cc: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
Message-Id: <20250724145202.7f48386e9bd6fc8e114c3436@linux-foundation.org>
In-Reply-To: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 21:13:50 +0200 Jann Horn <jannh@google.com> wrote:

> If an anon page is mapped into userspace, its anon_vma must be alive,
> otherwise rmap walks can hit UAF.
> 
> There have been syzkaller reports a few months ago[1][2] of UAF in rmap
> walks that seems to indicate that there can be pages with elevated mapcount
> whose anon_vma has already been freed, but I think we never figured out
> what the cause is; and syzkaller only hit these UAFs when memory pressure
> randomly caused reclaim to rmap-walk the affected pages, so it of course
> didn't manage to create a reproducer.
> 
> Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous pages to
> hopefully catch such issues more reliably.
> 
> Implementation note: I'm checking IS_ENABLED(CONFIG_DEBUG_VM) because,
> unlike the checks above, this one would otherwise be hard to write such
> that it completely compiles away in non-debug builds by itself, without
> looking extremely ugly.
> 
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -449,6 +449,19 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>  	default:
>  		VM_WARN_ON_ONCE(true);
>  	}
> +
> +	/*
> +	 * Anon folios must have an associated live anon_vma as long as they're
> +	 * mapped into userspace.
> +	 * Part of the purpose of the atomic_read() is to make KASAN check that
> +	 * the anon_vma is still alive.
> +	 */
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && PageAnonNotKsm(page)) {
> +		unsigned long mapping = (unsigned long)folio->mapping;
> +		struct anon_vma *anon_vma = (void *)(mapping - PAGE_MAPPING_ANON);
> +
> +		VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) == 0, folio);
> +	}
>  }

PAGE_MAPPING_ANON is now FOLIO_MAPPING_ANON.

The subtraction to clear a bitflag works, but my brain would prefer &=
FOLIO_MAPPING_ANON.  Oh well.

Plus gratuitous 80-col fix:

--- a/include/linux/rmap.h~mm-rmap-add-anon_vma-lifetime-debug-check-fix
+++ a/include/linux/rmap.h
@@ -458,8 +458,9 @@ static inline void __folio_rmap_sanity_c
 	 */
 	if (IS_ENABLED(CONFIG_DEBUG_VM) && PageAnonNotKsm(page)) {
 		unsigned long mapping = (unsigned long)folio->mapping;
-		struct anon_vma *anon_vma = (void *)(mapping - PAGE_MAPPING_ANON);
+		struct anon_vma *anon_vma;
 
+		anon_vma = (void *)(mapping - FOLIO_MAPPING_ANON);
 		VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) == 0, folio);
 	}
 }
_


