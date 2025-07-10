Return-Path: <linux-kernel+bounces-726198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6EAB00960
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9108B7A7342
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9295B2EAD0F;
	Thu, 10 Jul 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYIc6RCT"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1B148832
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166626; cv=none; b=mlFfaFdfSTJx9+Amxe86OvzblADGuU9pyBuSDtEZJXWU6y7IF6tX42f04IJXv3+KpjEVkvOLEWcmTv0Mo1DQdHkz4pwcydrKQheEDOVoppmqlYLmXZBRqAA9KLpEQm6dQppTG1PzWGFKq+I5iDy+gOa8GCJ/jPtTZNNWz7+s7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166626; c=relaxed/simple;
	bh=uGBD+xRo68ELT37G8AEGlW1rPI3Zz1uhIsUH8np6cFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RagXnqVy13a8Whs9vIbx29RDA4NyD6aLypXeNoGrIP4EmR4PKZBdhxPxElaj8qd7v56TIkp2XqOQ96yzVh7gCxIvEnDxyFDe0sfGExr32dWCU7bqCikF9agxHrqycY+COZ/oKhpqdhnNW8pAJUbywcWe3/6tj7mlIcJRTdz3utI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYIc6RCT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0d7b32322so183565466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752166623; x=1752771423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Ri74kT7ZHQydHthSU1dEMhblK6ufs2Kl2/e6Z/GVI=;
        b=mYIc6RCTZMHlpTEv6Ctqt/231+FC79+MXb4svaSfgTsxkZWlGaGsgg7XOrSEjhyIqc
         oDB7QWLqG5jQMnF6830DQoy9h8lbA4YIUvwqyX0z/4HAnCOdE4rYO0hqg6NslO4dDHX4
         NW8/bOAC2CUZG59bJ5+fSANRA4oVkJI8tNLwQgNlT6Ldg6EuanDEGNNtyN3qqUoBQgiY
         99kY1tfOVU+A6HCEaafjcTB6DklHW7hZor9BM1DVs8E/XXJ0sbS/gyawRpw3C7Kw+Cqb
         V8N9ArbzRK38Wu7NqdgdQ/sM3KJjDvycaCn/8vKOvv8EE5w98d4ZoznEmjh7DWoWrqIz
         j+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166623; x=1752771423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9Ri74kT7ZHQydHthSU1dEMhblK6ufs2Kl2/e6Z/GVI=;
        b=fs3aDkKp1+i+wuhq8bqOpsibBqqqhmrqasjrT0YA/esjZC9vNXMX9jcv/Rn97zPDZx
         YO0E+6ltw8l1thT+v8KCVfXy+3kcJn3tDOcYqnP5hTXEi+Fd8h3ann6b/SlLSsce+cm6
         NEYR6gYZOvjvDXdqXiKa8prz4+motXf6Rekx57Vj/ZoMihrKBI10wzAmlqpoiJqnjhpP
         YD+qWmFd8mkBdDzVk91c7YFv4EypyrIeW+tMNN3hCsMy/0y4+RyglJrpq1mpQV//uGm3
         5LDokcVCnM9pE8AI6acdPD5K0Md2SeTjix5AOp2wmKPapXjceRcSRD6VtI5tDYjpSHNV
         cDxA==
X-Forwarded-Encrypted: i=1; AJvYcCUTqV5nOHWHM576L1TfFyHw9w/uG4z0H19uRARjrMWT4KpG3ij6XsnhtjK4y+juX20g/DD5ko4AvxNxDmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VXZk5Oz2BcZxREbu0O6bE38j6YaiP54DI8ol4Jzgx3zW7H01
	7dGs1gSSs+Nktd5xpvH6iRY+xyEJHkrk53vSD3c91ENrUmNToT5jWBxoObvx
X-Gm-Gg: ASbGncuQTOPEvVdONMuRTcS8SvdJ3DmmgJ27TQUbYPu14E2uiI7LgglGJ4fgPhv8NyS
	QwYYkj853QlTR78cqJSZ/oRpg12I5uUzIpDQ7LNcf/CcpXo86d3t7FIn03dNzRWq1C1MtdH4+RQ
	6U3IizEIPeG/rdq0L05H1CgvIAJwN2D+j4CCc633iZY81POhFpKPmRtHD1zR5w1gTotyfGqB6zV
	Pvmrzi+RURhlxEdSADz0kt0CeMlnBj2AiUjMRcS7HTy1yNPlr2zQMJ1AKSJcnkff38sjLVIuhC5
	6LEeVEt2ZSGK0cr94IrH2UYhndNcS8UpurTxg6GG1eI1dXTbQ/EAbLxJqOf0
X-Google-Smtp-Source: AGHT+IGzU/Dlzc8COXQUiBNkPkzRxJR5U+b1hbru0ZWxpFK64pbTpTj+umsU1o80jBOpWOG4KlSjhg==
X-Received: by 2002:a17:907:cd0e:b0:ae6:a8c1:c633 with SMTP id a640c23a62f3a-ae6e7044e60mr340776966b.34.1752166623095;
        Thu, 10 Jul 2025 09:57:03 -0700 (PDT)
