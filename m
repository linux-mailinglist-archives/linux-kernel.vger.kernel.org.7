Return-Path: <linux-kernel+bounces-750175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09808B15820
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AD618A4368
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8431B413D;
	Wed, 30 Jul 2025 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiBtMB5X"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C57262D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753849825; cv=none; b=Eu73/YlR0IBwhbDTtIAAzkojRIKKNQD4aZfQsHkLRXzkcVhd4NzymDKHJ3CPQjy3587o6hCClo9VEw/d3lRbP/UdAw0HfbObpSg5R7sVytiWpOknkwLL5wxAzHJPfy2GXFuVh74bY0lbkHkCSk1CzwhY6EO2V8KOIsb8Q3I1VKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753849825; c=relaxed/simple;
	bh=HMp2CKNGnViSc+r9MfUxOE7NXI/wqzOvo8qYr3MLSGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aonlJ7RMLJSuPYiGsoig+MAnSpePwATpFUfotFew3W5rxJbLJwnrcusZ5y1sdquSCy9UZpFd8sZbJIfC11NKhCeC+3rd4FWopAHE5gRnjyc+kXSRdNDS0GZxnGCQShTkx70WlYDzdGPUcYY8Zqaftu2ba9K9VZVEgLjiaMKYz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiBtMB5X; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ff9b45aec2so2991146fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753849823; x=1754454623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2CvVUg7UlxR06MNM+bpdN0xAEBcFMMoZOjG6hEB23g=;
        b=QiBtMB5XbDdFfxrJOcVqtGr+66yT7qLVhUKP+nGrFaBL/cMmYnDEqbqoeaAh070a0C
         3F6D3LJ+GaMtRx8VZAym+rkvQXx8xi4qLbEuENr7A8M6QD0YOMqgnwtlNHJAce6TEeiQ
         t5Uiy4BAL0m1TXq0ccGLJmdB/6zFmcnyk/iZNsiG+imyD8s+lDD3bFMQXThzTx+CR1WY
         F9cR04gud6d0y11suV44HrqcjgSp/ZvIi+1IeJ7nKS0g2ZeHy+8cChH8Oqwo5woA1PQE
         jqIUkmlX0uDmJxWHMBMpzC52i1mTcJdiahhLjFRyYGW5TSsakZQJxmnvmzZnRIJsRGw6
         7eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753849823; x=1754454623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2CvVUg7UlxR06MNM+bpdN0xAEBcFMMoZOjG6hEB23g=;
        b=kE4lEetcqvabIoe3TjCXoWHYnf+8pHMd/lUvpWpFyrtPfYo1NRdyvZtkGefy5Xg+SD
         r7KwEgucscwl+xUJmIPWYpwsyTm6LMryoWMDsUCZehFVVlnFglvJqrtOd7NB2PpWgN6j
         up90X8gVcRjqFAyTqoJHNSzRQXpRJNSLhCX7FVZ+oMo0fSLZDy3T1iMqVtjV6mX5MmG/
         +Zk1hEJ2js7kgZcFPYY+Yv6ESC8Uu0hc5K7h5Putok70cIcsj1O15/RQ5XBGkmUXdKex
         U2bYC4kVZhyMTdjNXBQ0bJVjuexyb6pVLlobZ0lNAte1GCiVYo7izCUXwnArjNs0heZm
         aLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUop0qtWQ3nK1ACYFrprfxfpVGz4UKh/i6IKQ0gWQhiXPolM6yEB9/w0yIBdExNHyZqkgss4cn34nJurbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDTkLqRjHkeuxBctCs2GL/PxAZAJQVmtlUOjak2w0KnZjSReCe
	tOTLoRzFyAvZS1L+LvWxyrLQdpJSzOMolzxPblVA1b6XdiyRkZ9o1XD01tKJE2w5HwIWIIi9Ns3
	Lif2jEckjzzTApa/M6K8cIcGCnDiUJTo=
X-Gm-Gg: ASbGncvgY8DzGrBK5UA/aTN1Ik4vbAiXhRnysEAkChlWAgL0wk/TCHCDRLCXhT2DD3E
	Wxks2pxJiDehP4cF5neLKOg6Ad0ZO1Pjro/Mvme2svzIJrB3c36VXd6b8Wwnj+bv8yxze7HgRq0
	Wf++Hq9UdA75+DVJgGJl2hi/5QiUNoMaOxgDbq3BSSbS/B//NnPZJS7+iNW6i4adLp/9k5kISIV
	ZtoRd6G
