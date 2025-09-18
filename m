Return-Path: <linux-kernel+bounces-823242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A876B85E46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8114618918BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF24314B72;
	Thu, 18 Sep 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDG9y9Nk"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A300314A6F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211367; cv=none; b=NePigXPLB28afHzZUvH8SiNZLExXOJ7xZfnb5N/fns6nBZiZltf3ExEEYa6PhmvhzSFRTCgmSqP2Brq9sOgkoMG/h3bpaac/Sx8xicVyVXrS+ErHKLO4soiPziQBfKHbQeY7I5dCreCPtC7H8r2QvOmTveIG9Idav50dXBA5fE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211367; c=relaxed/simple;
	bh=LrZKUAO3ywnk+gBp3Su47n15fOX6/zrjj2N+0HVPaMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUk3o9Mr2pTPmnlSLkOUT1XG60qb3DLxfU8REytAhcNmS/woPPx5Bxowkt/ejziMNywjp55HiBOV7OAkO+9EgLBH5arbSOKq3ZSosqZfiStKghBxqZToDyQvlykh9SQBxWcdJttlHEvxj1iO2NCxk2jP7kaiE/nFK3q+tzEuMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDG9y9Nk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso967277f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758211365; x=1758816165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrZKUAO3ywnk+gBp3Su47n15fOX6/zrjj2N+0HVPaMo=;
        b=NDG9y9NkPIGcHw4oX4VbvDEYIfXxz4zWHCkICmLjuVwP0DImZUEX15D/qmMAe7XJM2
         dIadezZvkotqKyb1CuTOdbYmDxMaOGsyUi1sTKJ9ytmZczSim1QIcwY3Ybj7JqJGdZz0
         IQmjK1fnKWXeAl61wMWMkxHyat9BmuAMy+LJ1a7nTTSP/Ep2z+j7CsqcPbVVttxKAA8s
         okYLfTd6l0tFbdAqSV+kX8R300NxUXtXKXiKvpmNrUP8Mptvjob6UCsbs5gC49uD6Q1A
         USxvZa85CSezID/SeSFeDGKhg8b9oB4sI2QD8UlnUz+W3UZNdzilyyIe86nGbyBYxfQz
         v7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211365; x=1758816165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrZKUAO3ywnk+gBp3Su47n15fOX6/zrjj2N+0HVPaMo=;
        b=UKinNfnLUO5xJ4NdoqCmcK2izxuJIDs23ewHwz5kPmjMz/e6Zr5TtpaSXF69WVmqo5
         77sBz84eBCrX5QFapV8LY2qXRQwKuYmRyOe/KwrahkfhmK4eXJfONIZs0ia9pH6/g246
         q/Hk54RKmx1UoRWl8kfEEZxKKnxDZUebkYvm8bh057wEWMSFAv4Ll/DXoFteAHBQeEzz
         IrY9RS/deUPYjO+tX4A4MKRfcRN0uWIHll4UiUA3LGOFLRSigKjhDnzMogp0Liek1+jw
         kVVQbsGrrhQGJYJPflxkpKVHg/n3bs2h7uvunhrLctMXgfmRq6BKEccc/1bRSC93pJSJ
         Be7w==
X-Forwarded-Encrypted: i=1; AJvYcCVA+5XJUxjgsIt1whD0S4TATfZ/Z/no6ft8MR3JGQyTkBedLSaEgn92dC/mizcisSUH1jaFknQz2Os46Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/JmCR0FZ4TZE8pLYh6dHB8bW5UZZaQFGl7ZcO7e0+F3xSsLU
	ZWxcLroT8wtlqbBlVw94weFT1uH0xOLpUpt4WvOZOvjbo+dMm/GuiUZNZ7110Tq2Ij2Tc/S89La
	C9IHgVgs2zWx91JCxj4Gm85VDak8VMXY=
X-Gm-Gg: ASbGncuW/IUhcfPC9iUHUIxl69Bjww5JKJsu8h6mJOG7sYzPmPer9pvSKFcVN/yC5Ha
	eO8/0ee1JgBnHP/nEdq/zidJsi6CNV0+akrOsDTIAUKWKWFdPJDPn4DVtLtUgmMimTXHVWCQkQj
	N1zQP0iktgbGCWxzS2I2jxOiua0fdrV7UYeo41x8VudunUjJhNMSlfWA4XWaOaeXUoHqsqhhBTm
	LajXwx5/ZG5lQkITrkQF/Ny05De4zuPJ+VKFGvltZws/uEcuMtB
X-Google-Smtp-Source: AGHT+IF/FFBWHRcVTs/+LtBreJEZsaWSmiKBNwb88aF2dIpnUD5x8xfpMpZDRdW+2m9r9+Ji/KaDPmYDlZ8eMY10ixQ=
X-Received: by 2002:a05:6000:2211:b0:3e7:6454:85a4 with SMTP id
 ffacd0b85a97d-3ecdfa16fe7mr5495324f8f.33.1758211364535; Thu, 18 Sep 2025
 09:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net> <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
In-Reply-To: <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 09:02:31 -0700
X-Gm-Features: AS18NWB-ppdSVkapCREEP3Ua9UP5H5-ayQEppp8cCj2htLk07k5VBgjq7znNbDg
Message-ID: <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:32=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Thu, Sep 18, 2025 at 9:05=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > > is_endbr() is called in __ftrace_return_to_handler -> fprobe_return -=
>
> > > kprobe_multi_link_exit_handler -> is_endbr.
> > >
> > > It is not protected by the "bpf_prog_active", so it can't be traced b=
y
> > > kprobe-multi, which can cause recurring and panic the kernel. Fix it =
by
> > > make it notrace.
> >
> > This is very much a riddle wrapped in an enigma. Notably
> > kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is that
> > cryptic next line sufficient to explain why its a problem.
> >
> > I suspect the is_endbr() you did mean is the one in
> > arch_ftrace_get_symaddr(), but who knows.
>
> Yeah, I mean
> kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
> arch_ftrace_get_symaddr -> is_endbr
> actually. And CONFIG_X86_KERNEL_IBT is enabled of course.

All this makes sense to me.
__noendbr bool is_endbr(u32 *val) needs "notrace",
since it's in alternative.c and won't get inlined (unless LTO+luck).

