Return-Path: <linux-kernel+bounces-834553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814DBA4EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC3B4A73A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE97730DD20;
	Fri, 26 Sep 2025 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI3rnHmD"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954304C81
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758912791; cv=none; b=FrCskd3aw2LAPC5sCsRJQwd31BmTNQB1EWQkHUACzZFFph2Dnx7edoPJJOETGUimYQMXtKoKvPQuQmU9ojKAdJoiRym8KWMTLopj9ziAO483gxhloILM0tKi/qjE5hqCGytx3HQg223ITGdkHgJ3fj4g3qyy1NFhSv+7DqfcF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758912791; c=relaxed/simple;
	bh=8V6SVK5v8GrZKB2Bwx2cQD4Rr0kPivMwYIv0ut00IJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d54Mvq0N1wgGUFezzE8D+pjWKSQTGTCHNOmBF3jWw6GwREWhxUB6aPmRP38bj6BErfj5sEKHxMqArutb3nZyptunIzc51Kkm02wMfEdopgLMBwS4x1ZmT5Wr4jYAqXIcs5qtgIviwsVOclC+GHraNN5rCNVwcs0/MJHu5lrGUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI3rnHmD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so2888101a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758912789; x=1759517589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRoD+/xn+duqjmOLn3fdaJ5dNuVR6aVk7d9Y+El2Xao=;
        b=WI3rnHmDPsaydcJoww3cNAm3lYSZBpQRWVS6N4wtdTVVfF1Oe7BED45cZRphEnjVOU
         bLXMsR/Q8QNegAucWMvgveCjZLDc3MWN2Uujtdjk1is6jz6xDtYuHvoJPH4jE2PNQXSB
         irrHO6IEf4ubfioWSwllKAv5CDc0fZE4+3KRY+A5QvFfzTSB4Fl4PjV4Fv1OoK8EgsEK
         WZdcYHcmkJPw0LEE/uVcVOwKhSrNW5u0ZuR5np//c54ViFI0QykhvlY5+8083GSIWbLx
         pSrqfnmS4Do9nJ565FwYKLI/neb+ZMVwa4R3liaBXwgzsDNaJNMQ0/4zaNRIm0o60Rvu
         57fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758912789; x=1759517589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRoD+/xn+duqjmOLn3fdaJ5dNuVR6aVk7d9Y+El2Xao=;
        b=jHnZ7TH43rtPSzLx8F7FjU/pwkl/rPlJgdCLp6N+JPt85A7yFMjkval27Qg30UL3Nq
         LLGdfCRSLxDiUlnPtKTKwuj5bAkwdmuLtMFDI+/dvHPq+I4VDh6Zx8inUGfQwRxdoQj0
         4qX1llLB3hvcx4G+rW6cGqfAzBSnhD255wypYT26IyChOd1LdDUUX4bu9f6U/AQBHwWQ
         h281uychOxj5RZGtz/QR65HkQhdUilg7ssFkE6vxu1Qt+goNhZ7DkPxtcuU4Sm9iixX6
         wcew7+7Ico5NRomllirMVJWk4g2Z/nXXdFNezGINq6PvHrhBzpFNLSBof785R+arexsT
         SepA==
X-Forwarded-Encrypted: i=1; AJvYcCWf1BCSQzAOkcOCc4+J+QbtxsMrevzp2ah4A/hBh4k2kve35tc1TWZvBWBw+3idTYn5tenjZGJnot1lRdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0w4JPugUmr7CnnXrXdNqyqKHqX9DonDvt5+tNcQWDBBX9r91
	EOu43rlooTnI5nw4VDnSI2Vl3Wocnwjq/Xd/BTZRLFH7IFGsBKs9me32xDkXpc/0f52X+0D0rj0
	UUmrhqTgGvZW2Oj6e/4/de4yyHrctrpk=
