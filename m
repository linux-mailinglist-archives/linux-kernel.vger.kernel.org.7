Return-Path: <linux-kernel+bounces-780543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4423EB3033D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D873B687095
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD934AB1F;
	Thu, 21 Aug 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xkRwL6os"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02262E88B7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806025; cv=none; b=uiA+KuhUv0P+avGpNiuO7ib5wWwdeFNiRBRBW6jApJIspdFyvDl8Erww4/Cv1NxmvccfIeRd7O77rfsKyP8LOsKCrIT1txybR498oULK5W+PVQSM9YqgWyVv64u6wbHOFihC3/GDkA8cXEw348EJSCXWeAFU6P2v+AP/gJNIimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806025; c=relaxed/simple;
	bh=iAzHJhTmGhA4UuOIN7oR+yPBuRcwVJMXTKi+RzPVVg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLHv1jD7HDMHLWY4e9XuCpOiPnWJkCBFiKVATwYq6XOf7ADvfPtd6c4M6hHXVXmeGfPV7FZjsDmayjXH1bDHhFOD4SI+5Bf5eIPPvIoROe/OnH4WeZHDTT1A7ft9FWc4VzOadhlQvBdSmkOF6PV9fWzD+iliY5ascDWU4x3VMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xkRwL6os; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b29b714f8cso11231cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755806022; x=1756410822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQE488gFqLXE2ANKpcc7rXfMjRx7ZR+eoJCvQepJ5Ko=;
        b=xkRwL6osYp2QjBjZhruCzglM4d5UyQHQqnSZtWqtwVsCfLLZDjsebfxXPVAEDGpa8s
         Z1Ol3e7h74ZqOzVSsL0DSe5nUS1lyM22OrtW4+jSedC1pJNwha8CW8j3Y3aoeXzw4MEa
         mfLO9EkKrYFXTBZ9y7bBIaPFjt4eoEbz+8HvP9Mx9v6Z8zDiGCwC3Jf2fuzwI+3lojCF
         UbI9PFCt8q5tuHQpby6HmEcdDFv+Sy/EP6/ImziUKHMPYEgYZ/CBupxNM+Z0f5aVM3vY
         Ddg0Bl1l0zD1O7Cm+0P4ucyWgn8J01SKolTFAlRtb3Uoa1XFJp6K0lY8DS2qBr9cpqC4
         1Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806022; x=1756410822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQE488gFqLXE2ANKpcc7rXfMjRx7ZR+eoJCvQepJ5Ko=;
        b=GuChcsaoIxoBGkBk7eEOznSkHFkOjO1CLTR/vA5fCge1Gbq6Pd8QGmxmpSYRvQHOG1
         z6Bb+bR0T6ek21NYVqwhgp2fNXI6vK9Jmdp24miOOyIe4bfqXvkm5wyYlAA1DsBZ0aaC
         yKUlDWuLDAAicDDaaX8FIQQWjkoyBMFqxNpNPS7QS/5U2VMTzNhPDZPfwDSU2LjX1oz1
         90LURLWy+YHrGOqgP6INf2jAj25g/liQqX77A883XOW+LOQ6uhmXvN4pKMUwIvhkg1vQ
         rRrk3op7HIxap3G5bYJ8+jPcK6oZa2TvmUVhrApcEYC0VFVMMefKDjEYbVcZrPvZwjZx
         4CYg==
X-Forwarded-Encrypted: i=1; AJvYcCUlrAqxdin+LpPDIlxJ3U/nFOZjxtvDzwlK34mTLmww7nWZ+2Gu96pgGsd1ARSuJ4TIadC09kDvsEbWmyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzHQy+9pZgDLj89mZ04+pxQ3rXlTpRWFoTgnNYJaioVc5LX5Z
	O8u8KBTK2nG+3GnIDuWdD/oZbDpRLvodvmtIBuw5puV06ydcTSKDLeZMErFMGXE5lxheZlitBQK
	j+ggM0i67duTXdqoy8fw0BGmYJ+gnisLyxQhLukRj
