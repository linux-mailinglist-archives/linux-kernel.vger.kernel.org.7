Return-Path: <linux-kernel+bounces-869913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E668C08FB9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224FC1B25042
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EE02F83A2;
	Sat, 25 Oct 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="er+h0SIx"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D419AD8B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761393363; cv=none; b=SnV9J9zD4CKwdmVFIEHW5fe523WRCHoKxntNJeRwZC4xjaOAL8tsFojfRY0v44rRQgAfjXOc0FN6rdV/bZ2dbYS73tCIrvO1U6wKLQcxFcFItRBHzacGEQEqs9p8vE13d8iaYj7ReF+pgb4HebOB57kpa8iuhZiv1oEci8O4/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761393363; c=relaxed/simple;
	bh=IbVzirtx13zj8iro8c30f/cJH4Z9WeL1XylLbXVZg0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kq25+qxTUg5g6r1K+XznS0xlXuYs+Ur7uEP/CtKi6Ogiw1Aqzei0KzUcvK+PAhsRm8Zz+nHsFlTA8P8dc1sS/oUBt4HdbFVk2EdEZEeKmbvJtqL+Kkdx2YrlSMBcO4TKHIwqyz7RKuUndIB+3gdB2rguLj3qxHIv/AcapCJEJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=er+h0SIx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27d67abd215so122635ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761393361; x=1761998161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ct7/efD1GEoaA/ffsrEA43iPZ+ATBVXvTsFiAb3WeU=;
        b=er+h0SIxfGvRxDQPSMKw07mB/Fb1Ni79wIvpJzFTGyWg/7l4WTsrgZxY+BEMw4ME3/
         JwS+gphF+L+HXS2O+AFs1jmYNcodr3aqkxLp8zp18lXBGOWOty6qWrOctwqhzjDUmQZH
         TITvnV33b/ogRvy9a0fb1bkAj+jSnFMSzcHN1e4sPbO39xuYRcbm/yW7ggcn9SNwM9No
         DaIo9baJPMwmNV3A4ZqY+ce9j/GrPsnmzjhtz7FPcl0b1ea6yl+pM5Nlqolaa9xu51iC
         5yJZ2yz0ZeBzc2YvwJwoy1K9V/zaRSQVQq4SOCihCJC3ehIzJ1uVNq1R8H481nvirAaz
         44hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761393361; x=1761998161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ct7/efD1GEoaA/ffsrEA43iPZ+ATBVXvTsFiAb3WeU=;
        b=ORtoQRY5hWSTjecbA2AGWjfiJZHlZ6cIv5I0y1mvAgNFnH2OIf37QWSCZ4lEZxaXRY
         PPdJRje21o6sx0zQiOsbXMD3t3Lkby5VUvieOVE/wy/hMmKCZwfthoQuKg7gJS/AwHcs
         j8INHVFJmTKAi2PbwCeEihDAEMUMRD+Ikq4vC7Q4o6SsOzXdqYr4zl7IsLMvXcRq7pU5
         Q8jnIbt8tpBb1wiJAUlNMHmTRh2uLIa+JujLismhcAJfo+CuNhuAta29OfGtUaTAtDU+
         0Zph1h8PeBgzbf9JiUsT2/tVLrUeOINf29Rl6IpcdNqYm3cKjqwdeakwHLi0W3qgK4/2
         5SQg==
X-Forwarded-Encrypted: i=1; AJvYcCW18W0t2DdfkXe00q6sSr2H/wXrlsiwUXJwdhKJAm22JKtXDPnK9Ca+HF7Tlr0qT9Hg/fmstXaXITnZ8gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG1ID7S7ypdAbgnOyE9zLgnlkK5PKhQxibRBM7d9aZ4NGFvNa8
	oThi+LpnCgvrOu/8W8Aa93sxEMa4MiFpT2Q+2E4bncUAT52cRLGPtgDlWMyJvV41oDlxkBOwEkw
	vy+bPf8R/AuhNXuZKZcHJROaY5KxpfQaTQDymQprS
X-Gm-Gg: ASbGncv3MLNzlOHXiSidMrZKOl4dEez2q6yYcdWEU2bAGEn6LSNQbA8RIt+HUUlle0R
	gyqxe91OAf1J/Clje13YiHhK2vo6i7DruEl6uBFIXgYEylR4vji43jgFKpnD0eqam/AVogZ89+9
	6k2CM9d2P4Z2gauej/2DRmpTseK/lsJfmXNamz/AR5vH+SUG5fZknRuzuWH5tErmoUVcN4GAndb
	iihJiDqhZlwbA3lfrjeyomKVT55O1wZ5VI1cvL6JF7S7V6bcWz1oPCOyrLsN2BPv1hDoJ1o/S3a
	eaehxiyWbvvM57uwW+iafwzRijQ=
