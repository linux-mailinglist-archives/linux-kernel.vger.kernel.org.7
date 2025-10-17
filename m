Return-Path: <linux-kernel+bounces-858757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E028BEBC74
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 822A534C19C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25D72773D8;
	Fri, 17 Oct 2025 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBuhbD43"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88E354ADC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734977; cv=none; b=in7KRc/ESADGCs8W0C5bx+1o9SpgomFq2XpEWExLCnTj5r9gpTc4qv67orFkzcCV9vIiMnIDWlQ8rG4bhdKqBU+NWuMDQRUM7KOy+zfwtEORG/zcMS+oVUuMmWaCkFs2PjG+nkOQkVju81y9Dmuf2a3uhlnmE6n2c5X2zs+TE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734977; c=relaxed/simple;
	bh=8kUhLPLWHwKIYld09eHUwbls02G4UPhh+4MC7kWbgnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlRAe+pksJ9lPoWmSpiy9kp+5OGTAAGhrHlX8aG5oyEDgOR7vHZh7y2l2a+u7cu/TVp8nvX+djfEuxKXggpe9VrkkZa8sIqGDJFsVBqhXeRrk4wpHPvc4427Wy+b+z0yfP7AYugqEtP1HffsYPua4k8lxiPFBfTxQv/AbJmwbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBuhbD43; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63d97bcb898so3197990d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760734971; x=1761339771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pgtOz35i3U+zMCagJLxYJjRbr0bM2R+d1mcOlDwXhAU=;
        b=UBuhbD43WAtekABhL/I7S9Hcn8P3bj3Q2Cw1ioSAjyUj/556h1t7i20LiSgatqaDkx
         sfNfNogwKGtsBO9ETya61FHuYTZ7EtTK2m3XysPxXZ8yGlzo0CYz5TPjO0C7Yu4zoDR3
         mT91+0XvW+WYb6KY2QGkCrta0hmFLeRXBlfFBIw3Lnql1iKV192tKy8D+JgsW0l5ooUz
         0/SMTWd9OKVtz1kILl25Yd7uDxXaCzmgo6JszRM5HZZXcG8hkqOhoiLfN4qbDkDrjBLh
         JKal92yRf4Eu67Q7DgukKUAtiMYmMbO1WdCkdqI4ltvTZ7vEL8tgQVdWyUthu8eWLjN0
         yaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734971; x=1761339771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgtOz35i3U+zMCagJLxYJjRbr0bM2R+d1mcOlDwXhAU=;
        b=ch4EiruATU5V1QAflQMyCuz04ZUwEGq21oAlZXQtC2SoPNxwHaShYM10jZ3q7yMwzY
         kyZ9/q9e0Re2VD8IgNGZ0ZrSJowXc0Zab5ay3iBrGrBvWFhprvNQK4gightDDrpSS6KF
         PfBAG3dv9n3a/709eitj1GS8+/zXI2rtPv+ayFIaC1jyaN61IvXCImiEWNw+2k7Nx8V2
         nvjUouUeQA8t0fciMYO3HCFrKd2X+wJsYqgKyozcsnDyjabGegZjCJ0F6t7ve3U7Dz8r
         wLXlzheaCcm7P0qqpzafbGr4tFYLIYrdPlwIPVhcpSMWgh6f1udRwKOML0VMagN2X/lx
         GP+w==
X-Forwarded-Encrypted: i=1; AJvYcCWN1lTOU7iaI95f8IFY3Z9Y5ADRZNUzUwU+DYdhT5xfoQ7zJk6kQcft6uuh9kIWf4iCZpbMtFLCJSpzq+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAX5VaIR8dW8DCSg5NA0FpcujvBGombHoY10U3ejl/czqF0+5
	B2wG8npS5UZSEmyyOvcyNtvCR8tkn2sT9TdbiP76xnSg3Q7QqKwA5+NYKOn5r+rdyjrS5rH6qcv
	KShYqrmpga7AdY1DHmbHB7R5caBR9C0TguYccdr4=
X-Gm-Gg: ASbGncusoW36fHh1Bz7F58vM1kbxuh4oMwrlaoCo38EaEJwLqbm1iBBKosXQMeCyHmN
	4nTNWtFRMueoccgRSnRJh/DdHu1Mf7m4KXEqhly1GTtsAHR3RlkBbOHpKtfHp2F6SDRv6IG1wJ3
	vKf7ZH9Une2lTPrELVsYoaOoON0+7fzi/PmXJkZLtIMO+wEkOK5zw3v9Ki66cJW0o4+zd0dRmg3
	nAyutYSCO8+DNyhXjcnJEPfh1Ckopvj6E6PdtGDKbOPdZo5RhiUYlIakWbA4DkGoz4P/Zl67Lt8
	J9osk6scCuhFerI0
X-Google-Smtp-Source: AGHT+IEkrn9n1/4LBpI8Ee1T/0b+Co8Y21MZmsqSliWz7O38r7BFAvWowtj/3Qjz+0yTpgtW68D0euwB0gHS821doZ0=
X-Received: by 2002:a05:690e:1446:b0:63e:1806:f997 with SMTP id
 956f58d0204a3-63e1806fd46mr3373520d50.4.1760734970575; Fri, 17 Oct 2025
 14:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPJNPPFKsPKJWlLn@eldamar.lan> <a7fa4a93-2d80-4c1d-af91-9dad9626ed9f@intel.com>
In-Reply-To: <a7fa4a93-2d80-4c1d-af91-9dad9626ed9f@intel.com>
From: =?UTF-8?B?TGF1cmVuyJtpdSBQxINuY2VzY3U=?= <lpancescu@gmail.com>
Date: Fri, 17 Oct 2025 23:02:38 +0200
X-Gm-Features: AS18NWDtZ5zdDwEGZsSMoM4mQXg9_GqcXMOLU5wqhv5vTaKNG_EavMOBFIPr3P4
Message-ID: <CAE9TcM+AeG8F0PubxAcmSWd=unBiLwZK1xAvCGjXk0Y-+YBaJg@mail.gmail.com>
Subject: Re: WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:123
 do_clear_cpu_cap+0xdc/0x130 on Intel(R) Atom(TM) CPU N450 system
To: Dave Hansen <dave.hansen@intel.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	"Chang S. Bae" <chang.seok.bae@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org, 1117002@bugs.debian.org
Content-Type: multipart/mixed; boundary="0000000000007744030641610eef"

--0000000000007744030641610eef
Content-Type: multipart/alternative; boundary="0000000000007744010641610eed"

--0000000000007744010641610eed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

many thanks for the quick replies!

The netbook is from 2009 and has the latest BIOS update offered by Asus,
version 1202 from 2010. I used the BIOS defaults (it doesn't even have
fail-safe and optimized defaults, just "defaults"), and there are basically
no settings you can change: enable/disable onboard audio, LAN and LAN boot,
set the HDD in IDE or AHCI mode, and a sole CPU option "Max CPUID Limit"
("disabled for WIndows XP", but it makes no difference for the warning if I
enable or disable it).

I have been running Debian Stable on the netbook ever since I bought it,
and it worked without any errors or warnings in all versions before Debian
13 with kernel 6.12.43 (I get the same in Debian Testing with kernel
6.16.9). I attached the dmesg output produced by Debian 12 Bookworm, kernel
6.1.0, which works without warnings, and cpuinfo. There's a single CPU, an
Intel Atom N450, seen as two CPUs due to hyperthreading - but I can't
disable hyperthreading in BIOS, either.

"rdmsr -a 0x000001a0" produces the following output:
364972489
364972488

Kind regards,
Laurentiu



On Fri, Oct 17, 2025 at 4:26=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:

> On 10/17/25 07:05, Salvatore Bonaccorso wrote:
> > [    0.008282] RAX: 0000000000000000 RBX: ffffcd5fc00bfd18 RCX:
> 0000000000000000
> > [    0.008282] RDX: 0000000000000001 RSI: 0000000000000070 RDI:
> ffffcd5fc00bfd78
> > [    0.008282] RBP: 0000000000000070 R08: 0000000000000000 R09:
> 706f20676e697274
> > [    0.008282] R10: 7473207473616620 R11: 64656c6261736944 R12:
> ffffffffb8f20ba0
> > [    0.008282] R13: ffff8ad332718090 R14: 000000000000061c R15:
> 0000000000000000
> > [    0.008282] FS:  0000000000000000(0000) GS:ffff8ad378ec7000(0000)
> knlGS:0000000000000000
> > [    0.008282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.008282] CR2: 0000000000000000 CR3: 000000005842c000 CR4:
> 00000000000006f0
> > [    0.008282] Call Trace:
> > [    0.008282]  <TASK>
> > [    0.008282]  do_clear_cpu_cap+0x106/0x130
> > [    0.008282]  early_init_intel.cold+0x4d/0x11a
> > [    0.008282]  init_intel+0x2a/0x2c0
> > [    0.008282]  identify_cpu+0x18c/0x750
> > [    0.008282]  identify_secondary_cpu+0x50/0xa0
> > [    0.008282]  start_secondary+0x7c/0x160
> > [    0.008282]  common_startup_64+0x13e/0x141
> > [    0.008282]  </TASK>
> > [    0.008282] ---[ end trace 0000000000000000 ]---
> > [    0.354753] smp: Brought up 1 node, 2 CPUs
> > [    0.354797] smpboot: Total of 2 processors activated (6666.06
> BogoMIPS)
> >
> > Any ideas?
>
> That's a fun one.
>
> This looks to be this code:
>
>                         pr_info("Disabled fast string operations\n");
>                         setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
>
> because we can see the pr_info() and I'm assuming that the 'feature' is
> X86_FEATURE_REP_GOOD (0x70) which we can see in RSI/RBP.
>
> But X86_FEATURE_REP_GOOD isn't even a real CPU feature, it's one of the
> synthetic ones. The only way I can see this happening is if
> MSR_IA32_MISC_ENABLE_FAST_STRING is mismatched between the boot CPU and
> a secondary.
>
> Could you boot the system on a known good kernel and run this, please?
>
>         rdmsr -a 0x000001a0
>
> That'll dump out MSR_IA32_MISC_ENABLE on all the CPUs.
>
> When was the last kernel that worked for you? Also, do you have old
> microcode? Can you dump the beginning of /proc/cpuinfo, please?
>
> processor       : 21
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 170
> model name      : Intel(R) Core(TM) Ultra 7 155H
> stepping        : 4
> microcode       : 0x24
>
> I can see your microcode version in dmesg, but not the cpu
> model/family/stepping.
>
>
>

--0000000000007744010641610eed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello everyone,</div><div><br></div><div>many thanks =
for the quick replies!</div><div><br></div><div>The netbook is from 2009 an=
d has the latest BIOS update offered by Asus, version 1202 from 2010. I use=
d the BIOS defaults (it doesn&#39;t even have fail-safe and optimized defau=
lts, just &quot;defaults&quot;), and there are basically no settings you ca=
n change: enable/disable onboard audio, LAN and LAN boot, set the HDD in ID=
E or AHCI mode, and a sole CPU option &quot;Max CPUID Limit&quot; (&quot;di=
sabled for WIndows XP&quot;, but it makes no difference for the warning if =
I enable or disable it).</div><div><br></div><div>I have been running Debia=
n Stable on the netbook ever since I bought it, and it worked without any e=
rrors or warnings in all versions before Debian 13 with kernel 6.12.43 (I g=
et the same in Debian Testing with kernel 6.16.9). I attached the dmesg out=
put produced by Debian 12 Bookworm, kernel 6.1.0, which works without warni=
ngs, and cpuinfo. There&#39;s a single CPU, an Intel Atom N450, seen as two=
 CPUs due to hyperthreading - but I can&#39;t disable hyperthreading=C2=A0i=
n BIOS, either.</div><div><br></div><div>&quot;rdmsr -a 0x000001a0&quot; pr=
oduces the following output:</div><div>364972489<br>364972488</div><div><br=
></div><div>Kind regards,</div><div>Laurentiu</div><div><br></div><div><br>=
</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Oct 17, 2025 at 4:26=E2=80=AFPM Dave =
Hansen &lt;<a href=3D"mailto:dave.hansen@intel.com">dave.hansen@intel.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 10/17/25 07:05, Salvatore Bonaccorso wrote:<br>
&gt; [=C2=A0 =C2=A0 0.008282] RAX: 0000000000000000 RBX: ffffcd5fc00bfd18 R=
CX: 0000000000000000<br>
&gt; [=C2=A0 =C2=A0 0.008282] RDX: 0000000000000001 RSI: 0000000000000070 R=
DI: ffffcd5fc00bfd78<br>
&gt; [=C2=A0 =C2=A0 0.008282] RBP: 0000000000000070 R08: 0000000000000000 R=
09: 706f20676e697274<br>
&gt; [=C2=A0 =C2=A0 0.008282] R10: 7473207473616620 R11: 64656c6261736944 R=
12: ffffffffb8f20ba0<br>
&gt; [=C2=A0 =C2=A0 0.008282] R13: ffff8ad332718090 R14: 000000000000061c R=
15: 0000000000000000<br>
&gt; [=C2=A0 =C2=A0 0.008282] FS:=C2=A0 0000000000000000(0000) GS:ffff8ad37=
8ec7000(0000) knlGS:0000000000000000<br>
&gt; [=C2=A0 =C2=A0 0.008282] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033<br>
&gt; [=C2=A0 =C2=A0 0.008282] CR2: 0000000000000000 CR3: 000000005842c000 C=
R4: 00000000000006f0<br>
&gt; [=C2=A0 =C2=A0 0.008282] Call Trace:<br>
&gt; [=C2=A0 =C2=A0 0.008282]=C2=A0 &lt;TASK&gt;<br>
&gt; [=C2=A0 =C2=A0 0.008282]=C2=A0 do_clear_cpu_cap+0x106/0x130<br>
&gt; [=C2=A0 =C2=A0 0.008282]=C2=A0 early_init_intel.cold+0x4d/0x11a<br>
&gt; [=C2=A0 =C2=A0 0.008282]=C2=A0 init_intel+0x2a/0x2c0<br>
&gt; [=C2=A0 =C2=A0 0.008282]=C2=A0 identify_cpu+0x18c/0x750<br>
&gt; [=C2=A0 =C2=A0 0.008282]=C2=A0 identify_secondary_cpu+0x50/0xa0<br>
&gt; [=C2=A0 =C2=A0 0.008282]=C2=A0 start_secondary+0x7c/0x160<br>
&gt; [=C2=A0 =C2=A0 0.008282]=C2=A0 common_startup_64+0x13e/0x141<br>
&gt; [=C2=A0 =C2=A0 0.008282]=C2=A0 &lt;/TASK&gt;<br>
&gt; [=C2=A0 =C2=A0 0.008282] ---[ end trace 0000000000000000 ]---<br>
&gt; [=C2=A0 =C2=A0 0.354753] smp: Brought up 1 node, 2 CPUs<br>
&gt; [=C2=A0 =C2=A0 0.354797] smpboot: Total of 2 processors activated (666=
6.06 BogoMIPS)<br>
&gt; <br>
&gt; Any ideas?<br>
<br>
That&#39;s a fun one.<br>
<br>
This looks to be this code:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pr_info(&quot;Disabled fast string operations\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);<br>
<br>
because we can see the pr_info() and I&#39;m assuming that the &#39;feature=
&#39; is<br>
X86_FEATURE_REP_GOOD (0x70) which we can see in RSI/RBP.<br>
<br>
But X86_FEATURE_REP_GOOD isn&#39;t even a real CPU feature, it&#39;s one of=
 the<br>
synthetic ones. The only way I can see this happening is if<br>
MSR_IA32_MISC_ENABLE_FAST_STRING is mismatched between the boot CPU and<br>
a secondary.<br>
<br>
Could you boot the system on a known good kernel and run this, please?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rdmsr -a 0x000001a0<br>
<br>
That&#39;ll dump out MSR_IA32_MISC_ENABLE on all the CPUs.<br>
<br>
When was the last kernel that worked for you? Also, do you have old<br>
microcode? Can you dump the beginning of /proc/cpuinfo, please?<br>
<br>
processor=C2=A0 =C2=A0 =C2=A0 =C2=A0: 21<br>
vendor_id=C2=A0 =C2=A0 =C2=A0 =C2=A0: GenuineIntel<br>
cpu family=C2=A0 =C2=A0 =C2=A0 : 6<br>
model=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 170<br>
model name=C2=A0 =C2=A0 =C2=A0 : Intel(R) Core(TM) Ultra 7 155H<br>
stepping=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 4<br>
microcode=C2=A0 =C2=A0 =C2=A0 =C2=A0: 0x24<br>
<br>
I can see your microcode version in dmesg, but not the cpu<br>
model/family/stepping.<br>
<br>
<br>
</blockquote></div>

--0000000000007744010641610eed--
--0000000000007744030641610eef
Content-Type: text/plain; charset="US-ASCII"; name="cpuinfo.txt"
Content-Disposition: attachment; filename="cpuinfo.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mgvbyoxb0>
X-Attachment-Id: f_mgvbyoxb0

