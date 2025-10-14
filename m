Return-Path: <linux-kernel+bounces-851662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9909EBD7031
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF44518A8534
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E324263F22;
	Tue, 14 Oct 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2xXydRP"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5225D1FC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406869; cv=none; b=W1UlA9Io3L8HKUD3g09xIXwZ17Tt4Kub2+J0YsnQJNrOOdR07ISKhWkhmVO5xvkgnl1MmJX5lIYdMc4plgzEoWf+EFrEPzUuuaNIz7VBE+CZPVRoZcoRPj9Jft6kvESkF1ESDJIJM2w1jvbxX7NJejsX1JQ3zRGGOE+BMbVLFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406869; c=relaxed/simple;
	bh=T5J7OmcAxaPiSEye30W0ZOJTUvh/8wOGnJoBjAsSIOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKeW2wkL3n9oGffoxx6zgOJvMJHrB6qLCiyGcbdAZPCd/Qo+6pA31KU+0uTzlHYpNCxpIi0dPFdFa9/KcW8SI1bhM00xw4SQ2XX68tQfCuZg7A2KaggKeO93JHusY2JlM4Z8ZWrLspQRftZZkhemKEhalAJ1E7ay6gzK84yhiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2xXydRP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-639fb035066so7512197a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760406866; x=1761011666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik32QQu1F3n92X36Hdeq9+CsYS30S+qNycANq42cjDY=;
        b=m2xXydRPuFN1hEDeW8V68YP8RvUZPuHdnxdbZu7ruEc97eM1jE2dUtd5pNh8HkeAuF
         /KJs0b+YWUhvfQF6p+uXannI/pQHaHg0s66d407GmCdw6R5q0J+dRmdEStnq9uDosh9H
         r+M5ZFucZodnplRb9tetVK+cmXzp1qXJUx6yl6cqk1/RJxZ0B5HcrV9UWd9D5vakccQu
         XYZ/dLEMkMKOM2hyv42tX0iwbjrox8XVbv0chf/yIXq/3DC7AWk7xI+JrsqVyX907AyF
         TXZZi8Fy0MlbrPF+T2nML5vo5MzPNdti104Sx9Qw4fvk8VSagV87DzkEfqyT7Hp8fs+/
         4roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760406866; x=1761011666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik32QQu1F3n92X36Hdeq9+CsYS30S+qNycANq42cjDY=;
        b=bZITE/9SBLMVZ7tbX3jeWR6qIMg0pUu8Ej/4tSENTO7kpr8zjETFzQbbizCVRoASd2
         tEsKkSq1EL2nvodooGIYIbawem7JQVqDaJRanAiG4Hwsrjyt9fxsRFOprReILBDIKaI1
         97WidPQld1NoeDHi9qZ5T5Ieo3x9TJVUBVotx7SuCCs8mgPEJ26kxAiHo1oPQuG+3gy6
         6PWrlkEwQaYL3wZhFwQGTgBQylPYSIaN5BKBNaEr5jotFlfryRCblS5BadIoSm31gbzB
         8+1N7JXdtUsbxm6WukY07eJNmInTZSY/mVb7WpKE8x6cTpQhI296wj113+J5lInc3KrC
         FX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqLhLiwIu+hLHsgk4jLLkqFirQRTsCz7y5GB6UPHxQd/qMYy2mxd6sKU5M3Y1aB3Z6Q86lQ1ZnaMufjpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPhYcfkTn+DpAQsI3K8yllldro1ZfwXa98IhApV2nPxzEEfNDq
	CMzaw5joVzfMcrQAi0XbhQ++T9GFF+tpimpx2vvjxR3hj6QNAyY1yNg1QIs/N4PPqsZlzdzyLmj
	JYaR2TeR6vtdVXr57qUcngnKLYjE38Ec=
X-Gm-Gg: ASbGncvMAmIOcfTv12bF0WhBFw6oboERsUBCVXuDOmpX4SU6xpQcj+vByrOJqyOtoQJ
	S2q960lB4w14VIQFOW3vDHJSJ3LEldNCBaahBVFrQGSBNTpyJ/WwU2e2RbQ0RZL/iePxxXyAt/m
	oMXfwFLJtPrbu8krOAPbf0+5Ka2dvrL4fx7KuhU9EumzgfJ6HNcPlKkn4dnP+JetaOODr8XAwTk
	kiorS54Z98VnZsF+PjZgseudxOA5HsQmNzh0A==
