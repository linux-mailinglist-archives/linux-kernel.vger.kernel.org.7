Return-Path: <linux-kernel+bounces-856912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 698ACBE56A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95A334E876B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514E02DE1E6;
	Thu, 16 Oct 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuE1nlka"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372031EBFE0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647176; cv=none; b=V4Qevrs11qXKElidqAooXyVdKCMR2zaua/IVGAlX7Vk4OUo++AOSxNhqzEFFMfyiUXejpHiJLXQ1mtO1/RnYVT23NMJZjLuLHa6oeLjohSWfOW8msOEcG3d7/ju6JTxZSWp1uS4QZFhSfz7LF4FnRPVFsq+WThhq1n+JqGI6pSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647176; c=relaxed/simple;
	bh=j47gUxbffwQzSI5QkRAi1UGxgKVvkhYsy8R9Lk2cIp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg42g+hVpTuAWawJFyn/SLuSxpfVdAuee50HKznrQnREuA5L7ET/+UntvQ7xtZkvdv3UPAUufxbPPUHBJ/q/z3Vl953DMMKdzMQ0vwH5e06BK2r3YPnKWY9aeQzywx0Rn2NtMbQOwpK643U6J9xMG3hfZ4EV+TMhxcupXgtgRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuE1nlka; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33ba8d20888so1247245a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647174; x=1761251974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsEecsSQDVQd72weWcRmXLR+hYEbzg7jxqkKrhdHLo8=;
        b=MuE1nlkaMBgUExM+2ri3mzDg0HeqleVSO5rzkIiI51vVivw8OR8Dl/jtYYRRJYuOyY
         92kOxdZA5ZBR+9KXQN2AF7OhzphkmOBNFE2CBWkDusrQnNwSyLxjC4XzJSXT4Ws9nPii
         RrVOfXLmp7np+HzkqUw+qs2BWN/SvTOXUJKK/lA1s9PyUp+Z7jcVuQpWoZLA36KFJP+t
         uN6WJNWQIDl1xLgDPiy3DO65xrEQPv/xijIHEPd+pbpDbNUCZhyMJCIJ9cICrFIRkeQ9
         eWgWIjSIAh5KHkJxq2asnlVDXevBqgZdLtj2OHLSuAHtlyGJQ1xbx7PCk3Izz9Jq9uZb
         fKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647174; x=1761251974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsEecsSQDVQd72weWcRmXLR+hYEbzg7jxqkKrhdHLo8=;
        b=UEucTEkJ4Z3BH7MO2vfzVylqH9B47t1EQMnLVfYaSiqVKgwDMrygPBXgH9PDUltxS+
         T8eV06Gs8fAuqTj7ncL+K3upXZfIZYDvhVErznW3wPF6oIli6J+SsCcPRssqjaDQDtxM
         Vl83JgiVlLcDPAPKby5ybx+Vvmq3Ez1SrjAoyuodRSTC8uRHTcmqHUmgJy69GUF9CcEj
         pIYLkq3s6drG1/R1GXn2E6A1JMQUDyuP808a8yEPq7B/LGGjzAhfxgfVAgjsBA4KZ72o
         p4chYvajrelsMfEMwy2cmD2uwY4EQwXIw5RBXZfvv6z7C2lngvos/Gc1Uj7Aj/8N2a3y
         l0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVZp8NNof57xsHFRunvvrNTD9pKOs1044viUMyfbrw9NbZlbOEt2NjPpnB3yhD24e78qqhIRSBGdnxiAUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Bb+L1gbHHM8bei3mnwbgrXjwZA7+juzbW+4uVlmeFl9ZHAjm
	hVguExaLb458iBmMF/Ln+6UzUjWRCRPqOnRUJPsm2C7eiIuOQhcST7CB1WJZZD9Qrem7kONMlz7
	wu7qZk+2IwggaHX3Lb93kT4JlifGtL18=