X-Google-Smtp-Source: AGHT+IG/erEWja2xd4C3neXolA/4VGgAb4uoVKQMLlsBEtBRAWc7KQtZNePwJxR05qqxPoQqZGVWq8vd/ZcII6ZuX5E=
X-Received: by 2002:a17:902:c406:b0:25b:ce96:7109 with SMTP id
 d9443c01a7336-29497cb6798mr2714785ad.3.1761393360539; Sat, 25 Oct 2025
 04:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com> <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com> <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
 <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com>
 <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com> <aPsuD2fbYwCccgNi@intel.com>
 <ca688bca-df3f-4d82-97e7-20fc26f7d69e@intel.com> <68fbd63450c7c_10e910021@dwillia2-mobl4.notmuch>
 <2e49e80f-fab0-4248-8dae-76543e3c6ae3@intel.com> <68fbebc54e776_10e9100fd@dwillia2-mobl4.notmuch>
 <10786082-94e0-454e-a581-7778b3a22e26@intel.com> <CAGtprH8AbW4P2t-wHVcTdfLwf3SJK5mxP1CbsMHTgMYEpLiWjQ@mail.gmail.com>
 <68fc2af6305be_10e210029@dwillia2-mobl4.notmuch>
In-Reply-To: <68fc2af6305be_10e210029@dwillia2-mobl4.notmuch>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sat, 25 Oct 2025 04:55:46 -0700
X-Gm-Features: AS18NWCgHlzsnNJ7NBPcSXANACdF5lgDhlf80wCXpQLkk7p_f_jLit3U4dFWFqM
Message-ID: <CAGtprH8-UGFkh4NmuY1ETPYmg7Uk+bm24Er2PPxf8tUOSR_byQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: dan.j.williams@intel.com
Cc: Dave Hansen <dave.hansen@intel.com>, Chao Gao <chao.gao@intel.com>, 
	"Reshetova, Elena" <elena.reshetova@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"sagis@google.com" <sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 6:42=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Vishal Annapurve wrote:
> > On Fri, Oct 24, 2025 at 2:19=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> > >
> > > On 10/24/25 14:12, dan.j.williams@intel.com wrote:
> > > >> The SGX solution, btw, was to at least ensure forward progress (CP=
USVN
> > > >> update) when the last enclave goes away. So new enclaves aren't
> > > >> *prevented* from starting but the window when the first one starts
> > > >> (enclave count going from 0->1) is leveraged to do the update.
> > > > The status quo does ensure forward progress. The TD does get built =
and
> > > > the update does complete, just the small matter of TD attestation
> > > > failures, right?
> >
> > I would think that it's not a "small" problem if confidential
> > workloads on the hosts are not able to pass attestation.
>
> "Small" as in "not the kernel's problem". Userspace asked for the
> update, update is documented to clobber build sometimes, userspace ran
> an update anyway. Userspace asked for the clobber.
>
> It would be lovely if this clobbering does not happen at all and the
> update mechanism did not come with this misfeature. Otherwise, the kernel
> has no interface to solve that problem. The best it can do is document
> that this new update facility has this side effect.

In this case, host kernel has a way to ensure that userspace can't
trigger such clobbering at all. That IIUC is "Avoid updates during
update sensitive times". Best kernel can do is prevent userspace from
screwing up the state of TDs.

>
> Userspace always has the choice to not update, coordinate update with
> build, or do nothing and let tenants try to launch again.  Userspace
> could even retry the build and hide the tenant failure if it knew about
> the clobber,

IIUC host userspace has no way to know if the TD state got clobbered.

> but be clear that the problem is the clobber not the kernel
> doing what userspace asked.
>
> The clobber, as I understand, is also limited to cases where the update
> includes crypto library changes. I am not sure how often that happens in
> practice. Suffice to say, the fact that the clobber is conditioned on
> the contents of the update also puts it further away from being a kernel

The knowledge of things getting clobbered are well much further away
from userspace.

> problem. The clobber does not corrupt kernel state.
>
> > > Oh, yeah, for sure.
> > >
> > > If we do _nothing_ in the kernel (no build vs. module update
> > > synchronization), then the downside is being exposed to attestation
> > > failures if userspace either also does nothing or has bugs.
> > >
> > > That's actually, by far, my preferred solution to this whole mess:
> > > Userspace plays stupid games, userspace wins stupid prizes.
> > >
> >
> > IIUC, enforcing "Avoid updates during update sensitive times" is not
> > that complex and will ensure to avoid any issues with user space
> > logic.
>
> Userspace logic avoids issues by honoring the documentation that these
> ABIs sequences need synchronization. Otherwise, kernel blocking update
> during build just trades one error for another.

Kernel blocking update during build makes the production systems much
safer and prevents userspace from screwing up the state that it has no
way to detect after the fact.

>
> Treat this like any other userspace solution for requiring "atomic"
> semantics when the kernel mechanisms are not themselves designed to be
> atomic, wrap it in userspace synchronization.

In general if this is something userspace detectable I would agree,
TDX module is the closest entity that can detect the problematic
sequence and the host kernel has a very simple way to ensure that such
a problematic sequence is not at all allowed to happen by toggling
some seamcall controls. It would be very helpful IMO to ensure that
userspace is not able to screw up production workloads especially if
the mess is not all visible to userspace.

