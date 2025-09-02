Return-Path: <linux-kernel+bounces-795592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7117FB3F4EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C4D189E399
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7662765D2;
	Tue,  2 Sep 2025 06:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvYjGfG5"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FA1865FA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792945; cv=none; b=CNFNR/hb0edRkg+BWXp7D7r1VMytd3PY37Giiud6ph4kFd1psUqnIFQTwYRgbcSc5X42qRKTy62UI7dO404UbZBnueWSmGlhsaPwGNLW69DKdKEzNccWIBUq93JCZIqPOtuMxk1t2KnYmnrEh4G5GNST8+XqjIVC9Yqr2KE27EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792945; c=relaxed/simple;
	bh=oEAeyE+0TMUw/irMNV6HSXBtMni9AHV5BLdYl0T/KUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THcALWEgmgJI/IcfRUpAn+agHL0Epns0xXirjIxI11tg+/Hi7IjBowsVe0aBNDF46pVeAEzWrYS3l5WN59fk4V5XdVDo5N5ega4uP8r6+5EUE32i+YXxnkmPlBlLnvO+DMl6DnCW5Avo7JrYFImPY3lkxcVcTnWCmDs2AcqaWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvYjGfG5; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-52af5df0fdaso900174137.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756792943; x=1757397743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEAeyE+0TMUw/irMNV6HSXBtMni9AHV5BLdYl0T/KUM=;
        b=lvYjGfG5ZmEa+QSNEA1CpgRvsoVqLh1LPKMDK8szSr8idR+bCzWZAt47z5IWZQ3SzO
         n0gbaDY64vfxfDo9/QDh4MvkZ8MCDoQmnDhcvh2EBkfg0T7ftvLhUxUjYehuJ14Fhme/
         JxacWUd23rEzTXlFne6tsk0diMnPRkjnd+Gi6bg5NFLfq8ZWd2Wh6p9yqgISyFYi3LZb
         K5vpar4f7/pEIqG5qsPvHxonxlpPsdNP2WSXCAWZM7hhc5zKGWEnYZTmO0SkOP5FH6b1
         fvqA1rSDFHHn+97kjCUUaytZ4aL/uhL4aKiE9z4at6VPa9+4LlFKG3fp1gBN9s9Ssssl
         jtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756792943; x=1757397743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEAeyE+0TMUw/irMNV6HSXBtMni9AHV5BLdYl0T/KUM=;
        b=RmcD/1CIQ+ISA52LnoZecby4NDoCHY8PGxxf2GvNlFo0x6ck8jHKspok4t4/AMh/PJ
         FP7mRYO+4rUZXNqPbwdz+R3D/4uw21UsLIo1XyBvw3KhmDwTrWPrAFAhw9nq2zRv8mxb
         4Bp1UPZcHQ5gap2aztfMGraOAGeD/quTc6JgmU0yTrG1cCiuz+u/DV6suGK63e4WaqzQ
         zC3geWh3BKTaVOXBTw2zFHAuD+7uTKKon0FQHeceLVm6BzMShzGVsqNoy6t8NevZf/iD
         OS9hHWN50/S7zwSEeKUFSBt5wPeQnEGYP/AwP79D9YSvrlPe/y+EC197eblsE9BWqqGy
         PaHA==
X-Forwarded-Encrypted: i=1; AJvYcCUm4tGOlWyTbyFRCivipYHOpmp47AYcQveUKFianl2wVmoZuIOfmGwc01RNQniGwvaodKH9jHSVHN0SXto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpnF13J2eDe0oykzTHRQe97WmIh5Yi957JHge9csFSBb7VdAo
	4jyuLjDrKhKH6RuX0V3s8hFocAbymJRwmSk5uNsWmmmbVJhus9uZYY+moewaTdGKTL5Avu9IYHf
	wUfNXn4Fx8znXpLECbXH+UAZaA2peOYM=
X-Gm-Gg: ASbGncvG5rIEPoN44Qf4otcTEuw2zUK5iA3z7lkKBz5Lj75KHOWwy11+h26jp2k2Krj
	K9Oa7Lx7edCvBPdyMDwXTgEXVDYo0yipdCwR50zet2ateLl8g2yozhuQSpFfwd7ydoZMClH+Iij
	T0PEzl7C5edvYgBQmVhWAJKoyb1wIYQfGmoJnXd7ndCu3VxQ8oRH4W9RTR7F7ojwZhzzg73C4EO
	zvYD9ZQ+JOqXvOPLw==
X-Google-Smtp-Source: AGHT+IGnwmcDmk8tkNu8ZMJm6ZsY7tfwmFtfX3iDmwqaGXfOTfaCTjxC2YY9IZQZ4cqZF+eaCLbwUNNJLGjkb9hJJuQ=
X-Received: by 2002:a05:6102:5a8c:b0:524:c7ab:6bef with SMTP id
 ada2fe7eead31-52b1b809c7fmr2467918137.22.1756792943133; Mon, 01 Sep 2025
 23:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-5-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-5-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Sep 2025 14:02:11 +0800
X-Gm-Features: Ac12FXy6wS36mbX9MClREZ2t1AIDNIXLnTjeeWyfWCfJkczN6t5IXfD0myHNP7s
Message-ID: <CAGsJ_4x8fgWchmf4C8EvVK+aSK7gZRKzp9h=z0V_RpD2TmXaOA@mail.gmail.com>
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info helpers
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

On Sat, Aug 23, 2025 at 3:21=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> swp_swap_info is the most commonly used helper for retrieving swap info.
> It has an internal check that may lead to a NULL return value, but
> almost none of its caller checks the return value, making the internal
> check pointless. In fact, most of these callers already ensured the
> entry is valid and never expect a NULL value.
>
> Tidy this up and shorten the name. If the caller can make sure the
> swap entry/type is valid and the device is pinned, use the new introduced
> swp_info/swp_type_info instead. They have more debug sanity checks and
> lower overhead as they are inlined.
>
> Callers that may expect a NULL value should use
> swp_get_info/swp_type_get_info instead.
>
> No feature change. The rearranged codes should have had no effect, or
> they should have been hitting NULL de-ref bugs already. Some new sanity
> checks have been added to the debug build to catch potential misuse.
> And the new helpers will be used by swap cache when working with locked
> swap cache folios, as a locked swap cache ensures the entries are valid
> and stable.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

