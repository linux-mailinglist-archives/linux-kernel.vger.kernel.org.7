Return-Path: <linux-kernel+bounces-827940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8DB937F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAA32E126D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309F519A288;
	Mon, 22 Sep 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq/FQxzu"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB42DEA6F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580748; cv=none; b=VjrsBjGaBUfi0qksdsv8C+8cm9bI2gQbmeTk9osfFXum99t0aakVotJ5048tZ/q/XK+JDfXLuA80ZEcxMaKN2Hhh43i+1UQkqR+w8dtWJxtc86ABW+nwWPDdqN3vKc3iuARWfZMAMQ9DEkodiPE26aWnQ/9rfLma46UbMF37Y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580748; c=relaxed/simple;
	bh=FsBsmxfLMJqVVW0VQXb6jjSJe4OaHrZWZOJ4uZZLIBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo//8KKvxfP02GiTheXk7P/phNFQ4+4c524AbtRmYKKrz2XxpF2qy/vF7zDK+QolK3mawf6dxpCQf24zgc7IWlBK6KR1lZTstq75QTyDH3FMiCIZLhoFuvylnzgZ0sBX6p4OdnXr8CLxeQycBeAPbIqBELSltLnvFA1JT/XAI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq/FQxzu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so4263313a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580746; x=1759185546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s5oZ3yBKJeDuiH/x5f/bGcLal1TcIyLLUBiRn2ranc=;
        b=nq/FQxzu22db5XnLmJnfliX9xTA3KJB+dnvViZWmASPEmwm8qSeE1lQ+I3kARqCZHz
         HYXldbpxuGgqO9d9IueW2jcOGIL6D3AKVujFqxW4lxYhz1bN0t5FwOcKFM3swMFv/Hf8
         JunaiEVkC4YqCu80VpwIG2hLvdZVGIxnFLO3QLRMcBjEWC5LjKFEz8JLEuEc2rhkzzMe
         nRhnditsCJagoS59K34Pi3REWP+eZ+2qSmG4xNP1igBOk60I4DMrii3vOLe6jRnBMqAp
         f6jjacUc31+j8uZbPUoQmakvSDyC05P/IZCyWtIiqyZ3VQOuxBadxt6gbEB0GmJ2smx9
         iz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580746; x=1759185546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s5oZ3yBKJeDuiH/x5f/bGcLal1TcIyLLUBiRn2ranc=;
        b=taoPpkwSXHBsAIUHY8SCYD1V8F34kRvPeQ9qY0EFLAWexO57mj38WLZXWxugKqizta
         4OAH50QhKwWlnN2BK3NxTbPXIxGETht0NdlQp4PZN+aJra7u76vOVeLdooHemQriwyI2
         rSGtAfW7/nIpU7r7G3S5KcphTgHhpE87Yb/jxOO3L3PhIfwXf5ddFTxt7gGLHYpYBYe9
         6cwPa/dOR2A30Rj3UF/LqW285zwKqqmgW0+Ja9yszAEobS+EicrEbglpkSE1BAy7cumu
         KHa36yLOPf3daXjHcTiASb8wrxxSPmn+wWy8xk8MAYj4GarS5+G+zg0hawHgdol24mEG
         6+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm8nmg2qnQEmIMZrE1CDL8bOb/5o4WQVSfKIyvXnZvopSA/AbQ44vBNQRX441bKNWEKfAJeI3H9MPdFs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvkYU3MFBu6/qNdCs79B41fPtTuEEw6S9xeSI90yF577Ryb9Xp
	50wELSvquOhVLIzy6rH6kJdkm7a4GDQNYhiHhivDiT+oi0na8NjosMulxr2oToadz8QvpNgyUCW
	AbjJOUBQj5MRcV4AE1Nvek5MCcdXIt44=
X-Gm-Gg: ASbGncsqpJ8KTga2TdgRjD1xm40f2747z2TIiazZpVARV+Ky6KclekmBJgiogdwmcrU
	jfdBIJq04SN9e1pLQjXwNvOC/wweGknZzpTm/KIZTs5KH2DzXtklX+mpL5CZ8b3awP1/zwkD56c
	vhohlCJbGRCPSGkGiZNxHH0pFK2XNhHwZGIdQEAec43rzMiPPcIyz4W5jiMjwgu93t4qZ2Jm0kT
	2fISFbZvV9NzpF74NTGYzE=
X-Google-Smtp-Source: AGHT+IHkT+ZMltMRX0T37yaa83vWDp3M2bG5LvDGqkQichW4IqC6OvHQsQsKXYixsS1STnKtpjxvjjcpPoD4ihlj7Mg=
X-Received: by 2002:a17:90b:2fcb:b0:32e:5646:d448 with SMTP id
 98e67ed59e1d1-332a95bd2abmr592010a91.21.1758580746034; Mon, 22 Sep 2025
 15:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912233409.74900-1-contact@arnaud-lcm.com>
 <CAEf4BzZ-ovqXqLJ5oJ95n9prFnXsLOkO1UvdycUcON77=Akv-w@mail.gmail.com> <60553783-125a-4628-bd17-a7c40841d0ae@arnaud-lcm.com>
