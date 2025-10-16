Return-Path: <linux-kernel+bounces-856565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7BBE47F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C38D75088D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605032D0C2;
	Thu, 16 Oct 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmtQs0Da"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0132D0F4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631209; cv=none; b=B+kqPQdwMXIPzK/xQR9Vvab2cXUPKjtvtL39WSFgeNVbkXQ923tzgdAovyM4SOW7frBa3DHsFnTQA0QyJPZCRPXJii7QKcTJEZeuQAVh0Lo3V5wactoaYxEUQZIVwGoeQ1nmTletQqHARlph0+EbEoRhaPAYZxBNT6ut+OFaJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631209; c=relaxed/simple;
	bh=etpEjPCarwB0G7EW+Gd9LV79QkHdy2ORB0akVlJRUbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MU9LYpXglKKM5TScxhQb0C/HquqVZZtpn96upxs8wqAPzhVz8/PB9PXZN+eQUL62BpQ4Vf6rtMpRGmQy1xYzzPld/aB3q7Dr8aty/LQ8Jj9j9zJRJmizmrAFqvEem6clPFdvc38XHX8eOcJdnJqUsyF1v52llE59Fhdr+4zGy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wmtQs0Da; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-427015f63faso545035f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760631206; x=1761236006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PS22gaCE+LVVSo+qeQsTA9zBPGvU33EBgFuFPr/0MQ=;
        b=wmtQs0DaxsToTZrVT23fBp4kR2rQ8EUWdelvu5cDU6UaU7wtyE/SVmiSDsTU8gVmLO
         IjWKmptJWZtRk8MkG/x76CeLPTHP9p0mPZ5rzshDxyR9OLIXa6WmYWsJsQPGgxcxUiS1
         qyuFb7UZGkRC9HBJpZmsbU955u0jAtuYdM7ZMwZoY0KiIL+evRoavjQO86VrZezATXUe
         VQ4WMLEv2maU6sjw8lkPT60HVb4A0xEYt543TYwrWHbt04aqt2N97rfveHDU9pMebIkj
         bT/lBnlf6kH89TEp2nTggvBMtTrV00/gtU+M+jnUXypYpgd06iSbdY8L8Cn+2O4IlQc1
         Cleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631206; x=1761236006;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8PS22gaCE+LVVSo+qeQsTA9zBPGvU33EBgFuFPr/0MQ=;
        b=UrPRaBJUv4rKXlrHsnIT+t+JyyWgcgjKBiJyYOCOAaGCjgSBkU0A6Ue8yp7xqg/NL1
         asVKxIFEaRIf5Y03OJr0cFLpE/w89Xz26rA/QLLdQ2wLirsBg/9JG2yXc3gUKKGt0qyp
         YKz0CXGoLBQhX+5sJD2KSkzmvKS+6qJVby+hp/8unPmhbCTdEATcAuLjgatGnLWZyjzk
         044sXFsuu58oFdNxJeJ01KhpxoH+DNx5SF8masjsaW/rsaI5hjMcse2l5X04+I7LU1Gt
         MdbZzc3IfxGEm9KjABPvf4Eh/rNf6et+DPnYqGQ6GyPRDjgLWLtnXm7zekB4GPHwIEOv
         c8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAos5y7c7jF8X1XQevYZXuH7tQar5NkO9LIrNwexMR44k1LDRAqnLXBU7Or0ZN8jgWlXmZM9pIZiSGJC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zAtY1gmGz/l8IfLITzRmHTfjZH7a7GcAmknH3R6V+f4eXwap
	nTG1JQC108BXb1RQs4W9VlVzX23jXzNsc/Y7k1TDtUgWZa+J2/WIyjjny5YQRwrmyZ1NOoJIzgp
	ylcU2Ds2ET9Rd/w==
