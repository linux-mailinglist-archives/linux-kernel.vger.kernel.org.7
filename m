Return-Path: <linux-kernel+bounces-822468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED7B83F46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD384A60E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABC12773F0;
	Thu, 18 Sep 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiemgmDr"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9697226D04
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189836; cv=none; b=YKDjWFSz1AtMrzyrXD0NYLhECmCpWEqqh+KmCHPvEtUTzDWs0bEDPCnMs8CND07I3ThqC0zp/5JNJ5i/mTci6/7vHLpvt1GeQdN/vFOda7kT2G+T84ri7s6e6G5OhN2wzraXvxU/m8jO1EEouLx4wDy/RMBdT79h6qOq/LS265Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189836; c=relaxed/simple;
	bh=ByoR0cEGZmt0U5yHB5jQZmZ+RqLPgIYZYhgl1JFL/9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCD5G0mbxvBNa626vYX5YPzE75D1n1GKzQj1oMf7G+LS+b6MX+Z6cFaXvoqFrkhDMJlfrAGY/d/TjJdj8JzlAcVL3xLYHG3W+rGQXNh9+g/687juXEhaU1q2F4+bzxiRLWYxhRvin90GJh6wgeSO29YMV6/QtHSOtzsvVmOPe/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiemgmDr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so1040995e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758189833; x=1758794633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYCwkNUkEu1XT0gLNt7N//elymkdc3M3C0TwfgGszbA=;
        b=HiemgmDriJrtiUc6x6Z7M/ID2tZGsZimBYbrD0//RX01sKzaWuGPBgdlv9jM/mH4J3
         ya50pFzLfthv3sRUyf96wKLHEIkGnB9a2lylgVVoWM0btPWSuXz4IYsK0TwP7fbYaMJh
         2OMhijyZvnXH/hjlNaF3n5K3AOn5pR+xe25RybqlyN1sco3PfXYwLCfUAWCw23vajAI8
         2V9KEyzdLaRRkYCZcnstNsudEkbJJnPJexXJrdrjZfvMvjXqXCgjGFU1iX0kir7nvhJb
         KjhEI+VbF2ifWpQeopxMyrk2rROGU0CFjVCmRm8lEyqgEY+k8at0Zj1NWwf4xcjPZt/I
         WNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189833; x=1758794633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYCwkNUkEu1XT0gLNt7N//elymkdc3M3C0TwfgGszbA=;
        b=dAPUMMpOXa0nn33ofr0X+QlWwTttFKgrWeTbuQjUQKIUuKo71kDoI9nVpKaYDPj4tw
         mUbR0Yl8pluNiZwRtxJ42eVOT37pmpqI229XeCkU7Ed25eYgTbXFgfJOC+P+wJBPkG0T
         DjoWqGKw7OFcDI04++0WxiE4RL1O8ruh8GQNJ9KzfxTqKLUwJ4+aRQDLczPzixvHSmMu
         EUSlGqtlPweDz/5VzZKz/Fn0nBthlCEH5zQUdBODd1f598toAqEJXb3q6iM0ouCpMeCz
         sQgKpu/7DsU02Ww/uCPLskHgK39wHTHV3mtLG7kSbx5FaPTNFjiimGLV+L6SbKBzxKWA
         z4lA==
X-Forwarded-Encrypted: i=1; AJvYcCUlB9Ao5j7XQSLmmNq6lNjvdR08Ft5wVZIO76VbZASWZZU37DCajzMJv7o7wEafI8c8B//eAGUk4FeJH2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzLZ0lL+TkEI5PCeU3k2p4fHc+DCvt5bQoTWylP9zmjWJyRMLK
	hQ153f/0nj+m2++8IMFBHDDxPxaFsEYXtCTtOX2jM4Eg0kwJ3ZbxKPRQlhPpuskBlldjjLFJUPE
	h3moT/zU6lMr/RCmAYcAAzuRi5pcnbwU=
