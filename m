Return-Path: <linux-kernel+bounces-896614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A935EC50C63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E81744E8EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D1278161;
	Wed, 12 Nov 2025 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sj0rs/g6"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67A265CA6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930517; cv=none; b=tIMzoBNw1t7v+BfxV2YCHrQhuHN8k+l91h/L3Si8iEKbFVdO2+4H7cP97EjPqzyooBy0PfPmTyjT4pBEXpP7Jj7Kjz0wlhmkCnGDFofOfDEUrw2TTdZH9o/bKw6krh7UhtCQtHIGOWRzjbqy/nt/ClVtBeiJRVyI1zg7nF2KJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930517; c=relaxed/simple;
	bh=lSr3qf2YI0FWiZxKu8igH9Z/YA2aYQc1jylhAvc0UF0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kxH6KviwNA3yVINCPBFxtuYRVWeWhtxuWYS+Ainq1AWn6i9JrkAFNKG64K78nwfJ/FQmAOsy6oZJpb7CYWehqLwDVY6X4I50Pxc1YLP1mBrzGgDRPbREiA/lEbq5eGbCRTk0j0iwE5T6LJYb+AFy9zm+WFWErKfhlNkmSG+zRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sj0rs/g6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7866aca9ff4so5586177b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762930515; x=1763535315; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+2aDAgNNpvmztVWzyWU67msD40mML9fNw2pd7SfUBM=;
        b=sj0rs/g6QHH6+qb2zamQzhgXlhX7mZDliUVnnMNHrCHJ6j88sTRquqbLHkYhVZ2TW0
         pvy7sa4aVfkuloSmcIDhOMt7i6sUuG5VNW6smb7V8BUfhxq8rJiPZz7Tn/p9QbB/1i/d
         TP1lexGl+tosQIKIfsu4nNCGKS5HrWx0KE4v7XHqTXp/aOdSdMgQl9mOlL6gsw5aQ9/o
         5yo5ACRS7KWRYlFQLVIxUXyekdyqLLwR7y0HOXVMKuYc2Ez9n7mXr7eRRrz5Va6OZGDP
         uVUkojCL+vj2NLlsy8xlA8gEfRWVULTK8ioWVwJTVQHghft0G8UCa601ADHcdZXnNMig
         L2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930515; x=1763535315;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+2aDAgNNpvmztVWzyWU67msD40mML9fNw2pd7SfUBM=;
        b=XFThHNnPOBbf0Ok1A4VkCmbseqs3yFBAuw/oVdcQqRjwkulnjytEhQkztKMABDY5nW
         GTkIidHQVw/L1/wW/lWam6H5ZW6FJwRbs0AxhXDazrBVReG+fJ/nukfkpfrTCQmgclgf
         AhxomxDLpRcz/tcFR/mYSuQU9mjJXzOLhTaNI5/FcQR6wFsHEIk0SBARryAoNbXQ1z/Z
         URbPNcZYy2oH8rJTsKCj+WwIiuLLarY/Vy7SEcDwFytZsZqdHAuyv3KBkyGzRKFDGnpF
         HFWOh4L/QtQ2O4SrBWN26WteBEBX2jpOpA+bb480zWLTE8Ib71YdMLmbU5KDP58KH7AO
         Hb4w==
X-Forwarded-Encrypted: i=1; AJvYcCVYyhk+pgIyTtsNj5om5Sd3cMT8YMTzKArfXEBEPKk6u5ek/GPwdr0uauIAjo3OkFk/lr8WObew3G4cDF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq8J10a2CC0OL6UIACGOrfWhL2utxXWnpQleu3dhnrZNwiD2/E
	Mk+qJAIC3cKeGdGCfqgnp15OS8MKz3KENHrJYJrHLDvdmTGcQ5Kgu5/QZwnx7tlChRmfa0HoVVC
	btKj7M1hd