X-Google-Smtp-Source: AGHT+IEKRt8n20prx+FzjDE5DHX4ZzloJm6kDtM7i8EySK5onQeEPHkbBBYYXa3qcrq3TJoU9DBXzuBRKxhXcA==
X-Received: from wrbed5.prod.google.com ([2002:a05:6000:20c5:b0:40b:371c:4eb8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d02:0:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42704d522c4mr490601f8f.14.1760631205686;
 Thu, 16 Oct 2025 09:13:25 -0700 (PDT)
Date: Thu, 16 Oct 2025 16:13:25 +0000
In-Reply-To: <DS0PR12MB92733379567E36D5F84E83FD94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013143444.3999-1-david.kaplan@amd.com> <20251013143444.3999-8-david.kaplan@amd.com>
 <DDJRFMTS5HX9.3MT8W88VM4U2I@google.com> <DS0PR12MB92739B4BF6D4F35250F1B44994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <DDJU1MUCPR2J.14W8SU21KQK4F@google.com> <DS0PR12MB92733379567E36D5F84E83FD94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDJVO9NSVDOZ.1JS1JRMXOKBB3@google.com>
Subject: Re: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigations
From: Brendan Jackman <jackmanb@google.com>
To: "Kaplan, David" <David.Kaplan@amd.com>, Brendan Jackman <jackmanb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu Oct 16, 2025 at 3:26 PM UTC, David Kaplan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Brendan Jackman <jackmanb@google.com>
>> Sent: Thursday, October 16, 2025 9:57 AM
>> To: Kaplan, David <David.Kaplan@amd.com>; Brendan Jackman
>> <jackmanb@google.com>; Thomas Gleixner <tglx@linutronix.de>; Borislav Pe=
tkov
>> <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
>> <jpoimboe@kernel.org>; Pawan Gupta <pawan.kumar.gupta@linux.intel.com>;
>> Ingo Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com=
>;
>> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>
>> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigatio=
ns
>>
>> Caution: This message originated from an External Source. Use proper cau=
tion
>> when opening attachments, clicking links, or responding.
>>
>>
>> On Thu Oct 16, 2025 at 2:06 PM UTC, David Kaplan wrote:
>> > [AMD Official Use Only - AMD Internal Distribution Only]
>> >
>> >> -----Original Message-----
>> >> From: Brendan Jackman <jackmanb@google.com>
>> >> Sent: Thursday, October 16, 2025 7:54 AM
>> >> To: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
>> >> <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter Zijlstra
>> >> <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Pawan
>> Gupta
>> >> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>;
>> Dave
>> >> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
>> >> <hpa@zytor.com>
>> >> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
>> >> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
>> >> Subject: Re: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitiga=
tions
>> >>
>> >> Caution: This message originated from an External Source. Use proper =
caution
>> >> when opening attachments, clicking links, or responding.
>> >>
>> >>
>> >> On Mon Oct 13, 2025 at 2:33 PM UTC, David Kaplan wrote:
>> >> > Add function to reset spectre_v2_user mitigations back to their boo=
t-time
>> >> > defaults.
>> >> >
>> >> > Signed-off-by: David Kaplan <david.kaplan@amd.com>
>> >> > ---
>> >> >  arch/x86/kernel/cpu/bugs.c | 13 +++++++++++++
>> >> >  1 file changed, 13 insertions(+)
>> >> >
>> >> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.=
c
>> >> > index 1f56ccb5f641..4ca46f58e384 100644
>> >> > --- a/arch/x86/kernel/cpu/bugs.c
>> >> > +++ b/arch/x86/kernel/cpu/bugs.c
>> >> > @@ -2056,6 +2056,18 @@ static void __init
>> >> spectre_v2_user_apply_mitigation(void)
>> >> >       }
>> >> >  }
>> >> >
>> >> > +#ifdef CONFIG_DYNAMIC_MITIGATIONS
>> >> > +static void spectre_v2_user_reset_mitigation(void)
>> >> > +{
>> >> > +     static_branch_disable(&switch_vcpu_ibpb);
>> >> > +     static_branch_disable(&switch_mm_always_ibpb);
>> >> > +     static_branch_disable(&switch_mm_cond_ibpb);
>> >> > +     spectre_v2_user_stibp =3D SPECTRE_V2_USER_NONE;
>> >> > +     spectre_v2_user_ibpb =3D SPECTRE_V2_USER_NONE;
>> >> > +     spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_AUTO;
>> >> > +}
>> >> > +#endif
>> >> > +
>> >> >  static const char * const spectre_v2_strings[] =3D {
>> >> >       [SPECTRE_V2_NONE]                       =3D "Vulnerable",
>> >> >       [SPECTRE_V2_RETPOLINE]                  =3D "Mitigation: Retp=
olines",
>> >> > @@ -3844,5 +3856,6 @@ void arch_cpu_reset_mitigations(void)
>> >> >       spectre_v1_reset_mitigation();
>> >> >       spectre_v2_reset_mitigation();
>> >> >       retbleed_reset_mitigation();
>> >> > +     spectre_v2_user_reset_mitigation();
>> >> >  }
>> >> >  #endif
>> >>
>> >> I think this might be failing to account for task state? E.g. if a
>> >> user boots with spectre_v2=3Doff then we ignore the PR_SPEC_DISABLE c=
alls
>> >> that would enable IBPB-on-context-switch for that task. Then if they
>> >> enable it via this dynamic interface they probably expect their
>> >> PR_SPEC_DISABLE to take effect retroactively. I don't think it will w=
ith
>> >> the current code, do I have that right?
>> >
>> > If I'm reading the logic correct, if a process tries to do PR_SPEC_DIS=
ABLE say
>> for indirects but spectre_v2_user=3Doff then they'll get -EPERM, so we d=
on't ignore it.
>> >
>> > But there could be a case where spectre_v2=3Don (aka force), when
>> PR_SPEC_DISABLE does get ignored.  And then if spectre_v2 is changed to
>> something else like prctl then the relevant task flags weren't set.
>>
>> Er yeah good point, my example was wrong but the issue exists to some
>> extent.
>>
>> > Not sure the best way to handle this...even if we were to always set t=
he task flags
>> in this case, there could be other cases where the process might think i=
t could set
>> this flag and then get surprised with an -EPERM.  Open to ideas here.
>>
>> Hm, isn't the issue of surprise-EPERM orthogonal to the task state
>> issue? I suspect I'm doing a bit of motivated reasoning here, but it
>> feels to me like a userspace bug for someone to infer statically whether
>> they should expect -EPERM here. Like, the docs don't say that much, but
>> they do say something about what the prctls do, and that doesn't include
>> anything about the _reason_ you got -EPERM.
>>
>> (BTW, it's not relevant here but I actually think -EPERM is a bug [0])
>>
>> [0] https://lore.kernel.org/all/DDJU0415JEBQ.H2SD942NMDWX@google.com/
>
> Well, if you do PR_GET_SPECULATION_CTRL, and it says PR_SPEC_PRCTL=3D1 th=
at means you can control it per-task.  But then if you later get an error m=
essage when you try to set it, that would seem weird.

Yeah I see, I didn't notice there was a case where we _explicitly_ say
it can be controlled (I was just thinking of -EPERM/-ENXIO). It does
seem weird to suddenly countermand that one.

> I don't know if anyone is actually using these controls today but I am ne=
rvous about causing confusion (even if the API is rather unclear).

I do know of some users of this API.

> One potential option here could be to always return PR_SPEC_ENABLE if dyn=
amic mitigations are enabled (telling userspace they cannot control the mit=
igation and they should assume the speculation is enabled).  Or maybe creat=
e new options that allow a process to say 'try to give me this speculation =
control' but without any promise that they'll actually get it.
>
> Assuming that dynamic mitigations get locked down late in boot as part of=
 kernel lockdown, there may only be a relatively small period of time where=
 there is a risk of things changing underneath a task so maybe telling user=
space they can't control these until things are locked is ok?

I don't think this should be designed under the assumption that everyone
is using lockdown. It's correct that lockdown disables this feature but
that doesn't mean lockdown is the right security decision for all users.
It would be a shame if it didn't actually support the use case of "oh
no, we found out our assumptions were wrong, we want to change our CPU
posture without rebooting everything". And I think if we just always
returned PR_SPEC_ENABLE that would essentially just mean you can't have
both dynamic control and efficient per-process control.

For PR_SPEC_ENABLE/DISABLE in the return value of
PR_GET_SPECULATION_CTRL, I think we should just return the current state
accurately. The fact that this can now change below userspace's feet
seems kinda above their pay-grade to me.

For PR_SPEC_PRCTl, I guess we could leave it clear and add a new bit to
say "I'm dynamic, you can try the PRCTL but I might randomly fail"? Then
code that doesn't know about the new bit doesn't get surprise errors, it
just has to do whatever fallbacks it would do on unsupported hardware.
Then new code can be updated to deal with random failures gracefully.

This seems a bit over-complicated though, in practice it seems pretty
likely that just hitting people with the unexpected errors is sort of
OK? At least for the usecase I'm seeing everything through the lens of,
I think it would be.=20

