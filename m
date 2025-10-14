Return-Path: <linux-kernel+bounces-851556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3C2BD6C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7AEA4F5E70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B942ECD05;
	Mon, 13 Oct 2025 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc/KBPQ+"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D02C08B1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398846; cv=none; b=rbi78+ZPople1tG5zRRb1DU9WXCebQdjSmncIwBu5gR2mMljB9A+kwaaYG2ZvDfKBv5tX1RLTB5XREP5rpvl095RPRTLE40XtG5gplke6s+PQBIn7iEwbZ/jmKFH8d7NB7FmEppQZAPO89YIdmjjxQXXZ95JeAKmmHPhNVPjCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398846; c=relaxed/simple;
	bh=FypXfhaUgPqWoAOB6zCB4Gei8T7WpXBIDD005BLqAxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBDbV7cFzcC+QJtKattLqzend3RpasW+shrvvVtPMkHFbnsd59tEwLyN5iz5sRXrrU9sSjMPTlMocbS9gO1WPOmVhm5err1o22BrvItGrHNxPRQNdulcrVyf4FEaIGQfRKCQC9OqS4gZCs1dHOH4GCbfHi1RDUUaPKmZPx5nAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc/KBPQ+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so3809032a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760398844; x=1761003644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Np7BGfGSC5mSKSPzWqOH4qz0wb4n2bnrNejmqVPNiIo=;
        b=gc/KBPQ+yQvTPS+BXaPtJBvogaLx+ad9NHcb4CzCp0c6ufqcdcWX1Dl8AH1Fc2rZ+8
         t6hIHwusnF81iwrjGYA5Rt8bR9hdy/1c/CfeDMS9zYAOE7E91OcLzocmvAq6wdKokdPR
         vJ1gBt0ekfNjPUeRY6z/+kjg/FApx1V3qi9cLhtpIr54Uq7p5p/oelmSciHBKbd4+OQB
         hs0iAMNUDWnWrujtfopek8TjrjRxu/fKEinlQZEKIUIrDE9Pr/pxlnkTj8r++qxV5Z5V
         ri4buVYBoQeEUccqaLNPpuoh5gRDOFLYnZ5GfVyeuruzBnebqTh+4qtW5LRcvuubiP9Q
         G6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760398844; x=1761003644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Np7BGfGSC5mSKSPzWqOH4qz0wb4n2bnrNejmqVPNiIo=;
        b=eRA+OWF0HT6lpqDKQhqLVw5xemAO2AXkR6S5/DdzgMZT5hkoA0/GeRMWAD5vBpMFWA
         zs7kFFsaAHMGVNHRGRl10AE0AJeis4qIXjHoNvuKG3UZAhZII5GLnZRqnadOPrbvFPAD
         fjOvQFjb52N0hM+VwXx8JPhaxOLAo1qHVz9nSGoOIsykjELpf5uXFnq0umHKxc6p8/Mq
         SCaf3R+4aJ2pwPGly3PI+io03L2hNQX4O6Hz2q/Q5RNJ/d/roRRSDxuqM6HhhEdcBv8t
         redbZNXjj3s6CgsYDczHkPxJKoLQqpVw/K+f/XwQtF/r75bHS6maeGNpsXM3sfinLd83
         qtvA==
X-Forwarded-Encrypted: i=1; AJvYcCXT/kAnis/N2KJYCaZCCsmuGOO2h1e8GAigN5k4mKXSI8Y/XpHJo383kF+x4acx9WLAQ+77niN6Pf3+nLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygdwW0AaHoGurOuu17kUTSNXOQLo7oy1aTs10huc3+eUSGn0P1
	Om+SZ/iVPZ5kMqGFhF8yaoQ73K2gDNjeNYEJP8tUndHRDRAq4pBr0Sz4vdAp6Aa2hBsgP7q822x
	I09M4J6jhWWEfYhXzMiQrNeH3pebVC/A=
X-Gm-Gg: ASbGncsaVRLmS7qpc/wzWs3fK9msDwZqODYWzsvZ5k8McAQ+Yj9SylELq0oX0LQhITA
	zj7+qOC86oIDdlr2pFYq5AUbcbc5MUIw2TRCSUhVEZuSD2ej8rmBZJ0vstGijpxD5ko9dnegLUm
	SJ1CQWO0+dkL2tPjvnfr3+PanvRgW2FgWhtVLxkD8jNqalzbu8EMcSEC572m6bUlpMk7ERFsysX
	64cZzVW47UMmZ8Iu/pFfHTBLNZlBsxIyfl7KZr+rA==
