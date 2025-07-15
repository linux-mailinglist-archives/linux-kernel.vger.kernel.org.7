Return-Path: <linux-kernel+bounces-731595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72032B056F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D08188B7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE42D63E4;
	Tue, 15 Jul 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xk3C5fLn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C122DFB5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572715; cv=none; b=G6EI5Sgq/FopTTFi7DaNh/IkF8qpd4gKtg4nn/6a07XFxAPtBEkFWDuvAqmUczY1MK88Qu1YUOFn7OrvKgdYBr3QiVL/vE5Jr7J0dd7PwiQhe+9KVcLAq/crmYfBOJdUVRivtexQ8qZdNhE8L9vj1lR9v6ULYAOqYldld/bKC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572715; c=relaxed/simple;
	bh=pKMd/ZxcwwVU0Vlnn1gZ09aywe3UzeCDMUxxwekki1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiOVEbIrfZy+B74+pohVtX+voVn9pFOZ9PX2pvNLYas13rXyjUP4b3qeS76G5oj5c8rG0Sx9Q0cPk3Y/qDVCAzF24XBmtbG+wj9BkG8trA/kE64hdSs9cEaEvSh23MqQDTSwadq6ITplYDmmocABPqr07Wf7/hBXiuU4AUOsLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xk3C5fLn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF46140E00DE;
	Tue, 15 Jul 2025 09:45:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t_oX5a8liuEj; Tue, 15 Jul 2025 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752572707; bh=m/pf36P9FNkln7pqMd9qt41JY1LEj4XQn2g808gPdkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xk3C5fLncb0oAvp8l2GOWrbVV8gy1N349+aGyRxBkC2gMWivqLU8BjD8EL9HM0Bvg
	 yYjnk48tFkbrem9MSmcOhC3NOudyxNUBpeWvCJalHG7akvJaE19MfruZ7lqvQtkI/y
	 o3VZCqqPgwQ3kGfT1bZw7Hpd0mGPqbZj674qK0xUPIb0aE4i7zwhWMXLuz6CjYr08F
	 mNUbl0UbvzokEpfCzVaT5Erud4uaAJe9XVyGD4zlY0hbdBj68Z9muoSSn9I5ajnULb
	 35Rg+ZrsYF2mODZ/Zd8aHhx4g5eSFKUvrkJGpd08/lhUqTVKMfPhRRlfhweu7ftwoO
	 juuy6sdpoby3uVnpb3xZ6jfW5S9JVDmGQ9kMum8ibxVioCuNyttKSVgFqSeaTCvp1R
	 2afLfZ35wb3sXkR0nvua6NYNYJfRAorCF7Kfor6ESBcMPPzZd0hkwSQXgAQ4CuI7jN
	 yhs7wrMbDyr4XYSlWCPXyj107zchwQ6e4a79u9GlpQhqWOvoeeb+XdTVZocNvxdUzG
	 lqCUDAh/lYViGvULcW54JNG8r1dJoXP6fm0OpVLbxxhwaaCf6PiEbUl5pTp+nlyVzw
	 +iRVe96oz0EQQYKfMXs18uiruYMWbrIP64uAPIVcBHqKNERYit587fIMBVs7IXAcX3
	 aTOJ24bhrzVswc7x+Ijt3qTc=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 27F0540E0213;
	Tue, 15 Jul 2025 09:44:58 +0000 (UTC)
Date: Tue, 15 Jul 2025 11:44:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com,
	santosh.shukla@amd.com
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
Message-ID: <20250715094451.GDaHYjE68KhYiz_r20@fat_crate.local>
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com>
 <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com>
 <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
 <aHUx9ILdUZJHefjZ@google.com>
 <20250715083827.GBaHYTg9eU55LcHKR1@fat_crate.local>
 <85ecuhx1eh.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85ecuhx1eh.fsf@amd.com>

On Tue, Jul 15, 2025 at 09:13:10AM +0000, Nikunj A Dadhania wrote:
> That will panic the SNP guest instead of #GP:
> 
> root@ubuntu:~# wrmsr 0xc0010134 0
> [   20.804335] ------------[ cut here ]------------
> [   20.804336] WARNING: arch/x86/coco/sev/vc-handle.c:383 at vc_handle_exitcode.part.0+0xc1b/0x1090, CPU#0: wrmsr/607
> ...
> [   20.804507] SEV: Unsupported exception in #VC instruction emulation - can't continue
> [   20.804508] ------------[ cut here ]------------
> [   20.804508] kernel BUG at arch/x86/coco/sev/vc-handle.c:123!
> [   20.804514] Oops: invalid opcode: 0000 [#1] SMP NOPTI

You need to make trapnr become X86_TRAP_GP in vc_forward_exception() so that
the GP handler is called.

Or wait for Tom to wake up to double-check his suggestion... :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