X-Gm-Gg: ASbGncvo3Uz/vnbeIyrWHac4kG/1mYfBh0oXx4QNTvjOAUNo5UBou+TCu5H2GfaGn7f
	4p73fETo3mg9qCBQlvb9WuNZk+M/PqE+ZXxRp//3mTJgd6ONRQUfykzbQVA16qJCnrKaJrexfi7
	rmiznidOtzbz31cjlA/081PerrvnITUz53AqyTC4WI16ZF40yJQrMYTmx/vQXzdVceCcFOL4Cvr
	Gj6Cl12EAPaZ3ctMTbxexDIfAo=
X-Google-Smtp-Source: AGHT+IGWZd43JlKEWN+6I3rADVYp29++tuAbpqU7PxhYsMZJEVGNUvfnGTLsMFkPHV6lU3pTyYHqYCeJcd9azkwT2OY=
X-Received: by 2002:a05:6512:32cc:b0:571:f077:d96f with SMTP id
 2adb3069b0e04-57798756ae8mr1625467e87.37.1758189832455; Thu, 18 Sep 2025
 03:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKMdfmZo0520HqP_4tBDd5UVf8UY7r5CycjbGQu+8tcGge99g@mail.gmail.com>
 <CACYkzJ7X2uU=c7Qd+LUKnQbzSMyypnUu_WCMZ=8eX6ThXn_L6g@mail.gmail.com>
In-Reply-To: <CACYkzJ7X2uU=c7Qd+LUKnQbzSMyypnUu_WCMZ=8eX6ThXn_L6g@mail.gmail.com>
From: Ariel Silver <arielsilver77@gmail.com>
Date: Thu, 18 Sep 2025 13:03:40 +0300
X-Gm-Features: AS18NWC1YY66Iv1oonE3FepE-UmRLhzM1gqFCSI5l7KKoA-asGkp7gFlZKHvA10
Message-ID: <CACKMdfkPsemrUMPXNO5OR9Y2y70xNVVY9ss-3hX9NtGXFJxyQg@mail.gmail.com>
Subject: Re: [PATCH v2] docs/bpf: clarify ret handling in LSM BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just so I understand.
1) The docs are indeed wrong, correct?
2) Any idea why I get an automatic response of "CONFLICTS" when I send
my patch? Even though im 1000% sure there are no conlicts

On Wed, Sep 17, 2025 at 12:31=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> On Thu, Sep 11, 2025 at 12:52=E2=80=AFPM Ariel Silver <arielsilver77@gmai=
l.com> wrote:
> >
> > v2: Fixed trailing whitespace (reported by checkpatch.pl)
> >
> > Docs currently suggest that all attached BPF LSM programs always run
> > and that ret simply carries the previous return code. In reality,
> > execution stops as soon as one program returns non-zero. This is
> > because call_int_hook() breaks out of the loop when RC !=3D 0, so later
> > programs are not executed.
> >
> > Signed-off-by: arielsilver77@gmail.com <arielsilver77@gmail.com>
> > ---
> >  Documentation/bpf/prog_lsm.rst | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/bpf/prog_lsm.rst b/Documentation/bpf/prog_ls=
m.rst
> > index ad2be02f3..92bfb64c2 100644
> > --- a/Documentation/bpf/prog_lsm.rst
> > +++ b/Documentation/bpf/prog_lsm.rst
> > @@ -66,21 +66,17 @@ example:
> >
> >     SEC("lsm/file_mprotect")
> >     int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
> > -            unsigned long reqprot, unsigned long prot, int ret)
> > +            unsigned long reqprot, unsigned long prot)
> >     {
> > -       /* ret is the return value from the previous BPF program
> > -        * or 0 if it's the first hook.
> > -        */
> > -       if (ret !=3D 0)
> > -           return ret;
> > -
>
> This is correct as of today, the return value is checked implicitly by
> the generated trampoline and the next program in the chain is only
> called if this is zero as BPF LSM programs use the modify return
> trampoline:
>
> in invoke_bpf_mod_ret:
>
> /* mod_ret prog stored return value into [rbp - 8]. Emit:
> * if (*(u64 *)(rbp - 8) !=3D 0)
> * goto do_fexit;
> */
> /* cmp QWORD PTR [rbp - 0x8], 0x0 */
> EMIT4(0x48, 0x83, 0x7d, 0xf8); EMIT1(0x00);
>
> Acked-by: KP Singh <kpsingh@kernel.org>

