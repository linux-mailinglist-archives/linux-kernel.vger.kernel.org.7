Return-Path: <linux-kernel+bounces-795974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3AB3FA36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F0B1B23354
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7B2EAB76;
	Tue,  2 Sep 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVOvCzGX"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D42EAB85
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804940; cv=none; b=XDyvmPWDbj1bYVPnd2vAXhas5em4/NlpXf8kz2GuKabGaw6RtT9Q6ktXeJUFhm38VRgBvdhLLzzNvukPYMOCwyHK+sdTuI1V9EeTxfgpI6m5KkggRmsiqIws9V9xpO1xedPsPL0QH32kIICeZh3YTTGHb3XdCYNE6bKSd7rvZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804940; c=relaxed/simple;
	bh=JfU+C/+WNXrTU6x82nBJAMdCHq7IaWEhD6JeQAiASiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSxaBeeT2nX4O7byoFCgM2bGqZEI0+sGge2qq7R9CvqAAaOEQTcaFuuV92qdsW9a28EcShJQFM5xzAmC2wPmGk/attMYiJnvfr+Xda7vwtllE0XmkvQl/mFzYsOi52/B6i7u+HIgh7clmLggVn0weCu52ybTuFX0B9LWIL5JzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVOvCzGX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b327480fd0so849521cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756804937; x=1757409737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UEJ7Ey14mWS9ux2fnI3lv4hByDSn+Z0hPpiKOiV6hv4=;
        b=NVOvCzGXhNGXE0f8qvNnt46AZPm2dFHsdNCjOnnUIM51nDTV/UI/ESKLmDvoz6mCLE
         qa1atM7WiODqN4mXPzwRndiYx7NJbphcMC3hHQxPx/9l33qESQsH/7/vnxGfAmT/dwfD
         NVvXOf6rHRG7XGQ/dbm+2Vs60RqYx9kKMnSaz4MZwaCPUMdwsLkIJ+QELLX/Yezi/KCJ
         ga46bUDbTidFFQO8iDChebbmGWwbL+HhV4iX38w82ZW1lQ8gxA6/nv2aBdGhqw2vxku8
         vhXbdOkrCJt4SNVrMGo2AQ6Iy9EbnwyJK0/Noo4lK6bSVCWTRBLbzytbjEZLHAqgWyFu
         Qc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804937; x=1757409737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEJ7Ey14mWS9ux2fnI3lv4hByDSn+Z0hPpiKOiV6hv4=;
        b=FBj1bRvTbCj9ajuIWiycWinFEIMtTYXcUVwy2u065K1BUfTgaHSaRaNYdo+JWYUwAT
         cA3hYt8Jba3CHxTbhtUtGloCBgofq2fcRU1IfvcoAY8n6OjoF8zadsZn3tqp819yYtAK
         +GcewPX6HZ58bscE6GhklV9BbgPb4cJl+x8uD59RuIl1zI3epD3OU9vIYQoDRXnROj2i
         VsEJqsGfuq930/+WoS/i/YeErr3eatlOJTI1JzdAB77iAfZhFFiQFPn2Shfsy/025Vav
         WuAX2lZPKpBMpYnAM7FYKWwwMzd52lnswPl2bYwn+AZPyPINmfgj/ErP3IFzg5EBswWX
         GVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP5Teq3knAOc9FpllDF2Ok9TGpq+D6Dk7Uqqb/dUtjs25e6rrWtc8V5lbTEd0994A4bJsFb7OtrtCEJ1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOrYH5orcTQ/3r8cVnJjrred/a3A9EH8Te3dEXriZdEx3rvey
	emUFK+D2JBYR5sGyBG57Vxa2OblySit2usSTRUoAcOs6fhhFBOm4P4E3N2o/8DXszeGDwycwnq1
	F60WUM/8VWz5k/2GJ3Cf0ZgSnqqH6r5E7bv02e6nM
X-Gm-Gg: ASbGncuFJW+gNKRmkmBveBczq3eZEkuarHDVG18m/fHTMhQ5RAsMWEuT5Yu4WtusIFc
	H8EvarK/YMEGmwhHAxKBNRylqbd46c19TldenpSLG+Bx5fxwvaM5lcT+2POKe8k5XCXiekhN17m
	o8o3N7NXTERONkcjJCmwq8PsFvcSEhhbj/pX9155xpBYInd5xrKG3Esb2JVxjLSTyUjTu3Ew3Lj
	qnXsyZX6f9G0zg=
X-Google-Smtp-Source: AGHT+IE/365ZPa2na0I+61w5kSKHeQK2w8xYgvB2r/DuNmzeiSpIrPg40UHX6ZyJ0CzihYKx7admZMRUkLUk8hCwjvo=
X-Received: by 2002:ac8:5a56:0:b0:4b3:8ee:521b with SMTP id
 d75a77b69052e-4b31b0e2753mr12638851cf.0.1756804936638; Tue, 02 Sep 2025
 02:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EHjTxymfya75KdOrUsSUhtfmxe180DedhJpLQAGeCjsum_nw@mail.gmail.com>
 <20250902091810.4854-1-roypat@amazon.co.uk>