X-Gm-Gg: ASbGnctPjTurafSYfF+o1juF8P3IxL6aRcuQEPf21Z3J5FAXFp716UtJl1cqkoRdN9A
	6y/SGbxgSakK1KD3sotJZuMdLyovjwAD8Jvf6v9pyk3MrqMc5ZlxSF7AStkVoe36XSkbVw8vq+9
	Q1JPFrqoMkTp+lVeDDrwyBtLOQNosuGfXjfrHlToh+DgGRDN8aC4I21f1GMbhuqliuKML+5cfb/
	1eMeQiZ9SaDBDFySbAMJHrFqkbWjALeq1UpYC/1PATqVxvRDssDiTCZ0K9CLjkwMP+yHN/cFmbj
	LmXQzCJ6lrWTnsl34wMFJC8MLn2rJBOFfagJ77R+DmMFZTFo6gWh6jL5sIjwpAwZ1Qm9DZ2reXT
	Tam6v0Y2foKfFK4TvXMynP4GScWPbtp8MKNoQnHeC6uHH6P9Pe+8A9TwFZDOlBMiQWR3XEOL24B
	U9BNegGf7Iil+w11mp4v6bC9AOtmnw1mLUIIzQYRd+FVJUCouhgawYDvSvRsrqtZ+mSofMpekk8
	YuITmaOOw==
X-Google-Smtp-Source: AGHT+IGlVji64Q31PvxWDCE9wnYJAoL0csM/OHEk9a+ewKFIhSRNh79LwM5t6tm3Rf59bL7Nc/bffA==
X-Received: by 2002:a05:690c:6f8c:b0:786:6b92:b20a with SMTP id 00721157ae682-7881363f6e5mr17172437b3.24.1762930514888;
        Tue, 11 Nov 2025 22:55:14 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d69c0455sm39373027b3.37.2025.11.11.22.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:13 -0800 (PST)
Date: Tue, 11 Nov 2025 22:55:03 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
    David Hildenbrand <david@redhat.com>
cc: Deepanshu Kartikey <kartikey406@gmail.com>, 
    Vivek Kasireddy <vivek.kasireddy@intel.com>, hughd@google.com, 
    baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/memfd: clear hugetlb pages on allocation
In-Reply-To: <20251112031631.2315651-1-kartikey406@gmail.com>
Message-ID: <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com>
References: <20251112031631.2315651-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Nov 2025, Deepanshu Kartikey wrote:

> When allocating hugetlb pages for memfd, the pages are not zeroed,
> which leads to uninitialized kernel memory being exposed to userspace
> through read() or mmap() operations.
> 
> The issue arises because hugetlb_reserve_pages() can allocate pages
> through the surplus allocation path without the __GFP_ZERO flag. These
> pages are added to the reservation pool and later returned by
> alloc_hugetlb_folio_reserve() without being cleared, resulting in
> uninitialized memory being accessible to userspace.
> 
> This is a security vulnerability as it allows information disclosure of
> potentially sensitive kernel data. Fix it by explicitly zeroing the
> folio after allocation using folio_zero_range().
> 
> This is particularly important for udmabuf use cases where these pages
> are pinned and directly accessed by userspace via DMA buffers.
> 
> Reproducer:
>  - Create memfd with MFD_HUGETLB flag
>  - Use UDMABUF_CREATE ioctl to pin the hugetlb pages
>  - Read from the memfd using preadv()
>  - KMSAN detects uninitialized memory being copied to userspace
> 
> Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
> Tested-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Thanks a lot, Deepanshu and syzbot: this sounds horrid, and important
to fix very soon; and wlll need a Fixes tag (with stable Cc'ed when
the fix goes into mm.git), I presume it's

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")

But although my name appears against mm/memfd.c, the truth is I know
little of hugetlb (maintainers now addressed), and when its folios
are supposed to get zeroed (would a __GFP_ZERO somewhere be better?).

I was puzzled by how udmabuf came into the picture, since hugetlbfs
has always supported the read (not write) system call: but see now
that there is this surprising backdoor into the hugetlb subsystem,
via memfd and GUP pinning.

And where does that folio get marked uptodate, or is "uptodate"
irrelevant on hugetlbfs?  Are the right locks taken, or could
there be races when adding to hugetlbfs cache in this way?

Muchun, Oscar, David, I think this needs your eyes please!  I sense
that there could easily be other bugs hereabouts, but perhaps the
lack of zeroing needs to be addressed before worrying further.

Thanks,
Hugh

> ---
>  mm/memfd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 1d109c1acf21..f8cfc2909507 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -96,6 +96,12 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  						    NULL,
>  						    gfp_mask);
>  		if (folio) {
> +			/*
> +			 * Zero the folio to prevent information leaks to userspace.
> +			 * The folio may have been allocated during hugetlb_reserve_pages()
> +			 * without __GFP_ZERO, so explicitly clear it here.
> +			 */
> +			folio_zero_range(folio, 0, folio_size(folio));
>  			err = hugetlb_add_to_page_cache(folio,
>  							memfd->f_mapping,
>  							idx);
> -- 
> 2.43.0

