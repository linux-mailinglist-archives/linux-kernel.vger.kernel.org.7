Return-Path: <linux-kernel+bounces-749002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D0B148C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D911893BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878082586FE;
	Tue, 29 Jul 2025 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV+AC9Sm"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E502253A5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772020; cv=none; b=XBCBpbuQDCviV4fJndrCFVY2NFLFrlBQWu69fWVzj/sMKz8Mt/tkUrMiQNRtF6KH4q/INrJXUZKXydeW+fUsDKxtcTD6RFRvsHEuk26xIksGsOkPPnNPiwQzkBMejIW7hyI8lUtWC0GfKW/F/UfiyrqsB7PO19c+EIgzrnEDUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772020; c=relaxed/simple;
	bh=Qa2k+O9ONUtNQzfvM2ddzB+jWkO6eF9y9dLtD8Rhk2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSFv7R6rwQOdsQV4X6OhDMP13Umvu6ozM/I0Xp12vYXFTYEHVwB/12HUZLavPjRbKYzHtWLAHyi+tPD/4hmHfsyORHd4RHF29e6/Zn92rOhJDj9eOY587kJzqp07brJZW8xQAnQn7itYIQotdEwP1Q7d2drsx5QUSy/ELoRj5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV+AC9Sm; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-41cd87eff4dso3321539b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 23:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772018; x=1754376818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8oMrM2DG3wTSCvEAhReTE879IMPRgtKQTc5AFpwecg=;
        b=TV+AC9SmNFoaHVCokmm7V8Yb+KVgRTWaqS0oye5lC3X7s8xnEIUBFiOi8yUvEjqGtl
         D7QOx9qjYOpVSCZ0loSaGNrH6PNyVGAJV+M2NiRHkoW5HJODk6LoOuIjyZpbTCXfbFhB
         yHJlaQV1UkKQWHK6g6rYFvB8l9H1eFIBemcmWmD1LzxTJRSMmQgJS8HFBrkOtDsEOQWZ
         XALnOk5n5jd6eKk30hx77bEwYQx0C3jLeRoJKaCx3cLiB1L5/pHhT8AkyFaBhMJR6otT
         PIulM4nkD7ksB345qUx7XW/icbfGUkdad0c40ISgfgFtdCHB3TmnvENNnp9A/ZzkkU6V
         ijMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772018; x=1754376818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8oMrM2DG3wTSCvEAhReTE879IMPRgtKQTc5AFpwecg=;
        b=Ynj3ayChSnKfTwN3AXTuTzOStHie9qr8TE5WZZ5GAkPmJ7andQ/nXLIzoEunI2xqze
         e8s5Szu9kep+oq4nuijV6DmOOBS13PNk2jVNNL/aSIvwgEBNe+txOQ12otGdGdYZWzLZ
         NjoHKxuqTeg+1t5jCFGxjLYGL9kvFMccYON/2eWPAeMsHs7L7dJlWdK8kcCTeRQWCBwy
         ohsY1TEO1UgDG4UqtNfid/A0xJOJ1bUJ5cieG6TPS7ruMbQL92BSg7cU1bErzTzEJ0+0
         eU081r3zXmNjSisP6dIfs5bQvZAXsxtUltnolgFfolq5W2+LMZTjgeNOG3R8UAvX5OVj
         edfg==
X-Forwarded-Encrypted: i=1; AJvYcCUO401Qp/1W1y/OStabRk4Oita2YyAZVaka90CvRLZcVX7fSyNI8+ihYM32nERCVVxte0267wtydv+GhXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUx52KWvDSE7rZSUZgKl77UqodZjfOX/hogfffS53D2KU5Qt1k
	ozFBmu4Ch6bdqBj4MNnX635Nc+DJvC+3l++PigG3FQc9wgBL2izAk152BGUm0jnND3fGqJmDPjH
	dXeGMisnCwrNR26EFT+y1w3kTLgMPiwE=
X-Gm-Gg: ASbGncuNAo0IedgbOQAv2TWvse3V3Ff73lLP83qDZm9YN0kxVdz5MjUlDBVw1W4z4bM
	MDzO16PESKXt+YT4gQKhUI19Kvtnzet1FiCFTL9TO2m4wZ2vyfG1dWDys9WRTvugwx64W5Ril+1
	cJOVAontNyh2V062y5aC6de5eCGdog2S4wrHI/VsnJdiGAsm60yh5Pk/VgFIKJnxwhCZ4cksLot
	Y67OyVz
X-Google-Smtp-Source: AGHT+IGpPmfapoSxVAuAEpnGB+WPjA19xRC2eF1iMa0CxM6Qnw9RztltPYTcQ4+gK81dBl74lXZzWiMoA5skvxn3Mqk=
X-Received: by 2002:a05:6808:1304:b0:41e:9fd0:bd1e with SMTP id
 5614622812f47-42bb8c69cf8mr8317190b6e.22.1753772018360; Mon, 28 Jul 2025
 23:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729042621.6403-1-suchitkarunakaran@gmail.com> <2025072925-lint-agreement-77e8@gregkh>
In-Reply-To: <2025072925-lint-agreement-77e8@gregkh>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 29 Jul 2025 12:23:27 +0530
X-Gm-Features: Ac12FXysbuF8b_kl530HuA_WHikHLLxsbsoDwW8DimDPMjY2drtLGHEAmCj7-XA
Message-ID: <CAO9wTFg_jCUZ+DxXVDM11_715r6ALJ=HyRXkcBxhGrBUo4iVUg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/intel: Fix always false range check in x86_vfm
 model matching
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 at 10:58, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 29, 2025 at 09:56:21AM +0530, Suchit Karunakaran wrote:
> > Fix a logic bug in early_init_intel() where a conditional range check:
> > (c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_WILLAMET=
TE)
> > was always false due to (PRESCOTT) being numerically greater than the
> > upper bound (WILLAMETTE). This triggers:-Werror=3Dlogical-op:
> > logical =E2=80=98and=E2=80=99 of mutually exclusive tests is always fal=
se
> > The fix corrects the constant ordering to ensure the range is valid:
> > (c->x86_vfm >=3D  INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_CEDARMI=
LL)
> >
> > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
> > constant_tsc model checks")
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >
> > Changes since v1:
> > - Fix incorrect logic
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
> > --
> > 2.50.1
> >
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

Hi Greg,
I've a question regarding backporting this fix. Can this fix be
backported to stable kernel version 6.15.8? Also, should I send the
backport patch only after the initial patch has been merged in
mainline or linux-next?

