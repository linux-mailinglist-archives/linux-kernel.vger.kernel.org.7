Return-Path: <linux-kernel+bounces-845750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B89BC6049
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFB8A3511D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1E29B8D0;
	Wed,  8 Oct 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktKijQ2Z"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B354204E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940843; cv=none; b=mebaJiMx5pTT0hMCNcTdgxygU8qWqRmyqZfL/1hi75JALh8IS29mZJY5VZQUm5akEflxZ1VAYF41+KtW9SywmOGwx4dktUqtbsELZngRMvyX3NdULuI+OcTpLRkjdO+bli2Ew+hoIgCl1nPqzckeH+wAYBKBD+6ERFf1cHksQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940843; c=relaxed/simple;
	bh=ESYUvIrXIZf8LOINPbGCLLFX0IwDLy3Yro+8H8/WXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b24sBKOzlPX7HqIv+6vYL9fORTX6aGxslo075yjJAML4qhj37E7NwNzg/Ud5Jizf1Ug/pKONviBkbmN+v0MJ/PSPk/wHm65ZFp96zPFfuMso9ZArIlKHSZmjQgAvE+Gr12N5j5GuUDCNP+QVhNhZOwarefuW5sAQ3Ihb3neY+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktKijQ2Z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso454205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759940838; x=1760545638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMmT0yBvVqJ1w9268h9UX0+UvY7Ypnz5qKgFPlEn+l4=;
        b=ktKijQ2Zz61w+9Nb65gDjpEk7FqIES4Vs7UEtdWcb1yuqrDQmiGLWaU++F5+xO3mL6
         9w8OgLBWH63jLJdGb6AAVn81KE9aExlZ/Z+mU34bAVfb1FpMym95A1KD5msOPDtkya1I
         12//hGl9Xx+eOWhTH7MFL4q+xwtFkijLLzCigSTnYKgztpYfo9xhc04WpfQJLArGLXtv
         Wvl80hcH9mAE4e85d05k2yvtG2/Gq4y+XRFKSP5ktgBy1z3n22QfeND6khI3IezBkZ4N
         TIwvOWXazNv4zqXu1lB/ZpOVUvBItlAvMP6dmQxGaWhYIIeNPiiyN7pHQYwV6iY8d0br
         dHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940838; x=1760545638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMmT0yBvVqJ1w9268h9UX0+UvY7Ypnz5qKgFPlEn+l4=;
        b=KR5AgiBbUyk8aOYXdJ4GfmBzdqbpRV/plrzK7wz9800xA+d65lCR+ChRAJ6DlrhNMy
         z7AFSmOlXOoSCQFGcylxXLOIBz/PwmZezxOjiJxe4tD3r7uD9FuN2wNJPf6sN4ykgmup
         ineQKA6JF98OC+eDozqCYdyzshkK7kFJ+mr0Kcx/wwjJvi891k2YyysxYN0/zhT3Qol4
         dFC3wyZZ6hbKilJjphb6eLB8hxKZ1JCdAa1X3eLsWQ+LOyY4t3Kl+HcbrIuZjqFLi6oD
         5BGRBjmN/ZlwRj2n0HReIc/bp/q7E66wSMzemWGp46OnkNYg7ynKHLbdXlmyu0BvQPlN
         nj7w==
X-Forwarded-Encrypted: i=1; AJvYcCXyxOgROoWiK89/tfP9/kWnV4n7ou8E5BqzqUTPYQrA2v2fXEItAYVmTUg9drS400RJLH5u/iNb2WcucKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2kl4pElRviq3vuBQznT9leftELWbTiCxxQhSh4WPWB8lOdNx
	ZKZHWt/aLhTshaYh+MTVAh6wG4dUBq3WBtUGVpEAUz+eSAi0dxI6wkWqSW2rA6w+An0YNa9BeAV
	tW1BLIIfZh+JddofTYXfRg7pmRVH/b8E=
X-Gm-Gg: ASbGncvPIcC9ZBEXhQhqNFOJDKKG1MKKrp7iN3rIl8DyNbCIX8LvPEAGrOqWXfezkvq
	mUVpqhdE0hNX0+2hJ7anKRz6t+kmBeUCEvEO0SvZA6MZva6i6TsxQeDBCxmDxOs89Tz50+JxUnt
	I6H+7DzfUfL+dy0ihSf0Op246y3jJgReyXqCsOTfF2UBfPqSMY92ZPder/NUrQ1cOj1vpHaaV5O
	soCM0veI6+GT5CE5YPbR6IW/2M1sYI/WFWaW6i6sP0H33X3yaElOCN6+w==
