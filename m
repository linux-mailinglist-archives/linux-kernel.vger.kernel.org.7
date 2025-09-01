Return-Path: <linux-kernel+bounces-795393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D1AB3F15C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79130161C88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023A274B53;
	Mon,  1 Sep 2025 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4fPO+59"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A596BA4A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756770672; cv=none; b=J7FwdiTjkZ0y2fVcrQGWSwU542jwZK0fJOQNth849YSNFWmvT993hXlciX4SN/g0Ass+tUl6e4YC/47wVJkk2rwy5KutDRh3yW/geVKJNY+XYCmExcB5TbTQEKLP9GpTjRB6YJOBr0kvbLPIs+kvD+PKtbHzC335hyTfaXb50co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756770672; c=relaxed/simple;
	bh=EYNsvmk+b2NHho8sQvWH/yggEZY8AJCMPVz1fi8mYi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFqQNj8VfhmRdZ7sbL0q0/i64u1rsSjkmoRasTHxKZusFL4AT2OB9VIIdfFsitwHxBqhJ5mhMr7osm5YZAiNzPIVJUmwq6WJLTrodKLyTLjygRs9XmaKFlF3Fq3nGwPpzBFAtatOxvCDFbpXFdy6wrZpGnSM7BZCROhYz3sE4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4fPO+59; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7fe9eea0d21so258874385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 16:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756770670; x=1757375470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqIHNFoYLFHKJhJTPf2NISmNl0Wnj/vp/3ZJmR5d4Fg=;
        b=d4fPO+59MzTXtuMkq8YCa3JyzMSCO32B9MV5a4HBcoL1poBdRvBt19Kt/EbGBWVDA+
         WAQ7v+z/XfzIAn43hg2Wmlo2LOTurUIpjKxgeJf9U3iv+zY1whZbA6hO/v2pKf/4nGXg
         bpsd62600X36+UKNPlHS2FjgsUQuLcfuxiEAA2hm+NOTKXxA9hQLJUCsTeZCUT72BMiH
         Iisv3e4aH4J0K3tRUMOqvw0KwTaTEoNTJEtil1bU8XcavirRlbbS38tPUU8Bc8ruJW9t
         otGNB8sbHsap9UvTaK5Jskto2eBSyAYyi0DHZJ6OO4Br6+zBaNrM3xPczhY+FVaU0oqj
         vpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756770670; x=1757375470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqIHNFoYLFHKJhJTPf2NISmNl0Wnj/vp/3ZJmR5d4Fg=;
        b=kdNwf6SSUNeD/FIxePB0UoBVSx4tSr74G8hR7016DmJg0pk+z1LtpsM9v2kcYgiODO
         wVkM/kSFJLvIkk8QX3fmAFBCz7dCj7UrhzIx/XkxfRjdD5Z0robmZujqThXlns/unkgc
         iCUPazjMeDfq6XFzRasOhXSI+kK4ZAXuC2A2L88fg05uhZIwe4hrlvuNFRlcWp019YM2
         o2Qms5t+Haclc0WW0yHkNDiv3Tyt3im4mrIi/1n39GC9FUyF0/q0hIbmwfPzW5w0BODm
         p7dBb8JLUG8n0Qcw3sIRMY7UE/DwYRamOUwXJEbnYqd/1OST2frEaPLIIx2nx7jqoDOg
         WWHw==
X-Forwarded-Encrypted: i=1; AJvYcCUbDR5f34n6mC5ewQ/gtvnzZUGspCv4spcYq8cuAdd9qga6pAEt5oZKIg+iFEcXf4LQoumHUyW3rZpzDbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+I874zWfz9M+pbOGe4BZiuiVU+fGCROzOq9SxUMTF+J4WBLYE
	N+wpB3Ye6p54rFfyMc5F1yc60LiU7bybr51nyRirXAXfu7WPWVKQzVIVvtPtKbzcGVOclz8GK7m
	LyU2jBLjQYdwzQdWo7aH/9gRBF0Arl0A=
X-Gm-Gg: ASbGncvNwwWG3a47gPOxaXmIc/UfKjspmI5O5KoQqPLqTULvrhzYTDKB5bB/4F89wkp
	c9fTFvzWyNDsIMod9wXeQK/1NIYalgyfCsk8HQwQnNRlOHgxk6ufbe1VJx/2FO4s9WHVgSWpHQc
	dkaF0c++gIm8hvx1ZQ8rCQfupBqz8MliuaMZ3VRIBFUJ0bvuYiWJAzP+Wh2cL9WFr5n1QkzH0sq
	T9fVMsssFgSNt3jqw==
X-Google-Smtp-Source: AGHT+IFEljUaTil2+CEYlRXkXKAo+TnC+CteD5ohkve5fALgKeduVJE5mcFQyP1+j0xsB7Wac6Acd0GFwDcqkZ7qAh0=
X-Received: by 2002:a05:620a:a80a:b0:801:a5f7:1645 with SMTP id
 af79cd13be357-801a5f71a68mr586445885a.85.1756770669823; Mon, 01 Sep 2025
 16:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-2-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-2-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Sep 2025 07:50:57 +0800
X-Gm-Features: Ac12FXxqtGbLYCOlRJLl0vKc6QhZHbL5Ut-TDLRHKuwjm64bxLdZG0Cg3nR9zxY
Message-ID: <CAGsJ_4xoN35Av2H70o+dwGzhKrAnm7gppEseG0MgAUPQt2TygQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 3:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Always use swap_cache_get_folio for swap cache folio look up. The reason
> we are not using it in all places is that it also updates the readahead
> info, and some callsites want to avoid that.
>
> So decouple readahead update with swap cache lookup into a standalone
> helper, let the caller call the readahead update helper if that's
> needed. And convert all swap cache lookups to use swap_cache_get_folio.
>
> After this commit, there are only three special cases for accessing swap
> cache space now: huge memory splitting, migration and shmem replacing,
> because they need to lock the Xarray. Following commits will wrap their
> accesses to the swap cache too with special helpers.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Nice! This has cleaned up the confusing mix of using
swap_cache_get_folio with VMA, filemap_get_entry,
swap_cache_get_folio without VMA, and filemap_get_folio.

Reviewed-by: Barry Song <baohua@kernel.org>

Do we have any potential "dropbehind" cases for anonymous folios?
I guess not for now.

__filemap_get_folio()
{
        if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE))
                folio_clear_dropbehind(folio);
}

Can we mention something about it in the changelog?

Best regards
Barry

