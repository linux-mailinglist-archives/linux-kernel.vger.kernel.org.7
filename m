Return-Path: <linux-kernel+bounces-806142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86483B49259
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DD77A223D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875730F81B;
	Mon,  8 Sep 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0mbiZGl"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0430F7F6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343754; cv=none; b=O8gQIvCUgStOmHazap2OTEPD8o7KH6Wz3QyZ9SU5MJK+qVjNJPzXi0PtUo/GzYMMiOB8pEVBMBMPbaukfldPQpEH/653EZqwVkD3niWbxvEg/9KWAlKMeGQo6NB4xZ+xKTWNmBqMQmx54NGkuTR+UxiJJK5M73npdveIA7qNp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343754; c=relaxed/simple;
	bh=mlk7CEaDWsusV6a6RSbZw0bpsuLPACNzKa/4RBgoKBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ru8rSHqKAksx/rmle4p4rU79EH0nNppzJ2NJrIWYCA7gyCUYERmhgAviXWRsp5G9SNgo4LX5FMdZv4N9m5rBYD0wBrD9GpA2dfvnhnoZJrQmmGstI4i5P5KiL/UmJbwwU7r+jHA0BR2bK/PB1lR3aeuSXqdv8q8vH/RVhC3YdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0mbiZGl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a16441so682460666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757343751; x=1757948551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlk7CEaDWsusV6a6RSbZw0bpsuLPACNzKa/4RBgoKBU=;
        b=S0mbiZGlHgNFeEr/4PxN0dU+KDFgIJpSeL7+EBdHBuZMTqMPew+/AvN9lnDkq98oFQ
         T6dPFc8VxDNGtAOpbnOD/uQjyfkljYlRq1687h99os0hw4rTe0Ra9nyMSahwaAyW2W8+
         SVxSHQRRRUrsClFKembWa0Qr9UMEUlg4x1ULOpJqSnfpXJNmRW/gsaXl4UDKLUgVpbu5
         E8uLWS/8IsUeG+UokKDpiidhaOdDr+mYoYORQolkyKkpUv4Q8W15LejwxU/jMxn8a1kk
         TcyuSklvW+UT4uphxfU++IGpT8LLkruM6JZf7V7rrs+38lsdhiTXFBpWxld5VqiN+xdJ
         wQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343751; x=1757948551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlk7CEaDWsusV6a6RSbZw0bpsuLPACNzKa/4RBgoKBU=;
        b=u3akM9UxPlq7G5kpQQnLgcYq77T2gF8WDL+zsuevYjRG17DNFOvpVTkPpK6vi6hgnE
         LyEI3oT07F0QHEzNP/l1bX+Pj2c8xEfYckJbjFOSU/K5tAoQaPofQRqDHnhMBgNMJVkQ
         T6dSd+z1dSx8LPh2uN2y4UotGSOLcXVrJiSaVUoKWHdVQHdg5ig1EBZam0Ijxrdwlyqv
         YGRohCLwYHMj6gLNSW3KuDFeWciT+s0VYfNHyYBvds6uQHGV6thfL4SMqTz3ueTUA3Ss
         +ONxSyInJ7bTOuTTB0U69LJN/idsUgW1vjydGFFzxnViAewZumV2GBcvYTkYAOenv/vC
         18ag==
X-Forwarded-Encrypted: i=1; AJvYcCV9bp37zqF/opRt+m5W6RX5XOo+XXTF1fqk267rvl/JFJkPwQxepKoahWwi8beUbkcStUZ0V11FAN+n0bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9867zFC7t5v2+Pd+SArJ1gEBaWh60ZKGyuzXJNOC7Je9s/MB
	8aZqhUZaxIly59ZhzkvXC0GINpTC4fSC934qLdRDI9xo60FJBaDCuMaQBrBztJ8FcH1dLQyyyZ/
	DWx/IRxmtZdYkblZSzEOaN8PFMA17Uhw=
X-Gm-Gg: ASbGnct610paj5oUATlOUa7t3qUlSfR3ZhRuPIFWue2VAaI1Xm8Mul8hiaaM9Eve0q+
	v1eslBjy6gOpBXgwkP6gBWoTsZmATUjbiSx7dAYYxb4NOjdiDoBzETTSq6o7bV0zPF5BBA1D9vt
	TO5CUQkdrp/7HvyftxrXrxo0Dl/bgbYPvhBOFv9ybIlSb0WZhXUL4lF2+S/Vcmbh7Prwl4n8fqL
	aFP0IQSSyh55oJhvbG5Jw==
X-Google-Smtp-Source: AGHT+IE8ci9wgo7APiSNqM5pwo2bPVDRU9k7EhSscWIVD5IILts7UIBnfP3kwFE0j3XRjRl3mJu0nnkQhDjsW8W/fiM=
X-Received: by 2002:a17:907:3e0a:b0:b04:31c6:a434 with SMTP id
 a640c23a62f3a-b04b106b9f9mr734265166b.0.1757343750496; Mon, 08 Sep 2025
 08:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-8-ryncsn@gmail.com>
 <84d3ab47-a960-4709-b127-ffbb8d85ac23@redhat.com>
In-Reply-To: <84d3ab47-a960-4709-b127-ffbb8d85ac23@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 23:01:53 +0800
X-Gm-Features: AS18NWBLumplG5EeNn7dHFCF9A5JT6QjZ8t-wBwCRBv-0-uNMUOyEV26HlI_I5w
Message-ID: <CAMgjq7DjVu5q2w_GaA075YLAtkS0yMKOyTiuwhmEDZQZjBC4Uw@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] mm, swap: tidy up swap device and cluster info helpers
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:52=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.09.25 21:13, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > swp_swap_info is the most commonly used helper for retrieving swap info=
.
> > It has an internal check that may lead to a NULL return value, but
> > almost none of its caller checks the return value, making the internal
> > check pointless. In fact, most of these callers already ensured the
> > entry is valid and never expect a NULL value.
> >
> > Tidy this up and shorten the name. If the caller can make sure the
>
> "Tidy this up and improve the function names." ?

Yeah you are right. Most names actually got longer :)

>
> > swap entry/type is valid and the device is pinned, use the new introduc=
ed
> > __swap_entry_to_info/__swap_type_to_info instead. They have more debug
> > sanity checks and lower overhead as they are inlined.
> >
> > Callers that may expect a NULL value should use
> > swap_entry_to_info/swap_type_to_info instead.
> >
> > No feature change. The rearranged codes should have had no effect, or
> > they should have been hitting NULL de-ref bugs already. Only some new
> > sanity checks are added so potential issues may show up in debug build.
> >
> > The new helpers will be frequently used with swap table later when work=
ing
> > with swap cache folios. A locked swap cache folio ensures the entries a=
re
> > valid and stable so these helpers are very helpful.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Acked-by: Chris Li <chrisl@kernel.org>
> > Reviewed-by: Barry Song <baohua@kernel.org>
> > ---
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers
>
> David / dhildenb
>
>