X-Google-Smtp-Source: AGHT+IGydoa+Uq4878Yb/9h/myuPsA/hLU+ClnU6wU58PGmdNNA/S+SuciJyS4EWhUfyI1GnU9R2Dc7R6qET/aovPX4=
X-Received: by 2002:a05:6000:1449:b0:425:8559:5d17 with SMTP id
 ffacd0b85a97d-4266e7dfebfmr2645912f8f.30.1759940837904; Wed, 08 Oct 2025
 09:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev> <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
In-Reply-To: <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Oct 2025 09:27:04 -0700
X-Gm-Features: AS18NWBNt40LsuCSwzLCuqapaMgwYyUIMoVcfLF6Ag31yVFMBDU-uVz2cE-RisI
Message-ID: <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
Subject: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault to
 BPF stderr
To: Leon Hwang <hffilwlqm@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:41=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
>
> On 2025/10/7 14:14, Menglong Dong wrote:
> > On 2025/10/2 10:03, Alexei Starovoitov wrote:
> >> On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> >>>
> >>> Introduce the function bpf_prog_report_probe_violation(), which is us=
ed
> >>> to report the memory probe fault to the user by the BPF stderr.
> >>>
> >>> Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
>
> [...]
>
> >>
> >> Interesting idea, but the above message is not helpful.
> >> Users cannot decipher a fault_ip within a bpf prog.
> >> It's just a random number.
> >
> > Yeah, I have noticed this too. What useful is the
> > bpf_stream_dump_stack(), which will print the code
> > line that trigger the fault.
> >
> >> But stepping back... just faults are common in tracing.
> >> If we start printing them we will just fill the stream to the max,
> >> but users won't know that the message is there, since no one
> >
> > You are right, we definitely can't output this message
> > to STDERR directly. We can add an extra flag for it, as you
> > said below.
> >
> > Or, maybe we can introduce a enum stream_type, and
> > the users can subscribe what kind of messages they
> > want to receive.
> >
> >> expects it. arena and lock errors are rare and arena faults
> >> were specifically requested by folks who develop progs that use arena.
> >> This one is different. These faults have been around for a long time
> >> and I don't recall people asking for more verbosity.
> >> We can add them with an extra flag specified at prog load time,
> >> but even then. Doesn't feel that useful.
> >
> > Generally speaking, users can do invalid checking before
> > they do the memory reading, such as NULL checking. And
> > the pointer in function arguments that we hook is initialized
> > in most case. So the fault is someting that can be prevented.
> >
> > I have a BPF tools which is writed for 4.X kernel and kprobe
> > based BPF is used. Now I'm planing to migrate it to 6.X kernel
> > and replace bpf_probe_read_kernel() with bpf_core_cast() to
> > obtain better performance. Then I find that I can't check if the
> > memory reading is success, which can lead to potential risk.
> > So my tool will be happy to get such fault event :)
> >
> > Leon suggested to add a global errno for each BPF programs,
> > and I haven't dig deeply on this idea yet.
> >
>
> Yeah, as we discussed, a global errno would be a much more lightweight
> approach for handling such faults.
>
> The idea would look like this:
>
> DEFINE_PER_CPU(int, bpf_errno);
>
> __bpf_kfunc void bpf_errno_clear(void);
> __bpf_kfunc void bpf_errno_set(int errno);
> __bpf_kfunc int bpf_errno_get(void);
>
> When a fault occurs, the kernel can simply call
> 'bpf_errno_set(-EFAULT);'.
>
> If users want to detect whether a fault happened, they can do:
>
> bpf_errno_clear();
> header =3D READ_ONCE(skb->network_header);
> if (header =3D=3D 0 && bpf_errno_get() =3D=3D -EFAULT)
>         /* handle fault */;
>
> This way, users can identify faults immediately and handle them gracefull=
y.
>
> Furthermore, these kfuncs can be inlined by the verifier, so there would
> be no runtime function call overhead.

Interesting idea, but errno as-is doesn't quite fit,
since we only have 2 (or 3 ?) cases without explicit error return:
probe_read_kernel above, arena read, arena write.
I guess we can add may_goto to this set as well.
But in all these cases we'll struggle to find an appropriate errno code,
so it probably should be a custom enum and not called "errno".

