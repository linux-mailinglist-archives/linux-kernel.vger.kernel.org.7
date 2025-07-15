Return-Path: <linux-kernel+bounces-732586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75357B06924
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC99F16EA97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791B2459FA;
	Tue, 15 Jul 2025 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuax+szX"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA61953BB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617749; cv=none; b=Bm4VLj3BZUcwsE12KTlVSUys2eaRnrZ8kBPv/prriqp5EjHTK5CxkBe84/8SS7n0Wph7/MjXN3qPm/WaTlVHbAzWLFz20c+xISxF6HpfQYHzgZuG3ql8qbTxa+fzduPSD36TGujlOkwFv9koZhvcJ64F/LJXtsqaxlsxnE9XZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617749; c=relaxed/simple;
	bh=RO6DymqDttAzfSCmCcd7S0ukcT3GLumPAtUq1OLOWt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncOI1iHz7dTJJwPIP0NytlF3S+iTV1wim9Q7RsHkP7A4lwdTlUeHz2D1QAPh0UWUZT9s16RhK6ychc4bLMv3D9Zb6MZY47DHNuKwxq6OAmVWWQovpVkExT4sf18Z28uvVFP2JY22JTNCEd3jP2PbktZBXDqAZt7dqSCDHRQ3gKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuax+szX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so3392894f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752617740; x=1753222540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM+65DlZuMtswqqV8Qae3QMSQW7h28+G8WpIhXyY6to=;
        b=kuax+szXrztMfRmKJgRbHFI5SqhP9i+c15FI+MbFJXVmBo2SoM5uc2SL7bIep39D2a
         wKKAKn5+QVCgjUzift8ZcNL1PqQf9+ouRRZFopIWsvwcijkMr3X1h5XisoZ2hQcErISu
         D3PScbx+Q6xosNTM3PANPxHNlQytWW8MPlzBTBiZm0Qe61PgWmNlxtASTkz+RyO3BYSV
         AXbDgskzj+vFk8XfGWzq4eRZWJGo6Nj3vWUBzeWl4ekyUOPjjdNhXKiAF8dVXNT3NtaI
         PuME6z6TkKkO0p/6wPecPI5h3mKXUj9oSc8gTxivzO6YrKzI79Wm8dqEGtJXFyXamCs9
         Ua1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617740; x=1753222540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hM+65DlZuMtswqqV8Qae3QMSQW7h28+G8WpIhXyY6to=;
        b=J+uZppTG2vbeRkIpZPJRyDRXdc3F9SV+EY0crc4n/pvpgfBkM1KpdY6YmucMGy+/Wp
         V/O+AQlhPvX/2m/lUqrl+cWHlCcSpYgRFEY2++rH4sbeMv7slmtEbTf9+1P6DhTKAKn2
         zUIIRHMwXc3Kq4cu9gtkXB87JHIhuQg8t10jbrHSGSAolBpP22FEhwGFWBRE+P1VUxKG
         zXHuE3KhW6ivG7vvFw6TSekCnzmfRTKXjT9JNWkR02fU1+sx/O8mbFzutt5dbnptRcN1
         OYnrpOgb1m30T2fohef/dX40YAs11kZIs/A1+RIkxojqlE9aIKzkci5aMsoujfweW7U2
         wUwg==
X-Forwarded-Encrypted: i=1; AJvYcCUVHGdRcxGA6Xr27+UbiwhfY6jpIP0rRWPb9Ml91a1qO56UN+Z891LGlKDTdHQvR8edyMz2a6smhOhDFPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3vE/jKNiZ2ihwRKndwZltRV0J+fvhVEVonYKHsvXn3YhmeoD
	bKgPOYGOB+SB1kiZsciX+xB/xSruTVtO86oeudlu/2r/fznBk6fasrklTdt4PYOX0/590u3Klh1
	w3jF5NJHSXHmFrHqpsdMdiscx5uiUt58=
