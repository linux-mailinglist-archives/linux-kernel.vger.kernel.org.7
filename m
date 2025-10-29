Return-Path: <linux-kernel+bounces-877254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D7C1D935
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B64234C9CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7AE2DE6FE;
	Wed, 29 Oct 2025 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7BqExki"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582331A062
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776062; cv=none; b=A+h1PMA8L4GBXeuF53OcydlDQ3TBMZR0rkZL6iX6y4ize5iGf36Y6ocryeiKtDnWFHaVMdKt9agiD6lMiPgW0Pu4ibmZ6hTEhxBhsMOu9ibttZbFkTTHOwXr8T7v8MqgiJtMKm2D2b13sIR5BkilOyHVr3BMXhqbDBovGJF+bac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776062; c=relaxed/simple;
	bh=xzb0YPoXmlg3QHexmmAbfG4b51EgBcActh8TF84eQBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p926SrWh5/sdX66TnV4kNsleiuCpvF7lJyiP3+Uxtct1RQ8mpXvRvZgg2DAnkPj5qo5M048wFGftonbfQRLz2Wi1vKatMZaL7l2CRr8ic/XtA4uEKrA/HtzVjn0A9nNmy5d6Jfintex7HJR4jmuQBUv4Km5TYxlPyy4ZOuK4Y7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7BqExki; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4771b03267bso2593635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776059; x=1762380859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9ILiwfpPoD0N8GajmMaZ/muvcqQG+3EmnyLCkVYEyY=;
        b=R7BqExkiBOx0y+klX3E8Ej+8/GIFPd4KtQK+U9Sr2zoTPTbUSyGZI/cYcId3ooxB4g
         CRrLmLnMHlln4i7HXrpJdT/QTtA9tzSA9dTimqyrqtSABo9vM2zdqvK3ongVxzEBurJP
         R8SzK/MhxlrxeZyB8d6x7yThcNOaZbbSED8vVflZ25Hoh7LKhCZma4SG5XLSU5Qx+jsA
         FqgubRYm83Ukx6jf2m0IaQ4+W6vLhNNnRsNzx15rTSjFGMfTybX1oIF/tzkXU9fb4Soy
         PqYFlfwn34VBKt1IqdOovUM57kcw4zq3ERMAzZUOpGIXRc6Dsrok4LHXOOB+Rp4bB6SG
         g6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776059; x=1762380859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9ILiwfpPoD0N8GajmMaZ/muvcqQG+3EmnyLCkVYEyY=;
        b=Ku3IYau8S4RqROOo5lhLA35XU2rtqXKt14PH1Bwyps0LUoNKrdPVwT6zquwS/iwmP9
         d0bKO3ARGTzeG1ePhGtgw4cMrqs8zvPxj0ACEnKZXAz1WX7ye5TYkpZ6rPG4aYtYHnPh
         UXoOj5P9AdwdL18cAK352oqrsW4OuCGHoojVgwXIYFm+m7PlB++mkHHV34A87XSaPiBi
         B5fOiDlU6mGeCfYOhQnc/FR/5JG7iQnhnFKeY0jSvMkkR7MgR51GmOf9HW4u+5xitxmz
         mb7uU+7asIKnOileEDQz7KD+nWRo85clCOWn+g/dLldu549QKPjPh9xdBk5IzvtNMORh
         A9mA==
X-Forwarded-Encrypted: i=1; AJvYcCXvunALghLIppyTE+9Ic3xc2MTJw8r843waGtW1mnV5MBmIr26iDd13ZUJQMyhI2dllt3f9esaY5NssaxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsWCfCuIEZGbKib94JIq7cSED53+6aFhAdmGEEeNEU+W143eB
	YZC/X4Hb8BPFhm0oYDOkH6Dsy+yPFTN9gulOSK7O/PCkPnF7fCWqBQT8
X-Gm-Gg: ASbGnctkLMS3EMnlTc7QAYAULYE9TS6tIhWD0n3OMCJRCv5wsFlcE/Z0cce2R8ywxJo
	IfUft4DQyDavTnk/XK0sj9yZvKmuNytHFkBPWD9+JtSt4I1xRF+gwaksCPcObvqEUTAYM9iQSCG
	xa6fQPHXXLQATHUch8SDJv/X41QDvCjjVO/KSRaqJ4WNcERQuiqkEbs/udKrXTy1QbkDsYV82wH
	6+WyMsXcW9NutIRLWfsK/+WUiuugXH/w96sK22eWBKY48JZ4Sxt/rG1AXMkvmrpILl02+uB35UG
	mralDzuXEZWZIcoOKw69JmFp7w6skz/2icazDBF9Pp4Tlmzvu8S4BwPvTmLysQlr3cYnGkwZyDa
	ZfnMf6Vg70rBFHTP/kCHFvw7rS+PmRf+hXNcFIepHHrPuImkaWJSxiK0qxmFYREavpBmpiqTjk0
	Udyf8+j4NtzrbSDZgo4nkFcMKJfOt2ivosGSxE0Lm1Kw==
X-Google-Smtp-Source: AGHT+IH7hVZyzg5W409tTHabhyHEujLGhTEExVw2P2Ft0Kvd5e/XwpPelz+X0XwPPYkIpzLiT/E4RA==
X-Received: by 2002:a05:600c:3b8c:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-477267bc9e1mr7744615e9.21.1761776058686;
        Wed, 29 Oct 2025 15:14:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db839sm29654949f8f.34.2025.10.29.15.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:14:18 -0700 (PDT)
