Return-Path: <linux-kernel+bounces-870626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A972C0B4F7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A17189DF4F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857021DE4EF;
	Sun, 26 Oct 2025 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JH+vdXCs"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E933F9
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761516128; cv=none; b=OUnQV5prQnltbowi2gbSPwf8coaWnxkbvoowCKNfUXL9kEQodCwhAepnJyb6GurmnEwBUzN1n89ACulLlZwt0LPHd/bC34/atcMfqe/HpK0axQNIfTu4x0QP8MPaCRsLJsjVyhdGfgTN/iUDLT+Y0+6WXXH4VOQBLM4WohV/jA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761516128; c=relaxed/simple;
	bh=3+fgENP1ZH4cyV41Y+zrMzSCQC/sRXBIU0RStkeCUOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcdE+AY5JCbX8KOOTImrdS3PBKWkbdvYiAFkvcQq9EsvsYXk1luzqjEzREYlxLd1CRuMusxAiTDtL3gnsUfVlyHhUmHlNWE/OFQcYO9CBAL8leO5a0lZ6J5Iqgg19PlXZMc2Xzh08UtVlq3urOlaR/8dTw9KybWju85aazx1TLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JH+vdXCs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290da96b37fso219525ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 15:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761516127; x=1762120927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+fgENP1ZH4cyV41Y+zrMzSCQC/sRXBIU0RStkeCUOw=;
        b=JH+vdXCsfoeExO3NbEWmBiEeehzMT+b2ifVsyAFz1ZbjTgdNjAcvbveKuzK2f6VS0N
         Vi77IoN8osCqfME3gsJR4Y0qOGtbAvX2IgbEXnvIVScLhmiYZQcLeWPF/zv6RfYjXs6m
         gILJm06l9RKI/Pk1xYIwYfJzsaGPCq5gTpyUfbzOv/tBk8k+EJpjUTiAkQxlo9WdXe85
         gXuc7B6zavRQbWI+t/Jwr/J9O62pzr7DzdXa51MSf58beSBm9BfvliumPEfYOcVDPfBI
         cNovxNeoyy3tBROz0qTWh/VGCFQNfffQ5Lc1rY7PUFjL6KzAMbQwAXV9trvYGiuUjVnx
         rzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761516127; x=1762120927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+fgENP1ZH4cyV41Y+zrMzSCQC/sRXBIU0RStkeCUOw=;
        b=CoymdeJkwUgA7l3QuYP5MvOCxLkQBXFW7j2dpbEUtqoDCdPe+Eocnrb/zuoU8WuOSJ
         OAQ3WnA/dtVA90T6gvtzI1ot5pFn37L3oL+kTtSdiSOY0wY6JCSKDNuLDBA7vikZ45s7
         njDMvTFUDHkd1I/YY1FMMc3XLEhyyPCTZKzNC9wMPiLNmKTRGFm0JaaWu6jRT5oZrI6W
         FLS/sTPPjlO3H8s9b/MLx46xMUhdZftq4ZBZGcLpXrT8QgQL4EpdNmsANCMO+Jj0wGJ4
         P4h2J6J9Uw+RGXx3BYbknVbjfWk5fWosjVaymgJ/wyOzJsoMGrA/ReKDzKqKRwlnTSZ2
         OtGg==
X-Forwarded-Encrypted: i=1; AJvYcCVfIOv8x5qyBwlWKjj/ltbrZYAts2ljZzl8neyHUnzq4X2TdwlTfvL84imegMGoAtqJmRtHihn+8uIK1Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpq8foHcsR1KhtJDdYyiRoqI7C7lQcLzTffJLwbFRgqO+ar0Ym
	783AvKrj/S+3WI5Rm2kwbf2U01NtuehzYd4yl/6tgxpRaVBjbhRAlkbRXm6JcadtWhncKoYxFHk
	UWQYLDMIISn4+1/ofj/zvy+jxxzwnXnMxDPBkEMZf
X-Gm-Gg: ASbGncv17YahPM5oZEYlIVS1x2ZY9KK2KN8JxVPbIUjnWTYuXpE8Re5nluNKmgQ4AmM
	89izGrLCr44Rm3Bt6BfoMV8Ivqi0h55pjIJKMu++hnyDBMZnXrdCn8ElVRGxWDOToDASWz2zfHg
	v4b484KQiScEFN0d9djWR83yODpPj0HfPQQHGvbn37hyaAXEeclofR3wCzrXBK73g+l0meBEfCk
	9d1CIvBRiUo8B22CEDYcK+5h8jnh0J1h8dQ9z4MVGcF9NGKn9EQhbiA3gme0ZipE/2sUjuOHOhL
	MFPHgb7KxPl6itE+tiI9zmykcQ==
