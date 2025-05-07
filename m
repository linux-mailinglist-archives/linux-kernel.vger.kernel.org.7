Return-Path: <linux-kernel+bounces-638720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5FBAAECAE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 22:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A527918944B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC4209F45;
	Wed,  7 May 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nR9sGH6m"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C571DD877
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648453; cv=none; b=qmNv9gqoUpxMPSLMDKsVsMynXCBBnXwMRA/WHKbSxVr2nFinqikDLvVLsAt8ea1QwoTx1nPMRDusId0IN7+i8Jm0fqWVOHgJ5zwkSQKGuVr6bsGlrJ6yvG4pXdzJNtZH5qqrBLrlFETYPwCqVgMCe8NdwsC6Ke7DelfgTfsKx7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648453; c=relaxed/simple;
	bh=w3+3KeoElHyRcJVg0RmvVvE2AsXALYl4aJ8aofm6AIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4SGzstNsmVvVwjJKfWJqpZ5d2Ook63+mLuZTL1+4/5uf38XWQQu5zFZoRxdzCxnR6ztjyOFpG/yvfB7fsAw+QTSJioqyacyPeMIT5SelcV6dw5wjBxya7bf6IK0icBaSCo63Su4RtzZm5qLYC87ncLyqvE/Mpuv0u/xSptM/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nR9sGH6m; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so431885a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746648450; x=1747253250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3+3KeoElHyRcJVg0RmvVvE2AsXALYl4aJ8aofm6AIM=;
        b=nR9sGH6mEVA0ualXnhIOf0eGmjnyrDHYuzJUMqEMAoObxGxGWidjHKwv0AV+qNho6j
         qzESypGJu7PliTxYnNFSHroPKe9sAYq2Bgrp3XMBI2+gaJe9sYRE+wmgJuGf9lYJJRwJ
         t3iszg+DfQ5KgS/Pz/+EtXWXVAtmIr37Y+cRY4Zig8fn7EpjD0M9w9UU2VesTXbIR+9R
         nDHi2YF9X9afEtubAbtTuWyRHcqQ+2xX/GutwbWAU8yct3KW+PJ902WrLf/queUAokpu
         lUz+rGzWI0NFKjiIY3mb+lPSjCe4YrIXGP+A7RxQZ9QGCvDwY0BK4C06j5RbMol2RpHI
         fxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746648450; x=1747253250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3+3KeoElHyRcJVg0RmvVvE2AsXALYl4aJ8aofm6AIM=;
        b=sCVg7YEkxSH8Ei46YYjYJ3HhMU6a1rDYyF5uZsaHOGESvTV7E2h4tY399sYmsL6qyD
         45gGEUheEnuck9B0pfBoNQZZlo+JYrInNdkIvkGIKvSIo3rfSAKbPf7t5RvZ669epW9a
         8ybALAeoI7SkyZMs1XpzcSd3Ftgn2EsPiYC+iHbH5Jw7M/1Bbz73Kn7qAiAwGqaAJSNU
         x7ZCUplzc1E5DXeuJHTVYAOoIT+p/KVoCw39EDEEj4Jd4zvhUP5NZytvdJJOql0QhPVV
         5qjljlBYHW3V79YrABOZ0lIGepfs1RRWjG94KD4i599hDn+cUYSly/errIooKega7D5s
         J6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUYK/dw8jVvI++z5mZQrL6avcqVpQeHsRSNdIQ1/NjL7zgW2oUQd2cWp1zDoShQSHB1IxcP59w/4nZTSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZ1om70dsO0qVzi7V8EIGUDVwYahGEED5PFQdD2hf+O860Oar
	NiCPel8t5JXx9HnZsxncqrdkK4rq44DGv4D+NbtPGjVDggAx0e/XCTDwqxFCro7mgc7iEWHlPA2
	WXLnr70Tel3KTpUIeHjrAVKDCaZboltb5B3C0
X-Gm-Gg: ASbGncvn3QdlaA0gKTI0aJceAiOCHS9iWqHgmTu/M4mQVA321rHGfYjbBayzbGiBLdS
	K8VwjM7CoV0u56A8npdsg9e1WRAv5zA+bpfzmuHQ5ahH0fH08bVQK+JHzmcXDs2BgcTNebEJQuu
	lLiXfZReX1S3Td6CCoC4jUg9hfZMCmMMyOTmNHP8YTaJdMOmINZA==
X-Google-Smtp-Source: AGHT+IHMvqtGEgVvR4tBa+A7od70iCjCW3khzHB4JCJtIHlviqns0c3QvfPzORetkebMitf8d5H+ROVKAU7eJw0lMW0=
X-Received: by 2002:a17:907:c287:b0:ace:6c29:a98c with SMTP id
 a640c23a62f3a-ad1e8cd7709mr423668766b.37.1746648449789; Wed, 07 May 2025
 13:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506183533.1917459-1-xii@google.com> <aBqmmtST-_9oM9rF@slm.duckdns.org>
 <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>
 <aBtp98E9q37FLeMv@localhost.localdomain> <CAOBoifgp=oEC9SSgFC+4_fYgDgSH_Z_TMgwhOxxaNZmyD-ijig@mail.gmail.com>
 <aBuaN-xtOMs17ers@slm.duckdns.org>
In-Reply-To: <aBuaN-xtOMs17ers@slm.duckdns.org>
From: Xi Wang <xii@google.com>
Date: Wed, 7 May 2025 13:07:16 -0700
X-Gm-Features: ATxdqUG12XZN0hFzKilXUEhBsiRwGA9-TUpz4QKBiobL8v5U6hVTVFV89NOFQoM
Message-ID: <CAOBoifiv2GCeeDjax8Famu7atgkGNV0ZxxG-cfgvC857-dniqA@mail.gmail.com>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	jiangshanlai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:36=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, May 07, 2025 at 10:23:24AM -0700, Xi Wang wrote:
> > Overall I think your arguments depend on kernel and application threads=
 are
> > significantly different for cpu affinity management, but there isn't en=
ough
> > evidence for it. If cpuset is a bad idea for kernel threads it's probab=
ly not
> > a good idea for user threads either. Maybe we should just remove cpuset=
 from
> > kernel and let applications threads go with boot time global variables =
and
> > set their own cpu affinities.
>
> I can't tell whether you're making a good faith argument. Even if you are=
,
> you're making one bold claim without much substance and then jumping to t=
he
> other extreme based on that. This isn't a productive way to discuss these
> things.
>
> Thanks.
>
> --
> tejun

Yes this is still serious technical discussion. Frederic made several "we c=
an't
have b because we already have / are working on a" statements which were no=
t
very actionable. Deducing to a particular case is a quick way to simplify. =
I'd
prefer to focus more on higher level technical tradeoffs.

Overall compartmentalization limits resource (cpu) sharing which limits
overcommit thus efficiency. cpumask restrictions are not ideal but sometime=
s
necessary. Dynamically configurable cpumasks are better than statically
reserved cpus.

I do think the cgroup tree structure sometimes helps and we don't have to u=
se
it for all cases.

-Xi

