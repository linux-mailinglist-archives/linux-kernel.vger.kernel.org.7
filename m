Return-Path: <linux-kernel+bounces-796855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA06B4086F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA3F546416
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7BA2E0402;
	Tue,  2 Sep 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtxF4UWV"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA36A2EC098
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825423; cv=none; b=haRcMqbrN7sJj3QEHRm1WsTi/hWOLNwrCRM3DSfkfQgoSUFhUUYg8KWKlGhTZVMdIiZ0uYFBFvzaZYQwQFG2qMp8DNFjiolW/k02ybGGaiFOMPM6m5mCRBOC0lT+dBVGZp+6FP1YVzUuJHXXoJ7K9Kx/ZlHAmA21bKyTeb36qqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825423; c=relaxed/simple;
	bh=P2EDErnRMKsMMVV5N3TFtUBYfdCq51q/XvrALwUpe2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ke8weOgAITRUJHDFZ0EosEn2qDIyG2V6lTBilYk3xZ7Vvny1Q3hx0w/377O90hSJ4irFAB5hb9oYGKyAI/lpmAZek2FpcIj5R0I1oI5k0aa/M9oCMNqa8o197ube8tbyRriDeRGKauXEeo+OQ54iDVJnKehDqbRO7s26xPA7Xaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtxF4UWV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61d3d622a2bso3179049a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756825420; x=1757430220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2EDErnRMKsMMVV5N3TFtUBYfdCq51q/XvrALwUpe2g=;
        b=VtxF4UWVglgW8mMNIbvSOvP2SnaxzoV9wNtJJAK2AO3PD+DbCxovqP5QpOH8I6PS2i
         Ic50d5W8dSaBc0pJUfHOFx05azHeivxVymh1osHB+wjyzwPixB7xRt0SWB7tAN/bsaWQ
         7EyYxmtOB6pmskpZYN+m2OmGjUzzf7YVSJAaeQwOxujKjqNWtks806XQtXwrKQyJvJ7b
         2O/Jmssq0pFQeIOtuGrtGKV7BFupH2r88Js4DMzUWbsQ3Hc3XM+VZhzdAMoyFm1bv6GK
         xMgPJPwXo1PmQLQIbMEBHbithd7/ZEabyn7xkIRuQGKG8t1mhPxOUID4YEUcZH6eAoe2
         7ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756825420; x=1757430220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2EDErnRMKsMMVV5N3TFtUBYfdCq51q/XvrALwUpe2g=;
        b=wZYC5rstXh9pC7eyMU0cd6puaYbAxsoS8WcvhdzmqVpwRj2xUaV+TXYFbqiQRAz+Nn
         ehw5+tK2TEz3i55ZlWecvA5dKVqZreO9Ij9Gpeg4xesicqr6gfNpJ1mLx3z7kRCP1ubR
         iwt7W30dnwwnCbXicB6h24AVSTwex7McECZzZsw7OCRLpfS3kbWgDJbnLcWMqub2Q8hL
         qcaEzCFgChAPSxukHwxV1zsN5pJTAN4dyPd+U8Ev7RT19B0yyIddwx7x36H8Wd8VjC70
         DscEmLAMvUBDPmVY2Mx7mhVvb6HnTg2XdBmtO/TxEWPH9cto9gI5OVh6A1vHtlrhPC8V
         ye2A==
X-Forwarded-Encrypted: i=1; AJvYcCVPbNc2lzmBm3eMWqd3dbAh6ItQsrXgyo5QtEn084Bh2Q83qxyx/VRjBLr8iAacXhM08ZOfevx+dn+NM3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJUufNOycmGnC3XfdWTSzv+ZkeYjVmgQor6jXi1dQ6IYNk6AN
	rauu6kKBAHooVHx6RxY1N2NqZ5Mgui9j+QfLr5UqZXpqlofjSXkI0TL7PNPYc11dZHnUtQAauQu
	wctOuPIwxqh87cjSKFgOlb5uqp5bcRk4=
X-Gm-Gg: ASbGnctze7jLfQIcwnsSB+01BQRTg7+2TEMpRgQPKsfVCAvPOPttJmEBxGrhjhmoxcp
	n8JsEH7WkFf/6dCsXYX3s+kDXMwq0hg3Iae+KdujVfycDl2iBKPE9Zsm2HjeJfe3O5pkP5NBDvI
	8wJwIpXeIrXMB07qouprUHHFFN2ZSS2v0DqPuh8P/TfN9yCAQIIMBkin31WKGAKRwZBIaxwjX71
	vWMMkuxQbI8Zxh5eEof5Q==
