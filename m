Return-Path: <linux-kernel+bounces-765626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D305B23B89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF51B6114D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28832DA74A;
	Tue, 12 Aug 2025 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qs1of9jk"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07EA25FA3B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036060; cv=none; b=F135TEmIzDQkMVjVDMrTEbk7WTdW1tglOeZ6xqSxXZnE+yEykM7m27TxpB/Qp0OFe+e8gyLvS2FznaGYctM8hp0sBjNBPcQVZ9eyd60TSgSCDrtrgGK0JwWGLeH6Q8xF+jm9V9vG+Ev83svp+VJn1gs5Wj70FznNvtrT7gR7cec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036060; c=relaxed/simple;
	bh=f4aoBnF6UI6yoC/kt/MYYs/zEAGM8hMK8OsNn7Mb8Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGRE9ZHoQ7r2jYnPmFAQfKeb1zgccxIUmEFPKDLiLgC04TDpHGL3Ch9zzDBLQx36jNm3mKtt1EK0+PeXxhQ+Ac0+byg67zYS0MRbU2OoCDOgCJjrSupXF5Stl1lAbcyTGTiHPxwX9kRKwr0eD/FJyc53ALYrcaWXZlQN3dsfXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qs1of9jk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-242d1e9c6b4so82525ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755036058; x=1755640858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYnclDSEu7x5xe8ImalkQXpsTyg/ojy5gFPjdO0a8XQ=;
        b=Qs1of9jkjRkatygnOhgGZUMYhiFBVg4Bvka4kWtCiHnPylfw8WB9YHG1UJH91lB9dE
         8SRHi3iIBMm41Ea7RSn8Gf7tY7WWzum3WQfoiIUjsZtlO/BRI12HmM4LW7O+/GevfbSX
         i7ItRwXO7R4ILJWQcv499Ef1lJtNRRR2VYdRao8s4FJn4tvFRg64djzzHwhnItoItZow
         UeWTXkfs7kR6BxWIzmnr3W5w9YRTXVWLns1XiJMFNvAP6nbeELjXDyKxANyCb4PP4GGX
         Fz+3hA168aO/83nWonX2luTwOL1l15oL5OBhwV8f6tGE+nlARAw8Z9cFpcSJ1oVR4dHH
         1EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036058; x=1755640858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYnclDSEu7x5xe8ImalkQXpsTyg/ojy5gFPjdO0a8XQ=;
        b=d0waYUFymF9zTCzn2MHLEKAx741ETmct8CmIzRwWj8qs7dduipECKBlgknwYiOHRXv
         fQmmD3nHpjKO0rWI8YxHIEpvIxywLB5zeD8vsX8o0tNinIHqDi84n/xdUL03zht+yysI
         TWQpYT1DdpjYv+VmVAQepeJ3fkWmp3QZmlQFocYLdwNjVCUKpJuVDvQeGd255EnjywwN
         cuU3tD9cbGMrkXDpH381thOiHeq7Gb8eDQp3YFFe/8c3W+nCOgeixB7PBmJ/sThDxK6j
         b7qiw48pwfOyLbb9yt4tL5aPKqHGHO+/OeR6lIYTEjka0SRKCDDwlvp+fCn9TXbibdNl
         CXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbe9/gkikhSQiRm98JTBQ9iq7DdFwsdE4bRlO0e9TktUV0wmw1dxYRo2c/YJvvZ7GbN/uNMdhyiVo/S0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3uYNw1e0jMaRpY0O1oGU5Spk/Snj708BZnyZm371FtE0H7/D
	Ee9kP3mM1woZQXhwV9s0zFddHVaTWZFsb87Fxo6EGStexGI3FtsRPtmEkXDcegsnW9iqUXdZL8g
	iu83lBJxicNBRPmdym5dtRFzhx2GlefAUfFWB3MY4
X-Gm-Gg: ASbGncsaJVSvbMWHvDdURz4jqqFKlHWsYdpSV7SO/oG4UpXe8OQnZ8CuniKsIV5v/4j
	6sKVfZW0Gqm9axION776RVzOEVqaIiqbpN3ELfhRmBCfo60mnJch6i4HlPvbMMF6YU7Aqhw+5Gg
	z7piS6tXQjE3dgFJJx0wSkgNq20ryBq+QpLP445Cg5xjs76B6iaHPFKTQITntllI+VlJ3r69Ikc
	oM7W3i/6nqh/7y4V9TGqMBVnN+poaByfqFjtvbQITWbNten
