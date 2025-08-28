Return-Path: <linux-kernel+bounces-789361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D0B39451
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6176F7AE5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2A2BDC2A;
	Thu, 28 Aug 2025 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ue6oc2H3"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DB27A448
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364121; cv=none; b=XnqoY+GdfJgzluuNfqs+1cBmddJm5mA6lGmmB55N//VFhvxQ7W3tRzlOfEujjYsooUI0I9ms+9IsGTy2L/3X2aGF4O2glQtwrW2P7aEBtFCn333NLgdGG7SGEAxrnt59WRGB1zZvZ2a/hIMdIm6atXcWZxSnhTovBP+iyMSFuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364121; c=relaxed/simple;
	bh=9zk7MaZVnq9C9qg4ybe/c98j7g9Kh38l1+dwNY+aMAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbGmw3MFJFPXCLyWzJ2n34n4nmlG7AE1QDqbAbAAT+K0Kx/SLCHcT/rn/vuCwhZkR9iRkBP/YWHeqMWZNsEzcxI2KcD+c/ambcKALUOnb+aLq39P+BwpyH20efbe6hnZMvbNds2FVjzdkyMtotvoElyQ7AiN5qG/dJqbMh6RdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ue6oc2H3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb72d5409so95893666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756364118; x=1756968918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfykkSEaqRihdwJK+71Zkm/Ir0bH5rnOYiT/o5ljlio=;
        b=Ue6oc2H32Xl9mmSrF5jb361DiT4fI7Sez/cE4o0Ir8cYlokwc7VxBL//c7JRTuhjdG
         kEBC+z8isfMHjWyCovTPx3cugEehuitdjx66Qj3Pk3/uDB3Ej3xkV5TOhkqQDzV/hLbS
         qNRbhWHnzSfDakh8dBgom/U87r+vJrb/1wzHF5kzHH5psOTIulF5DjCFHEzdNwwgcIwk
         OAHf1WtaDGYWgagtNl+WDmphcmFDttJnRxSMM586x2PKKZSWUgfsQ9fM0oUVQtZhxWSU
         oLIQQxI6kt0BwPlWMcHj8COVQJJRDw8ZG+H1a+qAEEOVLRffe/GxmVS9IPKqJG4D2LdZ
         GP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364118; x=1756968918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfykkSEaqRihdwJK+71Zkm/Ir0bH5rnOYiT/o5ljlio=;
        b=bdtWT3Z5FQeukm8NoLn7Wo1BdwoW6JRDFQD6tu06MGW5Q8Cv04wcNv9Ppgce34ifmq
         GC0QRufWxIRQ1ZKq61vkTEwGWCq8zw/HlboJArbfvZwyWrCk9/rpFxzCsgWRvhY4FtW7
         BEmwCbg0XUZ8NY5g3PHpGDJqKVrwrilEa/TCiMqU5xIU9gnB4YaTlt470LfCRcDsD1Fw
         RRPES19C/tU6gVPqWa6dX98upSQUa9HOq03DvMLvM9tLLq3vh0CJAHuZSskTV3Y9N/u+
         SyUq1nsnZVx8H9H7zl8rEGE1MLvmXdx9WUDlhGt9JDe7srdkkXI4VpHcR+V8FaH9I4bP
         CL1A==
X-Forwarded-Encrypted: i=1; AJvYcCWsWsK3c0GSWydkVPky0xiAELNbmS3a/RKbFwczmJjXqyfCDwj01UHZFi4IAN1oNezIJ6nfvHxhOiNv5Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Re+glfvvyqgBcgtEIhYo1vIjFlB24dGZ9VDPVcr4J4aXQryy
	mP/vyAtFMbDq6m+X1rpq7TkWa1JS7QJXQnFc34Zcx3G4yWh/ENGMUh+VDLkuumXjkpVkKDcWMMk
	m8MFDG/qw7wtpVuDxwufRQBFE6MtVexUm/qfdXlni
X-Gm-Gg: ASbGncsZyec9QYeLdPMViz9NYX1LRB/lslqXVHfJB73uofR/4Ua1IJ/D06C5Y8DggHq
	b0RH+F7U8SDwtXhBecQn6xAAmV//EHiWcWSQVEoDUPErSw0o6OlrVrxc0PWDZV73fzuqdMEBhZA
	PiBjsIWeOW5kNkmZ2x2L6qE+H1XmkL4K0YRQsAAwDzBHM4a4AA4dqLf6ZBd/pj2WRBYhoq3hZqg
	ChA2MxTGPV9S0MJNbCAQpI=
