Return-Path: <linux-kernel+bounces-845001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328CBC3403
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8BC64E9114
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9542BDC32;
	Wed,  8 Oct 2025 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g26q1F5t"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC032580FB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895462; cv=none; b=s9aLQJf1HkNa3mLls33x7vhJs1x/zpHoVXUMJDUgCYWiOQzQU6RWALoephvhUvPMKAbSc2G0uuDDp3eCfOW7AGWSh30oqKVCXXpDle3e45QU1ktS26w4OoYJLtIvmJqIsS5pgssky7OkXH9FEJBZLmwO/kkny/pVwP2l0eMfALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895462; c=relaxed/simple;
	bh=901RhySNqmrBkBO4w25nUFBvli0tFgYz0eeMo+iVEWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePwo3FUNQR6b0aMYTfH/rkr0P11J+4KYMmaMFRlfxFclpw93c/o0nvKkwpMPz7xyNEgmBGfcCR1nJQ2KazqQ5/OFSz01yBby/ZyIlWKasrVVdW+NdFJjJKjW1maxzPH46do8MxlhGwhfYJpBH+PnVab9b3b4d1kGTuO/ZLnSHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g26q1F5t; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-858183680b4so855796885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759895460; x=1760500260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+jx7n3Xx/N7Z5ReLNJDr8EPoJ485g4LVFHysMmcuts=;
        b=g26q1F5tJ9fddPqlCdRqko+c60Pw4p7iqGbZEB1YgrTKfCBz/01a66NdoR/XuyCnge
         mfRzuZ53tpvnx6hqYKVNYA4tCtLEyIPSSf4JfSHVeM7/8M+0VUHNKkn21HLcDX6It7gW
         ZXNm6RxOLnL44075fAwmpxAPesTG84fCn+mLM20kJf20aFFxftJ8blYHVuUsB8DFyj7/
         vf/MwnN36j4SavmKr14avJyca0go9Mjttnh/OYexfbmVH0zh0Q3Bo33zr18QndVpLDJC
         /b/uVbTKi7TxdrKbtWey3uVQ6iRFkzz0w/zhTQ8olMlf/AL6CGZZKCAp7hV33fkJQ5tx
         hHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895460; x=1760500260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+jx7n3Xx/N7Z5ReLNJDr8EPoJ485g4LVFHysMmcuts=;
        b=nhzqvdxlB7fEwEf7T8DU+a70NVD4198h6pANRzpsAtT23fTyHQuhFElHY5qi70Xu6y
         OblUCy9yQ+saFs5FwOroOkYBTJ147gxzxLvVKUA422Hr3ZMAb/frWVA7Ec1FLb+csU1n
         BbgmMP6o/PfLcpzzCMtKYdWaJWKslvqLaPVKo0Xj0TAQBh0x7NgmhK61egFXK+1E7AGo
         T/qE01AadTfzaGGIOXdzjFDV87qVWIDTUgLsfLIpXTRLbiNt19GMrc9PuDKqsVBZxEdo
         QzH5Shs/240togUZ7WQIdEJy53Ne9U2BsYEWtkcaUjRCEhvxbKpjYdJ7wAsj4YAxIP25
         E/dw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Fj7WTUQXgq8K+D85t09THwz56JgCtyMBGqKxgEMzhDGD3AKuyZi0kIIqyWVpqtrQokc2R0R6vkKELNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygE/ByREIPrbNMLSZR5UFtC7soW2rZ8CRviRYgMz7zuAB6H4t9
	nkmXbsDoh75fAFGlmRBWoxHbzfrZRsC5CvmMpLG0Dvdfsxbc6PtgMbsKp/gjJ9eniSRUPhvaR4y
	0PaV9sgymHnPcpdlPisCyRrktye0w4lc=
X-Gm-Gg: ASbGncvHy/sOcyX/7b/ZRWKTB43Y2RmRA0Gw2UzydXoGUoZtvXR9WBpNKzTY/MtXxiv
	vLmytFtkcuDecxiBiFwF0nsQqThUJWJXScQJXdjIIm1lk7TjY9OZnuGPeBspqqbWU/gy52n6I1h
	mCyQhhUDFxE2IqPBPPSyqnWtjDqivVtAnOFxNzrQFQEp6kDMtDmmO90nruEfV/2FEUW8u4LFF5O
	nYF6lnEgGTLv+b6UDM3cwolj9BEnk9gyDIN9ezlMU/5xALyx13FUBMrkdNL3xry
X-Google-Smtp-Source: AGHT+IHII1V1w94JvtgMvnbeLHT8eBxHxQJa6TROlR1NDzQLk2GySyA7HWBaodCNt5MXTv85m0/XMhRKG6JZ8VcoTLM=
X-Received: by 2002:a05:6214:1301:b0:7e7:a043:59d1 with SMTP id
 6a1803df08f44-87b2ef36f58mr22758916d6.44.1759895459595; Tue, 07 Oct 2025
 20:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com> <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com>
In-Reply-To: <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Oct 2025 11:50:22 +0800
X-Gm-Features: AS18NWDo6G0yUgBTxh8Ver-mea44VVIk72GGjRNlFLV7d6fNMUbUH3UgINnuRYw
Message-ID: <CALOAHbBcU1m=2siwZn10MWYyNt15Y=3HwSGi7+t-YPWf0n=VRg@mail.gmail.com>
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

On Wed, Oct 8, 2025 at 11:25=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> > has shown that multiple attachments often introduce conflicts. This is
> > precisely why system administrators prefer to manage BPF programs with
> > a single manager=E2=80=94to avoid undefined behaviors from competing pr=
ograms.
>
> I don't believe this a single bit.

You should spend some time seeing how users are actually applying BPF
in practice. Some information for you :

https://github.com/bpfman/bpfman
https://github.com/DataDog/ebpf-manager
https://github.com/ccfos/huatuo

> bpf-thp didn't have any
> production exposure.
>  Everything that you said above is wishful thinking.

The statement above applies to other multi-attachable programs, not to bpf-=
thp.

> In actual production every programmable component needs to be
> scoped in some way. One can argue that scheduling is a global
> property too, yet sched-ext only works on a specific scheduling class.

I can also argue that bpf-thp only works on a specific thp mode
(madvise and always) ;-)

> All bpf program types are scoped except tracing, since kprobe/fentry
> are global by definition, and even than multiple tracing programs
> can be attached to the same kprobe.
>
> > execution. In other words, it is functionally a variant of fmod_ret.
>
> hid-bpf initially went with fmod_ret approach, deleted the whole thing
> and redesigned it with _scoped_ struct-ops.

I see little value in embedding a bpf_thp_struct_ops into the
task_struct. The benefits don't appear to justify the added
complexity.

>
> > If we allow multiple attachments and they return different values, how
> > do we resolve the conflict?
> >
> > If one program returns order-9 and another returns order-1, which
> > value should be chosen? Neither 1, 9, nor a combination (1 & 9) is
> > appropriate.
>
> No. If you cannot figure out how to stack multiple programs
> it means that the api you picked is broken.
>
> > A single global program is a natural and logical extension of the
> > existing global /sys/kernel/mm/transparent_hugepage/ interface. It is
> > a good fit for BPF-THP and avoids unnecessary complexity.
>
> The Nack to single global prog is not negotiable.

We still lack a compelling technical reason for embedding
bpf_thp_struct_ops into task_struct. Can you clearly articulate the
problem that this specific design is solving?

--=20
Regards
Yafang

