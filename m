Return-Path: <linux-kernel+bounces-845107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0ABC387D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35AA94F3749
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794812F0C75;
	Wed,  8 Oct 2025 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWSKKDAE"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF201A9F8D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907030; cv=none; b=J1LcuSGujUfoJzohRc+x/7ZtSRGg3G2COHC7zTkluK4xsWNbUylAeg+9fEY5ahyhOxc/dz/M0hGzjDUoYzNTLDdfIbKXppoxmFO3rKdeQwQ85KC7PHPa/IN2YX+/rPGH0kiCtazEJGCdIAYYNOSROTyGhXLVA7nw6T/5oxrtwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907030; c=relaxed/simple;
	bh=ZIBontMI3JXOfH0koR9RkZgD7vrZZLov/LpVr4jsmxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rg9qxW0TRqy5xO5MGyivgnjT/6c/SfF4D47MLG+N7gWIojzz1+dwUbmb7P53f/5rY8bmYW4zi6rPj3809McGU9aV2yVi834lrzSxY+UKLFS9Fve0kssPRVakoZTLCBi88yCSkvNRd+wbNfNyVfOmHlGPsorSTsP3eBNSXAByDqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWSKKDAE; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70ba7aa131fso77174886d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759907028; x=1760511828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIBontMI3JXOfH0koR9RkZgD7vrZZLov/LpVr4jsmxQ=;
        b=GWSKKDAEvQrV7su8NC9s0viCQk9hrOTV3vHcDiJZpbP2DslEHA05H+E5qd7IiAyd24
         a4HCrSnRoqrKoElO1JHha8Nw1MfJIhYLRWw6WLaDX72XA4UTze7PS8hod42l9thQWIso
         00QzSfgVdQbVS6ix+l1w1FTbY1nMPdvYQza7+a3dG4x5PRxvM69TAKiqD5+j6cwaEVdV
         6O4rM918JTTIBudbCn5rcwAnzx9E7mVUWB9lD5sNOpup9QVUO3yux1uLNj5ysj4Nbit4
         gQmfLptggOSxpCuJF2xovP+y2pCaiwzvTZeWVVpm6+pOFhYDw45enUhYznPFZWehyAMi
         haGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759907028; x=1760511828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIBontMI3JXOfH0koR9RkZgD7vrZZLov/LpVr4jsmxQ=;
        b=du9WfvopDOPQmTZ9jWj63+cjAo3qVwi4askn4meXhfYUXrChLuDpvy1yaGq9U045RG
         l6qbq/nJfq0Eyu0sNc4FT5LaU9yPqrur1nAO72r8NBR8hpdVlTARcx5gcIl6wAxRK7aW
         Zbe9DAhXOhIDkDEYjA7AChws0uMXIvF1YNJu9RoDoCm6aCECzZZAoE1peO9B7wcL7C0j
         UJ1kdyggml7pzuHFl8ryWtvguc89cwq7lgMmKNRGOeEBcQLtYwNnFOFCKmdolY0vRQMQ
         FoKacrHho7Q/UOYuQWR2jmTRFqqxY5n+ckkfLm10qrasPIej4/eBt+krUyzYfnjgzZvT
         9DPw==
X-Forwarded-Encrypted: i=1; AJvYcCU1IxfIYiHXdlaKZk56AXar594tCRH7HtlvDuuSjDx7LYq950Fw8bS8XhgcQzL4wlZvpld0fYGDKOUdkBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxxu8jVpl/cMM6znfk6tqIvqfoe32ImZHz1YivsaQayJQHtan8
	R7kblhKSy1J38VsuLNNpHcadD5qpYaaCxroxUNunHna4FxMhhQEXvC9jSr7HshgmNAahQAWve16
	1YWFNg7JHgnRg56ZF8RodvazmQWThAcQ=
X-Gm-Gg: ASbGnctX41GVKVgyyEfrgOzH1iD+1yTO13Scs4aZhtcyhimXPDcgQx74hgdNeN5FunI
	zQ7mdgFLMlWboaVnrvMzywZNpn2zNQcK3A3JOXDWzmeIk1muepgMDHTd4928b8yKFyN9ROfMlel
	hULdpygCbS95zLjrb3r1IqYZ4L/ssEO3BiuseCJoxeUHlgbtaj9taH29NFM9PnrJUyGjVTkEE3v
	19telAHPSewJXYxOtOXasAocMVVypq+
X-Google-Smtp-Source: AGHT+IHedmjtfrfQZ6kW8QKuwAdECr6I1hiXfVOXlZcxsFN061YcDFnfXfAPwRPbs6K5+eMFaH0JseZMD/Jr2viOYaM=
X-Received: by 2002:a05:6214:5199:b0:720:3cd9:1f7e with SMTP id
 6a1803df08f44-87b1bb42849mr30308086d6.0.1759907027966; Wed, 08 Oct 2025
 00:03:47 -0700 (PDT)
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
 <87tt0bfsq7.fsf@linux.dev> <CAHzjS_v+N7UO-yEt-d0w3nE5_Y1LExQ5hFWYnHqARp9L-5P_cg@mail.gmail.com>
 <87playf8ab.fsf@linux.dev>
In-Reply-To: <87playf8ab.fsf@linux.dev>
From: Song Liu <liu.song.linuxdev@gmail.com>
Date: Wed, 8 Oct 2025 00:03:37 -0700
X-Gm-Features: AS18NWAyjZKWTXeQJNB3PaOT3WzsTXBdhqC-Rkcj8nywQj_gcgCbw3kGbTWlhpA
Message-ID: <CAHzjS_tq34QC4NDQd_L8crQii2QZCxZr28ywSw=gMnFnqD_z2A@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 7:15=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
[...]
> >
> > I am not sure what is the best option for cgroup oom killer. There
> > are multiple options. Technically, it can even be a sysfs entry.
> > We can use it as:
> >
> > # load and pin oom killers first
> > $ cat /sys/fs/cgroup/user.slice/oom.killer
> > [oom_a] oom_b oom_c
> > $ echo oom_b > /sys/fs/cgroup/user.slice/oom.killer
> > $ cat /sys/fs/cgroup/user.slice/oom.killer
> > oom_a [oom_b] oom_c
>
> It actually looks nice!
> But I expect that most users of bpf_oom won't use it directly,
> but through some sort of middleware (e.g. systemd), so Idk if
> such a user-oriented interface makes a lot of sense.
>
> > Note that, I am not proposing to use sysfs entries for oom killer.
> > I just want to say it is an option.
> >
> > Given attach() can be implemented in different ways, we probably
> > don't need to add it to bpf_struct_ops. But if that turns out to be
> > the best option, I would not argue against it. OTOH, I think it is
> > better to keep reg() and attach() separate, though sched_ext is
> > using reg() for both options.
>
> I'm inclining towards a similar approach, except that I don't want
> to embed cgroup_id into the struct_ops, but keep it in the link,
> as Martin suggested. But I need to implement it end-to-end before I can
> be sure that it's the best option. Working on it...

If we add cgroup_id to the link, I guess this means we need the link
(some fd in user space) to hold reference on the attachment of this
oom struct_ops on this is cgroup. Do we also need this link to hold
a reference on the cgroup?

Alternatively, we can have the cgroup hold a reference to this
struct_ops. This way, we don't need a link to hold reference to the
struct_ops. I think this might be a cleaner design.

Just an idea. If this doesn't make sense, we can revisit this with
the code.

Thanks,
Song

