Return-Path: <linux-kernel+bounces-887497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAA5C385F2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8773B19C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719182D5436;
	Wed,  5 Nov 2025 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQsg6Llc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A7265629
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385477; cv=none; b=D2nQlexMgL1wXbsJo3rYPKJ7xPQbEhH36T5Od4DtWdozUiLFIUrrmweEOAOM6WEtisS3LYuCdPQYiVYqN3EzQ+QzadNF8N/kyXOU0kwsNiHCGZAI0icFMP/z4s5GVXBIyw+DhvHHsiFH9zLyYPUz1og3QcnnzEiomdmBaNydLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385477; c=relaxed/simple;
	bh=VOy1ApJJdF7nSPaonf/OlxWK/WsWg8EKFkVcp/+OGfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnLugHOdEmiT380/Rad7vKFjSuHpzBqCHDY71H0d986KXGQREPlHNg3DGO9UARyv9mG6d5T+GEv5JLlZqB5dqH0cjK/6HzhqKvoMQG7r88CPhTcNgl2zMWlPurZprSTDrLyeZH8y15mhJm2sdcVPcJKyaOOx3WMJ1CevirgpHuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQsg6Llc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c82bf86bso286222f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385474; x=1762990274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLff7yY29Bw0Pf6RhpnO3Xm0Qz1FxoTlvdLIXSwjL1s=;
        b=iQsg6LlcwSl8zuLl37faAEG4mUhEnUSwPHHOAySElfnFBU1veQz535j/qyIBeF1ikz
         IFJ5rYlxiVcXsgKQ7yDTuygqd3uIJqRh5XHbJpKa8fRnE7yICjJjr63N1+YtQVgqm4oV
         hJ5q8nR33DqrfQ+wGjUNhavO6ZWskkd5qNvyPn1e+YuWzhKcqomj1ah9PvNAxn6CLAwg
         0ISpECVDDHFFYYoEfekW0YLXmygKJNUiDJinrLL8TELZyERDcj0QD2FsuGKSH6aNa/yk
         xPwHZCoCBosxyYLeOiuftSoDwGiGvuAiBC2d9y3M5IizzvHGQrJ5z/+cMrRIrhGMsIXo
         xnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385474; x=1762990274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLff7yY29Bw0Pf6RhpnO3Xm0Qz1FxoTlvdLIXSwjL1s=;
        b=d9MsMz+9D3R2Rrodmg09VdDPhurxjUtYVAw7x7s5PLzzKAZiXjkSj2VhgVkpM67G2f
         tXITaUOk88fZfyBaR2whLHnAdwtuEuAH+Y2Whj9EMPl26uTNTvOOIp4jGJo3wwwMQeVD
         zFSXL5tSfWvt/ARUF7owbe1wDCULL4PIvoup5SAD6FRsgtuMAT798bY0W8DAX0/lpb+v
         Yx8Q0zz3P6KfTkem2N+JVCQqJ0sRbfnBhS2KWBVl5JcQ7RNwDBNj+RFgnFMJ9K4ooNwd
         p+OeLKml6Ky5sdkHevp0PnfTzY9EATXEECewqeTCP+/z+L8qrAFncRJ1DD2G4HrwPun2
         K9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpipkzGaOvnKXhPL4t1YZkTK086Lp88oH+XC7jCOEXQm7rKMkObUJ/niN5TfbSYxHkkSDoXQrq03YDgbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8xN/752S8TC1WJV/l/U1bLH9b7fERchZKHKH/gIvd8bGYsIn
	P0i5EHDukFNLvGZ/5CGebNBQXkev4age6fcdA+rlCjPS2+K7Bk6HJB1+Rz1HJcMm4rD/TD2zo/S
	YdV0MXENFW+Wkz7DJZE5H24MB5Vk8ecw=
X-Gm-Gg: ASbGncuNkjoiqbqq2Bm51JgEn1prLrerfA6ui4MTErnVLjkbFmbksnXG1pobEsFRz+M
	uWh62SeaftYhckp8KaCwjPD8PcmBwj0hT/y7QgDjissbtYUMphMQmAHVZRKJ8p+UTH8iPgvz+54
	Bg6shYhUmK5BONjrW37qs9oQtmvW629LXhzPyUg22SzzmAZ4alXunWWjmF75BZUI/gDqlce8pzz
	Fvj6p7z9OY26XQZAvku6GDfYXEf7eDZWGt30UzucEFclfYQ4OpMqJ7WqI2TMgkYKvIG4DYeZAgy
	D5cY4pKWw30Ss8CKFA==
