Return-Path: <linux-kernel+bounces-744786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD00B110F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875A8189671B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D2420487E;
	Thu, 24 Jul 2025 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtLjUBVK"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11242B9B9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381962; cv=none; b=JvX1AIEcphbNO5YhWix2sVlqJGcqvapcAO/1ORbNmUMabqvoLcjI1kJHPbjFmJJDm/3wb4Fr0Tmz7uz0oaPA2igvZJ6gkooKczl7ngVmEUVA5A5dJf5B6S/kxLxmoNe3qmWdv6MtmOEK1nTk1it8gqdXDlhWw+n1n2cOBmGkZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381962; c=relaxed/simple;
	bh=GmbiL8iYCG1UQmihDFnlY08O2Td3VL/UPhO2brn2dvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6h0wpucWTe9OajBFjzBmi9L8ZLjxerC6fJyn6j7HAmK11l9/UoeNgzFMdQj8lBWXw80qRQIjOxpyX82r1gZrojWF4MPpPzvosAwuyJB1f/Zsvzd9dV+LaB3x0yzO5KvvqvMdcDIZesC+6dWzGYzKsRRnZc0LDYcuZ1bYzCAL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gtLjUBVK; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ffc7c708a2so39374fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753381959; x=1753986759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30rlnSB27npgJWbqBMQFO+7pkMsstYfilIqdkjSj02k=;
        b=gtLjUBVKUNyhr6hxiQQtTRj4OhnLwITT+75wz9PFroSHtXyNu7PamlIDqOkDB0tYth
         zIFmC0PThdv+KILnfkDASfFo4PO80DVZGII8M9kEagtr8EwQ727mECuRsmgcUZ0tc3kD
         h+JNpNK1n+y3QIz9l4ueg0eZrbVtt2cynZosI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753381959; x=1753986759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30rlnSB27npgJWbqBMQFO+7pkMsstYfilIqdkjSj02k=;
        b=nWyPh7tNcM5gU8LX0iYzoYPscYf1Omz3s/b8g6D1fnj2Y0t27f6oJsH+rMWJmRWOks
         E1yjnpUBOZYEp9gq5JyRS1y6qYcVej0g6D7TY+T65fco0L1r8kuSOg4nVihXboyNrMFY
         TAoPRdYEPN9HBCUaCS2Dez88v5l6TmdLehR5H2KQA9aiKTG2YrRyVgjhdWB5k3jE05ZM
         qPC8l2dUsPe13jfMMFGCfXPG5VBKyH3GwI07EhU+q0b5c/MddbeU8oPq1X3Aqb/ie4TZ
         c1iFXc3fU03R2pz9rrwCnsJx56wx2rHxCcoKB6uOErpLs5u+TjFS/OGe7AdANYoK/mxT
         Ykbw==
X-Forwarded-Encrypted: i=1; AJvYcCWJbOAUI9f9E3WQuYMmlQN/WuwdIlY40YXTN4+7l0Oc4erq3cEWe3s1+SpyZ969uKbjirPrGkvd44ne6uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBXcSGlPHhIPRdFEbdjt8fXV4+JJ1Eh82oODr50bQaQx3Dxvq
	RGZJqSSl896shUGk24WubL4ImGCK1Ru0/Zl+Fcj//aJ5nODns0ox2jN3qAXQPSIcT0300O+5bxg
	zNWMu6zZGL7N5nU2gTXXv3muVXixRIe0nWwUW7hCw
X-Gm-Gg: ASbGncv8w12+bxaRI0FYR7EzInlX3Ebk7+oZM5aL1Rm0+UnssCm7YddOB/MV8u3t/ze
	sHBI8Ddf+ULjQDYrAK1EJZLdLjNi3niX8JdQ33E3wb6c+jLrnA0vVpYzgvBMeIW52aQcGa5TEbi
	oPRZyIWaaFbU744ocpkkS/pptaGufvJjdR0iuDF2ZaXeqO7jMQ+4E+PEwppE33Py/5xZJpekPT0
	rh0yVfeq+6Q8KG+2LlzeLWuy6Z7KFZDlQPZ
X-Google-Smtp-Source: AGHT+IE/v8/QcDYMq5rcXlGAzua42CVQDWzWzn2XXU5Eo9ZmM+YPZpj2WCQ58zMFcZj9ilRciyOvuOU/eAmRuaHjmtQ=
X-Received: by 2002:a05:6870:bb17:b0:2d6:1e7:f583 with SMTP id
 586e51a60fabf-306c6f2f38fmr2016132fac.3.1753381958752; Thu, 24 Jul 2025
 11:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:32:26 -0700
