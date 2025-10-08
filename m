Return-Path: <linux-kernel+bounces-845069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B766BBC36DA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D08504EF15A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC02EA735;
	Wed,  8 Oct 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsJdpOkP"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56391E835D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759903393; cv=none; b=pgEvT2biqzeVYL6rvXIy5s0JPNYrdEeOYP3WT7GUys9ybPCOE6HbZfpHvFQi5aa2OkxrNqbzTH6z/oCtVYV+ANilxuc05p6IwilFco08KAPeQKxkwei8pArHDiQ1qZaYcbkKBAFaX+aAwjfHSrpgUQZeqRVKf2OFADe7GUf/AE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759903393; c=relaxed/simple;
	bh=tBzereJRTdGWw5Bv4VX5a6USN6lK2ZJ/saFJPUjeViY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCa10+pz5UA+MkPsOcWRZITkzX5toF2r68fNElOj+6j3jBNp5/MjjqbDjKMptLoBc6Er38zc+pKC4fweym7FW7C0+Yn2zZ+0pVmVnWzeruIUZrfvtkqtng4Ov1pkaLeQ00Bf2TckVDZmhhvjomVfqlPPkWe8dZ/wkr1u0PCZlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsJdpOkP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78ea15d3489so62797426d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759903391; x=1760508191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBzereJRTdGWw5Bv4VX5a6USN6lK2ZJ/saFJPUjeViY=;
        b=GsJdpOkP8MRfjMzGckrnB3l3AUBEp0HfYB3e35W+1/zYf7QYsLkFYlh1NP34nQscsf
         mDj5Y9DCnXRWTi2oBr2rFOl4I4D4tj29V1Zspwywy8RkiaLW9CUHKUHNPeTyFWVebCWd
         7z65TO2lpJmIi5F61KYi3p4utocKlEHJMM0XJcD34bHfut0NjbUo5iDNV2ixCnmINhiz
         Yl/QVmZoTrRy+ewJFefaUXF3wo69BXsk/3c2u6xFQejLY2wdQnj5Edn/EzY0TLMehJPw
         4RFUkhwlg8ylyZ0wNdCWYpjKd7Xli54lbDLtVk5wfGU6uvlEAfQ3r9Jua8QLi7JRAXwY
         rsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759903391; x=1760508191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBzereJRTdGWw5Bv4VX5a6USN6lK2ZJ/saFJPUjeViY=;
        b=oM42rF+2546vP2ffS83y2veSOp7IM/J2e4t7f96F1EVckCc0sjks0jMGMotDR10ZiQ
         4ctp4fHTK1y3pGSUGB1NZ4e8v+Ve3jWa8e3O8+t7W4d/U9d7gYJloREvTzNKURhkqB2k
         WDNiyfrdMNN6Ocvxe0nc880gm8Ha6gcri0w2BME9MaNBOf6m8D/pJbpChuPQ769xIszM
         DVGUj2+wxAlyRoPNb7ieWMgZd9Z16ADGsP9G7JrYiwobs6fPpPUht5LdFD4it8l8gjLv
         rAiyo0b6Hz64eWj71wtAqXrZPEOzRM9NHx+0YbmoaivcZO0pD5OHUBZNUo37jq4EklNr
         9YvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXCe2idf7KVM4a14h4MwL6BdarDWxbt5ORrPN/wEAGXX51dHjQin0yVDndSgPB1zzVrVBhf6l+M5M6Smk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLH7TGzVlhtYo5G7H1u33/jMEMPsx8hRjg79fCyx/VYb+T6Ik
	4r7vHuHSHDsgpIR5Y4iHfScJmg97ZeL7qbWhDP3sc14VcS12J+y2xIxTMo5jQxJKU466r7Fhcam
	PuZJM0cLj3b0qx6Cqwv8OAkX0lPfay8g=
