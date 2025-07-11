Return-Path: <linux-kernel+bounces-728036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DFEB022DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334B53AE7BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681F2F0C4E;
	Fri, 11 Jul 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C89xLl9Q"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061D2F1991
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255710; cv=none; b=NhrWzg25+Oklcq0oEcI6KGO67dhF67J8SvUlNrz9Q/RF5pUnLXG8wtsOVkknc8gApXeCC/zNvvi4kgohS9drA7VoN3qx00yomFudmWZvmiOKzTstoB3sTirkzNuVP2drwixCGyBeVR+ADzY1vhYIi5DxUfqWXB1cocCJyJ9PHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255710; c=relaxed/simple;
	bh=tT7wPE70oe7dzBsi7RXbG4kZfWut7Hwc/EXvaRJKRy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+UEhrsLHJzXu0y5a4oSgMqQGR21+QkvhQ/M1VZLozAmQbqwrcmuzj/7T5O3TP1iB50edX95uvrBoZOziwcUHqj8I4S4IeT9d8z26B0mQ483SNDr6idWVD6OLSc8zvnSU06Zs/6FINsGc3swJL0GmldHlYAwdvMQdWZ4BonZvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C89xLl9Q; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31306794b30so384024a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752255708; x=1752860508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT7wPE70oe7dzBsi7RXbG4kZfWut7Hwc/EXvaRJKRy8=;
        b=C89xLl9QtMMaAd/E9IWBYbE5Ad6X0m+UAOj9v5eAKywx6kosR55S7eHpXP1p4z6v5q
         RcwKnwPQgg30YIvLjcMo9nQHh8oU7BrltzXkQR6Pp6iPZ6ePbLk+IwH7IenEGxoedYTe
         VfanQg2MwQVZCXQj3XggkqZ4J59AXLtYz7QED27nSlDdL4JFJop1FLunmkwkcdgoBznl
         z0ePBwHhjwDcx5gi0GOswVQ6FO3WNT55I3idNU9QzeNhBOeQHUU0N4AXgpDPbIrQ0AUu
         KAZmKg9SX3uVzKtw/PUlKlE7wg5pwlYafMu1GEHyjAIbwHRE0JWPnRgcxI5yvXTBLl/g
         8HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255708; x=1752860508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT7wPE70oe7dzBsi7RXbG4kZfWut7Hwc/EXvaRJKRy8=;
        b=cT9rZGfOJxIx4say+l4DWHiLZpUVsF89wSSlcDEWU/piK6dH8J8REPapJI+SaAehWi
         ZprGteF2cWf8AJc7V8QApJhN8F0xon8VcMZH95JBP84niiPib4zvuVb91Nt0V94kCYfI
         A7C/5sB5ZIpg4qiDqYZPkO1dJSkUsHF2Z8jhD+GO6tm5BTp9H1qUy0OB41StliUdpIK5
         4xjPPzK1l6rB57k9Lze+cCOjx2dkSkoUmmwdaOnJrmwMRoFxVFWxCHp8ONz9GZCGI+p9
         VLQ3E6EMxlVzQ1qEvvFk7K28D4sTKm70EJ0O0BX2cwMP2zbDy3Un7O9WpIPg4SWTT2+E
         2Fpg==
X-Forwarded-Encrypted: i=1; AJvYcCX6ICsjMEMTPJPbHUy5oUj/Z+1niG6z2izarpKdRsaRNLXpniBZcVXjlbwYoq1Y/+Sm4acg2dv2frmuKo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9Q8fTep2N8qwTwa47gYN1xt13b0UjQaTmB6UpLhRiEWz/HEJ
	M7r6w1rcd9NksrAHRVB7ro2ui6tGZYxP6pgsumGbHYEYqiF1sU7js1Flt4UV/SFj98jKtOQJkEF
	V79DQegxEC6W9A6zBV8RePgF3JZIV2eKQxbGCyae41V1uyrCWeaqCXus=
X-Gm-Gg: ASbGnctuWrD/61LvBieECuztRBsfJH3qSdOYwm4T6avSm0nsglgHta56sb33S7LWYsh
	IySV3VjPxB0H2TKCyLNP1HMRIuWCJ4dXwe3Wgxyh3HkJfcgvjkQhTQo9E5TBOelKqH10ewYFCwW
	UMME0MjvMr8B7MNz1mfTXDA9DxbbSUNH865r4aE7z5U3jo3nVoqIGVODcSLuvMwh415kzfZ1KCW
	KEpWvs=