X-Google-Smtp-Source: AGHT+IEPo4vvGKdFdYaOCWO/C3z2MbExc2HiyXMZsyRlPZGRDmfsC77FnkV9L3GnPE79qoEl88Xoj1OuFgp3X7QVNHk=
X-Received: by 2002:a05:6000:4112:b0:3fb:aca3:d5d9 with SMTP id
 ffacd0b85a97d-429e32c560dmr3547625f8f.1.1762385473728; Wed, 05 Nov 2025
 15:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <CAADnVQKQXcUxjJ2uYNu1nvhFYt=KhN8QYAiGXrt_YwUsjMFOuA@mail.gmail.com>
 <4465519.ejJDZkT8p0@7950hx> <1986305.taCxCBeP46@7950hx>
In-Reply-To: <1986305.taCxCBeP46@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 15:31:02 -0800
X-Gm-Features: AWmQ_bm9rSdeKzrDfmPDobOY1lktymFioQLZOxvi-oR7PMuyY6gjmCQjyz5Mbbw
Message-ID: <CAADnVQLX54sVi1oaHrkSiLqjJaJdm3TQjoVrgU-LZimK6iDcSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 11:47=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2025/11/5 15:13, Menglong Dong wrote:
> > On 2025/11/5 10:12, Alexei Starovoitov wrote:
> > > On Tue, Nov 4, 2025 at 5:30=E2=80=AFPM Menglong Dong <menglong.dong@l=
inux.dev> wrote:
> > > >
> > > > On 2025/11/5 02:56, Alexei Starovoitov wrote:
> > > > > On Tue, Nov 4, 2025 at 2:49=E2=80=AFAM Menglong Dong <menglong8.d=
ong@gmail.com> wrote:
> > > > > >
> > > > > > In origin call case, we skip the "rip" directly before we retur=
n, which
> > > > > > break the RSB, as we have twice "call", but only once "ret".
> > > > >
> > > > > RSB meaning return stack buffer?
> > > > >
> > > > > and by "breaks RSB" you mean it makes the cpu less efficient?
> > > >
> > > > Yeah, I mean it makes the cpu less efficient. The RSB is used
> > > > for the branch predicting, and it will push the "rip" to its hardwa=
re
> > > > stack on "call", and pop it from the stack on "ret". In the origin
> > > > call case, there are twice "call" but once "ret", will break its
> > > > balance.
> > >
> > > Yes. I'm aware, but your "mov [rbp + 8], rax" screws it up as well,
> > > since RSB has to be updated/invalidated by this store.
> > > The behavior depends on the microarchitecture, of course.
> > > I think:
> > > add rsp, 8
> > > ret
> > > will only screw up the return prediction, but won't invalidate RSB.
> > >
> > > > Similar things happen in "return_to_handler" in ftrace_64.S,
> > > > which has once "call", but twice "ret". And it pretend a "call"
> > > > to make it balance.
> > >
> > > This makes more sense to me. Let's try that approach instead
> > > of messing with the return address on stack?
> >
> > The way here is similar to the "return_to_handler". For the ftrace,
> > the origin stack before the "ret" of the traced function is:
> >
> >     POS:
> >     rip   ---> return_to_handler
> >
> > And the exit of the traced function will jump to return_to_handler.
> > In return_to_handler, it will query the real "rip" of the traced functi=
on
> > and the it call a internal function:
> >
> >     call .Ldo_rop
> >
> > And the stack now is:
> >
> >     POS:
> >     rip   ----> the address after "call .Ldo_rop", which is a "int3"
> >
> > in the .Ldo_rop, it will modify the rip to the real rip to make
> > it like this:
> >
> >     POS:
> >     rip   ---> real rip
> >
> > And it return. Take the target function "foo" for example, the logic
> > of it is:
> >
> >     call foo -> call ftrace_caller -> return ftrace_caller ->
> >     return return_to_handler -> call Ldo_rop -> return foo
> >
> > As you can see, the call and return address for ".Ldo_rop" is
> > also messed up. So I think it works here too. Compared with
> > a messed "return address", a missed return maybe have
> > better influence?
> >
> > And the whole logic for us is:
> >
> >     call foo -> call trampoline -> call origin ->
> >     return origin -> return POS -> return foo
>
> The "return POS" will miss the RSB, but the later return
> will hit it.
>
> The origin logic is:
>
>      call foo -> call trampoline -> call origin ->
>      return origin -> return foo
>
> The "return foo" and all the later return will miss the RBS.
>
> Hmm......Not sure if I understand it correctly.

Here another idea...
hack tr->func.ftrace_managed =3D false temporarily
and use BPF_MOD_JUMP in bpf_arch_text_poke()
when installing trampoline with fexit progs.
and also do:
@@ -3437,10 +3437,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im

        emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
        EMIT1(0xC9); /* leave */
-       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
-               /* skip our return address and return to parent */
-               EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
-       }
        emit_return(&prog, image + (prog - (u8 *)rw_image));

Then RSB is perfectly matched without messing up the stack
and/or extra calls.
If it works and performance is good the next step is to
teach ftrace to emit jmp or call in *_ftrace_direct()

