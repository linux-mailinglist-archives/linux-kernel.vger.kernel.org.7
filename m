Return-Path: <linux-kernel+bounces-867849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606CC03A07
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D353B29FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0F258CE8;
	Thu, 23 Oct 2025 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3842GFr"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720986340
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256862; cv=none; b=hQZbGwUYlvDpz6bColk18HwKf8MKxCLANvp1Fb5NyS5mvSInF5idhfqBcDQYJ6GgpSBRT+nyRrEADcp6oS22WeCNR8l3yQ034K69YYGxSc19wMxkIUPYHKYukFNOZlo2qbPd6eWtopvXVKLbiT49Cc7/5uPIFp0i+gO1F/qBB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256862; c=relaxed/simple;
	bh=fSsdRWecqQa6nNgrFLCmMLEOAUbyDJ50RnVjL+MYgvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOdVP5l15ldTw4u2BFmp1wDb1I/hdw3NrnWMWu+9m+M4klg8SFI/bPVDar477zr3KwPzX6tTKF/3TmEgTR3FqTWXl8nddiEeStzjXspTsQTvpOJRj77eI8c/TLql18+T8HnNbweQY+49w6sesYqag0hFkGfxOMan7i27DH24ayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3842GFr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so57595ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761256859; x=1761861659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK4oKnHNzcuq0rwncmx4pYGQWpDWxT04xX+7yY0pJF8=;
        b=E3842GFrMxyB7zbT/PQb9c/v4KJsvX7PtBKP9j8CgZHXSBegKhOxWO56rd5/H8SyYo
         ejYVkZMfSFUvdMExIKKLGSUsN2fcEtfPIwF1sYUvFQ29QYJtw1uZ9tZNRN8XJXy2yB5h
         dRhve3l3J7h93KZGUXa/XO8tKJpgEx16w9YsuoZ4YWryXKYh6MoBsxylug0NYsNLwsts
         9IH1d68BPWMnp2v1lR4QxjVLitce94WptO688qBNYxGCCh8gJSx4qZ+4Xhd6w8z9F/dJ
         vvuzkHh1vPxB4nRc1xrOGfTZSMyb5/CDlZwwGCrf9I0JuA/sNIujAZb4sC8wAUnPydIx
         QWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761256859; x=1761861659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iK4oKnHNzcuq0rwncmx4pYGQWpDWxT04xX+7yY0pJF8=;
        b=ADTEJAzAbSlZkSbavRzdeE3tlvxr/gwK1eQFVxky6cdKb1Rs7pUGqUqGWO1fSOsf92
         3ZwV4QpWjB7GFphdQQVJ6B9/e0PEBVo0RgcqzQ7anBieX70CTETVE4WzXHMIMy5b5MDb
         UhZ20i5RjKIYj3g3rdjiSAR6Ji67zEpXk0SX6C8ZuTfhgd1chU+qi+PIXHd1pvgDDHmf
         Ek6b2ciPBeqkcz9Zb+U6+g9EHDLqV08kgsHCkKNI5wqKnZoffqBRl0Wl8oGyFn9Vvjik
         K3Bsq0PH/B+El7zN9CntNPo1gEVpci28eOz3+NcTrJwtPlgRfQvHvuF8Nysg/h7fpRW+
         r6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVuNlxrXbn/k7gLHNHGr5QD3Z0465euDuFVZhV/nTHjLgqArLsyjJA6nNSNAIaHE8LjOaWMCYCoW+cRb6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfE6xdKz0lgCNPVvw8wkV4Eu42LhUC0exbNaamCl5J14tjhGp0
	RhBSTassSTO5p+sMfZCESCRTUFxTzW2i1zwc/8b+bm4HsvrZlJVZkb2Tv4Db96/ZCW4coh/v+bd
	O/E+jAMuXa7cpCgCgkcUby1cFYZ43w8XfN9EBRxm8
