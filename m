Return-Path: <linux-kernel+bounces-883439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB9C2D75F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 294E94E02C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C513156678;
	Mon,  3 Nov 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glK+3Iz0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778731A7F5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190691; cv=none; b=hI6kACr7Hub0XLkAB1FyTM4kuwpkiKviQZWYw7xoVp1CJQ4J6z15LnSpeH+kKYi6wKQQo3pRRTrc/u5CKj92ecOumHOmaIYuUN3BbgYPthwJj4VN16KVyIxhMk9sYXyILyXMFw6TI5fRARaSqn5EuPv4doqVfLFErRlwqwTMACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190691; c=relaxed/simple;
	bh=RBCrMHl5+r7gIpID5SMw5Uu9xHVvNcBVL8VL8b1svCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unbcgC2sbsKURiizTTf1oac8wHLU5/b2oSeJAN1FBf/TKqlHC1YLPRspzqYyPEnzm3GXnx9XyMo7zpSKDyUuzZ/3oxnMxpRs4JoSCOhjjrWaFW2vJrGRsr2QhKiyLSoOvLL2mNe1PPVxPnBR6fpiTAt1gxGTV9L231rbU7xjsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glK+3Iz0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so1226043f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762190687; x=1762795487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro1EY1qfOe4vUThx0ZqWLeIU2GAit/q1wMhzypsJ0iM=;
        b=glK+3Iz0UeuapX9ZY5l4oeDdfYwy7nx4bq0znltYU3fkuDByji1uae7g2r4GYybfgM
         AIa7AEoXItRNitMKCVHKrxivsSAPz2KoUw2NobTt022cy3pSXtIflguMO3XtKtJQCqJ6
         taThB8RSI2eUtE0G7ZaVvLZYiM+X4QtSwIMkJQrxvahsMIuBWrs3+/Bs97i9bhjCGrmO
         xrLAbA4+oLcRwNZTi4RNhb77GrVDWL+eDQdffy2rv5mF+QmsDCMLrxVDMMtVcqi67dIY
         dBKzTxHpBOE1vqiGYLkgAT3x5sIt2X2prDRyLcj0NWA+Jpl2+7O0fT+wS6kXTAusG7bC
         Zpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190687; x=1762795487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro1EY1qfOe4vUThx0ZqWLeIU2GAit/q1wMhzypsJ0iM=;
        b=eerCZfHPFHAP26r76D3W3rr2zfTD3nL2mmZINvpt4W66H1RtqruB4ObYI7TkbZmp/l
         WTYc2AZn8ji87dUqTQrE0RobeP4EvyaRqrXznOA6pim0zDGgBQ78HMz5TYpj+mZPV3u1
         PkdBPjGM42/OuIFcVGdqL0hB+OvDymfgB1C8hkdLmvIZEI1UyPZFg7/9Wdoh/KpLQJWa
         3FSvBKpmEDNiKK79N2y+3dhNlOIwrK5ATlkl3dMKwYqsNK4w3Xn67IQ+aOGKdrpow2P4
         2x+dtt6Htemx/jTuegt11cj+PMbxVIl3FQ8IWstZYtNz/zRxBPxQs/oS7Caw4gHJtkck
         f1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2hou3nsK2WceCe62JHGiTQ0YmCnojryDJH11iW8GvufeBUVmJ+39e42EJl/OzwKupjyBREkR873Wd7IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbo/vXd1ANdSnCGjm9DTt3pxEDEUOmtFyBhuN+ODvrfBx3QXGX
	Nleurmep1EQ4kMNPKyxpAG0ZZp2VGyEApDchfcCDfLTjIiZqiYEkcWeLfWjQLCSv6diKbEaa92e
	6cGzxVjKhWfSCRWpWU8grFV2ZuD3nweI=
