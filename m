Return-Path: <linux-kernel+bounces-865854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4005BFE2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004AB1883DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB347214807;
	Wed, 22 Oct 2025 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="w9q1klmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA761FBEAC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165079; cv=none; b=RsycgNF4f9ABCPP6e3gnBqU6DjfCb+tHNMa0Ve/eI7VGLq3mmFAfSxjZHiS2VQ+lOQi01EQqASKSrlEBFGKkfbuG450iqDdxIb8KcBhI+H+7EBUWzQBjmWfqoUQTE+Snasd0YEEq98GQtQzNe/1exLE0V83+BdtsUz4tKdksSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165079; c=relaxed/simple;
	bh=PYBRJIE2AzLCJIOA5mxGioZu5kRAh7s6KYh05y8hKyw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VP1sUI1kyxxhpwM+jPvbNQgS+AN3brWb8pd0Ea4PiGG0TCskrFckl9OYY+R/pswRsrBtJ9N5rcYnduBHXiO29O12AVPShGbKNiXUprGCO1Ygy4hhK5e4JIsAA0O9GjjZeNiAoFXVlivUV0F5c7b+QI5FEXXo3lgIfrGWY4IUrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=w9q1klmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E17C4CEE7;
	Wed, 22 Oct 2025 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761165078;
	bh=PYBRJIE2AzLCJIOA5mxGioZu5kRAh7s6KYh05y8hKyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=w9q1klmYoOXMFEprrdmvg9iJv/FQC1vDPcRutX+/g08xjqg//sOjy6qaMN0GdYz26
	 QQpoF7f9peB70xZ+Mro6WovAMtx9CKgGFjpAl3eZE9iBxM7sgYBXlBDFV3xFAILRP+
	 Eyki8vANrnKq539rP6uzfXklY4/n5U64tvBHC5yQ=
Date: Wed, 22 Oct 2025 13:31:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, craftfever
 <craftfever@airmail.cc>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
Message-Id: <20251022133118.f13f924348e8cdc6d49ef268@linux-foundation.org>
In-Reply-To: <20251022153059.22763-1-pedrodemargomes@gmail.com>
References: <20251022153059.22763-1-pedrodemargomes@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 12:30:59 -0300 Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:

> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> 

Thanks.  It would be helpful of the changelog were to tell people how
significant this change is for our users.

> Reported-by: craftfever <craftfever@airmail.cc>
> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io

Buried in here is a claim that large amount of CPU are being used, but
nothing quantitative.

So is there something we can tell people who are looking at this patch
in Feb 2026 and wondering "hm, should I add that to our kernel"?

> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Fixes: 31dbd01f3143 ("ksm: Kernel SamePage Merging")

If the observed runtime problem is bad enough then a cc:stable might be
justified.  But a description of that observed runtime behavior would
be needed for that, please.


