Return-Path: <linux-kernel+bounces-739119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F4B0C211
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA177A3BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A3028A1F4;
	Mon, 21 Jul 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="VYAE1odU"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC55202995
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095727; cv=none; b=DLxU3mJg7Cz7n258ITDj4zypUVksnIi4k8fonb6moMLJ0pNDVHnDMEjqaVCWR8i6AMLVVt/mM2gFdjlLmluMZSL8lI2+K8PWIIcuEs/32+PZ0c9EqEpkLHuAV9CsZWM9pP+g4fQab56dMMghG3/5pxJR5/93S7ZfQ7gYKTTI130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095727; c=relaxed/simple;
	bh=ip//SBix+cwyHizBedtjff93RkLwYvUx8b4zVf9t/zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu5pedal+VrrlOcpkxlSfDmG0BEOa/8fbFJSNHEsQJoe7oEzRPl+0wCB/joLaz2gdF4oF2X6flSrirXSN8blm3EMcsz2TKEZp7lFDzf2MmAzqaHZ71NkTaYr9XToiTurJN8jHiZOSFdalERV40X8ufdpIk86KNDxEy6ubnOZI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=android.com; spf=pass smtp.mailfrom=android.com; dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b=VYAE1odU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=android.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=android.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e372c8a9a4so62228185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20230601; t=1753095724; x=1753700524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5NScKoqqRDYpF25UOe7u8EPklWKzZRwjyOT1Jxt9gI=;
        b=VYAE1odU2braCEGVURZYefQgmRvfELD1qtj22mORhxwRttXpNmAvN9IzyxtMmPlQU7
         Rfw1/vJpj6XT293znmOfNVdfaRsyrFLxXTXLSEBzk6nNCiUxqMhqH9AMg/Oyg7w/GkyX
         o5cgqtsSaa4ObzmYvVwA9Fodj+rYp//Gk4R0xy+tnuMwliYyxbDZAL4knJUTFeC/9QW2
         oecZopAN0QqmsgDbxQxQSyQ6KfhFrEgKCIZbjaBhb4oAxPMw8HMABQ+RYBGhEZGe64gJ
         e/eL9UKnT8Q2ZARlGVsvXR26m6/K1n5mbEbd2/8KIlYcI82ldTWw40XCdpSG+qwZqtHa
         M8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095724; x=1753700524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5NScKoqqRDYpF25UOe7u8EPklWKzZRwjyOT1Jxt9gI=;
        b=SU1OlS1yrZYn87SfU8lRJ0cv5MxnDYitVn6+aXMd7iUWQKNZe5We2F4de74u13hgsn
         kOy5OdeznJYSDJfruJCH4ufqzBgqFYmI/Tp7TzpATEab1b7g89JoGa/RJ1yhON951pPz
         nW1Fn91UESO7m2uv83MH8AZhMxu1OngPJicqt1qD66lMtwQ6izIBWZ3/UgOitNdwzS/w
         5J3FFP9nwLNrlcHC4Kq+zowhMCxblzo4ZEjLBlOpWi84FvWej1YSIhnWNuWeA3KVhCwV
         l/sVcTZVBKe8jaBMuB6ZR7sfALvG4dlBRhVb5c6HEStere5dAhpnn16UQH9MtAOmlsD3
         Mjew==
X-Forwarded-Encrypted: i=1; AJvYcCXMexzwVcGj5RYiqRCjwJEpeF5eIr9Vcc2uGzq+sjBDsZodGrqoWgLlmF/1IYfn9tcQOOt4tovEmIy7bm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1S0oqpqEgS5r+8a2Dspq97iO/2l/w9TU7TNZBDk0AZ6JVVaR1
	FElLMqmtZWojzY9rIUt01kHgQ5pqDS2xGetLAl6Q+u8QP1j7dvJUxFwGDj+LT8M8AmfSWEnH+xW
	7kbnythJ2KiGXEgFtdVhgKctJkMXvZHs2AiJzUT3F