Received: from p183 ([46.53.250.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e9235esm163124566b.12.2025.07.10.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:57:02 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:57:00 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: implement "memory.oops_if_bad_pte=1" boot option
Message-ID: <72956765-39e0-445a-b381-6bbc54046544@p183>
References: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
 <525a4060-2c8b-40c5-b4bd-b9c47de94f0f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <525a4060-2c8b-40c5-b4bd-b9c47de94f0f@lucifer.local>

On Thu, Jul 10, 2025 at 05:16:52PM +0100, Lorenzo Stoakes wrote:
> Sorry but no - this seems to me to just be a hack. And it also appears to
> violate the rules on BUG_ON() (see [0]) so this is just a no.
> 
> [0]:https://lore.kernel.org/linux-mm/CAHk-=wjO1xL_ZRKUG_SJuh6sPTQ-6Lem3a3pGoo26CXEsx_w0g@mail.gmail.com/
> 
> On Wed, Jul 09, 2025 at 09:10:59PM +0300, Alexey Dobriyan wrote:
> > Implement
> >
> > 	memory.oops_if_bad_pte=1
> 
> This is a totally new paradigm afaict - introducing an oops based on user
> input, I really don't think that's sensible.
> 
> Unless kernel.panic_on_oops is set this won't necessarily cause anything to
> halt. Really you want a panic_on_bad_pte here, but that would be way way
> too specific.
> 
> So it seems like a hack just so you can get a vmcore?
> 
> You seem to be using BUG_ON() to _maybe_ cause a panic, maybe not, but by
> doing this you're inferring that there's unrecoverable system instability,
> which isf clearly not the case.
> 
> All of the bad PTE handling seems to be intended to be recoverable and
> handled by calling code.
> 
> Additionally we have uses like zap_present_folio_ptes() which use it to
> output PTE state in the instance of an invalid mapcount value - I don't
> think oopsing there would really be what you wanted right?
> 
> >
> > boot option which oopses the machine instead of dreadful
> >
> > 	BUG: Bad page map in process
> >
> > message.
> 
> I'm not sure what's so dreadful about it?

Because the root cause is unknown, happened at unknown time, dmesg
rotated away and nobody bothered to coredump the machine because it
didn't oops!

> And why an oops is better?

I apologize for stating the obvious but the less time between the bug
and coredump collection the better.

> > This is intended
> > for people who want to panic at the slightest provocation and
> > for people who ruled out hardware problems which in turn means that
> > delaying vmcore collection is counter-productive.
> 
> Seems to be a specific edge case.

Yes, but the option is not enabled by default and costs 2 instructions
on the coldest code path, so...

> > Linux doesn't (never?) panicked on PTE corruption and even implemented
> > ratelimited version of the message meaning it can go for minutes and
> > even hours without anyone noticing which is exactly the opposite of what
> > should be done to facilitate debugging.
> 
> But are there real situations you can cite where this has been problematic?
> 
> >
> > Not enabled by default.
> 
> Yeah, obviously.
> 
> >
> > Not advertised.
> 
> Umm why? Seems like you just want to add this for your own very specific
> purpose?

Sort of, I don't want to patch and unpatch things every time.

> > +/*
> > + * Oops instead of printing "Bad page map in process" message and
> > + * trying to continue.
> > + */
> > +static bool oops_if_bad_pte __ro_after_init = false;
> > +module_param(oops_if_bad_pte, bool, 0444);
> > +
> >  /*
> >   * This function is called to print an error when a bad pte
> >   * is found. For example, we might have a PFN-mapped pte in
> > @@ -490,6 +498,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
> >  static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> >  			  pte_t pte, struct page *page)
> >  {
> > +	/*
> > +	 * This line is a formality to collect vmcore ASAP. Real bug
> > +	 * (hardware or software) happened earlier, current registers and
> > +	 * backtrace aren't interesting.
> > +	 */
> > +	BUG_ON(oops_if_bad_pte);
> 
> Except that it won't without panic_on_oops?

Yes, I'll update the comment. it is supposed to be used with
panic_on_oops=1 for maximum effect.

> I mean we can't just go around putting arbitrary BUG_ON()'s like this for
> cases we want data on.

Yes, we can!

> And far worse here - this is a print_xxx() function, and you're making it
> oops? That's really bad.

It's fine because, it is conditional BUG_ON.

> Note that other page table levels can be 'bad' as well, see pgd_bad() et
> al. - none of these will be caught.

Sure, I didn't think much about spreading this option to other places.
It can be spread independently.

> Overall I suspect there's one single case you're worried about, that really
> you want to put a WARN_ON_ONCE() against - then you can panic_on_warn and
> get what you want.

Ehh, no. WARN is for home users who can maybe photo the oops and fish it
out of dmesg and make bug report -- so that system survives until their
data are flushed to disk.

I suspect users are very bifurcated: some want to panic always, some
want to panic during QA but not in the field, and then there are users
whose only hope is cellphone camera.

> If you can make an argument in favour of this that's convincing then that
> would be a potentially upstreamable patch, but this one isn't, in my view.

