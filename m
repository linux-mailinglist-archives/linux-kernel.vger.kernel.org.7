Return-Path: <linux-kernel+bounces-851169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68171BD5AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E3764F4BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A742D59F7;
	Mon, 13 Oct 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Z9UDhhz"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA02D542A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379422; cv=none; b=HHcTxgDmpaTqV99yrUTLVr1uJjTEarpu6fCTRwk+32ORqtqx+CT9QEnNyaxdL7/CLuwgkL03INGKoafNGEwhYvmwARKdij/BhQZjx9daxfLxNhOjT5gVRDP0DynKeHV6Vv0mkdTAqw1LcV/FCQWg7QCt+u+cKCOrCxN4ckKwh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379422; c=relaxed/simple;
	bh=yJzr3tT3DBco34PikB5TwPamKVOkAz5+ubxL1huczkU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dxy7KjKe9IH2kpNJyuqnF5etz2PU5e8j1brBl13AesmxxTsmeYtd1i0o+n+ED6Tha59qWNfa8WGkLT/V7EP1dwffNi5BuhKiI0tOoRLmzBRDPCIbBnxLS1KlxGNkoYphn/5/uo9YTwj5YF99Y2Up5dwVKveaIEEHhnHAh5GwVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Z9UDhhz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so8132952a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379420; x=1760984220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7IVrwkMyjg8NbRQMhjGy5h8IAzL7nYRX+qhKY6RS/E=;
        b=0Z9UDhhzgVXiEtFWcG2ttvjTiGRCjjeNDLFi9ITQbm/mdyarUG9vWSd7fV4SlPCpLO
         ery4DWXz4aYW8LANwxymL2+y5IyT6bu67M5U1IkXf8+l9Ojw9yOXwDnFqiilbshgK53k
         BqfZbZyJbyXUafnCXAp8wA6lqPSB4hF3SbhQyX+KFfzbaXnsnLvIesAvurZ8+v74TwxN
         Kf+RUHJ7PmcT4zaouuaKB0sTMEwFjlmcGuVT6fMnuW554d3KWj6rFM5m0J+cJRGAXnz5
         XTjgpF4DIfNWTWsaWN+2P0e+YmR0HaG90F4pk+5j3urgxS2ZLg2PiQR58Tg9kV0acFME
         apRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379420; x=1760984220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7IVrwkMyjg8NbRQMhjGy5h8IAzL7nYRX+qhKY6RS/E=;
        b=HXdxVvEqKrB24A0H/uKUDqxMvyMiiCMSV+Oj2f+spiTYOktL/CBKSY2pRH4NNQ+ZCn
         Zzj7+fQlOHUZmH7WEZsgUQ/N2pKj5ea07kiXslrA1FwycBviNBc6619sB69YELVVjdEN
         mkFvjDsyjomx+EQUTOP0mTIB9FLBDR1DHWOL4xZf6ZvoIcBqVDclsJrficEpubw1wYyj
         A2cT2ffE3olPYYdH2/vlcdQNA9AcNiKb29tAD9WRAj6toREAPCNRyWezsbD0w8C1Dp/+
         g+32noLPycyOiyLuuEA5/dyTQh4gKUZzvSRlBhbJSERm6o8DOMj8uxcppPXbinJ7TyzL
         q05w==
X-Forwarded-Encrypted: i=1; AJvYcCW40GV0HWu57Ic0Wo+Ut35Rrq68VMabcLSje5HXt30IZ1oKwZM25D/qX1HlIuXtX8PyXdWPb7ri1KcO+fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6LhyoAbh8uDiLPFxvmzDUfvD8sLRMtpWrUxYimE2/4Zfbk+n
	KvPtcnWjexCKfVQTxegpcRGHtpih+3CQkJzqrMsMPEww0+dmnN7X1geXOSY7OVIZpWcpRrMe2Gk
	2ZvlpNg==
