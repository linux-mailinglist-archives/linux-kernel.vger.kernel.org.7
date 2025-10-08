Return-Path: <linux-kernel+bounces-845033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD71BC3544
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CB484ECEFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2972BEC3D;
	Wed,  8 Oct 2025 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDrxZhd7"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141E19E98D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898364; cv=none; b=X/gmwVEIqsFphKrHe5opUqenhtKvHpGIIoI3kgYFDS1vqd6Pjs1CUc0TQb1UOiTfR/pb1SXR0kUErhYf/km2q/EIxrhpDtjPIYUzsJ/SfjEHoAzQkpByh/urZkk+J4NnPjI/olI7D3cu6npLJyR+CkY5KLWPTnvJHDIm4AvWFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898364; c=relaxed/simple;
	bh=Rm3GhlyZsgjNHwG8nD1ukkMMPB/ILNmwuDjzy2VbVTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtIPHuowPCOst0U17mJ9vNDVZLkF4YMxZ3Wo+aQVFMGFEYSzYH+OMj1sEvUFI6BSECgEnsUoXU/6PzQlwsQB7fowfx1g6JJIYmmYFIGA/WZh/Gc/5Ga/gNgXwAi7ZOY4rV6MWdE5F0sKJ7k6abucSDajgHSg2MhzoWyqlw42OMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDrxZhd7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so5160779f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759898360; x=1760503160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm3GhlyZsgjNHwG8nD1ukkMMPB/ILNmwuDjzy2VbVTE=;
        b=LDrxZhd7ewlwU/7+v5hH+trhWFZ8PO/eFe9ge/Rl5Sr5PokQ8ZJ7O0447Q7tC0w3cv
         Jjqh1csIA1Mlyz+FZrTzUtw22/GqPLFrGdpzzk3SDhnii9rnROLSDNfI/5ZxCJdGGfq6
         olA6gnmJ1Qjk1D9Yv+hnk8y1sEnOqmjYN9aifckndFmU/Q+varK2nW9n6a1Rgp2LZjp/
         6soVStwb7WMj95C/B2/gTZBGQHTccZnvb236ciIBBUaF8+5Dcl/K7RHZTD+qtChK6np9
         0752Rs96/JIyR1arQHkPv6UuBOZCa8KkJSzDYZRBnVaU+o/Vz88AaOOzuVCqIR3r0TTF
         tZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898360; x=1760503160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm3GhlyZsgjNHwG8nD1ukkMMPB/ILNmwuDjzy2VbVTE=;
        b=l2MKMRLr6whpJ9pU6X+z8N7yf6WXCyfg5OeHc7M0ZVpXpIUYjv6itbUUcK8JBvgOVz
         HNrd/xBcgR9koMkvRwpFbGH308mRpL1zFMQAkouZD4mACOcuV/HsLPbWjZYLmHKD28Xl
         F6eOjohouwizWCV/OTPEwG/5Ak9rBzi/4ZXo898lxu7Kqo55AHhe4/8NYZRkGZfn334q
         MmltTPHOUdbg+oeYD1wzn58qD+ivizppynjQsbuobnAjoMzgECho1+W87Slo8NZtha2N
         MNetJT5TnpLwmvpGHjOVr3/P92plH3Z1cSOFGYjqNBPIdJYhnmO6mvRiLzCIRzE08+t2
         E7gg==
X-Forwarded-Encrypted: i=1; AJvYcCXxIgW8PNSDj4aouUpTAqMiWG9enxI8AEmXq2FUhyNZmX6oWyS7pBXhxfN+lPycrkuh7uRXSrfRQ/1pyCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypmY0uafbBtJw46W68YgwFsz5L/66C+5QBbSVX0Z3WEVhpGYfW
	t99i0KINYCGjnQbNEYMVBA3QhKPLrH3vBdXsY4We9Fijj9JRuLFy9j0ZDMc6hPFzGplINKP1AGW
	SYI8elPoBpB3TP1zaaa0FMGv75ClRr18=
X-Gm-Gg: ASbGnctbaWEW72Fr37kPqsAgDymlXuHA3hOytPUSrnFl34bom1+3h2mEn97BPg6MmWU
	mECyamLyy7SJYKmInlwyNgni1bxRSgjCJPzPOo6QyNT8IUHoLlmTxYEp1RdI16h/CJdlMtZzxyJ
	EVYBYozFSshYd8HytT9G9OFX9VDjYvovGMRljYzNyNHBg/PgNIEWEuWWee4NZ7ePNBqKs0misuS
	OACgnr6xK0yIbO9dMjnEPYZXqQiIdEBUxE9FmeXlpB73DjDas3sTvyefMgvn7KF
X-Google-Smtp-Source: AGHT+IHVEHG1C3LKLnJ8DwT6l1r997HA+wzMKAexilSB8QteathZvj8Spsg01noOe1OnIJsIlqfqCOjIexAD1RZW1Rs=
X-Received: by 2002:a05:6000:26ca:b0:400:1bbb:d279 with SMTP id
 ffacd0b85a97d-4266e7d44f1mr925348f8f.39.1759898360484; Tue, 07 Oct 2025
 21:39:20 -0700 (PDT)
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
 <CAADnVQKzW0wuN3NfgCSqQKVqAVRdKVEYMyJg+SpH0ENKH6fnMA@mail.gmail.com> <CALOAHbBzS2RunZzEk8-rkU60M8jKEJ8FwiPgZqNeoXDy++L5hA@mail.gmail.com>
In-Reply-To: <CALOAHbBzS2RunZzEk8-rkU60M8jKEJ8FwiPgZqNeoXDy++L5hA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Oct 2025 21:39:08 -0700
X-Gm-Features: AS18NWC8ZPttD2mQYRSD8-3WnTYDsNM_I1o2QCoCf1odJXXOlkBQmZekv5Q9hPQ
Message-ID: <CAADnVQKLbc4iZDGWbbhqwr8hKhAZhyLjiZuuz_RBd2f9LH45rQ@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
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

On Tue, Oct 7, 2025 at 9:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, Oct 8, 2025 at 12:10=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Oct 7, 2025 at 8:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > On Wed, Oct 8, 2025 at 11:25=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > > > has shown that multiple attachments often introduce conflicts. Th=
is is
> > > > > precisely why system administrators prefer to manage BPF programs=
 with
> > > > > a single manager=E2=80=94to avoid undefined behaviors from compet=
ing programs.
> > > >
> > > > I don't believe this a single bit.
> > >
> > > You should spend some time seeing how users are actually applying BPF
> > > in practice. Some information for you :
> > >
> > > https://github.com/bpfman/bpfman
> > > https://github.com/DataDog/ebpf-manager
> > > https://github.com/ccfos/huatuo
> >
> > By seeing the above you learned the wrong lesson.
> > These orchestrators and many others were created because
> > we made mistakes in the kernel by not scoping the progs enough.
> > XDP is a prime example. It allows one program per netdev.
> > This was a massive mistake which we're still trying to fix.
>
> Since we don't use XDP in production, I can't comment on it. However,
> for our multi-attachable cgroup BPF programs, a key issue arises: if a
> program has permission to attach to one cgroup, it can attach to any
> cgroup. While scoping enables attachment to individual cgroups, it
> does not enforce isolation. This means we must still check for
> conflicts between programs, which begs the question: what is the
> functional purpose of this scoping mechanism?

cgroup mprog was added to remove the need for an orchestrator.

> My position is that the only valid scope for bpf-thp is at the level
> of specific THP modes like madvise and always. This patch correctly
> implements that precise design.

I'm done with this thread.

Nacked-by: Alexei Starovoitov <ast@kernel.org>

