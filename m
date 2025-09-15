Return-Path: <linux-kernel+bounces-817329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE6B580C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6FE3A87B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A461EA7C9;
	Mon, 15 Sep 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhG8h3aj"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608FB3375C0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949954; cv=none; b=RqiUoJ1S7q/FsWgKKLKPN1UvE3TzmXSNICMh6V+zK7aoOyLSX1fwDQ6gSCQnio6UuydKDhMnbAMT3GSpZdfaJ+9TNArD8wxSlKlY4sGxnQfbZD4tG3Mxop5v71snsajTtyW2b/OnGXLMcOLnB/PGlixYQcmqtuEGV+n3lmZ/YqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949954; c=relaxed/simple;
	bh=bT79mZWoVpCNSPqKjzxE1zifFi0RNZXBKcyX9tuKui8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzdN4hAtfaOZsttljAzCHLoizgjCH+f+vR4zYcYcduqKx5W6GmHGpxhRNSrQIHw5amMQWqwpX2UxmiSWQ4Srry97WXSLMYBRN8F/woTk7wzGEyrnqBzZmN2QHKbGGark4iXWWL2iirk6tAaEZP+lNZkOe/dSFv7VjnwK4nR8Qt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhG8h3aj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b7abed161bso7330861cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757949952; x=1758554752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twOjmxypi8F5/wktXXyH6UWMyBziK0bLBGe5jYGqXDA=;
        b=AhG8h3ajwT2Xhbx16fjiOfnh9ZjxkUA4BhjUFNQmzLUHq+utrE90Ynyf6Lo2cTeAGN
         qannMeOFKPqKKw0cEl2OWUmD+oklX+N9uPMMbSEkOa3RHLI574R6/jjpuLfXxMQ2sxjk
         LYCyW2HB+WFlovYXe5M3OWZFJ+KrpW9gqELLSaLOhCaOSocZQ+Fcr0zOd+NMuwruDxsz
         VBzRT32aBHlqatiG58kLex/3NbNAmkkdyuOVpMdwJGBUyIMFlGXtn8G6tCAkcNN9FmDs
         IshfONhVTrEvoo0jplLT2SQidvgGR7hKY7gWzAvMjr6f7LzyuINDnPZVnWH1+l6Df+uo
         baRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757949952; x=1758554752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twOjmxypi8F5/wktXXyH6UWMyBziK0bLBGe5jYGqXDA=;
        b=LFL7CY7+5+7iBtetOiAujL1+jDjQlox9wM8jgPNl46RmVgaf6O3tJbU/3p2zm16PVo
         ZdUIl+fRQ9bDBXvkUv+GixRhiWNPikmJSr2KOjoBLzs+8pAKZls1YtWBQtcw67LdueXa
         kanpNB0I4bLHdOwlU07c/i0g/lfOqDpwB1kNUVmWu3t0U8CEltB7cI3v255ISUfXA0FT
         JJq8/MYe7xiW4m3N5kGZDiK/Ne+e9CBpNpsRs8SUfbMN9Yh12UkjxPzQaIzJc/BYdJ8s
         r0pEeSUF5mvlwHcqwG8NJJS6a5URhTWpgzhAXMbcR6i1QEsERir+zkpw6IK5p//NUGLl
         WDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU04EDMvAQfhdwkVrMrVgNjFeU5YvwWdYaypSDqWgtoqtPz9rbjwD9F3i2e5Q2Lp57qjm2Vo9SaC2sSWtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL90kHZHZg8Rsuyl/fJlMB+MBftvY4bKENGtpm/1LjUIRkkGpY
	I1wJ9KMzVktvmq4PilY6e7WwVWmm+qvsUvIfnC0F7vCI/Rnkpy4EbbirAKfte4esNTUX6laqtlE
	hH/3OG1R8TMcYuah67GLRVhK+T9h4Yww=
