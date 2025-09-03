Return-Path: <linux-kernel+bounces-797579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471AFB4121B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD2E1A83224
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EBA1E2838;
	Wed,  3 Sep 2025 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9vWTaE6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0719C556
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756864598; cv=none; b=uq/9KT8q76MdTV/o3Q2wu2LCC27g889K/0ypLXr+HG6TQcrYRtz6LukD/gOrQRtVu+c0s/DFDCTSDwA/F2LA5hiYJpM4qih9WCC5dst/HbRfoc3auyFfeGw3+GIR8CuyO1N3uv+yrrkfrehI/YcRGhZCzMNcX/6dZqulm6PSHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756864598; c=relaxed/simple;
	bh=eGvQNN2zvePsU2wyHgDwc6Z6aa3lEyX628tVMVS/QlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjIa5WWg/zspasztJ/r6fSnxL9qh5l7brLIj3wVOk5jxhaUqXdWCEVjrc4ltg0FcCyfPhZYf4SSP122guZH+6pZR92iAK4LFhsJstIyTBfboXKQsZtSp+rY9mJRrHZ50F+aHS3jWACnySlN/3n/ds3bd4iDNqlToxexNxbXADQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9vWTaE6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d6af847306so331300f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756864595; x=1757469395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ953dkTsh0Dx4DikEan8wPpG+Hacm6lkS45eUd1Ujw=;
        b=F9vWTaE6j7OcegFFCkcZs061py/41zXGjToIpgnC0vcWMF8d06H8Brh0uFkLg7A20Q
         TlH4sHj9RaMRQOwbmcqpK7mt8NkaZCIVh2IOu0v06euVSFDDwNuZzIBSrq340eFI507C
         o78hFOsRqrUhGcVSw/bHahVG0Xs+FsxTIUGkJe0wtJ02upkh/0cjjvVt4hJa+X5lZKce
         CLWhK/6EFqFGf2uXRXM89IVozkSquy0ZCkbR9Iy07eEh4/1AGfI+tIxUcjAmARBvyWM7
         PwYSrkYoZT4EsScHLOoa6hHNR7KjLkPneBtyiKrxPQP3w/7Nv3FSuEPVkEvjuk529Z8z
         205Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756864595; x=1757469395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQ953dkTsh0Dx4DikEan8wPpG+Hacm6lkS45eUd1Ujw=;
        b=NH92G9ojLqdiH4Rt81b1J5QBKasNiwS4CXbQ/CxnIKED+HH3FcZJFqGASz+BcG/P71
         jP4jZOyUlcDfe8IdcGm7inWCrBzRYC3FevXGQe3Qy9ZNtkOurWSkF6eu7J5aZ1rQM2yM
         lcNJQYHGlGhpPu02IlcToITn27IEZDMqp1SJ1c5JEENNK85t5cksKYY20pfNpj8BN/uD
         LeQ+yBMkWRlODkSwjy1weZfFGn+hgSQQ9toIxHwnRvRbTtZEjBxJxWPs8HnZYTeHpBtr
         5ctyl4Y98iGLK64fqLDfHsd+dGo4CbE1xaVw2/rQJIhNUz6SoABO255d7S9W/DYeDi6C
         nOxw==
X-Forwarded-Encrypted: i=1; AJvYcCV5UmUvxTdTzX5Iy0xoZf1uUJFPi9HOPKX27GGve8GBC/bmn5b08xY2iihjWZ1+mKzR1RQg8USPbxf7rmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPwK3q+ikexPIRk+H6IX9uHcpNDyirLnPt+FnUv+GO2KSt2+U
	hKIwiNAi9vV/w2HxUT95zz8iyenaCq8Jmexe48QWoUHSgmWjtW3sYuhl/Ra9lyxZHcwkwj7bU5P
	5EmfMcwKVSEhnx9tcpwVR6DL6Hr6+/IY=
X-Gm-Gg: ASbGncsMm9dccuRPD2qu6Kkb71VnJJarNHXt5Ku6GAt7Bb2n3EoyhvClkkacp/bfgV0
	RimCCtb4qFh2zS+o8r6VonQVOptuBPVO2uEjaItWVa/fbCjnj5dG1soQOL+PfQNEdvPeflxpS85
	BZEnTUMXXLANj4DZ3JjLMqXj80YTXv7J5FFBvqNbOFCBf5aOgmgP3X5wHnonVjU1+yO8lv8zj7u
	6/Uz4VZ3wnlnc7vKqc=
X-Google-Smtp-Source: AGHT+IEyjtk0hTZKeLxSiUfd/rl4UytvosJX6XmzdLePURiXLfgCBqyw3MWbdQ/0hTsNmz+rrpatsR/ZRQZvUaEih7E=
X-Received: by 2002:a5d:64e4:0:b0:3c8:ed45:498 with SMTP id
 ffacd0b85a97d-3d0fc3b3558mr5666561f8f.9.1756864595052; Tue, 02 Sep 2025
 18:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901020416.2172182-1-chao@kernel.org> <CAHJ8P3+NJfE+F-Tsbw4Rz6PyT9o2F74kyrJncLqyQv+YeOSvgA@mail.gmail.com>
 <e44dc335-dfe1-45ba-8bac-9c5f7a5f24d7@kernel.org>
