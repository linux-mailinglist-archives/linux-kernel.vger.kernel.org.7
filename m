Return-Path: <linux-kernel+bounces-789307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B942CB393BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7413A5E2C33
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7045277CB9;
	Thu, 28 Aug 2025 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZc6LY2j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F21CAB3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362274; cv=none; b=EqTsHbX/Y0xmg4FCX2LnRtD6zpcRTajrLVflmtMJaH30LOYJ4asW7wARj62Lge8w/3EpL5ITxYAMMP8s0qxkcx2xMBoLY3bNnoUwz8tZC7vg+71PaPTnZNu0+qE5q7cymcK7rjW7+Y19Rkc7WYJaPNttdJ1UzbrHmACf4X0151I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362274; c=relaxed/simple;
	bh=PbTNAw6VsC0gq8pGRpCcIHQPHceTnxcZLFVsT//1nFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=empSlSbIrOt1w+KvKyKNlh08ho6O0P8gJm5hrsk4k47K3o5CcOEB/e3FGWdel4ZBQ5S+2b7oJ5criPOLk7VHVMQ0M7K8CIb3QKTe1kMLR2YG06fLg4zcdU4wfZm0qZa8CcksggxFGugehL07OtCaQ6GHPGvIiHiFTyzKQ+Fw7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZc6LY2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C31C4CEED
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756362273;
	bh=PbTNAw6VsC0gq8pGRpCcIHQPHceTnxcZLFVsT//1nFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rZc6LY2juK9W7cD2kQl3hihP6CnbDnyCc0WR4B5fUUvr+uC8LbFBHpX+kqjPHuqp9
	 WB3/ygN5MIx7nI7xv3iuQkvHIZpTsqy3KmNVXP3MRBJwnotK1L4EHxDRwLQ+5JXoob
	 D3QqgUEYMHfMQiLEw4Ex6atdwKh1UKlBzM5aDVsbXYd5zp1oSUR8A36dQEqOkiix0f
	 bC1kRqvPjnjna9ZDsosDgPAARkCyAKhJvf95Wx4DLh9+IU4P/clSmdtvQ8rX1yldTO
	 2xSNJCCQSV/P+iZu/FbpCzXzcSVz5XFpQoYl4Div1HU2h7jhqGwoyhhifdJntvwTyq
	 T/Jc6ctFJ01Sw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb78ead12so85689666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:24:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPFVO9lwag9GS8yz+O6wAQxPK+3SzjbA/ioeQra4vLqGecOGiqfMgeDIq+9jx6j5XSsmjaoA14hP4qIXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGk99mlYhC47Nyz0Nv6Xl4ykmQ+AtevUyRv475MJdzcTgzuMb
	tUxx2r7+iqg7ivzL9vfmzMZ7IHGtsy/H+eEBs5+izj3M+bJGqMuX//rS9el8oA6vBUA4+UmIlrm
	xLyx6FQ36rB2Hw9oM0vsijJ0ygZqBIXI=
X-Google-Smtp-Source: AGHT+IEYCrvShTe9yG42YxJ8urVHPGRw2tZPfQGhKCQTKV1ONMGFl0EOB38RtG7/af97vG3MmBuw4w7xe34Me5jPunA=
X-Received: by 2002:a17:907:d10:b0:af9:618f:83e with SMTP id
 a640c23a62f3a-afe2904321bmr2009811166b.37.1756362272254; Wed, 27 Aug 2025
 23:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826113225.406238-1-guanwentao@uniontech.com> <a0e11216-71b0-447f-beab-351d024810fb@linux.dev>
In-Reply-To: <a0e11216-71b0-447f-beab-351d024810fb@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 28 Aug 2025 14:24:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7zKLNpx7jM=JBT7unqQ=G4Ztv4RgEhrFsjP+P4LjPYjA@mail.gmail.com>
X-Gm-Features: Ac12FXx7udJpFMqE5gAtyKL_lpNyiSqtIp5wVrATKJWMX8-LbkV-HdT1q3hy8EI
Message-ID: <CAAhV-H7zKLNpx7jM=JBT7unqQ=G4Ztv4RgEhrFsjP+P4LjPYjA@mail.gmail.com>
Subject: Re: [PATCH] Loongarch: entry: fix syscall_get_arguments() VS no-bultin-memcpy
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Wentao Guan <guanwentao@uniontech.com>, kernel@xen0n.name, xry111@xry111.site, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	zhanjun@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:47=E2=80=AFPM Yanteng Si <si.yanteng@linux.dev> w=
rote:
>
> =E5=9C=A8 8/26/25 7:32 PM, Wentao Guan =E5=86=99=E9=81=93:
> > Loongarch use -fno-builtin-memcpy in Makefile,
> > so cause a extra memcpy in syscall hot path:
> >
> > syscall_enter_audit
> > ->syscall_get_arguments->memcpy(__memcpy_fast)
> > ->audit_syscall_entry
> >
> > Just avoid memcpy() altogether and write the copying of args from regs
> > manually, which shows 5% multi core score up in UnixBench syscall.
> 5%? Awesome!
> >
> > Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>
But why this is a "fix"? It is an optimization.

Huacai

>
> Thanks,
> Yanteng
> > ---
> >   arch/loongarch/include/asm/syscall.h | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/incl=
ude/asm/syscall.h
> > index 81d2733f7b94..171af2edd569 100644
> > --- a/arch/loongarch/include/asm/syscall.h
> > +++ b/arch/loongarch/include/asm/syscall.h
> > @@ -65,7 +65,11 @@ static inline void syscall_get_arguments(struct task=
_struct *task,
> >                                        unsigned long *args)
> >   {
> >       args[0] =3D regs->orig_a0;
> > -     memcpy(&args[1], &regs->regs[5], 5 * sizeof(long));
> > +     args[1] =3D regs->regs[5];
> > +     args[2] =3D regs->regs[6];
> > +     args[3] =3D regs->regs[7];
> > +     args[4] =3D regs->regs[8];
> > +     args[5] =3D regs->regs[9];
> >   }
> >
> >   static inline void syscall_set_arguments(struct task_struct *task,
>

