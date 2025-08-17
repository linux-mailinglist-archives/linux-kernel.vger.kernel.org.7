Return-Path: <linux-kernel+bounces-772407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E3EB29243
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6553B7A4E36
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D08D21B9C0;
	Sun, 17 Aug 2025 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjeZrue1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8E7081F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755419657; cv=none; b=tjZbnKhIB0Mh3saWI70ibVefiBA6f1nidGjZI9HqdTGZJ7g5/RNbrsPXJMG+MA38o9mUeYFw/RUU/QzQAetSN6zFsY9skSmFpeLEzbPJdcC8jbjnqxks8LGiS1LrQ5Urt4mBfcG9JIg9cTmH3c41znBpgoM4U91YdKkkb+p2TSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755419657; c=relaxed/simple;
	bh=li5zZbum8kkyoUzY84Ph1M8+NH2gQa+3WCpR7pJIhAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAJ/DIdtDtoPiGQruSJvqA0vVEcdPpaHipeOdL5HinTUv6qExF/JCu8tTZ9z71M8X6IUHmOKWQwIViNGi7TmC8G23fK/enKMobTyHKXrnkLQ+mweTSWpMdvvCukwwWiFvwECQDAE3CftbkFLevOnHZ95PKTZ4nWwBuP6VquPkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjeZrue1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34277C4CEF1
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755419655;
	bh=li5zZbum8kkyoUzY84Ph1M8+NH2gQa+3WCpR7pJIhAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SjeZrue1BVbhIJAnBNMVx96Io0yARDyZ+wTeB0fvi/1GppRjxvCiN/RKWXIF4JVWX
	 Dza97NVV2d8qa9sYhkKxsxWiVOXGDCzl2BfpKiGV7O1zG1wo29qQPO8yZmCQd375Jx
	 c68TD6F6rM7IqLbCD6wz3nuzsS+/8nk3c5syIR8ZLAonxL83R+8DYyle5HCYOkd059
	 m9oP4Hn8CMZ9VscrMIrIvi69FH6ERWmf9nDNo+unc+i3PZF1xmkzSiD7TiuonERh2X
	 G/fXebe/OzAPBxawF8VdozPod/5xoH4bNueTJJ8ETNDau4gz83RYxqzEKOUfiso3Xi
	 73g2Xh+kjSuVA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b73bef3so5691859a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 01:34:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgr28wjhR+tPPGgFzlaC1NZBu7dZ9qWULnWWqznzAVGkLy5xQfv6DKjZTIQN/FV/KY7LAjATGrGtfzs6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPxokOupR2t2LC2/NCdglai++FWy5nGk111TmyTZTaBG+5lLy
	hOg1ccKBMxErEEj7YP5tlFSv1UR5UoY7RxaTSRDNz7Bhq9aARBew6aV33U2xsBts/zrjYz4KNpn
	XDJbkmXfxLlO789WRltq4sv3CI3Vf+7Y=
X-Google-Smtp-Source: AGHT+IGa9W/r1zgXGlg06WiWs92ObZQDb827/f2x4dsSdzi3dHGFsi/6Oo0bvRS19ctBiV52MhxG3L7W2cSOzww/3TQ=
X-Received: by 2002:a05:6402:270c:b0:618:2257:7fcf with SMTP id
 4fb4d7f45d1cf-619bf1e5a9fmr4440978a12.18.1755419653730; Sun, 17 Aug 2025
 01:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815090539.1578484-1-chenhuacai@loongson.cn>
 <a20d605c-79a0-4d89-985b-9512a990b492@redhat.com> <CAAhV-H470h2HDEN_NY2qNBxUqQrSRQhLzwqZe9PB8GjnNsZVFQ@mail.gmail.com>
 <66ebc632-6704-4637-b62d-1cb11e5a4782@redhat.com> <9db98f7f-b90f-464b-ae7f-e94ac523bc28@redhat.com>
 <aKCwjCJTEhX4Q6wW@casper.infradead.org> <e06f23d9-adcf-4d0a-8ba1-bda6d4b483b1@redhat.com>
 <CAAhV-H6csiOVDco=pocC72WSPiafDJV+1+R7P0KvB15dxOjtow@mail.gmail.com> <3871f0b0-db94-4358-877b-fd5ddb4337dd@redhat.com>