X-Gm-Gg: ASbGncv03Na6aSnFOQVhVGitABQJFIjZJnsh6rFmGu1q3NEqZpj/rOAXBh8hiN/25eO
	TxPpK3ukMy04PW/yOgBPKNHDqMi+nlzUyg9cVJr4lwdMMZ59gcna4mGfoOlIN87lyI83FqfW8uw
	8nP9Edt9dTvimoSKcr0o/M6Ec7IrwQTtdE+dERKxeV7BHY4ZeKO59lgWTz0WZ5p6O+FQCDdtS6z
	AEgRZDmAs1+lfareR2BwomF1bf9via4lWRASrLJhrGSn2ub7oLANEg4p26Oljc+PPPL3qmYaAst
	iL+u9HUuqIbmDjM/wNnMcw5jF6mbwrTDJ9tIiL8=
X-Google-Smtp-Source: AGHT+IHz6r7O35iYyVRRBZJLFA/qCXABDW4tGQEbAQ+cdGVt03tHSYlQ4wP2Y0e+2Ox9XlZzezDFi6Kw4IgvUynJ1yg=
X-Received: by 2002:a17:902:f542:b0:290:dc44:d6fa with SMTP id
 d9443c01a7336-294896994b2mr1236445ad.16.1761256859241; Thu, 23 Oct 2025
 15:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com> <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com> <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com> <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
 <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com> <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com>
In-Reply-To: <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 23 Oct 2025 15:00:43 -0700
X-Gm-Features: AS18NWCc7EBWpHeHGZgKjL9rt91xyVTzV83dAB2GikFO-hGA2BC5MLJCuOQbeH4
Message-ID: <CAGtprH89JhD+sPStX=aOSRh5B0WMaiBZcA2hC0p0-AzbGkyheA@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: Dave Hansen <dave.hansen@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>, 
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:10=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 10/23/25 13:31, Vishal Annapurve wrote:
> ...
> >> Admin logic to update TDX modules can be designed to either retry
> >> failed TDX module updates or to be more robust, adds some
> >> synchronization with VM creation attempts on the host. i.e. I think
> >> it's fine to punt this problem of ensuring the forward progress to
> >> user-space admin logic on the host.
> > Discussed offline with Erdem Aktas on this. From Google's perspective
> > "Avoid updates during updatesensitive times" seems a better option as
> > I mentioned above.
> >
> > To avoid having to choose which policy to enforce in kernel, a better
> > way could be to:
> > * Allow user space opt-in for "Avoid updates during updatesensitive tim=
es" AND
> > * Allow user space opt-in for "Detect incompatibility after update" as =
well OR
> > * Keep "Detect incompatibility after update" enabled by default based
> > on the appetite for avoiding silent corruption scenarios.
>
> I'd really prefer to keep this simple. Adding new opt-in ABIs up the
> wazoo doesn't seem great.
>
> I think I've heard three requirements in the end:
>
> 1. Guarantee module update forward progress
> 2. Avoid "corrupt" TD build processes by letting the build/update
>    race happen
> 3. Don't complicate the build process by forcing it to error out
>    if a module update clobbers a build
>
> One thing I don't think I've heard anyone be worried about is how timely
> the update process is. So how about this: Updates wait for any existing
> builds to complete. But, new builds wait for updates. That can be done
> with a single rwsem:
>
> struct rw_semaphore update_rwsem;
>
> tdx_td_init()
> {
>         ...
> +       down_read_interruptible(&update_rwsem);
>         kvm_tdx->state =3D TD_STATE_INITIALIZED;
>
> tdx_td_finalize()
> {
>         ...
> +       up_read(&update_rwsem);
>         kvm_tdx->state =3D TD_STATE_RUNNABLE;
>
> A module update does:
>
>         down_write_interruptible(&update_rwsem);
>         do_actual_update();
>         up_write(&update_rwsem);
>
> There would be no corruption issues, no erroring out of the build
> process, and no punting to userspace to ensure forward progress.
>
> The big downside is that both the build process and update process can
> appear to hang for a long time. It'll also be a bit annoying to ensure
> that there are up_read(&update_rwsem)'s if the kvm_tdx object gets torn
> down during a build.
>
> But the massive upside is that there's no new ABI and all the
> consistency and forward progress guarantees are in the kernel. If we
> want new ABIs around it that give O_NONBLOCK semantics to build or
> update, that can be added on after the fact.
>
> Plus, if userspace *WANTS* to coordinate the whole shebang, they're free
> to. They'd never see long hangs because they would be coordinating.
>
> Thoughts?

Yeah, this approach sounds reasonable.