In-Reply-To: <60553783-125a-4628-bd17-a7c40841d0ae@arnaud-lcm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 15:38:51 -0700
X-Gm-Features: AS18NWDn28zltALLQs8oa-d2CjxK2qomkUDc0-AL3-bDjaHRyji-NvS5KjLsAhA
Message-ID: <CAEf4BzbBR7GBnWCA4E-RuEkbYJ7bUEfmJ5nd0g8G_bV0MG5tAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/3] bpf: refactor max_depth computation in bpf_get_stack()
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: alexei.starovoitov@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, 
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 12:32=E2=80=AFPM Lecomte, Arnaud <contact@arnaud-lc=
m.com> wrote:
>
>
> On 19/09/2025 23:50, Andrii Nakryiko wrote:
>
> On Fri, Sep 12, 2025 at 4:34=E2=80=AFPM Arnaud Lecomte <contact@arnaud-lc=
m.com> wrote:
>
> A new helper function stack_map_calculate_max_depth() that
> computes the max depth for a stackmap.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
> Changes in v2:
>  - Removed the checking 'map_size % map_elem_size' from
>    stack_map_calculate_max_depth
>  - Changed stack_map_calculate_max_depth params name to be more generic
>
> Changes in v3:
>  - Changed map size param to size in max depth helper
>
> Changes in v4:
>  - Fixed indentation in max depth helper for args
>
> Changes in v5:
>  - Bound back trace_nr to num_elem in __bpf_get_stack
>  - Make a copy of sysctl_perf_event_max_stack
>    in stack_map_calculate_max_depth
>
> Changes in v6:
>  - Restrained max_depth computation only when required
>  - Additional cleanup from Song in __bpf_get_stack
>
> Changes in v7:
>  - Removed additional cleanup from v6
>
> Changes in v9:
>  - Fixed incorrect removal of num_elem in get stack
>
> Link to v8: https://lore.kernel.org/all/20250905134625.26531-1-contact@ar=
naud-lcm.com/
> ---
> ---
>  kernel/bpf/stackmap.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..a794e04f5ae9 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -42,6 +42,28 @@ static inline int stack_map_data_size(struct bpf_map *=
map)
>                 sizeof(struct bpf_stack_build_id) : sizeof(u64);
>  }
>
> +/**
> + * stack_map_calculate_max_depth - Calculate maximum allowed stack trace=
 depth
> + * @size:  Size of the buffer/map value in bytes
> + * @elem_size:  Size of each stack trace element
> + * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID=
, ...)
> + *
> + * Return: Maximum number of stack trace entries that can be safely stor=
ed
> + */
> +static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 fl=
ags)
> +{
> +       u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +       u32 max_depth;
> +       u32 curr_sysctl_max_stack =3D READ_ONCE(sysctl_perf_event_max_sta=
ck);
> +
> +       max_depth =3D size / elem_size;
> +       max_depth +=3D skip;
> +       if (max_depth > curr_sysctl_max_stack)
> +               return curr_sysctl_max_stack;
> +
> +       return max_depth;
> +}
> +
>  static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>  {
>         u64 elem_size =3D sizeof(struct stack_map_bucket) +
> @@ -300,20 +322,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, ma=
p,
>            u64, flags)
>  {
> -       u32 max_depth =3D map->value_size / stack_map_data_size(map);
> -       u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +       u32 elem_size =3D stack_map_data_size(map);
>         bool user =3D flags & BPF_F_USER_STACK;
>         struct perf_callchain_entry *trace;
>         bool kernel =3D !user;
> +       u32 max_depth;
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID=
)))
>                 return -EINVAL;
>
> -       max_depth +=3D skip;
> -       if (max_depth > sysctl_perf_event_max_stack)
> -               max_depth =3D sysctl_perf_event_max_stack;
> -
> +       max_depth =3D stack_map_calculate_max_depth(map->value_size, elem=
_size, flags);
>         trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
>                                    false, false);
>
> @@ -406,7 +425,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>                             struct perf_callchain_entry *trace_in,
>                             void *buf, u32 size, u64 flags, bool may_faul=
t)
>  {
> -       u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
> +       u32 trace_nr, copy_len, elem_size, max_depth;
>         bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
>         bool crosstask =3D task && task !=3D current;
>         u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> @@ -438,10 +457,7 @@ static long __bpf_get_stack(struct pt_regs *regs, st=
ruct task_struct *task,
>                 goto clear;
>         }
>
> -       num_elem =3D size / elem_size;
> -       max_depth =3D num_elem + skip;
> -       if (sysctl_perf_event_max_stack < max_depth)
> -               max_depth =3D sysctl_perf_event_max_stack;
> +       max_depth =3D stack_map_calculate_max_depth(size, elem_size, flag=
s);
>
>         if (may_fault)
>                 rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> @@ -461,7 +477,6 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         }
>
>         trace_nr =3D trace->nr - skip;
> -       trace_nr =3D (trace_nr <=3D num_elem) ? trace_nr : num_elem;
>
> Is this also part of refactoring? If yes, it deserves a mention on why
> it's ok to just drop this.
>
> pw-bot: cr
>
> Yes it is also part of the refactoring as stack_map_calculate_max_depth n=
ow already curtains the trace->nr to the max possible number of elements, t=
here is no need to do the clamping twice. This is valid assuming that get_p=
erf_callchain and get_callchain_entry_for_task correctly set this limit.
>

What about that third case:

if (trace_in)
    trace =3D trace_in;

Did you analyze if that gets its trace->nr set properly as well (as of
this patch, without taking into account changes in the follow up
patches). Because it looks like this removal belongs in patch #2, no?

In either case, all the other changes in this patch except the removal
of this line is refactoring and as far as I can tell don't change the
logic. This line removal does (potentially) change the logic, so it
would be good to do it separately, explaining why you think it's the
correct thing to do.



>         copy_len =3D trace_nr * elem_size;
>
>         ips =3D trace->ip + skip;
> --
> 2.43.0
>
> Thanks,
> Arnaud

