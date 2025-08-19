Return-Path: <linux-kernel+bounces-775968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6A5B2C6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E183BFFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710AA25D21A;
	Tue, 19 Aug 2025 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GO5lo9RH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323992EB85C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613499; cv=none; b=mHTRoExKK8MgEsjgJQoSYd5L20I6zeUKFhDuUvpEjYaHlTDH2/wqYIoIsAfXLb3uRP6218OAokw91tF5ia2wF3T/n1Bk/sUSU+JI/lWB6kzogpCbhRPzjRRohGtBTRQRYb11zd2UNBpXtA6njo0P6Tro9ivWRnARB3sw/MiIgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613499; c=relaxed/simple;
	bh=0ewSci4kwM8psxpmJDgOyj1lMoJLg+oHg22M0eYrYNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXmYiUeJqyc383UEye0PYeD0v96NfUlEgOyV20zeN7SO3S1sIuc+TWNu7WiZ9H2dYvIamHmtGaDEX3c73Up0PA7adrA0lQ4/0j1JwZ8oIHZ6yZpjKpx8njrE6vJvKJne8UpZWiS74P9mFxjlOuA4T2Oud9aFyhzKKv+uEaQNSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GO5lo9RH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755613497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+6rtgrIobcRQVsNX25xQXMRbcgLTca8mFUg3pNO2o0=;
	b=GO5lo9RHF8c99I70sI0pKLdBGUFR639I9EF4bAl+Gb89YHmEbZQMG0+OcW/jdBz7SldjRt
	2xn+tO27syNmtKq7+tWa93WW/fjGHmTM4NOdaiy0w6a9vDOyD6O2xdaE13jE7A/6yQwVdU
	pv4h9Z03dKGyZrOaXsCV1NF/rforQCI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-stlBmczsODm9WUGa3K-6hQ-1; Tue, 19 Aug 2025 10:24:56 -0400
X-MC-Unique: stlBmczsODm9WUGa3K-6hQ-1
X-Mimecast-MFC-AGG-ID: stlBmczsODm9WUGa3K-6hQ_1755613495
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e934da9eb25so3752391276.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613495; x=1756218295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+6rtgrIobcRQVsNX25xQXMRbcgLTca8mFUg3pNO2o0=;
        b=tOeEcOybxQ1z6T112mC8d8IpQoIyX93yT7rK5Yd5Yk4pHDe1TDF8YmB/PV6Qw8a20Q
         9iDlvHICNWbAmxjk5Rn9JAhcJxpeD5N52SusF106Z3Exig24cbUIbghWquFgHJ+toRhS
         PYFg8L1mNQgBPNDQYO5rHKsEfxItlATSNA0zCSaFFKJ0Wgwqb/3J/NP2xz1+aKchg7/S
         dBHVxNmYV5hxfRozpMwUkx9c8/m6MTGioPuCwgC645EfforBpC5daYIG3o86POz8jfdL
         HzlNRokeL3BinDe/toxrg/FpNJF51g4vsfoHex4FFvzaftP2rstRtIUGMpQZRpuY+KAV
         Ynnw==
X-Forwarded-Encrypted: i=1; AJvYcCWuZNAjgSFjKVNg+sS4OurnAWiDvzEQE1UWYlxiClpIqT+rpLtPh0igzCYQK5yHECuAbuK36ckJDdNl9Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPanLl6ImZBVi10uOYEe73KtW/Ro8ZoTjzYSALOG1F/H39SajH
	1KBNxn4FDTd6x/NRIhVS4YylHSf0Ta6Nk+bGTL5lWOrC0zZ31uRngRcLjn8zDn20wS8l91/ibDm
	rjB+M9vR6C2ESiThILyCMr9S7R0D4tk2vqyrPB6IkeppLGpvKrSXYpr/BX5otendk8Pez0yvJB4
	a4zLhJ7nSq4GxWp7rTqmyWn8PzQp9FU7J92ewOApXm
X-Gm-Gg: ASbGncsjli5wyeAEGfXgCz3S1xwpuROBsU5XI9JCJTGOgdTJjeka3jgCZVEyWXvjjTV
	mlAzPVpTuf7QMzGja40DEMvgXM7ZTTLVvLnif/0/Z4PIz//Kk1t2HWv9fhQMg4nj4d8dBZ0IidN
	Vp9z6BM5kCW9XVD/AwpXS/c+w=