In-Reply-To: <3871f0b0-db94-4358-877b-fd5ddb4337dd@redhat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 17 Aug 2025 16:34:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7eX2OOaT=kMdvTZP5mO=_vpCs54h9_=xai6qPUJJixog@mail.gmail.com>
X-Gm-Features: Ac12FXzrRv7B-5AfseowyHbeieLtUNdQStVrTWOt3K4mY48V0WZeUg2NepDi4TI
Message-ID: <CAAhV-H7eX2OOaT=kMdvTZP5mO=_vpCs54h9_=xai6qPUJJixog@mail.gmail.com>
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Harry Yoo <harry.yoo@oracle.com>, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 4:05=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 17.08.25 03:37, Huacai Chen wrote:
> > On Sun, Aug 17, 2025 at 1:02=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 16.08.25 18:23, Matthew Wilcox wrote:
> >>> On Sat, Aug 16, 2025 at 12:54:52PM +0200, David Hildenbrand wrote:
> >>>> +++ b/mm/balloon_compaction.c
> >>>> @@ -256,8 +256,10 @@ const struct movable_operations balloon_mops =
=3D {
> >>>>    static int __init balloon_init(void)
> >>>>    {
> >>>> -    movable_ops[MOVABLE_BALLOON] =3D &balloon_mops;
> >>>> -    return 0;
> >>>> +    int rc;
> >>>> +
> >>>> +    rc =3D register_movable_ops(&balloon_mops, PGTY_offline);
> >>>> +    return rc;
> >>>
> >>> Using 'rc' as the name of this variable is an anti-pattern.  All it
> >>> tells you is "this is the return value".  Calling it 'err' is far
> >>> better because now we know it's an error number (or zero for success,
> >>> of course).
> >>
> >> I know, we all have our things to complain about. Some about Cc: above
> >> --, others about the name of error variables :P
> >>
> >> $ git grep "int rc" | wc -l
> >> 12730
> >> $ git grep "int ret" | wc -l
> >> 80386
> >> $ git grep "int error" | wc -l
> >> 4349
> >> $ git grep "int err " | wc -l
> >> 6117
> >>
> >>>
> >>> It seems to be a particularly IBM derived antipattern ;-)
> >>
> >> Careful miser :D
> >>
> >>> Some internal style guide, perhaps?
> >>
> >> Kernel-internal style guide maybe ;)
> >>
> >>>
> >>>> +void unregister_movable_ops(const struct movable_operations *ops, e=
num pagetype type)
> >>>> +{
> >>>> +    switch (type) {
> >>>> +    case PGTY_offline:
> >>>> +            WARN_ON_ONCE(offline_movable_ops !=3D ops);
> >>>> +            offline_movable_ops =3D NULL;
> >>>> +            break;
> >>>> +    case PGTY_zsmalloc:
> >>>> +            WARN_ON_ONCE(zsmalloc_movable_ops !=3D ops);
> >>>> +            zsmalloc_movable_ops =3D NULL;
> >>>> +            break;
> >>>
> >>> This might be a bit excessive ... just passing the pagetype and not
> >>> having the sanity checks should be enough for the tiny number of user=
s
> >>> this interface will have.
> >>
> >> Yeah, no strong opinion, this was a 3 minute hack.
> > I have tested your code, everything works well. But if the checking is
> > too excessive, can I use a set_movalbe_ops() to replace both
> > register_movable_ops() and unregister_movable_ops()?
>
> Makes sense, given that I don't expect us to have multiple handlers for
> the same type in the near future.
>
> Please do keep a sanity check for replacing valid pointers
>
> if (old_ops && new_ops)
>         return -EBUSY;
OK, will done in V3 later.

Huacai

>
> Thanks!
>
> --
> Cheers
>
> David / dhildenb
>

