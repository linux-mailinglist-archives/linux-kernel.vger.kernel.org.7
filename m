Return-Path: <linux-kernel+bounces-863489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E056BBF7F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7223B254D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB434E744;
	Tue, 21 Oct 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/FboD36"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432234D4E2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068990; cv=none; b=iUVXJ5m0/bJ+0wSOFHPHEflrDjdrysDmxN4mw4uMVW+b+zJd2gpkT2JGObsp9xNGxsuP6pMKBqzF0QNd9mQzFEP3HdG+BQOKPqAEHCM0g20E0kqkObSODzYZPdaT/px2KriQU7EaJS9nt36ZT8l7Mjs6rK/UEvpERZHXPwf9lTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068990; c=relaxed/simple;
	bh=qDzlcTloUqpO+I/XqJPhOmpCeUL3ayv4KE9vfDTV9es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwU6QdGO7rpjwqhGTMjzJKzLMjRcCOFDTX7iCvqbPS/2VZlSakX5pqW4gPuOvBv4DI/IQzWHXCoJj6kMhZLJ+KpiDN5veW5IBXj/f37NvdGKhMgqoMQbwBupRD7F/d+UyRzrEZJurQJ4GcnxuMX9CPrOIL7FDV90fyaMJv2I91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/FboD36; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so7099528a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761068988; x=1761673788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q8Os3QV4AiQnNKQL40uNK7bo4U73YgmtqjVFwNJYtk=;
        b=N/FboD36fRPRysCGMLgON3wdGu5jHn+tLrRWNZbEv4TZ+9sajIv6xFsfG8OpEo/A7V
         JrKMOrLq7nG4BHMiIqQLXtyi5rx0gTuNj1DSQ8eey5IoR7NDWMMUoxl2zNJ2waJCd7DV
         69zS/qSjprlZR8RkzfcaI5muwwCf5qoKvAf9OJodBYMWSyJvZgJ3r9GIdfTChvGLCqT9
         eMgr72hSxYpU1bwp1z81IP/zwqkUodw0aeglsW1zUPbq2whFUiW7rjLyIBc7dJhvC1Ro
         DQXz6GZinONa+ynOqArDkbdZVvqaPKUmTmsok4oto4KtBAZ0sFzzxGrtGBilhKP1J7WG
         PQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761068988; x=1761673788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+q8Os3QV4AiQnNKQL40uNK7bo4U73YgmtqjVFwNJYtk=;
        b=r6pCFHOLeRqRDs0zD2lK1qYbMtNtFvHn6PtrpCNq8+jmJAzmRb4KC64ioz+TTqyrag
         REiatoEj4wURjb/i+/XWxWUAR9X2zKzJCFdI3U7DPoWO8KdXhTe8DGewLDrW2SOESMYN
         bqirbaBGzL3VkoMOPbprUJGENIa/ly/eGqtjvv+a+G1ruRLiOIxsgMsjzUNThpm/4s8q
         +F/M4vsN41AuqlpP0LmsuhaHcFef88qSyAvzR+1b4PQ+u/1VNKUFnKlKZkm0s0TCPx/I
         kXbKquhHXZ0cwALzN4xF0yX/6Wt+FJY0vHzoXnQewXosUgXz6slr3MbtWK4c2kGo4J4R
         q5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXDPoL8AWiaNWtlsKDENOH2wx9jjrDJv09YjJ5kQjvvHbYWE8aFDvrpPvYqcCxuyts49QMnXlxmFxzZhS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaWgfD7VAiLsOhnjE0GbsvN+HLfIGmEBBfi4KWXqTx4xdwWZaA
	hNCaqMLTGLZCP5gyueQMWCp+cA7gobkm82b8pXapEJmjAqjyVRDvu1rfzCtP5lay/27OS7K84Hi
	SV+QSRTHes/PXijc8qjI5AnnyrMusnhQ=
