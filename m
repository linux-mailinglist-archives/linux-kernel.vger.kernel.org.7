Return-Path: <linux-kernel+bounces-880764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF7AC26818
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B743B2C95
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278543093C3;
	Fri, 31 Oct 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emqDqYy1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACF2E718F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933455; cv=none; b=pBnW+89rJQCPTLv0bWJckMi0k1j+106j+7yHw44sGy+XPiXf7vwvwYnG3VFmH7ws90uTUGf6YYUAiY8pbMh6JS9+bTgp+Zc0oRcHXWxHWiAz3bkbVVuIOSGlccT1ETdJd0OTQt4TMvZIecyvAnJnz2vh/5CNxzIvtZVof9Iig+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933455; c=relaxed/simple;
	bh=w+l2KnhOSPqcCidvxKmZoV7YhTgpct2Y/GQfmSENZX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZVNlNf/YqnwwndRjSdaMj6ecRcidiSpNSfTfg9/EY/dlnsCXU4RL6pAnkHvXv/Vw1jPwSfYuyK68FZsUPffHt+QbQIUekO6flHGlTxCD5yb6IUgjlOwKOiyxRAdiFvQut34WNHwAI3TgIreco1qrSmtd7eLmqYJSB+yyw5CTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emqDqYy1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27eeafd4882so20325ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761933453; x=1762538253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA5McjZLTPeaIiPTmwBlsqsNvLJ/0YB/eoqpy0U2piE=;
        b=emqDqYy1KvfBdx8I1JPX/1izjnN23IcEefDts9qdh5wv8wLAt6nVXWq67Y8V9epfKU
         JoOVgFSy3QHlbgyMkHCsloE9m2GfJjv84VA06v9Em/eMtk7yyHal+88KQpjPPPoZ2qST
         ROX61hIi1MwDVuuWlScLy/JF6KIr7ahAjNzKgVWRXG57edG410vBmZXEGZ8eCPCEzspm
         NfmmOl75HIJ9pXY3jpuhaQShm6DVK2lE3iyjD5/pSjDZjks6bwS45mCMHLOcK2Tkf2yi
         xfp2R+x/VGzVcldimIWd/o/ir4v9z0A1EplLGg8XjOGM+kqKhb5t8socZfxw8h1M5sKr
         jwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761933453; x=1762538253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA5McjZLTPeaIiPTmwBlsqsNvLJ/0YB/eoqpy0U2piE=;
        b=FEZ/6P6AZbkx4XfSTd/J/W9t1Nj0Qj7V4yGhMD1tg9W0C3E4DJ5VQPWL/IWl41aZOZ
         HrLmfUeQXFzt54kWampl9Ek8P+xKZ5QDS7gI6HYCA4JyABjJvqHYt06zfB9Y2ejzq2Re
         eMJGmNwuv5VG9CkKiJ8k6OToL8ToVoKrRQKAei0XQmxQKV/ScsqxrAbBdQkTZOl6yDC/
         SjLUs94XhT58XK3NDFbpxoSU6ZRLdOIzff0n38uRdiwEfwrW7fA22mgTd54zIpP7Ob3F
         ObHQuz5ZHeP+lTmkraJA2nB3H8/y0V8cUtrWxd9Q9W+5HjpZS/kqy87qj3dparX3tIzx
         JK/w==
X-Forwarded-Encrypted: i=1; AJvYcCXGsNP5KwEADCz6DFxHIhzFllnWmGEQsDOzYinSFKtOPDxFwnCYVOnhFw95kIMIzeG7Zi6jQ2OhRpODtTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqopYYKJruhMCakp7RLg7J34bgpb5LpCY9zHbDpz975CfuEn7F
	mO4MU1L/YgqXH/eeXtYwUVhWSPuVzxefZNcKlwF7nZiRMTDaGYaqPtJOvWZukajCPF4+TMPZsFE
	gPJB7S5R/bLrWzREUx2MNshkD8xYWpWQtWBoMFUwJ
X-Gm-Gg: ASbGncs4HeMyjQeSrOuWALht8RE2TYS5AXS3kitLCIOXTcPh5eT0q3I3JSLSQkbqTIC
	STs2Bymg5h2VBBG2CBJb/Ra7qeWTLp/zrq2ABGQ3Dp8v+b/bvJ+RzOqcxcgWSPfr3foZmYN0uP0
	5c3F49WGUDxyIdSe86Lc7dgTMhXOF7tVspNEHHF1vdS5syM1JAhvtjIS3qqePIrKggfaex1Lkkn
	T1MxIY50LGF8uMenMfPHTorhYI32LdEcsTYVifdGD4c5x1xdy58VSigzNAbZMDQDRBexXaNmIli
	qBgnAA2sOgm7SF2qU8hu25WR6vXQ
X-Google-Smtp-Source: AGHT+IH52ONiunJDDawQVCijIuSE1WTf+MEIQuJ+bSRpyZ0rrSGKJGCZKm4jtJfrXlgC7tzB7Eax2KkIUaW7cADasEc=
X-Received: by 2002:a17:903:1ce:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-29554bb5aaemr335185ad.10.1761933452880; Fri, 31 Oct 2025
 10:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com> <CAAhR5DF74PhX_YpMebbqnZOJom-sR=1s7xbhrk5WCTS8jn7U7Q@mail.gmail.com>
