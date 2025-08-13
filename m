Return-Path: <linux-kernel+bounces-765700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAAAB23D05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD61784E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C20C4D8CE;
	Wed, 13 Aug 2025 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xd8Hu6nW"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36A1362
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755044346; cv=none; b=C60Vf58ZziNggGOeildJoqd0kf06Fb/DAn00ZxAWkyyk/KlBzSAhdax0YBKMrFU7/ma+emc9BLkGksXfEuTliT6+IUG8mFHfT6omXRSPdTlE3Xiwv/dweDxVeCuRXGW3uCxLtzRHqxk+dHH1SvOYg5+GtkmIT9oBxz2STwHiOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755044346; c=relaxed/simple;
	bh=pJARVKcCUedtd7CK1Bh6kczqQ9W8RfiKpPJ4TG6cCgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8rM1lukeNzLGEWrA/Z5eKDDvSnSCiebpUo1kgLGNm+AY99rpW9tigCdIJFX02oQWYWgiM4YcdZbjc6CAut3CPp6jrqS0gwtssljaSifmzlFLloVgD+8zWwJDuKBuZ1d0Rl1wVJY4EJIFK28Jo7Ze9ozEwNUekwgxaQ8QO7HyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xd8Hu6nW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-242d3be5bdfso45035ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755044344; x=1755649144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJARVKcCUedtd7CK1Bh6kczqQ9W8RfiKpPJ4TG6cCgw=;
        b=xd8Hu6nWCLo34JORiTBKIWAFeGm/w152yVe/4YVLQCjzWYurKvQQnBOBE7qDLyvJx0
         hXQi1ufKhjMQ3uwHgyVn+ePSkC3pYJwszwZgrLmhhVmal8FVy7CBzr4r0WeVipZ/RQNP
         OvWthzptVBj8PIelro96Z+Atk2Vuo3M228h2SdHhTP7ibzhVNvYLgtJ4I1wwLNxJk/MY
         H34DL/VDSXFBsgl1XdQiywYrVt1biAoMiIVa0JKUAoTIyuTYfk4Gq4z7RTjQbSujSiL+
         Mu+PO24Dw5N7K5SVX9yTs+trpxllFspMrKp5LQWFzO+kZc2In/NQ6Mwc5fXAGHW2pIvT
         q2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755044344; x=1755649144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJARVKcCUedtd7CK1Bh6kczqQ9W8RfiKpPJ4TG6cCgw=;
        b=pgcy18P+1RXt67A3JroPicqzuiKg/9hwSqFCyxJqQJxaSTXQaN7jT4WCo2yC7kz+kC
         qs0SA8c7ovSF8GvRH2SXZjvJfjxzbc33XWyqTWAgI2jGqfFERdinwaIV+TE1B9nhmqgr
         gbk6qs4Oax/gKaQxEmam7VqlvikNM7C+IGIgD0GwwqRWf1Qtgm/NoSmyXsxezrRMFSqo
         vWExRytpdNE7nF1BHIYx/ONJmz7iVGT0/WU8FU33pn2lDGn/vtanGFDXDBHmIfi2/sE2
         0LhXITi/3TiWWysHbNohniZ9BqWqwJD50ARmu2ZXuDEd4WghoQe1rSJeFyPyDyalHEyg
         3S+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb7OYwOPXYtUwKxjTt2Ovfo+dUuKKaLzQU36HrFpD8H18APnAxoTl6OqBH+pqpl1hHyNtE+BEqqejNN6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwukbnhqNvOGmYwTdiKLawxTFoddAW8DCNEUMxQRj2px0pcQRu/
	VTF+Um0/GpnjuuzfVRHhblhM7RwCEUhwTeJuUhacsOchpGkXCoDV4484a47ulY73tNtsO9nw22X
	dYPbclUooTzDa6TnSzj555kpuX2hQ9ScQ1wG38A2G
X-Gm-Gg: ASbGnct9GfiS+APrEuS6zrWm0MNzNaILb9EroC01bZQgAwQOP3ilCyBSnhaLlNs+HLi
	o7kTAcfupoCh/gG61q0KvkAV/LF+/u8MQ3aVO8mXHZUbf0SUsdKtjCYlU8phLErJzqcz6nrLrWv
	ROyIjfBZ3+6tDxg8uAhyokd6O0BOIgyMugx9gO4a6Ox4zG1evd+lztF/lGGEiguZbehilYKLvs8
	vxmk1lWZ/X47plpkY8DPeXuIDrJGbcPaHki
X-Google-Smtp-Source: AGHT+IHJqyzxyBLp/fNRzX0VvbZ2PjM1nmN1yNpjsisZAXnj67rfBRkyV3HvdXc1eB5IXQBBQWe7gVaCUBi239OhCHs=
X-Received: by 2002:a17:903:2281:b0:23d:eb0f:f49 with SMTP id
 d9443c01a7336-2430d22e961mr1599265ad.14.1755044343461; Tue, 12 Aug 2025
 17:19:03 -0700 (PDT)
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
 <CAGtprH9x8vATTX612ZUf-wJmAbn+=LUTP-SOnkh-GTUHmW3T-w@mail.gmail.com> <b5ce9dfe7277fa976da5b762545ca213e649fcbc.camel@intel.com>
In-Reply-To: <b5ce9dfe7277fa976da5b762545ca213e649fcbc.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 12 Aug 2025 17:18:50 -0700
X-Gm-Features: Ac12FXxPSxg1yJOw-7Iewn9Frs8_mGpjq5ATxWJ9uJCejooYNNBU4ZpCUOOrKNY
Message-ID: <CAGtprH8Mdgf_nx4qEN3eqp4KqmrW9OvxYHHDJDV2xa7nmBnGbA@mail.gmail.com>
Subject: Re: [PATCHv2 00/12] TDX: Enable Dynamic PAMT
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:35=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2025-08-12 at 15:00 -0700, Vishal Annapurve wrote:
> > IMO, tieing lifetime of guest_memfd folios with that of KVM ownership
> > beyond the memslot lifetime is leaking more state into guest_memfd
> > than needed. e.g. This will prevent usecases where guest_memfd needs
> > to be reused while handling reboot of a confidential VM [1].
>
> How does it prevent this? If you really want to re-use guest memory in a =
fast
> way then I think you would want the DPAMT to remain in place actually. It=
 sounds
> like an argument to trigger the add/remove from guestmemfd actually.

With the reboot usecase, a new VM may start with it's own new HKID so
I don't think we can preserve any state that's specific to the
previous instance. We can only reduce the amount of state to be
maintained in SEPTs/DPAMTs by using hugepages wherever possible.

>
> But I really question with all the work to rebuild S-EPT, and if you prop=
ose
> DPAMT too, how much work is really gained by not needing to reallocate hu=
getlbfs
> pages. Do you see how it could be surprising? I'm currently assuming ther=
e is
> some missing context.

I would not limit the reboot usecase to just hugepage backing
scenario. guest_memfd folios (and ideally the guest_memfd files
themselves) simply should be reusable outside the VM lifecycle
irrespective of whether it's used to back CoCo VMs or not.

