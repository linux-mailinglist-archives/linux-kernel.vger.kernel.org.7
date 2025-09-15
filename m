Return-Path: <linux-kernel+bounces-817279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B11B58001
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4407A5771
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B532F77A;
	Mon, 15 Sep 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUvH1+O4"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7433218BA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948936; cv=none; b=BctcJGscs2og6A5WIeyfc7T2PTA43LxdEeoUy09VUFKLbctpfUML8eJ2UG2NG2O7R1HOUnQ1kWChamPb9xvr6nVT3BLWlbOLF67lg8Ssk8WRkaiHFNMFg7SUxLqsdYUyxQMkZxUnzELBBay0q2nGIv6uN7DmfZiF8cVmV/m5qBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948936; c=relaxed/simple;
	bh=fpkLiRx4peIwEQMVeV0Sr+7DioZoAzUNHpOYmIWDnzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKEadSudsQDB3DDsXUBKbGwk5MN7OfE9BXbLv/a3PM1c20tBVE6jgLtc1OHhDhY6NOY2SCp0DZNwobLOmsj73IG4Ft778V5VUBs/p4Wkb5ZAhPds/9/XTt1738+wDKC00ruM2MprIo7dZo+OasSB9gPWqycXu8QYQuFWIFZ/Hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUvH1+O4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-723ad237d1eso39287417b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757948934; x=1758553734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwFsPBiwikLgXGeg1StWERPB9X7NSPvY1FsUVXJjxOU=;
        b=ZUvH1+O44BalJljNEHTYc+/MrA8qMiFPyepOy8Zd+88Zzi0Bqn0pc9YzLtH6CwoaS0
         QcePhbRams0AmmBTyyKZVhK1H++YzQEPKB3CUEiii6Jpiv7vNjT1oMzZ5F6Kmax37ebu
         /6+olLf4XsFuz/9vYQW8PogfuSCdShl6UDjV8DjBEXgJJP9qSj7E/a7Y/fKDaXu0sF8I
         uhhUxKozecuUWD1xx5vB4x20AoWC+BRaPni6r/aZDYwhADX1QHeodAWPiVYCWJ5zW/BJ
         c0KH15ooWuN03Wte9i7QvKi5KxDDaVkkcqGQ6Mam3bpEOBTgLVo1UQV5I+h/p1k54mtq
         wwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948934; x=1758553734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwFsPBiwikLgXGeg1StWERPB9X7NSPvY1FsUVXJjxOU=;
        b=VnEA7mtv2Xk7XZ3fFmgsibp2euX3SGEVqdocBfhUOWiY9mcfFP7MFaTNj7kjr+19Sb
         SK7HGATlr06Fe3Fx7DSNfvgwxVCDKpKXzxq2Jijgg+hNkYP7TsgiBw22EDrk5OkikK44
         H0GFKgM2y+VIBdUk5G6Msa88V43htkzjxaUlacDmaFBPYh/SnV3Hlq+Jv9ITYEGrlK9P
         +642FQQyXhuQLCWFuKTZZsPvYkZCQFKPGOmgsdwDlCzwXaBBegh+aOKYwZP7tGDH98ev
         z402LBJoRYD4tuqQVICERRjZhUlulukAtyPZ4apMKAv0LGJkE3nvkqoVNxLMoZDcjRt+
         8NiA==
X-Forwarded-Encrypted: i=1; AJvYcCVNXulF4ORoLMOueijJoWwhWCfb+kRxlu6X9YDEk+GsI/0NYKgXq7kaxnsHcIkLX5j+szOqndZmebMO0yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTtroCgtjGlllmyh0TItO7zXz5br9CU0bEWt3mxfYrqjttLGB
	EEJIoMEF26ygtuCqG8ZmNakktekV8dk92C74yMKnCVdIHSxBh1rXWfXF