X-Google-Smtp-Source: AGHT+IEIwL92OleUUPX8SMcFqaEBb3u6X2yfff0qC3j0KF5wSLhgWS1eaHLjQKiAE6ArF6J7UL6js8sAh5poiNQTYBY=
X-Received: by 2002:a17:907:d1d:b0:b41:873d:e226 with SMTP id
 a640c23a62f3a-b50aa48cabdmr2092647466b.1.1760406865724; Mon, 13 Oct 2025
 18:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com> <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
In-Reply-To: <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 14 Oct 2025 09:54:14 +0800
X-Gm-Features: AS18NWDaf7q3M1w8lIGQrPCBFol7jT1DFpi3r6Xob_q4wKIj2XFCbo4A4CQJ9Q4
Message-ID: <CAErzpmvOj_ecnN02EKuMtZ7ZTdxV_Uo4NOUG5+YS1uJsA0NG0w@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 6:16=E2=80=AFAM pengdonglin <dolinux.peng@gmail.c=
om> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Currently, when the funcgraph-args feature is in use, the
> > btf_find_by_name_kind function is invoked quite frequently. However,
> > this function only supports linear search. When the number of btf_type
> > entries to search through is large, such as in the vmlinux BTF which
> > contains over 80,000 named btf_types, it consumes a significant amount
> > of time.
> >
> > This patch optimizes the btf_find_by_name_kind lookup by sorting BTF
> > types according to their names and kinds. Additionally, it modifies
> > the search direction. Now, it first searches the BTF and then its base.
>
> Well, the latter is a meaningful change outside of sorting. Split it
> out and justify separately?

Thanks, I will split it out in v2.

>
> >
> > It should be noted that this change incurs some additional memory and
> > boot-time overhead. Therefore, the option is disabled by default.
> >
> > Here is a test case:
> >
> >  # echo 1 > options/funcgraph-args
> >  # echo function_graph > current_tracer
> >
> > Before:
> >  # time cat trace | wc -l
> >  124176
> >
> >  real    0m16.154s
> >  user    0m0.000s
> >  sys     0m15.962s
> >
> > After:
> >  # time cat trace | wc -l
> >  124176
> >
> >  real    0m0.948s
> >  user    0m0.000s
> >  sys     0m0.973s
> >
> > An improvement of more than 20 times can be observed.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> > ---
> >  include/linux/btf.h |   1 +
> >  kernel/bpf/Kconfig  |  13 ++++
> >  kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 165 insertions(+), 9 deletions(-)
> >
>
> Just a few observations (if we decide to do the sorting of BTF by name
> in the kernel):
>
> - given we always know kind we are searching for, I'd sort by kind,
> then by name, it probably will be a touch faster because we'll be
> quickly skipping lots of elements clustered by kind we don't care
> about;

Good catch, thanks.

>
> - instead of having BPF_SORT_BTF_BY_NAME_KIND, we should probably just
> have a lazy sorting approach, and maybe employ a bit more
> sophisticated heuristic. E.g., not by number of BTF types (or at least
> not just by that), but by the total number of entries we had to skip
> to find something. For small BTFs we might not reach this budget ever.
> For vmlinux BTF we are almost definitely hitting it on
> first-second-third search. Once the condition is hit, allocate
> sorted_ids index, sort, remember. On subsequent searches use the
> index.

Thanks, I appreciate the suggestion and will include it in v2.
However, due to the
memory overhead, I believe a BPF_SORT_BTF_BY_NAME_KIND option might
be necessary.

>
> WDYT?
>
> [...]
>
> > +static void btf_sort_by_name_kind(struct btf *btf)
> > +{
> > +       const struct btf_type *t;
> > +       struct btf_sorted_ids *sorted_ids;
> > +       const char *name;
> > +       u32 *ids;
> > +       u32 total, cnt =3D 0;
> > +       u32 i, j =3D 0;
> > +
> > +       total =3D btf_type_cnt(btf);
> > +       for (i =3D btf->start_id; i < total; i++) {
> > +               t =3D btf_type_by_id(btf, i);
> > +               name =3D btf_name_by_offset(btf, t->name_off);
> > +               if (str_is_empty(name))
> > +                       continue;
> > +               cnt++;
> > +       }
> > +
> > +       /* Use linear search when the number is below the threshold */
> > +       if (cnt < 8)
>
> kind of a random threshold, at least give it a name

Thanks, I will fix it in v2.

>
> > +               return;
> > +
> > +       sorted_ids =3D kvmalloc(struct_size(sorted_ids, ids, cnt), GFP_=
KERNEL);
> > +       if (!sorted_ids) {
> > +               pr_warn("Failed to allocate memory for sorted_ids\n");
> > +               return;
> > +       }
>
> [...]