X-Gm-Gg: ASbGncscLw8kPFLkzlKIvK4yQwVh12mdplbgkODi/yTiZgEQscIRMU1PZshBzPcBq63
	3J49VJm6kNxb+owmHe3zyh6Y9jnNLEuYWxEAn8QV8TyJBNmU5nsBljgStF6FTrmOphTG3Ug1I8d
	gmfEa89Q+074FfyMEohaSpnXfYKKN57+XlQrCowSHUkF9+EvHFM5L5Ld2hZA2RkGwvYf7Zl5W9q
	v4UUqWkJFQSU48kfwgSesdUmT36hA8Cobx4GPf1JA==
X-Google-Smtp-Source: AGHT+IFi54tA/j4ZfIPctLHHg6b5vyU1fnTS/ZP8EdichbysBiV/QOT7PSO6lGugTEs2q8yVhdWoz8PI8zW1nkRBPYM=
X-Received: by 2002:a05:6214:310f:b0:700:c7e4:cac6 with SMTP id
 6a1803df08f44-705071c240cmr195760366d6.8.1753095723949; Mon, 21 Jul 2025
 04:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-virtio-msg-ffa-v7-0-995afc3d385e@google.com>
 <20250701-virtio-msg-ffa-v7-2-995afc3d385e@google.com> <8634bdbgaz.wl-maz@kernel.org>
 <3b10fa81-bfdd-4325-a330-c79df2e21621@immunant.com> <aHpOClH1k-3NhI_y@willie-the-truck>
 <67cc6766-6493-4171-a6b1-2a105c3e6ff5@immunant.com>
In-Reply-To: <67cc6766-6493-4171-a6b1-2a105c3e6ff5@immunant.com>
From: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Date: Mon, 21 Jul 2025 04:01:52 -0700
X-Gm-Features: Ac12FXxyyw32mDla--L9makX6oeYtEuUpV1sDlGA2J2wilR4nXDa-mqd-j0HZ08
Message-ID: <CAMP5XgeUwDnf=PbySy6aoF_zc7dtxymDQZEp8DuRSOLg4WEnFQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] KVM: arm64: Use SMCCC 1.2 for FF-A initialization
 and in host handler
To: Per Larsen <perl@immunant.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, perlarsen@google.com, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, ahomescu@google.com, armellel@google.com, 
	ayrton@google.com, qperret@google.com, sebastianene@google.com, 
	qwandor@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:54=E2=80=AFPM Per Larsen <perl@immunant.com> wro=
