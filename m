Return-Path: <linux-kernel+bounces-794921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42214B3EAC9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3147F483679
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00435AAB5;
	Mon,  1 Sep 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cPcrYk0l"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510D275B13
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739855; cv=none; b=FLXb36ZV41ozF+UC5uiyavPVMuew4jythB/xlTp+0ISKsYnChEtlIGKA4AQwe9Bno/Rpau7WiqwPNvbZYpz+vlQHvuw1/DQuEcDbrACmgEeesT4Q9fA/xbmH0X18cfI3PThB7bDCMM3JWOKdHN+7dUY4yfwvzxLdTZ3WdRjrUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739855; c=relaxed/simple;
	bh=2vLlsr7X2ia5/OeQs8olHZPr7msI9HcqjAeK9e+vndo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cygGsYML+AWUlz4ajChjjZlK6p4Ka6u16U3Tbhup1uVsgxV0SBdfP11UuyYAKp5hNT00Fsum3FzQoHvScRJDht+lZqQC59Hw5K0wSfd3+HfzASimb34x3ruEpBBuWqYMMi6H4jLMZLfZA2YCe5eoh14gAFnHqa+j79fscv8BtEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cPcrYk0l; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042cc397dcso134852666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739852; x=1757344652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVsve/IFMKMWGwAEF879SRkVfMnyldOnTnxfs/L/xuQ=;
        b=cPcrYk0lG5/RAZ05cjfVkLhN1nU+ecgWhsvk7sRT53uzQ0dDFpRoU7ekOVKMTIkWPW
         6KJyY2UdEnBKa3nVLfoaqpb/EBxhsip9d6ROXKlZJ8wqFVVhP1m4iYh6CLeBwIszbsl+
         6TMQyrJKwl+uXZgauZZQ3A7E/zYQWmxOHnw3vgVIfmspqvLcyM5OmBBRG0mdq+7BtODP
         jM5EEiOtv26L+BBOm4zk1P/EmD7gETyl+6/EmhQJ8t46YTZShwNvxdBX7sFOgpdH04Mc
         9Qo4nIXVsmyJX6AMEG7VmpPn8JuLNgE04VTMNj9Uv7LINJ0y4uusJvQCxtG9D905umVS
         BQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739852; x=1757344652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVsve/IFMKMWGwAEF879SRkVfMnyldOnTnxfs/L/xuQ=;
        b=WwoLNPD3SC+3Smuv585hm7FHTvYP8r/6Sy8rJysE2zlt5sVFhybK6j1+yF5d5v/eil
         3gcXTsknZiHEdbyLTCESIXODbIVAoW2XuHMkHKzU+xqEsH6nA55BzuInrWMIP+3dJr07
         SYqWzw0h8H6ES4rpPlcfSK7yW77l1nHAfPLBDBY5vn8Hqf2Sbhr33NvLZ3V7uMaCYHMl
         lDC7jIgWBroS1UlbIk1JAQqISrbXzyken3+OXcPlHo4uhcZegcDAqSXoFCHAmzIpuvWq
         rcxLyZRDqvNYGsSMvMseENLccJFVZDJmc/FujiaziCbnK13qLB4BodMimfVoeYu3g4FU
         K3EA==
X-Forwarded-Encrypted: i=1; AJvYcCUXYux7YOC/msaIt0KATZufSWFbNReLW96K3/zaRNnVwc66ZP3Xoopm+EZ37W9e3odMBSq/IWo/wIK+S+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWy9XnJbb2X8EWw6Sge+yk6/NAxOtQ5N7FuJaA/ImwwW9jdKHA
	Yye198tl/+X2SwdLqDZhTe0rrWYghkrU1c/geo6rqnmnMa2VepqP0YuPt6A5DMhCyMOno2tV+fC
	KDdqWjkCR0lJ3fxbfmxDsWwrl0NMXGXwG1JtLjmXwFA==
X-Gm-Gg: ASbGncuWBd2Eiy7A1cKSQQ+LkSfZmpNb4SGx9aEPwnnTj3J+Pw/cVLeFuRc7wBfdPB/
	LyGPOINV/A7gtAKuK1QXZ55Gk6QXNI7f8lLdiyiz3dGdL0gOD/QmospI9yaXmVVw99w/pAU1yTZ
	vDyWY110f0wTeDCkcpa3EY95Kg3x6kAPMI4T9/4Y5xBqjOPVcr7h/HXFqb2MMkEd4nf6f2MtU+z
	GALCxvXJG5+YTJwlZmKeAm6U435QO2jTWc=
X-Google-Smtp-Source: AGHT+IG/xTCJ9bj+alHxnm8uZcbqfurR+IyDtwLk2ZtZW9b4+JSGWCUUEu7vdYbFqHJ+Zaxrj6LPdykdWiyzaO+0sH8=
X-Received: by 2002:a17:907:d8d:b0:afe:5c9d:c7f1 with SMTP id
 a640c23a62f3a-b01d8a8b328mr935024266b.10.1756739851758; Mon, 01 Sep 2025
 08:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-12-max.kellermann@ionos.com> <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
In-Reply-To: <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:17:20 +0200
X-Gm-Features: Ac12FXzbdsR-8kES_4on1Dew__ksXVksfxEkYJjm0-lwqH8RlE2IsInEJr70z8I
Message-ID: <CAKPOu+8xJJ91pOymWxJ0W3wum_mHPkn_nR7BegzmrjFwEMLrGg@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] mm: constify assert/test functions in mm.h
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:07=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> > -static inline void assert_fault_locked(struct vm_fault *vmf)
> > +static inline void assert_fault_locked(const struct vm_fault *vmf)
> >   {
>
> This confused me a bit: in the upper variant it's "*const" and here it's
> "const *".

That was indeed a mistake. Both should be "const*const".

> There are multiple such cases here, which might imply that it is not
> "relatively trivial to const-ify them". :)

I double-checked this patch and couldn't find any other such mistake.
Or do you mean the function vs prototype thing on parameter values?