cHJvY2Vzc29yCTogMAp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6IDYKbW9k
ZWwJCTogMjgKbW9kZWwgbmFtZQk6IEludGVsKFIpIEF0b20oVE0pIENQVSBONDUwICAgQCAxLjY2
R0h6CnN0ZXBwaW5nCTogMTAKbWljcm9jb2RlCTogMHgxMDcKY3B1IE1IegkJOiA5OTkuOTMyCmNh
Y2hlIHNpemUJOiA1MTIgS0IKcGh5c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTogMgpjb3JlIGlkCQk6
IDAKY3B1IGNvcmVzCTogMQphcGljaWQJCTogMAppbml0aWFsIGFwaWNpZAk6IDAKZnB1CQk6IHll
cwpmcHVfZXhjZXB0aW9uCTogeWVzCmNwdWlkIGxldmVsCTogMTAKd3AJCTogeWVzCmZsYWdzCQk6
IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBwZ2UgbWNh
IGNtb3YgcGF0IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJl
IHN5c2NhbGwgbnggbG0gY29uc3RhbnRfdHNjIGFyY2hfcGVyZm1vbiBwZWJzIGJ0cyByZXBfZ29v
ZCBub3BsIGNwdWlkIGFwZXJmbXBlcmYgcG5pIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCBlc3QgdG0y
IHNzc2UzIGN4MTYgeHRwciBwZGNtIG1vdmJlIGxhaGZfbG0gZHRoZXJtCmJ1Z3MJCToKYm9nb21p
cHMJOiAzMzMyLjk0CmNsZmx1c2ggc2l6ZQk6IDY0CmNhY2hlX2FsaWdubWVudAk6IDY0CmFkZHJl
c3Mgc2l6ZXMJOiAzMiBiaXRzIHBoeXNpY2FsLCA0OCBiaXRzIHZpcnR1YWwKcG93ZXIgbWFuYWdl
bWVudDoKCnByb2Nlc3Nvcgk6IDEKdmVuZG9yX2lkCTogR2VudWluZUludGVsCmNwdSBmYW1pbHkJ
OiA2Cm1vZGVsCQk6IDI4Cm1vZGVsIG5hbWUJOiBJbnRlbChSKSBBdG9tKFRNKSBDUFUgTjQ1MCAg
IEAgMS42NkdIegpzdGVwcGluZwk6IDEwCm1pY3JvY29kZQk6IDB4MTA3CmNwdSBNSHoJCTogOTk5
Ljg1NQpjYWNoZSBzaXplCTogNTEyIEtCCnBoeXNpY2FsIGlkCTogMApzaWJsaW5ncwk6IDIKY29y
ZSBpZAkJOiAwCmNwdSBjb3Jlcwk6IDEKYXBpY2lkCQk6IDEKaW5pdGlhbCBhcGljaWQJOiAxCmZw
dQkJOiB5ZXMKZnB1X2V4Y2VwdGlvbgk6IHllcwpjcHVpZCBsZXZlbAk6IDEwCndwCQk6IHllcwpm
bGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIg
cGdlIG1jYSBjbW92IHBhdCBjbGZsdXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2UyIHNzIGh0
IHRtIHBiZSBzeXNjYWxsIG54IGxtIGNvbnN0YW50X3RzYyBhcmNoX3BlcmZtb24gcGVicyBidHMg
bm9wbCBjcHVpZCBhcGVyZm1wZXJmIHBuaSBkdGVzNjQgbW9uaXRvciBkc19jcGwgZXN0IHRtMiBz
c3NlMyBjeDE2IHh0cHIgcGRjbSBtb3ZiZSBsYWhmX2xtIGR0aGVybQpidWdzCQk6CmJvZ29taXBz
CTogMzMzMi45NApjbGZsdXNoIHNpemUJOiA2NApjYWNoZV9hbGlnbm1lbnQJOiA2NAphZGRyZXNz
IHNpemVzCTogMzIgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCnBvd2VyIG1hbmFnZW1l
bnQ6Cgo=
--0000000000007744030641610eef
Content-Type: text/plain; charset="US-ASCII"; name="dmesg_bookworm.txt"
Content-Disposition: attachment; filename="dmesg_bookworm.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mgvbyu731>
X-Attachment-Id: f_mgvbyu731

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA2LjEuMC00MC1hbWQ2NCAoZGViaWFuLWtlcm5l
bEBsaXN0cy5kZWJpYW4ub3JnKSAoZ2NjLTEyIChEZWJpYW4gMTIuMi4wLTE0K2RlYjEydTEpIDEy
LjIuMCwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlhbikgMi40MCkgIzEgU01QIFBSRUVN
UFRfRFlOQU1JQyBEZWJpYW4gNi4xLjE1My0xICgyMDI1LTA5LTIwKQpbICAgIDAuMDAwMDAwXSBD
b21tYW5kIGxpbmU6IEJPT1RfSU1BR0U9L3ZtbGludXotNi4xLjAtNDAtYW1kNjQgcm9vdD0vZGV2
L21hcHBlci9zbm93YmVsbC0tdmctcm9vdCBybyB6c3dhcC5lbmFibGVkPTEgbG9nbGV2ZWw9Nwpb
ICAgIDAuMDAwMDAwXSBCSU9TLXByb3ZpZGVkIHBoeXNpY2FsIFJBTSBtYXA6ClsgICAgMC4wMDAw
MDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMDAwMDAwMDAtMHgwMDAwMDAwMDAwMDlmYmZm
XSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDA5ZmMw
MC0weDAwMDAwMDAwMDAwOWZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDog
W21lbSAweDAwMDAwMDAwMDAwZTIwMDAtMHgwMDAwMDAwMDAwMGZmZmZmXSByZXNlcnZlZApbICAg
IDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMTAwMDAwLTB4MDAwMDAwMDA3
ZjY4ZmZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
N2Y2OTAwMDAtMHgwMDAwMDAwMDdmNjlkZmZmXSBBQ1BJIGRhdGEKWyAgICAwLjAwMDAwMF0gQklP
Uy1lODIwOiBbbWVtIDB4MDAwMDAwMDA3ZjY5ZTAwMC0weDAwMDAwMDAwN2Y2ZGZmZmZdIEFDUEkg
TlZTClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwN2Y2ZTAwMDAtMHgw
MDAwMDAwMDdmNmZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMGZlZTAwMDAwLTB4MDAwMDAwMDBmZWUwMGZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAw
MDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZmY4MDAwMC0weDAwMDAwMDAwZmZmZmZm
ZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIE5YIChFeGVjdXRlIERpc2FibGUpIHByb3RlY3Rp
b246IGFjdGl2ZQpbICAgIDAuMDAwMDAwXSBTTUJJT1MgMi42IHByZXNlbnQuClsgICAgMC4wMDAw
MDBdIERNSTogQVNVU1RlSyBDb21wdXRlciBJTkMuIDEwMDVQRS8xMDA1UCwgQklPUyAxMjAyICAg
IDA2LzIzLzIwMTAKWyAgICAwLjAwMDAwMF0gdHNjOiBGYXN0IFRTQyBjYWxpYnJhdGlvbiB1c2lu
ZyBQSVQKWyAgICAwLjAwMDAwMF0gdHNjOiBEZXRlY3RlZCAxNjY2LjQ5OCBNSHogcHJvY2Vzc29y
ClsgICAgMC4wMDI2ODldIGU4MjA6IHVwZGF0ZSBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwMGZmZl0g
dXNhYmxlID09PiByZXNlcnZlZApbICAgIDAuMDAyNzAyXSBlODIwOiByZW1vdmUgW21lbSAweDAw
MGEwMDAwLTB4MDAwZmZmZmZdIHVzYWJsZQpbICAgIDAuMDAyNzIxXSBsYXN0X3BmbiA9IDB4N2Y2
OTAgbWF4X2FyY2hfcGZuID0gMHg0MDAwMDAwMDAKWyAgICAwLjAwMjgxOV0geDg2L1BBVDogQ29u
ZmlndXJhdGlvbiBbMC03XTogV0IgIFdDICBVQy0gVUMgIFdCICBXUCAgVUMtIFdUICAKWyAgICAw
LjAxMzExOF0gZm91bmQgU01QIE1QLXRhYmxlIGF0IFttZW0gMHgwMDBmZjc4MC0weDAwMGZmNzhm
XQpbICAgIDAuMDE0MjE0XSBSQU1ESVNLOiBbbWVtIDB4MmZhYWYwMDAtMHgzM2Q0ZWZmZl0KWyAg
ICAwLjAxNDIzNl0gQUNQSTogRWFybHkgdGFibGUgY2hlY2tzdW0gdmVyaWZpY2F0aW9uIGRpc2Fi
bGVkClsgICAgMC4wMTQyNDddIEFDUEk6IFJTRFAgMHgwMDAwMDAwMDAwMEZCRjQwIDAwMDAyNCAo
djAyIEFDUElBTSkKWyAgICAwLjAxNDI2Ml0gQUNQSTogWFNEVCAweDAwMDAwMDAwN0Y2OTAxMDAg
MDAwMDZDICh2MDEgX0FTVVNfIE5vdGVib29rIDA2MDAxMDIzIE1TRlQgMDAwMDAwOTcpClsgICAg
MC4wMTQyODFdIEFDUEk6IEZBQ1AgMHgwMDAwMDAwMDdGNjkwMjkwIDAwMDBGNCAodjA0IEFfTV9J
XyBPRU1GQUNQICAwNjAwMTAyMyBNU0ZUIDAwMDAwMDk3KQpbICAgIDAuMDE0MzAyXSBBQ1BJOiBE
U0RUIDB4MDAwMDAwMDA3RjY5MDQ5MCAwMDhCREUgKHYwMiBBMTQxNCAgQTE0MTQwMDAgMDAwMDAw
MDAgSU5UTCAyMDA2MDExMykKWyAgICAwLjAxNDMxOF0gQUNQSTogRkFDUyAweDAwMDAwMDAwN0Y2
OUUwMDAgMDAwMDQwClsgICAgMC4wMTQzMjldIEFDUEk6IEZBQ1MgMHgwMDAwMDAwMDdGNjlFMDAw
IDAwMDA0MApbICAgIDAuMDE0MzQyXSBBQ1BJOiBBUElDIDB4MDAwMDAwMDA3RjY5MDM5MCAwMDAw
NUMgKHYwMiBBX01fSV8gT0VNQVBJQyAgMDYwMDEwMjMgTVNGVCAwMDAwMDA5NykKWyAgICAwLjAx
NDM1Nl0gQUNQSTogTUNGRyAweDAwMDAwMDAwN0Y2OTAzRjAgMDAwMDNDICh2MDEgQV9NX0lfIE9F
TU1DRkcgIDA2MDAxMDIzIE1TRlQgMDAwMDAwOTcpClsgICAgMC4wMTQzNzFdIEFDUEk6IEVDRFQg
MHgwMDAwMDAwMDdGNjkwNDMwIDAwMDA1NSAodjAxIEFfTV9JXyBPRU1FQ0RUICAwNjAwMTAyMyBN
U0ZUIDAwMDAwMDk3KQpbICAgIDAuMDE0Mzg2XSBBQ1BJOiBPRU1CIDB4MDAwMDAwMDA3RjY5RTA0
MCAwMDAwNjEgKHYwMSBBX01fSV8gQU1JX09FTSAgMDYwMDEwMjMgTVNGVCAwMDAwMDA5NykKWyAg
ICAwLjAxNDQwMF0gQUNQSTogSFBFVCAweDAwMDAwMDAwN0Y2OTkwNzAgMDAwMDM4ICh2MDEgQV9N
X0lfIE9FTUhQRVQgIDA2MDAxMDIzIE1TRlQgMDAwMDAwOTcpClsgICAgMC4wMTQ0MTVdIEFDUEk6
IEdTQ0kgMHgwMDAwMDAwMDdGNjlFMEIwIDAwMjAyNCAodjAxIEFfTV9JXyBHTUNIU0NJICAwNjAw
MTAyMyBNU0ZUIDAwMDAwMDk3KQpbICAgIDAuMDE0NDMwXSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDA3
RjZBMEM4MCAwMDA0RjAgKHYwMSBQbVJlZiAgQ3B1UG0gICAgMDAwMDMwMDAgSU5UTCAyMDA2MDEx
MykKWyAgICAwLjAxNDQ0NF0gQUNQSTogU0xJQyAweDAwMDAwMDAwN0Y2OTkwQjAgMDAwMTc2ICh2
MDEgX0FTVVNfIE5vdGVib29rIDA2MDAxMDIzIE1TRlQgMDAwMDAwOTcpClsgICAgMC4wMTQ0NTdd
IEFDUEk6IFJlc2VydmluZyBGQUNQIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4N2Y2OTAyOTAtMHg3
ZjY5MDM4M10KWyAgICAwLjAxNDQ2M10gQUNQSTogUmVzZXJ2aW5nIERTRFQgdGFibGUgbWVtb3J5
IGF0IFttZW0gMHg3ZjY5MDQ5MC0weDdmNjk5MDZkXQpbICAgIDAuMDE0NDY4XSBBQ1BJOiBSZXNl
cnZpbmcgRkFDUyB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDdmNjllMDAwLTB4N2Y2OWUwM2ZdClsg
ICAgMC4wMTQ0NzJdIEFDUEk6IFJlc2VydmluZyBGQUNTIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4
N2Y2OWUwMDAtMHg3ZjY5ZTAzZl0KWyAgICAwLjAxNDQ3Nl0gQUNQSTogUmVzZXJ2aW5nIEFQSUMg
dGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZjY5MDM5MC0weDdmNjkwM2ViXQpbICAgIDAuMDE0NDgx
XSBBQ1BJOiBSZXNlcnZpbmcgTUNGRyB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDdmNjkwM2YwLTB4
N2Y2OTA0MmJdClsgICAgMC4wMTQ0ODVdIEFDUEk6IFJlc2VydmluZyBFQ0RUIHRhYmxlIG1lbW9y
eSBhdCBbbWVtIDB4N2Y2OTA0MzAtMHg3ZjY5MDQ4NF0KWyAgICAwLjAxNDQ5MF0gQUNQSTogUmVz
ZXJ2aW5nIE9FTUIgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZjY5ZTA0MC0weDdmNjllMGEwXQpb
ICAgIDAuMDE0NDk0XSBBQ1BJOiBSZXNlcnZpbmcgSFBFVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAw
eDdmNjk5MDcwLTB4N2Y2OTkwYTddClsgICAgMC4wMTQ0OTldIEFDUEk6IFJlc2VydmluZyBHU0NJ
IHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4N2Y2OWUwYjAtMHg3ZjZhMDBkM10KWyAgICAwLjAxNDUw
M10gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZjZhMGM4MC0w
eDdmNmExMTZmXQpbICAgIDAuMDE0NTA4XSBBQ1BJOiBSZXNlcnZpbmcgU0xJQyB0YWJsZSBtZW1v
cnkgYXQgW21lbSAweDdmNjk5MGIwLTB4N2Y2OTkyMjVdClsgICAgMC4wMTQ2NTNdIE5vIE5VTUEg
Y29uZmlndXJhdGlvbiBmb3VuZApbICAgIDAuMDE0NjU3XSBGYWtpbmcgYSBub2RlIGF0IFttZW0g
MHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDA3ZjY4ZmZmZl0KWyAgICAwLjAxNDcxOF0gTk9E
RV9EQVRBKDApIGFsbG9jYXRlZCBbbWVtIDB4N2Y2NjUwMDAtMHg3ZjY4ZmZmZl0KWyAgICAwLjAx
NTkwNl0gWm9uZSByYW5nZXM6ClsgICAgMC4wMTU5MTBdICAgRE1BICAgICAgW21lbSAweDAwMDAw
MDAwMDAwMDEwMDAtMHgwMDAwMDAwMDAwZmZmZmZmXQpbICAgIDAuMDE1OTE5XSAgIERNQTMyICAg
IFttZW0gMHgwMDAwMDAwMDAxMDAwMDAwLTB4MDAwMDAwMDA3ZjY4ZmZmZl0KWyAgICAwLjAxNTky
Nl0gICBOb3JtYWwgICBlbXB0eQpbICAgIDAuMDE1OTMwXSAgIERldmljZSAgIGVtcHR5ClsgICAg
MC4wMTU5MzVdIE1vdmFibGUgem9uZSBzdGFydCBmb3IgZWFjaCBub2RlClsgICAgMC4wMTU5NDRd
IEVhcmx5IG1lbW9yeSBub2RlIHJhbmdlcwpbICAgIDAuMDE1OTQ2XSAgIG5vZGUgICAwOiBbbWVt
IDB4MDAwMDAwMDAwMDAwMTAwMC0weDAwMDAwMDAwMDAwOWVmZmZdClsgICAgMC4wMTU5NTJdICAg
bm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAwMTAwMDAwLTB4MDAwMDAwMDA3ZjY4ZmZmZl0KWyAg
ICAwLjAxNTk2MF0gSW5pdG1lbSBzZXR1cCBub2RlIDAgW21lbSAweDAwMDAwMDAwMDAwMDEwMDAt
MHgwMDAwMDAwMDdmNjhmZmZmXQpbICAgIDAuMDE1OTc5XSBPbiBub2RlIDAsIHpvbmUgRE1BOiAx
IHBhZ2VzIGluIHVuYXZhaWxhYmxlIHJhbmdlcwpbICAgIDAuMDE2MTIzXSBPbiBub2RlIDAsIHpv
bmUgRE1BOiA5NyBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5nZXMKWyAgICAwLjAxODgzMl0gT24g
bm9kZSAwLCB6b25lIERNQTMyOiAyNDE2IHBhZ2VzIGluIHVuYXZhaWxhYmxlIHJhbmdlcwpbICAg
IDAuMDE4ODQ5XSBSZXNlcnZpbmcgSW50ZWwgZ3JhcGhpY3MgbWVtb3J5IGF0IFttZW0gMHg3Zjgw
MDAwMC0weDdmZmZmZmZmXQpbICAgIDAuMDE5MDE5XSBBQ1BJOiBQTS1UaW1lciBJTyBQb3J0OiAw
eDgwOApbICAgIDAuMDE5MDU4XSBJT0FQSUNbMF06IGFwaWNfaWQgMiwgdmVyc2lvbiAzMiwgYWRk
cmVzcyAweGZlYzAwMDAwLCBHU0kgMC0yMwpbICAgIDAuMDE5MDcxXSBBQ1BJOiBJTlRfU1JDX09W
UiAoYnVzIDAgYnVzX2lycSAwIGdsb2JhbF9pcnEgMiBkZmwgZGZsKQpbICAgIDAuMDE5MDc5XSBB
Q1BJOiBJTlRfU1JDX09WUiAoYnVzIDAgYnVzX2lycSA5IGdsb2JhbF9pcnEgOSBoaWdoIGxldmVs
KQpbICAgIDAuMDE5MDkzXSBBQ1BJOiBVc2luZyBBQ1BJIChNQURUKSBmb3IgU01QIGNvbmZpZ3Vy
YXRpb24gaW5mb3JtYXRpb24KWyAgICAwLjAxOTA5OV0gQUNQSTogSFBFVCBpZDogMHhmZmZmZmZm
ZiBiYXNlOiAweGZlZDAwMDAwClsgICAgMC4wMTkxMTZdIHNtcGJvb3Q6IEFsbG93aW5nIDIgQ1BV
cywgMCBob3RwbHVnIENQVXMKWyAgICAwLjAxOTE2M10gUE06IGhpYmVybmF0aW9uOiBSZWdpc3Rl
cmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHgwMDAwMDAwMC0weDAwMDAwZmZmXQpbICAgIDAuMDE5
MTcyXSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDAw
MDlmMDAwLTB4MDAwZmZmZmZdClsgICAgMC4wMTkxNzhdIFttZW0gMHg4MDAwMDAwMC0weGZlZGZm
ZmZmXSBhdmFpbGFibGUgZm9yIFBDSSBkZXZpY2VzClsgICAgMC4wMTkxODNdIEJvb3RpbmcgcGFy
YXZpcnR1YWxpemVkIGtlcm5lbCBvbiBiYXJlIGhhcmR3YXJlClsgICAgMC4wMTkxOTFdIGNsb2Nr
c291cmNlOiByZWZpbmVkLWppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczogMHhm
ZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc2NDU1MTk2MDAyMTE1NjggbnMKWyAgICAwLjAzMzc2N10g
c2V0dXBfcGVyY3B1OiBOUl9DUFVTOjgxOTIgbnJfY3B1bWFza19iaXRzOjIgbnJfY3B1X2lkczoy
IG5yX25vZGVfaWRzOjEKWyAgICAwLjAzNTQ5N10gcGVyY3B1OiBFbWJlZGRlZCA2MiBwYWdlcy9j
cHUgczIxNzA4OCByODE5MiBkMjg2NzIgdTEwNDg1NzYKWyAgICAwLjAzNTUyNF0gcGNwdS1hbGxv
YzogczIxNzA4OCByODE5MiBkMjg2NzIgdTEwNDg1NzYgYWxsb2M9MSoyMDk3MTUyClsgICAgMC4w
MzU1MzVdIHBjcHUtYWxsb2M6IFswXSAwIDEgClsgICAgMC4wMzU2NDVdIEZhbGxiYWNrIG9yZGVy
IGZvciBOb2RlIDA6IDAgClsgICAgMC4wMzU2NTZdIEJ1aWx0IDEgem9uZWxpc3RzLCBtb2JpbGl0
eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiA1MTM0NjEKWyAgICAwLjAzNTY2M10gUG9saWN5
IHpvbmU6IERNQTMyClsgICAgMC4wMzU2NjddIEtlcm5lbCBjb21tYW5kIGxpbmU6IEJPT1RfSU1B
R0U9L3ZtbGludXotNi4xLjAtNDAtYW1kNjQgcm9vdD0vZGV2L21hcHBlci9zbm93YmVsbC0tdmct
cm9vdCBybyB6c3dhcC5lbmFibGVkPTEgbG9nbGV2ZWw9NwpbICAgIDAuMDM1ODI4XSBVbmtub3du
IGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVycyAiQk9PVF9JTUFHRT0vdm1saW51ei02LjEu
MC00MC1hbWQ2NCIsIHdpbGwgYmUgcGFzc2VkIHRvIHVzZXIgc3BhY2UuClsgICAgMC4wMzcxMzdd
IERlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDI2MjE0NCAob3JkZXI6IDksIDIwOTcx
NTIgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjAzNzg0NF0gSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiAxMzEwNzIgKG9yZGVyOiA4LCAxMDQ4NTc2IGJ5dGVzLCBsaW5lYXIpClsgICAgMC4w
Mzc5NDRdIG1lbSBhdXRvLWluaXQ6IHN0YWNrOmFsbCh6ZXJvKSwgaGVhcCBhbGxvYzpvbiwgaGVh
cCBmcmVlOm9mZgpbICAgIDAuMDUyMTI2XSBNZW1vcnk6IDI2MDg2MEsvMjA4NzA5NksgYXZhaWxh
YmxlICgxNDM0M0sga2VybmVsIGNvZGUsIDIzNDBLIHJ3ZGF0YSwgOTEwNEsgcm9kYXRhLCAyODE2
SyBpbml0LCAxNzM2MEsgYnNzLCAxNTg3NDhLIHJlc2VydmVkLCAwSyBjbWEtcmVzZXJ2ZWQpClsg
ICAgMC4wNTM0OTBdIFNMVUI6IEhXYWxpZ249NjQsIE9yZGVyPTAtMywgTWluT2JqZWN0cz0wLCBD
UFVzPTIsIE5vZGVzPTEKWyAgICAwLjA1MzY0NV0gZnRyYWNlOiBhbGxvY2F0aW5nIDQwMzc3IGVu
dHJpZXMgaW4gMTU4IHBhZ2VzClsgICAgMC4wNjY3NzldIGZ0cmFjZTogYWxsb2NhdGVkIDE1OCBw
YWdlcyB3aXRoIDUgZ3JvdXBzClsgICAgMC4wNjg0NDBdIER5bmFtaWMgUHJlZW1wdDogdm9sdW50
YXJ5ClsgICAgMC4wNjg2MTFdIHJjdTogUHJlZW1wdGlibGUgaGllcmFyY2hpY2FsIFJDVSBpbXBs
ZW1lbnRhdGlvbi4KWyAgICAwLjA2ODYxNV0gcmN1OiAJUkNVIHJlc3RyaWN0aW5nIENQVXMgZnJv
bSBOUl9DUFVTPTgxOTIgdG8gbnJfY3B1X2lkcz0yLgpbICAgIDAuMDY4NjIxXSAJVHJhbXBvbGlu
ZSB2YXJpYW50IG9mIFRhc2tzIFJDVSBlbmFibGVkLgpbICAgIDAuMDY4NjI0XSAJUnVkZSB2YXJp
YW50IG9mIFRhc2tzIFJDVSBlbmFibGVkLgpbICAgIDAuMDY4NjI1XSAJVHJhY2luZyB2YXJpYW50
IG9mIFRhc2tzIFJDVSBlbmFibGVkLgpbICAgIDAuMDY4NjI4XSByY3U6IFJDVSBjYWxjdWxhdGVk
IHZhbHVlIG9mIHNjaGVkdWxlci1lbmxpc3RtZW50IGRlbGF5IGlzIDI1IGppZmZpZXMuClsgICAg
MC4wNjg2MzJdIHJjdTogQWRqdXN0aW5nIGdlb21ldHJ5IGZvciByY3VfZmFub3V0X2xlYWY9MTYs
IG5yX2NwdV9pZHM9MgpbICAgIDAuMDkwMzE0XSBOUl9JUlFTOiA1MjQ1NDQsIG5yX2lycXM6IDQ0
MCwgcHJlYWxsb2NhdGVkIGlycXM6IDE2ClsgICAgMC4wOTA2NjddIHJjdTogc3JjdV9pbml0OiBT
ZXR0aW5nIHNyY3Vfc3RydWN0IHNpemVzIGJhc2VkIG9uIGNvbnRlbnRpb24uClsgICAgMC4wOTM1
MTFdIENvbnNvbGU6IGNvbG91ciBWR0ErIDgweDI1ClsgICAgMC4xMDE5MDNdIHByaW50azogY29u
c29sZSBbdHR5MF0gZW5hYmxlZApbICAgIDAuMTAyMDc3XSBBQ1BJOiBDb3JlIHJldmlzaW9uIDIw
MjIwMzMxClsgICAgMC4xMDI1MDhdIGNsb2Nrc291cmNlOiBocGV0OiBtYXNrOiAweGZmZmZmZmZm
IG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiAxMzM0ODQ4ODI4NDggbnMKWyAg
ICAwLjEwMjY1OV0gQVBJQzogU3dpdGNoIHRvIHN5bW1ldHJpYyBJL08gbW9kZSBzZXR1cApbICAg
IDAuMTAzMjA4XSAuLlRJTUVSOiB2ZWN0b3I9MHgzMCBhcGljMT0wIHBpbjE9MiBhcGljMj0tMSBw
aW4yPS0xClsgICAgMC4xMjI2NjFdIGNsb2Nrc291cmNlOiB0c2MtZWFybHk6IG1hc2s6IDB4ZmZm
ZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVzOiAweDE4MDU4NzM1YWZjLCBtYXhfaWRsZV9uczogNDQw
Nzk1MjI2OTQ2IG5zClsgICAgMC4xMjI4MDVdIENhbGlicmF0aW5nIGRlbGF5IGxvb3AgKHNraXBw
ZWQpLCB2YWx1ZSBjYWxjdWxhdGVkIHVzaW5nIHRpbWVyIGZyZXF1ZW5jeS4uIDMzMzIuOTkgQm9n
b01JUFMgKGxwaj02NjY1OTkyKQpbICAgIDAuMTIyOTY2XSBDUFUwOiBUaGVybWFsIG1vbml0b3Jp
bmcgZW5hYmxlZCAoVE0yKQpbICAgIDAuMTIzMDkwXSBwcm9jZXNzOiB1c2luZyBtd2FpdCBpbiBp
ZGxlIHRocmVhZHMKWyAgICAwLjEyMzE3Nl0gTGFzdCBsZXZlbCBpVExCIGVudHJpZXM6IDRLQiAz
MiwgMk1CIDAsIDRNQiAwClsgICAgMC4xMjMyNjBdIExhc3QgbGV2ZWwgZFRMQiBlbnRyaWVzOiA0
S0IgNjQsIDJNQiAwLCA0TUIgOCwgMUdCIDAKWyAgICAwLjEyMzM2Ml0geDg2L2ZwdTogeDg3IEZQ
VSB3aWxsIHVzZSBGWFNBVkUKWyAgICAwLjE3NTEwNF0gRnJlZWluZyBTTVAgYWx0ZXJuYXRpdmVz
IG1lbW9yeTogMzZLClsgICAgMC4xNzUyMDRdIHBpZF9tYXg6IGRlZmF1bHQ6IDMyNzY4IG1pbmlt
dW06IDMwMQpbICAgIDAuMTc1NTQ0XSBMU006IFNlY3VyaXR5IEZyYW1ld29yayBpbml0aWFsaXpp
bmcKWyAgICAwLjE3NTcwNF0gbGFuZGxvY2s6IFVwIGFuZCBydW5uaW5nLgpbICAgIDAuMTc1Nzgw
XSBZYW1hOiBkaXNhYmxlZCBieSBkZWZhdWx0OyBlbmFibGUgd2l0aCBzeXNjdGwga2VybmVsLnlh
bWEuKgpbICAgIDAuMTc1OTc3XSBBcHBBcm1vcjogQXBwQXJtb3IgaW5pdGlhbGl6ZWQKWyAgICAw
LjE3NjA2MF0gVE9NT1lPIExpbnV4IGluaXRpYWxpemVkClsgICAgMC4xNzYxNDldIExTTSBzdXBw
b3J0IGZvciBlQlBGIGFjdGl2ZQpbICAgIDAuMTc2Mzk0XSBNb3VudC1jYWNoZSBoYXNoIHRhYmxl
IGVudHJpZXM6IDQwOTYgKG9yZGVyOiAzLCAzMjc2OCBieXRlcywgbGluZWFyKQpbICAgIDAuMTc2
NTI2XSBNb3VudHBvaW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNDA5NiAob3JkZXI6IDMs
IDMyNzY4IGJ5dGVzLCBsaW5lYXIpClsgICAgMC4yOTEwNDFdIHNtcGJvb3Q6IENQVTA6IEludGVs
KFIpIEF0b20oVE0pIENQVSBONDUwICAgQCAxLjY2R0h6IChmYW1pbHk6IDB4NiwgbW9kZWw6IDB4
MWMsIHN0ZXBwaW5nOiAweGEpClsgICAgMC4yOTE5NzZdIGNibGlzdF9pbml0X2dlbmVyaWM6IFNl
dHRpbmcgYWRqdXN0YWJsZSBudW1iZXIgb2YgY2FsbGJhY2sgcXVldWVzLgpbICAgIDAuMjkyMTAw
XSBjYmxpc3RfaW5pdF9nZW5lcmljOiBTZXR0aW5nIHNoaWZ0IHRvIDEgYW5kIGxpbSB0byAxLgpb
ICAgIDAuMjkyMzE3XSBjYmxpc3RfaW5pdF9nZW5lcmljOiBTZXR0aW5nIGFkanVzdGFibGUgbnVt
YmVyIG9mIGNhbGxiYWNrIHF1ZXVlcy4KWyAgICAwLjI5MjQzM10gY2JsaXN0X2luaXRfZ2VuZXJp
YzogU2V0dGluZyBzaGlmdCB0byAxIGFuZCBsaW0gdG8gMS4KWyAgICAwLjI5MjYyNF0gY2JsaXN0
X2luaXRfZ2VuZXJpYzogU2V0dGluZyBhZGp1c3RhYmxlIG51bWJlciBvZiBjYWxsYmFjayBxdWV1
ZXMuClsgICAgMC4yOTI3MzhdIGNibGlzdF9pbml0X2dlbmVyaWM6IFNldHRpbmcgc2hpZnQgdG8g
MSBhbmQgbGltIHRvIDEuClsgICAgMC4yOTI5MThdIFBlcmZvcm1hbmNlIEV2ZW50czogUEVCUyBm
bXQwKywgQXRvbSBldmVudHMsIDgtZGVlcCBMQlIsIEludGVsIFBNVSBkcml2ZXIuClsgICAgMC4y
OTMwODNdIC4uLiB2ZXJzaW9uOiAgICAgICAgICAgICAgICAzClsgICAgMC4yOTMxNThdIC4uLiBi
aXQgd2lkdGg6ICAgICAgICAgICAgICA0MApbICAgIDAuMjkzMjMzXSAuLi4gZ2VuZXJpYyByZWdp
c3RlcnM6ICAgICAgMgpbICAgIDAuMjkzMzA4XSAuLi4gdmFsdWUgbWFzazogICAgICAgICAgICAg
MDAwMDAwZmZmZmZmZmZmZgpbICAgIDAuMjkzMzg4XSAuLi4gbWF4IHBlcmlvZDogICAgICAgICAg
ICAgMDAwMDAwMDA3ZmZmZmZmZgpbICAgIDAuMjkzNDY5XSAuLi4gZml4ZWQtcHVycG9zZSBldmVu
dHM6ICAgMwpbICAgIDAuMjkzNTQ0XSAuLi4gZXZlbnQgbWFzazogICAgICAgICAgICAgMDAwMDAw
MDcwMDAwMDAwMwpbICAgIDAuMjkzOTMyXSBzaWduYWw6IG1heCBzaWdmcmFtZSBzaXplOiAxNDQw
ClsgICAgMC4yOTQxNjldIHJjdTogSGllcmFyY2hpY2FsIFNSQ1UgaW1wbGVtZW50YXRpb24uClsg
ICAgMC4yOTQyNTNdIHJjdTogCU1heCBwaGFzZSBuby1kZWxheSBpbnN0YW5jZXMgaXMgMTAwMC4K
WyAgICAwLjI5NTQ1M10gTk1JIHdhdGNoZG9nOiBFbmFibGVkLiBQZXJtYW5lbnRseSBjb25zdW1l
cyBvbmUgaHctUE1VIGNvdW50ZXIuClsgICAgMC4yOTU4MzldIHNtcDogQnJpbmdpbmcgdXAgc2Vj
b25kYXJ5IENQVXMgLi4uClsgICAgMC4yOTY1MzBdIHg4NjogQm9vdGluZyBTTVAgY29uZmlndXJh
dGlvbjoKWyAgICAwLjI5NjYxOV0gLi4uLiBub2RlICAjMCwgQ1BVczogICAgICAjMQpbICAgIDAu
MDE2MDkyXSBEaXNhYmxlZCBmYXN0IHN0cmluZyBvcGVyYXRpb25zClsgICAgMC4zMTMxNDRdIHNt
cDogQnJvdWdodCB1cCAxIG5vZGUsIDIgQ1BVcwpbICAgIDAuMzEzMTQ0XSBzbXBib290OiBNYXgg
bG9naWNhbCBwYWNrYWdlczogMQpbICAgIDAuMzEzMTQ0XSBzbXBib290OiBUb3RhbCBvZiAyIHBy
b2Nlc3NvcnMgYWN0aXZhdGVkICg2NjY1Ljk5IEJvZ29NSVBTKQpbICAgIDAuMzQyNDE5XSBub2Rl
IDAgZGVmZXJyZWQgcGFnZXMgaW5pdGlhbGlzZWQgaW4gMjhtcwpbICAgIDAuMzQzMjYwXSBkZXZ0
bXBmczogaW5pdGlhbGl6ZWQKWyAgICAwLjM0MzI2MF0geDg2L21tOiBNZW1vcnkgYmxvY2sgc2l6
ZTogMTI4TUIKWyAgICAwLjM0NDc3MF0gQUNQSTogUE06IFJlZ2lzdGVyaW5nIEFDUEkgTlZTIHJl
Z2lvbiBbbWVtIDB4N2Y2OWUwMDAtMHg3ZjZkZmZmZl0gKDI3MDMzNiBieXRlcykKWyAgICAwLjM0
NDc3MF0gY2xvY2tzb3VyY2U6IGppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczog
MHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc2NDUwNDE3ODUxMDAwMDAgbnMKWyAgICAwLjM0NDc3
MF0gZnV0ZXggaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIgKG9yZGVyOiAzLCAzMjc2OCBieXRlcywg
bGluZWFyKQpbICAgIDAuMzQ0NzcwXSBwaW5jdHJsIGNvcmU6IGluaXRpYWxpemVkIHBpbmN0cmwg
c3Vic3lzdGVtClsgICAgMC4zNDkwNjddIE5FVDogUmVnaXN0ZXJlZCBQRl9ORVRMSU5LL1BGX1JP
VVRFIHByb3RvY29sIGZhbWlseQpbICAgIDAuMzQ5NjgzXSBETUE6IHByZWFsbG9jYXRlZCAyNTYg
S2lCIEdGUF9LRVJORUwgcG9vbCBmb3IgYXRvbWljIGFsbG9jYXRpb25zClsgICAgMC4zNDk5Mzhd
IERNQTogcHJlYWxsb2NhdGVkIDI1NiBLaUIgR0ZQX0tFUk5FTHxHRlBfRE1BIHBvb2wgZm9yIGF0
b21pYyBhbGxvY2F0aW9ucwpbICAgIDAuMzUwMjM1XSBETUE6IHByZWFsbG9jYXRlZCAyNTYgS2lC
IEdGUF9LRVJORUx8R0ZQX0RNQTMyIHBvb2wgZm9yIGF0b21pYyBhbGxvY2F0aW9ucwpbICAgIDAu
MzUwNDU2XSBhdWRpdDogaW5pdGlhbGl6aW5nIG5ldGxpbmsgc3Vic3lzIChkaXNhYmxlZCkKWyAg
ICAwLjM1MDk5OF0gYXVkaXQ6IHR5cGU9MjAwMCBhdWRpdCgxNzYwNzMzMjgwLjI0ODoxKTogc3Rh
dGU9aW5pdGlhbGl6ZWQgYXVkaXRfZW5hYmxlZD0wIHJlcz0xClsgICAgMC4zNTEzODldIHRoZXJt
YWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJub3IgJ2ZhaXJfc2hhcmUnClsgICAgMC4z
NTEzOTZdIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJub3IgJ2JhbmdfYmFu
ZycKWyAgICAwLjM1MTQ4NF0gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5v
ciAnc3RlcF93aXNlJwpbICAgIDAuMzU0ODA5XSB0aGVybWFsX3N5czogUmVnaXN0ZXJlZCB0aGVy
bWFsIGdvdmVybm9yICd1c2VyX3NwYWNlJwpbICAgIDAuMzU0ODk1XSB0aGVybWFsX3N5czogUmVn
aXN0ZXJlZCB0aGVybWFsIGdvdmVybm9yICdwb3dlcl9hbGxvY2F0b3InClsgICAgMC4zNTUwMjld
IGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIGxhZGRlcgpbICAgIDAuMzU1MjA4XSBjcHVpZGxlOiB1
c2luZyBnb3Zlcm5vciBtZW51ClsgICAgMC4zNTU0NzddIGFjcGlwaHA6IEFDUEkgSG90IFBsdWcg
UENJIENvbnRyb2xsZXIgRHJpdmVyIHZlcnNpb246IDAuNQpbICAgIDAuMzU1OTExXSBQQ0k6IE1N
Q09ORklHIGZvciBkb21haW4gMDAwMCBbYnVzIDAwLWZmXSBhdCBbbWVtIDB4ZTAwMDAwMDAtMHhl
ZmZmZmZmZl0gKGJhc2UgMHhlMDAwMDAwMCkKWyAgICAwLjM1NjA0N10gUENJOiBub3QgdXNpbmcg
TU1DT05GSUcKWyAgICAwLjM1NjEzMF0gUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5cGUgMSBm
b3IgYmFzZSBhY2Nlc3MKWyAgICAwLjM2MTExMV0ga3Byb2Jlczoga3Byb2JlIGp1bXAtb3B0aW1p
emF0aW9uIGlzIGVuYWJsZWQuIEFsbCBrcHJvYmVzIGFyZSBvcHRpbWl6ZWQgaWYgcG9zc2libGUu
ClsgICAgMC4zODY3OTRdIEh1Z2VUTEI6IHJlZ2lzdGVyZWQgMi4wMCBNaUIgcGFnZSBzaXplLCBw
cmUtYWxsb2NhdGVkIDAgcGFnZXMKWyAgICAwLjM4Njc5NF0gSHVnZVRMQjogMjggS2lCIHZtZW1t
YXAgY2FuIGJlIGZyZWVkIGZvciBhIDIuMDAgTWlCIHBhZ2UKWyAgICAwLjM4ODI0MF0gQUNQSTog
QWRkZWQgX09TSShNb2R1bGUgRGV2aWNlKQpbICAgIDAuMzg4MjQwXSBBQ1BJOiBBZGRlZCBfT1NJ
KFByb2Nlc3NvciBEZXZpY2UpClsgICAgMC4zODgyNDBdIEFDUEk6IEFkZGVkIF9PU0koUHJvY2Vz
c29yIEFnZ3JlZ2F0b3IgRGV2aWNlKQpbICAgIDAuNDA3MDU2XSBBQ1BJOiAyIEFDUEkgQU1MIHRh
YmxlcyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRlZApbICAgIDAuNDA4NzU1XSBBQ1BJ
OiBFQzogRUMgc3RhcnRlZApbICAgIDAuNDA4ODQxXSBBQ1BJOiBFQzogaW50ZXJydXB0IGJsb2Nr
ZWQKWyAgICAwLjQxMDg2MV0gQUNQSTogRUM6IEVDX0NNRC9FQ19TQz0weDY2LCBFQ19EQVRBPTB4
NjIKWyAgICAwLjQxMDk1Ml0gQUNQSTogRUM6IEJvb3QgRUNEVCBFQyB1c2VkIHRvIGhhbmRsZSB0
cmFuc2FjdGlvbnMKWyAgICAwLjQzMjA1M10gQUNQSTogRHluYW1pYyBPRU0gVGFibGUgTG9hZDoK
WyAgICAwLjQzMjA1M10gQUNQSTogU1NEVCAweEZGRkY4QkFDOTY0OTgwMDAgMDAwMzI2ICh2MDEg
UG1SZWYgIENwdTBJc3QgIDAwMDAzMDAwIElOVEwgMjAwNjAxMTMpClsgICAgMC40MzI0MTJdIEFD
UEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAgMC40MzI1MjJdIEFDUEk6IFNTRFQgMHhG
RkZGOEJBQzk2NDNGODAwIDAwMDcyNCAodjAxIFBtUmVmICBDcHUwQ3N0ICAwMDAwMzAwMSBJTlRM
IDIwMDYwMTEzKQpbICAgIDAuNDM0NTk2XSBBQ1BJOiBEeW5hbWljIE9FTSBUYWJsZSBMb2FkOgpb
ICAgIDAuNDM0NjkwXSBBQ1BJOiBTU0RUIDB4RkZGRjhCQUM5NjUzMDNDMCAwMDAwQUIgKHYwMSBQ
bVJlZiAgQ3B1MUlzdCAgMDAwMDMwMDAgSU5UTCAyMDA2MDExMykKWyAgICAwLjQzNTgzN10gQUNQ
STogRHluYW1pYyBPRU0gVGFibGUgTG9hZDoKWyAgICAwLjQzNTkyOF0gQUNQSTogU1NEVCAweEZG
RkY4QkFDOTY1MzAzMDAgMDAwMDg1ICh2MDEgUG1SZWYgIENwdTFDc3QgIDAwMDAzMDAwIElOVEwg
MjAwNjAxMTMpClsgICAgMC40MzczMjldIEFDUEk6IEludGVycHJldGVyIGVuYWJsZWQKWyAgICAw
LjQzNzQ3MV0gQUNQSTogUE06IChzdXBwb3J0cyBTMCBTMyBTNCBTNSkKWyAgICAwLjQzNzU1Ml0g
QUNQSTogVXNpbmcgSU9BUElDIGZvciBpbnRlcnJ1cHQgcm91dGluZwpbICAgIDAuNDM3NzM0XSBQ
Q0k6IE1NQ09ORklHIGZvciBkb21haW4gMDAwMCBbYnVzIDAwLWZmXSBhdCBbbWVtIDB4ZTAwMDAw
MDAtMHhlZmZmZmZmZl0gKGJhc2UgMHhlMDAwMDAwMCkKWyAgICAwLjQzOTI4MV0gUENJOiBNTUNP
TkZJRyBhdCBbbWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZmZl0gcmVzZXJ2ZWQgaW4gQUNQSSBtb3Ro
ZXJib2FyZCByZXNvdXJjZXMKWyAgICAwLjQzOTQ2Nl0gUENJOiBVc2luZyBob3N0IGJyaWRnZSB3
aW5kb3dzIGZyb20gQUNQSTsgaWYgbmVjZXNzYXJ5LCB1c2UgInBjaT1ub2NycyIgYW5kIHJlcG9y
dCBhIGJ1ZwpbICAgIDAuNDM5NTg3XSBQQ0k6IFVzaW5nIEU4MjAgcmVzZXJ2YXRpb25zIGZvciBo
b3N0IGJyaWRnZSB3aW5kb3dzClsgICAgMC40NDAxNzFdIEFDUEk6IEVuYWJsZWQgNCBHUEVzIGlu
IGJsb2NrIDAwIHRvIDFGClsgICAgMC40NTQ5NDRdIEFDUEk6IFtGaXJtd2FyZSBCdWddOiBCSU9T
IF9PU0koTGludXgpIHF1ZXJ5IGlnbm9yZWQKWyAgICAwLjQ1OTAyMF0gQUNQSTogUENJIFJvb3Qg
QnJpZGdlIFtQQ0kwXSAoZG9tYWluIDAwMDAgW2J1cyAwMC1mZl0pClsgICAgMC40NTkxMzNdIGFj
cGkgUE5QMEEwODowMDogX09TQzogT1Mgc3VwcG9ydHMgW0V4dGVuZGVkQ29uZmlnIEFTUE0gQ2xv
Y2tQTSBTZWdtZW50cyBNU0kgSFBYLVR5cGUzXQpbICAgIDAuNDU5MjcyXSBhY3BpIFBOUDBBMDg6
MDA6IF9PU0M6IE9TIHJlcXVlc3RlZCBbUENJZUhvdHBsdWcgU0hQQ0hvdHBsdWcgUE1FIEFFUiBQ
Q0llQ2FwYWJpbGl0eSBMVFJdClsgICAgMC40NTkzOTVdIGFjcGkgUE5QMEEwODowMDogX09TQzog
cGxhdGZvcm0gd2lsbGluZyB0byBncmFudCBbUENJZUhvdHBsdWcgU0hQQ0hvdHBsdWcgUE1FIEFF
UiBQQ0llQ2FwYWJpbGl0eSBMVFJdClsgICAgMC40NTk1MTldIGFjcGkgUE5QMEEwODowMDogX09T
QzogcGxhdGZvcm0gcmV0YWlucyBjb250cm9sIG9mIFBDSWUgZmVhdHVyZXMgKEFFX05PVF9GT1VO
RCkKWyAgICAwLjQ2MDQyOF0gUENJIGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAwOjAwClsgICAgMC40
NjA1MzBdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2lvICAweDAwMDAtMHgw
Y2Y3IHdpbmRvd10KWyAgICAwLjQ2MDYyNF0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNv
dXJjZSBbaW8gIDB4MGQwMC0weGZmZmYgd2luZG93XQpbICAgIDAuNDYwNzE0XSBwY2lfYnVzIDAw
MDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmIHdpbmRv
d10KWyAgICAwLjQ2MDgyOV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVt
IDB4MDAwZDAwMDAtMHgwMDBkZmZmZiB3aW5kb3ddClsgICAgMC40NjA5NDRdIHBjaV9idXMgMDAw
MDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweDdmNzAwMDAwLTB4ZmVkOGZmZmYgd2luZG93
XQpbICAgIDAuNDYxMDYxXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMg
MDAtZmZdClsgICAgMC40NjExODhdIHBjaSAwMDAwOjAwOjAwLjA6IFs4MDg2OmEwMTBdIHR5cGUg
MDAgY2xhc3MgMHgwNjAwMDAKWyAgICAwLjQ2MTQ4N10gcGNpIDAwMDA6MDA6MDIuMDogWzgwODY6
YTAxMV0gdHlwZSAwMCBjbGFzcyAweDAzMDAwMApbICAgIDAuNDYxNTg3XSBwY2kgMDAwMDowMDow
Mi4wOiByZWcgMHgxMDogW21lbSAweGY3ZTAwMDAwLTB4ZjdlN2ZmZmZdClsgICAgMC40NjE2ODBd
IHBjaSAwMDAwOjAwOjAyLjA6IHJlZyAweDE0OiBbaW8gIDB4ZGMwMC0weGRjMDddClsgICAgMC40
NjE3NjldIHBjaSAwMDAwOjAwOjAyLjA6IHJlZyAweDE4OiBbbWVtIDB4ZDAwMDAwMDAtMHhkZmZm
ZmZmZiBwcmVmXQpbICAgIDAuNDYxODYyXSBwY2kgMDAwMDowMDowMi4wOiByZWcgMHgxYzogW21l
bSAweGY3ZDAwMDAwLTB4ZjdkZmZmZmZdClsgICAgMC40NjE5ODBdIHBjaSAwMDAwOjAwOjAyLjA6
IFZpZGVvIGRldmljZSB3aXRoIHNoYWRvd2VkIFJPTSBhdCBbbWVtIDB4MDAwYzAwMDAtMHgwMDBk
ZmZmZl0KWyAgICAwLjQ2MjM2NV0gcGNpIDAwMDA6MDA6MDIuMTogWzgwODY6YTAxMl0gdHlwZSAw
MCBjbGFzcyAweDAzODAwMApbICAgIDAuNDYyNDY0XSBwY2kgMDAwMDowMDowMi4xOiByZWcgMHgx
MDogW21lbSAweGY3ZTgwMDAwLTB4ZjdlZmZmZmZdClsgICAgMC40NjI3NjJdIHBjaSAwMDAwOjAw
OjFiLjA6IFs4MDg2OjI3ZDhdIHR5cGUgMDAgY2xhc3MgMHgwNDAzMDAKWyAgICAwLjQ2MjgyNF0g
cGNpIDAwMDA6MDA6MWIuMDogcmVnIDB4MTA6IFttZW0gMHhmN2NmODAwMC0weGY3Y2ZiZmZmIDY0
Yml0XQpbICAgIDAuNDYzMDE2XSBwY2kgMDAwMDowMDoxYi4wOiBQTUUjIHN1cHBvcnRlZCBmcm9t
IEQwIEQzaG90IEQzY29sZApbICAgIDAuNDYzMjg5XSBwY2kgMDAwMDowMDoxYy4wOiBbODA4Njoy
N2QwXSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwClsgICAgMC40NjM0NzhdIHBjaSAwMDAwOjAwOjFj
LjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMC40NjM4NzddIHBj
aSAwMDAwOjAwOjFjLjE6IFs4MDg2OjI3ZDJdIHR5cGUgMDEgY2xhc3MgMHgwNjA0MDAKWyAgICAw
LjQ2NDA3M10gcGNpIDAwMDA6MDA6MWMuMTogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBE
M2NvbGQKWyAgICAwLjQ2NDQ5Ml0gcGNpIDAwMDA6MDA6MWMuMzogWzgwODY6MjdkNl0gdHlwZSAw
MSBjbGFzcyAweDA2MDQwMApbICAgIDAuNDY0NjkwXSBwY2kgMDAwMDowMDoxYy4zOiBQTUUjIHN1
cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuNDY1MTE3XSBwY2kgMDAwMDowMDox
ZC4wOiBbODA4NjoyN2M4XSB0eXBlIDAwIGNsYXNzIDB4MGMwMzAwClsgICAgMC40NjUyNTNdIHBj
aSAwMDAwOjAwOjFkLjA6IHJlZyAweDIwOiBbaW8gIDB4ZDQwMC0weGQ0MWZdClsgICAgMC40NjU2
MjFdIHBjaSAwMDAwOjAwOjFkLjE6IFs4MDg2OjI3YzldIHR5cGUgMDAgY2xhc3MgMHgwYzAzMDAK
WyAgICAwLjQ2NTc1NV0gcGNpIDAwMDA6MDA6MWQuMTogcmVnIDB4MjA6IFtpbyAgMHhkNDgwLTB4
ZDQ5Zl0KWyAgICAwLjQ2NjExOV0gcGNpIDAwMDA6MDA6MWQuMjogWzgwODY6MjdjYV0gdHlwZSAw
MCBjbGFzcyAweDBjMDMwMApbICAgIDAuNDY2MjUyXSBwY2kgMDAwMDowMDoxZC4yOiByZWcgMHgy
MDogW2lvICAweGQ4MDAtMHhkODFmXQpbICAgIDAuNDY2NjA4XSBwY2kgMDAwMDowMDoxZC4zOiBb
ODA4NjoyN2NiXSB0eXBlIDAwIGNsYXNzIDB4MGMwMzAwClsgICAgMC40NjY4MjVdIHBjaSAwMDAw
OjAwOjFkLjM6IHJlZyAweDIwOiBbaW8gIDB4ZDg4MC0weGQ4OWZdClsgICAgMC40NjcyMTRdIHBj
aSAwMDAwOjAwOjFkLjc6IFs4MDg2OjI3Y2NdIHR5cGUgMDAgY2xhc3MgMHgwYzAzMjAKWyAgICAw
LjQ2NzMyNF0gcGNpIDAwMDA6MDA6MWQuNzogcmVnIDB4MTA6IFttZW0gMHhmN2NmN2MwMC0weGY3
Y2Y3ZmZmXQpbICAgIDAuNDY3NTA5XSBwY2kgMDAwMDowMDoxZC43OiBQTUUjIHN1cHBvcnRlZCBm
cm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuNDY3ODkzXSBwY2kgMDAwMDowMDoxZS4wOiBbODA4
NjoyNDQ4XSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAxClsgICAgMC40NjgyOTldIHBjaSAwMDAwOjAw
OjFmLjA6IFs4MDg2OjI3YmNdIHR5cGUgMDAgY2xhc3MgMHgwNjAxMDAKWyAgICAwLjQ2ODgzOV0g
cGNpIDAwMDA6MDA6MWYuMjogWzgwODY6MjdjMV0gdHlwZSAwMCBjbGFzcyAweDAxMDYwMQpbICAg
IDAuNDY4OTQ4XSBwY2kgMDAwMDowMDoxZi4yOiByZWcgMHgxMDogW2lvICAweGQwODAtMHhkMDg3
XQpbICAgIDAuNDY5MDQyXSBwY2kgMDAwMDowMDoxZi4yOiByZWcgMHgxNDogW2lvICAweGQwMDAt
MHhkMDAzXQpbICAgIDAuNDY5MTM0XSBwY2kgMDAwMDowMDoxZi4yOiByZWcgMHgxODogW2lvICAw
eGNjMDAtMHhjYzA3XQpbICAgIDAuNDY5MjI2XSBwY2kgMDAwMDowMDoxZi4yOiByZWcgMHgxYzog
W2lvICAweGM4ODAtMHhjODgzXQpbICAgIDAuNDY5MzE3XSBwY2kgMDAwMDowMDoxZi4yOiByZWcg
MHgyMDogW2lvICAweGM4MDAtMHhjODFmXQpbICAgIDAuNDY5NDA5XSBwY2kgMDAwMDowMDoxZi4y
OiByZWcgMHgyNDogW21lbSAweGY3Y2Y3ODAwLTB4ZjdjZjdiZmZdClsgICAgMC40Njk1NTJdIHBj
aSAwMDAwOjAwOjFmLjI6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QKWyAgICAwLjQ2OTkxOV0g
cGNpIDAwMDA6MDA6MWYuMzogWzgwODY6MjdkYV0gdHlwZSAwMCBjbGFzcyAweDBjMDUwMApbICAg
IDAuNDcwMDY1XSBwY2kgMDAwMDowMDoxZi4zOiByZWcgMHgyMDogW2lvICAweDA0MDAtMHgwNDFm
XQpbICAgIDAuNDcwNDE5XSBwY2kgMDAwMDowMDoxYy4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDRd
ClsgICAgMC40NzA2NDNdIHBjaSAwMDAwOjAyOjAwLjA6IFsxNjhjOjAwMmJdIHR5cGUgMDAgY2xh
c3MgMHgwMjgwMDAKWyAgICAwLjQ3MDc2Ml0gcGNpIDAwMDA6MDI6MDAuMDogcmVnIDB4MTA6IFtt
ZW0gMHhmYmZmMDAwMC0weGZiZmZmZmZmIDY0Yml0XQpbICAgIDAuNDcwOTcxXSBwY2kgMDAwMDow
MjowMC4wOiBzdXBwb3J0cyBEMQpbICAgIDAuNDcxMDUyXSBwY2kgMDAwMDowMjowMC4wOiBQTUUj
IHN1cHBvcnRlZCBmcm9tIEQwIEQxIEQzaG90IEQzY29sZApbICAgIDAuNDcxMzk4XSBwY2kgMDAw
MDowMDoxYy4xOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDItMDNdClsgICAgMC40NzE0OTJdIHBjaSAw
MDAwOjAwOjFjLjE6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZjgwMDAwMDAtMHhmYmZmZmZmZl0K
WyAgICAwLjQ3MTU4Nl0gcGNpIDAwMDA6MDA6MWMuMTogICBicmlkZ2Ugd2luZG93IFttZW0gMHhm
MDAwMDAwMC0weGY2ZmZmZmZmIDY0Yml0IHByZWZdClsgICAgMC40NzE4MzBdIHBjaSAwMDAwOjAx
OjAwLjA6IFsxOTY5OjEwNjJdIHR5cGUgMDAgY2xhc3MgMHgwMjAwMDAKWyAgICAwLjQ3MTk0OF0g
cGNpIDAwMDA6MDE6MDAuMDogcmVnIDB4MTA6IFttZW0gMHhmN2ZjMDAwMC0weGY3ZmZmZmZmIDY0
Yml0XQpbICAgIDAuNDcyMDUwXSBwY2kgMDAwMDowMTowMC4wOiByZWcgMHgxODogW2lvICAweGVj
MDAtMHhlYzdmXQpbICAgIDAuNDcyMjA3XSBwY2kgMDAwMDowMTowMC4wOiBbRmlybXdhcmUgQnVn
XTogZGlzYWJsaW5nIFZQRCBhY2Nlc3MgKGNhbid0IGRldGVybWluZSBzaXplIG9mIG5vbi1zdGFu
ZGFyZCBWUEQgZm9ybWF0KQpbICAgIDAuNDcyNDA5XSBwY2kgMDAwMDowMTowMC4wOiBQTUUjIHN1
cHBvcnRlZCBmcm9tIEQwIEQxIEQyIEQzaG90IEQzY29sZApbICAgIDAuNDcyNzMyXSBwY2kgMDAw
MDowMDoxYy4zOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDFdClsgICAgMC40NzI4MjBdIHBjaSAwMDAw
OjAwOjFjLjM6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4ZTAwMC0weGVmZmZdClsgICAgMC40NzI5
MDldIHBjaSAwMDAwOjAwOjFjLjM6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZjdmMDAwMDAtMHhm
N2ZmZmZmZl0KWyAgICAwLjQ3MzA1NV0gcGNpX2J1cyAwMDAwOjA1OiBleHRlbmRlZCBjb25maWcg
c3BhY2Ugbm90IGFjY2Vzc2libGUKWyAgICAwLjQ3MzI1NF0gcGNpIDAwMDA6MDA6MWUuMDogUENJ
IGJyaWRnZSB0byBbYnVzIDA1XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDAuNDczMzU2XSBw
Y2kgMDAwMDowMDoxZS4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDAwMDAtMHgwY2Y3IHdpbmRv
d10gKHN1YnRyYWN0aXZlIGRlY29kZSkKWyAgICAwLjQ3MzQ3Nl0gcGNpIDAwMDA6MDA6MWUuMDog
ICBicmlkZ2Ugd2luZG93IFtpbyAgMHgwZDAwLTB4ZmZmZiB3aW5kb3ddIChzdWJ0cmFjdGl2ZSBk
ZWNvZGUpClsgICAgMC40NzM1OTVdIHBjaSAwMDAwOjAwOjFlLjA6ICAgYnJpZGdlIHdpbmRvdyBb
bWVtIDB4MDAwYTAwMDAtMHgwMDBiZmZmZiB3aW5kb3ddIChzdWJ0cmFjdGl2ZSBkZWNvZGUpClsg
ICAgMC40NzM3MTddIHBjaSAwMDAwOjAwOjFlLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4MDAw
ZDAwMDAtMHgwMDBkZmZmZiB3aW5kb3ddIChzdWJ0cmFjdGl2ZSBkZWNvZGUpClsgICAgMC40NzM4
MzddIHBjaSAwMDAwOjAwOjFlLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4N2Y3MDAwMDAtMHhm
ZWQ4ZmZmZiB3aW5kb3ddIChzdWJ0cmFjdGl2ZSBkZWNvZGUpClsgICAgMC40NzY2MThdIEFDUEk6
IFBDSTogSW50ZXJydXB0IGxpbmsgTE5LQSBjb25maWd1cmVkIGZvciBJUlEgMTUKWyAgICAwLjQ3
NjkwN10gQUNQSTogUENJOiBJbnRlcnJ1cHQgbGluayBMTktCIGNvbmZpZ3VyZWQgZm9yIElSUSAx
MApbICAgIDAuNDc3MTgyXSBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0MgY29uZmlndXJl
ZCBmb3IgSVJRIDcKWyAgICAwLjQ3NzQ1Nl0gQUNQSTogUENJOiBJbnRlcnJ1cHQgbGluayBMTktE
IGNvbmZpZ3VyZWQgZm9yIElSUSAxMQpbICAgIDAuNDc3NzMwXSBBQ1BJOiBQQ0k6IEludGVycnVw
dCBsaW5rIExOS0UgY29uZmlndXJlZCBmb3IgSVJRIDAKWyAgICAwLjQ3NzgxOF0gQUNQSTogUENJ
OiBJbnRlcnJ1cHQgbGluayBMTktFIGRpc2FibGVkClsgICAgMC40NzgwODNdIEFDUEk6IFBDSTog
SW50ZXJydXB0IGxpbmsgTE5LRiBjb25maWd1cmVkIGZvciBJUlEgNQpbICAgIDAuNDc4Mzc3XSBB
Q1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0cgY29uZmlndXJlZCBmb3IgSVJRIDQKWyAgICAw
LjQ3ODY1MV0gQUNQSTogUENJOiBJbnRlcnJ1cHQgbGluayBMTktIIGNvbmZpZ3VyZWQgZm9yIElS
USAzClsgICAgMC40NzkzNjVdIEFDUEk6IEVDOiBpbnRlcnJ1cHQgdW5ibG9ja2VkClsgICAgMC40
Nzk0NTFdIEFDUEk6IEVDOiBldmVudCB1bmJsb2NrZWQKWyAgICAwLjQ3OTUyOV0gQUNQSTogRUM6
IEVDX0NNRC9FQ19TQz0weDY2LCBFQ19EQVRBPTB4NjIKWyAgICAwLjQ3OTYxMF0gQUNQSTogRUM6
IEdQRT0weDFjClsgICAgMC40Nzk2ODVdIEFDUEk6IFxfU0JfLlBDSTAuU0JSRy5FQzBfOiBCb290
IEVDRFQgRUMgaW5pdGlhbGl6YXRpb24gY29tcGxldGUKWyAgICAwLjQ3OTc3N10gQUNQSTogXF9T
Ql8uUENJMC5TQlJHLkVDMF86IEVDOiBVc2VkIHRvIGhhbmRsZSB0cmFuc2FjdGlvbnMgYW5kIGV2
ZW50cwpbICAgIDAuNDgwMjQ5XSBpb21tdTogRGVmYXVsdCBkb21haW4gdHlwZTogVHJhbnNsYXRl
ZCAKWyAgICAwLjQ4MjgwNl0gaW9tbXU6IERNQSBkb21haW4gVExCIGludmFsaWRhdGlvbiBwb2xp
Y3k6IGxhenkgbW9kZSAKWyAgICAwLjQ4MzI0MF0gcHBzX2NvcmU6IExpbnV4UFBTIEFQSSB2ZXIu
IDEgcmVnaXN0ZXJlZApbICAgIDAuNDgzMzI4XSBwcHNfY29yZTogU29mdHdhcmUgdmVyLiA1LjMu
NiAtIENvcHlyaWdodCAyMDA1LTIwMDcgUm9kb2xmbyBHaW9tZXR0aSA8Z2lvbWV0dGlAbGludXgu
aXQ+ClsgICAgMC40ODM0NTZdIFBUUCBjbG9jayBzdXBwb3J0IHJlZ2lzdGVyZWQKWyAgICAwLjQ4
MzU3Nl0gRURBQyBNQzogVmVyOiAzLjAuMApbICAgIDAuNDgzODU0XSBOZXRMYWJlbDogSW5pdGlh
bGl6aW5nClsgICAgMC40ODM4NTRdIE5ldExhYmVsOiAgZG9tYWluIGhhc2ggc2l6ZSA9IDEyOApb
ICAgIDAuNDgzODU0XSBOZXRMYWJlbDogIHByb3RvY29scyA9IFVOTEFCRUxFRCBDSVBTT3Y0IENB
TElQU08KWyAgICAwLjQ4Mzg1NF0gTmV0TGFiZWw6ICB1bmxhYmVsZWQgdHJhZmZpYyBhbGxvd2Vk
IGJ5IGRlZmF1bHQKWyAgICAwLjQ4Mzg4OV0gUENJOiBVc2luZyBBQ1BJIGZvciBJUlEgcm91dGlu
ZwpbICAgIDAuNDkxNjU5XSBQQ0k6IHBjaV9jYWNoZV9saW5lX3NpemUgc2V0IHRvIDY0IGJ5dGVz
ClsgICAgMC40OTE3NDRdIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4MDAwOWZjMDAt
MHgwMDA5ZmZmZl0KWyAgICAwLjQ5MTc1Ml0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0g
MHg3ZjY5MDAwMC0weDdmZmZmZmZmXQpbICAgIDAuNDkxODM1XSBwY2kgMDAwMDowMDowMi4wOiB2
Z2FhcmI6IHNldHRpbmcgYXMgYm9vdCBWR0EgZGV2aWNlClsgICAgMC40OTE4MzVdIHBjaSAwMDAw
OjAwOjAyLjA6IHZnYWFyYjogYnJpZGdlIGNvbnRyb2wgcG9zc2libGUKWyAgICAwLjQ5MTgzNV0g
cGNpIDAwMDA6MDA6MDIuMDogdmdhYXJiOiBWR0EgZGV2aWNlIGFkZGVkOiBkZWNvZGVzPWlvK21l
bSxvd25zPWlvK21lbSxsb2Nrcz1ub25lClsgICAgMC40OTE4MzVdIHZnYWFyYjogbG9hZGVkClsg
ICAgMC41MDI2NDRdIGhwZXQ6IDMgY2hhbm5lbHMgb2YgMCByZXNlcnZlZCBmb3IgcGVyLWNwdSB0
aW1lcnMKWyAgICAwLjUwMjc0NF0gaHBldDA6IGF0IE1NSU8gMHhmZWQwMDAwMCwgSVJRcyAyLCA4
LCAwClsgICAgMC41MDI4MDVdIGhwZXQwOiAzIGNvbXBhcmF0b3JzLCA2NC1iaXQgMTQuMzE4MTgw
IE1IeiBjb3VudGVyClsgICAgMC41MDUwMzRdIGNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0byBjbG9j
a3NvdXJjZSB0c2MtZWFybHkKWyAgICAwLjU2NTc1MV0gVkZTOiBEaXNrIHF1b3RhcyBkcXVvdF82
LjYuMApbICAgIDAuNTY1OTU2XSBWRlM6IERxdW90LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczog
NTEyIChvcmRlciAwLCA0MDk2IGJ5dGVzKQpbICAgIDAuNTY2ODAxXSBBcHBBcm1vcjogQXBwQXJt
b3IgRmlsZXN5c3RlbSBFbmFibGVkClsgICAgMC41NjY5OTJdIHBucDogUG5QIEFDUEkgaW5pdApb
ICAgIDAuNTY3MzMxXSBzeXN0ZW0gMDA6MDA6IFttZW0gMHhmZWQxNDAwMC0weGZlZDE5ZmZmXSBo
YXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTY3NDMyXSBzeXN0ZW0gMDA6MDA6IFttZW0gMHhmZWQ5
MDAwMC0weGZlZDkzZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTY5NTAwXSBzeXN0ZW0g
MDA6MDQ6IFtpbyAgMHgwMjVjLTB4MDI1Zl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjU2OTYw
M10gc3lzdGVtIDAwOjA0OiBbaW8gIDB4MDM4MC0weDAzODNdIGhhcyBiZWVuIHJlc2VydmVkClsg
ICAgMC41Njk2OTFdIHN5c3RlbSAwMDowNDogW2lvICAweDA0MDAtMHgwNDFmXSBoYXMgYmVlbiBy
ZXNlcnZlZApbICAgIDAuNTY5Nzc4XSBzeXN0ZW0gMDA6MDQ6IFtpbyAgMHgwNGQwLTB4MDRkMV0g
aGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjU2OTg2NV0gc3lzdGVtIDAwOjA0OiBbaW8gIDB4MDgw
MC0weDA4N2ZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC41Njk5NTJdIHN5c3RlbSAwMDowNDog
W2lvICAweDA0ODAtMHgwNGJmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTcwMDQzXSBzeXN0
ZW0gMDA6MDQ6IFttZW0gMHhmZWQxYzAwMC0weGZlZDFmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApb
ICAgIDAuNTcwMTM1XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWQyMDAwMC0weGZlZDNmZmZmXSBo
YXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTcwMjI2XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWQ1
MDAwMC0weGZlZDhmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTcwMzE3XSBzeXN0ZW0g
MDA6MDQ6IFttZW0gMHhmZmIwMDAwMC0weGZmYmZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAg
IDAuNTcwNDA4XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZmYwMDAwMC0weGZmZmZmZmZmXSBjb3Vs
ZCBub3QgYmUgcmVzZXJ2ZWQKWyAgICAwLjU3MDg5N10gc3lzdGVtIDAwOjA1OiBbbWVtIDB4ZmVj
MDAwMDAtMHhmZWMwMGZmZl0gY291bGQgbm90IGJlIHJlc2VydmVkClsgICAgMC41NzEwMDJdIHN5
c3RlbSAwMDowNTogW21lbSAweGZlZTAwMDAwLTB4ZmVlMDBmZmZdIGhhcyBiZWVuIHJlc2VydmVk
ClsgICAgMC41NzEzMzRdIHN5c3RlbSAwMDowNjogW21lbSAweGUwMDAwMDAwLTB4ZWZmZmZmZmZd
IGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC41NzIwMDVdIHBucCAwMDowNzogZGlzYWJsaW5nIFtt
ZW0gMHgwMDBjMDAwMC0weDAwMGNmZmZmXSBiZWNhdXNlIGl0IG92ZXJsYXBzIDAwMDA6MDA6MDIu
MCBCQVIgNiBbbWVtIDB4MDAwYzAwMDAtMHgwMDBkZmZmZl0KWyAgICAwLjU3MjI3Nl0gc3lzdGVt
IDAwOjA3OiBbbWVtIDB4MDAwMDAwMDAtMHgwMDA5ZmZmZl0gY291bGQgbm90IGJlIHJlc2VydmVk
ClsgICAgMC41NzIzNzNdIHN5c3RlbSAwMDowNzogW21lbSAweDAwMGUwMDAwLTB4MDAwZmZmZmZd
IGNvdWxkIG5vdCBiZSByZXNlcnZlZApbICAgIDAuNTcyNDY2XSBzeXN0ZW0gMDA6MDc6IFttZW0g
MHgwMDEwMDAwMC0weDdmNmZmZmZmXSBjb3VsZCBub3QgYmUgcmVzZXJ2ZWQKWyAgICAwLjU3MjU4
MF0gc3lzdGVtIDAwOjA3OiBbbWVtIDB4ZmVkOTAwMDAtMHhmZmZmZmZmZl0gY291bGQgbm90IGJl
IHJlc2VydmVkClsgICAgMC41NzMyMjZdIHBucDogUG5QIEFDUEk6IGZvdW5kIDggZGV2aWNlcwpb
ICAgIDAuNTg2MzY1XSBjbG9ja3NvdXJjZTogYWNwaV9wbTogbWFzazogMHhmZmZmZmYgbWF4X2N5
Y2xlczogMHhmZmZmZmYsIG1heF9pZGxlX25zOiAyMDg1NzAxMDI0IG5zClsgICAgMC41ODY4MDJd
IE5FVDogUmVnaXN0ZXJlZCBQRl9JTkVUIHByb3RvY29sIGZhbWlseQpbICAgIDAuNTg3MTI2XSBJ
UCBpZGVudHMgaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2OCAob3JkZXI6IDYsIDI2MjE0NCBieXRl
cywgbGluZWFyKQpbICAgIDAuNTkwNzQ2XSB0Y3BfbGlzdGVuX3BvcnRhZGRyX2hhc2ggaGFzaCB0
YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRlcjogMiwgMTYzODQgYnl0ZXMsIGxpbmVhcikKWyAgICAw
LjU5MTAxMF0gVGFibGUtcGVydHVyYiBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjog
NiwgMjYyMTQ0IGJ5dGVzLCBsaW5lYXIpClsgICAgMC41OTEyMDZdIFRDUCBlc3RhYmxpc2hlZCBo
YXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNSwgMTMxMDcyIGJ5dGVzLCBsaW5lYXIp
ClsgICAgMC41OTE3MzddIFRDUCBiaW5kIGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVy
OiA3LCA1MjQyODggYnl0ZXMsIGxpbmVhcikKWyAgICAwLjU5MjEyM10gVENQOiBIYXNoIHRhYmxl
cyBjb25maWd1cmVkIChlc3RhYmxpc2hlZCAxNjM4NCBiaW5kIDE2Mzg0KQpbICAgIDAuNTkyNjky
XSBNUFRDUCB0b2tlbiBoYXNoIHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAzLCA0OTE1MiBi
eXRlcywgbGluZWFyKQpbICAgIDAuNTkzMDM2XSBVRFAgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0
IChvcmRlcjogMywgMzI3NjggYnl0ZXMsIGxpbmVhcikKWyAgICAwLjU5MzE3NV0gVURQLUxpdGUg
aGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRlcjogMywgMzI3NjggYnl0ZXMsIGxpbmVhcikK
WyAgICAwLjU5MzQ3M10gTkVUOiBSZWdpc3RlcmVkIFBGX1VOSVgvUEZfTE9DQUwgcHJvdG9jb2wg
ZmFtaWx5ClsgICAgMC41OTM2MTBdIE5FVDogUmVnaXN0ZXJlZCBQRl9YRFAgcHJvdG9jb2wgZmFt
aWx5ClsgICAgMC41OTM3MjNdIHBjaSAwMDAwOjAwOjFjLjA6IGJyaWRnZSB3aW5kb3cgW2lvICAw
eDEwMDAtMHgwZmZmXSB0byBbYnVzIDA0XSBhZGRfc2l6ZSAxMDAwClsgICAgMC41OTM4NDldIHBj
aSAwMDAwOjAwOjFjLjA6IGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMTAwMDAwLTB4MDAwZmZmZmYg
NjRiaXQgcHJlZl0gdG8gW2J1cyAwNF0gYWRkX3NpemUgMjAwMDAwIGFkZF9hbGlnbiAxMDAwMDAK
WyAgICAwLjU5Mzk4M10gcGNpIDAwMDA6MDA6MWMuMDogYnJpZGdlIHdpbmRvdyBbbWVtIDB4MDAx
MDAwMDAtMHgwMDBmZmZmZl0gdG8gW2J1cyAwNF0gYWRkX3NpemUgMjAwMDAwIGFkZF9hbGlnbiAx
MDAwMDAKWyAgICAwLjU5NDExMl0gcGNpIDAwMDA6MDA6MWMuMTogYnJpZGdlIHdpbmRvdyBbaW8g
IDB4MTAwMC0weDBmZmZdIHRvIFtidXMgMDItMDNdIGFkZF9zaXplIDEwMDAKWyAgICAwLjU5NDIz
NV0gcGNpIDAwMDA6MDA6MWMuMzogYnJpZGdlIHdpbmRvdyBbbWVtIDB4MDAxMDAwMDAtMHgwMDBm
ZmZmZiA2NGJpdCBwcmVmXSB0byBbYnVzIDAxXSBhZGRfc2l6ZSAyMDAwMDAgYWRkX2FsaWduIDEw
MDAwMApbICAgIDAuNTk0MzkzXSBwY2kgMDAwMDowMDoxYy4wOiBCQVIgMTQ6IGFzc2lnbmVkIFtt
ZW0gMHg4MDAwMDAwMC0weDgwMWZmZmZmXQpbICAgIDAuNTk0NDk1XSBwY2kgMDAwMDowMDoxYy4w
OiBCQVIgMTU6IGFzc2lnbmVkIFttZW0gMHg4MDIwMDAwMC0weDgwM2ZmZmZmIDY0Yml0IHByZWZd
ClsgICAgMC41OTQ2MjBdIHBjaSAwMDAwOjAwOjFjLjM6IEJBUiAxNTogYXNzaWduZWQgW21lbSAw
eDgwNDAwMDAwLTB4ODA1ZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjU5NDc0MV0gcGNpIDAwMDA6
MDA6MWMuMDogQkFSIDEzOiBhc3NpZ25lZCBbaW8gIDB4MTAwMC0weDFmZmZdClsgICAgMC41OTQ4
MzFdIHBjaSAwMDAwOjAwOjFjLjE6IEJBUiAxMzogYXNzaWduZWQgW2lvICAweDIwMDAtMHgyZmZm
XQpbICAgIDAuNTk0OTM3XSBwY2kgMDAwMDowMDoxYy4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDRd
ClsgICAgMC41OTUwMjRdIHBjaSAwMDAwOjAwOjFjLjA6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4
MTAwMC0weDFmZmZdClsgICAgMC41OTUxMTVdIHBjaSAwMDAwOjAwOjFjLjA6ICAgYnJpZGdlIHdp
bmRvdyBbbWVtIDB4ODAwMDAwMDAtMHg4MDFmZmZmZl0KWyAgICAwLjU5NTIwNl0gcGNpIDAwMDA6
MDA6MWMuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg4MDIwMDAwMC0weDgwM2ZmZmZmIDY0Yml0
IHByZWZdClsgICAgMC41OTUzMjZdIHBjaSAwMDAwOjAwOjFjLjE6IFBDSSBicmlkZ2UgdG8gW2J1
cyAwMi0wM10KWyAgICAwLjU5NTQxMF0gcGNpIDAwMDA6MDA6MWMuMTogICBicmlkZ2Ugd2luZG93
IFtpbyAgMHgyMDAwLTB4MmZmZl0KWyAgICAwLjU5NTUwMF0gcGNpIDAwMDA6MDA6MWMuMTogICBi
cmlkZ2Ugd2luZG93IFttZW0gMHhmODAwMDAwMC0weGZiZmZmZmZmXQpbICAgIDAuNTk1NTkyXSBw
Y2kgMDAwMDowMDoxYy4xOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGYwMDAwMDAwLTB4ZjZmZmZm
ZmYgNjRiaXQgcHJlZl0KWyAgICAwLjU5NTcxM10gcGNpIDAwMDA6MDA6MWMuMzogUENJIGJyaWRn
ZSB0byBbYnVzIDAxXQpbICAgIDAuNTk1Nzk2XSBwY2kgMDAwMDowMDoxYy4zOiAgIGJyaWRnZSB3
aW5kb3cgW2lvICAweGUwMDAtMHhlZmZmXQpbICAgIDAuNTk1ODg1XSBwY2kgMDAwMDowMDoxYy4z
OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGY3ZjAwMDAwLTB4ZjdmZmZmZmZdClsgICAgMC41OTU5
NzddIHBjaSAwMDAwOjAwOjFjLjM6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ODA0MDAwMDAtMHg4
MDVmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNTk2MDk4XSBwY2kgMDAwMDowMDoxZS4wOiBQQ0kg
YnJpZGdlIHRvIFtidXMgMDVdClsgICAgMC41OTYxOTFdIHBjaV9idXMgMDAwMDowMDogcmVzb3Vy
Y2UgNCBbaW8gIDB4MDAwMC0weDBjZjcgd2luZG93XQpbICAgIDAuNTk2MjgwXSBwY2lfYnVzIDAw
MDA6MDA6IHJlc291cmNlIDUgW2lvICAweDBkMDAtMHhmZmZmIHdpbmRvd10KWyAgICAwLjU5NjM2
Nl0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA2IFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZm
IHdpbmRvd10KWyAgICAwLjU5NjQ1Nl0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA3IFttZW0g
MHgwMDBkMDAwMC0weDAwMGRmZmZmIHdpbmRvd10KWyAgICAwLjU5NjU2NF0gcGNpX2J1cyAwMDAw
OjAwOiByZXNvdXJjZSA4IFttZW0gMHg3ZjcwMDAwMC0weGZlZDhmZmZmIHdpbmRvd10KWyAgICAw
LjU5NjY1Nl0gcGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSAwIFtpbyAgMHgxMDAwLTB4MWZmZl0K
WyAgICAwLjU5Njc0MV0gcGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSAxIFttZW0gMHg4MDAwMDAw
MC0weDgwMWZmZmZmXQpbICAgIDAuNTk2ODI5XSBwY2lfYnVzIDAwMDA6MDQ6IHJlc291cmNlIDIg
W21lbSAweDgwMjAwMDAwLTB4ODAzZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjU5Njk0M10gcGNp
X2J1cyAwMDAwOjAyOiByZXNvdXJjZSAwIFtpbyAgMHgyMDAwLTB4MmZmZl0KWyAgICAwLjU5NzAy
OF0gcGNpX2J1cyAwMDAwOjAyOiByZXNvdXJjZSAxIFttZW0gMHhmODAwMDAwMC0weGZiZmZmZmZm
XQpbICAgIDAuNTk3MTE1XSBwY2lfYnVzIDAwMDA6MDI6IHJlc291cmNlIDIgW21lbSAweGYwMDAw
MDAwLTB4ZjZmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjU5NzIzMF0gcGNpX2J1cyAwMDAwOjAx
OiByZXNvdXJjZSAwIFtpbyAgMHhlMDAwLTB4ZWZmZl0KWyAgICAwLjU5NzMxNV0gcGNpX2J1cyAw
MDAwOjAxOiByZXNvdXJjZSAxIFttZW0gMHhmN2YwMDAwMC0weGY3ZmZmZmZmXQpbICAgIDAuNTk3
NDAyXSBwY2lfYnVzIDAwMDA6MDE6IHJlc291cmNlIDIgW21lbSAweDgwNDAwMDAwLTB4ODA1ZmZm
ZmYgNjRiaXQgcHJlZl0KWyAgICAwLjU5NzUxN10gcGNpX2J1cyAwMDAwOjA1OiByZXNvdXJjZSA0
IFtpbyAgMHgwMDAwLTB4MGNmNyB3aW5kb3ddClsgICAgMC41OTc2MDRdIHBjaV9idXMgMDAwMDow
NTogcmVzb3VyY2UgNSBbaW8gIDB4MGQwMC0weGZmZmYgd2luZG93XQpbICAgIDAuNTk3NjkxXSBw
Y2lfYnVzIDAwMDA6MDU6IHJlc291cmNlIDYgW21lbSAweDAwMGEwMDAwLTB4MDAwYmZmZmYgd2lu
ZG93XQpbICAgIDAuNTk3NzgxXSBwY2lfYnVzIDAwMDA6MDU6IHJlc291cmNlIDcgW21lbSAweDAw
MGQwMDAwLTB4MDAwZGZmZmYgd2luZG93XQpbICAgIDAuNTk3ODcxXSBwY2lfYnVzIDAwMDA6MDU6
IHJlc291cmNlIDggW21lbSAweDdmNzAwMDAwLTB4ZmVkOGZmZmYgd2luZG93XQpbICAgIDAuNTk5
NTg5XSBQQ0k6IENMUyAzMiBieXRlcywgZGVmYXVsdCA2NApbICAgIDAuNjAwMDIxXSBUcnlpbmcg
dG8gdW5wYWNrIHJvb3RmcyBpbWFnZSBhcyBpbml0cmFtZnMuLi4KWyAgICAwLjYwMjM3N10gSW5p
dGlhbGlzZSBzeXN0ZW0gdHJ1c3RlZCBrZXlyaW5ncwpbICAgIDAuNjAyNTYxXSBLZXkgdHlwZSBi
bGFja2xpc3QgcmVnaXN0ZXJlZApbICAgIDAuNjAzMTQ2XSB3b3JraW5nc2V0OiB0aW1lc3RhbXBf
Yml0cz0zNiBtYXhfb3JkZXI9MTkgYnVja2V0X29yZGVyPTAKWyAgICAwLjYxNTQ4NV0gemJ1ZDog
bG9hZGVkClsgICAgMC42MTcyNzFdIGludGVncml0eTogUGxhdGZvcm0gS2V5cmluZyBpbml0aWFs
aXplZApbICAgIDAuNjE3NDE4XSBpbnRlZ3JpdHk6IE1hY2hpbmUga2V5cmluZyBpbml0aWFsaXpl
ZApbICAgIDAuNjE3NTI3XSBLZXkgdHlwZSBhc3ltbWV0cmljIHJlZ2lzdGVyZWQKWyAgICAwLjYx
NzYyNV0gQXN5bW1ldHJpYyBrZXkgcGFyc2VyICd4NTA5JyByZWdpc3RlcmVkClsgICAgMS42MDgx
ODVdIHRzYzogUmVmaW5lZCBUU0MgY2xvY2tzb3VyY2UgY2FsaWJyYXRpb246IDE2NjYuNDc3IE1I
egpbICAgIDEuNjA4MzE1XSBjbG9ja3NvdXJjZTogdHNjOiBtYXNrOiAweGZmZmZmZmZmZmZmZmZm
ZmYgbWF4X2N5Y2xlczogMHgxODA1NzM1ODljYiwgbWF4X2lkbGVfbnM6IDQ0MDc5NTIyNDI4NiBu
cwpbICAgIDEuNjA4Nzk5XSBjbG9ja3NvdXJjZTogU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2UgdHNj
ClsgICAgMy42Nzg0NDVdIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogNjgyMjRLClsgICAgMy43MDAz
OTZdIGFsZzogc2VsZi10ZXN0cyBmb3IgQ1RSLUtERiAoaG1hYyhzaGEyNTYpKSBwYXNzZWQKWyAg
ICAzLjcwMDYwM10gQmxvY2sgbGF5ZXIgU0NTSSBnZW5lcmljIChic2cpIGRyaXZlciB2ZXJzaW9u
IDAuNCBsb2FkZWQgKG1ham9yIDI0OCkKWyAgICAzLjcwMDkzNl0gaW8gc2NoZWR1bGVyIG1xLWRl
YWRsaW5lIHJlZ2lzdGVyZWQKWyAgICAzLjcwNTcwNl0gcGNpZXBvcnQgMDAwMDowMDoxYy4wOiBl
bmFibGluZyBkZXZpY2UgKDAxMDQgLT4gMDEwNykKWyAgICAzLjcwNjExMl0gcGNpZXBvcnQgMDAw
MDowMDoxYy4xOiBlbmFibGluZyBkZXZpY2UgKDAxMDYgLT4gMDEwNykKWyAgICAzLjcwNjgxNV0g
c2hwY2hwOiBTdGFuZGFyZCBIb3QgUGx1ZyBQQ0kgQ29udHJvbGxlciBEcml2ZXIgdmVyc2lvbjog
MC40ClsgICAgMy43MDY5ODVdIHRzYzogTWFya2luZyBUU0MgdW5zdGFibGUgZHVlIHRvIFRTQyBo
YWx0cyBpbiBpZGxlIHN0YXRlcyBkZWVwZXIgdGhhbiBDMgpbICAgIDMuNzA3NDQyXSBjbG9ja3Nv
dXJjZTogQ2hlY2tpbmcgY2xvY2tzb3VyY2UgdHNjIHN5bmNocm9uaXphdGlvbiBmcm9tIENQVSAw
IHRvIENQVXMgMS4KWyAgICAzLjcwNzYyOV0gY2xvY2tzb3VyY2U6IFN3aXRjaGVkIHRvIGNsb2Nr
c291cmNlIGhwZXQKWyAgICAzLjcyNDI2NV0gdGhlcm1hbCBMTlhUSEVSTTowMDogcmVnaXN0ZXJl
ZCBhcyB0aGVybWFsX3pvbmUwClsgICAgMy43MjQzNjVdIEFDUEk6IHRoZXJtYWw6IFRoZXJtYWwg
Wm9uZSBbVFowMF0gKDU0IEMpClsgICAgMy43MjQ5NzldIFNlcmlhbDogODI1MC8xNjU1MCBkcml2
ZXIsIDQgcG9ydHMsIElSUSBzaGFyaW5nIGVuYWJsZWQKWyAgICAzLjcyNjk5MV0gTGludXggYWdw
Z2FydCBpbnRlcmZhY2UgdjAuMTAzClsgICAgMy43Mjc0NTJdIEFNRC1WaTogQU1EIElPTU1VdjIg
ZnVuY3Rpb25hbGl0eSBub3QgYXZhaWxhYmxlIG9uIHRoaXMgc3lzdGVtIC0gVGhpcyBpcyBub3Qg
YSBidWcuClsgICAgMy43Mjg0OTddIGk4MDQyOiBQTlA6IFBTLzIgQ29udHJvbGxlciBbUE5QMDMw
MzpQUzJLLFBOUDBmMTM6UFMyTV0gYXQgMHg2MCwweDY0IGlycSAxLDEyClsgICAgMy43NDYxOTdd
IHNlcmlvOiBpODA0MiBLQkQgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEKWyAgICAzLjc0NjMwM10g
c2VyaW86IGk4MDQyIEFVWCBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMTIKWyAgICAzLjc0Njk3NV0g
bW91c2VkZXY6IFBTLzIgbW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1pY2UKWyAgICAzLjc0
NzQ1N10gcnRjX2Ntb3MgMDA6MDE6IFJUQyBjYW4gd2FrZSBmcm9tIFM0ClsgICAgMy43NDgyMDld
IHJ0Y19jbW9zIDAwOjAxOiByZWdpc3RlcmVkIGFzIHJ0YzAKWyAgICAzLjc0ODMzOV0gcnRjX2Nt
b3MgMDA6MDE6IHNldHRpbmcgc3lzdGVtIGNsb2NrIHRvIDIwMjUtMTAtMTdUMjA6MzQ6NDQgVVRD
ICgxNzYwNzMzMjg0KQpbICAgIDMuNzQ4NTUzXSBydGNfY21vcyAwMDowMTogYWxhcm1zIHVwIHRv
IG9uZSBtb250aCwgeTNrLCAxMTQgYnl0ZXMgbnZyYW0sIGhwZXQgaXJxcwpbICAgIDMuNzQ4Nzk5
XSBpbnRlbF9wc3RhdGU6IENQVSBtb2RlbCBub3Qgc3VwcG9ydGVkClsgICAgMy43NDg5NDNdIGxl
ZHRyaWctY3B1OiByZWdpc3RlcmVkIHRvIGluZGljYXRlIGFjdGl2aXR5IG9uIENQVXMKWyAgICAz
Ljc2NDY2Ml0gaW5wdXQ6IEFUIFRyYW5zbGF0ZWQgU2V0IDIga2V5Ym9hcmQgYXMgL2RldmljZXMv
cGxhdGZvcm0vaTgwNDIvc2VyaW8wL2lucHV0L2lucHV0MApbICAgIDMuNzkzOTkxXSBORVQ6IFJl
Z2lzdGVyZWQgUEZfSU5FVDYgcHJvdG9jb2wgZmFtaWx5ClsgICAgMy44MTU4NjZdIFNlZ21lbnQg
Um91dGluZyB3aXRoIElQdjYKWyAgICAzLjgxNjAwOV0gSW4tc2l0dSBPQU0gKElPQU0pIHdpdGgg
SVB2NgpbICAgIDMuODE2MjEyXSBtaXA2OiBNb2JpbGUgSVB2NgpbICAgIDMuODE2MzE5XSBORVQ6
IFJlZ2lzdGVyZWQgUEZfUEFDS0VUIHByb3RvY29sIGZhbWlseQpbICAgIDMuODE2NTc1XSBtcGxz
X2dzbzogTVBMUyBHU08gc3VwcG9ydApbICAgIDMuODE3MjU1XSBtaWNyb2NvZGU6IHNpZz0weDEw
NmNhLCBwZj0weDQsIHJldmlzaW9uPTB4MTA3ClsgICAgMy44MTczNjldIG1pY3JvY29kZTogTWlj
cm9jb2RlIFVwZGF0ZSBEcml2ZXI6IHYyLjIuClsgICAgMy44MTczODhdIElQSSBzaG9ydGhhbmQg
YnJvYWRjYXN0OiBlbmFibGVkClsgICAgMy44MTgxMzZdIHJlZ2lzdGVyZWQgdGFza3N0YXRzIHZl
cnNpb24gMQpbICAgIDMuODE4MjQ3XSBMb2FkaW5nIGNvbXBpbGVkLWluIFguNTA5IGNlcnRpZmlj
YXRlcwpbICAgIDMuOTg3NzMxXSBMb2FkZWQgWC41MDkgY2VydCAnQnVpbGQgdGltZSBhdXRvZ2Vu
ZXJhdGVkIGtlcm5lbCBrZXk6IDY5ZjBhOTM0NTdjN2E1YjM0Njg4ZmJjNWMwN2YxODE5MzQ4NjQz
MzUnClsgICAgMy45ODg5ODldIHpzd2FwOiBsb2FkZWQgdXNpbmcgcG9vbCBsem8vemJ1ZApbICAg
IDMuOTg5ODM1XSBLZXkgdHlwZSAuZnNjcnlwdCByZWdpc3RlcmVkClsgICAgMy45ODk5MjZdIEtl
eSB0eXBlIGZzY3J5cHQtcHJvdmlzaW9uaW5nIHJlZ2lzdGVyZWQKWyAgICA0LjAxMDQzMV0gS2V5
IHR5cGUgZW5jcnlwdGVkIHJlZ2lzdGVyZWQKWyAgICA0LjAxMDU0NF0gQXBwQXJtb3I6IEFwcEFy
bW9yIHNoYTEgcG9saWN5IGhhc2hpbmcgZW5hYmxlZApbICAgIDQuMDEwNjcxXSBpbWE6IE5vIFRQ
TSBjaGlwIGZvdW5kLCBhY3RpdmF0aW5nIFRQTS1ieXBhc3MhClsgICAgNC4wMTA3NThdIGltYTog
QWxsb2NhdGVkIGhhc2ggYWxnb3JpdGhtOiBzaGEyNTYKWyAgICA0LjAxMDg5Ml0gaW1hOiBObyBh
cmNoaXRlY3R1cmUgcG9saWNpZXMgZm91bmQKWyAgICA0LjAxMTAzMl0gZXZtOiBJbml0aWFsaXNp
bmcgRVZNIGV4dGVuZGVkIGF0dHJpYnV0ZXM6ClsgICAgNC4wMTExMTRdIGV2bTogc2VjdXJpdHku
c2VsaW51eApbICAgIDQuMDExMTg4XSBldm06IHNlY3VyaXR5LlNNQUNLNjQgKGRpc2FibGVkKQpb
ICAgIDQuMDExMjY0XSBldm06IHNlY3VyaXR5LlNNQUNLNjRFWEVDIChkaXNhYmxlZCkKWyAgICA0
LjAxMTM0MV0gZXZtOiBzZWN1cml0eS5TTUFDSzY0VFJBTlNNVVRFIChkaXNhYmxlZCkKWyAgICA0
LjAxMTQyMF0gZXZtOiBzZWN1cml0eS5TTUFDSzY0TU1BUCAoZGlzYWJsZWQpClsgICAgNC4wMTE0
OTddIGV2bTogc2VjdXJpdHkuYXBwYXJtb3IKWyAgICA0LjAxMTU3MF0gZXZtOiBzZWN1cml0eS5p
bWEKWyAgICA0LjAxMTY0MF0gZXZtOiBzZWN1cml0eS5jYXBhYmlsaXR5ClsgICAgNC4wMTE3MTJd
IGV2bTogSE1BQyBhdHRyczogMHgxClsgICAgNC45MDk3NzFdIFVuc3RhYmxlIGNsb2NrIGRldGVj
dGVkLCBzd2l0Y2hpbmcgZGVmYXVsdCB0cmFjaW5nIGNsb2NrIHRvICJnbG9iYWwiCiAgICAgICAg
ICAgICAgIElmIHlvdSB3YW50IHRvIGtlZXAgdXNpbmcgdGhlIGxvY2FsIGNsb2NrLCB0aGVuIGFk
ZDoKICAgICAgICAgICAgICAgICAidHJhY2VfY2xvY2s9bG9jYWwiCiAgICAgICAgICAgICAgIG9u
IHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lClsgICAgNC45MTA5NzJdIGNsazogRGlzYWJsaW5nIHVu
dXNlZCBjbG9ja3MKWyAgICA0LjkxNTg3MF0gRnJlZWluZyB1bnVzZWQgZGVjcnlwdGVkIG1lbW9y
eTogMjAzNksKWyAgICA0LjkxODY0M10gRnJlZWluZyB1bnVzZWQga2VybmVsIGltYWdlIChpbml0
bWVtKSBtZW1vcnk6IDI4MTZLClsgICAgNC45MTg3NTJdIFdyaXRlIHByb3RlY3RpbmcgdGhlIGtl
cm5lbCByZWFkLW9ubHkgZGF0YTogMjY2MjRrClsgICAgNC45MjE0NzddIEZyZWVpbmcgdW51c2Vk
IGtlcm5lbCBpbWFnZSAodGV4dC9yb2RhdGEgZ2FwKSBtZW1vcnk6IDIwNDBLClsgICAgNC45MjI2
NjJdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSAocm9kYXRhL2RhdGEgZ2FwKSBtZW1vcnk6
IDExMzZLClsgICAgNC45ODg5ODFdIHg4Ni9tbTogQ2hlY2tlZCBXK1ggbWFwcGluZ3M6IHBhc3Nl
ZCwgbm8gVytYIHBhZ2VzIGZvdW5kLgpbICAgIDQuOTg5MTI4XSBSdW4gL2luaXQgYXMgaW5pdCBw
cm9jZXNzClsgICAgNC45ODkyMTNdICAgd2l0aCBhcmd1bWVudHM6ClsgICAgNC45ODkyMTldICAg
ICAvaW5pdApbICAgIDQuOTg5MjIyXSAgIHdpdGggZW52aXJvbm1lbnQ6ClsgICAgNC45ODkyMjVd
ICAgICBIT01FPS8KWyAgICA0Ljk4OTIyOV0gICAgIFRFUk09bGludXgKWyAgICA0Ljk4OTIzMl0g
ICAgIEJPT1RfSU1BR0U9L3ZtbGludXotNi4xLjAtNDAtYW1kNjQKWyAgICA1Ljg4NzgzNF0gaW5w
dXQ6IExpZCBTd2l0Y2ggYXMgL2RldmljZXMvTE5YU1lTVE06MDAvTE5YU1lCVVM6MDAvUE5QMEMw
RDowMC9pbnB1dC9pbnB1dDIKWyAgICA1Ljg5NjE2OF0gQUNQSTogYnV0dG9uOiBMaWQgU3dpdGNo
IFtMSURdClsgICAgNS44OTcyNDldIGlucHV0OiBTbGVlcCBCdXR0b24gYXMgL2RldmljZXMvTE5Y
U1lTVE06MDAvTE5YU1lCVVM6MDAvUE5QMEMwRTowMC9pbnB1dC9pbnB1dDMKWyAgICA1Ljg5NzU2
Nl0gQUNQSTogYnV0dG9uOiBTbGVlcCBCdXR0b24gW1NMUEJdClsgICAgNS44OTc5NzZdIGlucHV0
OiBQb3dlciBCdXR0b24gYXMgL2RldmljZXMvTE5YU1lTVE06MDAvTE5YU1lCVVM6MDAvUE5QMEMw
QzowMC9pbnB1dC9pbnB1dDQKWyAgICA1Ljg5ODI5Ml0gQUNQSTogYnV0dG9uOiBQb3dlciBCdXR0
b24gW1BXUkJdClsgICAgNS44OTg3NDldIGlucHV0OiBQb3dlciBCdXR0b24gYXMgL2RldmljZXMv
TE5YU1lTVE06MDAvTE5YUFdSQk46MDAvaW5wdXQvaW5wdXQ1ClsgICAgNS45MTIzNjVdIEFDUEk6
IGJ1dHRvbjogUG93ZXIgQnV0dG9uIFtQV1JGXQpbICAgIDYuMDI0ODA5XSBBQ1BJOiBiYXR0ZXJ5
OiBTbG90IFtCQVQwXSAoYmF0dGVyeSBwcmVzZW50KQpbICAgIDYuMTU1MjQ0XSBBQ1BJIFdhcm5p
bmc6IFN5c3RlbUlPIHJhbmdlIDB4MDAwMDAwMDAwMDAwMDgyOC0weDAwMDAwMDAwMDAwMDA4MkYg
Y29uZmxpY3RzIHdpdGggT3BSZWdpb24gMHgwMDAwMDAwMDAwMDAwODAwLTB4MDAwMDAwMDAwMDAw
MDg3RiAoXFBNSU8pICgyMDIyMDMzMS91dGFkZHJlc3MtMjA0KQpbICAgIDYuMTU1NDUyXSBBQ1BJ
IFdhcm5pbmc6IFN5c3RlbUlPIHJhbmdlIDB4MDAwMDAwMDAwMDAwMDgyOC0weDAwMDAwMDAwMDAw
MDA4MkYgY29uZmxpY3RzIHdpdGggT3BSZWdpb24gMHgwMDAwMDAwMDAwMDAwODI4LTB4MDAwMDAw
MDAwMDAwMDgyRiAoXF9TQi5QQ0kwLlNCUkcuSUVMSy5HUFNFKSAoMjAyMjAzMzEvdXRhZGRyZXNz
LTIwNCkKWyAgICA2LjE1NTY0Nl0gQUNQSTogT1NMOiBSZXNvdXJjZSBjb25mbGljdDsgQUNQSSBz
dXBwb3J0IG1pc3NpbmcgZnJvbSBkcml2ZXI/ClsgICAgNi4xNTU3NDNdIEFDUEkgV2FybmluZzog
U3lzdGVtSU8gcmFuZ2UgMHgwMDAwMDAwMDAwMDAwNEIwLTB4MDAwMDAwMDAwMDAwMDRCRiBjb25m
bGljdHMgd2l0aCBPcFJlZ2lvbiAweDAwMDAwMDAwMDAwMDA0ODAtMHgwMDAwMDAwMDAwMDAwNEJG
IChcX1NCLlBDSTAuU0JSRy5HUEJYKSAoMjAyMjAzMzEvdXRhZGRyZXNzLTIwNCkKWyAgICA2LjE1
NTkzNV0gQUNQSTogT1NMOiBSZXNvdXJjZSBjb25mbGljdDsgQUNQSSBzdXBwb3J0IG1pc3Npbmcg
ZnJvbSBkcml2ZXI/ClsgICAgNi4xNTYwMjldIEFDUEkgV2FybmluZzogU3lzdGVtSU8gcmFuZ2Ug
MHgwMDAwMDAwMDAwMDAwNDgwLTB4MDAwMDAwMDAwMDAwMDRBRiBjb25mbGljdHMgd2l0aCBPcFJl
Z2lvbiAweDAwMDAwMDAwMDAwMDA0ODAtMHgwMDAwMDAwMDAwMDAwNEJGIChcX1NCLlBDSTAuU0JS
Ry5HUEJYKSAoMjAyMjAzMzEvdXRhZGRyZXNzLTIwNCkKWyAgICA2LjE1NjMwMl0gQUNQSTogT1NM
OiBSZXNvdXJjZSBjb25mbGljdDsgQUNQSSBzdXBwb3J0IG1pc3NpbmcgZnJvbSBkcml2ZXI/Clsg
ICAgNi4xNTY0MDNdIGxwY19pY2g6IFJlc291cmNlIGNvbmZsaWN0KHMpIGZvdW5kIGFmZmVjdGlu
ZyBncGlvX2ljaApbICAgIDYuMTYwODQxXSBBQ1BJIFdhcm5pbmc6IFN5c3RlbUlPIHJhbmdlIDB4
MDAwMDAwMDAwMDAwMDQwMC0weDAwMDAwMDAwMDAwMDA0MUYgY29uZmxpY3RzIHdpdGggT3BSZWdp
b24gMHgwMDAwMDAwMDAwMDAwNDAwLTB4MDAwMDAwMDAwMDAwMDQwRiAoXFNNUkcpICgyMDIyMDMz
MS91dGFkZHJlc3MtMjA0KQpbICAgIDYuMTYxMDgxXSBBQ1BJIFdhcm5pbmc6IFN5c3RlbUlPIHJh
bmdlIDB4MDAwMDAwMDAwMDAwMDQwMC0weDAwMDAwMDAwMDAwMDA0MUYgY29uZmxpY3RzIHdpdGgg
T3BSZWdpb24gMHgwMDAwMDAwMDAwMDAwNDAwLTB4MDAwMDAwMDAwMDAwMDQwRiAoXF9TQi5QQ0kw
LlNCUkcuU01SRykgKDIwMjIwMzMxL3V0YWRkcmVzcy0yMDQpClsgICAgNi4xNjEyOTRdIEFDUEk6
IE9TTDogUmVzb3VyY2UgY29uZmxpY3Q7IEFDUEkgc3VwcG9ydCBtaXNzaW5nIGZyb20gZHJpdmVy
PwpbICAgIDYuMzE3OTEwXSBBQ1BJOiBidXMgdHlwZSBVU0IgcmVnaXN0ZXJlZApbICAgIDYuMzE4
MTc1XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYmZzClsgICAg
Ni4zMTgzMThdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgaHViClsg
ICAgNi4zMTg0NjFdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGRldmljZSBkcml2ZXIgdXNiClsg
ICAgNi41MzE3OTBdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMDogVUhDSSBIb3N0IENvbnRyb2xsZXIK
WyAgICA2LjUzMTkxN10gdWhjaV9oY2QgMDAwMDowMDoxZC4wOiBuZXcgVVNCIGJ1cyByZWdpc3Rl
cmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDEKWyAgICA2LjUzMjA1OF0gdWhjaV9oY2QgMDAwMDow
MDoxZC4wOiBkZXRlY3RlZCAyIHBvcnRzClsgICAgNi41NDgxNzZdIHVoY2lfaGNkIDAwMDA6MDA6
MWQuMDogaXJxIDIzLCBpbyBwb3J0IDB4MDAwMGQ0MDAKWyAgICA2LjU0ODYxOF0gdXNiIHVzYjE6
IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xZDZiLCBpZFByb2R1Y3Q9MDAwMSwgYmNk
RGV2aWNlPSA2LjAxClsgICAgNi41NDg3NzddIHVzYiB1c2IxOiBOZXcgVVNCIGRldmljZSBzdHJp
bmdzOiBNZnI9MywgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9MQpbICAgIDYuNTQ4OTI2XSB1c2Ig
dXNiMTogUHJvZHVjdDogVUhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICA2LjU0OTAyN10gdXNiIHVz
YjE6IE1hbnVmYWN0dXJlcjogTGludXggNi4xLjAtNDAtYW1kNjQgdWhjaV9oY2QKWyAgICA2LjU0
OTEzNl0gdXNiIHVzYjE6IFNlcmlhbE51bWJlcjogMDAwMDowMDoxZC4wClsgICAgNi41NTAwOTld
IGh1YiAxLTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgNi41NTAyNjNdIGh1YiAxLTA6MS4wOiAy
IHBvcnRzIGRldGVjdGVkClsgICAgNi41NjU2MTNdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMTogVUhD
SSBIb3N0IENvbnRyb2xsZXIKWyAgICA2LjU2NTc1N10gdWhjaV9oY2QgMDAwMDowMDoxZC4xOiBu
ZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDIKWyAgICA2LjU2NTkx
OV0gdWhjaV9oY2QgMDAwMDowMDoxZC4xOiBkZXRlY3RlZCAyIHBvcnRzClsgICAgNi41NjYxOTRd
IHVoY2lfaGNkIDAwMDA6MDA6MWQuMTogaXJxIDE5LCBpbyBwb3J0IDB4MDAwMGQ0ODAKWyAgICA2
LjU3MDUxNV0gdXNiIHVzYjI6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xZDZiLCBp
ZFByb2R1Y3Q9MDAwMSwgYmNkRGV2aWNlPSA2LjAxClsgICAgNi41NzA2ODJdIHVzYiB1c2IyOiBO
ZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MywgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9MQpb
ICAgIDYuNTcwODIzXSB1c2IgdXNiMjogUHJvZHVjdDogVUhDSSBIb3N0IENvbnRyb2xsZXIKWyAg
ICA2LjU3MDkyN10gdXNiIHVzYjI6IE1hbnVmYWN0dXJlcjogTGludXggNi4xLjAtNDAtYW1kNjQg
dWhjaV9oY2QKWyAgICA2LjU3MTAzNV0gdXNiIHVzYjI6IFNlcmlhbE51bWJlcjogMDAwMDowMDox
ZC4xClsgICAgNi41NzUyNzhdIGh1YiAyLTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgNi41NzY5
ODNdIGh1YiAyLTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkClsgICAgNi41ODYxNzldIFNDU0kgc3Vi
c3lzdGVtIGluaXRpYWxpemVkClsgICAgNi42OTIyOThdIGVoY2ktcGNpIDAwMDA6MDA6MWQuNzog
RUhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICA2LjY5MjQ0NV0gZWhjaS1wY2kgMDAwMDowMDoxZC43
OiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDMKWyAgICA2LjY5
MjYwM10gZWhjaS1wY2kgMDAwMDowMDoxZC43OiBkZWJ1ZyBwb3J0IDEKWyAgICA2LjY5NjcxNl0g
ZWhjaS1wY2kgMDAwMDowMDoxZC43OiBpcnEgMjMsIGlvIG1lbSAweGY3Y2Y3YzAwClsgICAgNi42
OTcyMTFdIEFDUEk6IGJ1cyB0eXBlIGRybV9jb25uZWN0b3IgcmVnaXN0ZXJlZApbICAgIDYuNzEy
MTU4XSBlaGNpLXBjaSAwMDAwOjAwOjFkLjc6IFVTQiAyLjAgc3RhcnRlZCwgRUhDSSAxLjAwClsg
ICAgNi43MTI2MjJdIHVzYiB1c2IzOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2
YiwgaWRQcm9kdWN0PTAwMDIsIGJjZERldmljZT0gNi4wMQpbICAgIDYuNzEyNzU3XSB1c2IgdXNi
MzogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTMsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVy
PTEKWyAgICA2LjcxMjg3OV0gdXNiIHVzYjM6IFByb2R1Y3Q6IEVIQ0kgSG9zdCBDb250cm9sbGVy
ClsgICAgNi43MTI5NjZdIHVzYiB1c2IzOiBNYW51ZmFjdHVyZXI6IExpbnV4IDYuMS4wLTQwLWFt
ZDY0IGVoY2lfaGNkClsgICAgNi43MTMwNTldIHVzYiB1c2IzOiBTZXJpYWxOdW1iZXI6IDAwMDA6
MDA6MWQuNwpbICAgIDYuNzE0MTUzXSBodWIgMy0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDYu
NzE0NTcyXSBodWIgMy0wOjEuMDogOCBwb3J0cyBkZXRlY3RlZApbICAgIDYuNzI0NTIyXSBhdGwx
YyAwMDAwOjAxOjAwLjAgZW5wMXMwOiByZW5hbWVkIGZyb20gZXRoMApbICAgIDYuNzI0ODMwXSBs
aWJhdGEgdmVyc2lvbiAzLjAwIGxvYWRlZC4KWyAgICA2Ljc0NDQ5OV0gaHViIDEtMDoxLjA6IFVT
QiBodWIgZm91bmQKWyAgICA2Ljc0NDk0NF0gaHViIDEtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQK
WyAgICA2Ljc1NjUxOV0gYWhjaSAwMDAwOjAwOjFmLjI6IHZlcnNpb24gMy4wClsgICAgNi43NTY5
ODddIGFoY2kgMDAwMDowMDoxZi4yOiBBSENJIDAwMDEuMDEwMCAzMiBzbG90cyA0IHBvcnRzIDMg
R2JwcyAweDEgaW1wbCBTQVRBIG1vZGUKWyAgICA2Ljc1NzEzMl0gYWhjaSAwMDAwOjAwOjFmLjI6
IGZsYWdzOiA2NGJpdCBuY3EgcG0gbGVkIGNsbyBwaW8gc2x1bSBwYXJ0IApbICAgIDYuNzYxMDk2
XSBzY3NpIGhvc3QwOiBhaGNpClsgICAgNi43NjM0NDRdIHNjc2kgaG9zdDE6IGFoY2kKWyAgICA2
Ljc3MjQ4OV0gaHViIDItMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgICA2Ljc3MjY2MV0gaHViIDIt
MDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKWyAgICA2Ljc3NTg4OV0gc2NzaSBob3N0MjogYWhjaQpb
ICAgIDYuNzc3MDU5XSB1aGNpX2hjZCAwMDAwOjAwOjFkLjI6IFVIQ0kgSG9zdCBDb250cm9sbGVy
ClsgICAgNi43NzcyMjRdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMjogbmV3IFVTQiBidXMgcmVnaXN0
ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciA0ClsgICAgNi43NzczOTBdIHVoY2lfaGNkIDAwMDA6
MDA6MWQuMjogZGV0ZWN0ZWQgMiBwb3J0cwpbICAgIDYuNzc3NjcwXSB1aGNpX2hjZCAwMDAwOjAw
OjFkLjI6IGlycSAxOCwgaW8gcG9ydCAweDAwMDBkODAwClsgICAgNi43NzgxNjJdIHVzYiB1c2I0
OiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2YiwgaWRQcm9kdWN0PTAwMDEsIGJj
ZERldmljZT0gNi4wMQpbICAgIDYuNzc4MzE4XSB1c2IgdXNiNDogTmV3IFVTQiBkZXZpY2Ugc3Ry
aW5nczogTWZyPTMsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTEKWyAgICA2Ljc3ODQ2NV0gdXNi
IHVzYjQ6IFByb2R1Y3Q6IFVIQ0kgSG9zdCBDb250cm9sbGVyClsgICAgNi43Nzg1NzNdIHVzYiB1
c2I0OiBNYW51ZmFjdHVyZXI6IExpbnV4IDYuMS4wLTQwLWFtZDY0IHVoY2lfaGNkClsgICAgNi43
Nzg2NzJdIHVzYiB1c2I0OiBTZXJpYWxOdW1iZXI6IDAwMDA6MDA6MWQuMgpbICAgIDYuNzc5NDk5
XSBodWIgNC0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDYuNzc5NjU3XSBodWIgNC0wOjEuMDog
MiBwb3J0cyBkZXRlY3RlZApbICAgIDYuNzgxMDAyXSB1aGNpX2hjZCAwMDAwOjAwOjFkLjM6IFVI
Q0kgSG9zdCBDb250cm9sbGVyClsgICAgNi43ODExMjddIHVoY2lfaGNkIDAwMDA6MDA6MWQuMzog
bmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciA1ClsgICAgNi43ODEy
NjRdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMzogZGV0ZWN0ZWQgMiBwb3J0cwpbICAgIDYuNzgxNDY2
XSB1aGNpX2hjZCAwMDAwOjAwOjFkLjM6IGlycSAxNiwgaW8gcG9ydCAweDAwMDBkODgwClsgICAg
Ni43ODE4NjBdIHVzYiB1c2I1OiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2Yiwg
aWRQcm9kdWN0PTAwMDEsIGJjZERldmljZT0gNi4wMQpbICAgIDYuNzgxOTk3XSB1c2IgdXNiNTog
TmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTMsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTEK
WyAgICA2Ljc4MjEyMF0gdXNiIHVzYjU6IFByb2R1Y3Q6IFVIQ0kgSG9zdCBDb250cm9sbGVyClsg
ICAgNi43ODIyMDhdIHVzYiB1c2I1OiBNYW51ZmFjdHVyZXI6IExpbnV4IDYuMS4wLTQwLWFtZDY0
IHVoY2lfaGNkClsgICAgNi43ODIzMDBdIHVzYiB1c2I1OiBTZXJpYWxOdW1iZXI6IDAwMDA6MDA6
MWQuMwpbICAgIDYuNzgzMDQyXSBodWIgNS0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDYuNzgz
MTc1XSBodWIgNS0wOjEuMDogMiBwb3J0cyBkZXRlY3RlZApbICAgIDYuNzkxNzMzXSBzY3NpIGhv
c3QzOiBhaGNpClsgICAgNi43OTIyMzRdIGF0YTE6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTEw
MjRAMHhmN2NmNzgwMCBwb3J0IDB4ZjdjZjc5MDAgaXJxIDI0ClsgICAgNi43OTIzODhdIGF0YTI6
IERVTU1ZClsgICAgNi43OTI0ODBdIGF0YTM6IERVTU1ZClsgICAgNi43OTI1NjddIGF0YTQ6IERV
TU1ZClsgICAgNi45NzYyMjNdIHVzYiAzLTY6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVt
YmVyIDIgdXNpbmcgZWhjaS1wY2kKWyAgICA3LjExMjIxMl0gYXRhMTogU0FUQSBsaW5rIHVwIDMu
MCBHYnBzIChTU3RhdHVzIDEyMyBTQ29udHJvbCAzMDApClsgICAgNy4xMTM0NjZdIGF0YTEuMDA6
IEFDUEkgY21kIGY1LzAwOjAwOjAwOjAwOjAwOmEwKFNFQ1VSSVRZIEZSRUVaRSBMT0NLKSBmaWx0
ZXJlZCBvdXQKWyAgICA3LjExMzc3MF0gYXRhMS4wMDogQVRBLTg6IEhpdGFjaGkgSFRTNTQ1MDI1
QjlBMzAwLCBQQjJPQzYwTiwgbWF4IFVETUEvMTMzClsgICAgNy4xMzY3NzldIHVzYiAzLTY6IE5l
dyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xM2QzLCBpZFByb2R1Y3Q9NTExMSwgYmNkRGV2
aWNlPSA5LjE3ClsgICAgNy4xMzY5MjFdIHVzYiAzLTY6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6
IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0yClsgICAgNy4xMzcwMTNdIHVzYiAzLTY6
IFByb2R1Y3Q6IFVTQjIuMCBVVkMgVkdBIFdlYkNhbQpbICAgIDcuMTM3MDk2XSB1c2IgMy02OiBN
YW51ZmFjdHVyZXI6IEltYWdlIFByb2Nlc3NvcgpbICAgIDcuMTM3MTc4XSB1c2IgMy02OiBTZXJp
YWxOdW1iZXI6IFVTQjIuMCBVVkMgVkdBIFdlYkNhbQpbICAgIDcuNDkwNjc2XSBwc21vdXNlIHNl
cmlvMTogc3luYXB0aWNzOiBxdWVyaWVkIG1heCBjb29yZGluYXRlczogeCBbLi41ODA4XSwgeSBb
Li40ODQyXQpbICAgIDcuNjAyNzAyXSBwc21vdXNlIHNlcmlvMTogc3luYXB0aWNzOiBUb3VjaHBh
ZCBtb2RlbDogMSwgZnc6IDcuMiwgaWQ6IDB4MWEwYjEsIGNhcHM6IDB4ZDA0NzMxLzB4YTQwMDAw
LzB4YTAwMDAvMHgwLCBib2FyZCBpZDogMCwgZncgaWQ6IDU3MDE2NgpbICAgIDcuNjczNDk0XSBp
bnB1dDogU3luUFMvMiBTeW5hcHRpY3MgVG91Y2hQYWQgYXMgL2RldmljZXMvcGxhdGZvcm0vaTgw
NDIvc2VyaW8xL2lucHV0L2lucHV0NgpbICAgIDguMDgyNzI0XSBhdGExLjAwOiA0ODgzOTcxNjgg
c2VjdG9ycywgbXVsdGkgMTY6IExCQTQ4IE5DUSAoZGVwdGggMzIpLCBBQQpbICAgIDguMDg0NDEx
XSBhdGExLjAwOiBBQ1BJIGNtZCBmNS8wMDowMDowMDowMDowMDphMChTRUNVUklUWSBGUkVFWkUg
TE9DSykgZmlsdGVyZWQgb3V0ClsgICAgOC4wODQ5OTZdIGF0YTEuMDA6IGNvbmZpZ3VyZWQgZm9y
IFVETUEvMTMzClsgICAgOC4wODU1ODJdIHNjc2kgMDowOjA6MDogRGlyZWN0LUFjY2VzcyAgICAg
QVRBICAgICAgSGl0YWNoaSBIVFM1NDUwMiBDNjBOIFBROiAwIEFOU0k6IDUKWyAgICA4LjI4NTUw
NF0gc2QgMDowOjA6MDogW3NkYV0gNDg4Mzk3MTY4IDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzOiAo
MjUwIEdCLzIzMyBHaUIpClsgICAgOC4yODU3MDNdIHNkIDA6MDowOjA6IFtzZGFdIFdyaXRlIFBy
b3RlY3QgaXMgb2ZmClsgICAgOC4yODU3OTddIHNkIDA6MDowOjA6IFtzZGFdIE1vZGUgU2Vuc2U6
IDAwIDNhIDAwIDAwClsgICAgOC4yODU5MDldIHNkIDA6MDowOjA6IFtzZGFdIFdyaXRlIGNhY2hl
OiBlbmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBPIG9yIEZV
QQpbICAgIDguMjg2MTkwXSBzZCAwOjA6MDowOiBbc2RhXSBQcmVmZXJyZWQgbWluaW11bSBJL08g
c2l6ZSA1MTIgYnl0ZXMKWyAgICA4LjMxOTg3Nl0gIHNkYTogc2RhMSBzZGEyIDwgc2RhNSA+Clsg
ICAgOC4zMjA4MTNdIHNkIDA6MDowOjA6IFtzZGFdIEF0dGFjaGVkIFNDU0kgZGlzawpbICAgIDku
NDI3ODkwXSBwY2kgMDAwMDowMDowMC4wOiBJbnRlbCBHTUEzMTUwIENoaXBzZXQKWyAgICA5LjQy
ODAxNl0gcGNpIDAwMDA6MDA6MDAuMDogZGV0ZWN0ZWQgZ3R0IHNpemU6IDUyNDI4OEsgdG90YWws
IDI2MjE0NEsgbWFwcGFibGUKWyAgICA5LjQyODI3MV0gcGNpIDAwMDA6MDA6MDAuMDogZGV0ZWN0
ZWQgODE5Mksgc3RvbGVuIG1lbW9yeQpbICAgIDkuNDI4NTgzXSBpOTE1IDAwMDA6MDA6MDIuMDog
dmdhYXJiOiBkZWFjdGl2YXRlIHZnYSBjb25zb2xlClsgICAgOS40Mjk2MjddIENvbnNvbGU6IHN3
aXRjaGluZyB0byBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1ClsgICAgOS40MzMzMDldIGk5MTUg
MDAwMDowMDowMi4wOiB2Z2FhcmI6IGNoYW5nZWQgVkdBIGRlY29kZXM6IG9sZGRlY29kZXM9aW8r
bWVtLGRlY29kZXM9aW8rbWVtOm93bnM9aW8rbWVtClsgICAgOS40NTk3MTZdIGk5MTUgMDAwMDow
MDowMi4wOiBbZHJtXSBJbml0aWFsaXplZCBvdmVybGF5IHN1cHBvcnQuClsgICAgOS40NjE4Mjhd
IGk5MTUgMDAwMDowMDowMi4wOiBbZHJtXSBTa2lwcGluZyBpbnRlbF9iYWNrbGlnaHQgcmVnaXN0
cmF0aW9uClsgICAgOS40NjIxMDddIFtkcm1dIEluaXRpYWxpemVkIGk5MTUgMS42LjAgMjAyMDEx
MDMgZm9yIDAwMDA6MDA6MDIuMCBvbiBtaW5vciAwClsgICAgOS40NjMxNTJdIEFDUEk6IHZpZGVv
OiBWaWRlbyBEZXZpY2UgW1ZHQV0gKG11bHRpLWhlYWQ6IHllcyAgcm9tOiBubyAgcG9zdDogbm8p
ClsgICAgOS40NjQxNDddIGlucHV0OiBWaWRlbyBCdXMgYXMgL2RldmljZXMvTE5YU1lTVE06MDAv
TE5YU1lCVVM6MDAvUE5QMEEwODowMC9MTlhWSURFTzowMC9pbnB1dC9pbnB1dDcKWyAgICA5LjQ3
Njk1OF0gYWNwaSBkZXZpY2U6MGQ6IHJlZ2lzdGVyZWQgYXMgY29vbGluZ19kZXZpY2UyClsgICAg
OS40OTMxNTldIGZiY29uOiBpOTE1ZHJtZmIgKGZiMCkgaXMgcHJpbWFyeSBkZXZpY2UKWyAgIDEw
LjIzMTIwNF0gQ29uc29sZTogc3dpdGNoaW5nIHRvIGNvbG91ciBmcmFtZSBidWZmZXIgZGV2aWNl
IDEyOHgzNwpbICAgMTAuMjUxNTE3XSBpOTE1IDAwMDA6MDA6MDIuMDogW2RybV0gZmIwOiBpOTE1
ZHJtZmIgZnJhbWUgYnVmZmVyIGRldmljZQpbICAgMTAuNDMwMDYwXSBkZXZpY2UtbWFwcGVyOiBj
b3JlOiBDT05GSUdfSU1BX0RJU0FCTEVfSFRBQkxFIGlzIGRpc2FibGVkLiBEdXBsaWNhdGUgSU1B
IG1lYXN1cmVtZW50cyB3aWxsIG5vdCBiZSByZWNvcmRlZCBpbiB0aGUgSU1BIGxvZy4KWyAgIDEw
LjQzMDM3Nl0gZGV2aWNlLW1hcHBlcjogdWV2ZW50OiB2ZXJzaW9uIDEuMC4zClsgICAxMC40MzA4
MjJdIGRldmljZS1tYXBwZXI6IGlvY3RsOiA0LjQ3LjAtaW9jdGwgKDIwMjItMDctMjgpIGluaXRp
YWxpc2VkOiBkbS1kZXZlbEByZWRoYXQuY29tClsgICAxMS4yMjgxMjFdIHJhbmRvbTogY3JuZyBp
bml0IGRvbmUKWyAgIDUyLjc0Njc5MF0gY3J5cHRkOiBtYXhfY3B1X3FsZW4gc2V0IHRvIDEwMDAK
WyAgIDU0Ljc1NDY0N10gUE06IEltYWdlIG5vdCBmb3VuZCAoY29kZSAtMjIpClsgICA1NS4zNTI5
MTNdIEVYVDQtZnMgKGRtLTEpOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGEg
bW9kZS4gUXVvdGEgbW9kZTogbm9uZS4KWyAgIDU1Ljg5NDExNF0gTm90IGFjdGl2YXRpbmcgTWFu
ZGF0b3J5IEFjY2VzcyBDb250cm9sIGFzIC9zYmluL3RvbW95by1pbml0IGRvZXMgbm90IGV4aXN0
LgpbICAgNTcuNjc1NDgzXSBzeXN0ZW1kWzFdOiBJbnNlcnRlZCBtb2R1bGUgJ2F1dG9mczQnClsg
ICA1Ny45NjQ4ODRdIHN5c3RlbWRbMV06IHN5c3RlbWQgMjUyLjM5LTF+ZGViMTJ1MSBydW5uaW5n
IGluIHN5c3RlbSBtb2RlICgrUEFNICtBVURJVCArU0VMSU5VWCArQVBQQVJNT1IgK0lNQSArU01B
Q0sgK1NFQ0NPTVAgK0dDUllQVCAtR05VVExTICtPUEVOU1NMICtBQ0wgK0JMS0lEICtDVVJMICtF
TEZVVElMUyArRklETzIgK0lETjIgLUlETiArSVBUQyArS01PRCArTElCQ1JZUFRTRVRVUCArTElC
RkRJU0sgK1BDUkUyIC1QV1FVQUxJVFkgK1AxMUtJVCArUVJFTkNPREUgK1RQTTIgK0JaSVAyICtM
WjQgK1haICtaTElCICtaU1REIC1CUEZfRlJBTUVXT1JLIC1YS0JDT01NT04gK1VUTVAgK1NZU1ZJ
TklUIGRlZmF1bHQtaGllcmFyY2h5PXVuaWZpZWQpClsgICA1Ny45NjUyNzldIHN5c3RlbWRbMV06
IERldGVjdGVkIGFyY2hpdGVjdHVyZSB4ODYtNjQuClsgICA1Ny45OTA0MTFdIHN5c3RlbWRbMV06
IEhvc3RuYW1lIHNldCB0byA8c25vd2JlbGw+LgpbICAgNjAuMzc1MDEwXSBzeXN0ZW1kWzFdOiBR
dWV1ZWQgc3RhcnQgam9iIGZvciBkZWZhdWx0IHRhcmdldCBncmFwaGljYWwudGFyZ2V0LgpbICAg
NjAuNDAxNDc5XSBzeXN0ZW1kWzFdOiBDcmVhdGVkIHNsaWNlIHN5c3RlbS1nZXR0eS5zbGljZSAt
IFNsaWNlIC9zeXN0ZW0vZ2V0dHkuClsgICA2MC40MDQyMjldIHN5c3RlbWRbMV06IENyZWF0ZWQg
c2xpY2Ugc3lzdGVtLW1vZHByb2JlLnNsaWNlIC0gU2xpY2UgL3N5c3RlbS9tb2Rwcm9iZS4KWyAg
IDYwLjQwNjczNF0gc3lzdGVtZFsxXTogQ3JlYXRlZCBzbGljZSBzeXN0ZW0tc3lzdGVtZFx4MmRj
cnlwdHNldHVwLnNsaWNlIC0gQ3J5cHRzZXR1cCBVbml0cyBTbGljZS4KWyAgIDYwLjQwOTg2MV0g
c3lzdGVtZFsxXTogQ3JlYXRlZCBzbGljZSBzeXN0ZW0tc3lzdGVtZFx4MmRmc2NrLnNsaWNlIC0g
U2xpY2UgL3N5c3RlbS9zeXN0ZW1kLWZzY2suClsgICA2MC40MTUyMDBdIHN5c3RlbWRbMV06IENy
ZWF0ZWQgc2xpY2UgdXNlci5zbGljZSAtIFVzZXIgYW5kIFNlc3Npb24gU2xpY2UuClsgICA2MC40
MjI3NzJdIHN5c3RlbWRbMV06IFN0YXJ0ZWQgc3lzdGVtZC1hc2stcGFzc3dvcmQtd2FsbC5wYXRo
IC0gRm9yd2FyZCBQYXNzd29yZCBSZXF1ZXN0cyB0byBXYWxsIERpcmVjdG9yeSBXYXRjaC4KWyAg
IDYwLjQzMTk0OF0gc3lzdGVtZFsxXTogU2V0IHVwIGF1dG9tb3VudCBwcm9jLXN5cy1mcy1iaW5m
bXRfbWlzYy5hdXRvbW91bnQgLSBBcmJpdHJhcnkgRXhlY3V0YWJsZSBGaWxlIEZvcm1hdHMgRmls
ZSBTeXN0ZW0gQXV0b21vdW50IFBvaW50LgpbICAgNjAuNDQyMjg3XSBzeXN0ZW1kWzFdOiBFeHBl
Y3RpbmcgZGV2aWNlIGRldi1kaXNrLWJ5XHgyZHV1aWQtODM4NWQzMDNceDJkYjVkY1x4MmQ0N2U5
XHgyZDk2MmNceDJkMTliYmRmZmZhNGFmLmRldmljZSAtIC9kZXYvZGlzay9ieS11dWlkLzgzODVk
MzAzLWI1ZGMtNDdlOS05NjJjLTE5YmJkZmZmYTRhZi4uLgpbICAgNjAuNDQ4MDY0XSBzeXN0ZW1k
WzFdOiBFeHBlY3RpbmcgZGV2aWNlIGRldi1kaXNrLWJ5XHgyZHV1aWQtZWVlN2RlMmVceDJkNTJm
Mlx4MmQ0N2RjXHgyZGEyNjRceDJkM2VmZmViMjI3MTVkLmRldmljZSAtIC9kZXYvZGlzay9ieS11
dWlkL2VlZTdkZTJlLTUyZjItNDdkYy1hMjY0LTNlZmZlYjIyNzE1ZC4uLgpbICAgNjAuNDU5NTg1
XSBzeXN0ZW1kWzFdOiBFeHBlY3RpbmcgZGV2aWNlIGRldi1tYXBwZXItc25vd2JlbGxceDJkXHgy
ZHZnXHgyZGhvbWUuZGV2aWNlIC0gL2Rldi9tYXBwZXIvc25vd2JlbGwtLXZnLWhvbWUuLi4KWyAg
IDYwLjQ2Mjg2Nl0gc3lzdGVtZFsxXTogRXhwZWN0aW5nIGRldmljZSBkZXYtbWFwcGVyLXNub3di
ZWxsXHgyZFx4MmR2Z1x4MmRzd2FwXzEuZGV2aWNlIC0gL2Rldi9tYXBwZXIvc25vd2JlbGwtLXZn
LXN3YXBfMS4uLgpbICAgNjAuNDcxNzAyXSBzeXN0ZW1kWzFdOiBFeHBlY3RpbmcgZGV2aWNlIGRl
di1tYXBwZXItc25vd2JlbGxceDJkXHgyZHZnXHgyZHRtcC5kZXZpY2UgLSAvZGV2L21hcHBlci9z
bm93YmVsbC0tdmctdG1wLi4uClsgICA2MC40ODA1NzBdIHN5c3RlbWRbMV06IEV4cGVjdGluZyBk
ZXZpY2UgZGV2LW1hcHBlci1zbm93YmVsbFx4MmRceDJkdmdceDJkdmFyLmRldmljZSAtIC9kZXYv
bWFwcGVyL3Nub3diZWxsLS12Zy12YXIuLi4KWyAgIDYwLjQ4NDIyOF0gc3lzdGVtZFsxXTogUmVh
Y2hlZCB0YXJnZXQgaW50ZWdyaXR5c2V0dXAudGFyZ2V0IC0gTG9jYWwgSW50ZWdyaXR5IFByb3Rl
Y3RlZCBWb2x1bWVzLgpbICAgNjAuNDkwMzkwXSBzeXN0ZW1kWzFdOiBSZWFjaGVkIHRhcmdldCBy
ZW1vdGUtZnMudGFyZ2V0IC0gUmVtb3RlIEZpbGUgU3lzdGVtcy4KWyAgIDYwLjQ5OTIyOF0gc3lz
dGVtZFsxXTogUmVhY2hlZCB0YXJnZXQgc2xpY2VzLnRhcmdldCAtIFNsaWNlIFVuaXRzLgpbICAg
NjAuNTAyNzkxXSBzeXN0ZW1kWzFdOiBSZWFjaGVkIHRhcmdldCB2ZXJpdHlzZXR1cC50YXJnZXQg
LSBMb2NhbCBWZXJpdHkgUHJvdGVjdGVkIFZvbHVtZXMuClsgICA2MC41MTIwMTZdIHN5c3RlbWRb
MV06IExpc3RlbmluZyBvbiBkbS1ldmVudC5zb2NrZXQgLSBEZXZpY2UtbWFwcGVyIGV2ZW50IGRh
ZW1vbiBGSUZPcy4KWyAgIDYwLjUyMTU4MF0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIGx2bTIt
bHZtcG9sbGQuc29ja2V0IC0gTFZNMiBwb2xsIGRhZW1vbiBzb2NrZXQuClsgICA2MC41MzEwNDZd
IHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBzeXN0ZW1kLWZzY2tkLnNvY2tldCAtIGZzY2sgdG8g
ZnNja2QgY29tbXVuaWNhdGlvbiBTb2NrZXQuClsgICA2MC41NDAzNDFdIHN5c3RlbWRbMV06IExp
c3RlbmluZyBvbiBzeXN0ZW1kLWluaXRjdGwuc29ja2V0IC0gaW5pdGN0bCBDb21wYXRpYmlsaXR5
IE5hbWVkIFBpcGUuClsgICA2MC41NTA5ODJdIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBzeXN0
ZW1kLWpvdXJuYWxkLWF1ZGl0LnNvY2tldCAtIEpvdXJuYWwgQXVkaXQgU29ja2V0LgpbICAgNjAu
NTYwMzEwXSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gc3lzdGVtZC1qb3VybmFsZC1kZXYtbG9n
LnNvY2tldCAtIEpvdXJuYWwgU29ja2V0ICgvZGV2L2xvZykuClsgICA2MC41NzAxNDJdIHN5c3Rl
bWRbMV06IExpc3RlbmluZyBvbiBzeXN0ZW1kLWpvdXJuYWxkLnNvY2tldCAtIEpvdXJuYWwgU29j
a2V0LgpbICAgNjAuNjAyODI1XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gc3lzdGVtZC11ZGV2
ZC1jb250cm9sLnNvY2tldCAtIHVkZXYgQ29udHJvbCBTb2NrZXQuClsgICA2MC42MDcwMDVdIHN5
c3RlbWRbMV06IExpc3RlbmluZyBvbiBzeXN0ZW1kLXVkZXZkLWtlcm5lbC5zb2NrZXQgLSB1ZGV2
IEtlcm5lbCBTb2NrZXQuClsgICA2MC42MzY2MTddIHN5c3RlbWRbMV06IE1vdW50aW5nIGRldi1o
dWdlcGFnZXMubW91bnQgLSBIdWdlIFBhZ2VzIEZpbGUgU3lzdGVtLi4uClsgICA2MC42NDc5MjFd
IHN5c3RlbWRbMV06IE1vdW50aW5nIGRldi1tcXVldWUubW91bnQgLSBQT1NJWCBNZXNzYWdlIFF1
ZXVlIEZpbGUgU3lzdGVtLi4uClsgICA2MC42NjA2MjZdIHN5c3RlbWRbMV06IE1vdW50aW5nIHN5
cy1rZXJuZWwtZGVidWcubW91bnQgLSBLZXJuZWwgRGVidWcgRmlsZSBTeXN0ZW0uLi4KWyAgIDYw
LjY3MTk0MF0gc3lzdGVtZFsxXTogTW91bnRpbmcgc3lzLWtlcm5lbC10cmFjaW5nLm1vdW50IC0g
S2VybmVsIFRyYWNlIEZpbGUgU3lzdGVtLi4uClsgICA2MC42ODI1NDFdIHN5c3RlbWRbMV06IEZp
bmlzaGVkIGJsay1hdmFpbGFiaWxpdHkuc2VydmljZSAtIEF2YWlsYWJpbGl0eSBvZiBibG9jayBk
ZXZpY2VzLgpbICAgNjAuNzIxMDkwXSBzeXN0ZW1kWzFdOiBTdGFydGluZyBrZXlib2FyZC1zZXR1
cC5zZXJ2aWNlIC0gU2V0IHRoZSBjb25zb2xlIGtleWJvYXJkIGxheW91dC4uLgpbICAgNjAuNzMy
NjMwXSBzeXN0ZW1kWzFdOiBTdGFydGluZyBrbW9kLXN0YXRpYy1ub2Rlcy5zZXJ2aWNlIC0gQ3Jl
YXRlIExpc3Qgb2YgU3RhdGljIERldmljZSBOb2Rlcy4uLgpbICAgNjAuNzQ5MTQyXSBzeXN0ZW1k
WzFdOiBTdGFydGluZyBsdm0yLW1vbml0b3Iuc2VydmljZSAtIE1vbml0b3Jpbmcgb2YgTFZNMiBt
aXJyb3JzLCBzbmFwc2hvdHMgZXRjLiB1c2luZyBkbWV2ZW50ZCBvciBwcm9ncmVzcyBwb2xsaW5n
Li4uClsgICA2MC43NjgyNTJdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIG1vZHByb2JlQGNvbmZpZ2Zz
LnNlcnZpY2UgLSBMb2FkIEtlcm5lbCBNb2R1bGUgY29uZmlnZnMuLi4KWyAgIDYwLjc4NTE4M10g
c3lzdGVtZFsxXTogU3RhcnRpbmcgbW9kcHJvYmVAZG1fbW9kLnNlcnZpY2UgLSBMb2FkIEtlcm5l
bCBNb2R1bGUgZG1fbW9kLi4uClsgICA2MC44MDQ5ODRdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIG1v
ZHByb2JlQGRybS5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwgTW9kdWxlIGRybS4uLgpbICAgNjAuODQw
MDc5XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBtb2Rwcm9iZUBlZmlfcHN0b3JlLnNlcnZpY2UgLSBM
b2FkIEtlcm5lbCBNb2R1bGUgZWZpX3BzdG9yZS4uLgpbICAgNjAuODc2OTgwXSBzeXN0ZW1kWzFd
OiBTdGFydGluZyBtb2Rwcm9iZUBmdXNlLnNlcnZpY2UgLSBMb2FkIEtlcm5lbCBNb2R1bGUgZnVz
ZS4uLgpbICAgNjAuODk1NzgzXSBzeXN0ZW1kWzFdOiBTdGFydGluZyBtb2Rwcm9iZUBsb29wLnNl
cnZpY2UgLSBMb2FkIEtlcm5lbCBNb2R1bGUgbG9vcC4uLgpbICAgNjAuOTAwNjA4XSBzeXN0ZW1k
WzFdOiBzeXN0ZW1kLWZzY2stcm9vdC5zZXJ2aWNlIC0gRmlsZSBTeXN0ZW0gQ2hlY2sgb24gUm9v
dCBEZXZpY2Ugd2FzIHNraXBwZWQgYmVjYXVzZSBvZiBhbiB1bm1ldCBjb25kaXRpb24gY2hlY2sg
KENvbmRpdGlvblBhdGhFeGlzdHM9IS9ydW4vaW5pdHJhbWZzL2ZzY2stcm9vdCkuClsgICA2MC45
MTU0MDRdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIHN5c3RlbWQtam91cm5hbGQuc2VydmljZSAtIEpv
dXJuYWwgU2VydmljZS4uLgpbICAgNjEuMDQwOTMwXSBzeXN0ZW1kWzFdOiBTdGFydGluZyBzeXN0
ZW1kLW1vZHVsZXMtbG9hZC5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwgTW9kdWxlcy4uLgpbICAgNjEu
MDUxMDQ2XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBzeXN0ZW1kLXJlbW91bnQtZnMuc2VydmljZSAt
IFJlbW91bnQgUm9vdCBhbmQgS2VybmVsIEZpbGUgU3lzdGVtcy4uLgpbICAgNjEuMDY5Mzc2XSBz
eXN0ZW1kWzFdOiBTdGFydGluZyBzeXN0ZW1kLXVkZXYtdHJpZ2dlci5zZXJ2aWNlIC0gQ29sZHBs
dWcgQWxsIHVkZXYgRGV2aWNlcy4uLgpbICAgNjEuMTA5NjE1XSBzeXN0ZW1kWzFdOiBNb3VudGVk
IGRldi1odWdlcGFnZXMubW91bnQgLSBIdWdlIFBhZ2VzIEZpbGUgU3lzdGVtLgpbICAgNjEuMTMw
NDk3XSBzeXN0ZW1kWzFdOiBNb3VudGVkIGRldi1tcXVldWUubW91bnQgLSBQT1NJWCBNZXNzYWdl
IFF1ZXVlIEZpbGUgU3lzdGVtLgpbICAgNjEuMTQwNzU0XSBzeXN0ZW1kWzFdOiBNb3VudGVkIHN5
cy1rZXJuZWwtZGVidWcubW91bnQgLSBLZXJuZWwgRGVidWcgRmlsZSBTeXN0ZW0uClsgICA2MS4x
NjEwODFdIHN5c3RlbWRbMV06IE1vdW50ZWQgc3lzLWtlcm5lbC10cmFjaW5nLm1vdW50IC0gS2Vy
bmVsIFRyYWNlIEZpbGUgU3lzdGVtLgpbICAgNjEuMTkzNDY0XSBzeXN0ZW1kWzFdOiBGaW5pc2hl
ZCBrbW9kLXN0YXRpYy1ub2Rlcy5zZXJ2aWNlIC0gQ3JlYXRlIExpc3Qgb2YgU3RhdGljIERldmlj
ZSBOb2Rlcy4KWyAgIDYxLjIxMjA3MF0gbG9vcDogbW9kdWxlIGxvYWRlZApbICAgNjEuMjIxMDU1
XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBrZXlib2FyZC1zZXR1cC5zZXJ2aWNlIC0gU2V0IHRoZSBj
b25zb2xlIGtleWJvYXJkIGxheW91dC4KWyAgIDYxLjI0OTg1NV0gc3lzdGVtZFsxXTogbW9kcHJv
YmVAY29uZmlnZnMuc2VydmljZTogRGVhY3RpdmF0ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgNjEuMjU0
NjE0XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBtb2Rwcm9iZUBjb25maWdmcy5zZXJ2aWNlIC0gTG9h
ZCBLZXJuZWwgTW9kdWxlIGNvbmZpZ2ZzLgpbICAgNjEuMjY1MDg1XSBzeXN0ZW1kWzFdOiBtb2Rw
cm9iZUBkbV9tb2Quc2VydmljZTogRGVhY3RpdmF0ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgNjEuMjc1
MDg2XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBtb2Rwcm9iZUBkbV9tb2Quc2VydmljZSAtIExvYWQg
S2VybmVsIE1vZHVsZSBkbV9tb2QuClsgICA2MS4yODg4MjldIHN5c3RlbWRbMV06IG1vZHByb2Jl
QGRybS5zZXJ2aWNlOiBEZWFjdGl2YXRlZCBzdWNjZXNzZnVsbHkuClsgICA2MS4yOTI1NThdIEVY
VDQtZnMgKGRtLTEpOiByZS1tb3VudGVkLiBRdW90YSBtb2RlOiBub25lLgpbICAgNjEuMjk0MDU1
XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBtb2Rwcm9iZUBkcm0uc2VydmljZSAtIExvYWQgS2VybmVs
IE1vZHVsZSBkcm0uClsgICA2MS4zMTQyMTFdIGZ1c2U6IGluaXQgKEFQSSB2ZXJzaW9uIDcuMzgp
ClsgICA2MS4zMzA3NzVdIHN5c3RlbWRbMV06IG1vZHByb2JlQGVmaV9wc3RvcmUuc2VydmljZTog
RGVhY3RpdmF0ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgNjEuMzM1NTYxXSBzeXN0ZW1kWzFdOiBGaW5p
c2hlZCBtb2Rwcm9iZUBlZmlfcHN0b3JlLnNlcnZpY2UgLSBMb2FkIEtlcm5lbCBNb2R1bGUgZWZp
X3BzdG9yZS4KWyAgIDYxLjM0NjEyN10gc3lzdGVtZFsxXTogbW9kcHJvYmVAZnVzZS5zZXJ2aWNl
OiBEZWFjdGl2YXRlZCBzdWNjZXNzZnVsbHkuClsgICA2MS4zNTA4NzZdIHN5c3RlbWRbMV06IEZp
bmlzaGVkIG1vZHByb2JlQGZ1c2Uuc2VydmljZSAtIExvYWQgS2VybmVsIE1vZHVsZSBmdXNlLgpb
ICAgNjEuMzYwNjkxXSBzeXN0ZW1kWzFdOiBtb2Rwcm9iZUBsb29wLnNlcnZpY2U6IERlYWN0aXZh
dGVkIHN1Y2Nlc3NmdWxseS4KWyAgIDYxLjM2NjUwMV0gc3lzdGVtZFsxXTogRmluaXNoZWQgbW9k
cHJvYmVAbG9vcC5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwgTW9kdWxlIGxvb3AuClsgICA2MS4zNzU3
NzVdIHN5c3RlbWRbMV06IEZpbmlzaGVkIHN5c3RlbWQtcmVtb3VudC1mcy5zZXJ2aWNlIC0gUmVt
b3VudCBSb290IGFuZCBLZXJuZWwgRmlsZSBTeXN0ZW1zLgpbICAgNjEuNDA0Nzc2XSBzeXN0ZW1k
WzFdOiBNb3VudGluZyBzeXMtZnMtZnVzZS1jb25uZWN0aW9ucy5tb3VudCAtIEZVU0UgQ29udHJv
bCBGaWxlIFN5c3RlbS4uLgpbICAgNjEuNDE0NjM2XSBzeXN0ZW1kWzFdOiBNb3VudGluZyBzeXMt
a2VybmVsLWNvbmZpZy5tb3VudCAtIEtlcm5lbCBDb25maWd1cmF0aW9uIEZpbGUgU3lzdGVtLi4u
ClsgICA2MS40MjU3MjhdIHN5c3RlbWRbMV06IHN5c3RlbWQtZmlyc3Rib290LnNlcnZpY2UgLSBG
aXJzdCBCb290IFdpemFyZCB3YXMgc2tpcHBlZCBiZWNhdXNlIG9mIGFuIHVubWV0IGNvbmRpdGlv
biBjaGVjayAoQ29uZGl0aW9uRmlyc3RCb290PXllcykuClsgICA2MS40MjY2MjddIHN5c3RlbWRb
MV06IHN5c3RlbWQtcmVwYXJ0LnNlcnZpY2UgLSBSZXBhcnRpdGlvbiBSb290IERpc2sgd2FzIHNr
aXBwZWQgYmVjYXVzZSBubyB0cmlnZ2VyIGNvbmRpdGlvbiBjaGVja3Mgd2VyZSBtZXQuClsgICA2
MS40Nzc2MDhdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIHN5c3RlbWQtc3lzdXNlcnMuc2VydmljZSAt
IENyZWF0ZSBTeXN0ZW0gVXNlcnMuLi4KWyAgIDYxLjQ5OTQyN10gc3lzdGVtZFsxXTogTW91bnRl
ZCBzeXMtZnMtZnVzZS1jb25uZWN0aW9ucy5tb3VudCAtIEZVU0UgQ29udHJvbCBGaWxlIFN5c3Rl
bS4KWyAgIDYxLjUwNzQwNF0gc3lzdGVtZFsxXTogTW91bnRlZCBzeXMta2VybmVsLWNvbmZpZy5t
b3VudCAtIEtlcm5lbCBDb25maWd1cmF0aW9uIEZpbGUgU3lzdGVtLgpbICAgNjEuNzU4MTk3XSBs
cDogZHJpdmVyIGxvYWRlZCBidXQgbm8gZGV2aWNlcyBmb3VuZApbICAgNjEuODQ2MTkzXSBwcGRl
djogdXNlci1zcGFjZSBwYXJhbGxlbCBwb3J0IGRyaXZlcgpbICAgNjEuOTQ5MjU5XSBzeXN0ZW1k
WzFdOiBTdGFydGVkIHN5c3RlbWQtam91cm5hbGQuc2VydmljZSAtIEpvdXJuYWwgU2VydmljZS4K
WyAgIDY1LjA2ODIwNV0gQUNQSTogQUM6IEFDIEFkYXB0ZXIgW0FDMF0gKG9uLWxpbmUpClsgICA2
NS4xMjA4NzddIHNkIDA6MDowOjA6IEF0dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzAgdHlwZSAwClsg
ICA2NS43NjU3MTJdIGlucHV0OiBQQyBTcGVha2VyIGFzIC9kZXZpY2VzL3BsYXRmb3JtL3Bjc3Br
ci9pbnB1dC9pbnB1dDgKWyAgIDY2LjA3OTI2M10gaVRDT192ZW5kb3Jfc3VwcG9ydDogdmVuZG9y
LXN1cHBvcnQ9MApbICAgNjYuMzE4NDU4XSBhc3VzX3dtaTogQVNVUyBXTUkgZ2VuZXJpYyBkcml2
ZXIgbG9hZGVkClsgICA2Ni4zNTE0MDVdIGVlZXBjX3dtaTogRm91bmQgbGVnYWN5IEFUS0QgZGV2
aWNlIChBU1VTMDEwKQpbICAgNjYuMzU0MTE3XSBlZWVwY193bWk6IFdNSSBkZXZpY2UgcHJlc2Vu
dCwgYnV0IGxlZ2FjeSBBVEtEIGRldmljZSBpcyBhbHNvIHByZXNlbnQgYW5kIGVuYWJsZWQKWyAg
IDY2LjM1NjcwM10gZWVlcGNfd21pOiBZb3UgcHJvYmFibHkgYm9vdGVkIHdpdGggYWNwaV9vc2k9
IkxpbnV4IiBvciBhY3BpX29zaT0iIVdpbmRvd3MgMjAwOSIKWyAgIDY2LjM1OTM1NV0gZWVlcGNf
d21pOiBDYW4ndCBsb2FkIGVlZXBjLXdtaSwgdXNlIGRlZmF1bHQgYWNwaV9vc2kgKHByZWZlcnJl
ZCkgb3IgZWVlcGMtbGFwdG9wClsgICA2Ni4zNjE4NjNdIGVlZXBjLXdtaTogcHJvYmUgb2YgZWVl
cGMtd21pIGZhaWxlZCB3aXRoIGVycm9yIC0xNgpbICAgNjYuNDE3NjM0XSBpVENPX3dkdCBpVENP
X3dkdC4xLmF1dG86IEZvdW5kIGEgTk0xMCBUQ08gZGV2aWNlIChWZXJzaW9uPTIsIFRDT0JBU0U9
MHgwODYwKQpbICAgNjYuNDI3MTU2XSBpVENPX3dkdCBpVENPX3dkdC4xLmF1dG86IGluaXRpYWxp
emVkLiBoZWFydGJlYXQ9MzAgc2VjIChub3dheW91dD0wKQpbICAgNjYuNzQzNjA5XSBpbnRlbF9w
b3dlcmNsYW1wOiBObyBwYWNrYWdlIEMtc3RhdGUgYXZhaWxhYmxlClsgICA2Ni43Njk0OTldIGNm
ZzgwMjExOiBMb2FkaW5nIGNvbXBpbGVkLWluIFguNTA5IGNlcnRpZmljYXRlcyBmb3IgcmVndWxh
dG9yeSBkYXRhYmFzZQpbICAgNjYuNzc2NjQ5XSBjZmc4MDIxMTogTG9hZGVkIFguNTA5IGNlcnQg
J2JlbmhAZGViaWFuLm9yZzogNTc3ZTAyMWNiOTgwZTBlODIwODIxYmE3YjU0YjQ5NjFiOGI0ZmFk
ZicKWyAgIDY2Ljc4MTg1MF0gY2ZnODAyMTE6IExvYWRlZCBYLjUwOSBjZXJ0ICdyb21haW4ucGVy
aWVyQGdtYWlsLmNvbTogM2FiYmM2ZWMxNDZlMDlkMWI2MDE2YWI5ZDZjZjcxZGQyMzNmMDMyOCcK
WyAgIDY2Ljc4NjY1OF0gbWM6IExpbnV4IG1lZGlhIGludGVyZmFjZTogdjAuMTAKWyAgIDY2Ljc5
Mjc0OV0gY2ZnODAyMTE6IExvYWRlZCBYLjUwOSBjZXJ0ICdzZm9yc2hlZTogMDBiMjhkZGY0N2Fl
ZjljZWE3JwpbICAgNjYuNzk4MzkwXSBjZmc4MDIxMTogTG9hZGVkIFguNTA5IGNlcnQgJ3dlbnM6
IDYxYzAzODY1MWFhYmRjZjk0YmQwYWM3ZmYwNmM3MjQ4ZGIxOGM2MDAnClsgICA2Ny4zNTY0OTFd
IHBsYXRmb3JtIHJlZ3VsYXRvcnkuMDogZmlybXdhcmU6IGRpcmVjdC1sb2FkaW5nIGZpcm13YXJl
IHJlZ3VsYXRvcnkuZGIKWyAgIDY3LjM2Njg0NF0gdmlkZW9kZXY6IExpbnV4IHZpZGVvIGNhcHR1
cmUgaW50ZXJmYWNlOiB2Mi4wMApbICAgNjcuNDcwNTA0XSBwbGF0Zm9ybSByZWd1bGF0b3J5LjA6
IGZpcm13YXJlOiBkaXJlY3QtbG9hZGluZyBmaXJtd2FyZSByZWd1bGF0b3J5LmRiLnA3cwpbICAg
NjguMjM3NzA5XSBBZGRpbmcgOTk5NDIwayBzd2FwIG9uIC9kZXYvbWFwcGVyL3Nub3diZWxsLS12
Zy1zd2FwXzEuICBQcmlvcml0eTotMiBleHRlbnRzOjEgYWNyb3NzOjk5OTQyMGsgRlMKWyAgIDY4
LjMxODMyOV0gc25kX2hkYV9jb2RlY19yZWFsdGVrIGhkYXVkaW9DMEQwOiBhdXRvY29uZmlnIGZv
ciBBTEMyNjk6IGxpbmVfb3V0cz0xICgweDE0LzB4MC8weDAvMHgwLzB4MCkgdHlwZTpzcGVha2Vy
ClsgICA2OC4zMjE3MTBdIHNuZF9oZGFfY29kZWNfcmVhbHRlayBoZGF1ZGlvQzBEMDogICAgc3Bl
YWtlcl9vdXRzPTAgKDB4MC8weDAvMHgwLzB4MC8weDApClsgICA2OC4zMjUxMDldIHNuZF9oZGFf
Y29kZWNfcmVhbHRlayBoZGF1ZGlvQzBEMDogICAgaHBfb3V0cz0xICgweDE1LzB4MC8weDAvMHgw
LzB4MCkKWyAgIDY4LjMyODQ4MF0gc25kX2hkYV9jb2RlY19yZWFsdGVrIGhkYXVkaW9DMEQwOiAg
ICBtb25vOiBtb25vX291dD0weDAKWyAgIDY4LjMzMTY0Ml0gc25kX2hkYV9jb2RlY19yZWFsdGVr
IGhkYXVkaW9DMEQwOiAgICBpbnB1dHM6ClsgICA2OC4zMzYyNzhdIHNuZF9oZGFfY29kZWNfcmVh
bHRlayBoZGF1ZGlvQzBEMDogICAgICBNaWM9MHgxOApbICAgNjguMzM5MzkwXSBzbmRfaGRhX2Nv
ZGVjX3JlYWx0ZWsgaGRhdWRpb0MwRDA6ICAgICAgSW50ZXJuYWwgTWljPTB4MTIKWyAgIDY4LjM3
MzgyMF0gaW5wdXQ6IEhEQSBEaWdpdGFsIFBDQmVlcCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAw
MDA6MDA6MWIuMC9zb3VuZC9jYXJkMC9pbnB1dDkKWyAgIDY4LjM3NzM2MV0gaW5wdXQ6IEhEQSBJ
bnRlbCBNaWMgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFiLjAvc291bmQvY2FyZDAv
aW5wdXQxMApbICAgNjguMzgwOTY2XSBpbnB1dDogSERBIEludGVsIEhlYWRwaG9uZSBhcyAvZGV2
aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWIuMC9zb3VuZC9jYXJkMC9pbnB1dDExClsgICA2OC40
NTE2ODRdIHVzYiAzLTY6IEZvdW5kIFVWQyAxLjAwIGRldmljZSBVU0IyLjAgVVZDIFZHQSBXZWJD
YW0gKDEzZDM6NTExMSkKWyAgIDY4LjQ2ODYyMF0gaW5wdXQ6IFVTQjIuMCBVVkMgVkdBIFdlYkNh
bSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuNy91c2IzLzMtNi8zLTY6MS4wL2lu
cHV0L2lucHV0MTIKWyAgIDY4LjQ3NjkwOV0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJm
YWNlIGRyaXZlciB1dmN2aWRlbwpbICAgNjguODY1ODY0XSBhdGg6IHBoeTA6IEFTUE0gZW5hYmxl
ZDogMHg0MgpbICAgNjguODY5MTI4XSBhdGg6IEVFUFJPTSByZWdkb21haW46IDB4NjAKWyAgIDY4
Ljg2OTEzNV0gYXRoOiBFRVBST00gaW5kaWNhdGVzIHdlIHNob3VsZCBleHBlY3QgYSBkaXJlY3Qg
cmVncGFpciBtYXAKWyAgIDY4Ljg2OTE0NF0gYXRoOiBDb3VudHJ5IGFscGhhMiBiZWluZyB1c2Vk
OiAwMApbICAgNjguODY5MTQ4XSBhdGg6IFJlZ3BhaXIgdXNlZDogMHg2MApbICAgNjguODc3Mjgy
XSBpZWVlODAyMTEgcGh5MDogU2VsZWN0ZWQgcmF0ZSBjb250cm9sIGFsZ29yaXRobSAnbWluc3Ry
ZWxfaHQnClsgICA2OC44OTIyNjldIGllZWU4MDIxMSBwaHkwOiBBdGhlcm9zIEFSOTI4NSBSZXY6
MiBtZW09MHgwMDAwMDAwMGRmMzczMjliLCBpcnE9MTcKWyAgIDY5LjA3NjMxM10gYXRoOWsgMDAw
MDowMjowMC4wIHdscDJzMDogcmVuYW1lZCBmcm9tIHdsYW4wClsgICA2OS44NjE0MDRdIEVYVDQt
ZnMgKGRtLTIpOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGEgbW9kZS4gUXVv
dGEgbW9kZTogbm9uZS4KWyAgIDcwLjA5MzMwNF0gRVhUNC1mcyAoZG0tNCk6IG1vdW50ZWQgZmls
ZXN5c3RlbSB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLiBRdW90YSBtb2RlOiBub25lLgpbICAgNzAu
MTQ2NDUyXSBzeXN0ZW1kLWpvdXJuYWxkWzM1M106IFJlY2VpdmVkIGNsaWVudCByZXF1ZXN0IHRv
IGZsdXNoIHJ1bnRpbWUgam91cm5hbC4KWyAgIDcwLjQ1NTAzNl0gRVhUNC1mcyAoZG0tNSk6IG1v
dW50ZWQgZmlsZXN5c3RlbSB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLiBRdW90YSBtb2RlOiBub25l
LgpbICAgNzIuODA4NDE0XSBFWFQ0LWZzIChzZGExKTogbW91bnRpbmcgZXh0MiBmaWxlIHN5c3Rl
bSB1c2luZyB0aGUgZXh0NCBzdWJzeXN0ZW0KWyAgIDcyLjk4NzE2M10gRVhUNC1mcyAoc2RhMSk6
IG1vdW50ZWQgZmlsZXN5c3RlbSB3aXRob3V0IGpvdXJuYWwuIFF1b3RhIG1vZGU6IG5vbmUuClsg
ICA3My44NTA0OTddIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc2MDczMzM1NC41OTY6Mik6IGFw
cGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZp
bmVkIiBuYW1lPSJsc2JfcmVsZWFzZSIgcGlkPTU1MiBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsg
ICA3My45NDA0NjldIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc2MDczMzM1NC42ODg6Myk6IGFw
cGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZp
bmVkIiBuYW1lPSJudmlkaWFfbW9kcHJvYmUiIHBpZD01NTMgY29tbT0iYXBwYXJtb3JfcGFyc2Vy
IgpbICAgNzMuOTQ5OTYyXSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3NjA3MzMzNTQuNjg4OjQp
OiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5j
b25maW5lZCIgbmFtZT0ibnZpZGlhX21vZHByb2JlLy9rbW9kIiBwaWQ9NTUzIGNvbW09ImFwcGFy
bW9yX3BhcnNlciIKWyAgIDczLjk2NzQ5M10gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzYwNzMz
MzU0LjcxMjo1KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHBy
b2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Ii91c3IvbGliL3g4Nl82NC1saW51eC1nbnUvbGlnaHRk
bS9saWdodGRtLWd1ZXN0LXNlc3Npb24iIHBpZD01NTEgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpb
ICAgNzMuOTgxMzUyXSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3NjA3MzMzNTQuNzEyOjYpOiBh
cHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25m
aW5lZCIgbmFtZT0iL3Vzci9saWIveDg2XzY0LWxpbnV4LWdudS9saWdodGRtL2xpZ2h0ZG0tZ3Vl
c3Qtc2Vzc2lvbi8vY2hyb21pdW0iIHBpZD01NTEgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAg
NzQuMDU4MjIwXSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3NjA3MzMzNTQuODA0OjcpOiBhcHBh
cm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5l
ZCIgbmFtZT0iL3Vzci9iaW4vbWFuIiBwaWQ9NTU3IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAg
IDc0LjA5NjAxNV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzYwNzMzMzU0LjgwNDo4KTogYXBw
YXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmlu
ZWQiIG5hbWU9Im1hbl9maWx0ZXIiIHBpZD01NTcgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAg
NzQuMTA0NjkxXSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3NjA3MzMzNTQuODA0OjkpOiBhcHBh
cm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5l
ZCIgbmFtZT0ibWFuX2dyb2ZmIiBwaWQ9NTU3IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDc0
LjExNDEzNF0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzYwNzMzMzU0Ljg2MDoxMCk6IGFwcGFy
bW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVk
IiBuYW1lPSIvdXNyL2xpYi9OZXR3b3JrTWFuYWdlci9ubS1kaGNwLWNsaWVudC5hY3Rpb24iIHBp
ZD01NTUgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgNzQuMTI1MjI4XSBhdWRpdDogdHlwZT0x
NDAwIGF1ZGl0KDE3NjA3MzMzNTQuODYwOjExKTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9u
PSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Ii91c3IvbGliL05ldHdv
cmtNYW5hZ2VyL25tLWRoY3AtaGVscGVyIiBwaWQ9NTU1IGNvbW09ImFwcGFybW9yX3BhcnNlciIK
WyAgIDg1LjE2MTIyMl0gTkVUOiBSZWdpc3RlcmVkIFBGX1FJUENSVFIgcHJvdG9jb2wgZmFtaWx5
ClsgICA4NS45NTMyNDddIGthdWRpdGRfcHJpbnRrX3NrYjogMTEgY2FsbGJhY2tzIHN1cHByZXNz
ZWQKWyAgIDg1Ljk1MzI1OF0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzYwNzMzMzY2LjcwMDoy
Myk6IGFwcGFybW9yPSJERU5JRUQiIG9wZXJhdGlvbj0iY2FwYWJsZSIgcHJvZmlsZT0iL3Vzci9z
YmluL2N1cHNkIiBwaWQ9NjgzIGNvbW09ImN1cHNkIiBjYXBhYmlsaXR5PTEyICBjYXBuYW1lPSJu
ZXRfYWRtaW4iClsgICA4OC40MTE5MDVdIHdscDJzMDogYXV0aGVudGljYXRlIHdpdGggMGM6NzI6
NzQ6NGY6YWU6NDYKWyAgIDg4LjQxMTk4N10gd2xwMnMwOiA4MCBNSHogbm90IHN1cHBvcnRlZCwg
ZGlzYWJsaW5nIFZIVApbICAgODguNDI5MjkzXSB3bHAyczA6IHNlbmQgYXV0aCB0byAwYzo3Mjo3
NDo0ZjphZTo0NiAodHJ5IDEvMykKWyAgIDg4LjQzMzE0OV0gd2xwMnMwOiBhdXRoZW50aWNhdGVk
ClsgICA4OC40NDA1NjVdIHdscDJzMDogYXNzb2NpYXRlIHdpdGggMGM6NzI6NzQ6NGY6YWU6NDYg
KHRyeSAxLzMpClsgICA4OC40NDU3NDRdIHdscDJzMDogUlggQXNzb2NSZXNwIGZyb20gMGM6NzI6
NzQ6NGY6YWU6NDYgKGNhcGFiPTB4MTQxMSBzdGF0dXM9MCBhaWQ9MzApClsgICA4OC40NDYwMTNd
IHdscDJzMDogYXNzb2NpYXRlZApbICAgODguNDQ5NTMyXSBhdGg6IEVFUFJPTSByZWdkb21haW46
IDB4ODExNApbICAgODguNDQ5NTQ4XSBhdGg6IEVFUFJPTSBpbmRpY2F0ZXMgd2Ugc2hvdWxkIGV4
cGVjdCBhIGNvdW50cnkgY29kZQpbICAgODguNDQ5NTUzXSBhdGg6IGRvaW5nIEVFUFJPTSBjb3Vu
dHJ5LT5yZWdkbW4gbWFwIHNlYXJjaApbICAgODguNDQ5NTU4XSBhdGg6IGNvdW50cnkgbWFwcyB0
byByZWdkbW4gY29kZTogMHgzNwpbICAgODguNDQ5NTYzXSBhdGg6IENvdW50cnkgYWxwaGEyIGJl
aW5nIHVzZWQ6IERFClsgICA4OC40NDk1NjldIGF0aDogUmVncGFpciB1c2VkOiAweDM3ClsgICA4
OC40NDk1NzRdIGF0aDogcmVnZG9tYWluIDB4ODExNCBkeW5hbWljYWxseSB1cGRhdGVkIGJ5IGNv
dW50cnkgZWxlbWVudApbICAgODguNzQ4MzY1XSB3bHAyczA6IExpbWl0aW5nIFRYIHBvd2VyIHRv
IDIwICgyMCAtIDApIGRCbSBhcyBhZHZlcnRpc2VkIGJ5IDBjOjcyOjc0OjRmOmFlOjQ2ClsgICA4
OC43NjQ1ODRdIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiB3bHAyczA6IGxpbmsgYmVj
b21lcyByZWFkeQo=
--0000000000007744030641610eef--

