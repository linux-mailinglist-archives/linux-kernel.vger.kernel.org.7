Return-Path: <linux-kernel+bounces-767577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD04B2563C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E59E1C28013
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DB02D3727;
	Wed, 13 Aug 2025 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pumSiAVz"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ABF2046BA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122534; cv=none; b=XGivX+szi+tQvreXprO5zvfqELBSQzEu+1WEJfF+qczexRb4RxdVOk5QojngptzoyqUQ6A3+vR9y1rAQcPwCHsj6wVIPFivL2Y6VgoVgHORDxb4UE+wLxWBMr4h5pU0mLCvABj/rgt06X5Yss7QVvhlYPIlEQ02yuI/pg/cyXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122534; c=relaxed/simple;
	bh=4iFht3nsk7YqplusUetBQqE6oe6XCHDupWqucsOT0ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFVeXjOLUIrSfo6Dp/ZcOx22K2X9tZwGJC9ezEMZYnYGLbsyXev4mXlVoLy5CRuSeUrsRDyoJ9QsCR0/ueYfLuvor2lxWW6yYYgKkyoelQ4CNDgWOz2QhgDjbnMvbujK+NBjh4HKlfsRV7cDTxHeWeZS0/sc+mYOBfEmg976i+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pumSiAVz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-617ff2c8e5dso4034a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755122531; x=1755727331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iFht3nsk7YqplusUetBQqE6oe6XCHDupWqucsOT0ug=;
        b=pumSiAVzlnrbxT04cx8mF9gMJMeap3YM2p2K6doHa+Kec0K14Y/LdkSWhJUVkOgfJf
         1Y1nPqf69z5lt951UK9MECvXdN3E19UkPaEojdJzXy3ok8aBY/2QhoOPGFKaEkgxZflG
         TrBGUh5UEJzK8LWSav96L+GddUNuDmHp/ItdgK2XA59w/TzBjeswe7P/Mg9HSD8Qe1n2
         4jLNcUtmHR5T5pujwU3TSe/oQem5f/0ZEQhryeerxzD263FBbkQu7i3qCx+84UfGR6CE
         jdZeQSlZCxjKtEkURt437MwKQnKehL5KDL3h8qYPGH1N8uWNvCiimta5WbrefApr+Uve
         cG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122531; x=1755727331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iFht3nsk7YqplusUetBQqE6oe6XCHDupWqucsOT0ug=;
        b=lUetoiqSONiBVb5vN8fdyBWcjbnjtAxOWbE3UcSnRkOYVG+yD2Qs9neepzzuSJXbyO
         ieC5VYhqqTW/GzIvutJXNJqJoaHfCLYVUgwOyogfbvIHSGMGZxv6mS9A24CL43aD6O4F
         MeHI02xEaOoGgPLmGx1BxyiOxY0iSxK818Bjct61YtGHMl/8RUqBwNyMymj/5olnLW2G
         VWBn7/43ha3K3Cega+DQ0MZua7KigC72J94Z1Yzxa4TU1n0bzgbfl3Sd7aya/AUv2N7i
         RVHBgSsbHG7ahTZHJ1dpaayEFZ692HKfxXp2Xx808faC/sW+VDvP1JCshR8la1j2L0kb
         UUbw==
X-Forwarded-Encrypted: i=1; AJvYcCV3BfTIuCSjZZ4URIo3m8Qe+dLtstsUQQniXiErPQrQ5HauUuDLVRZceCs4JpIaHe0Gk247TCAhhgvgSPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcZ+13SQ+YXA80brzggSwUzjXVSnf9k6OJ1Ahq9PCFc52lB6G
	8qrqORQNZdxIMhfhONNkSaqnLGaPt5o3L8WZOjIV7fsu7x2SXAbG14dyUVOiCauSt+4GMdaqo/1
	S9hLrp3p1lzMCWe+Z7Zn5az1XPwt1Wjq7dUpqkD6R
X-Gm-Gg: ASbGnctuJL/H5ZUyXGNXG3kkE6SUh8t39aOmmIYQP1d25ovhnnowi3zCzx8DqZPGFAl
	6hmkZDepRQbYoe/iiIJDW5nc7QAJhtLuaPqPBzbJxCdlTwMzmAY0554EEVEM9LSTiCnn2K6DjZ9
	V/fa6oAt6RZnftapzA2q1ps/lxhnBHi16S/ToXKhvhfLwEgo/Poxtt6P0kPzc99FHhQrO39r6yv
	TmCUyoPFDCNdxeeNhBLT0sjZCaoxlsry5q1YA==
X-Google-Smtp-Source: AGHT+IHiiPh9Xm8Mns7CYO0SfUCu3wLhGRYYIogqYiDQBdF8hepQOLiPJ2i3M2KIFfkMDguGUksaJNIUBLHQn6XDs6Q=
X-Received: by 2002:a05:6402:a0cc:b0:618:4ac1:e6a3 with SMTP id
 4fb4d7f45d1cf-6188c50b31amr28635a12.4.1755122531025; Wed, 13 Aug 2025
 15:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813193024.2279805-1-lokeshgidra@google.com> <20250813144737.c3f388313fe13ff44856daf5@linux-foundation.org>
In-Reply-To: <20250813144737.c3f388313fe13ff44856daf5@linux-foundation.org>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 13 Aug 2025 15:01:59 -0700
X-Gm-Features: Ac12FXzh-EyQzOywYOpNxT8MGqhZDgFNX3c76zzozstwuOwDhPlgDUJ8kAYaIKM
Message-ID: <CA+EESO4rMS5ot_wJfWVT+7rDKYgk187xnZJ3NNZsFgUXCbG1yQ@mail.gmail.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Andrew Morton <akpm@linux-foundation.org>
Cc: aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	21cnbao@gmail.com, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:47=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 13 Aug 2025 12:30:24 -0700 Lokesh Gidra <lokeshgidra@google.com> =
wrote:
>
> > MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> > for moving present pages. Mitigate this cost by opportunistically
> > batching present contiguous pages for TLB flushing.
> >
> > Without batching, in our testing on an arm64 Android device with UFFD G=
C,
> > which uses MOVE ioctl for compaction, we observed that out of the total
> > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> > ~20% in vm_normal_folio().
> >
> > With batching, the proportion of vm_normal_folio() increases to over
> > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > includes TLB-flush overhead.
> >
> > When the GC intensive benchmark, which was used to gather the above
> > numbers, is run on cuttlefish (qemu android instance on x86_64), the
> > completion time of the benchmark went down from ~45mins to ~20mins.
> >
> > Furthermore, system_server, one of the most performance critical system
> > processes on android, saw over 50% reduction in GC compaction time on a=
n
> > arm64 android device.
>
> Were these inefficiencies a regression relative to an earlier kernel?
No, these inefficiencies existed since MOVE ioctl came into existence.
IOW, the patch is improving performance, rather than fixing a
regression.