In-Reply-To: <CAAhR5DF74PhX_YpMebbqnZOJom-sR=1s7xbhrk5WCTS8jn7U7Q@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 31 Oct 2025 10:57:20 -0700
X-Gm-Features: AWmQ_bldOnJMqaHQe0Ts3A4WPbB0FJ1ezLt9Jpnrpzo2fVxtPV1Mx-JEfS1PIQY
Message-ID: <CAGtprH9UTqC-wmOhfjr2qNk2X-BDJokmLYjET=Zm+Zu+QHZ6Dw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: Sagi Shahar <sagis@google.com>
Cc: Chao Gao <chao.gao@intel.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com, 
	ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com, 
	yilun.xu@linux.intel.com, paulmck@kernel.org, nik.borisov@suse.com, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:55=E2=80=AFAM Sagi Shahar <sagis@google.com> wrot=
e:
>
> On Tue, Sep 30, 2025 at 9:54=E2=80=AFPM Chao Gao <chao.gao@intel.com> wro=
te:
> >
> > Changelog:
> > v1->v2:
> >  - Replace tdx subsystem with a "tdx-host" device implementation
> >  - Reorder patches to reduce reviewer's mental "list of things to look =
out for"
> >  - Replace "TD-Preserving update" with "runtime TDX Module Update"
> >  - Drop the temporary "td_preserving_ready" flag
> >  - Move low-level SEAMCALL helpers to its own header file
> >  - Don't create a new, inferior framework to save/restore VMCS
> >  - Minor cleanups and changelog improvements for clarity and consistenc=
y
> >  - Collect review tags
> >  - I didn't add Sagi Shahar's Tested-by due to various changes/reorder =
etc.
> >  - v1: https://lore.kernel.org/kvm/20250523095322.88774-1-chao.gao@inte=
l.com/
> >
> > Hi Reviewers,
> >
> > This series adds support for runtime TDX Module updates that preserve
> > running TDX guests.
> >
> > =3D=3D Background =3D=3D
> >
> > Intel TDX isolates Trusted Domains (TDs), or confidential guests, from =
the
> > host. A key component of Intel TDX is the TDX Module, which enforces
> > security policies to protect the memory and CPU states of TDs from the
> > host. However, the TDX Module is software that require updates.
> >
> > =3D=3D Problems =3D=3D
> >
> > Currently, the TDX Module is loaded by the BIOS at boot time, and the o=
nly
> > way to update it is through a reboot, which results in significant syst=
em
> > downtime. Users expect the TDX Module to be updatable at runtime withou=
t
> > disrupting TDX guests.
> >
> > =3D=3D Solution =3D=3D
> >
> > On TDX platforms, P-SEAMLDR[1] is a component within the protected SEAM
> > range. It is loaded by the BIOS and provides the host with functions to
> > install a TDX Module at runtime.
> >
> > Implement a TDX Module update facility via the fw_upload mechanism. Giv=
en
> > that there is variability in which module update to load based on featu=
res,
> > fix levels, and potentially reloading the same version for error recove=
ry
> > scenarios, the explicit userspace chosen payload flexibility of fw_uplo=
ad
> > is attractive.
> >
> > This design allows the kernel to accept a bitstream instead of loading =
a
> > named file from the filesystem, as the module selection and policy
> > enforcement for TDX Modules are quite complex (see more in patch 8). By
> > doing so, much of this complexity is shifted out of the kernel. The ker=
nel
> > need to expose information, such as the TDX Module version, to userspac=
e.
> > Userspace must understand the TDX Module versioning scheme and update
> > policy to select the appropriate TDX Module (see "TDX Module Versioning=
"
> > below).
> >
> > In the unlikely event the update fails, for example userspace picks an
> > incompatible update image, or the image is otherwise corrupted, all TDs
> > will experience SEAMCALL failures and be killed. The recovery of TD
> > operation from that event requires a reboot.
> >
> > Given there is no mechanism to quiesce SEAMCALLs, the TDs themselves mu=
st
> > pause execution over an update. The most straightforward way to meet th=
e
> > 'pause TDs while update executes' constraint is to run the update in
> > stop_machine() context. All other evaluated solutions export more
> > complexity to KVM, or exports more fragility to userspace.
> >
> > =3D=3D How to test this series =3D=3D
> >
> > This series can be tested using the userspace tool that is able to
> > select the appropriate TDX module and install it via the interfaces
> > exposed by this series:
> >
> >  # git clone https://github.com/intel/tdx-module-binaries
> >  # cd tdx-module-binaries
> >  # python version_select_and_load.py --update
> >
> > =3D=3D Base commit =3D=3D
> >
> > This series is based on:
> > https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?=
h=3Dtdx&id=3D9332e088937f
>
> Can you clarify which patches are needed from this tree? Is it just
> "coco/tdx-host: Introduce a "tdx_host" device" or is this series also
> depends on other patches?
>
> More specifically, does this series depend on "Move VMXON/VMXOFF
> handling from KVM to CPU lifecycle"?
>

Hi Chao,

Is this non-RFC series dependent on RFC patches?

What's the intended order of upstreaming the features and dependencies
being discussed here?