X-Google-Smtp-Source: AGHT+IFMl4SOsBNCWSNMVioKK3ph3e85yFGBL3ByOiB15jaiAYdBhfZ9gIl691PiBIkdZctaSd5iyta4TNPAm0XoiR4=
X-Received: by 2002:a17:90b:3cc8:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-31c4f37b71cmr1911945a91.0.1752255707877; Fri, 11 Jul 2025
 10:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711002322.1303421-1-cachen@purestorage.com>
 <CALCePG3a6wG+3Nu7-JHha+LMtyRRNF3sXp13sS-=Xv1pvsX09Q@mail.gmail.com>
 <fhy4rcjrwwmlebgoiwepmga3fovxdvqeylsub6lk3opl2fi2td@ucuwdpu4ua7r>
 <CALCePG1h8NE010EGpBh8CxhiWqr4-GantEJ4P0Dnck+cnioBiw@mail.gmail.com> <vyguhk4hzhf6zyg6hn77satnmsrsr5hmcl7bifws32bnilqbs2@374p6che72yz>
In-Reply-To: <vyguhk4hzhf6zyg6hn77satnmsrsr5hmcl7bifws32bnilqbs2@374p6che72yz>
From: Casey Chen <cachen@purestorage.com>
Date: Fri, 11 Jul 2025 10:41:36 -0700
X-Gm-Features: Ac12FXxsYtMviMJqxEQ9G8qJWSE_VTggBxwThpyFF_kw7PGNiKJUHiqTVkGYiMM
Message-ID: <CALCePG0gw9aJM5dWWxrk1Vh850kOB4wDqvmsuwyM-4q0QAz1Qw@mail.gmail.com>
Subject: Re: [PATCH v3] alloc_tag: add per-NUMA node stats
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, surenb@google.com, corbet@lwn.net, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	yzhong@purestorage.com, souravpanda@google.com, 00107082@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 8:09=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Jul 10, 2025 at 06:07:13PM -0700, Casey Chen wrote:
> > On Thu, Jul 10, 2025 at 5:54=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Thu, Jul 10, 2025 at 05:42:05PM -0700, Casey Chen wrote:
> > > > Hi All,
> > > >
> > > > Thanks for reviewing my previous patches. I am replying some commen=
ts
> > > > in our previous discussion
> > > > https://lore.kernel.org/all/CAJuCfpHhSUhxer-6MP3503w6520YLfgBTGp7Q9=
Qm9kgN4TNsfw@mail.gmail.com/T/#u
> > > >
> > > > Most people care about the motivations and usages of this feature.
> > > > Internally, we used to have systems having asymmetric memory to NUM=
A
> > > > nodes. Node 0 uses a lot of memory but node 1 is pretty empty.
> > > > Requests to allocate memory on node 0 always fail. With this patch,=
 we
> > > > can find the imbalance and optimize the memory usage. Also, David
> > > > Rientjes and Sourav Panda provide their scenarios in which this pat=
ch
> > > > would be very useful. It is easy to turn on an off so I think it is
> > > > nice to have, enabling more scenarios in the future.
> > > >
> > > > Andrew / Kent,
> > > > * I agree with Kent on using for_each_possible_cpu rather than
> > > > for_each_online_cpu, considering CPU online/offline.
> > > > * When failing to allocate counters for in-kernel alloc_tag, panic(=
)
> > > > is better than WARN(), eventually the kernel would panic at invalid
> > > > memory access.
> > > > * percpu stats would bloat data structures quite a bit.
> > > >
> > > > David Wang,
> > > > I don't really understand what is 'granularity of calling sites'. I=
f
> > > > NUMA imbalance is found, the calling site could request memory
> > > > allocation from different nodes. Other factors can affect NUMA
> > > > balance, those information can be implemented in a different patch.
> > >
> > > Let's get this functionality in.
> > >
> > > We've already got userspace parsing and consuming /proc/allocinfo, so=
 we
> > > just need to do it without changing that format.
> >
> > You mean keep the format without per-NUMA info the same as before ?
> > My patch v3 changed the header and the alignment of bytes and calls. I
> > can restore them back.
>
> I mean an ioctl interface - so we can have a userspace program with
> different switches for getting different types of output.
>
> Otherwise the existing programs people have already written for
> consuming /proc/allocinfo are going to break.

What does this IOCTL interface do ? get bytes/calls per allocating
site ? or get total bytes/calls per module ? or per-NUMA bytes/calls
for each allocating site or module ?
Would it be too much work for this patch ? If you can show me an
example, it would be useful. I can try implementing it.