te:
>
> On 7/18/25 6:37 AM, Will Deacon wrote:
> > On Mon, Jul 07, 2025 at 05:06:23PM -0700, Per Larsen wrote:
> >> On 7/3/25 5:38 AM, Marc Zyngier wrote:
> >>> On Tue, 01 Jul 2025 23:06:35 +0100,
> >>> Per Larsen via B4 Relay <devnull+perlarsen.google.com@kernel.org> wro=
te:
> >>>> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe=
/ffa.c
> >>>> index 2c199d40811efb5bfae199c4a67d8ae3d9307357..65d241ba32403d014b43=
cc4ef4d5bf9693813809 100644
> >>>> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> >>>> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> >>>> @@ -71,36 +71,68 @@ static u32 hyp_ffa_version;
> >>>>    static bool has_version_negotiated;
> >>>>    static hyp_spinlock_t version_lock;
> >>>> -static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_e=
rrno)
> >>>> +static void ffa_to_smccc_error(struct arm_smccc_1_2_regs *res, u64 =
ffa_errno)
> >>>>    {
> >>>> -  *res =3D (struct arm_smccc_res) {
> >>>> +  *res =3D (struct arm_smccc_1_2_regs) {
> >>>>                    .a0     =3D FFA_ERROR,
> >>>>                    .a2     =3D ffa_errno,
> >>>>            };
> >>>>    }
> >>>> -static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int re=
t, u64 prop)
> >>>> +static void ffa_to_smccc_res_prop(struct arm_smccc_1_2_regs *res, i=
nt ret, u64 prop)
> >>>>    {
> >>>>            if (ret =3D=3D FFA_RET_SUCCESS) {
> >>>> -          *res =3D (struct arm_smccc_res) { .a0 =3D FFA_SUCCESS,
> >>>> -                                          .a2 =3D prop };
> >>>> +          *res =3D (struct arm_smccc_1_2_regs) { .a0 =3D FFA_SUCCES=
S,
> >>>> +                                                .a2 =3D prop };
> >>>>            } else {
> >>>>                    ffa_to_smccc_error(res, ret);
> >>>>            }
> >>>>    }
> >>>> -static void ffa_to_smccc_res(struct arm_smccc_res *res, int ret)
> >>>> +static void ffa_to_smccc_res(struct arm_smccc_1_2_regs *res, int re=
t)
> >>>>    {
> >>>>            ffa_to_smccc_res_prop(res, ret, 0);
> >>>>    }
> >>>>    static void ffa_set_retval(struct kvm_cpu_context *ctxt,
> >>>> -                     struct arm_smccc_res *res)
> >>>> +                     struct arm_smccc_1_2_regs *res)
> >>>>    {
> >>>> +  DECLARE_REG(u64, func_id, ctxt, 0);
> >>>>            cpu_reg(ctxt, 0) =3D res->a0;
> >>>>            cpu_reg(ctxt, 1) =3D res->a1;
> >>>>            cpu_reg(ctxt, 2) =3D res->a2;
> >>>>            cpu_reg(ctxt, 3) =3D res->a3;
> >>>> +  cpu_reg(ctxt, 4) =3D res->a4;
> >>>> +  cpu_reg(ctxt, 5) =3D res->a5;
> >>>> +  cpu_reg(ctxt, 6) =3D res->a6;
> >>>> +  cpu_reg(ctxt, 7) =3D res->a7;
> >>>
> >>>   From DEN0028G 2.6:
> >>>
> >>> <quote>
> >>> Registers W4-W7 must be preserved unless they contain results, as
> >>> specified in the function definition.
> >>> </quote>
> >>>
> >>> On what grounds can you blindly change these registers?
> >>  From DEN0077A 1.2 Section 11.2: Reserved parameter convention
> >>
> >> <quote>
> >> Unused parameter registers in FF-A ABIs are reserved for future use by=
 the
> >> Framework.
> >>
> >> [...]
> >>
> >> The caller is expected to write zeroes to these registers. The callee
> >> ignores the values in these registers.
> >> </quote>
> >>
> >> My read is that, as long as we are writing zeroes into reserved regist=
ers
> >> (which I believe we are), we comply with DEN0026G 2.6.>
> >
> > Right, the specs make this far more difficult to decipher than necessar=
y
> > but I think SMCCC defers to the definition of the specific call being
> > made and then FF-A is basically saying that unused argument registers
> > are always zeroed.
> >
> > Rather than have the EL2 proxy treat each call differently based on the
> > used argument registers, we can rely on EL3 doing the right thing and
> > blindly copy everything back, which is what you've done. So I think
> > that's ok.
> >
> >>>> +
> >>>> +  /*
> >>>> +   * DEN0028C 2.6: SMC32/HVC32 call from aarch64 must preserve x8-x=
30.
> >>>> +   *
> >>>> +   * The most straightforward approach is to look at the function I=
D
> >>>> +   * sent by the caller. However, the caller could send FFA_MSG_WAI=
T
> >>>> +   * which is a 32-bit interface but the reply could very well be 6=
4-bit
> >>>> +   * such as FFA_FN64_MSG_SEND_DIRECT_REQ or FFA_MSG_SEND_DIRECT_RE=
Q2.
> >>>> +   *
> >>>> +   * Instead, we could look at the function ID in the response (a0)=
 but
> >>>> +   * that doesn't work either as FFA_VERSION responses put the vers=
ion
> >>>> +   * number (or error code) in w0.
> >>>> +   *
> >>>> +   * Set x8-x17 iff response contains 64-bit function ID in a0.
> >>>> +   */
> >>>> +  if (func_id !=3D FFA_VERSION && ARM_SMCCC_IS_64(res->a0)) {
> >>>> +          cpu_reg(ctxt, 8) =3D res->a8;
> >>>> +          cpu_reg(ctxt, 9) =3D res->a9;
> >>>> +          cpu_reg(ctxt, 10) =3D res->a10;
> >>>> +          cpu_reg(ctxt, 11) =3D res->a11;
> >>>> +          cpu_reg(ctxt, 12) =3D res->a12;
> >>>> +          cpu_reg(ctxt, 13) =3D res->a13;
> >>>> +          cpu_reg(ctxt, 14) =3D res->a14;
> >>>> +          cpu_reg(ctxt, 15) =3D res->a15;
> >>>> +          cpu_reg(ctxt, 16) =3D res->a16;
> >>>> +          cpu_reg(ctxt, 17) =3D res->a17;
> >>>> +  }
> >>>>    }
> >>>
> >>> I don't see how that can ever work.
> >>>
> >>> Irrespective of how FFA_MSG_WAIT actually works (and I couldn't find
> >>> anything in the spec that supports the above), the requester will
> >>> fully expect its registers to be preserved based on the initial
> >>> function type, and that alone. No ifs, no buts.
> >>>
> >>> If what you describe can happen (please provide a convincing example)=
,
> >>> then the spec is doomed.
> >>
> >> DEN0077A 1.2 Section 8.2 (Runtime Model for FFA_RUN) and 8.3 (Runtime =
Model
> >> for Direct request ABIs) contains Figures 8.1 and 8.2. Each figure sho=
ws
> >> transitions between states "waiting", "blocked", "running", and "preem=
pted".
> >> Key to my understanding is that the waiting state in Figure 8.1 and Fi=
gure
> >> 8.2 is the exact same state. This appears to be the case per Section 4=
.10.
> >>
> >> So we have to consider the ways to get in and out of the waiting state=
 by
