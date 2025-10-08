Return-Path: <linux-kernel+bounces-844938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F561BC319D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 03:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EA594E3E34
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 01:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C228B7D7;
	Wed,  8 Oct 2025 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgN/V3wA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A728A701
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759885638; cv=none; b=IQxStbMH9FEEnpY1miZtLpKgXHGaneVhsFzjW6DCTOSV6M17RZGeeT7s32D9wGsu6zaoTXp8YQ9XUiAQwRkZbhq6qJHKbhYEY+x+nRB2/xl4b5MxPGlVa10N3TzDnirkhbBuFkACj72zWAgyU5Ffr+4ZMW74Brg+t+qCyyKVbbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759885638; c=relaxed/simple;
	bh=zBCqyJMWlRsL+4LATvFpWbApDg0JJQI3CUv1g8acmHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dm5YGLFQh5wuOsW6BbeBp20S6a2MdxcxWmckxE0hVgstu754eUxexVQ2RbdyfxIJ03u/MK9tBDmXaTggjCe2fgvVRV1egpGFKwgjmyv51hAIZ9cTHW2olaqXrhQ8rjRMNQzYZmW6Y+OD45SyWdOkHIh2D+GaHmTXmDaH49nKEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgN/V3wA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB15C19422
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 01:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759885637;
	bh=zBCqyJMWlRsL+4LATvFpWbApDg0JJQI3CUv1g8acmHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YgN/V3wAL5l8gU911XAnxezLGZznwYAlmCRXe3Ovvevboxu0GX2EcRWaIensz5R+e
	 8z1dSIXKO7hq3F/pXbQryVb/AWs6jqG4Nik+dLdt5Sl7JtT/H9bM5g9RSIIu8CPZf2
	 Z0LhS1pRVa6E+PA3OMsh8A9GaLdMShsX4AtgRGQtmP2RFPnnT/EB+40FGp0CT5Fe7k
	 HxfE8hYtzbuQpIEBERPhdWRYGM53FARCPG+MhWzGWoX9QoyYCvq3W5YfVaZ4tnbZmK
	 e4zAkqe2ImVEIh+5gtHVYKSF1zi6C7DMKrpSkTH7jByb34vG4S5XcamUaJfS2olsfG
	 rtEN6VaSzLL5Q==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-795be3a3644so41210436d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 18:07:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5OT/0piigk65ya1Cqp6tGDacpYLZOkrwGsnj5RSeTPEsoqtSXW+ZHs2pQ6tYCKNmT8002C4D/TaNSlqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3z0UEWYYAMUTkFo/y3E1dSfIUeR8KtM4/UimL+yVFAf1/Wfn
	E06ZeBVQh+ggAKLc5xkNwkMBtKMF/JN7MUee3h2o1uqIvf0l92+PrsLHv4uswLmGES16grnT4lp
	CtKSutVNHFJQvk7vaDV/de1uZrPG7KA8=
X-Google-Smtp-Source: AGHT+IEcmF6j99P7KkUpn2/4L6HaFID6zbkjSdls+iCzttgJ43409b0C4AVN/zVkcxiO3cU7SJ9+sGQsQOMolE5AhVI=
X-Received: by 2002:ad4:5c65:0:b0:786:2d5e:fdda with SMTP id
 6a1803df08f44-87b2101ec96mr26440866d6.18.1759885636562; Tue, 07 Oct 2025
 18:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev> <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev> <a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev>
 <877bxb77eh.fsf@linux.dev> <CAEf4BzafXv-PstSAP6krers=S74ri1+zTB4Y2oT6f+33yznqsA@mail.gmail.com>
 <871pnfk2px.fsf@linux.dev> <CAEf4BzaVvNwt18eqVpigKh8Ftm=KfO_EsB2Hoh+LQCDLsWxRwg@mail.gmail.com>
 <87tt0bfsq7.fsf@linux.dev>
In-Reply-To: <87tt0bfsq7.fsf@linux.dev>
From: Song Liu <song@kernel.org>
Date: Tue, 7 Oct 2025 18:07:03 -0700
X-Gmail-Original-Message-ID: <CAHzjS_v+N7UO-yEt-d0w3nE5_Y1LExQ5hFWYnHqARp9L-5P_cg@mail.gmail.com>
X-Gm-Features: AS18NWAx-XMC-g3j9uutWYIZTxRO0r1IXmHmgo-2RkWcxjCjTc5QNe70onU4eO4
Message-ID: <CAHzjS_v+N7UO-yEt-d0w3nE5_Y1LExQ5hFWYnHqARp9L-5P_cg@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:42=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
[...]
> >> >
> >> > So, there cannot be bpf_link__attach_cgroup(), but there can be (at
> >> > least conceptually) bpf_map__attach_cgroup(), where map is struct_op=
s
> >> > map.
> >>
> >> I see...
> >> So basically when a struct ops map is created we have a fd and then
> >> we can attach it (theoretically multiple times) using BPF_LINK_CREATE.
> >
> > Yes, exactly. "theoretically" part is true right now because of how
> > things are wired up internally, but this must be fixable
>
> Ok, one more question: do you think it's better to alter the existing
> bpf_struct_ops.reg() callback and add the bpf_attr parameter
> or add the new .attach() callback?

IIUC, bpf_struct_ops_link is just for bpf_struct_ops.reg(). The
attach() operation can be separate, and it doesn't need to be
implemented in sys_bpf() syscall. BPF TCP congestion control
uses setsockopt() to do the attach(). Current sched_ext does
the attach as part of reg(). Tejun is proposing to use reg() for
sub scheduler [1]. In my earlier patch set for fanotify-bpf, I
was planning to use ioctl on the fanotify fd [2]. I think these
all work for the given use case.

I am not sure what is the best option for cgroup oom killer. There
are multiple options. Technically, it can even be a sysfs entry.
We can use it as:

# load and pin oom killers first
$ cat /sys/fs/cgroup/user.slice/oom.killer
[oom_a] oom_b oom_c
$ echo oom_b > /sys/fs/cgroup/user.slice/oom.killer
$ cat /sys/fs/cgroup/user.slice/oom.killer
oom_a [oom_b] oom_c

Note that, I am not proposing to use sysfs entries for oom killer.
I just want to say it is an option.

Given attach() can be implemented in different ways, we probably
don't need to add it to bpf_struct_ops. But if that turns out to be
the best option, I would not argue against it. OTOH, I think it is
better to keep reg() and attach() separate, though sched_ext is
using reg() for both options.

Does this make sense?

Thanks,
Song

[1] https://lore.kernel.org/bpf/20250920005931.2753828-1-tj@kernel.org/
[2] https://lore.kernel.org/bpf/20241114084345.1564165-1-song@kernel.org/