X-Google-Smtp-Source: AGHT+IGfwv1ZWrS4oHle6pz1ZRXFvtF9JAKmlfK8yVhn8PUDFu2Wo/yJAmNGdiOiEQeoymxG0CmJlbyHTUPXC89PmeE=
X-Received: by 2002:a17:903:187:b0:240:4464:d486 with SMTP id
 d9443c01a7336-2430e54d963mr414465ad.13.1755036057250; Tue, 12 Aug 2025
 15:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609191340.2051741-1-kirill.shutemov@linux.intel.com>
 <d432b8b7cfc413001c743805787990fe0860e780.camel@intel.com>
 <sjhioktjzegjmyuaisde7ui7lsrhnolx6yjmikhhwlxxfba5bh@ss6igliiimas>
 <c2a62badf190717a251d269a6905872b01e8e340.camel@intel.com>
 <aJqgosNUjrCfH_WN@google.com> <CAGtprH9TX4s6jQTq0YbiohXs9jyHGOFvQTZD9ph8nELhxb3tgA@mail.gmail.com>
 <itbtox4nck665paycb5kpu3k54bfzxavtvgrxwj26xlhqfarsu@tjlm2ddtuzp3>
 <57755acf553c79d0b337736eb4d6295e61be722f.camel@intel.com>
 <aJtolM_59M5xVxcY@google.com> <6b7f14617ff20e9cbb304cc4014280b8ba385c2a.camel@intel.com>
In-Reply-To: <6b7f14617ff20e9cbb304cc4014280b8ba385c2a.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 12 Aug 2025 15:00:43 -0700
X-Gm-Features: Ac12FXzUOSL8uj22Gf8SAUQ6EMRq4bH-wO2CrZWzJDP_8gow_mcas1sjUn3kyAg
Message-ID: <CAGtprH9x8vATTX612ZUf-wJmAbn+=LUTP-SOnkh-GTUHmW3T-w@mail.gmail.com>
Subject: Re: [PATCHv2 00/12] TDX: Enable Dynamic PAMT
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Tue, Aug 12, 2025 at 11:39=E2=80=AFAM Edgecombe, Rick P <rick.p.edgeco=
mbe@intel.com> wrote:
>
> On Tue, 2025-08-12 at 09:15 -0700, Sean Christopherson wrote:
> > > I actually went down this path too, but the problem I hit was that TD=
X
> > > module wants the PAMT page size to match the S-EPT page size.
> >
> > Right, but over-populating the PAMT would just result in "wasted" memor=
y,
> > correct? I.e. KVM can always provide more PAMT entries than are needed.=
  Or am
> > I misunderstanding how dynamic PAMT works?
>
> Demote needs DPAMT pages in order to split the DPAMT. But "needs" is what=
 I was
> hoping to understand better.
>
> I do think though, that we should consider premature optimization vs re-
> architecting DPAMT only for the sake of a short term KVM design. As in, i=
f fault
> path managed DPAMT is better for the whole lazy accept way of things, it
> probably makes more sense to just do it upfront with the existing archite=
cture.
>
> BTW, I think I untangled the fault path DPAMT page allocation code in thi=
s
> series. I basically moved the existing external page cache allocation to
> kvm/vmx/tdx.c. So the details of the top up and external page table cache
> happens outside of x86 mmu code. The top up structure comes from arch/x86=
 side
> of tdx code, so the cache can just be passed into tdx_pamt_get(). And fro=
m the
> MMU code's perspective there is just one type "external page tables". It =
doesn't
> know about DPAMT at all.
>
> So if that ends up acceptable, I think the main problem left is just this=
 global
> lock. And it seems we have a simple solution for it if needed.
>
> >
> > In other words, IMO, reclaiming PAMT pages on-demand is also a prematur=
e
> > optimization of sorts, as it's not obvious to me that the host would ac=
tually
> > be able to take advantage of the unused memory.
>
> I was imagining some guestmemfd callback to setup DPAMT backing for all t=
he
> private memory. Just leave it when it's shared for simplicity. Then clean=
up
> DPAMT when the pages are freed from guestmemfd. The control pages could h=
ave
> their own path like it does in this series. But it doesn't seem supported=
.

IMO, tieing lifetime of guest_memfd folios with that of KVM ownership
beyond the memslot lifetime is leaking more state into guest_memfd
than needed. e.g. This will prevent usecases where guest_memfd needs
to be reused while handling reboot of a confidential VM [1].

IMO, if avoidable, its better to not have DPAMT or generally other KVM
arch specific state tracking hooked up to guest memfd folios specially
with hugepage support and whole folio splitting/merging that needs to
be done. If you still need it, guest_memfd should be stateless as much
as possible just like we are pushing for SNP preparation tracking [2]
to happen within KVM SNP and IMO any such tracking should ideally be
cleaned up on memslot unbinding.

[1] https://lore.kernel.org/kvm/CAGtprH9NbCPSwZrQAUzFw=3D4rZPA60QBM2G8opYo9=
CZxRiYihzg@mail.gmail.com/
[2] https://lore.kernel.org/kvm/20250613005400.3694904-2-michael.roth@amd.c=
om/

