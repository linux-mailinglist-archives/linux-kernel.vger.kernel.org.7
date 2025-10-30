Return-Path: <linux-kernel+bounces-877578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B9C1E7C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D99740472C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEEB2F7AA6;
	Thu, 30 Oct 2025 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSX/v238"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773102F618D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803989; cv=none; b=PbsudK3EZxLakgBq52aqT+6vpJqBlFkLnAhpANWz+p+Y1dmpiai0CLQO2Q5NUj15DmvMQNzGHwxRdLO8u4ktN6AcWElwv2oUbaRmO5wKT6j/ZZfaR6GEnNRn2zwoqncHNgSSETKQv5RVMNgM8Qeyg0PSJmSrGJjRJo26aR2sWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803989; c=relaxed/simple;
	bh=Fo8cm+XrUSwYf3Uitve4r+vVNnLUs+e4tzLAtKY9pvA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HvilNowy0SvR7qUtclg4c6ibmvGKeBoaikC8Nra2INl+JFJTkVygkVan4xDbsVMiKm7zMAej9mGWi+csbn9Jk8iccfY44bv8Pn3Dombec9lPCDt4qdar7odrT7k2BnCPnDCzRChxH6f3bVHyT6rCHw9dR3ie8gJotcg07aKd5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSX/v238; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e0dd765a0so740631d50.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761803986; x=1762408786; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ChsXC22GEEipb+m9hP846LdbfZpqHSDexm/9GSfJLYw=;
        b=jSX/v238TUmfKL7Mrx3azwMuuLzQpnqNyO0PJ6b3JeXZWX/0gv9dIyti/vegXRmrbB
         OFGhQ6hDYRr9TbYBzZX1qXt7gmVxp0Q8WJ+Dc1CKqulumUBL8sRtZJBoEBGRFB3IsUj1
         jxhkOe3qt6wkyE1n2mV57Octa0T30KfQU+enNlcsm7kEgZ/eZCfO3PyaxpLTtTfvAFw3
         m0+Hm4Jp1gZwyeP+ose2rd+1doIfa/PMhrLAVcrtVwxZu7+2wkaeXZW8EyYJoiomEiAa
         6J2W+d9mQDE2dnxwOtPT/igtvap5nyrQw8LyQ6H7H90FbkhM+SF/iy8kzKamxVkjkaja
         c/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761803986; x=1762408786;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChsXC22GEEipb+m9hP846LdbfZpqHSDexm/9GSfJLYw=;
        b=hJzgd5tpniSlUoxE7AcgKiCxOAwLiLzdPsnKIMqbn3fHffS4RMAY8IjmzDLhpw3rFv
         qz5AZwHBjFkZGfs36u1Gh1OxDQ92nUkq/kKbgG/YW9Bf75OtuGxVXW2xrtfJzwN2Ns2u
         6Ety28BHPkhAHkSx2R0rPUyaEjnmM5pGpu3eHCDJ07tBEwNAvrJX/Y7e52uJX6ybUcA6
         mleqHcZQgCwy5NPhpgFjIpMTSUrOSgKMCiP4+IGMcb+dMMK+WDhHYiXwqmGGFvH4HjaK
         uBSKINdb5yh9S3d2/ryHbgrKhjXMomHqAPCnHjLi5i0QxK+mqPHTRPJ84vzVkyI+Zn/P
         t8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCULNvMszcIjUK14ObeH8ICOs7LcjZJUiQIDG/gpyGj0qAV1V5Mtf0YmyyODIMWEk+OkVF6rJDmiDtF8Hm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOpn20WfxEd65Y/LOcXg8cPguCMyS9GgGYwXeJo+hJUtHIMZ9
	1KBxapMDhGpF7ywzCi7ug6jnNd011qcKegx0c0FPZ30n+AG2rPyakfKG+zi0KfbEug==
X-Gm-Gg: ASbGncsxJu81Yj6HgEwzez5ftYZ2s6+nBmoWAuRv7vbnuIcrS+d7+ROrL1nKklguAJh
	8EIIxPPrvF/hJeLVeKDoQ4dAhsUnw5VQAqQ5Y1oA8L5AMDlhityENFb4ppflp+fZbuz8tkqci7/
	mf7/OyfuMQu2Jk2vmzekW3VBdMijxkevAc/VPnqWYTfNvx6zyh8eTHr9ql61sjbqEX3vW+bvPeG
	ccNCjwycduzlGQYEGq111ZVTA9Y2Wpo5pqAI4foquB6swur9uxFZfnh6rDkySQDgYdV09HUcbf3
	tUiUnolfgJ5Sn/7pNr7XjUhZ1C41oyIC7t8VRk7JmUm0uxiWSaKRNptjzXjdYz7wYBFupQsDMYL
	sCwVdXWW9ozJ5QKT0Xc93Ti6Dqn6iADy+8o9vao8gwbYR4vsQqHG70vTAzlTfI5jKZNrKiWi3px
	mA/nPHHMAcX01SIizqZWES51EMnmNvpvDWyx9vBeIksvVJRKptKh+oWtrP5dMh