X-Gm-Gg: ASbGncvCBKtsOvkGfkpaqKRJexDQZDEsiC4jF0pFjkDQKeJeVaigljVqxKip8R0mMjG
	x/T3K9wz63DIDiuVfVkGnRddL04mJu8U2YuUCgyQG038XoWZNlO0Qs7U+xV8KY5OaNKvKQAEly2
	9r1NZ3/uB4kpurkau3RbjnEbC1oWJX6w7LEoH7McuWb9lS1SYQ+H7llaF5RssyZ1qsK0cBtwrdL
	owtfGaB
X-Google-Smtp-Source: AGHT+IHIg/11IOI1UvwDXrQrF9FvmKDQpmWNgXnUiQo6BHAbAVnO7D1M71U5c0urqNVSgXdTQuX71SwkiXwvr2Drbm8=
X-Received: by 2002:a5d:64ee:0:b0:3aa:c9a8:a387 with SMTP id
 ffacd0b85a97d-3b60e446e70mr158604f8f.0.1752617739844; Tue, 15 Jul 2025
 15:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623231536.1120282-1-Mr.Bossman075@gmail.com> <aHY0mWEx8_z_nJoU@mai.linaro.org>
In-Reply-To: <aHY0mWEx8_z_nJoU@mai.linaro.org>
From: Jesse T <mr.bossman075@gmail.com>
Date: Tue, 15 Jul 2025 18:15:03 -0400
X-Gm-Features: Ac12FXzBzUkaCQ2uspQJV8eldICbB0xAjArutA46vBdfRIUXxrzha0-2-ATwUG8
Message-ID: <CAJFTR8S=EKRG93sGYDr4tKTdmiEMdC+tyaDGh1e_n28fKr6+kg@mail.gmail.com>
Subject: Re: [PATCH v6] clocksource/drivers/timer-clint: Add T-Head C9xx clint
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Icenowy Zheng <uwu@icenowy.me>, Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:59=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On Mon, Jun 23, 2025 at 07:15:36PM -0400, Jesse Taube wrote:
> > From: Jisheng Zhang <jszhang@kernel.org>
> >
> > To use the T-HEAD C9xx clint in RISCV-M NOMMU env, we need to take
> > care two points:
> >
> > 1.The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> > implement such support.
> >
> > 2. As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer:
> > add a quirk for lacking mtime register") of opensbi:
> >
> > "T-Head developers surely have a different understanding of time CSR an=
d
> > CLINT's mtime register with SiFive ones, that they did not implement
> > the mtime register at all -- as shown in openC906 source code, their
> > time CSR value is just exposed at the top of their processor IP block
> > and expects an external continous counter, which makes it not
> > overrideable, and thus mtime register is not implemented, even not for
> > reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> > extended CSR, these systems still rely on the mtimecmp registers to
> > generate timer interrupts. This makes it necessary to implement T-Head
> > C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> > reading mtime register and falls back to default code that reads time
> > CSR."
> >
> > So, we need to fall back to read time CSR instead of mtime register.
> > Add riscv_csr_time_available static key for this purpose.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > ---
> > Treat this as a completely new patch, as it is mostly rewritten.
>
> [ ... ]
Yes, Jisheng Zhang was the original author, but the patch serves the same g=
oal.
I used their code as a starting point, so I kept the sign-off and
commit description.

>
> > V5 -> V6:
> >  - Add csr_clock_next_event
> >  - Add csr_get_cycles64 to sched_clock_register
> >  - Break get_cycles64 into csr_get_cycles64 and clint_get_cycles64
> >  - Change default behavior to use CSR time register
>
> [ ... ]
>
> Any comments for these changes from the arch maintainer ?

I don't understand? Are you asking Jisheng Zhang?

>
> Thanks
>
> --
>
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

> > +static int c900_clint_clock_next_event(unsigned long delta,
> > + struct clock_event_device *ce)
> > +{
> > + void __iomem *r =3D clint_timer_cmp +
> > + cpuid_to_hartid_map(smp_processor_id());
> > + u64 val =3D clint_get_cycles64() + delta;

This line should be:
u64 val =3D csr_get_cycles64() + delta;
I messed up when splitting csr_get_cycles64 and clint_get_cycles64

Thanks,
Jesse Taube
> > +
> > + csr_set(CSR_IE, IE_TIE);
> > + writel_relaxed(val, r);
> > + writel_relaxed(val >> 32, r + 4);
> > + return 0;
> > +}
> > +