X-Google-Smtp-Source: AGHT+IHepmoLe7owuQg/ttGnou7IrSd6gNUs+MxMKC2XYHdwpqQpe1mB7KTbQs4YRPtZx203Vm/GoSCY0OvajzsBYRQ=
X-Received: by 2002:a17:907:3f23:b0:afe:c2fd:32c9 with SMTP id
 a640c23a62f3a-afec2fd38ffmr469942066b.46.1756364117529; Wed, 27 Aug 2025
 23:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-45-ardb+git@google.com> <20250811174034.GRaJorEmcBfLTDhWml@fat_crate.local>
 <c9bb1b3f-17ce-254f-5d0f-ae3563b03b50@amd.com> <20250811190306.GAaJo-ai4M2aVod6_V@fat_crate.local>
 <38f6fa08-41fb-4717-9763-39ec5fa54075@amd.com> <CAMj1kXGY7-ZmQbUnw-KtMq6HG-o9xUNmb7KMHAzdBBbWBmGo=g@mail.gmail.com>
In-Reply-To: <CAMj1kXGY7-ZmQbUnw-KtMq6HG-o9xUNmb7KMHAzdBBbWBmGo=g@mail.gmail.com>
From: Ard Biesheuvel <ardb@google.com>
Date: Thu, 28 Aug 2025 08:55:06 +0200
X-Gm-Features: Ac12FXwiuUhjnwsNDrkZiGd14sRet2k3w2d5l8TyhOvAPASb-aRAp7vujbAgfAw
Message-ID: <CAGnOC3YsE3p4JA0=mswVHhEC_AK3PMSpPRcLCe5HYY3RDJKUUA@mail.gmail.com>
Subject: Re: [PATCH v6 21/22] x86/boot: Move startup code out of __head section
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nikunj A Dadhania <nikunj@amd.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:50=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Thu, 14 Aug 2025 at 19:17, Tom Lendacky <thomas.lendacky@amd.com> wrot=
e:
> >
> > On 8/11/25 14:03, Borislav Petkov wrote:
> > > On Mon, Aug 11, 2025 at 01:05:42PM -0500, Tom Lendacky wrote:
> > >> Yes, that works. Or just get rid of snp_abort() and call
> > >> sev_es_terminate() directly. Secure AVIC could even use an
> > >> SEV_TERM_SET_LINUX specific code instead of the generic failure code=
.
> > >
> > > I *love* deleting code. Here's something to start the debate:
> > >
> > > ---
> > > diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/star=
tup/sev-startup.c
> > > index 7a8128dc076e..19b23e6d2dbe 100644
> > > --- a/arch/x86/boot/startup/sev-startup.c
> > > +++ b/arch/x86/boot/startup/sev-startup.c
> > > @@ -135,7 +135,7 @@ static struct cc_blob_sev_info *__init find_cc_bl=
ob(struct boot_params *bp)
> > >
> > >  found_cc_info:
> > >       if (cc_info->magic !=3D CC_BLOB_SEV_HDR_MAGIC)
> > > -             snp_abort();
> > > +             sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED=
);
> > >
> > >       return cc_info;
> > >  }
> > > @@ -209,8 +209,3 @@ bool __init snp_init(struct boot_params *bp)
> > >
> > >       return true;
> > >  }
> > > -
> > > -void __init __noreturn snp_abort(void)
> > > -{
> > > -     sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> > > -}
> > > diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.=
c
> > > index 39e7e9d18974..e389b39fa2a9 100644
> > > --- a/arch/x86/boot/startup/sme.c
> > > +++ b/arch/x86/boot/startup/sme.c
> > > @@ -531,7 +531,7 @@ void __init sme_enable(struct boot_params *bp)
> > >        * enablement abort the guest.
> > >        */
> > >       if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
> > > -             snp_abort();
> > > +             sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED=
);
> > >
> > >       /* Check if memory encryption is enabled */
> > >       if (feature_mask =3D=3D AMD_SME_BIT) {
> > > diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm=
/sev-common.h
> > > index 0020d77a0800..01a6e4dbe423 100644
> > > --- a/arch/x86/include/asm/sev-common.h
> > > +++ b/arch/x86/include/asm/sev-common.h
> > > @@ -208,6 +208,7 @@ struct snp_psc_desc {
> > >  #define GHCB_TERM_SVSM_CAA           9       /* SVSM is present but =
CAA is not page aligned */
> > >  #define GHCB_TERM_SECURE_TSC         10      /* Secure TSC initializ=
ation failed */
> > >  #define GHCB_TERM_SVSM_CA_REMAP_FAIL 11      /* SVSM is present but =
CA could not be remapped */
> > > +#define GHCB_TERM_SAVIC_FAIL         12      /* Secure AVIC-specific=
 failure */
> >
> > We can get specific if desired, e.g., GHCB_TERM_SAVIC_NO_X2APIC
> >
>
> I'll fold this in for the next revision, and we can take it from there.

Actually, it does not appear to be in tip/master yet so I am going to
ignore it for now.

