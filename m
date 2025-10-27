Return-Path: <linux-kernel+bounces-871031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00448C0C466
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECFC3B2C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D172E7BB4;
	Mon, 27 Oct 2025 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4a5ss/L5"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A52DEA96
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553259; cv=none; b=LTFxxMBDsOJtQS8UO3EF+c+pMZByhm6IkYmjNJQ0YHs+fVjZ49XqEZWQCKl1UPqqXFDDSlWQXrgPeOTrl5KGlRkdIyLhXS4n3lUw4kmV4IHBTIkMjWp5Uoz1IwV1OgIhIC7cmNHmV9ZSRpVx03MV1hHi2Y+eE1DoPK7+YNa39Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553259; c=relaxed/simple;
	bh=ECPu/wJw4iKhTKTaEfb6pK0kQ1b8vXYUKnijBY/H8PY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D+Oms0L6gdLWw6UI71aw4cfESfsvIwKKF8I+DgdrlrrIfAyr53anE5ANJKTfzLcUp6qegtGfOctBOqZ6pT2rXYbYC4pJBZ5OLxt0MDic272EfVKGZ9OstupjMguYz07//5qeC6u/eQwSU3pB6rq+pdXGA3vBo7kUddtUzIzPUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4a5ss/L5; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e16fbdd50so4110271d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761553256; x=1762158056; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8i9V9XN9hg6qjjGZ1kzhc0nrYJh0IgUWRXxrYjVsEk=;
        b=4a5ss/L5jfuk5NGsxlz/gxyVJjsWnDZCkd4cDJZn8nRADDjmAx5q+8HtXHLdB5yjHD
         b2LDLaCyppvh30NcPlROse9am4B7tjI8rfVixEpoqDNMz+Brr3eTGWXnon8/2461cjEq
         JgoNvO59BfbOkp4iqzzqxW1uFaLVJ4ZeXwmXZxrGhrrYbjrDwUv4TdDy4LQ3dNRpLuQA
         V1uB4WX8WNk85JGOpdSKAmAUcIvkyV/d2YU3LHRMdGUhdEn0WHOcj2gixoGDaVfDh47s
         C9JDBdL3BjIlzsTBq17JIx0DDgZFv7AUMASs5PR6JdstQM1l21zCCNtsrIssujIXsRA/
         lgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761553256; x=1762158056;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8i9V9XN9hg6qjjGZ1kzhc0nrYJh0IgUWRXxrYjVsEk=;
        b=iu8PrfOojBE4wyBHnKsnKNlt71yJSV/C/6ch9co9rXpuHJAb2jrzoGNOrrE2MiOS9Y
         0CtnvRBIbc/AcZfUPTOsqpjevWuYXdAYThyVg10O2lQR3pJjlAXbt+PaMhqfYg64kMm2
         MqMOByOmp8YGPQVN/eiw+XqQMzmJnPUaP5NDXmVj/VAmqmnRKE/L/X5OLhB1GRQeNBmF
         qoS2PybATmA063VV6KCSQy3JBtQItgxKGqrhy4wEaRO32pp62V74NHcy/JKd1iQdKRRV
         IvYESsMvKVKc4AzwpGoSi1yO+gkylso0VG48OmBHGO4rWYgKsqE+GKR6Sz1b/QfeNHXR
         nJYg==
X-Forwarded-Encrypted: i=1; AJvYcCV38MEm9DYl3FY8wYF6DfisetCIHLTd5AXdphKt5n82NHMG4o9NyYvufCHCmCS7JqjitB+BSy72fCKkoOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7j7itbGdiiI0cOn5uWZHBCNVFjTk2azUBgPcjRQknEdIqQdGT
	cQwGGj352SA5i/yEW23a8CjguTf9hG+ezBR/o0AtP3BVIy/oTZ5auR4SNm6R59Gbuw==
X-Gm-Gg: ASbGncu1OIUbf5gz8pOBJ04F/KD+TRRpPgqQFr2XJxZmak7A5lFlQjrf8p52ohbI8YP
	1PQ2quA+MJX88f/8tEMeLqhUjf/yytmc0lOa3m1trX8dnZ7+cCrxdFxIhv/MfaAd+CrhO5SVwVE
	WFwYm31bdkx9IoxflEdb1URhdMtzzZt70KKEyCGnfISfxr/xI3/qes5EVrVh3Kz5NIizMvYO9d1
	1Y1cCcB5ajxBeX5ja8zLzk7duS8QwzPnDaPRvRU4BVM8gbK8KTZy49IJWnYkKiCIXHBBRZVpacG
	sMG49g6PjljRS8wNeWQwGaXxwdmNjQIW4Q/L4mz7VHtSHfTJN3i29G7Zidh37QSoHK6YC53otBu
	bgacJan7qIh4rswg1fknozOq5X18XQ8IupvWnItgUXXiqqzP21UnZ8IAJ4ylKxv5l0lIoky56/m
	JvZ2GD3b133y8sp7QXNkq5xB+aIeulDlvvRp5dxN7YdCkCLJllpawepvIN42QI
X-Google-Smtp-Source: AGHT+IEkrjgBL/rVFsJvctj6nF95xlm6ZoesSRoLMtXTNJL5ue1ifqY7ixGqz6500hmN62Bj943W/w==
X-Received: by 2002:a05:690e:258d:b0:63e:e3c:ea59 with SMTP id 956f58d0204a3-63f4357cd79mr6910825d50.56.1761553256284;
        Mon, 27 Oct 2025 01:20:56 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c3bc6e3sm2081958d50.3.2025.10.27.01.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:20:54 -0700 (PDT)
Date: Mon, 27 Oct 2025 01:20:42 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
In-Reply-To: <20251023093251.54146-2-kirill@shutemov.name>
Message-ID: <96102837-402d-c671-1b29-527f2b5361bf@google.com>
References: <20251023093251.54146-1-kirill@shutemov.name> <20251023093251.54146-2-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Oct 2025, Kiryl Shutsemau wrote:

> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> Recent changes attempted to fault in full folio where possible. They did
> not respect i_size, which led to populating PTEs beyond i_size and
> breaking SIGBUS semantics.
> 
> Darrick reported generic/749 breakage because of this.
> 
> However, the problem existed before the recent changes. With huge=always
> tmpfs, any write to a file leads to PMD-size allocation. Following the
> fault-in of the folio will install PMD mapping regardless of i_size.
> 
> Fix filemap_map_pages() and finish_fault() to not install:
>   - PTEs beyond i_size;
>   - PMD mappings across i_size;

Sorry for coming in late as usual, and complicating matters.

> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")

ACK to restoring the correct POSIX behaviour to those filesystems
which are being given large folios beyond EOF transparently,
without any huge= mount option to permit it.

> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")

But NAK to regressing the intentional behaviour of huge=always
on shmem/tmpfs: the page size, whenever possible, is PMD-sized.  In
6.18-rc huge=always is currently (thanks to Baolin) behaving correctly
again, as it had done for nine years: I insist we do not re-break it.

Andrew, please drop this version (and no need to worry about backports).

I'm guessing that yet another ugly shmem_file() or shmem_mapping()
exception should be good enough - I doubt you need to consider the
huge= option, just go by whether there is a huge folio already there -
though that would have an implication for the following patch.

(But what do I mean by "huge folio" above?  Do I mean large or do
I mean pmd_mappable?  It's the huge=always pmd_mappable folios I
care not to break, the mTHPy ones can be argued either way.)

Hugh

