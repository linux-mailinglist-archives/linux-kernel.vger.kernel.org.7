Return-Path: <linux-kernel+bounces-724526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29023AFF3FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADAD7A9707
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497D23F40A;
	Wed,  9 Jul 2025 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wtfc/Bdt"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D88A92E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097013; cv=none; b=DWCeQJWQ5XpgCiqKOQErpBn2fFZlKps+KIxzQ8uCXTmSuD5ea0Rq2zwlGvMNHWBSZJQBArP17g6HNuPtPCFFL5k9P7cx6QrDVj/hJ7KAzUNaCJDEf/raq6gXGJF5boKI4iL0udCah0sObjMTcyKwdxBNx9BeVCVOP12XpVEk2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097013; c=relaxed/simple;
	bh=qS8xCwqQJQNA2xukALQdC1zCv6E13NjHv21ApuVNiRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e15QTqWX7Mjoj4iRMxMgQM7g8AYyAnDfpdP8eZyI9SKQmqYBWYaEkn8ANhqWD0IxD/SSJzpxONdlGb4FE8KgrZcIeZ/QXmT+S629NtzSmKq20HhxuhdNRDhdkCKrFMVVFDy7KID5n+cLbw+BuAkZnOstBzys+afWEWyW7zc32mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wtfc/Bdt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7425efba1a3so352711b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097011; x=1752701811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3d6tzfJc09QAN3tOMltMcwq5vs2xgKEQEBLpFxZA4Y=;
        b=Wtfc/Bdt7gAiOMNUjKMvspuvunFJ23xGAXh7bfZf1orGgwme8Y8CSpsRpZjehWx4HY
         M+T58xwN9nQXGFoEiN+ISAokLF2UPMETsvmWGlawt8DfIYO0gWC5v9lw/d/V70QA9bIK
         ysRNAyvPkRtOk66ojRZ4G46QGCWuI7kAh0HIUa09bkC4QByUvaVVk2TUHs+82chqbbnl
         edzmrvYiIbuesdeSDCVvjg8RrhiezRVnqvuJtriBGIw+tmykL/Wnjomqe3S4SdpvO4tp
         qStjXdghUwvlQSgbMBHcENAGw/GIePjtTB3rDnBcTj9H7u6AayQ2YSdagVc/b/bLAZMy
         /Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097011; x=1752701811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3d6tzfJc09QAN3tOMltMcwq5vs2xgKEQEBLpFxZA4Y=;
        b=iiybfMB9r03dndsnEim6gxDvDKX6WaGr8+3GD+fXUBW2tndLhkNPrJMxtyTbOTpN6y
         I8kpmF1hlT7hRjBasX/qGEn1f7klN3Tq6196HqE5RAtrAn0ML4z90/nmVB2ba7fsScKv
         lFtUJ1h1zTBOWmUccT1LjdupwF0LoBPEd2VMMw6lFNvstrdE9sgzqspV4UzPAU+xMczc
         pbaKO+Ppvs1/CKq4xQqN8tbyhtnoT7RhSZJLyuiIYgM4UXjgObU/StB2K4n3yv7CccDK
         6ROAsb72pBardnKsu3S+asQ2HmCYzvVa909ZVi0D2GDBHyAc4YvPbNOsdWpNKAldf1U6
         eiOg==
X-Forwarded-Encrypted: i=1; AJvYcCV7fVRvrFmTvu2WJJ8Xifki3yPUHvciKL0QT9vAawS2wq83p2bwT54HkLxXpg8CDlMyhJckwWnIAzLggPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEbHb22jcMo7uDnuaRxxzM7NAWHeamyUI23yEx3j1LE8Lgcd8H
	81wzbHGimvYhn8Ab0ckz4Dc6FEjKx04uzZAc0QvRfThS+Rb2+UxjrL7g1s3wGrKReZvYWJsF0sh
	Odw4f+A==
X-Google-Smtp-Source: AGHT+IFLEqNTh1QWENQoKcaGQJ6FjDiy9bAAhlEBb5QtB5Bh8MLqQr+R1uQHMdCvh3BdwLZPRf9uwMB9da4=
X-Received: from pfbct18.prod.google.com ([2002:a05:6a00:f92:b0:749:2cc7:bd89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d21:b0:220:2fe9:f07a
 with SMTP id adf61e73a8af0-22fc2b18849mr1713280637.6.1752097011498; Wed, 09
 Jul 2025 14:36:51 -0700 (PDT)
Date: Wed, 9 Jul 2025 14:36:50 -0700
In-Reply-To: <20250709185757.GDaG67tbGFYHUQxte2@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522233733.3176144-1-seanjc@google.com> <aG6X__K8MvVYORkr@google.com>
 <20250709185757.GDaG67tbGFYHUQxte2@fat_crate.local>
Message-ID: <aG7g8vNejmxfftA-@google.com>
Subject: Re: [PATCH v3 0/8] x86, KVM: Optimize SEV cache flushing
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Zheyun Shen <szy0127@sjtu.edu.cn>, Mingwei Zhang <mizhang@google.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Borislav Petkov wrote:
> On Wed, Jul 09, 2025 at 09:25:35AM -0700, Sean Christopherson wrote:
> > On Thu, May 22, 2025, Sean Christopherson wrote:
> > > This is the combination of Kevin's WBNOINVD series[1] with Zheyun's targeted
> > > flushing series[2].  The combined goal is to use WBNOINVD instead of WBINVD
> > > when doing cached maintenance to prevent data corruption due to C-bit aliasing,
> > > and to reduce the number of cache invalidations by only performing flushes on
> > > CPUs that have entered the relevant VM since the last cache flush.
> > > 
> > > All of the non-KVM patches are frontloaded and based on v6.15-rc7, so that
> > > they can go through the tip tree (in a stable branch, please :-) ).
> > 
> > Tip tree folks, any feedback/thoughts on this series (patches 1-4 in particular)?
> > It'd be nice to get this into 6.17, and I'd really like land it by 6.18 at the
> > latest.
> 
> I'll take a look tomorrow.
> 
> If I queue 1-4, would you like an immutable branch to merge for the other 4?

Yes please, thanks!