X-Google-Smtp-Source: AGHT+IHx53+OT/iU5ncrV7eLgcmP7WB6YYEN+QheTqXjctli+ZTT136PerVE69TnyO4Xpuz74P93dggE62/a9ay0GUE=
X-Received: by 2002:a17:902:d2cb:b0:292:64ec:e0f with SMTP id
 d9443c01a7336-29497c21fb6mr5956275ad.6.1761516126042; Sun, 26 Oct 2025
 15:02:06 -0700 (PDT)
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
 <68fc2af6305be_10e210029@dwillia2-mobl4.notmuch> <CAGtprH8-UGFkh4NmuY1ETPYmg7Uk+bm24Er2PPxf8tUOSR_byQ@mail.gmail.com>
 <68fe92d8eef5f_10e210057@dwillia2-mobl4.notmuch>
In-Reply-To: <68fe92d8eef5f_10e210057@dwillia2-mobl4.notmuch>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sun, 26 Oct 2025 15:01:52 -0700
X-Gm-Features: AWmQ_blT1zj6KKe0CRTsU1n5euwANUl1olNBkqvjxuYAuzV9TOvr6vNZnzbUBTw
Message-ID: <CAGtprH8g5212M26HPneyaHPq8VKS=x4TU4Q4vbDZqt_gYLO=TA@mail.gmail.com>
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

On Sun, Oct 26, 2025 at 2:30=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Vishal Annapurve wrote:
> > On Fri, Oct 24, 2025 at 6:42=E2=80=AFPM <dan.j.williams@intel.com> wrot=
e:
> > >
> > > Vishal Annapurve wrote:
> > > > On Fri, Oct 24, 2025 at 2:19=E2=80=AFPM Dave Hansen <dave.hansen@in=
tel.com> wrote:
> > > > >
> > > > > On 10/24/25 14:12, dan.j.williams@intel.com wrote:
> > > > > >> The SGX solution, btw, was to at least ensure forward progress=
 (CPUSVN
> > > > > >> update) when the last enclave goes away. So new enclaves aren'=
t
> > > > > >> *prevented* from starting but the window when the first one st=
arts
> > > > > >> (enclave count going from 0->1) is leveraged to do the update.
> > > > > > The status quo does ensure forward progress. The TD does get bu=
ilt and
> > > > > > the update does complete, just the small matter of TD attestati=
on
> > > > > > failures, right?
> > > >
> > > > I would think that it's not a "small" problem if confidential
> > > > workloads on the hosts are not able to pass attestation.
> > >
> > > "Small" as in "not the kernel's problem". Userspace asked for the
> > > update, update is documented to clobber build sometimes, userspace ra=
n
> > > an update anyway. Userspace asked for the clobber.
> > >
> > > It would be lovely if this clobbering does not happen at all and the
> > > update mechanism did not come with this misfeature. Otherwise, the ke=
rnel
> > > has no interface to solve that problem. The best it can do is documen=
t
> > > that this new update facility has this side effect.
> >
> > In this case, host kernel has a way to ensure that userspace can't
> > trigger such clobbering at all.
>
> Unless the clobber condition can be made atomic with respect to update
> so that both succeed, the kernel needs to punt the syncrhonization
> problem to userspace.
>
> A theoretical TDX Module change could ensure that atomicity.

IIUC TDX module already supports avoiding this clobber based on the
TDH.SYS.SHUTDOWN documentation from section 5.4.73 of TDX ABI Spec
[1].

Host kernel needs to set bit 16 of rcx when invoking TDH.SYS.SHUTDOWN
is available.

"If supported by the TDX Module, the host VMM can set the
AVOID_COMPAT_SENSITIVE flag to request the TDX Module to fail
TDH.SYS.UPDATE if any of the TDs are currently in a state that is
impacted by the update-sensitive cases."

I think the above documentation should replace TDH.SYS.UPDATE with
TDH.SYS.SHUTDOWN IIUC.

[1] https://cdrdv2.intel.com/v1/dl/getContent/733579

> A
> theoretical change to the kernel's build ABI could effect that as well,
> or notify the collision. I.e. a flag at the finalization stage that an
> update happened during the build sequence needs a restart. This is the
> role of "generation" in the tsm_report ABI. As far as I understand
> userspace just skips that ABI and arranges for userspace synchronized
> access to tsm_report.
>

