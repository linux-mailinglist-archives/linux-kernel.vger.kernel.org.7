Return-Path: <linux-kernel+bounces-817272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EA2B58002
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB27E4C3915
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7453431E2;
	Mon, 15 Sep 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNGDXU4c"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EA341AAF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948828; cv=none; b=Gkky+5XvPsQJxIGqiXj15gdTO7fqMEij6d6CsZdpU6z5myG9oGDBNKeu9HNUp+c2dcb6T/bOMtBlg9EgBRKc3WqLOuyvimLvOeZw8l645+vuSaPJT61UaTbmvNDsiQFVsZB83q6TPJV7wDKGVU4AqG6PIVByDZb6HYIAw7z1g54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948828; c=relaxed/simple;
	bh=mvhyhVaE1NgOtTceXq0ofadHYAv2ARkQsHSzvKbsxAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOdSmSa2Pfi+scLDZ+XfhzOPB+EeahGdPSqsyBArED4qP0MG/pgDCwc7bdbrJaYuQ1136QmHE+pvJ7svaDTdNJkR5JMP+KzEuLVf9KTi1n2bw/1HLBJQ9Ol40SzXG82GOSeLvrBDVdKL497G9tVeZ7z5+1yS7ZTr31P8K4LtwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNGDXU4c; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-62bbc95b4dfso888091d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757948824; x=1758553624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDVeU4L3YG1TiJ1MEpll75Z/ltEov2CndLJiRR2rTQE=;
        b=cNGDXU4cLMphcRFCN8Amu19B7PiGR84snnbKi6b03nPASBmKDYxWygDtCTMy7CoQ/c
         BQqpXggPD9Ba9nr0NhW82sjz25XMhvoXrgujw59wNecm7ftXx4bROU5UAOsTCUjvXmx5
         mcsIVhbMjmmvEH7usHmLFAQEfeRT+OIjKGpei684vmzLVucuee+1XeEoxk/Mk2VuMkvD
         /jrOufQQe+mwh/TaedkcmX2Hsd4PPS0Mghs8hIQInEODJopGp5Y42Y/ShcVisGzXMpAn
         WQELI82FE7p61lYM8htFC/ZSHghYlJkuhaY9/DIxhKNO9neJcv1heARpaGUoCnOfXMwE
         G1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948824; x=1758553624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDVeU4L3YG1TiJ1MEpll75Z/ltEov2CndLJiRR2rTQE=;
        b=YLv1dm5e+tS8vDF3zDVVIFwQ0X/gv8stQPhomxf+uQTTouM1srr1CS1SrEOgk5qYWP
         9zV9PKIrJmA/Usk+q2/vRRylweWcUOIL9UdaJXRijepgmaFkxzIqcu4MZ+r9uXcidL0W
         okit0Nk7UnD/Sd+03eDhkdC0igpy9ZI1Kh1DGbRyCr0PErSjff4QEdvijqCFPsXjdjRY
         4Ud6FS8jLjnoTYmL/+RTax71RWDjFmI6gwvqJbu8hBhk8mnqgp2DtWPGvu0xlKyi/T4F
         +klYwzSlg8zVIMn5ol4TAWahTw1bCPiFdW+dQktGyCtUu4ZG4PrZFPvw24E8BzVmd/4V
         Jw6g==
X-Forwarded-Encrypted: i=1; AJvYcCX3y4OKDIKdoRJa8wmLsbW2DnWNFlowbKqBykNL6MLfMuBOvy0gRL+PP4i+fyj9W1o++fS9GPKi0B4TUE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3A4OTx56QAZlpjX5G8k/EbGzMoGK6hBLbEGwxtWJ2TGadnSIT
	Breto3M3hwbRrvGKiVGYDTfYefxxUhLI1yOXCkt5xwsAm5pKe1d2zHelgsNJ1A==
X-Gm-Gg: ASbGncsPtCs5uSZPpUCWEuJphdrrMUALa3iElFMk57kIVRfSsyHubQLZi1LesIYNHCv
	x4bQwqiA1b9cik0A22j32v8SNxkKXPogF76cxbhwdWBcaa5tCJkL1K1+l9yv6wgPsDSkX2ojppp
	O8PO0B1fT03aQMF9kNG8q6aupe68lCRkqvX1wQFqrKB4mBp1egQntbdix3ngDGFtwHp1K7oRyer
	uYpv6U+EIkv0VlFivdScofLKe0rDIG+gjOEPm8kVo02F0PTdVbujJOF25WORD3dXVnEaqSJMNoa
	ywI2ewRQhiT3UkiwBVtRHThrGL/7fUO4F5zCEu3xUoJCCTLYnJvgS9dcdG6sNBNZq6eMP/GDm3K
	nmWLWB1u33PRtE5IktJ1WW/uYhuA9jkmwitsoTcO19x8Rw0EO8JoKCQvFE18XliKo
X-Google-Smtp-Source: AGHT+IH7pt4IX2Xw7+CU3ZHlHQK6hR4lJhRz8r+4QNMMkKKZ9nkGgDixZer0GbSaS8MxEPVoUip+3w==
X-Received: by 2002:a05:690c:3388:b0:721:5b31:54be with SMTP id 00721157ae682-730650e0036mr114848797b3.39.1757948824149;
        Mon, 15 Sep 2025 08:07:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76238392sm32913737b3.1.2025.09.15.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:07:03 -0700 (PDT)
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
Subject: Re: [PATCH 4/6] Docs/mm/damon/maintainer-profile: update community meetup for reservation requirements
Date: Mon, 15 Sep 2025 08:07:01 -0700
Message-ID: <20250915150702.1499965-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915015807.101505-5-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 18:58:05 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON community meetup was having two different kinds of meetups:
> reservation required ones and unrequired ones.  Now the reservation
> unrequested one is gone, but the documentation on the maintainer-profile
> is not updated.  Update.

LGTM!
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
> index 5cd07905a193..58a3fb3c5762 100644
> --- a/Documentation/mm/damon/maintainer-profile.rst
> +++ b/Documentation/mm/damon/maintainer-profile.rst
> @@ -89,18 +89,13 @@ the maintainer.
>  Community meetup
>  ----------------
>  
> -DAMON community is maintaining two bi-weekly meetup series for community
> -members who prefer synchronous conversations over mails.
> +DAMON community has a bi-weekly meetup series for members who prefer
> +synchronous conversations over mails.  It is for discussions on specific topics
> +between a group of members including the maintainer.  The maintainer shares the
> +available time slots, and attendees should reserve one of those at least 24
> +hours before the time slot, by reaching out to the maintainer.
>  
> -The first one is for any discussion between every community member.  No
> -reservation is needed.
> -
> -The seconds one is for discussions on specific topics between restricted
> -members including the maintainer.  The maintainer shares the available time
> -slots, and attendees should reserve one of those at least 24 hours before the
> -time slot, by reaching out to the maintainer.
> -
> -Schedules and available reservation time slots are available at the Google `doc
> +Schedules and reservation status are available at the Google `doc
>  <https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing>`_.
>  There is also a public Google `calendar
>  <https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
> -- 
> 2.39.5

Sent using hkml (https://github.com/sjp38/hackermail)