X-Gm-Gg: ASbGnculII1RAD/5SLUtH6cc1dvjoh1WTJ2IH6ac9FjIN1M7UZghgYMLtUxoyudGz8G
	an6bNk92f1B0IhrjmlnFIFTLGBOBzScdJI8qEZ8DHKLdj8E9kJmekzzaCMPXHC/uiHePCr8/WCl
	IkNp5CN1Zvalz7Ibz7immKnA2szTYH+rgEOC4SPXx7DzWKaMUs4s1uAO3KKYTFn8yLN59zkbewu
	DV+b2f+AuYxmLv78ldsbbOgcPz8YVEW3nqHx546PmY91Svw1TU=
X-Google-Smtp-Source: AGHT+IG0lj4OHOWbpCyzpHkhetLcDU4pJdQ9spR9svWGOUH3xKPwb7pLVnXSJvywltfC7gPj6m2GvwN33sLw0OSiuQ8=
X-Received: by 2002:a05:622a:a19:b0:4b7:9f68:52d6 with SMTP id
 d75a77b69052e-4b79f686bfbmr58374191cf.9.1757949952122; Mon, 15 Sep 2025
 08:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915015807.101505-1-sj@kernel.org> <20250915150851.1508878-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20250915150851.1508878-1-joshua.hahnjy@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Sep 2025 08:25:40 -0700
X-Gm-Features: Ac12FXzQhzLPiwahg8l4GbB3zTsY9ipEubXDL1xh87e6emG51matFCCQ0FbehiY
Message-ID: <CAJnrk1ZHdt-sj4n2VigW6u6bnd-gX47WpUfaHDxqN1BH4JGUXw@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm/damon: misc fixups and improvements for 6.18
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, damon@lists.linux.dev, 
	kernel-team@meta.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:08=E2=80=AFAM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> On Sun, 14 Sep 2025 18:58:01 -0700 SeongJae Park <sj@kernel.org> wrote:
>
> > Misc fixes and improvements for DAMON that are not critical and
> > therefore aims to be merged into Linux 6.18-rc1.
> >
> > The first patch improves DAMON's age counting for nr_accesses zero
> > to/from non-zero changes.
> >
> > The second patch fixes an initial DAMOS apply interval delay issue that
> > is not realistic but still could happen on an odd setup.
> >
> > The third patch fixes wrongly written code that doesn't cause any real
> > problem but could make code review confusing.
> >
> > The fourth and the fifth patches update DAMON community meetup
> > description and DAMON user-space tool example command for DAMOS usage,
> > respectively.
> >
> > Finally, the sixth patch updates MAINTAINERS section name for DAMON to
> > just DAMON.
>
> Hi SJ,
>
> I was unable to find this sixth patch on the mailing list. Maybe it got d=
ropped
> somewhere? : -)

I'm seeing it show up for me, this is the link I'm looking at
https://lore.kernel.org/all/20250915015807.101505-7-sj@kernel.org/

>
> > Changes from RFC
> > (https://lore.kernel.org/20250909034353.7064-1-sj@kernel.org)
> > - The RFC was only for the first patch
> > - Rebase and wordsmith the first patch
> > - Add a few misc fixes and improvements for 6.18 to the series
> >
> > SeongJae Park (6):
> >   mm/damon/core: reset age if nr_accesses changes between non-zero and
> >     zero
> >   mm/damon/core: set effective quota on first charge window
> >   mm/damon/lru_sort: use param_ctx correctly
> >   Docs/mm/damon/maintainer-profile: update community meetup for
> >     reservation requirements
> >   Docs/admin-guide/mm/damon/start: add --target_pid to DAMOS example
> >     command
> >   MAINTAINERS: rename DAMON section
> >
> >  Documentation/admin-guide/mm/damon/start.rst  |  2 +-
> >  Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
> >  MAINTAINERS                                   |  2 +-
> >  mm/damon/core.c                               |  7 ++++++-
> >  mm/damon/lru_sort.c                           |  2 +-
> >  5 files changed, 15 insertions(+), 15 deletions(-)
> >
> >
> > base-commit: d245e17d619ea0336d50b0a6c914f5701d1b0e53
> > --
> > 2.39.5
>
> Sent using hkml (https://github.com/sjp38/hackermail)

