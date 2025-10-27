Return-Path: <linux-kernel+bounces-872196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 201BCC0F857
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 239704E2D91
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5043126A2;
	Mon, 27 Oct 2025 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Q3A7MD"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC72C21C3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584703; cv=none; b=fJBTOs/ZJ4EPr5nyI1NGa6k+lP9eDYbo5NyXk4ga9geem1gW3kpueEcnseY190xyURsZsTcIgySZfMTBOmhJpI43I7r8spR+8NOeNcb5AN9qyvOX9z9TRepcKjDdmI4ZQ3KivHNoQibbNE0FVdNCNwZYIlF0S11Jvdj9QznT9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584703; c=relaxed/simple;
	bh=5GzkYMM+fPyPu2CUWcfzDIO9ZgWS2a7dc1YB56U+LLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tye3Uhwo5pJksb1FGnx0SpmElm0vkuTFXMbWutoGJ+OXvKdrJZoX2gVtwo+oDAkjcHg4lLXvVz2xUDUTH7NY3IR4olEmaCK2vqgvdI82amQfp8IpSDF6mNMZk5SJS5fCQvrzvNsyBkibzxiHvjw9JyxbY2wM08FDek/j8KPpEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2Q3A7MD; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6014810fso48323337b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761584700; x=1762189500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/pGzl7BvfQC6Ltlu7o6vv7/TF5tkl6HNvHVP3Xc/d8=;
        b=K2Q3A7MD0Qp73gLYQdapRMUEig66GSo7e84Vxjli8Au3F2WjdjiSNbP0J6AjnfITsE
         TzxDHYG32ORjWzkDqXElsf0VNqq1dgVn8IjB+mv0vNv6jMqcNHdL+aHv2OwhcYIT9lZy
         dlGlDIlTAgqItoHbIsTuhG//6h9ObjGKLJFXJYBi6TQXQPfeWd/Gnw9QyfR2/f8/CtCI
         j64CuJBOQOmxQpeerCtqjfgP5TmG/5kjch8xQpA+qnAMebApTOfmMTtQNDQE6thsMp1Z
         cjvAAB1FvA1KZBrweNBgk6l9iQubMuqB6dkSa9cOf7yshA49BvzwQ3Nz4YShZo4pRQJC
         Qh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584700; x=1762189500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/pGzl7BvfQC6Ltlu7o6vv7/TF5tkl6HNvHVP3Xc/d8=;
        b=t8Ra6PmYa0ek7i8zvM1AdW6/jwtR/f1eRkWUilpH53+VMTHYB2u9Fcr7GssNTq69rM
         WHvQXJJWAfFK2hRkOOjHXX5jU3XK5M/t71zB+Uut6jScvaUFgG3CsVP1mOo83JVSPA69
         8QPPEPoIp1dyyDzjPJyp9HXtKawI4UVKLtZdQDxjLGGW/uuaALY+1S2hLMvCGgFeqdHQ
         ChC5ZDuJf4t582P82gRI7rkcl0dP2yVB/qHvxPCn+ES9+QP5rQ/pWX2HQAAxVrpFOKea
         7nhr8oSEcfoIHcEfuwsbvKFT6/RedhK05RKaqYp/PtcSri4Y2nEWnIlMIAfR+KbxRmRZ
         7gOw==
X-Forwarded-Encrypted: i=1; AJvYcCWfK9kg0CP16tZVtq5Xnz6VnvdwJCTgOkP0z+XC3yAcj9FTQ6pIXvtfyFerXR+SoW9Lif4pPW7LI709HJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50Pw0lLSDnSKl9YptbmKFiZjK79V6c9Qv9Jz2mT15XlASAcLq
	dtDkfUrug93toqCVrVfp3VKIwi21osfVAFPWyGTHJccq5/kiooj3THouQJq/t0Gm4dXqQ2t6tCp
	LVMAndKgnl9bEAdgaQTBP/wQabX6vZPI=
X-Gm-Gg: ASbGncsARI9v232RUil49VHFtwwBptp0bFYmkVPncQx/VCkCM6McYUYioohooNCEftG
	82W3zIJhhx3EXhWDfP/qumTBqUI4fPR/CmDYLKaV3XfQrlik9qf7G/NnhuDISDvoy3FMYU0z9hg
	txRdhEzAZ89ux3pROhXhOlWhpAgsJU3VSiHA1elQQlyg4IsVex4O36wMtcd2oKGUpf6V/7PYwgU
	wpOGau9z+bjOgdg74R1TQ/UTpQ/JNGIpzzg++Fw10FFGPoMwQj0r75xIgq4
