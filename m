Return-Path: <linux-kernel+bounces-850629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB4BD3557
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5B13C43F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52A257827;
	Mon, 13 Oct 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFqu546V"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC72512F5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364280; cv=none; b=jXCMpKJ4VSwiJ5TmpiiQ43Njd7+3ifDp7fRA50zktREM2vIfpMZUCriZt23MdIUbf263RwEfTwT2SdChyfbP8btljTOZnIaR1mftYdDhWAioUskHlEG6jbBOQIQuC5KSItbsDM1um9zIKiFj3dSrM4cw1hhsStUIAXah6uTXsyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364280; c=relaxed/simple;
	bh=k7Wnh0MDFRkiNum8Z2X+Q1EMJvXMBuyi/5gO1W0mwIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WsPJ+AVc8BmYxYrBfBLmYuS8EBktEex0kPwqHC8snOqMfbqyq5iISSzSpOkDlluKUzKEaLwb3ppGy/+bW01J79fre3YsgElgdgePiEM58weZn+A1HXgxcweUS5Cw9HA7KYFU7KA/QMIPritNefvNXRp8iWQ/Zo3xj0+IMRicon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LFqu546V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-277f0ea6fc6so174805085ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760364278; x=1760969078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXpOOr+C08LiSxfY7wTnlbBjPJg18+PGY+BCgjJ/7/c=;
        b=LFqu546VpmjJ4ZdzWiqTX9v4XD4B4/0KpHQJkByCwUhnC7zrBMRNeqtzPQ89sUmbCV
         7wBZCbhwsrBNcLOwjJ113uZP6C1U9E95nMGtu2k0/6Lx8W8sKw4tdqI2KiM2SLqWmESu
         pDJ8bx9gAIxKXV8AyOIxsNwV1rXCoAv2O0jbJ+TkeZC89lhmU48oXhv8lbmyHY4yiyzt
         /tnhYAZINDS1ujZo0bOtTr1K56Pq40ZksM/lqCj4lq9OjViaTMZhP7AJrxplfiUB78qM
         R3ozjd9RAuej3BIkJiJ/6naIwYs8gOz9OEk6cSkEw78SUZrGAD70z2pOo293A6j1jATm
         8NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364278; x=1760969078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXpOOr+C08LiSxfY7wTnlbBjPJg18+PGY+BCgjJ/7/c=;
        b=t6jJUhMlt1sI38xCpxZWUEYPqtSps+1Ja7kI4tqxYoKFFJTY9+1P7aPE0FZiXquVou
         68aYZ4KZYIeiAobYBw9nww7mdUw0gf0R82tCgwdiQrwGx3QEloFoGWrXnECrybrGEiZb
         Mm0bXz2cYycEYusSY0fyBq2z218E8fVQoARfqc7pS9H8wPPuEdEO5MWzEObiLXJrl2os
         BLBkc9g7D9EO0ofewgWA7xBbShsWBMuJsasbb33oh3++zgC9abhMt7AKbPp1JFi7esAe
         y5gt2SgFwQn1aIODq+i8WGc9BzKJ6/d6ZYSzSI9B73/698OAB6cqSp75g8ZYNdchNFFi
         Ui0g==
X-Forwarded-Encrypted: i=1; AJvYcCXAzpPnDiK36GTk6sOQh89gky5egmZX9fbkatbxeCuqpPcKgI3t/8jo7dOlMRfyQIpdnQ4Sxp80Z3LpuYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysDF/0qqCycf7KgV6/cDECe2wiOA2adt9tscwkgai2ZOgGKdCK
	HyaMrGViP/OpJyk/HeJcSxBzvpKLwiUWHElVP076Ef9MyA0eiV+oEJVmlVNWYwdBNmi5x7PL+z5
	H3OvGbw==
X-Google-Smtp-Source: AGHT+IHwYmKV6bklpg5vtbSKVTRl7C6XEgSh9a6Y5HHFfYZD2Yg6qM+/GQ0Os6vJiLGLtryEtk6AaBRhVnQ=
X-Received: from pjbst8.prod.google.com ([2002:a17:90b:1fc8:b0:330:523b:2b23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:910:b0:258:9d26:1860
 with SMTP id d9443c01a7336-290273ffeb7mr293116575ad.40.1760364278498; Mon, 13
 Oct 2025 07:04:38 -0700 (PDT)
Date: Mon, 13 Oct 2025 07:04:37 -0700
In-Reply-To: <20251012071607.17646-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251012071607.17646-1-shivankg@amd.com>
Message-ID: <aO0G9Ycu_SlISBih@google.com>
Subject: Re: [PATCH V3 kvm-x86/gmem 1/2] KVM: guest_memfd: move
 kvm_gmem_get_index() and use in kvm_gmem_prepare_folio()
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: pbonzini@redhat.com, david@redhat.com, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

FWIW, there's no need to put the base (target?) branch in the subject.  The
branch name is often incomplete information; by the time someone goes to apply
the patch, the branch may have changed significantly, or maybe have even been
deleted, e.g. I use ephemeral topic branch for kvm-x86 that get deleted once
their content is merge to kvm/next.

From Documentation/process/maintainer-kvm-x86.rst, my strong preference is that
contributors always use kvm-x86/next as the base branch,

  Base Tree/Branch
  ~~~~~~~~~~~~~~~~
  Fixes that target the current release, a.k.a. mainline, should be based on
  ``git://git.kernel.org/pub/scm/virt/kvm/kvm.git master``.  Note, fixes do not
  automatically warrant inclusion in the current release.  There is no singular
  rule, but typically only fixes for bugs that are urgent, critical, and/or were
  introduced in the current release should target the current release.
  
  Everything else should be based on ``kvm-x86/next``, i.e. there is no need to
  select a specific topic branch as the base.  If there are conflicts and/or
  dependencies across topic branches, it is the maintainer's job to sort them
  out.
  
  The only exception to using ``kvm-x86/next`` as the base is if a patch/series
  is a multi-arch series, i.e. has non-trivial modifications to common KVM code
  and/or has more than superficial changes to other architectures' code.  Multi-
  arch patch/series should instead be based on a common, stable point in KVM's
  history, e.g. the release candidate upon which ``kvm-x86 next`` is based.  If
  you're unsure whether a patch/series is truly multi-arch, err on the side of
  caution and treat it as multi-arch, i.e. use a common base.

and then use the --base option with git format-patch to capture the exact hash.

  Git Base
  ~~~~~~~~
  If you are using git version 2.9.0 or later (Googlers, this is all of you!),
  use ``git format-patch`` with the ``--base`` flag to automatically include the
  base tree information in the generated patches.
  
  Note, ``--base=auto`` works as expected if and only if a branch's upstream is
  set to the base topic branch, e.g. it will do the wrong thing if your upstream
  is set to your personal repository for backup purposes.  An alternative "auto"
  solution is to derive the names of your development branches based on their
  KVM x86 topic, and feed that into ``--base``.  E.g. ``x86/pmu/my_branch_name``,
  and then write a small wrapper to extract ``pmu`` from the current branch name
  to yield ``--base=x/pmu``, where ``x`` is whatever name your repository uses to
  track the KVM x86 remote.

My pushes to kvm-x86/next are always --force pushes (it's rebuilt like linux-next,
though far less frequently), but when pushing, I also push a persistent tag so
that the exact object for each incarnation of kvm-x86/next is reachable.  Combined
with --base, that makes it easy to apply a patch/series even months/years after
the fact (assuming I didn't screw up or forget the tag).

