Return-Path: <linux-kernel+bounces-896792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F106C51353
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85F7534DB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3677D2F2915;
	Wed, 12 Nov 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnQe8S9X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAQl8mqL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C01E492A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937669; cv=none; b=JSIMvQRZLWAZEGwhEeEczlsKiMZWLdoovtld+L0HxR7iMqFdGg1/QiA8FZVMMmR7kPNKOrCceb7XPuXhAo0EJsp5k+UFv6lz8qX6ryjggVaZvN48ujuJ9hCg7MxZ+3PnzEhk4ofUXIqlAx7ybRc+v8UC92naSt0tYJN8xOElkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937669; c=relaxed/simple;
	bh=v38kEjuvcFgheQ99mZl3IS+J1wdYEbfdxCzmk9AFFck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+rZqx0mczt3Ii8vta7MAVbGluifRK87/7H4F2LV6X55lSDUZPAMpiRESF/XrpYfUfBn4yp2mh2iymMAk1tgeOHX90yr5rRi5P+dHEL0E+L9XhDNPsnPTMFe/04GAFbEWGP8ZyxrZYo1Q5uK16nJYze76Oa+7DD381h0z/Rl01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnQe8S9X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAQl8mqL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762937666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhdcYap3SM+S5dOmiD2FLYCC8vjhARcXiqb+7x/90VA=;
	b=bnQe8S9XAQHHn3XSd+l05AD1p/Nlj4uP068uaVyPg4lw/kZik1HbGm46zjE1krPZFqEX8Q
	18M3r0n3ouP22vhJrCBFJu59nrpO6Aj7cgqfZ2LORjA98jw9pw4Ah/6SZhVAR1NepPqEnF
	n+/zO0y6qmuJDVypb3EZnPfAK2AwN9A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-E4j0zEGMO4uD_9_Nv-P6zw-1; Wed, 12 Nov 2025 03:54:25 -0500
X-MC-Unique: E4j0zEGMO4uD_9_Nv-P6zw-1
X-Mimecast-MFC-AGG-ID: E4j0zEGMO4uD_9_Nv-P6zw_1762937664
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2fb13b79so260991f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762937664; x=1763542464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhdcYap3SM+S5dOmiD2FLYCC8vjhARcXiqb+7x/90VA=;
        b=iAQl8mqLQBsd/e779Q+yks8SzKBbyDpWkQYt8SEutnFhWM7OH2CUrbLTktgoi91hY1
         Wom1qLZ2WLWHEo03XRlqhFNPpVsUyi+7JVNU8NaNw/+mFBQ6kb74Vm+V79chyySPrVcC
         +9GAShlcpMRNDuoWK4QinFBBLTvRIbBYXMXH1AmHqYK0anImnDuJw1cJ63YdC7pnzkAl
         LXTGQ14ekvZk4I9PZnwxmiF25wSGrdlZrU5H8AsONg7jewFIEZRbw+y3g9vV/T1LEhNL
         uZ4VgBLwtECRUn0mfTHBJlEFnS5+yO2cONGQ53Sf7V03MQBjM+xNCs+6j9ONZR7KLD5w
         kY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937664; x=1763542464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhdcYap3SM+S5dOmiD2FLYCC8vjhARcXiqb+7x/90VA=;
        b=Y0zeGbJqPZxKPElSN7Ind9PWOMap17C/PfT9/7mtypieHp8uo2MOLlZe1FV1SkvUuz
         kZBRktAMA9LBJ/0OI0UnhPy6HG8197tfkesxKQ5HKBuAb8K+9hK4djASV7Mg6Og6m7Oh
         Y3/BPIhqZq7fZWvmQefDqDw9GuPgLwt/XV4Aq2fxehesC8PQ/btvjpcH4ED5yusdN6tY
         PGxYmx2qGtRcfrG3Hfe9roTFKd06lEtWNgqYYE7zm3bJRjqhQWnP50U8ragaXgDNjYZo
         7SfXv9w1HuYZlLz7A7gtfNwTLhRT2qnI1H7HohGi6tHpWEWl4PrELodFZDDhKFUre49T
         W73w==