In-Reply-To: <20250902091810.4854-1-roypat@amazon.co.uk>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 2 Sep 2025 10:21:40 +0100
X-Gm-Features: Ac12FXxFB1Y6AnaQmou77bzNFiPMi0bpB9wRe5PhLp9QE0Dg7CKdLpI-R4eIPWU
Message-ID: <CA+EHjTz1JxOy=E3p=So2q+k=UK3cDG6C8gOUgA9NQEpqRdhW5g@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] mm: introduce AS_NO_DIRECT_MAP
To: "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "ackerleytng@google.com" <ackerleytng@google.com>, "david@redhat.com" <david@redhat.com>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "will@kernel.org" <will@kernel.org>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 10:18, Roy, Patrick <roypat@amazon.co.uk> wrote:
>
> On Tue, 2025-09-02 at 09:50 +0100, Fuad Tabba wrote:
> > On Tue, 2 Sept 2025 at 09:46, David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 02.09.25 09:59, Fuad Tabba wrote:
> >>> Hi Patrick,
> >>>
> >>> On Mon, 1 Sept 2025 at 15:56, Roy, Patrick <roypat@amazon.co.uk> wrote:
> >>>>
> >>>> On Mon, 2025-09-01 at 14:54 +0100, "Roy, Patrick" wrote:
> >>>>>
> >>>>> Hi Fuad!
> >>>>>
> >>>>> On Thu, 2025-08-28 at 11:21 +0100, Fuad Tabba wrote:
> >>>>>> Hi Patrick,
> >>>>>>
> >>>>>> On Thu, 28 Aug 2025 at 10:39, Roy, Patrick <roypat@amazon.co.uk> wrote:
> >>>>>>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> >>>>>>> index 12a12dae727d..b52b28ae4636 100644
> >>>>>>> --- a/include/linux/pagemap.h
> >>>>>>> +++ b/include/linux/pagemap.h
> >>>>>>> @@ -211,6 +211,7 @@ enum mapping_flags {
> >>>>>>>                                     folio contents */
> >>>>>>>          AS_INACCESSIBLE = 8,    /* Do not attempt direct R/W access to the mapping */
> >>>>>>>          AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
> >>>>>>> +       AS_NO_DIRECT_MAP = 10,  /* Folios in the mapping are not in the direct map */
> >>>>>>>          /* Bits 16-25 are used for FOLIO_ORDER */
> >>>>>>>          AS_FOLIO_ORDER_BITS = 5,
> >>>>>>>          AS_FOLIO_ORDER_MIN = 16,
> >>>>>>> @@ -346,6 +347,21 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(struct address_spac
> >>>>>>>          return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
> >>>>>>>   }
> >>>>>>>
> >>>>>>> +static inline void mapping_set_no_direct_map(struct address_space *mapping)
> >>>>>>> +{
> >>>>>>> +       set_bit(AS_NO_DIRECT_MAP, &mapping->flags);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static inline bool mapping_no_direct_map(struct address_space *mapping)
> >>>>>>> +{
> >>>>>>> +       return test_bit(AS_NO_DIRECT_MAP, &mapping->flags);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static inline bool vma_is_no_direct_map(const struct vm_area_struct *vma)
> >>>>>>> +{
> >>>>>>> +       return vma->vm_file && mapping_no_direct_map(vma->vm_file->f_mapping);
> >>>>>>> +}
> >>>>>>> +
> >>>>>> Any reason vma is const whereas mapping in the function that it calls
> >>>>>> (defined above it) isn't?
> >>>>>
> >>>>> Ah, I cannot say that that was a conscious decision, but rather an artifact of
> >>>>> the code that I looked at for reference when writing these two simply did it
> >>>>> this way.  Are you saying both should be const, or neither (in my mind, both
> >>>>> could be const, but the mapping_*() family of functions further up in this file
> >>>>> dont take const arguments, so I'm a bit unsure now)?
> >>>>
> >>>> Hah, just saw
> >>>> https://lore.kernel.org/linux-mm/20250901123028.3383461-3-max.kellermann@ionos.com/.
> >>>> Guess that means "both should be const" then :D
> >>>
> >>> I don't have any strong preference regarding which way, as long as
> >>> it's consistent. The thing that should be avoided is having one
> >>> function with a parameter marked as const, pass that parameter (or
> >>> something derived from it), to a non-const function.
> >>
> >> I think the compiler will tell you that that is not ok (and you'd have
> >> to force-cast the const it away).
> >
> > Not for the scenario I'm worried about. The compiler didn't complain
> > about this (from this patch):
> >
> > +static inline bool mapping_no_direct_map(struct address_space *mapping)
> > +{
> > +       return test_bit(AS_NO_DIRECT_MAP, &mapping->flags);
> > +}
> > +
> > +static inline bool vma_is_no_direct_map(const struct vm_area_struct *vma)
> > +{
> > +       return vma->vm_file && mapping_no_direct_map(vma->vm_file->f_mapping);
> > +}
> >
> > vma_is_no_direct_map() takes a const, but mapping_no_direct_map()
> > doesn't. For now, mapping_no_direct_map() doesn't modify anything. But
> > it could, and the compiler wouldn't complain.
>
> Wouldn't this only be a problem if vma->vm_file->f_mapping was a 'const struct
> address_space *const'? I thought const-ness doesn't leak into pointers (e.g.
> even above, vma_is_no_direct_map isn't allowed to make vma point at something
> else, but it could modify the pointed-to vm_area_struct).

That's the thing, constness checks don't carry over to pointers within
a struct, but a person reading the code would assume that a function
with a parameter marked as const wouldn't modify anything related to
that parameter.

Cheers,
/fuad

> > Cheers,
> > /fuad
> >
> >
> >> Agreed that we should be using const * for these simple getter/test
> >> functions.
> >>
> >> --
> >> Cheers
> >>
> >> David / dhildenb
> >>
>

