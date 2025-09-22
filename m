Return-Path: <linux-kernel+bounces-827867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA05B934E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E0F7A9ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140052ECE86;
	Mon, 22 Sep 2025 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5/QHp1e"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8A27B34A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574768; cv=none; b=VIQcVDZXdMst7j/cvdUHY81OwW3vuL0kxu4KFVl6tRn/MDW8Bb6WtSeex0zGooirrK3knKWjXju2rcJvYUHLJfkJvjBb77NOA4m9igokUQtUP9UCDoPVPxEsW7uvG8BNjq+9Cz7n/ZrJW/7Zt4L/gqv7RRzILPv5HX4PQ4JAoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574768; c=relaxed/simple;
	bh=CUP3eycXoGcBJmDOi+pXkUgGpzCUq/xusP8MHFeb4Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dumJJ9zHWftdpjEiGFhNm3mpJs7227R3AlUfPLCM5BfXbp81Jxj3wYnIfWsJJ9VmXzljgnDrHuG+/3KcRjT3JijcvXI/wntElgil+yb7sDjOmFNbTkJF4BU4ZzOOc5MAPiopZaa1z2tjfMQef1jo78HFkZh4At8Z6P66FBpBTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5/QHp1e; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54a74f9150so3586988a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758574766; x=1759179566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiFG421BizDvewXPlC7JQjLJ8H0b8/d80Id9cbV0N74=;
        b=I5/QHp1eg1IAJASMR+jmi1MwWUwbNhmS7pBwA+S+nf5xhpQzQFcvmAo1M4NTQxE5UQ
         hBLWB16TwH1wg5BwNvpJuS6O+tFUdFOh4sYtaJKvUfINhbrpyc1WdWQu6/qfWuwvkoxy
         j/pWRTPaF0MCoX42m8N/mZd1Kg3VB+ADwdC4ZTfVYnKkWwL2wa16P3GncLokkNvp6h6q
         3N5o+YXHX5Df7Arwsqf54JjK0hscsqfNo76n11yBEurpDivUf7UESdk9JHxqjRLjnQj0
         wEd0/L/AqZLDZl5pcW/0dBBrja9CSFIl3odDbkr/DFiaWGLdrwUhFi65LBj9/BPuCtgX
         cZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758574766; x=1759179566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiFG421BizDvewXPlC7JQjLJ8H0b8/d80Id9cbV0N74=;
        b=AE8aPyIbJPQVmR/gSCXvviVj6kVERAyPP9lPzoYC+44MCYyfKS6mb4hIaiYY/w3GTM
         yDFfFoI7F+hTpAx4gT8IzSJJzsNdvhBvnU90XMr+EyWkEyFNVd+4//Qc8py0+SIwTCPQ
         19lVv64NLX8VkveyN+kuEy9A+ngypJ4rTJ5BjAIXKv0CxHq80ONQJmwMbXe8nE+7619V
         i5T9IVjF5OUwiSVtBVoXMVqiKsz2blbDdGjnPFV+1nwsy2gTErUHeYl8il+GOpvqb077
         ZUPCZsBYWkLrtV712zCyca27haBALOrXxcFrzIyPlaluHB07E83eOyg23j/UyG4UpcxA
         02Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUkNqEpTdlM2EYuEZHqeWRz8xsD35mT5gSX/O3FxwoaiFMbqbZ7mY1UNVHjZVI5CQkJtHexspZrfvlFDrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFrK5nTWr2bKs2FKcFnsnDd498NkEXPcAegbaRcDnrT5AWje3
	rTNZnTPlKNyk4biuuxpcTs0U8sMk/AS8pe5xL59lkwy1NeTTx4sUqHKnQ8mQ6QYP1y46/OjDQ1p
	JeoyTQV32zcDD5e8YL8KL/abPmPnC/fxgag==