X-Gm-Gg: ASbGncvlO+F9lBDZ4O/EPYo6d369mR7ihRzU4YRdy2gBWUPUbEcu8li+LdSHFmKHJxy
	gAZNjPnw9ywAvO5alUmliN+8CFBDhyXGBn9hxNlTZW+UrngbN3L7nGCM6RofdRB12oXtCqInSSm
	vE2oyp8nVOJzRG1nIR1PrHv5enFj2GH6V2AI03ZwY0ijVXa9xS0FLdngxcbpomZALaWUyi3C8iM
	z2qXypSL31zn8ud9yOLZBJC1kDRfOIF8VKaefxtKJX3lSg6epDloRB2HgPk0jfBn0XRCWMsySoe
	gTqT4oxrMOw=
X-Google-Smtp-Source: AGHT+IHDr5J0KFk161wPAYc7kYj7KAxZHJ299Vu5BgTI/wRioKfbYD47CRXPhpJbNq7ELZ17QmNTDJWYHON81DsIz/o=
X-Received: by 2002:a17:90b:54c6:b0:32e:dcc6:cd3f with SMTP id
 98e67ed59e1d1-33b9e28a808mr6232546a91.14.1760647174299; Thu, 16 Oct 2025
 13:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev> <aO4-jAA5RIUY2yxc@krava> <CAADnVQLoF49pu8CT81FV1ddvysQzvYT4UO1P21fVxnafnO5vrQ@mail.gmail.com>
In-Reply-To: <CAADnVQLoF49pu8CT81FV1ddvysQzvYT4UO1P21fVxnafnO5vrQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 13:39:20 -0700
X-Gm-Features: AS18NWA45dPZ_Bqm8aVj24uKxev9XFt4-GQ7iuJ9EiK13dkTykni87M8kGxIHSA
Message-ID: <CAEf4BzbAt_3co0s-+DspnHuJryG2DKPLP9OwsN0bWWnbd5zsmQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry to get_perf_callchain
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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

On Tue, Oct 14, 2025 at 8:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 14, 2025 at 5:14=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
> > > As Alexei noted, get_perf_callchain() return values may be reused
> > > if a task is preempted after the BPF program enters migrate disable
> > > mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
> > > stack-allocated memory of bpf_perf_callchain_entry is used here.
> > >
> > > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > ---
> > >  kernel/bpf/stackmap.c | 19 +++++++++++--------
> > >  1 file changed, 11 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > > index 94e46b7f340..acd72c021c0 100644
> > > --- a/kernel/bpf/stackmap.c
> > > +++ b/kernel/bpf/stackmap.c
> > > @@ -31,6 +31,11 @@ struct bpf_stack_map {
> > >       struct stack_map_bucket *buckets[] __counted_by(n_buckets);
> > >  };
> > >
> > > +struct bpf_perf_callchain_entry {
> > > +     u64 nr;
> > > +     u64 ip[PERF_MAX_STACK_DEPTH];
> > > +};
> > > +

we shouldn't introduce another type, there is perf_callchain_entry in
linux/perf_event.h, what's the problem with using that?

> > >  static inline bool stack_map_use_build_id(struct bpf_map *map)
> > >  {
> > >       return (map->map_flags & BPF_F_STACK_BUILD_ID);
> > > @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, reg=
s, struct bpf_map *, map,
> > >       bool user =3D flags & BPF_F_USER_STACK;
> > >       struct perf_callchain_entry *trace;
> > >       bool kernel =3D !user;
> > > +     struct bpf_perf_callchain_entry entry =3D { 0 };
> >
> > so IIUC having entries on stack we do not need to do preempt_disable
> > you had in the previous version, right?
> >
> > I saw Andrii's justification to have this on the stack, I think it's
> > fine, but does it have to be initialized? it seems that only used
> > entries are copied to map
>
> No. We're not adding 1k stack consumption.

Right, and I thought we concluded as much last time, so it's a bit
surprising to see this in this patch.

Tao, you should go with 3 entries per CPU used in a stack-like
fashion. And then passing that entry into get_perf_callchain() (to
avoid one extra copy).

>
> pw-bot: cr