X-Google-Smtp-Source: AGHT+IF787ik2qzT2D+nRo5/5UNOd9UVCJkB7Jl9qjVV5oS2oJbxwMLYJIpraq/VuVyMpjP9Fl8ACnvF2rWBTojz2PU=
X-Received: by 2002:a05:6871:ac0b:b0:302:5dba:5ae0 with SMTP id
 586e51a60fabf-30785bb217amr1081081fac.20.1753849823172; Tue, 29 Jul 2025
 21:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729042621.6403-1-suchitkarunakaran@gmail.com> <2d30ee37-8069-4443-8a80-5233b3b23f66@intel.com>
In-Reply-To: <2d30ee37-8069-4443-8a80-5233b3b23f66@intel.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Wed, 30 Jul 2025 10:00:11 +0530
X-Gm-Features: Ac12FXyj4GOgaeK_kpw9TvOD7fMYxzphMMdpcX3yL9OmsAq_Ysak0jlC3UqItIE
Message-ID: <CAO9wTFgB_5tiVj5boPpgWtYd2O+49oyUemdcWVP9+vpZri=Nmw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/intel: Fix always false range check in x86_vfm
 model matching
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	peterz@infradead.org, ravi.bangoria@amd.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jul 2025 at 00:20, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> Though the title is correct, it is better to make it more precise.
> Something like:
>
> x86/cpu/intel: Fix the constant_tsc model check for Pentium 4s
>
> On 7/28/2025 9:26 PM, Suchit Karunakaran wrote:
> > Fix a logic bug in early_init_intel() where a conditional range check:
> > (c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_WILLAMET=
TE)
> > was always false due to (PRESCOTT) being numerically greater than the
> > upper bound (WILLAMETTE). This triggers:-Werror=3Dlogical-op:
> > logical =E2=80=98and=E2=80=99 of mutually exclusive tests is always fal=
se
>
> We can focus on the why instead of how this error was found. How about
> wording it as below?
>
> The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
> wrong. Since INTEL_P4_PRESCOTT is numerically greater than
> INTEL_P4_WILLAMETTE, the logic always results in false and never sets
> X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.
>
> The error was introduced while replacing the x86_model check with a VFM
> one. The original check was as follows:
>
>         if ((c->x86 =3D=3D 0xf && c->x86_model >=3D 0x03) ||
>                 (c->x86 =3D=3D 0x6 && c->x86_model >=3D 0x0e))
>                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>
> Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
> Cedarmill (model 6) which is the last model released in Family 15.
>
> > The fix corrects the constant ordering to ensure the range is valid:
> > (c->x86_vfm >=3D  INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_CEDARMI=
LL)
> >
>
> This line is unnecessary. Changes that are easily observable in the diff
> below don't need to be described in the commit message.
>
> > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
> > constant_tsc model checks")
> >
>
> The "Fixes:" line doesn't need to be broken down into multiple lines.
> All of it can be on the same line.
>
> For patches being reviewed for upstream, adding a stable Cc (Option 1 in
> the stable documentation) is the easiest and preferred way to
> automatically trigger submissions for stable.
>
> In this case, include the below Cc: line after the Fixes: line.
>
> Cc: <stable@vger.kernel.org> # v6.15
>
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >
> > Changes since v1:
> > - Fix incorrect logic
>
> Patch-to-patch changes should be below the --- line. That way they will
> get ignored when the patch is applied to the maintainer's tree.
>
> > ---
> >  arch/x86/kernel/cpu/intel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > index 076eaa41b8c8..6f5bd5dbc249 100644
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
> >       if (c->x86_power & (1 << 8)) {
> >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >               set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> > -     } else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D =
INTEL_P4_WILLAMETTE) ||
> > +     } else if ((c->x86_vfm >=3D  INTEL_P4_PRESCOTT && c->x86_vfm <=3D=
 INTEL_P4_CEDARMILL) ||
> >                  (c->x86_vfm >=3D INTEL_CORE_YONAH  && c->x86_vfm <=3D =
INTEL_IVYBRIDGE)) {
> >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >       }
>

Hi Sohil,
Thank you very much for your valuable feedback. I have incorporated
all the suggested changes and sent out the v3 patch. Could you please
review it?

Thanks,
Suchit