X-Google-Smtp-Source: AGHT+IH0Ze3xjA1KYpKBfttix5UqLPTPhNBnRN9WL9RcMpkxZK1OKgo3ADN0ICP0fCpuEVChTUDYyOY7hCZkC0iC66g=
X-Received: by 2002:a53:ce92:0:b0:63e:2715:5ace with SMTP id
 956f58d0204a3-63f6ba84d2emr498593d50.42.1761584698262; Mon, 27 Oct 2025
 10:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <20251026154000.34151-4-leon.hwang@linux.dev>
 <CAMB2axPhcYctJYz0bH032-Kc1h2LcJL74O5iS5g=8Qp74GPK_g@mail.gmail.com> <377791b5-2294-4ced-a0d3-918c7e078b2b@linux.dev>
In-Reply-To: <377791b5-2294-4ced-a0d3-918c7e078b2b@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 27 Oct 2025 10:04:47 -0700
X-Gm-Features: AWmQ_blT_P1_WTCjkjfvapLkw00GeA0aYEpC3ig11F-8VU7IenB_yLMtEO-rWLU
Message-ID: <CAMB2axPx2RajLzhoOsnffhrOxkw7Zy=D=vHam_Y_5wKS0cqf0g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/4] bpf: Free special fields when update local
 storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:15=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Hi Amery,
>
> On 2025/10/27 23:44, Amery Hung wrote:
> > On Sun, Oct 26, 2025 at 8:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> When updating local storage maps with BPF_F_LOCK on the fast path, the
> >> special fields were not freed after being replaced. This could cause
> >> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
> >> map gets freed.
> >>
> >> Similarly, on the other path, the old sdata's special fields were neve=
r
> >> freed regardless of whether BPF_F_LOCK was used, causing the same issu=
e.
> >>
> >> Fix this by calling 'bpf_obj_free_fields()' after
> >> 'copy_map_value_locked()' to properly release the old fields.
> >>
> >> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  kernel/bpf/bpf_local_storage.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_sto=
rage.c
> >> index b931fbceb54da..8e3aea4e07c50 100644
> >> --- a/kernel/bpf/bpf_local_storage.c
> >> +++ b/kernel/bpf/bpf_local_storage.c
> >> @@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_l=
ocal_storage_map *smap,
> >>                 if (old_sdata && selem_linked_to_storage_lockless(SELE=
M(old_sdata))) {
> >>                         copy_map_value_locked(&smap->map, old_sdata->d=
ata,
> >>                                               value, false);
> >> +                       bpf_obj_free_fields(smap->map.record, old_sdat=
a->data);
> >
> > [ ... ]
> >
> >>                         return old_sdata;
> >>                 }
> >>         }
> >> @@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_l=
ocal_storage_map *smap,
> >>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> >>                 copy_map_value_locked(&smap->map, old_sdata->data, val=
ue,
> >>                                       false);
> >> +               bpf_obj_free_fields(smap->map.record, old_sdata->data)=
;
> >
> > The one above and this make sense. Thanks for fixing it.
> >
>
> Thanks for your review.
>
> >>                 selem =3D SELEM(old_sdata);
> >>                 goto unlock;
> >>         }
> >> @@ -654,6 +656,7 @@ bpf_local_storage_update(void *owner, struct bpf_l=
ocal_storage_map *smap,
> >>
> >>         /* Third, remove old selem, SELEM(old_sdata) */
> >>         if (old_sdata) {
> >> +               bpf_obj_free_fields(smap->map.record, old_sdata->data)=
;
> >
> > Is this really needed? bpf_selem_free_list() later should free special
> > fields in this selem.
> >
>
> Yes, it=E2=80=99s needed. The new selftest confirms that the special fiel=
ds are
> not freed when updating a local storage map.
>

Hmmm. I don't think so.

> Also, bpf_selem_unlink_storage_nolock() doesn=E2=80=99t invoke
> bpf_selem_free_list(), unlike bpf_selem_unlink_storage(). So we need to
> call bpf_obj_free_fields() here explicitly to free those fields.
>

bpf_selem_unlink_storage_nolock() unlinks the old selem and adds it to
old_selem_free_list. Later, bpf_selem_free_list() will call
bpf_selem_free() to free selem in bpf_selem_free_list, which should
also free special fields in the selem.

The selftests may have checked the refcount before an task trace RCU
gp and thought it is a leak. I added a 300ms delay before the checking
program runs and the test did not detect any leak even without this
specific bpf_obj_free_fields().

> Thanks,
> Leon
>
> [...]
>
>

