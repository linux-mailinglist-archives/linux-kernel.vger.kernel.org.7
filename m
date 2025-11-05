Return-Path: <linux-kernel+bounces-887499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDB0C38613
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D987E4E80A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B862F5499;
	Wed,  5 Nov 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd3MaR6M"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131122D9ED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385621; cv=none; b=ePl7K5eKvFI6CTZgRhpi8cBdyOt5ME2eRp0GqcmMDIxbE78816G4YDTc2Jna4MTLj4JaRaw1G8MiHjyWvQ9M/Ztoi607MsG78+ghlIPoPhjfwFDGBGVUwyFkjqDyxBuQvgfpLikYV5AVlikETJ/4N8X+6m5e9qNFQNxC2i2qivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385621; c=relaxed/simple;
	bh=RoHqgdm7fFl5Yh0xwlNj+CL9/T7cunCVRJpIqPbD+E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDk8qJdHP2JsVBtHHbaQsw4eIlfiAxlxIj7+teWstoiYX+4M2UEALFBeY7HFh0Sk+9SJbMIjIfyL2dwH+VAykJXXlk/yasVmbfJcjSTBQ/5D+NQmzv5cAqKdNd/7ARxQvidsd7rkjOB2ACT8P3yCpngN1XBvdiN1QnVeY/DtYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd3MaR6M; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so793733f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385618; x=1762990418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A32nXO43+m2kR+8eaRzNcHIYkEApDPiVW8pHqnBOQt0=;
        b=Rd3MaR6Mbkr6u3FFERkInTigl5NhDD/8zcLQSTTEDG90Uz7a/zhgpMIEDqGFOdL/1w
         429p4UHQCrqmonvW/oJUzb/avDv5Dxl8XibBmrw3YdTphlmYtyzEUY8f7wGYU983aFMQ
         BRg9CbOki3kLWiSDq4cgRVg82BFRb1+2HGtjZTykCtLy6RaTKkZ1DaofgAM7mD8MkJq6
         U+kCDbIfwM4PPEBA2Py6b9Lxuz3ub0x3nmozII/zVxGnpR3dlDmsjnuLFNQDg7oLMGJj
         j7L+BNKXYbqTQk2LEb3QYQQ4lb9WrbNFsSuWjFGB6LbXRQ5KOB4HFHdkzc4SN9zwF3ej
         hUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385618; x=1762990418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A32nXO43+m2kR+8eaRzNcHIYkEApDPiVW8pHqnBOQt0=;
        b=Ix57VxAC+fTAdVTtQBZsen/sv4kb0VkjZjJ2COWu9cpMDOfYJj3e9DBCvx8ePsJ7NE
         N9Ckg6ze0acMA5u3DPUTKnWOzFLw/BnQnwidumuWxg7zeN/TTjiuZqTS81ucjOFjxVjk
         8me35Miee0rVL52Dgf05bKjYJO1xHcTBwGQFBTcpd9cyk6Q8yubhf2T0P0mtw4VQZntV
         ioxFaogJNSCvVI89D3dkPSeRc5VQw95K7FU1ci4ELLqKdCxV8y4vzGm98RniDe4pd3I9
         1x+PB+5WVcQTmCGWg+gHirnCVaSBcbCgDE/yeC0dzVn7gWktzD9axmmbK/sjaA9EVlvM
         OJOw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Wd9ipJGhZRPSNpf7nOQtvJCgxENtVOa2BKCwDjgRhuTd1TugSjL7WPayFcUIGkAWhGRHi6s9evMCTS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFSTTeDyPOMjLw88tOMlRd64yXCH4uOG2Zp91dz7gWh54QO85
	47cb7BwszSKG9aQY5f50nPaa4LQ5JDMJ99PsQEy7ly3ICkFnM7mZyr1e/fkJfJ95X0bHNO8f1O4
	6hYrOdW8N5Ec9UpS/ZlbRrUAUBAV2LkU=
X-Gm-Gg: ASbGncvqnI0X8Haye8xVQGaR3tMsfy7tWAXe2hGHIg/bux2igvQsXe4MUztijDx6ngP
	NJXjPMkSh+ZxTW4M8u5Islb9Auufk5qfLjYgc/xRjrP+Ay1ej74uT6zB2f/BBXKu3I90nkED2n3
	WoF2sBzhbStdVJ1AUeRVBUQz37dRZ+v8RVxTpFHZHEu1HZv4qSC3xyQI3lnPgS02AO566echDes
	NnAKbzl/wHc6misbaRsd4yyQOcrKfRXeEfCX0aHwXBNK32MLfxgO9P5VKZgqcf1/MmceSF2zKTG
	UBvO8zEH++2PyFuzKerZr7tFkTl2
X-Google-Smtp-Source: AGHT+IFi15XXG51xVgDDu0e2kdYsdqqcOP+5TL9/eEL9rxbiDzL6XMtse44f+Pr3b/wZshISq8Jg/ZZNqOdRK5iGPdo=
X-Received: by 2002:a05:6000:1849:b0:429:ccd0:d36c with SMTP id
 ffacd0b85a97d-429eb19d72cmr1055962f8f.14.1762385618434; Wed, 05 Nov 2025
 15:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105201415.227144-1-hoyeon.lee@suse.com> <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
 <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
In-Reply-To: <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 15:33:25 -0800
X-Gm-Features: AWmQ_bmfpzydKuHyeC5aqOqiAefI6FMJ9biunpiR2FY5nzyk7MMSFvRPKri5HKg
Message-ID: <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hoyeon Lee <hoyeon.lee@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com=
> wrote:
> > >
> > > The netif_receive_skb BPF program used in snprintf_btf test still use=
s
> > > a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
> > > available and provides the same functionality.
> > >
> > > This commit refactors the test to use the bpf_strncmp helper, removin=
g
> > > the redundant custom implementation.
> > >
> > > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > > ---
> > >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +------------=
--
> > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/=
tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > index 9e067dcbf607..186b8c82b9e6 100644
> > > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > @@ -31,19 +31,6 @@ struct {
> > >         __type(value, char[STRSIZE]);
> > >  } strdata SEC(".maps");
> > >
> > > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > > -{
> > > -       const unsigned char *s1 =3D m1;
> > > -       const unsigned char *s2 =3D m2;
> > > -       int i, delta =3D 0;
> > > -
> > > -       for (i =3D 0; i < len; i++) {
> > > -               delta =3D s1[i] - s2[i];
> > > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > > -                       break;
> > > -       }
> > > -       return delta;
> > > -}
> > >
> > >  #if __has_builtin(__builtin_btf_type_id)
> > >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)        =
           \
> > > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *m2=
, size_t len)
> > >                                        &_ptr, sizeof(_ptr), _hflags);=
   \
> > >                 if (ret)                                             =
   \
> > >                         break;                                       =
   \
> > > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_STRSI=
ZE); \
> > > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _expecte=
dval); \
> >
> > Though it's equivalent, the point of the test is to be heavy
> > for the verifier with open coded __strncmp().
> >
> > pw-bot: cr
>
> I double checked that before acking, the test was added as a part of [1].
> So it seems to be focused on bpf_snprintf_btf(), not on scalability.
> And it's not that heavy in terms of instructions budget:
>
> File                     Program                  Verdict  Insns  States
> -----------------------  -----------------------  -------  -----  ------
> netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     629

Is this before or after?
What is the % decrease in insn_processed?
I'd like to better understand the impact of the change.