X-Google-Smtp-Source: AGHT+IGic/23QC4PUaC2yRhDBJYKR3DZQxhhPkpq1/vUXqTgg/aJ0G3deqGBUo4Qbc3UlNDsDUlBss+j9wTnIEZqAls=
X-Received: by 2002:a05:6402:1e8f:b0:61c:c034:10cd with SMTP id
 4fb4d7f45d1cf-61d26d5bddcmr10375580a12.9.1756825419732; Tue, 02 Sep 2025
 08:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-5-ryncsn@gmail.com>
 <39087ce8-6f6a-4998-95e4-813e265318d0@redhat.com>
In-Reply-To: <39087ce8-6f6a-4998-95e4-813e265318d0@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Sep 2025 23:03:02 +0800
X-Gm-Features: Ac12FXyLlzKHhttNr4D3KBMcouTB4kzGccaupNNYaebeIQscQX6NJ_SHFlbVOJc
Message-ID: <CAMgjq7C+mChdnbcrYEkKyuuRN9-THXwBdFeCVwvW_m-_CWCzvw@mail.gmail.com>
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info helpers
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

On Tue, Sep 2, 2025 at 10:14=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 22.08.25 21:20, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > swp_swap_info is the most commonly used helper for retrieving swap info=
.
> > It has an internal check that may lead to a NULL return value, but
> > almost none of its caller checks the return value, making the internal
> > check pointless. In fact, most of these callers already ensured the
> > entry is valid and never expect a NULL value.
> >
> > Tidy this up and shorten the name.
>
> Shorter !=3D better. But yes, "swp_swap" was a mess.
>
> > If the caller can make sure the
> > swap entry/type is valid and the device is pinned, use the new introduc=
ed
> > swp_info/swp_type_info instead. They have more debug sanity checks and
> > lower overhead as they are inlined.
> >
> > Callers that may expect a NULL value should use
> > swp_get_info/swp_type_get_info instead.
>
> High-level comments:
>
> 1) I hate the "swp" vs. "swap". Is that a valuable distinction or could
> we just convert it to "swap" as we touch it?

Totally agree. I was just blindly following the old style. It's kind
of confusing indeed.

>
> You're converting swap_type_to_swap_info() to swp_type_to_swap_info(),
> and I am not sure if that is the right direction :)
>
>
> 2) Can we just call it "swap_entry" when we work on a swap entry and
> "swap_type" when we work on a swap type in the function name?
>
> swp_info() is a rather bad function name.
>
>
> 3) I am not sure about "to" -> "get". "to" is much more readable in that
> context and consistent.
>
>
> 4) swp_info[] vs. swap_info() gah.
>
>
> I would just have done:
>
> swap_type_to_info(int type)
> __swap_type_to_info(int type)
> swap_entry_to_info(swp_entry_t entry)
> __swap_entry_to_info(swp_entry_t entry)
>
> __ are the expert functions where we don't expect NULL.
>

Thanks a lot for the suggestions! I also like the idea of using "__"
to seperate the non-NULL version a lot and implis the caller have to
careful.

My concern was that names will be getting very long in later commits
following this convention. Which is also the reason I want to shorten
them here.

A lot of SWAP relate operations will be cluster based, so it will be
very common to get offset or the swap cluster from a swap entry.
We will end up having a really long name like
__swap_entry_to_cluster_offset (convert swap entry to offset inside a
cluster).

Since we already have the swap entry type called `swp_entry_t` and
helprs like `swp_offset` and 'swp_swap_info' that convert an entry to
other swap things, so I thought that anything converts swap entry /
offset to others are named `swp_*`.

Maybe a bad practise here, we can fix it while at it, or at least no
longer introduce more confusing names.

I can follow this suggested style, will it be a good idea if we have
following set of helpers?

For swap cluster and swap device (swap_info_struct):
swap_type_to_info(int)
__swap_type_to_info(int)
swap_entry_to_info(swp_entry_t)
__swap_entry_to_info(swp_entry_t)
__swap_offset_to_cluster(struct swap_info_struct *, pgoff_t)
__swap_entry_to_cluster(swp_entry_t)

And for offsets, we still use:
swp_offset() (Existing helper)
swp_cluster_offset()

Now all swp_* helpers are pure arithmetic operations (we just renamed
swp_swap_info which seems the only exception). Is this better?
I'm open to suggestions as I'm really bad at naming things :)

