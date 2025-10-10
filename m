Return-Path: <linux-kernel+bounces-848428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF0BCDC1E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DB8407631
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ADB2F83C2;
	Fri, 10 Oct 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jaqr4IG6"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3F2F83A7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109079; cv=none; b=r5FGnxzavef1+kGfMon1RjJmHvweiySFjUvcniy/aTyd3/cx32aDBBzyXV18AuuEAkzv7cZFOGA5rmj1VFhgxQqih7fr3OtqfHmn+EP4JJPutagmS7AFd5ldLGnNR7hTMh5H94ZYajJqbXVvXKFz6ODbZqGI105WfpqyqA8Q2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109079; c=relaxed/simple;
	bh=OufjMV7n9C333+rJytXkSYUZuipa6ORADmGGGWWRiLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da/ZGBQcjdN2lRzF0TuGYx3bTlkoxoINJ82OvJZr6SOUQ2HhRmyMEUJmMots1ysCNaxyC94XAXwYKuklYcHWppafxSnBbJlnjdoU+U6gBOUZ/KcPurVRt6bs2ygP7Q+ii4Q3VsxXihdikRQC7ceRx7yZECUNegZncI0QAefOjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jaqr4IG6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760109065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2WIDIQGrfvJR6KEY/O1u4w6eW9kKtDSQxyS2Lc5ggQ=;
	b=Jaqr4IG6pufJjrp/2SyboMGXVzdlJIKgiojREsycVdzBLeXyNSDAZEbCE7CBcRt3kjJjcO
	naj4rdtWA+AqtJUJa0RXpya/lGbE9t7Uj3rnmRjJDge8Qm7rwFY9QHan5cTzq8ANMF7bfP
	7GBuN2LgteddFPnQLus/W1qf0qerFm8=
From: Menglong Dong <menglong.dong@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <hffilwlqm@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Subject:
 Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault to BPF
 stderr
Date: Fri, 10 Oct 2025 23:10:56 +0800
Message-ID: <1983718.CQOukoFCf9@7950hx>
In-Reply-To: <3349652.5fSG56mABF@7950hx>
References:
 <20250927061210.194502-1-menglong.dong@linux.dev>
 <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
 <3349652.5fSG56mABF@7950hx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/10 20:05, Menglong Dong wrote:
> On 2025/10/9 04:08, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 8 Oct 2025 at 21:34, Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Wed, 2025-10-08 at 19:08 +0200, Kumar Kartikeya Dwivedi wrote:
> > > > On Wed, 8 Oct 2025 at 18:27, Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Oct 8, 2025 at 7:41=E2=80=AFAM Leon Hwang <hffilwlqm@gmai=
l.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 2025/10/7 14:14, Menglong Dong wrote:
> > > > > > > On 2025/10/2 10:03, Alexei Starovoitov wrote:
> > > > > > > > On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <men=
glong8.dong@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Introduce the function bpf_prog_report_probe_violation(),=
 which is used
> > > > > > > > > to report the memory probe fault to the user by the BPF s=
tderr.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
> > > > > >
> > > > > > [...]
> > > > > >
> [......]
> > > >
> > > > Yeah, agreed that this would be useful, particularly in this case. =
I'm
> > > > wondering how we'll end up implementing this.
> > > > Sounds like it needs to be tied to the program's invocation, so it
> > > > cannot be per-cpu per-program, since they nest. Most likely should =
be
> > > > backed by run_ctx, but that is unavailable in all program types. Ne=
xt
> > > > best thing that comes to mind is reserving some space in the stack
> > > > frame at a known offset in each subprog that invokes this helper, a=
nd
> > > > use that to signal (by finding the program's bp and writing to the
> > > > stack), the downside being it likely becomes yet-another arch-speci=
fic
> > > > thing. Any other better ideas?
> > >
> > > Another option is to lower probe_read to a BPF_PROBE_MEM instruction
> > > and generate a special kind of exception handler, that would set r0 to
> > > -EFAULT. (We don't do this already, right? Don't see anything like th=
at
> > > in verifier.c or x86/../bpf_jit_comp.c).
> > >
> > > This would avoid any user-visible changes and address performance
> > > concern. Not so convenient for a chain of dereferences a->b->c->d,
> > > though.
> >=20
> > Since we're piling on ideas, one of the other things that I think
> > could be useful in general (and maybe should be done orthogonally to
> > bpf_errno)
> > is making some empty nop function and making it not traceable reliably
> > across arches and invoke it in the bpf exception handler.
> > Then if we expose prog_stream_dump_stack() as a kfunc (should be
> > trivial), the user can write anything to stderr that is relevant to
> > get more information on the fault.
>=20
> Thanks for all the ideas! So we have following approaches
> on this problem:
>=20
> may_goto(Kumar)
> --------------------------
> Hmm......I haven't figure how this work on this problem yet.
>=20
> "may_goto" is a condition break, does it mean that we introduce
> a "condition_fault"? Will it need the supporting of the compiler?
>=20
> I'm not sure if this is the right understanding: save the fault
> type(PROBE_FAULT, AREA_READ_FAULT, AREA_WRITE_FAULT) to
> the stack or the run_ctx, and the "if (condition_fault)" will be
> replace with "if (__stack or run_ctx)".
>=20
> save errno to r0(Eduard)
> -----------------------------------
> Save the errno to r0 in the exception handler of BPF_PROBE_MEM,
> and read r0 with a __kfun in BPF program. (Not sure if I understand
> it correctly).
>=20
> This sounds effective, but won't this break the usage of r0? I mean,
> the r0 can be used by the BPF program somewhere.

I think I'm a little understand it:

int a, *b;

b =3D xxx;
a =3D *b; // insert "r0 =3D 0" before this insn in verifier
             // if fault happen, r0 will become -EFAULT
if (bpf_probe_fault()) // change it to if (r0) in verifier
   return;

Am I right?

Thanks!
Menglong Dong

>=20
> trace error event(Kumar)
> ------------------------------------
> Call a empty and traceable function in the exception handler.
>=20
> This maybe the simplest way, and I think the only shortcoming
> is that there may be some noise, as the the BPF program can
> receive the fault event from other BPF users.
>=20
> And maybe it's better to pass the bpf prog to the arguments of
> the empty function, therefore users can do some filter. Or, we
> can introduce a tracepoint for this propose.
>=20
> And I think this is the similar way that Leon suggested later.
>=20
> bpf errno(Leon)
> ----------------------
> introduce a percpu variable, save the -EFAULT to it in the
> exception handler. Introduce the __kfunc to read, set and
> clear the errno.
>=20
> output the error information directly to STDERR(Menglong)
> -------------------------------------------------------------------------=
=2D------------
> As it described.
>=20
> Ah......it seems we have many approaches here, and most
> of them work. Do we have any ideas on these ideas?
>=20
> Thanks!
> Menglong Dong
>=20
> >=20
> > It is then up to the user to decide the rate of messages for such
> > faults etc. and get more information if needed.
> >=20
>=20
>=20
>=20
>=20
>=20
>=20





