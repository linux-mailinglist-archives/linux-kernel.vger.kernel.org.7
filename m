Return-Path: <linux-kernel+bounces-767988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB49B25B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D41D1C85C72
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A7E23770A;
	Thu, 14 Aug 2025 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EgAq0wFi"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F911BCA0E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151716; cv=none; b=Own+ulH3MKCZ9vhsnPYhbCF2wYq5mz2/LXFOT1NZJPSDnQvaJKD6wnpVmu00U/izE9OHHv01r0fGYZtv0NydG3Eb5CjLNfNZIobi3wOHm5WaO9ULIXA/bmgax5YpXCLN5fCDeTV4ThGvGZs6MuKze+VTPU3Qq7xHUsd5u8Q1wv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151716; c=relaxed/simple;
	bh=1JKOiLep8ExXa0fltpkQh1omBRKjOAvIjNHGEBk20HQ=;
	h=References:Mime-Version:From:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKvrb6A5+hcv4zNc9hoRbJHJkH7Oybs/hYfq1k9aLqJxVPIMZITKHVfGBq8U6W44LwUIW0/tEZrS3SX7xdCa5V5Ik9jlG0ozUt2VeLazy9xyTSIJcvYNuJDA8BkMm5pNYGH6M76DjsSVLozebWKs25p0ZE8cSgL2931x6zKna+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EgAq0wFi; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d603cebd9so6923837b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755151713; x=1755756513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :from:mime-version:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JKOiLep8ExXa0fltpkQh1omBRKjOAvIjNHGEBk20HQ=;
        b=EgAq0wFiHvfelELk1+0GgJ0TGihBRRUjyseBdJa3ud8yo0IZL7iJ6KaksDYLLYpLAO
         Zy5NpBKJQ2ruXf3hz+Tfn5szx+W1w0+/RbHy8USv94OqGiXT2oEyMZJ0NDiR0sKzXppM
         2VKJn3VoxzQJ0IkY/KMRXfJxUThpiEYBmKeq12QLBTrBjXDFcBn5666Qzl82ZJ7ZrkA0
         k+eW59U2eWjG1KrOcSoTk86LphtVy5Dg0tj487TNR/AFtZHEATH9k4rb1FRecVcauNaw
         E/cnh2F5oZ9pUIQZY63HYvoo8yuYNG4il5U9sMsF3xcS5Xfkc2jpz1q2W1arZ9zqhUZl
         XGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755151713; x=1755756513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :from:mime-version:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1JKOiLep8ExXa0fltpkQh1omBRKjOAvIjNHGEBk20HQ=;
        b=wtPQhWEHjZOR/H3mLFotMA3hfZd+cB16O78i8gFruO3ZLnD0Ke9Pb2shsM/d2qtVYx
         SSpZHlqt/ZS5TXjsIkfhDpN/Ipjwc6dqe4HltyeFaw9r5UEqI7ODNfOci1UNWkJAipHY
         NqvTCMAMG8uacorlNT7p6oB9EGPBgCqAuNPTsOslvMLJQNLUb2JBG8g1iFcRUCSoWg1e
         Oq4Z1g2lmW1W/Nx5SAyR9ih2Qi1lg+KFmbos6P+qU1yIl0sRwxTsNQ/ensSFR635qJz+
         c383AHZc/P0lMmEIIopnVWEWOHWwTm87sWHRbR+IaR8mgsOUSLBtlGjxdGXj0HCnmVYb
         JtIA==
X-Forwarded-Encrypted: i=1; AJvYcCUG0VzMFz+bFrVeQGMsBIlezp9ClDxSmAcunWKBC52MWduSGg1qYNLLON+jedbR66zeXS46fse9U5bw91g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcHlWa650PZWzJEIcN3JdFjpw5x/e6yh2GpS/f9Vrfb6fp1Pm
	POTW6+Z17QKnw9CUkvYyBwbMKQfVL3cWhK5wMXnzoFbeDWNOEc1UYWY9JrHViFqaDDr9xo+BMJq
	VMY/uhomdqwXZ6O9Vij7Yif4mTIWRDQQBxe+6FeLEGw==