X-Google-Smtp-Source: AGHT+IFGEuFtFYpi2vyy3A8eLUuhfUiGbCqURf5zV4Cr2s13TifQkVs61vrdc1+myRcVrJpT3FYwGxjIl0w=
X-Received: from pjqo23.prod.google.com ([2002:a17:90a:ac17:b0:33b:51fe:1a7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4b:b0:339:9a71:efd8
 with SMTP id 98e67ed59e1d1-33b513a24demr29447382a91.37.1760379419894; Mon, 13
 Oct 2025 11:16:59 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:16:58 -0700
In-Reply-To: <aO0G9Ycu_SlISBih@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251012071607.17646-1-shivankg@amd.com> <aO0G9Ycu_SlISBih@google.com>
Message-ID: <aO1CGlKGso4LLtS5@google.com>
Subject: Re: [PATCH V3 kvm-x86/gmem 1/2] KVM: guest_memfd: move
 kvm_gmem_get_index() and use in kvm_gmem_prepare_folio()
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: pbonzini@redhat.com, david@redhat.com, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Sean Christopherson wrote:
> FWIW, there's no need to put the base (target?) branch in the subject.  The
> branch name is often incomplete information; by the time someone goes to apply
> the patch, the branch may have changed significantly, or maybe have even been
> deleted, e.g. I use ephemeral topic branch for kvm-x86 that get deleted once
> their content is merge to kvm/next.
> 
> >From Documentation/process/maintainer-kvm-x86.rst, my strong preference is that
> contributors always use kvm-x86/next as the base branch,

Oh, right, this is a funky situation though due to kvm-x86/gmem not yet being
folded into kvm-x86/next.  So yeah, calling out the base branch is helpful in
that case, but providing the --base commit is still preferred (and of course,
they don't have to be mutually exclusive).

>   Base Tree/Branch
>   ~~~~~~~~~~~~~~~~
>   Fixes that target the current release, a.k.a. mainline, should be based on
>   ``git://git.kernel.org/pub/scm/virt/kvm/kvm.git master``.  Note, fixes do not
>   automatically warrant inclusion in the current release.  There is no singular
>   rule, but typically only fixes for bugs that are urgent, critical, and/or were
>   introduced in the current release should target the current release.
>   
>   Everything else should be based on ``kvm-x86/next``, i.e. there is no need to
>   select a specific topic branch as the base.  If there are conflicts and/or
>   dependencies across topic branches, it is the maintainer's job to sort them
>   out.
>   
>   The only exception to using ``kvm-x86/next`` as the base is if a patch/series
>   is a multi-arch series, i.e. has non-trivial modifications to common KVM code
>   and/or has more than superficial changes to other architectures' code.  Multi-
>   arch patch/series should instead be based on a common, stable point in KVM's
>   history, e.g. the release candidate upon which ``kvm-x86 next`` is based.  If
>   you're unsure whether a patch/series is truly multi-arch, err on the side of
>   caution and treat it as multi-arch, i.e. use a common base.
> 
> and then use the --base option with git format-patch to capture the exact hash.
> 
>   Git Base
>   ~~~~~~~~
>   If you are using git version 2.9.0 or later (Googlers, this is all of you!),
>   use ``git format-patch`` with the ``--base`` flag to automatically include the
>   base tree information in the generated patches.
>   
>   Note, ``--base=auto`` works as expected if and only if a branch's upstream is
>   set to the base topic branch, e.g. it will do the wrong thing if your upstream
>   is set to your personal repository for backup purposes.  An alternative "auto"
>   solution is to derive the names of your development branches based on their
>   KVM x86 topic, and feed that into ``--base``.  E.g. ``x86/pmu/my_branch_name``,
>   and then write a small wrapper to extract ``pmu`` from the current branch name
>   to yield ``--base=x/pmu``, where ``x`` is whatever name your repository uses to
>   track the KVM x86 remote.
> 
> My pushes to kvm-x86/next are always --force pushes (it's rebuilt like linux-next,
> though far less frequently), but when pushing, I also push a persistent tag so
> that the exact object for each incarnation of kvm-x86/next is reachable.  Combined
> with --base, that makes it easy to apply a patch/series even months/years after
> the fact (assuming I didn't screw up or forget the tag).

