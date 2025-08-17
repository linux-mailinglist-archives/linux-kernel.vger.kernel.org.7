Return-Path: <linux-kernel+bounces-772308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5AB29115
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 03:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B822A2695
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 01:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F311990C7;
	Sun, 17 Aug 2025 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcYsx2I1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117618FDBD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755394643; cv=none; b=IzZg6gKy0UW36dawEgVufJvht09SRanHDRwt9xZ2BUdCz2kRT3KopnO4pZUIm2VNuv+wmhek2rkFhGtXYzIZCOesqcj0qUwad+YpeP16DxlkJZrKDy13/HKOnyAAfz5BJJrhDA6zH6+CKysDHiC/8rDALyQSctjTH9uuzbQNyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755394643; c=relaxed/simple;
	bh=98B3wydd9pNJSwXo9oKtwIU8Z/skWmHQS9kAtrLaLLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtKFANoFMyfkmRsS3SosnFLOa2/qWF7il01b3k2wlUnHjl/1tkrdE2epn6jb9JhPHiM/smHhy4tpNC24kPmoG9V7BHiWs4N+Q2sqpTFmdP8eNE3BxFt0y0HpKkLlm2tBJxbE4KzF1cvrZss8yxc3MoeYbbo/irPf2abhB7RsnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcYsx2I1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB392C4CEF7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 01:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755394642;
	bh=98B3wydd9pNJSwXo9oKtwIU8Z/skWmHQS9kAtrLaLLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rcYsx2I1rgfl9DQKoVL1bDhTn8/Cc3FXxGdkgj8rJFw/zAnQ9GvPS4C6MzNWYL0GK
	 vTBrnuoXNPr/uv1obdItA0tYnIq2RD8BcRxrKeBkMz4YBleTag1tVoGDj7HmAuC9yN
	 N2sncmKUln+CxKbkpKVNHpM3Xf8NpxRi+mqA3E+cerh3boyktc9RScJNaihyiYdb4J
	 6VIR7K8AjivQpv+ivVQiBHmk+Gi7J6ti2jm8W80nhZRz7m38YKEcAdd+9xtgEuoP0r
	 PIu1hkgvrx/fj5qWWQMfsAAHI+Sdl5iPaauBstO+qblEXdwh4JOYf4qX0CxSfwUPcA
	 SF5Xndqx0abyQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-619ff42ad8eso1050872a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 18:37:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCniI+NBSGlBhpeljca+oGJZ57rxH/NwBv54/mTcFfrhU7147IfHphiz9HrASb8hmfmT+oKbHwXLfYxdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4w2hl53YXtU6+QI3Dbv4DQcbSNW/mH5pkHu+aIeyBXJ/v9Yny
	JXswQxAyfjYwTGLW01W+puoeVOxLWiI34zwI4pSJ5EnpmVkCGPmAvY5TtvKt/tkxgvisvwy/2ES
	cS8pXOC9AFomzLi2bCUfyMQ7MtE1m75w=
X-Google-Smtp-Source: AGHT+IHXjJ/zZKNED7MRYupguP+hzkILfeOdZashtip7Q2uruj+3o+XpMjNgILr82FhUMA/aEsi0zdq1Ko56W4OITiE=
X-Received: by 2002:a17:906:c154:b0:ae3:c767:da11 with SMTP id
 a640c23a62f3a-afceae5af28mr383029166b.50.1755394641318; Sat, 16 Aug 2025
 18:37:21 -0700 (PDT)
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
In-Reply-To: <e06f23d9-adcf-4d0a-8ba1-bda6d4b483b1@redhat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 17 Aug 2025 09:37:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6csiOVDco=pocC72WSPiafDJV+1+R7P0KvB15dxOjtow@mail.gmail.com>
X-Gm-Features: Ac12FXwmxXwhrFiUo2UU-awg0ihzGsCPQXGqVMaq1mgOiUl9KUx_ClVs_iHzOFk
Message-ID: <CAAhV-H6csiOVDco=pocC72WSPiafDJV+1+R7P0KvB15dxOjtow@mail.gmail.com>
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Harry Yoo <harry.yoo@oracle.com>, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 1:02=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.08.25 18:23, Matthew Wilcox wrote:
> > On Sat, Aug 16, 2025 at 12:54:52PM +0200, David Hildenbrand wrote:
> >> +++ b/mm/balloon_compaction.c
> >> @@ -256,8 +256,10 @@ const struct movable_operations balloon_mops =3D =
{
> >>   static int __init balloon_init(void)
> >>   {
> >> -    movable_ops[MOVABLE_BALLOON] =3D &balloon_mops;
> >> -    return 0;
> >> +    int rc;
> >> +
> >> +    rc =3D register_movable_ops(&balloon_mops, PGTY_offline);
> >> +    return rc;
> >
> > Using 'rc' as the name of this variable is an anti-pattern.  All it
> > tells you is "this is the return value".  Calling it 'err' is far
> > better because now we know it's an error number (or zero for success,
> > of course).
>
> I know, we all have our things to complain about. Some about Cc: above
> --, others about the name of error variables :P
>
> $ git grep "int rc" | wc -l
> 12730
> $ git grep "int ret" | wc -l
> 80386
> $ git grep "int error" | wc -l
> 4349
> $ git grep "int err " | wc -l
> 6117
>
> >
> > It seems to be a particularly IBM derived antipattern ;-)
>
> Careful miser :D
>
> > Some internal style guide, perhaps?
>
> Kernel-internal style guide maybe ;)
>
> >
> >> +void unregister_movable_ops(const struct movable_operations *ops, enu=
m pagetype type)
> >> +{
> >> +    switch (type) {
> >> +    case PGTY_offline:
> >> +            WARN_ON_ONCE(offline_movable_ops !=3D ops);
> >> +            offline_movable_ops =3D NULL;
> >> +            break;
> >> +    case PGTY_zsmalloc:
> >> +            WARN_ON_ONCE(zsmalloc_movable_ops !=3D ops);
> >> +            zsmalloc_movable_ops =3D NULL;
> >> +            break;
> >
> > This might be a bit excessive ... just passing the pagetype and not
> > having the sanity checks should be enough for the tiny number of users
> > this interface will have.
>
> Yeah, no strong opinion, this was a 3 minute hack.
I have tested your code, everything works well. But if the checking is
too excessive, can I use a set_movalbe_ops() to replace both
register_movable_ops() and unregister_movable_ops()? Because register
and unregister are very similar without excessive checking, then we
can pass a meaningful pointer for register and a NULL for unregister
via set_movalbe_ops().

Huacai

>
> --
> Cheers
>
> David / dhildenb
>