Date: Wed, 29 Oct 2025 22:14:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, Juergen Gross <jgross@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter
 Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Graf <graf@amazon.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Message-ID: <20251029221416.5b33e1fe@pumpkin>
In-Reply-To: <LV3PR12MB9265295E1470ED9C5BE9EF9094FAA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
	<20251013143444.3999-35-david.kaplan@amd.com>
	<d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
	<LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
	<754ee3ec-8819-47df-8251-dec2906a020b@suse.com>
	<LV3PR12MB9265E559972E1C6693AAE7E794FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
	<5f1fa90d-5c84-43e6-a99e-ef4a215b5055@suse.com>
	<LV3PR12MB9265295E1470ED9C5BE9EF9094FAA@LV3PR12MB9265.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 16:26:58 +0000
"Kaplan, David" <David.Kaplan@amd.com> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Nikolay Borisov <nik.borisov@suse.com>
> > Sent: Wednesday, October 29, 2025 4:37 AM
> > To: Kaplan, David <David.Kaplan@amd.com>; Juergen Gross
> > <jgross@suse.com>; Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov
> > <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> > <jpoimboe@kernel.org>; Pawan Gupta <pawan.kumar.gupta@linux.intel.com>;
> > Ingo Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> > x86@kernel.org; H . Peter Anvin <hpa@zytor.com>
> > Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> > <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for alternatives
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On 10/27/25 16:19, Kaplan, David wrote:  
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >  
> > >> -----Original Message-----
> > >> From: Nikolay Borisov <nik.borisov@suse.com>
> > >> Sent: Monday, October 27, 2025 6:35 AM
> > >> To: Kaplan, David <David.Kaplan@amd.com>; Juergen Gross  
> > <jgross@suse.com>;  
> > >> Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter
> > >> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>;  
> > Pawan  
> > >> Gupta <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar  
> > <mingo@redhat.com>;  
> > >> Dave Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> > >> <hpa@zytor.com>
> > >> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> > >> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> > >> Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for alternatives
> > >>
> > >> Caution: This message originated from an External Source. Use proper caution
> > >> when opening attachments, clicking links, or responding.
> > >>
> > >>
> > >> On 10/15/25 16:45, Kaplan, David wrote:  
> > >>> [AMD Official Use Only - AMD Internal Distribution Only]
> > >>>  
> > >>>> -----Original Message-----
> > >>>> From: Juergen Gross <jgross@suse.com>
> > >>>> Sent: Wednesday, October 15, 2025 5:38 AM
> > >>>> To: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
> > >>>> <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter Zijlstra
> > >>>> <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Pawan  
> > >> Gupta  
> > >>>> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>;  
> > >> Dave  
> > >>>> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> > >>>> <hpa@zytor.com>
> > >>>> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> > >>>> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> > >>>> Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for  
> > alternatives  
> > >>>>
> > >>>> On 13.10.25 16:34, David Kaplan wrote:  
> > >>>>> Save the existing instruction bytes at each alternative site when patching.
> > >>>>> This is only done the first time, and these will be used later to help
> > >>>>> restore the code back to its original form.
> > >>>>>
> > >>>>> Signed-off-by: David Kaplan <david.kaplan@amd.com>  
> > >>>>
> > >>>> Instead of saving the original instructions at runtime, why don't you
> > >>>> expand struct alt_instr to have an additional offset to a saved copy
> > >>>> of the original instruction, located in .altinstr_replacement?
> > >>>>
> > >>>> The new field should be guarded with #ifdef  
> > CONFIG_DYNAMIC_MITIGATIONS,  
> > >>>> of course, like the added handling in the ALTERNATIVE() macros.
> > >>>>  
> > >>>
> > >>> That's an interesting idea, I think that could work.  That would make the kernel  
> > >> image on disk (slightly) larger though, as the original bytes will essentially be
> > >> duplicated (at the original location and in .altinstr_replacement).  I'm not sure  
> > which  
> > >> is the better trade-off (kernel image bytes on disk vs runtime memory usage).
> > >> Although I think we're talking about a relatively small amount of memory  
> > regardless.  
> > >> Most of the runtime overhead of dynamic mitigations comes from remembering  
> > the  
> > >> call sites/returns.
> > >>
> > >> It's not just about memory usage per-se but also memory pressure from
> > >> allocation and the resulting fragmentation, though I'd think that
> > >> majority of the allocation will fit into kmalloc-32 bucket, still having
> > >> them as part of the kernel image eliminates the additional allocs.  
> > >
> > > I see.  Just to understand, the issue is more with the numerous small allocations  
> > right? (that is the kmalloc at each alt_site)  And less about the single large allocation
> > of the array?
> >
> > Yep, do you have some statistics how many allocs have to be done?
> >  
> 
> On a typical kernel, I'm seeing 6427 kmallocs() from this with a total size of ~36kb.
> 
> If that is too many, another option could be to go through and figure out the total size needed and then do one big allocation.

Is there also an 8 byte pointer to each allocation? They add up as well.
Is may be worth doing multiple (say) 4k allocations in a list (or array of pointers).
Then the pointer can be replaced by an offset into the overall 'big buffer'.
Align the entries (a bit) and maybe a the 8 byte pointer can be replaced with
a 16bit index?

	David


> 
> --David Kaplan