X-Gm-Gg: ASbGncskXag4y2uFHM7UYe2BnAyf+0qQnpMjBmYAem0mh3ZgWZI6DE37Qy+khkUJY2C
	2H9N7BVX3h4CpX6WcfI8ea1lMbxiB0LwVF5Brzuih3X9Qjad9+jhm2P1Cnc0I2cNMpz5eJ8rZoE
	qzePEjNWy5uVmCYfW7Cp70ERnj9rX5xk5fmghdoMzt2HPR3eQg02iVcuOU+wrHGFV1SxuLo3+Vd
	ZUclOQf+s+KyTpCS/P6EPyKiy7ev85d
X-Google-Smtp-Source: AGHT+IH3i4UbOMhI3oI6UkDKVAwsIItFN+jiqtJHvdL2O4YFAAc2h64wmgmvF5o3lpGcsCsYn+hno/QpLXXkreWvY/A=
X-Received: by 2002:a17:90b:4aca:b0:336:b563:993a with SMTP id
 98e67ed59e1d1-336b5639a5bmr28132a91.23.1758912788906; Fri, 26 Sep 2025
 11:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926153952.1661146-1-chen.dylane@linux.dev>
In-Reply-To: <20250926153952.1661146-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Sep 2025 11:52:53 -0700
X-Gm-Features: AS18NWC2aPk-ebAr1m1OOXPnIkQ7LeGUvIa8h19IykjetTzeBTTrIVDn2maXywY
Message-ID: <CAEf4BzbLJtMGaZoFAaAgnNXe8GCStsw+kZ_3hWoGfySWZ6B5mg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add preempt_disable to protect get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:40=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. We therefore use bpf_perf_callchain_entries percpu entries
> similarly to bpf_try_get_buffers to preserve the current task's
> callchain and prevent overwriting by preempting tasks. And we also
> add preempt_disable to protect get_perf_callchain.
>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Closes: https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRs=
zmZV7pQDyV=3DVDQ@mail.gmail.com
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 76 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 61 insertions(+), 15 deletions(-)
>
> Change list:
>  v1 -> v2:
>   From Alexei
>   - create percpu entris to preserve current task's callchain
>     similarly to bpf_try_get_buffers.
>   v1: https://lore.kernel.org/bpf/20250922075333.1452803-1-chen.dylane@li=
nux.dev
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 2e182a3ac4c..8788c219926 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -31,6 +31,55 @@ struct bpf_stack_map {
>         struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>  };
>
> +struct bpf_perf_callchain_entry {
> +       u64 nr;
> +       u64 ip[PERF_MAX_STACK_DEPTH];
> +};
> +
> +#define MAX_PERF_CALLCHAIN_PREEMPT 3
> +static DEFINE_PER_CPU(struct bpf_perf_callchain_entry[MAX_PERF_CALLCHAIN=
_PREEMPT],
> +                     bpf_perf_callchain_entries);
> +static DEFINE_PER_CPU(int, bpf_perf_callchain_preempt_cnt);
> +
> +static int bpf_get_perf_callchain(struct bpf_perf_callchain_entry **entr=
y,
> +                                 struct pt_regs *regs, u32 init_nr, bool=
 kernel,
> +                                 bool user, u32 max_stack, bool crosstac=
k,
> +                                 bool add_mark)
> +{
> +       struct bpf_perf_callchain_entry *bpf_entry;
> +       struct perf_callchain_entry *perf_entry;
> +       int preempt_cnt;
> +
> +       preempt_cnt =3D this_cpu_inc_return(bpf_perf_callchain_preempt_cn=
t);
> +       if (WARN_ON_ONCE(preempt_cnt > MAX_PERF_CALLCHAIN_PREEMPT)) {
> +               this_cpu_dec(bpf_perf_callchain_preempt_cnt);
> +               return -EBUSY;
> +       }
> +
> +       bpf_entry =3D this_cpu_ptr(&bpf_perf_callchain_entries[preempt_cn=
t - 1]);
> +
> +       preempt_disable();
> +       perf_entry =3D get_perf_callchain(regs, init_nr, kernel, user, ma=
x_stack,
> +                                       crosstack, add_mark);
> +       if (unlikely(!perf_entry)) {
> +               preempt_enable();
> +               this_cpu_dec(bpf_perf_callchain_preempt_cnt);
> +               return -EFAULT;
> +       }
> +       memcpy(bpf_entry, perf_entry, sizeof(u64) * (perf_entry->nr + 1))=
;

N copies of a stack trace is not good enough, let's have N + 1 now :)

If we are going with our own buffers, we need to teach
get_perf_callchain to let us pass that buffer directly to avoid that
unnecessary copy.

Also, I know it's about 1KB, but it would be so simple and efficient
to just have this bpf_perf_callchain_entry on the stack. Kernel has a
16KB stack, right? It feels like for something like this using 1KB of
the stack to simplify and speed up stack trace capture is a good
enough reason.

> +       *entry =3D bpf_entry;
> +       preempt_enable();
> +
> +       return 0;
> +}
> +
> +static void bpf_put_perf_callchain(void)
> +{
> +       if (WARN_ON_ONCE(this_cpu_read(bpf_perf_callchain_preempt_cnt) =
=3D=3D 0))
> +               return;
> +       this_cpu_dec(bpf_perf_callchain_preempt_cnt);
> +}
> +
>  static inline bool stack_map_use_build_id(struct bpf_map *map)
>  {
>         return (map->map_flags & BPF_F_STACK_BUILD_ID);
> @@ -303,8 +352,9 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, s=
truct bpf_map *, map,
>         u32 max_depth =3D map->value_size / stack_map_data_size(map);
>         u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
>         bool user =3D flags & BPF_F_USER_STACK;
> -       struct perf_callchain_entry *trace;
> +       struct bpf_perf_callchain_entry *trace;
>         bool kernel =3D !user;
> +       int err;
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID=
)))
> @@ -314,14 +364,15 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs,=
 struct bpf_map *, map,
