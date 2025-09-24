Return-Path: <linux-kernel+bounces-829881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFCCB981C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93EA2A53C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5D223DE5;
	Wed, 24 Sep 2025 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZqM+RzB7"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DF21D3C9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683550; cv=none; b=fpKN9WgxRo5iDxxm82PJSH7h2zYzCrP8RMcQhltqv4ewZmOdhQoni1lTZBlOA9AKIxsnY2T1PoriQztqrTigd1KsagnErsK8bO4HLjS2IHz8WkfrsgB84L/NYholQkrMFqiQyVGBdR3NhLz1OFHC+fnDTlifmvb/tCYT1rZrIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683550; c=relaxed/simple;
	bh=Me5VP6Be922V8FVzXDNDAiJ2jg6Vq4w2eQbABap0OsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6FrNq11g9bBb+k42eHwPCEtG77Gj6LMu9pGJ1YlgqlYPbZ4Gke/JmQv+7bvPym7zFzj0bQBL4c6jHgsNQkoVjEc/etZPdWwC8nmVYWRK7haQb4NIo5LH7ft/+bgQatjGWRKMmunXaCZn/s2bFQ00yjA60/AnsMEs9NLwazQ6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZqM+RzB7; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Gm-Message-State: AOJu0YwDE1Y2TdIr2HPFsk7EDCQUKXw4cuaryVJS/Gu4z0ncu/Uk15qG
	G1Wc2/ngIIwzAsMIf9SL7YceuiAPnvtnsRvBSs/OaJ7TDQchnwAX0fNv7M+3O9bq4ZlG1XxRWA8
	pPYrnIuJX9+snUmR4V/52ufNFNS0jMdY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758683544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOrHhjsmxF2Ew0D7GzKZcNGlrZ1OvklqA2nVYEVLSIc=;
	b=ZqM+RzB78nor3Z6caj1TDB2xmfdLKyAfSUARdgXkKCCYmDgbOaH+PEofxYRPBygZOQfRk3
	BKZoRwzf+//stn70p1maJCBPZsYj5/xMSCBDNl9zlEwh+jGpKRznipl9212Lch2rYMAoqa
	nmRLOqr22BpM9Zbw3CB7Eb3+O8C4O3Y=
X-Google-Smtp-Source: AGHT+IGQ4pBfaILYlDHVJp4SkABtJmejqgHl68noujwNpKHg3bpoTJW1Hux0HRmpISdc0eyTZ91uBuK0aDN1rxLh/wk=
X-Received: by 2002:a05:6214:5196:b0:70f:a4b0:1eb8 with SMTP id
 6a1803df08f44-7e6ff32e686mr49834776d6.13.1758683538065; Tue, 23 Sep 2025
 20:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923140058.2020023-1-david@redhat.com>
In-Reply-To: <20250923140058.2020023-1-david@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Wed, 24 Sep 2025 11:11:42 +0800
X-Gmail-Original-Message-ID: <CABzRoyaWCxOZAvMO5ZAxk3eaf4mkSQwfUwYW0dXcR3yhjCMJhA@mail.gmail.com>
X-Gm-Features: AS18NWDqoKmUtQv8Yz5yjznM5vChyLT8QPhh1t0udZYb9G0scu2d2wiqj3iGwe8
Message-ID: <CABzRoyaWCxOZAvMO5ZAxk3eaf4mkSQwfUwYW0dXcR3yhjCMJhA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: convert folio_page() back to a macro
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 24, 2025 at 12:44=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> In commit 73b3294b1152 ("mm: simplify folio_page() and folio_page_idx()")
> we converted folio_page() into a static inline function. However
> briefly afterwards in commit a847b17009ec ("mm: constify highmem related
> functions for improved const-correctness") we had to add some nasty
> const-away casting to make the compiler happy when checking const
> correctness.
>
> So let's just convert it back to a simple macro so the compiler can
> check const correctness properly. There is the alternative of
> using a _Generic() similar to page_folio(), but there is not a lot of
> benefit compared to just using a simple macro.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

LGTM. Feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

>  include/linux/page-flags.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 568011930e358..48e27768e7ba9 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -316,10 +316,7 @@ static __always_inline unsigned long _compound_head(=
const struct page *page)
>   * check that the page number lies within @folio; the caller is presumed
>   * to have a reference to the page.
>   */
> -static inline struct page *folio_page(const struct folio *folio, unsigne=
d long n)
> -{
> -       return (struct page *)(&folio->page + n);
> -}
> +#define folio_page(folio, n)   (&(folio)->page + (n))
>
>  static __always_inline int PageTail(const struct page *page)
>  {
> --
> 2.51.0
>
>