X-Gm-Gg: ASbGncvIUmibzBjwtiXad2CKVE3MyatnF2ETBTb090LnN1FGtcM5LqsUJqS6vOSnWoG
	fYK/6NCrTAFlk58nyUoXtf94ems1OrgmQaRnlxfWWTpgb3ZGRYmKgbf35ewMjuu1svT36GkMhG6
	x07qs5jLQSHd9m97pHLWi1nDNf5PduBXvL4l92De6T03M/miLEMWgrIm+SgybQkZI15Ohc0Wpqw
	V/cJS/HYoF0WL8PVWL5dyqHpleiffn8WO6QB/hSOTP5+dcnQDUbH0wOGQ==
X-Google-Smtp-Source: AGHT+IEtV+EElbszmKzsagGUV+5RJ5kFfylNWl8hAeezTkODuvWCFFOJDiHSg2jtvhjUFiOXg0YM9g3Uq8HKa8NejXs=
X-Received: by 2002:a05:622a:34f:b0:4b1:1ba4:e2 with SMTP id
 d75a77b69052e-4b2aaddba89mr1071241cf.14.1755806022171; Thu, 21 Aug 2025
 12:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609191340.2051741-1-kirill.shutemov@linux.intel.com>
 <20250609191340.2051741-9-kirill.shutemov@linux.intel.com>
 <CAAhR5DGGWss4jovHETYmBeK1gze04LR9c8Dcd2oMpCC3SnMDgQ@mail.gmail.com> <0a1cf08ba04b026a6c48a390a756dc2a990b3620.camel@intel.com>
In-Reply-To: <0a1cf08ba04b026a6c48a390a756dc2a990b3620.camel@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 21 Aug 2025 14:53:31 -0500
X-Gm-Features: Ac12FXxoVffod8mw688ECGptg6wu19qXj9q41MZieGo6yWj9z8AWlvpolLHUTos
Message-ID: <CAAhR5DEy5z4QsHQjvxv+uDOP=5fC47sK8NTcU5iRSgV5ReCOZQ@mail.gmail.com>
Subject: Re: [PATCHv2 08/12] KVM: TDX: Handle PAMT allocation in fault path
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Gao, Chao" <chao.gao@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:35=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Thu, 2025-08-21 at 14:21 -0500, Sagi Shahar wrote:
> > >   int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
> > >                                enum pg_level level, kvm_pfn_t pfn)
> > >   {
> > > +       struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
> > >          struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
> > >          struct page *page =3D pfn_to_page(pfn);
> > > +       int ret;
> > > +
> > > +       ret =3D tdx_pamt_get(page, level, tdx_alloc_pamt_page_atomic,=
 vcpu);
> > > +       if (ret)
> > > +               return ret;
> >
> > tdx_pamt_get() can return non-zero value in case of success e.g.
> > returning 1 in case tdx_pamt_add() lost the race.
>
> No?
>
> +static int tdx_pamt_get(struct page *page, enum pg_level level)
> +{
> +       unsigned long hpa =3D page_to_phys(page);
> +       atomic_t *pamt_refcount;
> +       LIST_HEAD(pamt_pages);
> +       int ret;
> +
> +       if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> +               return 0;
> +
> +       if (level !=3D PG_LEVEL_4K)
> +               return 0;
> +
> +       pamt_refcount =3D tdx_get_pamt_refcount(hpa);
> +       WARN_ON_ONCE(atomic_read(pamt_refcount) < 0);
> +
> +       if (atomic_inc_not_zero(pamt_refcount))
> +               return 0;
> +
> +       if (tdx_alloc_pamt_pages(&pamt_pages))
> +               return -ENOMEM;
> +
> +       ret =3D tdx_pamt_add(pamt_refcount, hpa, &pamt_pages);
> +       if (ret)
> +               tdx_free_pamt_pages(&pamt_pages);
> +
> +       return ret >=3D 0 ? 0 : ret;
> +}
>
> > Shouldn't we check
> > for (ret < 0) here and below cases?
>
> I think you are thinking of tdx_pamt_add().

My bad.