X-Gm-Gg: ASbGncsBBION2B+Dxkd7z1PQUAOkz9e3Is9GZ8zMRbFgDdzeGRSbgZFHNgycmejqBkY
	NDCUVHoS8lGhN2U47dt+Eyg5HOhdesZDBBPvc6je13YGM7Qz5FHPah8Pp4/X6kPgNmZe5wFchr/
	j81inxYWUtmOda6QpBd8CBQjelDQgWwV+JqMmycEipBdcJ5SberOPoyB1/Cpao4GT/k2/JSjctf
	gZLGTj9eg==
X-Google-Smtp-Source: AGHT+IGkaiCdlqj221lQJeRqwiVuhWTVonhf2T9OhfXmUKr/telI+k+Vx3B7KwIKgvahWIcywwmIPChAyl6m+zDIYSQ=
X-Received: by 2002:a05:690c:4a10:b0:71c:149b:86c2 with SMTP id
 00721157ae682-71d634346camr23342247b3.14.1755151713502; Wed, 13 Aug 2025
 23:08:33 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 13 Aug 2025 23:08:33 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 13 Aug 2025 23:08:33 -0700
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
 <aJs-aPH32OxpzR3G@sunil-laptop> <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
 <aJtKZhvNX0p3obFw@sunil-laptop> <CAEEQ3wmomscuAzuiRyJu4ha8tiM=s1Y-ytQROPTWr1DScMNL3g@mail.gmail.com>
 <aJwiXKWXik8BmpL8@sunil-laptop> <CAHEos+Msmta3o-HvXoigmJGbD48333Kh8tU3j2D=w_G8gL+OQw@mail.gmail.com>
 <aJyAlqd3U5Jq9ipy@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: =?UTF-8?B?6Z6g5paH6b6Z?= <juwenlong@bytedance.com>
In-Reply-To: <aJyAlqd3U5Jq9ipy@sunil-laptop>
Date: Wed, 13 Aug 2025 23:08:33 -0700
X-Gm-Features: Ac12FXwjnR9HnYIX_p1dnlAXjkNKqrvwpZ-67lvlIUqJADCeLVEfaQA3DCEqJZk
Message-ID: <CAHEos+PdZtqzS++aq-TTXnWbKRmemukeV5-DboSOCnhSQOTRXQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: yunhui cui <cuiyunhui@bytedance.com>, rafael@kernel.org, lenb@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sunil=EF=BC=8C
=C2=A0sorry for the last email format error=EF=BC=8Csend it again.



> From: "Sunil V L"<sunilvl@ventanamicro.com>
> Date:=C2=A0 Wed, Aug 13, 2025, 20:10
> Subject:=C2=A0 Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYC=
LE for CPPC FFH
> To: "=E9=9E=A0=E6=96=87=E9=BE=99"<juwenlong@bytedance.com>
> Cc: "yunhui cui"<cuiyunhui@bytedance.com>, <rafael@kernel.org>, <lenb@ker=
nel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berke=
ley.edu>, <alex@ghiti.fr>, <linux-acpi@vger.kernel.org>, <linux-riscv@lists=
.infradead.org>, <linux-kernel@vger.kernel.org>, "Anup Patel"<apatel@ventan=
amicro.com>, "Rahul Pathak"<rpathak@ventanamicro.com>
> On Wed, Aug 13, 2025 at 12:06:11AM -0700, =E9=9E=A0=E6=96=87=E9=BE=99 wro=
te:

> > Hi Sunil=EF=BC=8C

> >

> > > From: "Sunil V L"<sunilvl@ventanamicro.com>

> > > Date:=C2=A0 Wed, Aug 13, 2025, 13:28

> > > Subject:=C2=A0 Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR=
_CYCLE for CPPC FFH