X-Received: by 2002:a05:6902:124d:b0:e90:6b79:23b5 with SMTP id 3f1490d57ef6-e94e6175edamr2941272276.11.1755613495472;
        Tue, 19 Aug 2025 07:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF0NyUe7/RofjcC4QixzaRFRmVdElcMtMYnzi+jpWMgZd139uXmHSJYXx/CbZFkRV3womoYTYYBMDs+rGHGVg=
X-Received: by 2002:a05:6902:124d:b0:e90:6b79:23b5 with SMTP id
 3f1490d57ef6-e94e6175edamr2941207276.11.1755613494924; Tue, 19 Aug 2025
 07:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134824.623535-1-npache@redhat.com> <20250819134824.623535-2-npache@redhat.com>
In-Reply-To: <20250819134824.623535-2-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 19 Aug 2025 08:24:28 -0600
X-Gm-Features: Ac12FXyGOl9R8GM6piGm3MATFXxEB46AmdLRhkeJHEPEb8_8zxs7ckcl8qzqEps
Message-ID: <CAA1CXcCBu290fywdxqCY=05ejSLL0P4z5KWRrMf2LRxz1VzYGg@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] Documentation: mm: update the admin guide for
 mTHP collapse
To: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 7:49=E2=80=AFAM Nico Pache <npache@redhat.com> wrot=
e:
>
> Now that we can collapse to mTHPs lets update the admin guide to
> reflect these changes and provide proper guidence on how to utilize it.
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
I had git send email error and had to resend this patch (13), but i
forgot the in-reply-to
please ignore this one and reply to correct version

https://lore.kernel.org/lkml/20250819141742.626517-1-npache@redhat.com/
--in-reply-to=3D20250819141742.626517-1-npache@redhat.com



-- Nico
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index b85547ac4fe9..1f9e6a32052c 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -63,7 +63,7 @@ often.
>  THP can be enabled system wide or restricted to certain tasks or even
>  memory ranges inside task's address space. Unless THP is completely
>  disabled, there is ``khugepaged`` daemon that scans memory and
> -collapses sequences of basic pages into PMD-sized huge pages.
> +collapses sequences of basic pages into huge pages.
>
>  The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>  interface and using madvise(2) and prctl(2) system calls.
> @@ -149,6 +149,18 @@ hugepage sizes have enabled=3D"never". If enabling m=
ultiple hugepage
>  sizes, the kernel will select the most appropriate enabled size for a
>  given allocation.
>
> +khugepaged uses max_ptes_none scaled to the order of the enabled mTHP si=
ze
> +to determine collapses. When using mTHPs it's recommended to set
> +max_ptes_none low-- ideally less than HPAGE_PMD_NR / 2 (255 on 4k page
> +size). This will prevent undesired "creep" behavior that leads to
> +continuously collapsing to the largest mTHP size; when we collapse, we a=
re
> +bringing in new non-zero pages that will, on a subsequent scan, cause th=
e
> +max_ptes_none check of the +1 order to always be satisfied. By limiting
> +this to less than half the current order, we make sure we don't cause th=
is
> +feedback loop. max_ptes_shared and max_ptes_swap have no effect when
> +collapsing to a mTHP, and mTHP collapse will fail on shared or swapped o=
ut
> +pages.
> +
>  It's also possible to limit defrag efforts in the VM to generate
>  anonymous hugepages in case they're not immediately free to madvise
>  regions or to never try to defrag memory and simply fallback to regular
> @@ -264,11 +276,6 @@ support the following arguments::
>  Khugepaged controls
>  -------------------
>
> -.. note::
> -   khugepaged currently only searches for opportunities to collapse to
> -   PMD-sized THP and no attempt is made to collapse to other THP
> -   sizes.
> -
>  khugepaged runs usually at low frequency so while one may not want to
>  invoke defrag algorithms synchronously during the page faults, it
>  should be worth invoking defrag at least in khugepaged. However it's
> --
> 2.50.1
>