X-Gm-Gg: ASbGncsQ3zdfuWOSzmGKY+SpUjv/6XjzC3GMF+eVOU1MT3EYwhaG70USjVDo5mFvkWz
	X5bBH9EJv7ViGamQrjiVlsq9NB/DtUsHAk/LpeM2ed6lsNiUjTomJWUe4XU3+9dXO0oVfievZTT
	B+C0FTbVFGn3IuHyMIgWt+TWL7ymw69dqZc1Si1xhcrNZOxxWJMYtWRgeo+tFtZAL4YtnHRrop2
	8zLpZi8wYpSTPO5z+clCCjNQMcNkR2NJMigtdUfyj6EAQObUsIsddqHXPvAHZkZLiIzgGt09wo=
X-Google-Smtp-Source: AGHT+IGN1fUle74mm+Dey9XN+9R2Hgx9711f1pzgYvQjJUJA/sik2SzgKknv0h0WalhCBF/jq/ow+URmBR5p54sJHtw=
X-Received: by 2002:a05:6214:2a8a:b0:785:c20b:f602 with SMTP id
 6a1803df08f44-87b2ef94a07mr29281856d6.61.1759903390435; Tue, 07 Oct 2025
 23:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
 <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com>
 <CALOAHbBcU1m=2siwZn10MWYyNt15Y=3HwSGi7+t-YPWf0n=VRg@mail.gmail.com>
 <CAADnVQKzW0wuN3NfgCSqQKVqAVRdKVEYMyJg+SpH0ENKH6fnMA@mail.gmail.com>
 <CALOAHbBzS2RunZzEk8-rkU60M8jKEJ8FwiPgZqNeoXDy++L5hA@mail.gmail.com> <CAADnVQKLbc4iZDGWbbhqwr8hKhAZhyLjiZuuz_RBd2f9LH45rQ@mail.gmail.com>
In-Reply-To: <CAADnVQKLbc4iZDGWbbhqwr8hKhAZhyLjiZuuz_RBd2f9LH45rQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Oct 2025 14:02:34 +0800
X-Gm-Features: AS18NWB7YAjB1_r1_mFRyGxWlvWmvmCic0bUl2k22vQ5MpJjGUViYxml_XAQVh4
Message-ID: <CALOAHbCOQ_S-b+8pMxwGsjoc9QnAdij=gjkPEm0--cR7iCRQ3w@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 12:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 7, 2025 at 9:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Wed, Oct 8, 2025 at 12:10=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Oct 7, 2025 at 8:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > On Wed, Oct 8, 2025 at 11:25=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gm=
ail.com> wrote:
> > > > > > has shown that multiple attachments often introduce conflicts. =
This is
> > > > > > precisely why system administrators prefer to manage BPF progra=
ms with
> > > > > > a single manager=E2=80=94to avoid undefined behaviors from comp=
eting programs.
> > > > >
> > > > > I don't believe this a single bit.
> > > >
> > > > You should spend some time seeing how users are actually applying B=
PF
> > > > in practice. Some information for you :
> > > >
> > > > https://github.com/bpfman/bpfman
> > > > https://github.com/DataDog/ebpf-manager
> > > > https://github.com/ccfos/huatuo
> > >
> > > By seeing the above you learned the wrong lesson.
> > > These orchestrators and many others were created because
> > > we made mistakes in the kernel by not scoping the progs enough.
> > > XDP is a prime example. It allows one program per netdev.
> > > This was a massive mistake which we're still trying to fix.
> >
> > Since we don't use XDP in production, I can't comment on it. However,
> > for our multi-attachable cgroup BPF programs, a key issue arises: if a
> > program has permission to attach to one cgroup, it can attach to any
> > cgroup. While scoping enables attachment to individual cgroups, it
> > does not enforce isolation. This means we must still check for
> > conflicts between programs, which begs the question: what is the
> > functional purpose of this scoping mechanism?
>
> cgroup mprog was added to remove the need for an orchestrator.

However, this approach would still require a userspace manager to
coordinate the mprog attachments and prevent conflicts between
different programs, no ?

>
> > My position is that the only valid scope for bpf-thp is at the level
> > of specific THP modes like madvise and always. This patch correctly
> > implements that precise design.
>
> I'm done with this thread.
>
> Nacked-by: Alexei Starovoitov <ast@kernel.org>

Given its experimental status, I believe any scoping mechanism would
be premature and over-engineered. Even integrating it into the
mm_struct introduces unnecessary complexity at this stage.

--=20
Regards
Yafang