> > > To: "yunhui cui"<cuiyunhui@bytedance.com>

> > > Cc: <rafael@kernel.org>, <lenb@kernel.org>, <paul.walmsley@sifive.com=
>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <linux-a=
cpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>, <linux-kernel@vger=
.kernel.org>, "Anup Patel"<apatel@ventanamicro.com>, "Rahul Pathak"<rpathak=
@ventanamicro.com>, <juwenlong@bytedance.com>

> > > Hi Yunhui,

> > >

> > >

> > > On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:

> > > > Hi Sunil,

> > > >

> > > > On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@ventana=
micro.com> wrote:

> > > > >

> > > [...]

> > > > > > > >

> > > > > > > > The purpose of cppc_ffh_csr_read() is to calculate the actu=
al

> > > > > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XX=
X.

> > > > > > > >

> > > > > > > > CSR_XXX should be a reference clock and does not count duri=
ng WFI

> > > > > > > > (Wait For Interrupt).

> > > > > > > >

> > > > > > > > Similar solutions include: x86's aperf/mperf, and ARM64's A=
MU with

> > > > > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.

> > > > > > > >

> > > > > > > > However, we know that CSR_TIME in the current code does cou=
nt during

> > > > > > > > WFI. So, is this design unreasonable?

> > > > > > > >

> > > > > > > > Should we consider proposing an extension to support such a=
 dedicated

> > > > > > > > counter (a reference clock that does not count during WFI)?=
 This way,

> > > > > > > > the value can be obtained directly in S-mode without trappi=
ng to

> > > > > > > > M-mode, especially since reading this counter is very frequ=
ent.

> > > > > > > >

> > > > > > > Hi Yunhui,

> > > > > > >

> > > > > > > Yes, but we anticipated that vendors might define their own c=
ustom CSRs.

> > > > > > > So, we introduced FFH encoding to accommodate such cases.

> > > > > > >

> > > > > > > Thanks,

> > > > > > > Sunil

> > > > > >

> > > > > > As mentioned earlier, it is best to directly read CSR_XXX (a re=
ference

> > > > > > clock that does not count during WFI) and CSR_CYCLE in S-mode, =
rather

> > > > > > than trapping to SBI.

> > > > > >

> > > > > No. I meant direct CSR access itself not SBI. Please take a look =
at

> > > > > Table 6 of RISC-V FFH spec.

> > > > >

> > > > > > drivers/acpi/riscv/cppc.c is a generic driver that is not speci=
fic to

> > > > > > any vendor. Currently, the upstream code already uses CSR_TIME,=
 and

> > > > > > the logic of CSR_TIME is incorrect.

> > > > > >

> > > ACPI spec for "Reference Performance Register" says,

> > >

> > >

> > > "The Reference Performance Counter Register counts at a fixed rate an=
y

> > > time the processor is active. It is not affected by changes to Desire=
d

> > > Performance, processor throttling, etc."

> > >

> > >

> > > > > CSR_TIME is just an example. It is upto the vendor how _CPC objec=
ts are

> > > > > encoded using FFH. The linux code doesn't mean one should use CSR=
_TIME

> > > > > always.

> > > >

> > > > First, the example of CSR_TIME is incorrect. What is needed is a

> > > > CSR_XXX (a reference clock that does not count during WFI).

> > > >

> > > > Second, you mentioned that each vendor can customize their own

> > > > implementations. But should all vendors' CSR_XXX/YYY/... be added t=
o

> > > > drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/riscv/cpp=
c.c fall

> > > > under the scope defined by the RISC-V architecture?

> > > >

> > > No. One can implement similar to csr_read_num() in opensbi. We didn't

> > > add it since there was no HW implementing such thing. What I am

> > > saying is we have FFH encoding to support such case.

> > >

> > >

> > > > >

> > > > > > It would be best to promote a specification to support CSR_XXX,=
 just

> > > > > > like what has been done for x86 and arm64. What do you think?

> > > > > >

