Return-Path: <linux-kernel+bounces-788993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CD2B38F67
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7E5980D57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3C82EA741;
	Wed, 27 Aug 2025 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V+4gzN75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E40930CDAD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338791; cv=none; b=B1rpeObcehq85ajS5U5YI+Vr8q67RgaGBfEchd/4JI9xrpVBk4LSTlkv3W4qVvwEU64NPf/QWgd9LNVAnwue0JIWg/WxFCUkPK7ZbnJJ/CFqOvADiY2cEP6JGH5vQPsQXvnP5fu2FR+4CcxbTAd3Yig+/mJsrfB76O0qG7DBj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338791; c=relaxed/simple;
	bh=OiOLYJb2Zd5nJ4kFjVVVoam9t8cIRUYfLzwKKyXHnpk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sObN1Iufybl8tEMJ6AXOiTg0lwc1mFnJjdxu7hiKVPINB5OeiXAgfUi97hOBcBfOhEi+LlM6sh6RSp0ZJ7Yvc2+5ZY1hIXWO3l7a7L2qvejtxhtCfq2z3WNQKA1f1NLDOm2lF4kVq8iIQR4Ff4olxp0TddGQP0jHQo6Pj44dqT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V+4gzN75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7974C4CEEB;
	Wed, 27 Aug 2025 23:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756338790;
	bh=OiOLYJb2Zd5nJ4kFjVVVoam9t8cIRUYfLzwKKyXHnpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+4gzN75/R/uxO0d6n902wfPpwNcKXxYvim8iTOEcOW2FctPSVv/cknX5aKQ+oa2G
	 0J6K3m12nPnf/tiqge5xDMw6idP0rJmYpq9WZTpO+TGSObxliabGRS8NZBxN+oGfcq
	 +4X35cjB9q75g/V7gp7bz46O8+/xuYVX6oAPq2tE=
Date: Wed, 27 Aug 2025 16:53:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] huge_mm.h: disallow is_huge_zero_folio(NULL)
Message-Id: <20250827165309.44e465ff214e45f1a6665b24@linux-foundation.org>
In-Reply-To: <20250827150330.280399-1-max.kellermann@ionos.com>
References: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
	<20250827150330.280399-1-max.kellermann@ionos.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 17:03:30 +0200 Max Kellermann <max.kellermann@ionos.com> wrote:

> Calling is_huge_zero_folio(NULL) should not be legal - it makes no
> sense, and a different (theoretical) implementation may dereference
> the pointer.  But currently, lacking any explicit documentation, this
> call is possible.
> 
> But if somebody really passes NULL, the function should not return
> true - this isn't the huge zero folio after all!  However, if the
> `huge_zero_folio` hasn't been allocated yet, it's NULL, and
> is_huge_zero_folio(NULL) just happens to return true, which is a lie.
> 
> This weird side effect prevented me from reproducing a kernel crash
> that occurred when the elements of a folio_batch were NULL - since
> folios_put_refs() skips huge zero folios, this sometimes causes a
> crash, but sometimes does not.  For debugging, it is better to reveal
> such bugs reliably and not hide them behind random preconditions like
> "has the huge zero folio already been created?"
> 
> To improve detection of such bugs, David Hildenbrand suggested adding
> a VM_WARN_ON_ONCE().
>
> ...
>
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_HUGE_MM_H
>  #define _LINUX_HUGE_MM_H
>  
> +#include <linux/mmdebug.h> // for VM_WARN_ON_ONCE()
>  #include <linux/mm_types.h>
>  
>  #include <linux/fs.h> /* only for vma_is_dax() */
> @@ -479,6 +480,8 @@ extern unsigned long huge_zero_pfn;
>  
>  static inline bool is_huge_zero_folio(const struct folio *folio)
>  {
> +	VM_WARN_ON_ONCE(folio == NULL);
> +
>  	return READ_ONCE(huge_zero_folio) == folio;
>  }

OK, but it remains the case that we have seen code which calls
is_huge_zero_folio() prior to the initialization of huge_zero_folio.

Is this a bug?  I think so.  Should we be checking for recurrences of
this bug?


Also, sigh.  I do dislike seeing VM_WARN_ON_ONCE() in an inline
function - heaven knows how much bloat that adds.  Defconfig
mm/huge_memory.o (which has three calls) grows by 80 bytes so I guess
that's livable with.

