Return-Path: <linux-kernel+bounces-852556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAFBD951B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF0A54E94FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D94313549;
	Tue, 14 Oct 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc8MMyJ/"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2B31063B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444620; cv=none; b=lYrAwQbpeCBsg0J6oHaxPuq3HUIIuSF0id4PQmGSqzlJPXFzlhtKBXDyHXZy+iAKL68DkZJXqEG3KkL2kJg22aA1LkZrjjF31vIBFCz+78RlCYVE6BcXm3JKZz4cpvp9NiPLz7v/E5iB6fjXdtR35pL4b0XSz2ql2+07kGzGlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444620; c=relaxed/simple;
	bh=trw3erKcBrmCOtT2DE5wAFGrqWHQObe9Vw1+YmbQxYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8kHkIFwABlj02vUiVPaCpkarbXUzOj9x8uxdzQ513+Wx5XdARbhNpLPM8dDzOm/KAnyVViz1uz6Rq/T6PV4vbG43vSdJI5buPZ6aBjFWZfUf2rkU1SCotlVoFzcG6ixgcmzsCp3t31HdnX7fJmTO04RgVqXr7n0BgibQbLwX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc8MMyJ/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b50645ecfbbso1030395466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760444617; x=1761049417; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4zpYT42/pWjG2wOiPoPN8UFfIlZHUseBg40P2GM6ks=;
        b=Jc8MMyJ/UeRfPsHTc2O/vVOKfChumvUkphUUc0Yt29Oc4uNhLrkKroREHOW007AgsF
         LQs8rB55fCRWUTPBk8goujK5NS4RW+tmYd8M9TjHH6J3iSPfVW3WFQuXGjSBfnYdxB97
         SrivieCmlJgJ9YPSDxhUxGqZn+YFRE809SXXk4Azw2i7L9FDnCnFtdOuMLnLMCX9uqV4
         oH/byr3DHo4EAjrCdVmzWFTvART0VChXazqVj3bjWtQzRb3V19NPhY42NcAmOU5MhtTb
         s/Ko0LDMTkhQWPW6lke8YNwYIRCHou14iZ7uq9BPw8OQ+Fc9eriOLY6D4gGnfDRePPSp
         HhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444617; x=1761049417;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4zpYT42/pWjG2wOiPoPN8UFfIlZHUseBg40P2GM6ks=;
        b=YgzzkRcVTPUub31F8FU0OLBkqQ3/ljr7ZfHEcaux428j4xlx+1L2kXQAkWTDnSsp56
         E5lqOAqElzUCH3jU1Ok40uY+p5OFkirU3kwOSGkhZGY2LB/VPbrbjdq48ntKfzRN6yQq
         ooYGT9fwrodsIFouvQSRbE/iEO7xLAj5eHbX6IP7Qor+hEp+4Nx8ZSjb7R7P54QBkLIV
         4lizmr+ocsVhlXcMSEegA9Ze46O1bc3cerDg7/orv1PaWQKzt+xiGjr8WRvczjQ+cZn2
         oFEM0w1KhEnqwYi91x4eomKWb+q84ZDXYLCTn9I8QaaiFUIPEZ+F2K+wlmYAdvObvL2o
         6fbg==
X-Gm-Message-State: AOJu0YxEdYUeC2a6McQuy5fWj9yDNEazLmM47qn3J15da2lSyeSdWuqS
	uOgHZM3f1BxlYFlZNBUezl2TX03OZhdMI8cLUp/1PCVVG+KuvI/J+Mmd
X-Gm-Gg: ASbGncsimr1Do10XrzDBk7ajl61QmMtxADDS3FzHWLfZMW3FtPK9v/fXNRPBXM1D+ld
	pj8bw8S/IMjEmjAXqy7KCA3EEOpbBEMArSExR5KZDIIvRU6d0VsWa5MNuKswOl0MtYaRzlNAKKF
	KRRqdMag+Aez5RrcKhXwjdufB618zegDBBbarHkOhLOUBgcEmeDG88/wPEw+5Cf2sQulF7apvta
	e+hquWQixBjY6IFlnnfqNGdx1BzGEOPZqLJ3xlcEvTDl/4W42IH59WsnZlsUDxswMXOPas4+n6C
	40CC/kr8RUYAREKgfhSxuNJpRWvOohKdoxUWCU5ZzgVxok/Ubj/WgR5iUbRFzey8DyULZOoyGRB
	2XyHAyhXW+t7UnQbqxeOBNvw+buzUpO95Gj/Iz0cHMxH/3nfoNJ4=
X-Google-Smtp-Source: AGHT+IHDOAfe4JNqhFSA9gUX7LcGwhfmUpTtqm0hZRNoZ9LOkkInOSpqZhVqzK5eUfW8u4Wf52cxuA==
X-Received: by 2002:a17:906:730a:b0:b0b:20e5:89f6 with SMTP id a640c23a62f3a-b50ac5d07b5mr2495753366b.60.1760444616765;
        Tue, 14 Oct 2025 05:23:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b715ffsm11262090a12.22.2025.10.14.05.23.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Oct 2025 05:23:36 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:23:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 20/20] mm: stop maintaining the per-page mapcount of
 large folios (CONFIG_NO_PAGE_MAPCOUNT)
Message-ID: <20251014122335.dpyk5advbkioojnm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-21-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303163014.1128035-21-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Mar 03, 2025 at 05:30:13PM +0100, David Hildenbrand wrote:
[...]
>@@ -1678,6 +1726,22 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
> 		break;
> 	case RMAP_LEVEL_PMD:
> 	case RMAP_LEVEL_PUD:
>+		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
>+			last = atomic_add_negative(-1, &folio->_entire_mapcount);
>+			if (level == RMAP_LEVEL_PMD && last)
>+				nr_pmdmapped = folio_large_nr_pages(folio);
>+			nr = folio_dec_return_large_mapcount(folio, vma);
>+			if (!nr) {
>+				/* Now completely unmapped. */
>+				nr = folio_large_nr_pages(folio);
>+			} else {
>+				partially_mapped = last &&
>+						   nr < folio_large_nr_pages(folio);

Hi, David

Do you think this is better to be?

	partially_mapped = last && nr < nr_pmdmapped;

As commit 349994cf61e6 mentioned, we don't support partially mapped PUD-sized
folio yet.

Not sure what I missed here.

>+				nr = 0;
>+			}
>+			break;
>+		}
>+
> 		folio_dec_large_mapcount(folio, vma);
> 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
> 		if (last) {
>-- 
>2.48.1
>

-- 
Wei Yang
Help you, Help me

