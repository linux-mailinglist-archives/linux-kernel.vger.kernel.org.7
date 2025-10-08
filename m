Return-Path: <linux-kernel+bounces-845012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED52BC347E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8183C451E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206572BE7B6;
	Wed,  8 Oct 2025 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfuGdehp"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826D2BE7BA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759896641; cv=none; b=OUFEKflMhZbLFVibsF9H7raD0PJuvtYQf3X66Q/nh2d+/0U8Dwr4pizR5asMCmOdoJTNwVJo0v6YgKl/Lvxr6DI8QvwTLYCekum3vu1S1Pf+Y8onCgH3nd+o3ss6br7j14kcyEC5oSoJ+bhj4/79T4LfAn5l9x9tJI3NOxQZkHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759896641; c=relaxed/simple;
	bh=k4kMP+g5RiEZcnhoRkeve+Z9tYSilH0RKGWoeHvR8Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Et1KHenXVydbH/3y1MgMlO+7hl9tNpkNDczys/jIt0iH/Iaf0o+zCp7cSadH+SDIpBDBwPOFKCmF/12hTv0O0vC5I5gFTvelhFSGiXaSI7kwdhiobp4Y1MZ+tcuEye9P6do/9Hg3LqliSCg6iqOc4rpf/SEZuq4/Y0wKb96kx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfuGdehp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so1732076f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759896637; x=1760501437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4kMP+g5RiEZcnhoRkeve+Z9tYSilH0RKGWoeHvR8Vo=;
        b=AfuGdehpws8psHDrxjZiAT5/r9OcqLXrTk4VEW5ru2d0xrcL45TSgJoiWjkR+6MJ5g
         haxSIicFpoCjIqdLfDaTA4kduBhaltToSSUFgw4AgBQC/C+bjahqW1DrFpWmPFSJqu67
         qxoXepTbQAbnaQS+7vxJeGBaIqieixnJrHbWLiodTFypiJSXz6UhbbQTJZhOkTTG5b6T
         I8uLUVICXLqsr6GLNB9bRt6EIhZNHnxBEDss5QFfHTi3mNKFyqh7FMBuhxkmfZSbwQS3
         Bd8KruVFfgqGT28dD6DFBFy6ZPvqCT0iUuP96KHuzblKZfzL4MGwAuu6/orGSr0voCdL
         TopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759896637; x=1760501437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4kMP+g5RiEZcnhoRkeve+Z9tYSilH0RKGWoeHvR8Vo=;
        b=Y4AdDb0iJp6sejXZxn2A9Q0jUi/4l1CGhTqOaCrXzvMBGHdXHm8TGR21WKUd8aq7Sb
         gG/ARmK3GXzhBcBv37J2DAqJGOpw7WXv6man5HSmFBjHPTsV/oNC/hQZZx5qqIc6I3kn
         T/JjAodQAZYjLlgyI3e3tJYVGkgi2EW2Z1RsRX7Ir5ZRH1nilkjnVyuav4RbWdamG11G
         OdMcwAe6IfBqQUo/eBv+THOQRxztF5Oux+OSi60ySxTX+hFwXUziEH3Xm89/QFxWI98R
         lEONsHsvLHt3AHLNa3bsXF9ylIFpQBl7qWjKgU1pbL02SEa/cuCiGbMC+fzmfXoIbiMj
         bGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSfJh8WDqaGnQpPXIf4oFgmFfebZe5e+M/dmELJFhXxeE9O6mB/RZGuBgpHgHOA4ALuINAdFSI8+v5SeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUZFrOAb2xHHim7D6BCHVArYemTKP5HRVAfy/STT4cLbeLTWo
	A2EfS6rXE11J6fdvr7ZpdbW5LkCKzLcmK65pkcppX4vRnqXpTXWmHv8BQkJfkDXRarryZLXSS/2
	jVbBGUrDIxQYZnFbbtSFXJDKv4PH4WcI=
X-Gm-Gg: ASbGncsfoyzSreHJC9FnjTqq57aoeQ4DtYvcQTDqSr1vMIUBKWLhHVC2F9ShXaya3J9
	WEr+4fH+eNdhqzN2mn2DxRgwdM6NywJciPdhtXFozyv4MXkVfbjpxmEOd5DS4iL2GH5KyEZNYdT
	A3wk1PWvzfdRnZcvQlcJwXu9rIAPdxapFNHfuH76zZg4puZCnG2xPG5MDfxPBlLD7wdPOdF+VGR
	thRhe0dgbJMiJppOQ+AQPz2pMYaDGxJv7+eppleDCYKRCvoHBJJk2EGDbJaC3Glhnpl2cKgDOA=
X-Google-Smtp-Source: AGHT+IEbTF1Padja2a5VYTPxu9e01sfQgU7xUDhedDQcSi45ZcqbFc2By50SOlGmeATDd+z0rHt0ZHSn8owfVsEk02s=
X-Received: by 2002:a5d:588b:0:b0:425:7f10:ada7 with SMTP id
 ffacd0b85a97d-42667458124mr907732f8f.20.1759896636654; Tue, 07 Oct 2025
 21:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
 <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com> <CALOAHbBcU1m=2siwZn10MWYyNt15Y=3HwSGi7+t-YPWf0n=VRg@mail.gmail.com>
In-Reply-To: <CALOAHbBcU1m=2siwZn10MWYyNt15Y=3HwSGi7+t-YPWf0n=VRg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Oct 2025 21:10:25 -0700
X-Gm-Features: AS18NWAHpHX-o2MgG3uRPCIrdO8_WsGJ2z7_dnabrBdSIRdjp2sl6QIslommR8o
Message-ID: <CAADnVQKzW0wuN3NfgCSqQKVqAVRdKVEYMyJg+SpH0ENKH6fnMA@mail.gmail.com>
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

On Tue, Oct 7, 2025 at 8:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, Oct 8, 2025 at 11:25=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > > has shown that multiple attachments often introduce conflicts. This i=
s
> > > precisely why system administrators prefer to manage BPF programs wit=
h
> > > a single manager=E2=80=94to avoid undefined behaviors from competing =
programs.
> >
> > I don't believe this a single bit.
>
> You should spend some time seeing how users are actually applying BPF
> in practice. Some information for you :
>
> https://github.com/bpfman/bpfman
> https://github.com/DataDog/ebpf-manager
> https://github.com/ccfos/huatuo

By seeing the above you learned the wrong lesson.
These orchestrators and many others were created because
we made mistakes in the kernel by not scoping the progs enough.
XDP is a prime example. It allows one program per netdev.
This was a massive mistake which we're still trying to fix.

> > hid-bpf initially went with fmod_ret approach, deleted the whole thing
> > and redesigned it with _scoped_ struct-ops.
>
> I see little value in embedding a bpf_thp_struct_ops into the
> task_struct. The benefits don't appear to justify the added
> complexity.

huh? where did I say that struct-ops should be embedded in task_struct ?

