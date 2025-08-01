Return-Path: <linux-kernel+bounces-753877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2633B18956
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18155A10CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE36D26FA7B;
	Fri,  1 Aug 2025 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJ5dRXVw"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6670229B1F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089832; cv=none; b=dtPXmtBXv2UNuk212Nn0f/yzR3bVrEPjXr8YK6VupZnH/e5OuvVhmmv5OLuPb/hdKgdtddncByNlD4xXaTnLAuDXbe2XQAoPnIyJ1+iccxIa2D1jUeGrRcIE3yvtRIljHn0paeb7eKNw56j5upW0HVBbFaIhUhxgCo7XqlqSrmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089832; c=relaxed/simple;
	bh=GwrrHh+mKQ4p41elE73MS6bGKcwXmcqEjf1KLecr9Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLlW0xvuzY3v65zIpaGTGM7A4OYIx9Fu0XScxoHQ6NMKhjAHhQIwj2EhzOedaTlAvCYIStR6eC9eiBM22QdQG960Z8yeUrOtDUDUgPCv2cWeWypuvFNYnW+QZyGWevzuMY71rTguWU7vQlv6Gz4U0bUXpNTfprOQj5toupf6eMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJ5dRXVw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso38661cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754089830; x=1754694630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g2gB+6N1sjCl5YcGKFO4HOtdhCFwo/qJxfuXGOfsPo=;
        b=nJ5dRXVwtv1f91pA8hDJfJ66hz9VvBS88sULCiXDg1GrS2pD2dvPB6CMgt0gS2vRCo
         E2S7NAUOeUOVha/onQch1gUamRi3s860FocgIwTlb3nj4Op4C8SbzH7jRg+IxHv0mxyd
         VlWQ/542gCx2+4XqtSMPyYdfbmGh4J6tq0XV3zlCQd6h+3BnIUaps45LftioGrhbOnMF
         utJH20mAtR47FCIUFSQrnVDzIjMCUhgw4bEW+ZmvVZO+gjmi2/4T12jlbviO1tNbWps2
         ftXOH6AtlmrIGK8gcqBWOBR2hWv2ID04TJuQu64TjRbWyhtaiuOCAKG+apR/+rx9toa9
         ms5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754089830; x=1754694630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g2gB+6N1sjCl5YcGKFO4HOtdhCFwo/qJxfuXGOfsPo=;
        b=BcJtZPW0ri7MrfenKL725tgPP+ACYnEmol/gnLgB8/Yum00QNQm+yBk4qUcIee3OmT
         1mKjbeZI5+W5GERaP+KZHPP5RZbJLER15xeHfioL+T1P+jQb1/+Jx5Pe94Q3imlPyoap
         AplamyGhZ1oD8g81zg7dKVkdvs8l6vziiV59/qmf7dGQL0qOlCIDwuily5f9odi1G/y5
         wo7UAzEfYWXQlcxFbD332eMJnee+aaE3k1ZDrRMXgpyL3PtuQqfuG8yeNBMq4YfckqCf
         z0DwXJNFClAQXJNYA4vLWqkDJUp9mbIyh9uWF9C8MGdNBVhSsbzEgQo8ck9wV1Lo5YJT
         +jYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2dMYyGVbtmGpuowOJiQmX1WU/ormxnS+z24T3hW1ufChbgsny7OZqSy0RftbgP+5tcRfn1zvCJWhROv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTChAzZyPYTu56TqzeO12P3CgficHqnhek6z7g4Mc64NWAtoK
	Zn+/DhooZG1ccp2KKOGpzcKaj58ba3kPwFuIlCyRmnf6zex4mibzF8qshL7q62ON0dbcq9XBEVb
	Gg37Ah38VnX8kE3Tw+dMhtIRHWwZ9OXhtecEk2qg7
X-Gm-Gg: ASbGnctMmHI7tKZii74S3RHsGFyJ26Rf4+FMzNZdMzSve8gr9yF53JMC6vFiXjlnp82
	fC/ioCqd1Esj1cTS+uA45ZZH2fWaVETfsq7FrhSTaX5eDKfKyn0dVE8MH90UBfTyMW4xvkbkpVU
	q9/ePWofPuLeJ49arNSwbfpjFk9pIrYiMKRFekJT+dRn9mHgkrlYn9DTCECSeBeq5Md9+qBtuzp
	ZdQ3SfxZPi9+m3U7LV4RJMDCq9Q7h0+dDiWEg0h
X-Google-Smtp-Source: AGHT+IG3phk7tKovbC70u4hARPE5dtDSCFUBqv/mdXZaf4iZ2qRLkbKaC5fUwIf1Iwu9r984nTzsGVnOfq8EtbgMdJc=
X-Received: by 2002:a05:622a:302:b0:4ab:54d2:3666 with SMTP id
 d75a77b69052e-4af164bd40cmr710461cf.25.1754089829339; Fri, 01 Aug 2025
 16:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com> <20250613191359.35078-6-sagis@google.com>
 <aH62f9X25LHuUx8n@iweiny-mobl>
In-Reply-To: <aH62f9X25LHuUx8n@iweiny-mobl>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 1 Aug 2025 18:10:18 -0500
X-Gm-Features: Ac12FXwQNDLbo9Q31lKoiJLw7QQejnonXC6nW-MjLkZmnyO9vlyhYR3XHFSy7sM
Message-ID: <CAAhR5DEQ9QWfdzO1yCuFzYjju+Q=pDGbcYyRWFmA_6tc8A4LNA@mail.gmail.com>
Subject: Re: [PATCH v7 05/30] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:51=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> On Fri, Jun 13, 2025 at 12:13:32PM -0700, Sagi Shahar wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
>
> [snip]
>
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/te=
sting/selftests/kvm/lib/x86/processor.c
> > index d082d429e127..d9f4ecd6ffbc 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -1166,10 +1166,19 @@ void kvm_get_cpu_address_width(unsigned int *pa=
_bits, unsigned int *va_bits)
> >
> >  void kvm_init_vm_address_properties(struct kvm_vm *vm)
> >  {
> > +     uint32_t gpa_bits =3D kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY=
_ADDR)
>
> This fails to compile.

Looks like it's a simple case of missing semicolon at the end of the
line, it builds fine if you add it. I can update it in the next
version.
>
> Ira
>
> [snip]