X-Google-Smtp-Source: AGHT+IHvOT616NhfArx9bWlgX4KXCjMp7apJznSYFsC5Y+A/Q36E5xxCPaAJusL+mPs+XxbhFklnh19SRIOqEKvmGD8=
X-Received: by 2002:a17:90b:4984:b0:32b:94a2:b0c4 with SMTP id
 98e67ed59e1d1-339edac69f1mr36210878a91.16.1760398844625; Mon, 13 Oct 2025
 16:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
In-Reply-To: <20251013131537.1927035-1-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 16:40:30 -0700
X-Gm-Features: AS18NWBZJP_Tc9TCJA3QgJjEAZrIjWVUOR-kNIw6mReq4Pob5m-LizRQGvqNn9k
Message-ID: <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: pengdonglin <dolinux.peng@gmail.com>
Cc: andrii@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:16=E2=80=AFAM pengdonglin <dolinux.peng@gmail.com=
> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Currently, when the funcgraph-args feature is in use, the
> btf_find_by_name_kind function is invoked quite frequently. However,
> this function only supports linear search. When the number of btf_type
> entries to search through is large, such as in the vmlinux BTF which
> contains over 80,000 named btf_types, it consumes a significant amount
> of time.
>
> This patch optimizes the btf_find_by_name_kind lookup by sorting BTF
> types according to their names and kinds. Additionally, it modifies
> the search direction. Now, it first searches the BTF and then its base.

Well, the latter is a meaningful change outside of sorting. Split it
out and justify separately?

>
> It should be noted that this change incurs some additional memory and
> boot-time overhead. Therefore, the option is disabled by default.
>
> Here is a test case:
>
>  # echo 1 > options/funcgraph-args
>  # echo function_graph > current_tracer
>
> Before:
>  # time cat trace | wc -l
>  124176
>
>  real    0m16.154s
>  user    0m0.000s
>  sys     0m15.962s
>
> After:
>  # time cat trace | wc -l
>  124176
>
>  real    0m0.948s
>  user    0m0.000s
>  sys     0m0.973s
>
> An improvement of more than 20 times can be observed.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> ---
>  include/linux/btf.h |   1 +
>  kernel/bpf/Kconfig  |  13 ++++
>  kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 165 insertions(+), 9 deletions(-)
>

Just a few observations (if we decide to do the sorting of BTF by name
in the kernel):

- given we always know kind we are searching for, I'd sort by kind,
then by name, it probably will be a touch faster because we'll be
quickly skipping lots of elements clustered by kind we don't care
about;

- instead of having BPF_SORT_BTF_BY_NAME_KIND, we should probably just
have a lazy sorting approach, and maybe employ a bit more
sophisticated heuristic. E.g., not by number of BTF types (or at least
not just by that), but by the total number of entries we had to skip
to find something. For small BTFs we might not reach this budget ever.
For vmlinux BTF we are almost definitely hitting it on
first-second-third search. Once the condition is hit, allocate
sorted_ids index, sort, remember. On subsequent searches use the
index.

WDYT?

[...]

> +static void btf_sort_by_name_kind(struct btf *btf)
> +{
> +       const struct btf_type *t;
> +       struct btf_sorted_ids *sorted_ids;
> +       const char *name;
> +       u32 *ids;
> +       u32 total, cnt =3D 0;
> +       u32 i, j =3D 0;
> +
> +       total =3D btf_type_cnt(btf);
> +       for (i =3D btf->start_id; i < total; i++) {
> +               t =3D btf_type_by_id(btf, i);
> +               name =3D btf_name_by_offset(btf, t->name_off);
> +               if (str_is_empty(name))
> +                       continue;
> +               cnt++;
> +       }
> +
> +       /* Use linear search when the number is below the threshold */
> +       if (cnt < 8)

kind of a random threshold, at least give it a name

> +               return;
> +
> +       sorted_ids =3D kvmalloc(struct_size(sorted_ids, ids, cnt), GFP_KE=
RNEL);
> +       if (!sorted_ids) {
> +               pr_warn("Failed to allocate memory for sorted_ids\n");
> +               return;
> +       }

[...]

