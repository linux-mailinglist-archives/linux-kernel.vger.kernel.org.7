Return-Path: <linux-kernel+bounces-852908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D7BDA35D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8979C3A21C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985402C029C;
	Tue, 14 Oct 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVv/VASc"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE129D26D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454143; cv=none; b=plmbm5JE7YztQzRVGJe7/l3j2gpb7IukQWFF0izuOeh/VvHJ6INDgYabzhTptajg5hmKMUen0wKPeE4RlRpxI3Zaz5f1GztYiCoCJqanr8cLTSfMiXDF14hoZPTKwjyVp1XRA6WH6lkTi99TEElav6ldb/UlGO48xiDb7CFCEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454143; c=relaxed/simple;
	bh=wLBVcnPZguAYTgTwsKiwtS3FxogrqpWpBa8CDXH8zpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV3i/ljq/28MRUBWDg3qCLJqHwSqxu4lFsetTVlZ64orz2zGFlmTaCnupY2MCAwT/y70bBRhStg1pw0XdoPKRnpTtgE4yMU9BI7jcPLPoKHDNcuGklUj7W95f1shwrcOpYoqctjy6lUpvHiPQBz+vc/GIzg2VnAz5UFgkaGQyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVv/VASc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e5980471eso29885675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454139; x=1761058939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z3LeGxNpykW8QPBBmWGZO+eW3eGppBCAhBgpeK39tg=;
        b=GVv/VAScI0yT7zJtxlMoy7phM4rxnAkX4Y9gZIG90BQ65CNFU8a/j4JEkbCeW7qkem
         U1OCaHVbD6ksOtIyMjZXR3RCBB/P36VVRjkiwO7s3SCIPXcFFQRCOFjcZ8EJkqVt2Gai
         w2GVUahsgg82q0n/d3/9czo0p5qeL6RqX8Ttfg+Ft/Is9xlOvhlU/KjjYflEk5h9dcv4
         jCWTn1Yxf/OHw/GhEK+18EUshxteGoj50rpsYwYyFrzYd18CAlibMllWw/ljXHoBrN7I
         16ZS55xcd678S92ZL87v50g7CY49pc4bf6p4/LnL5KxKqzAr5GqVXsD8eC7DX5O67lNd
         EixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454139; x=1761058939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z3LeGxNpykW8QPBBmWGZO+eW3eGppBCAhBgpeK39tg=;
        b=DZSU/T02mgiKDvoL12+xVsF8xEVbz1LvJ0YgbWWp1b+6yDLbjKVruea+y13GOsD/FJ
         8zgrmZBs+eC3XRM2l+jLFhZez5YLXaMOYmYPv0spOzHl56UJQXNPLx5319IEz8uddDsS
         oFemmUaDICOC5ptao6AB/5sKNAg2rlp8aTe7JPtte5Y1Wfg9MmvKSzdz2gjRav75Ulkd
         nPJgUNQptS9vThV4iKR4WdmJhSdsYhD8ieuggnSYglyZirOEAs6qVe6/wadn0jUdEYG5
         s7Phu1/v+guop5eNSLPkJVet+l8XjQSuj3+68q9fXp3TT34jH7ziahBMjMncUHJfm7Kx
         wMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVHlJXPZdCgafPjSQbAAIXnBie7FJYTAQF9SkLj9cQPAz5WgbumGqB+xpTji0F0YKTC4zWR4oJQYRbUXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTX9NE71TA82nmP3bnKf4sIwSYZ1cZNG6Jo6Q232263E8R2wM1
	BKYrwRcsKk3P3NI8gPgnC0dBniLdKQp7v4rwvSkdXRCzqwwIBlKQFR64prHG9wMoKVUrbOwcW99
	H8uy2mnGAAj96xUGZ1fO72dVCbFNJvcM=
X-Gm-Gg: ASbGncs5cWQiu/maZuXGjW0558/W67Ky9CIOy5zE8vdVgq3cYYrN9b3iDm1y5a19oKh
	4NIKPKUcjnncXdkSFGTQId5SPdFEHiO3pRmnuWU4ogg5GEer9Aspbi0q8cJ4ouYfWeGPvvv4pp+
	bQp5IfBZtTY6km+q77IV6/6XfY+orqMP/Vp+jBkthiKcpE0zsaerCkIGQMQ5i3AshgAPAS1XtU6
	Qan1MxX3U6oPDypdTqxLDkMwzLXqzRiHUQ0tMH9Eg==
X-Google-Smtp-Source: AGHT+IFZ4oUDp4AWLyXSPzY6UsUd433FoGP+hnvIbGLoK7umHXXDi0LbPYh5b/NE1SjwjjD79z/uWjqAoIeYogU1rOw=
X-Received: by 2002:a05:6000:22c5:b0:3fd:bf1d:15d1 with SMTP id
 ffacd0b85a97d-4266e8dde71mr15298478f8f.49.1760454139020; Tue, 14 Oct 2025
 08:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev> <aO4-jAA5RIUY2yxc@krava>
In-Reply-To: <aO4-jAA5RIUY2yxc@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 08:02:06 -0700
X-Gm-Features: AS18NWCSgrnY4KPRrkJ5eguwWeliltY9wxstLdBBs-NEBFqW5W6tT8iypfQAxiM
Message-ID: <CAADnVQLoF49pu8CT81FV1ddvysQzvYT4UO1P21fVxnafnO5vrQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry to get_perf_callchain
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:14=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
> > As Alexei noted, get_perf_callchain() return values may be reused
> > if a task is preempted after the BPF program enters migrate disable
> > mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
> > stack-allocated memory of bpf_perf_callchain_entry is used here.
> >
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >  kernel/bpf/stackmap.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 94e46b7f340..acd72c021c0 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -31,6 +31,11 @@ struct bpf_stack_map {
> >       struct stack_map_bucket *buckets[] __counted_by(n_buckets);
> >  };
> >
> > +struct bpf_perf_callchain_entry {
> > +     u64 nr;
> > +     u64 ip[PERF_MAX_STACK_DEPTH];
> > +};
> > +
> >  static inline bool stack_map_use_build_id(struct bpf_map *map)
> >  {
> >       return (map->map_flags & BPF_F_STACK_BUILD_ID);
> > @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs,=
 struct bpf_map *, map,
> >       bool user =3D flags & BPF_F_USER_STACK;
> >       struct perf_callchain_entry *trace;
> >       bool kernel =3D !user;
> > +     struct bpf_perf_callchain_entry entry =3D { 0 };
>
> so IIUC having entries on stack we do not need to do preempt_disable
> you had in the previous version, right?
>
> I saw Andrii's justification to have this on the stack, I think it's
> fine, but does it have to be initialized? it seems that only used
> entries are copied to map

No. We're not adding 1k stack consumption.

pw-bot: cr