X-Forwarded-Encrypted: i=1; AJvYcCXNqyeQw4Enu5DzTpE0J+6IeWW9ZlJsNsbHAP5oAn09UxJ4bx3Cx++TSTrRapj1440TpbwrIQDllHnL6Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZL9IpRQ43gi4IGaSM3+98bpXkiS7h7aBgxTOVopouLIrUEaZb
	xnXWXR8Ptz3/Dya38uyeVHafYRMCjQHbanPJL/W3BzDu9jlsOX72lka32bN1n3xCm1sxWL9n1dg
	COXKaz0XKoiRXzS6o2VbYTHlPgjlWhj276tRGbdiYmIkEE69+Z+7yzE8/mgHdllPDqscCZgycj9
	wxcHktE1OyCZtP5ssHoCmKryDeVFCbTpzMrUg4dtyo
X-Gm-Gg: ASbGncuUBMRpOl1C6fEePGMZ2vtgy+WLb/UXBSE1w9UYaDufObTKezyvdi+riBYXRwa
	bWg2qaBZt9PjorGcxOvaqZSf+LljwQp7BA5sJV4wb2qx1qchQUb+MnlW+C7ZIzBxyST87kUqug8
	D6LD4Q8/RNppLCYcBMWloEYQ1UMn103Tbzq3AKydDQbgaCojf4wU+CRgE/dBPDza6o+mI11ftkx
	jN6huXOhACZWSqLqDdYms/35eO99AuPr8EvMsMteYsMsNrevvd7Sowk+yIqQg==
X-Received: by 2002:a05:6000:2509:b0:42b:496e:517c with SMTP id ffacd0b85a97d-42b4bb8b30amr1769405f8f.13.1762937664177;
        Wed, 12 Nov 2025 00:54:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5HytOk020zd6ytbKUrg7KNXg5lABAprL5NDx0eEspz2lKER1LucpgvormZhbxSAhpxmVsf111duOtSAVjnFI=
X-Received: by 2002:a05:6000:2509:b0:42b:496e:517c with SMTP id
 ffacd0b85a97d-42b4bb8b30amr1769371f8f.13.1762937663794; Wed, 12 Nov 2025
 00:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com> <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
 <20251111081352.GD278048@noisy.programming.kicks-ass.net> <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Nov 2025 09:54:12 +0100
X-Gm-Features: AWmQ_bk4MkmpxDnQL63Mwoi6uHLO0j8XzL8o1Vqxo1_9pTEPZ48l39f_GOUPifM
Message-ID: <CABgObfa7eZXs75F3F9ycyip_LHMYq3=VZHhuar76Bji1OOBXHQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Naman Jain <namjain@linux.microsoft.com>, 
	Sean Christopherson <seanjc@google.com>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, Christoph Hellwig <hch@infradead.org>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:12=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
> > +     .section        .discard.addressable,"aw"
> > +     .align 8
> > +     .type   __UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercal=
l_662.0, @object
> > +     .size   __UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercal=
l_662.0, 8
> > +__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0:
> > +     .quad   __SCK____mshv_vtl_return_hypercall
>
> This is pretty yucky itself. Why is it better than calling out to a C fun=
ction?
> Is it because in spite of the annotations, there's no guarantee the C
> compiler won't generate some code that messes up a register value? Or is
> there some other reason?
>
> Does the magic "_662.0" have any significance?  Or is it just some
> uniqueness salt on the symbol name?

It's just a counter coming from include/linux/compiler.h:

#define __UNIQUE_ID(prefix) \
        __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)

#define ___ADDRESSABLE(sym, __attrs) \
        static void * __used __attrs \
        __UNIQUE_ID(__PASTE(__addressable_,sym)) =3D (void *)(uintptr_t)&sy=
m;

#define __ADDRESSABLE(sym) \
        ___ADDRESSABLE(sym, __section(".discard.addressable"))

You can replace the whole ugly symbol with just something like
__dummy_SCK____mshv_vtl_return_hypercall if you prefer.

Paolo


Paolo


