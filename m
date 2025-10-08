Return-Path: <linux-kernel+bounces-844989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF603BC3394
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA1D189E5E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D397E2BD015;
	Wed,  8 Oct 2025 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izS7O8Nb"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187929E10C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893943; cv=none; b=HuHOCeoIB7v0oIVN9gCIxiUzM4XH1HJy8Bj0LsANEozatFtZiSij/pgGdL6sGuQdh1TwSZBg3uSJOf25lcngUYO/DI+/Lhg4sZDaxNWf9/FF8Hg66EHEGx0Ne/rwLrdMdLWGwgcKjYChjjdfdjO8D5MbbjpQyX8OvdYTMk8RXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893943; c=relaxed/simple;
	bh=Aq7/8dQHrmRmSKQ6xABjHJxjL0wL6AjJEcMgMgkiMrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMyvNk9PN+jv14bGeSm8kAVdOb2d+Csykh0g1440g3S03z2eDmqQzYV0CmvCMj3bGTycguuyiyK0EC5AKbKDhGeqJJAKDVsjaIK4xa5lRlaccX0/IqkDD68ei5a4Ah9gBqca06vN5dkWHnytHKUAFdetsG4GqDgIe0u5EPfhy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izS7O8Nb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42421b1514fso3267317f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759893940; x=1760498740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq7/8dQHrmRmSKQ6xABjHJxjL0wL6AjJEcMgMgkiMrU=;
        b=izS7O8NbWYd+JSuU5aTA2hEJWpUrKX29TsPeun8AgpoaWyq3lQCmWi2HlRDzFg4PU6
         1kBe4Wl0BsGB7vMbK59U1/S3nRlXIwYrHCaRwg0TFEiVfvn0z587IyJhv1+IZc4MaV9o
         sBr5nybTfNEI35upT/LeA2lGAiIGSEFP2EkH4ETqyVGyok6LsvovkIRWpAls5vGuWkyk
         kbp6uAbjs6i2nKLWtHcd+s0SdepO7n13cLWdp+XwwlSRCLM+p4jm7AwQxb6Tnwpvzo1C
         7iWmbOEdzCBgm6MnTt6cn5QO+qGgelEt6FW4cyKxeZuPUnYgRw/Jj47WzzyYxrDyjk20
         XoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759893940; x=1760498740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq7/8dQHrmRmSKQ6xABjHJxjL0wL6AjJEcMgMgkiMrU=;
        b=F57lU+faUZSJ4mtPecq8srTsvcbQC/2+Qtfd9X7IyYz86Lx+m6f3JAScl5tGwb/pq5
         SyrFR80MsVVI2lpaHGF+1VpT9jFcRyM3DMNqfgCwIRPsHS2QR1XI8GrdcEuIdgbXGirM
         2uEKctRNWhcKeoEw2vwo2hkgem3WyL/LkJCKPZ8zi4iuJgrj5M9JD1n2huVu2azZRS0n
         kzR5dONGMC4P7JVBTArs0g5s2nChkHTJNT/AHOwB2NH03D5KBGwN/nEXp5HBwiOqb0Xg
         EV4aH8Zk+cUp0w82dDpq+Rg0xdyFOuF5Mu7U3F3q59I5SwIVhF7vTI9r5eWCPmU/atkv
         hZrg==
X-Forwarded-Encrypted: i=1; AJvYcCWUoCu2tEpUvmmFfIbQlC/det0OckZQvjuchsa3haxcmCDJRwP5LXe4sroVfDjzlCf6M5fwWpNrDhJBnKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84PZqcPo5nxy0CKHTtIaRf0r2GpRxCVLP/H7hIeQz6p1erXoW
	AKKmbZIbBxhakNvizaX9lGK+YAE8GrZgYo1oi29apclHJNm9QyoJ/d3nkILtlAKBrFz04CiJU5r
	SmlZh3AqZT+1gEGcn6xkEW7Hdd/x62bQ=
X-Gm-Gg: ASbGncs3OVtKSUL2pvr5vmmOgjIwQB7RcJUZuFTA5qGApcADyj8QYBcHT7vsm/mKThP
	1jFJHXHTIagMjfE9Z+2XXj6g9U6fYvsN3+7z/pP+tfIOuehkzwTJWQLyMoTXrmUkUjcq3cbkzt0
	DQJtzFl7Y9VG61FM7rTvQY4mmnIyWBgDDQp24gv31T/6FevZd8tCtScyUhyttoiw2jBv4lfrKd1
	Od4pCQ9az4rG/sEnED8Thi7uSTfI9uVGl2RxPRWzq8mqMwWd81Mpt8+FcenuYcz
X-Google-Smtp-Source: AGHT+IHeswXWseQTzOZVDgPDpClSJjRdYqa3Gk+TNJHyXQ0PCdIukEVOo3TQExJxoJHeGY0CBioSlo3kBJaFQswByNk=
X-Received: by 2002:a5d:5d02:0:b0:425:7c1b:9344 with SMTP id
 ffacd0b85a97d-42666ab87c3mr807115f8f.15.1759893939583; Tue, 07 Oct 2025
 20:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com> <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
In-Reply-To: <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Oct 2025 20:25:28 -0700
X-Gm-Features: AS18NWATPwVk-W8hdC0xrQiJYrJaEbx7Di3QWbBv11leFl2ACmYaQhhy44lYgpI
Message-ID: <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com>
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

On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
> has shown that multiple attachments often introduce conflicts. This is
> precisely why system administrators prefer to manage BPF programs with
> a single manager=E2=80=94to avoid undefined behaviors from competing prog=
rams.

I don't believe this a single bit. bpf-thp didn't have any
production exposure. Everything that you said above is wishful thinking.
In actual production every programmable component needs to be
scoped in some way. One can argue that scheduling is a global
property too, yet sched-ext only works on a specific scheduling class.
All bpf program types are scoped except tracing, since kprobe/fentry
are global by definition, and even than multiple tracing programs
can be attached to the same kprobe.

> execution. In other words, it is functionally a variant of fmod_ret.

hid-bpf initially went with fmod_ret approach, deleted the whole thing
and redesigned it with _scoped_ struct-ops.

> If we allow multiple attachments and they return different values, how
> do we resolve the conflict?
>
> If one program returns order-9 and another returns order-1, which
> value should be chosen? Neither 1, 9, nor a combination (1 & 9) is
> appropriate.

No. If you cannot figure out how to stack multiple programs
it means that the api you picked is broken.

> A single global program is a natural and logical extension of the
> existing global /sys/kernel/mm/transparent_hugepage/ interface. It is
> a good fit for BPF-THP and avoids unnecessary complexity.

The Nack to single global prog is not negotiable.