In-Reply-To: <e44dc335-dfe1-45ba-8bac-9c5f7a5f24d7@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 3 Sep 2025 09:56:23 +0800
X-Gm-Features: Ac12FXzBETk0qad4U4cyz9AjIw6DlZ-icmknEZMJ_c7mJWaI_nYnLeCf-dbYhk8
Message-ID: <CAHJ8P3+BAzDzW9GixwgXBs6NJqWm+pAUe4cCyhNKWwUx+5f+hQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid migrating empty section
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=883=E6=97=A5=E5=91=
=A8=E4=B8=89 09:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9/3/25 08:04, Zhiguo Niu wrote:
> > Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> > =E4=BA=8E2025=E5=B9=B49=E6=9C=881=E6=97=A5=E5=91=A8=E4=B8=80 10:08=E5=
=86=99=E9=81=93=EF=BC=9A
> >>
> >> It reports a bug from device w/ zufs:
> >>
> >> F2FS-fs (dm-64): Inconsistent segment (173822) type [1, 0] in SSA and =
SIT
> >> F2FS-fs (dm-64): Stopped filesystem due to reason: 4
> >>
> >> Thread A                                Thread B
> >> - f2fs_expand_inode_data
> >>  - f2fs_allocate_pinning_section
> >>   - f2fs_gc_range
> >>    - do_garbage_collect w/ segno #x
> >>                                         - writepage
> >>                                          - f2fs_allocate_data_block
> >>                                           - new_curseg
> >>                                            - allocate segno #x
> >>
> >> The root cause is: fallocate on pinning file may race w/ block allocat=
ion
> >> as above, result in do_garbage_collect() from fallocate() may migrate
> >> segment which is just allocated by a log, the log will update segment =
type
> >> in its in-memory structure, however GC will get segment type from on-d=
isk
> >> SSA block, once segment type changes by log, we can detect such
> >> inconsistency, then shutdown filesystem.
> >>
> >> In this case, on-disk SSA shows type of segno #173822 is 1 (SUM_TYPE_N=
ODE),
> >> however segno #173822 was just allocated as data type segment, so in-m=
emory
> >> SIT shows type of segno #173822 is 0 (SUM_TYPE_DATA).
> >>
> >> Change as below to fix this issue:
> >> - check whether current section is empty before gc
> >> - add sanity checks on do_garbage_collect() to avoid any race case, re=
sult
> >> in migrating segment used by log.
> >> - btw, it fixes misc issue in printed logs: "SSA and SIT" -> "SIT and =
SSA".
> >>
> >> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> >> Cc: Daeho Jeong <daehojeong@google.com>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>  fs/f2fs/gc.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >> index ed3acbfc83ca..a7708cf80c04 100644
> >> --- a/fs/f2fs/gc.c
> >> +++ b/fs/f2fs/gc.c
> >> @@ -1794,6 +1794,13 @@ static int do_garbage_collect(struct f2fs_sb_in=
fo *sbi,
> >>                 struct folio *sum_folio =3D filemap_get_folio(META_MAP=
PING(sbi),
> >>                                         GET_SUM_BLOCK(sbi, segno));
> >>
> >> +               if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
> >> +                       f2fs_err(sbi, "%s: segment %u is used by log",
> >> +                                                       __func__, segn=
o);
> >> +                       f2fs_bug_on(sbi, 1);
> > Hi Chao,
> > Do we need f2fs_bug_on here?  or it is enough to skip current segno
> > and let gc continue?
>
> Zhiguo,
>
> I think we should never select in-use segment as GC victim, so I add a
> f2fs_bug_on() here to detect any potential bugs. Let's see what will we
> find w/ this.
Hi Chao,
Got it and thanks for this.
>
> Thanks,
>
> > Thanks!
> >> +                       goto skip;
> >> +               }
> >> +
> >>                 if (get_valid_blocks(sbi, segno, false) =3D=3D 0)
> >>                         goto freed;
> >>                 if (gc_type =3D=3D BG_GC && __is_large_section(sbi) &&
> >> @@ -1805,7 +1812,7 @@ static int do_garbage_collect(struct f2fs_sb_inf=
o *sbi,
> >>
> >>                 sum =3D folio_address(sum_folio);
> >>                 if (type !=3D GET_SUM_TYPE((&sum->footer))) {
> >> -                       f2fs_err(sbi, "Inconsistent segment (%u) type =
[%d, %d] in SSA and SIT",
> >> +                       f2fs_err(sbi, "Inconsistent segment (%u) type =
[%d, %d] in SIT and SSA",
> >>                                  segno, type, GET_SUM_TYPE((&sum->foot=
er)));
> >>                         f2fs_stop_checkpoint(sbi, false,
> >>                                 STOP_CP_REASON_CORRUPTED_SUMMARY);
> >> @@ -2068,6 +2075,13 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
> >>                         .iroot =3D RADIX_TREE_INIT(gc_list.iroot, GFP_=
NOFS),
> >>                 };
> >>
> >> +               /*
> >> +                * avoid migrating empty section, as it can be allocat=
ed by
> >> +                * log in parallel.
> >> +                */
> >> +               if (!get_valid_blocks(sbi, segno, true))
> >> +                       continue;
> >> +
> >>                 if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno)))
> >>                         continue;
> >>
> >> --
> >> 2.49.0
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>