X-Google-Smtp-Source: AGHT+IHtaoa/Pxq5oxH85sshVOTI9spxw9LUpe10KGGpGL4M8OEIeW0CHTrJ2BtAjboq/8BNzA5j1Q==
X-Received: by 2002:a05:690c:3512:b0:784:94d5:847b with SMTP id 00721157ae682-78638e2fa9dmr35267717b3.20.1761803986131;
        Wed, 29 Oct 2025 22:59:46 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c4423d1sm4861208d50.17.2025.10.29.22.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 22:59:44 -0700 (PDT)
Date: Wed, 29 Oct 2025 22:59:24 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
cc: Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
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
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
In-Reply-To: <xtsartutnbe7uiyloqrus3b6ja7ik2xbop7sulrnbdyzxweyaj@4ow5jd2eq6z2>
Message-ID: <24aa941e-64b2-14cd-6209-536c1304cf9d@google.com>
References: <20251023093251.54146-1-kirill@shutemov.name> <20251023093251.54146-2-kirill@shutemov.name> <96102837-402d-c671-1b29-527f2b5361bf@google.com> <8fc01e1d-11b4-4f92-be43-ea21a06fcef1@redhat.com> <9646894c-01ef-90b9-0c55-4bdfe3aabffd@google.com>
 <xtsartutnbe7uiyloqrus3b6ja7ik2xbop7sulrnbdyzxweyaj@4ow5jd2eq6z2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, Kiryl Shutsemau wrote:
> On Wed, Oct 29, 2025 at 01:31:45AM -0700, Hugh Dickins wrote:
> > On Mon, 27 Oct 2025, David Hildenbrand wrote:
> > ...
> > > 
> > > Just so we are on the same page: this is not about which folio sizes we
> > > allocate (like what Baolin fixed) but what/how much to map.
> > > 
> > > I guess this patch here would imply the following changes
> > > 
> > > 1) A file with a size that is not PMD aligned will have the last (unaligned
> > > part) not mapped by PMDs.
> > > 
> > > 2) Once growing a file, the previously-last-part would not be mapped by PMDs.
> > 
> > Yes, the v2 patch was so, and the v3 patch fixes it.
> > 
> > khugepaged might have fixed it up later on, I suppose.
> > 
> > Hmm, does hpage_collapse_scan_file() or collapse_pte_mapped_thp()
> > want a modification, to prevent reinserting a PMD after a failed
> > non-shmem truncation folio_split?  And collapse_file() after a
> > successful non-shmem truncation folio_split?
> 
> I operated from an assumption that file collapse is still lazy as I
> wrote it back it the days and doesn't install PMDs. It *seems* to be
> true for khugepaged, but not MADV_COLLAPSE.
> 
> Hm...
> 
> > Conversely, shouldn't MADV_COLLAPSE be happy to give you a PMD
> > if the map size permits, even when spanning EOF?
> 
> Filesystem folks say allowing the folio to be mapped beyond
> round_up(i_size, PAGE_SIZE) is a correctness issue, not only POSIX
> violation.
> 
> I consider dropping 'install_pmd' from collapse_pte_mapped_thp() so the
> fault path is source of truth of whether PMD can be installed or not.

(Didn't you yourself just recently enhance that?)

> 
> Objections?

Yes, I would probably object (or perhaps want to allow until EOF);
but now it looks to me like we can agree no change is needed there.

I was mistaken in raising those khugepaged/MADV_COLLAPSE doubts,
because file_thp_enabled(vma) is checked in the !shmem !anonymous
!dax case, and file_thp_enabled(vma) still limits to
CONFIG_READ_ONLY_THP_FOR_FS=y, refusing to allow collapse if anyone
has the file open for writing (and you cannot truncate or hole-punch
without write permission); and pagecache is invalidated afterwards
if there are any THPs when reopened for writing (presumably for
page_mkwrite()-ish consistency reasons, which you interestingly
pointed to in another mail where I had worried about ENOSPC after
split failure).

But shmem is simple, does not use page_mkwrite(), and is fine to
continue with install_pmd here, just as it's fine to continue
with huge page spanning EOF as you're now allowing in v3.

But please double check my conclusion there, it's so easy to
get lost in the maze of hugepage permissions and prohibitions.

Hugh