> >> joining the state machines in Figures 8.1 and 8.2. Figure 8.1 has an e=
dge
> >> between "running" and "waiting" caused by FFA_MSG_WAIT. Figure 8.2 has=
 an
> >> edge between "waiting" and "running" caused by a "Direct request ABI".
> >>
> >> Direct request ABIs include FFA_MSG_SEND_DIRECT_REQ2 which is why the =
FF-A
> >> 1.2 spec, in my read, permits the response to a 32-bit FFA_MSG_WAIT ca=
ll can
> >> be a 64-bit FFA_MSG_SEND_DIRECT_REQ2 reply.
> >
> > That seems bonkers to me and I agree with Marc's assessment above. The
> > SMCCC is crystal clear that a caller using the SM32/HVC32 calling
> > convention can rely on x8-x30 (as well as the stack pointers) being
> > preserved. If FF-A has a problem with that then it needs to be fixed
> > there and not bodged in Linux.
> Ack. Patchset v8 addresses Marc's feedback by using the func_id detect
> SMC64 instead.>
> > Setting that aside, I'm still not sure I follow this part of your check=
:
> >
> >       if (... && ARM_SMCCC_IS_64(res->a0))
> >
> > won't res->a0 contain something like FFA_SUCCESS? The FFA spec states:
> >
> >    FFA_SUCCESS64, is used only if any result register encodes a 64-bit
> >    parameter.
> >
> > which doesn't really seem related to whether or not the initial call
> > was using SMC32 or SMC64. What am I missing?I agree that we cannot use =
res->a0 to distinguish SMC32/SMC64 for the
> reason you stated.

I don't think using the function-id of the original call works
correctly in this context though. If you look at
drivers/firmware/arm_ffa/driver.c:ffa_msg_send_direct_req2 it has the
same problem as the FFA_MSG_WAIT example in your comment. In the
simple case it will use FFA_MSG_SEND_DIRECT_REQ2 for the call and
FFA_MSG_SEND_DIRECT_RESP2 for the response, both 64 bit opcodes, and
either approach here will have the same correct result. However if
FFA_MSG_SEND_DIRECT_REQ2 responds with FFA_INTERRUPT or FFA_YIELD,
then the driver will resume the call with FFA_RUN, a 32 bit opcode,
and still expect a 64 bit FFA_MSG_SEND_DIRECT_RESP2 response with a
full response in x4-17. If you use ARM_SMCCC_IS_64(func_id) here
instead of ARM_SMCCC_IS_64(res->a0), then the part of response in
x8-x17 will be lost.

The FF-A 1.3 ALP2 fixes this by adding a 64 bit FF-A run opcode, but
at the current patchstack only adds ff-a 1.2 support and the linux
ff-a driver does not yet support the new 1.3 ALP2 call flow either so
I think the current v7 patch here is the best option for now.

--=20
Arve Hj=C3=B8nnev=C3=A5g