X-Gm-Gg: ASbGnctZIV3BVpal8lp5yQYz3PVvMGm1TKIhOWh3V2tovmW2AMxSHq2xOXBz6gDKaOl
	YqhtD4SfFK4acBmbT/olRofFOvIkq2vF2X6nSolzJmlyiSMLe6A7mp4UxR+hvZbGT9rFbMoMO3f
	/wb0hO8G1IB4wBMowiLGOgzXgL5cOUGmehZ+Yw5pdiH6ReOjsT8tBRY29um+LrM1i7R3tLlhRPI
	cDRtMII3Rog3+sYa9WJUpecngakgWMb6MLBNZHKHMmc71iDo5L8IxdzPADv8CR+Eya+zviaXwCg
	nL4/w0cLQIZHrWfcQgLcHg==
X-Google-Smtp-Source: AGHT+IEJD1f1OGGvHWmr6ipCmnC/rKjkjLbQjqmUaOn+glW25HAYOi5NjfH97rBU5lFoA/xbTGNntS5+u0C87uDofTk=
X-Received: by 2002:a05:6000:310a:b0:3de:78c8:120e with SMTP id
 ffacd0b85a97d-429bd676070mr9132749f8f.6.1762190686736; Mon, 03 Nov 2025
 09:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030152451.62778-1-leon.hwang@linux.dev> <20251030152451.62778-4-leon.hwang@linux.dev>
 <CAADnVQLib8ebe8cmGRj98YZiArendX8u=dSKNUrUFz6NGq7LRg@mail.gmail.com> <22f12031-7a19-4824-a9cc-459fb63a5e0e@linux.dev>
In-Reply-To: <22f12031-7a19-4824-a9cc-459fb63a5e0e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Nov 2025 09:24:31 -0800
X-Gm-Features: AWmQ_bm4t42nXKKLY7EleQr5SyGRExs3j12-OPMXVNGKvQ-5I62n-U-Sv767GRs
Message-ID: <CAADnVQJ9dFOou9jqmDaJKaYagF_KM0YXO+=r9uyM5r48+SFTuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Free special fields when update
 local storage maps with BPF_F_LOCK
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 9:18=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 31/10/25 06:35, Alexei Starovoitov wrote:
> > On Thu, Oct 30, 2025 at 8:25=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
>
> [...]
>
> >> @@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_l=
ocal_storage_map *smap,
> >>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> >>                 copy_map_value_locked(&smap->map, old_sdata->data, val=
ue,
> >>                                       false);
> >> +               bpf_obj_free_fields(smap->map.record, old_sdata->data)=
;
> >>                 selem =3D SELEM(old_sdata);
> >>                 goto unlock;
> >>         }
> >
> > Even with rqspinlock I feel this is a can of worms and
> > recursion issues.
> >
> > I think it's better to disallow special fields and BPF_F_LOCK combinati=
on.
> > We already do that for uptr:
> >         if ((map_flags & BPF_F_LOCK) &&
> > btf_record_has_field(map->record, BPF_UPTR))
> >                 return -EOPNOTSUPP;
> >
> > let's do it for all special types.
> > So patches 2 and 3 will change to -EOPNOTSUPP.
> >
>
> Do you mean disallowing the combination of BPF_F_LOCK with other special
> fields (except for BPF_SPIN_LOCK) on the UAPI side =E2=80=94 for example,=
 in
> lookup_elem() and update_elem()?

yes

> If so, I'd like to send a separate patch set to implement that after the
> series
> =E2=80=9Cbpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu map=
s=E2=80=9D is
> applied.
>
> After that, we can easily add the check in bpf_map_check_op_flags() for
> the UAPI side, like this:
>
> static inline int bpf_map_check_op_flags(...)
> {
>         if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record,
> BPF_SPIN_LOCK))
>                 return -EINVAL;
>
>         if ((flags & BPF_F_LOCK) && btf_record_has_field(map->record,
> ~BPF_SPIN_LOCK))
>                 return -EOPNOTSUPP;
> }
>
> Then we can clean up some code, including the bpf_obj_free_fields()
> calls that follow copy_map_value_locked(), as well as the existing UPTR
> check.

ok. fair enough.