>         if (max_depth > sysctl_perf_event_max_stack)
>                 max_depth =3D sysctl_perf_event_max_stack;
>
> -       trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
> -                                  false, false);
> +       err =3D bpf_get_perf_callchain(&trace, regs, 0, kernel, user, max=
_depth,
> +                                    false, false);
> +       if (err)
> +               return err;
>
> -       if (unlikely(!trace))
> -               /* couldn't fetch the stack trace */
> -               return -EFAULT;
> +       err =3D __bpf_get_stackid(map, (struct perf_callchain_entry *)tra=
ce, flags);
> +       bpf_put_perf_callchain();
>
> -       return __bpf_get_stackid(map, trace, flags);
> +       return err;
>  }
>
>  const struct bpf_func_proto bpf_get_stackid_proto =3D {
> @@ -443,8 +494,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         if (sysctl_perf_event_max_stack < max_depth)
>                 max_depth =3D sysctl_perf_event_max_stack;
>
> -       if (may_fault)
> -               rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> +       preempt_disable();
>
>         if (trace_in)
>                 trace =3D trace_in;
> @@ -455,8 +505,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>                                            crosstask, false);
>
>         if (unlikely(!trace) || trace->nr < skip) {
> -               if (may_fault)
> -                       rcu_read_unlock();
> +               preempt_enable();
>                 goto err_fault;
>         }
>
> @@ -474,10 +523,7 @@ static long __bpf_get_stack(struct pt_regs *regs, st=
ruct task_struct *task,
>         } else {
>                 memcpy(buf, ips, copy_len);
>         }
> -
> -       /* trace/ips should not be dereferenced after this point */
> -       if (may_fault)
> -               rcu_read_unlock();
> +       preempt_enable();
>
>         if (user_build_id)
>                 stack_map_get_build_id_offset(buf, trace_nr, user, may_fa=
ult);

really it's just build_id resolution that can take a while, which is
why we are trying to avoid preemption around it. But for non-build_id
case, can we avoid extra copying?

> --
> 2.48.1
>