X-Gm-Gg: ASbGncuoGp3Z2nYD6AMunpGSHF3EsxZY1oYZLoB+eRsFu9J+N1VGyYKAGiyy912cC3P
	PfbvFOAIWqi/AbEOMSUJiVUp4Kwp3O27G1mOxRPD2QIXngQMah+C5KaaG+y2TDLAkn5AK/qKicm
	+aW3ncPjx8JLzX7lEw4BI/SasnbtJhe2rzjFIfldCIfTXFpcxDB2HxVMQsU/eC9nESnetIf/JUB
	MmVJnnKnEE5mKvlbNc9ZZYRy7KvL2aazwEyRWR0V9pdn4wVCsACvVyekYCyVjUs9TSXfp1fOlM/
	en/LNcPWO1PMrEO2s/VzFKr8QGF7ZDd7kKMYdCyKPQxOIQLUvSQn31tZRG7ErnYV4WmMhJS7kF0
	GYL0jU2QCW7aQ94KxhMqJQ/bw4I3ZgJ6q1madPbi96cFBYdb/QBM/j7WbA04pK7Tx
X-Google-Smtp-Source: AGHT+IEoCH4/7SidphYGS+MZaTfXIWw2+iqeHbHWYFRR44N5J03EruPqOb3s6H+Eiuaqun0K37I/aQ==
X-Received: by 2002:a05:690c:640e:b0:732:92b7:8b88 with SMTP id 00721157ae682-73292b78edfmr55749467b3.38.1757948933883;
        Mon, 15 Sep 2025 08:08:53 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73453627ddcsm8002397b3.38.2025.09.15.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:08:53 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/6] mm/damon: misc fixups and improvements for 6.18
Date: Mon, 15 Sep 2025 08:08:51 -0700
Message-ID: <20250915150851.1508878-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915015807.101505-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 18:58:01 -0700 SeongJae Park <sj@kernel.org> wrote:

> Misc fixes and improvements for DAMON that are not critical and
> therefore aims to be merged into Linux 6.18-rc1.
> 
> The first patch improves DAMON's age counting for nr_accesses zero
> to/from non-zero changes.
> 
> The second patch fixes an initial DAMOS apply interval delay issue that
> is not realistic but still could happen on an odd setup.
> 
> The third patch fixes wrongly written code that doesn't cause any real
> problem but could make code review confusing.
> 
> The fourth and the fifth patches update DAMON community meetup
> description and DAMON user-space tool example command for DAMOS usage,
> respectively.
> 
> Finally, the sixth patch updates MAINTAINERS section name for DAMON to
> just DAMON.

Hi SJ,

I was unable to find this sixth patch on the mailing list. Maybe it got dropped
somewhere? : -) 

> Changes from RFC
> (https://lore.kernel.org/20250909034353.7064-1-sj@kernel.org)
> - The RFC was only for the first patch
> - Rebase and wordsmith the first patch
> - Add a few misc fixes and improvements for 6.18 to the series
> 
> SeongJae Park (6):
>   mm/damon/core: reset age if nr_accesses changes between non-zero and
>     zero
>   mm/damon/core: set effective quota on first charge window
>   mm/damon/lru_sort: use param_ctx correctly
>   Docs/mm/damon/maintainer-profile: update community meetup for
>     reservation requirements
>   Docs/admin-guide/mm/damon/start: add --target_pid to DAMOS example
>     command
>   MAINTAINERS: rename DAMON section
> 
>  Documentation/admin-guide/mm/damon/start.rst  |  2 +-
>  Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
>  MAINTAINERS                                   |  2 +-
>  mm/damon/core.c                               |  7 ++++++-
>  mm/damon/lru_sort.c                           |  2 +-
>  5 files changed, 15 insertions(+), 15 deletions(-)
> 
> 
> base-commit: d245e17d619ea0336d50b0a6c914f5701d1b0e53
> -- 
> 2.39.5

Sent using hkml (https://github.com/sjp38/hackermail)