X-Gm-Features: Ac12FXzJWfvxsyQk1Xr5HsYL_xRb49zP3u1pqHeWkzOCB4ps3luILJW3LOiNn98
Message-ID: <CABi2SkVVswRr+H5OWRcbFQSLq_457a0eXwn0OrtkcMEbGphz6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] mseal cleanups, fixup MAP_PRIVATE file-backed case
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

Thanks for including me in this thread. I've just returned from
vacation and am catching up on my emails. I'll respond to each patch
separately in the following emails.

Could you consider adding mm/mseal.c to the HARDENING section of
MAINTAINERS? Please include Kees and linux-hardening in future emails
about mseal - Kees has been helping me with mseal since the beginning.

Thanks and regards,
-Jeff

On Wed, Jul 16, 2025 at 10:38=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Perform a number of cleanups to the mseal logic. Firstly, VM_SEALED is
> treated differently from every other VMA flag, it really doesn't make sen=
se
> to do this, so we start by making this consistent with everything else.
>
> Next we place the madvise logic where it belongs - in mm/madvise.c. It
> really makes no sense to abstract this elsewhere. In doing so, we go to
> great lengths to explain very clearly the previously very confusing logic
> as to what sealed mappings are impacted here.
>
> In doing so, we fix an existing logical oversight - previously we permitt=
ed
> an madvise() discard operation for a sealed, read-only MAP_PRIVATE
> file-backed mapping.
>
> However this is incorrect. To see why consider:
>
> 1. A MAP_PRIVATE R/W file-backed mapping is established.
> 2. The mapping is written to, which backs it with anonymous memory.
> 3. The mapping is mprotect()'d read-only.
> 4. The mapping is mseal()'d.
>
> At this point you have data that, once sealed, a user cannot alter, but a
> discard operation can unrecoverably remove. This contradicts the semantic=
s
> of mseal(), so should not be permitted.
>
> We then abstract out and explain the 'are there are any gaps in this rang=
e
> in the mm?' check being performed as a prerequisite to mseal being
> performed.
>
> Finally, we simplify the actual mseal logic which is really quite
> straightforward.
>
>
> v3:
> * Propagated more tags, thanks everyone!
> * Updated 5/5 to assign curr_start in a smarter way as per Liam. Adjust
>   code to more sensibly handle already-sealed case at the same time.
> * Updated 4/5 to not move range_contains_unmapped() for better diff.
> * Renamed can_modify_vma() to vma_is_sealed() and inverted the logic - th=
is
>   is far clearer than the nebulous 'can modify VMA'.
>
> v2:
> * Propagated tags, thanks everyone!
> * Updated can_madvise_modify() to a more logical order re: the checks
>   performed, as per David.
> * Replaced vma_is_anonymous() check (which was, in the original code, a
>   vma->vm_file or vma->vm_ops check) with a vma->vm_flags & VM_SHARED
>   check - to explicitly check for shared mappings vs private to preclude
>   MAP_PRIVATE-mapping file-baked mappings, as per David.
> * Made range_contains_unmapped() static and placed in mm/mseal.c to avoid
>   encouraging any other internal users towards this rather silly pattern,
>   as per Pedro and Liam.
> https://lore.kernel.org/all/cover.1752586090.git.lorenzo.stoakes@oracle.c=
om/
>
> v1:
> https://lore.kernel.org/all/cover.1752497324.git.lorenzo.stoakes@oracle.c=
om/
>
> Lorenzo Stoakes (5):
>   mm/mseal: always define VM_SEALED
>   mm/mseal: update madvise() logic
>   mm/mseal: small cleanups
>   mm/mseal: Simplify and rename VMA gap check
>   mm/mseal: rework mseal apply logic
>
>  include/linux/mm.h                      |   6 +-
>  mm/madvise.c                            |  63 +++++++++-
>  mm/mprotect.c                           |   2 +-
>  mm/mremap.c                             |   2 +-
>  mm/mseal.c                              | 157 +++++-------------------
>  mm/vma.c                                |   4 +-
>  mm/vma.h                                |  27 +---
>  tools/testing/selftests/mm/mseal_test.c |   3 +-
>  tools/testing/vma/vma_internal.h        |   6 +-
>  9 files changed, 107 insertions(+), 163 deletions(-)
>
> --
> 2.50.1

