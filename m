Return-Path: <linux-kernel+bounces-869067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D773C06DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 443FA4F0B91
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC53E322557;
	Fri, 24 Oct 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JyKei+8U"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A02C11F8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318411; cv=none; b=fm0oOJR3DHiBb8y7Acat6QWC9DhMmdvzzkzFFDKDTLRy69a/gdROFGzN2Lm2GCyMSpsEFj9y7gmjSbSgorsQAw/Vi1ZEWz6/xc2DPlUnVC6LM+OQ23PFlXL9yExCWkPZ8LR3aXQgYecNS/wYJD3Cec5TkGtCRSqchy6xgiZ7cpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318411; c=relaxed/simple;
	bh=vjCUowAAckOMTIv3A075oLnvlkvKQazUfP1rThqFm0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6xTvxVjTEPD6fj3uvda99988njOqsTLOYt/z5NnvWehVwE2PYJXaAYtcsV4wiRopCgvxyjNy0p8zEdWiqFUvna4U41py6XfUC20sC+GX2G4PuDQLV1kmOjomj7bQk0P4jm4DAoQYUaxgLfeOBjH9tZtrxc8WdSlf23YSTa4JnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JyKei+8U; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so3385192a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761318406; x=1761923206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAggPenHEekpw1xsWjUuRRKCQ64Rzgw+ORJ7ssWDMm4=;
        b=JyKei+8U7052ZEy7vU91P2dSPphhBbTZIqEqiYBejaYMW8LmTrURHmBXUnU43LI3Ht
         6Ky230ph44A8orMhYV4ikaPqijn1sK/bx3qwbvV3iK7ucckZlNkGUC24JDzrzvwZvGg5
         kAVvd9nhTuBda87ENakxAW3E/B5vaI5C/edfePx7csqswf8usUc66KhY2JVpI++9SywZ
         skxWaaJvHcnpWEw2kL4Cet/+X5aowoMBf+G+5RbOiiN7fdzsjh2zusJ5RmkHq0f9i7wl
         H3yguuOWtiKJ1dB/8/VUX6WZYgcrUgbkvxP1/wfgfIMxovAgq1xECY3/vkPm5LS6oXXK
         jqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318406; x=1761923206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAggPenHEekpw1xsWjUuRRKCQ64Rzgw+ORJ7ssWDMm4=;
        b=pJQ7sCot46DOuimSPbP7JHwceyx7XKDflfbO/I6RQwQQZodtN6LidnKnxnHJz4vLyW
         BthI/xENEq4BUxmjumo5JwoSGP2Mfr1oPdOkjk6UAvb3fy8A1xne6wViG8rUpFERhZZ8
         PnZHdSL/1bZT0wWcjbCfa5K3mWIsz6vW9y7K6hSJ9rVTyaof/xsqixVsMoJc+APukXcA
         lV0d2W2nvxcDoa3NAlYihOfsoDsnlr+SYC09y6YRzhCrbTDlDQ1owFe2TjzTOQMHR4e0
         d61YVaLvD29b5NTExQGAnA4pkm0zQUYr9Mscv24+sEe7UM93UYK+ZI28yp23eZQDyAxc
         3UIA==
X-Forwarded-Encrypted: i=1; AJvYcCXDvTzGsFyJ4KSGengSFQYdISijmSQO2AgQyq4RhHfq0JOxA1I6HLI3QZ/v8dbl9KjhlLw7kdtRVBfyAkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfn6SD8HMwKKikzvyOZ82mvzePbwbLYyITlfY5CxU1j64aUbn3
	iInRrHAxRJCTPAFrqQm97SWKn7NTZrWuOa0HZ5CF8yXMutzvjK/+csYY7auEhPL3qsDkF1fzlV+
	KpGus0utGEf/4OvMEG8EA8R5L31cJ+oD7L6Xp2v+tqQ==
X-Gm-Gg: ASbGncu3hQ3iku/F/6Z1lCuJBZjBLAo5LHMSL5lijJno+KBlpuAK4CRWnQ8v2QrwDCF
	+Qi3BFm4ZA+zYgQaZlgoaP5LnswSgvI9d1HtGN7kYditDXD4EqCKl2ENupksd0aByLi211J0mMq
	l9JnWLSGA15cxCXC74S0ww7Pbj9d7Qr1FW6SW8Wz6cMXVlZCWFln/eX6x4i+3aZ8IN4KWWhk+2e
	3/1MvcRyNlzrWpjE4PiIQDp9FfYP338MxqBLgM3CIRiBsjJSJ/xqx+KClBu3k8Bi0Zp485/UnvL
	kqY=
X-Google-Smtp-Source: AGHT+IGJ6GxYCa8q7rSrU/U7gWUFVxG4yyZcVGPe6x/UkHon/1sZO0bVqDFGJeZ2B7N9o//bnwlEJ/gsM5ocEkK4Mlk=
X-Received: by 2002:a05:6402:13cc:b0:63b:f67b:3781 with SMTP id
 4fb4d7f45d1cf-63e6007d032mr2315279a12.18.1761318406399; Fri, 24 Oct 2025
 08:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
 <20251024132509.GB760669@ziepe.ca> <CA+CK2bA_Qb9csWvEQb-zpxgMg7vy+gw9eh0z88QBEdiFdtopMQ@mail.gmail.com>
 <20251024142014.GC760669@ziepe.ca> <CA+CK2bAmPN+v7SYsdHA+RL4kFfnoQvKqTqZ2YQ4wdq6dnFkotg@mail.gmail.com>
 <20251024145508.GD760669@ziepe.ca>
In-Reply-To: <20251024145508.GD760669@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 11:06:08 -0400
X-Gm-Features: AWmQ_blMLbNOm0uoJKs5bR4RSgG2ejq2gkg9FwwwkGNR7IXB5OE5p-7PHsMu37Q
Message-ID: <CA+CK2bC2XNKDd497_+mXxQ=3YaA0QwjxjPzQ95WG6O4nhjeoLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com, 
	glider@google.com, elver@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:55=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Oct 24, 2025 at 10:36:45AM -0400, Pasha Tatashin wrote:
>
> > We do not zero memory on kexec/KHO/LU; instead, the next kernel zeroes
> > memory on demand during allocation. My point is that the KHO interface
> > retrieves a full page in the next kernel, not an individual slab.
> > Consequently, a caller might retrieve data that was preserved as a
> > slab in the previous kernel, expose that data to the user, and
> > unintentionally leak the remaining part of the page as well.
>
> I don't think preventing that is part of the kho threat model..
>
> >
> > > > There's also the inefficiency. The unpreserved parts of that page a=
re
> > > > unusable by the new kernel until the preserved object is freed.
> > >
> > > Thats not how I see slab preservation working. When the slab page
> > > is unpreserved all the free space in that page should be immediately
> > > available to the sucessor kernel.
> >
> > This ties into the same problem. The scenario I'm worried about is:
> > 1. A caller preserves one small slab object.
> > 2. In the new kernel, the caller retrieves the entire page that
> > contains this object.
> > 3. The caller uses the data from that slab object without freeing it.
>
> 4. When slab restores the page it immediately makes all the free slots
>   available on its free list.

Right, we do not have this functionality.

>
> > > other patches are small and allocating a whole page is pretty wastefu=
l
> > > too.
> >
> > If we're going to support this, it would have to be specifically
> > engineered as full slab support for KHO preservation, where the
> > interface retrieves slab objects directly, not the pages they're on,
>
> Yes
>
> > and I think would require using a special GFP_PRESERVED flag.
>
> Maybe so, I was hoping not..
>
> Jason