X-Gm-Gg: ASbGncsSvMk9hB8xE7hQScT3WG674x4PSTarzLyFmkVTMyrdsmX6WZ8jxNK4DcaJMRA
	PnThvzeAjaMHZOGq5i5ZT8+ZkEyIwSpjQkqNzzZOglAwMPcSumLV65FYN7b8umdC9w1raDAGAqV
	tJepoIKmB+hS/YpBTDlxEnCFGfdNXqn92aq/ExtB05APtlUZ6f+lfsmEnmVyACkNs1ztOJPiyPP
	xKcXW+SdsMxgEd3qzXM21xhbjAbASWV9cXEGdwWIVfiBj7wooG/GxAaDIKzD5MdKouw
X-Google-Smtp-Source: AGHT+IGOXQgu6lQWhFyf+t/CSA1diNM3SwVxnFnjh0utUblYzFhYLfjlWfGOvy2Gt+AOFXij58+2eNPtcHopEifHSlY=
X-Received: by 2002:a17:90b:3d87:b0:33b:b020:595e with SMTP id
 98e67ed59e1d1-33bcf8f78cfmr21160963a91.25.1761068988525; Tue, 21 Oct 2025
 10:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHaCkmc_CrwBRj-Gji_td9S19oPg9U9-n8B4u8yTR4sPm9Vx7Q@mail.gmail.com>
In-Reply-To: <CAHaCkmc_CrwBRj-Gji_td9S19oPg9U9-n8B4u8yTR4sPm9Vx7Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Oct 2025 10:49:36 -0700
X-Gm-Features: AS18NWAsfq3fhmrRaxV6XHiZww58Xefxp9cRzg3SYFrj93L49T-WggbE-aYzrZs
Message-ID: <CAEf4BzaKhqx+5O6k7i5naAxAhpPxBuWgy=ryFwkLzGROJxQbgw@mail.gmail.com>
Subject: Re: [PATCH] Fix up 'make versioncheck' issues
To: Jesper Juhl <jesperjuhl76@gmail.com>
Cc: wireguard@lists.zx2c4.com, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:09=E2=80=AFPM Jesper Juhl <jesperjuhl76@gmail.com=
> wrote:
>
> From d2e411b4cd37b1936a30d130e2b21e37e62e0cfb Mon Sep 17 00:00:00 2001
> From: Jesper Juhl <jesperjuhl76@gmail.com>
> Date: Tue, 21 Oct 2025 03:51:21 +0200
> Subject: [PATCH] [PATCH] Fix up 'make versioncheck' issues
>
> 'make versioncheck' currently flags a few files that don't need to
> needs it but doesn't include it. This patch fixes that up.
>
> Signed-Off-By: Jesper Juhl <jesperjuhl76@gmail.com>
> ---
> samples/bpf/spintest.bpf.c                                | 1 -
> tools/lib/bpf/bpf_helpers.h                               | 2 ++
> tools/testing/selftests/bpf/progs/dev_cgroup.c            | 1 -
> tools/testing/selftests/bpf/progs/netcnt_prog.c           | 2 --
> tools/testing/selftests/bpf/progs/test_map_lock.c         | 1 -
> tools/testing/selftests/bpf/progs/test_send_signal_kern.c | 1 -
> tools/testing/selftests/bpf/progs/test_spin_lock.c        | 1 -
> tools/testing/selftests/bpf/progs/test_tcp_estats.c       | 1 -
> tools/testing/selftests/wireguard/qemu/init.c             | 1 -
> 9 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/samples/bpf/spintest.bpf.c b/samples/bpf/spintest.bpf.c
> index cba5a9d507831..6278f6d0b731f 100644
> --- a/samples/bpf/spintest.bpf.c
> +++ b/samples/bpf/spintest.bpf.c
> @@ -5,7 +5,6 @@
>  * License as published by the Free Software Foundation.
>  */
> #include "vmlinux.h"
> -#include <linux/version.h>
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 80c0285406561..393ce1063a977 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -2,6 +2,8 @@
> #ifndef __BPF_HELPERS__
> #define __BPF_HELPERS__
>
> +#include <linux/version.h>
> +

this is libbpf's public API header, we are not adding linux/version.h
here. Linux version on which something was built has nothing to do
with the version of Linux on which the BPF program is actually
running. And BPF programs are most of the time intentionally Linux
version-agnostic.

[...]

