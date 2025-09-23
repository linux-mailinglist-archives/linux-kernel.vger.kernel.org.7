Return-Path: <linux-kernel+bounces-829513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3693AB973ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796402E5F45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8402FB630;
	Tue, 23 Sep 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpozEqWp"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6A2BE644
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653561; cv=none; b=OAlwaJ7e6sa53+cb2+YxRZJ5euw6uCR6gYoj1CX2jmB82gaIU3UgOHDqVKPGy03NtPc5FnkDSOPax0nqG8HipGQPS0X7H3t3gW8CRc7FFjl55aRlC0z7cFIMtTN9VEL3meCK0wOnu45nB1kz+o9sJRU/vM9le0ZYzpybTYjVy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653561; c=relaxed/simple;
	bh=cgONVmkhgMelsDdmMuAt/qU/DExf9Qngi25mO8xSTew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFK2TJiV7xy/Rd+6yWgeDa7i3I1wDIk6p+m3DQm1/iL/wYMohndYHmt3XQ10GmyBf29cI+zxIIeQhWr5QSkayEXtIjyOJqfJ3l8UE9QDaf3wg31x+Wk46q0h/RS0h8qz5Bpa5s8Pi3gfNTAoMWYW9GJXQIlOHeOXXUQ+SZM9w3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpozEqWp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46d25f99d5aso1296605e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758653558; x=1759258358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUn2OpHmm7pfo4BppeNZW2V1cfojK5GlgjBJHRJGklM=;
        b=hpozEqWp2Dcg0CBYlV+BDbO+v4I8FQ90V6/QmuCwjbEvRgA5ETJUTY2sXvMC8DlNZx
         oxHNEy6hgI1qhVw7V8DxrF28Qf88j/EXbMXSm+xx1OrYx+AfhWTsNnljvG8w8WoFaIHS
         1x1ijLt9/CSRINFStPQh2gbczJ34EKtz6UHBA4C/oObYGxcv7zstFT96lKpOi66J6IKN
         rByU36HKgmN+dT1PKnWLuBZWR6hmfFAp5AakOzWfeIXSJdCYhWnfw/N1tLqYgyqwT1m3
         XJUyHrKjs3hG18IJeZBiMX0WzpkyTtcZ3szF7sORSL3LbAK/vfO9cEnOuwpAIjxTf4+q
         lRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758653558; x=1759258358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUn2OpHmm7pfo4BppeNZW2V1cfojK5GlgjBJHRJGklM=;
        b=WMm1PfDMDtyhw/oWEWD81JiQFq15thRrEEv2CnawukVdR4FbiXxik/S1a5Wk5vuB+C
         899aYJk3Jl5Trhe8dD1QfRiFi0TbS99BN8uw8YR12/dKW+58lLV/q2kCrIFmZ5GN3cFZ
         snb9wm+J6soaA4sYlDIPST3I0sFN3bOUOzUJk3+fXrOJYczS4oz5+EmWP1uv23Von6wL
         ebMsyoX1bT/u6PkFq05g2THRQog16vCmSpj6HQFXAlkXVBv9zX65xuW+krYv8Gw6dQMg
         M1Oide14CHog7Txw3WFBSlUHyDI89P46SiClIyB5exnwD0v8XT3C/Yz1fI8RDXJOoI2C
         XteQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzo7rG4mDqalwUg0j53tF+hL7mBWCumLO4h8UU7yGT4Hpl7x5pcRQJMRB1nwtz21bOYAtFlKPpvJ4bfE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/FUPV4A8Z/qSiuaCZRwlb1jzRhAs+/PMvhz33WBs5Xsjpa2P+
	ieZThwQGiHWZANw3HfZeE1OvTovx93UqTWphX/sOP1BC76lR3tNKelgT4F+q1BxS32CWsBpn6TI
	SG9JQaFjHy1uCDuyjldYv2Sr09olL3Bo=
X-Gm-Gg: ASbGncsv2ehtn34UyU3J7WX8ivF1qOP6wY9Fd1qqBQQ8QgDicpWqB5lX0RYcPUuhBGx
	uPFhBRwOz6pFur2q2mzoFDf2vbZoou8G/7w9fHlzVxmdTgYQHI/heFrikWrG100VyindkElKgo7
	98IlOOorFGsDBeKRfnpu4g4U8dxl12Y3p/MzhXqcuPqg6pAXKAu1FFSKHgRPtyuzfUNAcDEZtIF
	N5SMMs=
X-Google-Smtp-Source: AGHT+IFXdr1qAFRKrRIhRvTAlUBj6EMd3fVOhJImQNL3jAjkCWTz1HxTEqxRjvy5Y2MiYiNM5folI9tZZzb0E6VAjPo=
X-Received: by 2002:a05:6000:1885:b0:3f0:8d2f:5ed9 with SMTP id
 ffacd0b85a97d-405ca2a64bfmr2999158f8f.1.1758653557938; Tue, 23 Sep 2025
 11:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com> <20250923164357.1578295-1-listout@listout.xyz>
In-Reply-To: <20250923164357.1578295-1-listout@listout.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 11:52:26 -0700
X-Gm-Features: AS18NWD76Xqc7COam94wfoYJ9nOoP1gcYlOdh0b2K3xOtwaSSY20L2ccQKJi6N4
Message-ID: <CAADnVQJva1iQbVk4h9sKEEBnfDVd4iJDKR499n=hj_JL1dMZ5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] bpf: fix NULL pointer dereference in print_reg_state()
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 9:44=E2=80=AFAM Brahmajit Das <listout@listout.xyz>=
 wrote:
>
> Syzkaller reported a general protection fault due to a NULL pointer
> dereference in print_reg_state() when accessing reg->map_ptr without
> checking if it is NULL.
>
> The existing code assumes reg->map_ptr is always valid before
> dereferencing reg->map_ptr->name, reg->map_ptr->key_size, and
> reg->map_ptr->value_size.
>
> Fix this by adding explicit NULL checks before accessing reg->map_ptr
> and its members. This prevents crashes when reg->map_ptr is NULL,
> improving the robustness of the BPF verifier's verbose logging.
>
> Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  kernel/bpf/log.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 38050f4ee400..b38efbbf22cf 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -716,11 +716,12 @@ static void print_reg_state(struct bpf_verifier_env=
 *env,
>         if (type_is_non_owning_ref(reg->type))
>                 verbose_a("%s", "non_own_ref");
>         if (type_is_map_ptr(t)) {
> -               if (reg->map_ptr->name[0])
> +               if (reg->map_ptr !=3D NULL && reg->map_ptr->name[0] !=3D =
'\0')
>                         verbose_a("map=3D%s", reg->map_ptr->name);

Looks like you're bandaiding a symptome instead of fixing
underlying issue. For map types map_ptr should always be set.

pw-bot: cr

