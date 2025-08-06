Return-Path: <linux-kernel+bounces-758165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B447B1CBDA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467E1189DF52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CC51B5EB5;
	Wed,  6 Aug 2025 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4GljbNIW"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6718FC92
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504478; cv=none; b=acQ2vQ89vbww3pTnPAZ7jm5r91tGfKth8yBmVEKrTT0CYoU59KWLbmrifgYXQ+aJIh7hHs+t/LUoi+7l6ncftJRLkc1AbOqXk0U+YV/T8PCeQAe3CTaf8IcyACt90Qj7lC2ZR4GHo9PWOURkVhfPc/K3UO29tk6NeDiQEXhQ3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504478; c=relaxed/simple;
	bh=cFY/TZITiKjs0JtJtbpXn41ElMFKN7hRg8VmUNXXoSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+YQsx5A0byka/GjMRVHbBQU5ws3/ZPLHEJDHozyOZ6afdbbCSZRqYlPd0dhmf+O+ffTlzM1Z4I80GgkAj7JTYAKW2Hzhv4cqYRikd0fWygQdiueaLrs/ILUGrFmf9ul2CKElnn7yV357x9AOmDK80nVIGlwuZbdSdzfTG+9Oe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4GljbNIW; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0673b0a7cso34251cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754504476; x=1755109276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpzHgd6TpTYvjXVHg7u1dC6rZFfWzZnJYbp9d0+ZhbI=;
        b=4GljbNIWjcMMECy15WHr8vTsA96/Mc+nOoKLLJFK2OuzNPIHWlA874E7Uhts8de0d2
         mESbJduA/Hr6oOurs57T5nc+RUOGAYetc9UZlzwSASYrWQOs1pK19HfqEQwkgICxESP7
         mzPwg0hC2tJ035LmiVWEWJNWCF55Jyn3fM16okk38DmxRmqf8k062xMdBAjQpfcG7Eme
         255ntBPb6lx6dHjIb79Q9K0ITGSjymndrImKS8Et0GRleSD6uXbKgFSzJY1hzsVmU9++
         gyvm6I1FlmRdNKWxx02ZxSR8W9wdi6slB6QWk6f4D9bSwsQ1n4ZjUaWavz9dn5sesis+
         7wDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754504476; x=1755109276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpzHgd6TpTYvjXVHg7u1dC6rZFfWzZnJYbp9d0+ZhbI=;
        b=EoRLbUAGQMex79iKEHH7JSD1rmrhfpYrDqrAhQjQutRfwtDS2Fh3otcEFlknON/w4s
         whZDoWlmOYhGiDsYZI3nNnxAHs/5AoxKp+VvWhX1wCMQwB860CrT5sgnzNDh91Ys2uWh
         PcAxymnRQtBPJONajj0oKgda9ABT6UAchUMMUceKpcqkc7RuD7ZWcuhHX4YWc2Xf1mFY
         zc38+oZpP5bl0rYngCckisIqM/jWGtxBmztWgCA8aFGT8SWbSArt1PjLosgqWHxggWD9
         Ap2HyRDM2dRZbWh3RNwq6Yay/HkxmEEqwtX6cLxwILK+188Hyt4T+4I9SeMA6/BS43mF
         W4CA==
X-Forwarded-Encrypted: i=1; AJvYcCUoPUfN8jW5dgyiXuq2U4uaivZd0UCEI3HY00WuXV3D6JaBHwJNnswNxeiuxGeWAkVTdzmrB4zOGZFgNLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYC49agzDqYZdKpWBfV2/lt2Hw2vk8uzFSqz3XFvrazFlnT6J
	UZT3UuIKjTTcoQzW65Tf5O6ziJjiZ4UURZ4lGeyA+syirBY8HrcZPuZkVEa/eT6dOEZuS5Fkbb3
	p0kXKGNN2M+xSO+YnXOrmRXoJqfxwgUhByLUEBagI
X-Gm-Gg: ASbGncuFmKV3/1bv1dUky7doBxBO07LNyaTMWMMvRq6VxWOnFDX/+dE2oQDR+RFDb63
	oE4vJT8MJHA18Vv/CQAG05cBNWSJikLRsu/3i3XfMK+qJaUNIKvnR7eoC6gZROpTVcxFjwPVJSV
	5SzAU/rgpzTPoIWT8OK91W1tyPCaSUAzlcY3MDFq31ViNjOOWqWUgpQDnOfmY1Z5UGB//GZIV72
	AFcmA==
X-Google-Smtp-Source: AGHT+IF/oBk+1Kx6MOGQZ+KRXoereierCI6MIImjRBAfsMTewdOnZY01NCyaNvQxEiMf8qFgK2ouIA3X3qcui1fNVQI=
X-Received: by 2002:ac8:5742:0:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4b0a1abba87mr458871cf.6.1754504475631; Wed, 06 Aug 2025
 11:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806154015.769024-1-surenb@google.com> <aJOJI-YZ0TTxEzV9@x1.local>
 <CAJuCfpGGGJfnvzzdhOEwsXRWPm1nJoPcm2FcrYnkcJtc9W96gA@mail.gmail.com> <aJOaXPhFry_LTlfI@x1.local>
In-Reply-To: <aJOaXPhFry_LTlfI@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 11:21:04 -0700
X-Gm-Features: Ac12FXx7qPXyaQOngW6323VZjhzisIrfexf_bbuz5pNIpI6czJ1v3UXAemPUJ5o
Message-ID: <CAJuCfpF0RJ9w0STKFaFA7vLEA5_kEsebuowYWSVnK-=5J2wsPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] userfaultfd: fix a crash in UFFDIO_MOVE with some
 non-present PMDs
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:09=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 06, 2025 at 10:09:30AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Aug 6, 2025 at 9:56=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Wed, Aug 06, 2025 at 08:40:15AM -0700, Suren Baghdasaryan wrote:
> > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and =
it
> > >
> > > The migration entry can appear with/without ALLOW_SRC_HOLES, right?  =
Maybe
> > > drop this line?
> >
> > Yes, you are right. I'll update.
> >
> > >
> > > If we need another repost, the subject can further be tailored to men=
tion
> > > migration entry too rather than non-present.  IMHO that's clearer on
> > > explaining the issue this patch is fixing (e.g. a valid transhuge THP=
 can
> > > also have present bit cleared).
> > >
> > > > encounters a non-present PMD (migration entry), it proceeds with fo=
lio
> > > > access even though the folio is not present. Add the missing check =
and
> > >
> > > IMHO "... even though folio is not present" is pretty vague.  Maybe
> > > "... even though it's a swap entry"?  Fundamentally it's because of t=
he
> > > different layouts of normal THP v.s. a swap entry, hence pmd_folio() =
should
> > > not be used on top of swap entries.
> >
> > Well, technically a migration entry is a non_swap_entry(), so calling
> > migration entries "swap entries" is confusing to me. Any better
> > wording we can use or do you think that's ok?
>
> The more general definition of "swap entry" should follow what swp_entry_=
t
> is defined, where, for example, is_migration_entry() itself takes
> swp_entry_t as input.  So it should be fine, but I agree it's indeed
> confusing.
>
> If we want to make it clearer, IMHO we could rename non_swap_entry()
> instead to is_swapfile_entry() / is_real_swap_entry() / ... but that can =
be
> discussed separately.  Here, if we want to make it super accurate, we cou=
ld
> also use "swp_entry_t" instead of "swap entry", that'll be 100% accurate.

Ok, that I think is our best option. I'll post an update shortly.
Thanks!

>
> Thanks,
>
> --
> Peter Xu
>