X-Gm-Gg: ASbGncsK2JEQ1YKoC+yQfLdTCDbkiXB6E/+uJrIhcs/u1X4FEA6pkwy7leXGO22wa0W
	M3F8oH9WsNX8dFa2yLxhKFs5xG52A6oQK6D7tYO4mMWivdo2kXPUAEmzSXPbtuJbifsszLD3o/w
	2xC780AeV9NSy7Q5/hdUNe7Ozedt6EY7Kvlz9zJ3pVi30akpYVvp/Bng6J1Db70Z0wsz/RIlrGp
	+7fh7iXv9ULduuI2P/5nbI=
X-Google-Smtp-Source: AGHT+IE9VwmPhMIv6d0ZnfhqqCx6ceFX364yO9AZ/YG0TmLdzzTNChAty82pjLqupowSD1TL5gMW2iLVCihtihnXoVw=
X-Received: by 2002:a17:90b:55c6:b0:32b:ca6f:1245 with SMTP id
 98e67ed59e1d1-332a92c97a2mr336889a91.5.1758574766224; Mon, 22 Sep 2025
 13:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920155211.1354348-1-chen.dylane@linux.dev>
 <20250920155211.1354348-2-chen.dylane@linux.dev> <f1d2d0fc-c541-4acc-b5d6-34f2bba37aea@gmail.com>
In-Reply-To: <f1d2d0fc-c541-4acc-b5d6-34f2bba37aea@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 13:59:10 -0700
X-Gm-Features: AS18NWDOlowWXkediPF7GZxq3CHM4H4DGTwIIh0oSy17dJQm2WRIqevDYgt8APY
Message-ID: <CAEf4BzbWOzwmsMhHmk_LbWUFM=Q2DwVsWWtoVD4ZjK672_XV9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add stacktrace map
 lookup_and_delete_elem test case
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 7:42=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 20/9/25 23:52, Tao Chen wrote:
> > ...
> > test_stacktrace_map:PASS:compare_stack_ips stackmap vs. stack_amap 0 ns=
ec
> > test_stacktrace_map:PASS:stack_key_map lookup 0 nsec
> > test_stacktrace_map:PASS:stackmap lookup and detele 0 nsec
> > test_stacktrace_map:PASS:stackmap lookup deleted stack_id 0 nsec
> >  #397     stacktrace_map:OK
> > ...
>
> As they suppose to pass, they are meaningless in the commit log.
>
> Please describe what the test is for and what it is doing instead.
>
> >
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >  .../selftests/bpf/prog_tests/stacktrace_map.c | 22 ++++++++++++++++++-
> >  .../selftests/bpf/progs/test_stacktrace_map.c |  8 +++++++
> >  2 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/=
tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> > index 84a7e405e91..7d38afe5cfc 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> > @@ -3,7 +3,7 @@
> >
> >  void test_stacktrace_map(void)
> >  {
> > -     int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> > +     int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd, =
stack_key_map_fd;
> >       const char *prog_name =3D "oncpu";
> >       int err, prog_fd, stack_trace_len;
> >       const char *file =3D "./test_stacktrace_map.bpf.o";
> > @@ -11,6 +11,9 @@ void test_stacktrace_map(void)
> >       struct bpf_program *prog;
> >       struct bpf_object *obj;
> >       struct bpf_link *link;
> > +     __u32 stack_id;
> > +     char val_buf[PERF_MAX_STACK_DEPTH *
> > +             sizeof(struct bpf_stack_build_id)];
>
> Nit: minor indentation issue here.
>
> 'val_buf' should stay on a single line, since up to 100 characters per
> line are allowed.
>
> NOTE: keep inverted Christmas tree style.

we don't really enforce this, no need to shift lines around just for
the reverse Christmas tree style

>
> Thanks,
> Leon
>
> >
> >       err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, =
&prog_fd);
> >       if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
> > @@ -41,6 +44,10 @@ void test_stacktrace_map(void)
> >       if (CHECK_FAIL(stack_amap_fd < 0))
> >               goto disable_pmu;
> >
> > +     stack_key_map_fd =3D bpf_find_map(__func__, obj, "stack_key_map")=
;
> > +     if (CHECK_FAIL(stack_key_map_fd < 0))
> > +             goto disable_pmu;
> > +
> >       /* give some time for bpf program run */
> >       sleep(1);
> >
>
> [...]

