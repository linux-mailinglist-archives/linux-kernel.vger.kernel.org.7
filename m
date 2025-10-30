Return-Path: <linux-kernel+bounces-877611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D39C1E928
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55E8E4E7252
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DFC32ABFE;
	Thu, 30 Oct 2025 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlHPwUQ0"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1222301004
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806050; cv=none; b=mqW86DCp0U8gjJhM8sVQUCKf5unYHeQuY+9OcF+5PsD/px3eKSJJCfJnfHnP/AOA7tIGcK9QR5wYXgQeOYqELrOK1sAbIXDIGNKAyORlIB5nPeoln7wvQ5AITZdP8bfwWtan1Vl+lvtFtv9vrVfErX4Edv68Z82cy5/hooiQ1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806050; c=relaxed/simple;
	bh=zflyYk3NYy4RcPJITCP+PJ6c8wHVT/sLZfTTgaXKfCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAbru7KRM6fR46vZCN6UcYgpLocW7nFubyct81f0zqjay0ozfwyIicOzAN7Do2WkTr5m6j3VlSDusN9RBRJceKEgOuReilyQOFqwiHbyLmVnjXTM6NGfEt+Bng7PjajrM1skboXcknvIW82alQdveUsSpYZlLu4iEhTIF8/DyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlHPwUQ0; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-785d3a5f641so8098727b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761806046; x=1762410846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zflyYk3NYy4RcPJITCP+PJ6c8wHVT/sLZfTTgaXKfCk=;
        b=UlHPwUQ0YSemv40ZGHCY7NIcxtx7Vdgvi54HCNlWgnToL98ONPEPEua6KiSleMKvZs
         CGnpyBNJFvkkMHenB1MYC3FLSNu4BVaOiNYS2FzlzUO6WDaLIyTlISp7339s0hodnitz
         6NtQdZzitvGieoICQidNlR+dlXRT3hTHxEwl8J4iQvV9gna2odKV7Ht6yhIorppqiufi
         N7AIYwAf2kZZsQyZroDk/uMqWMB6gcMFTIgVbfEM5/zUdFgdrvSVSvqRfEpQxK1BeqZP
         HTT+txarUxveXuMlN1i28dJ/0tXeO2ADi8ncOckcaXvpdiHuJvRV3RVl8rNTawxwYOH5
         3tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761806046; x=1762410846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zflyYk3NYy4RcPJITCP+PJ6c8wHVT/sLZfTTgaXKfCk=;
        b=i/nFMA0PCqEmQWFYw9UjW/JvY87+0j0eHU3UIaY6A+f0C+GeDrkUXPTmI/YLJ5/kYP
         6n107Cet61wcxwtEO7wH3L/FehNBAak4aSRfxvk3dX8pLKXwW3mIqjnAgHeTemWW1544
         6M3RIC3AxCdKJoMyegyTIFte9vNKCeiR9FUmr2H1GJanyald815qTdVtCvbjvdvOr0TQ
         y5mKOTsrXVbl4KoSmMVLFp10kSQlP0m1sMpiFZsugc62CRc+OWBlyvcnNZ/L5kGiuOjv
         asUAxVQ2wfinuBViOIrh7twIjgu1cB/hVurFNuQSniOAn7awxx/XKZSRXT0J1X0oIua+
         T7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVGUUkewt4iyDbOfTn8e+mGBJOH3PD3yAhyrvG33WtdrNUjc8T2mZz4SXkl5YSVZRNT5zyWqmTzXxHK8Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/DcKD2EMS2jyrJxWyA07ibHbwrG4VotZ3HOLSL+eYRdlIZlF
	2Sl9rfT30YmtLFt4uIIt9YZHFrBUt2at25KGg8RKUBvfdcbEQWjbEmI9VlJKo3J/IwRN6NuQuQG
	WehU6Vp5Zr0rFRNp28sNH6mFJVLdqvow=
X-Gm-Gg: ASbGnct46xhk7Zgc1ubszQPkmFf2H6bbguN62kVJFqdbLiy824dqsA5m7bkBIh0NliS
	GOB3y+y6iAa49l9QwdI3RiXfGRlewqfPChMPb/sqAEDeC790eoWhvCumxUDnX6q/vy24VjF1QH0
	8bwUVwQtudpTbPEe/ckjfRaOxfdlpvLHBSHqozS6dHEp20ypzFuzzTFuSTjxuAtivTxJ8Ek1fia
	Nrb0NH16AAJ9lKONTTXsGjZ1Kgia+674Cvfi4p8ovJsj6RNHCxjGHpxud1wLY1OyqncuQkc
X-Google-Smtp-Source: AGHT+IHAkzPCtNQ20ppd+4ZhB3lJD10RCDw7ZQWKRcjkJ/MU+ifVpTXFAcgPBxAL5BiXPDLqVFNv4y1b/arwSry/zk8=
X-Received: by 2002:a05:690c:b95:b0:781:159:33ae with SMTP id
 00721157ae682-78628e82453mr55969657b3.4.1761806045641; Wed, 29 Oct 2025
 23:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <871pmle5ng.fsf@linux.dev> <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
 <aQKa5L345s-vBJR1@slm.duckdns.org> <CAADnVQJp9FkPDA7oo-+yZ0SKFbE6w7FzARosLgzLmH74Vv+dow@mail.gmail.com>
 <aQKrZ2bQan8PnAQA@slm.duckdns.org> <CAADnVQJPcqq+w0qDjMV+fx-gYfp6kjuc7m8VD-7saCZ7-bvaBw@mail.gmail.com>
In-Reply-To: <CAADnVQJPcqq+w0qDjMV+fx-gYfp6kjuc7m8VD-7saCZ7-bvaBw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 30 Oct 2025 14:33:29 +0800
X-Gm-Features: AWmQ_bmDSiMH7BHRJ2t-PSFn5y1B5iA1PUPKgXH8mX3AM57qm-0dXLGAddjgEhY
Message-ID: <CALOAHbBW0jM=WZG7BM3Lh=xHBV7M585j85xMzpWAtWdrkRa+nQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:16=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 29, 2025 at 5:03=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > Oh, if there are other mechanisms to enforce boundaries, it's not a pro=
blem,
> > but I can almost guarantee as the framework grows, there will be needs =
for
> > kfuncs to identify and verify the callers and handlers communicating wi=
th
> > each other along the hierarchy requiring recursive calls.
>
> tbh I think it's a combination of sched_ext_ops and bpf infra problem.
> All of the scx ops are missing "this" pointer which would have
> been there if it was a C++ class.
> And "this" should be pointing to an instance of class.
> If sched-ext progs are attached to different cgroups, then
> every attachment would have been a different instance and
> different "this".
> Then all kfuncs would effectively be declared as helper
> methods within a class. In this case within "struct sched_ext_ops"
> as functions that ops callback can call but they will
> also have implicit "this" that points back to a particular instance.
>
> Special aux__prog and prog_assoc are not exactly pretty
> workarounds for lack of "this".
>

I also share the concern that supporting the attachment of a single
struct-ops to multiple cgroups appears over-engineered for the current
needs. Given that we do not anticipate a large number of cgroup
attachments in real-world use, implementing such a generalized
mechanism now seems premature. We can always introduce this
functionality later in a backward-compatible manner if concrete use
cases emerge.

That said, if we still decide to move forward with this approach, I
would suggest merging this patch as a standalone change. Doing so
would allow my BPF-THP series to build upon the same mechanism.

--=20
Regards
Yafang