> > > > > Wouldn't above work? For a standard extension, you may have to pr=
ovide

> > > > > more data with actual HW.

> > > >

> > > > This won=E2=80=99t work. May I ask how the current upstream code ca=
n calculate

> > > > the actual CPU frequency using CSR_TIME without trapping to SBI?

> > > > This is a theoretical logical issue. Why is data needed here?

> > > >

> > > As I mentioned above, one can implement a generic CSR read without

> > > trapping to SBI.

> > >

> > >

> > > > Could you take a look at the "AMU events and event numbers" chapter=
 in

> > > > the ARM64 manual?

> > > >

> > > As-per ACPI spec reference performance counter is not affected by CPU

> > > state. The RISC-V FFH encoding is sufficiently generic to support thi=
s

> > > requirement, even if the standard CSR_TIME cannot be used. In such

> > > cases, an alternative CSR can be encodeded, accessed via an OS-level

> > > abstraction such as csr_read_num().

> > =C2=A0=C2=A0 =C2=A0 =C2=A0 As-per ACPI Spec=EF=BC=8CBoth Reference perf=
ormance counter register

> > and Delivered Performance Counter are affected by CPU

> > state=E3=80=82From ACPI Spec=EF=BC=8C=E2=80=9CThe Reference Performance=
 Counter Register

> > counts at a fixed rate any time the processor is active.=E2=80=9D

> >

> > =E2=80=9CThe Delivered Performance Counter Register increments any time=
 the

> > processor is active, at a rate proportional to the current performance

> > level, taking into account changes to Desired Performance=E2=80=9D

> > =E2=80=9C Processor power states include are designated C0, C1, C2, C3,=
 . . .

> > Cn. The C0 power state is an active power state where the CPU executes

> > instructions. The C1 through Cn power states are processor sleeping

> > states where the processor consumes less power and dissipates less

> > heat than leaving the processor in the C0 state=E2=80=9D. So the time c=
sr can

> > not meet this requirements.we need another csr, but not availiable for

> > now.Either implement it as vendor-specific or create a community

> > extension for all=EF=BC=9F

> >

> It is upto the interpretation. I am not sure what is "active" or

> "etc" in the below statement.

>
> "The Reference Performance Counter Register counts at a fixed rate any

> time the processor is active. It is not affected by changes to Desired

> Performance, processor throttling, etc."
Per ACPI Spec,Per ACPI Spec,"The C0 power state is an active power
state where the CPU executes instructions."
=C2=A0When we say a processor is active ,it means the processor is in C0,
so the active =3D=3D C0,i think.
The following is a comparison of different architectural implementations.
=C2=A0x86
Delivered Performance Counter register----APERF:
This register increments in proportion to the actual number of core
clocks cycles while the core is in C0. The register does not
increment when the core is in the stop-grant state.
Reference Performance Counter register-----MPERF:
This register Incremented by hardware at the P0 frequency while the
core is in C0. This register does not increment when the core is in
the
stop-grant state.
ARM
Delivered Performance Counter register----AMEVCNTR0_EL[0]:
The counter increments on every cycle when the PE is not in WFI or WFE
state. When the PE is in WFI or WFE state, this counter does not
increment.
Reference Performance Counter register-----AMEVCNTR0_EL0[1]:
The counter increments at a constant frequency when the PE=C2=A0is not in
WFI or WFE state, equal to therate of increment of the System counter,
CNTPCT_EL0. When the PE is in WFI or WFE state, thiscounter does not
increment.
RISC V
Delivered Performance Counter register---Not clearly defined.
Reference Performance Counter register---Not clearly defined.
>
> Second, I don't see an issue if both reference and delivered counters

> increment irrespective of idle state because ultimately the ratio

> delta(delivered)/delta(reference) matters which will be same in either

> case.
Theoretically, yes, if both counters=C2=A0 increment irrespective of idle s=
tate=C2=A0 .
>
> Thanks,

> Sunil
>

