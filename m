Return-Path: <linux-kernel+bounces-826023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987FB8D5AB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198CF189D04A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC362BE64A;
	Sun, 21 Sep 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG5uWx77"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B30276051
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758435860; cv=none; b=DCdhf7krFO0SuskZV3HVgWf1ye6tvQ26GwTOkpVFZaIs38bUCnmai6IVptfYEmLw19epWLNQvktyBu1IW2zi5nj7z/adm5kcgkrmhu3sdsRGcCZbQYNv8bH7D0zM7/A5NDJuBLSRgmKGRg1p+EvENoTIXspo1srHktF7bbvcRY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758435860; c=relaxed/simple;
	bh=7ncQyYZxpGQpoWZu4O4eeQ31bFZfa7Ff2+7sYzrfMf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbdY5J+SYfZoCYrgM1Ga+/1dkK1GFu/HDQECvvqcU3+DuvInvKXuAkpusM+9WOkYl0zxkKGOvfJu2ots0jUiF9kbbrCDOuS5sRbSMtT1H0gND8F5D8SRFn9TIBC6sfYb302HKDmR9ursAyAk3VfFR85l0xwyYavfFuY7YKRwGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG5uWx77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E26C4CEE7;
	Sun, 21 Sep 2025 06:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758435860;
	bh=7ncQyYZxpGQpoWZu4O4eeQ31bFZfa7Ff2+7sYzrfMf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mG5uWx77WE0EGnCrHbQasMsoBXvZLyPyefnHDo/kv1dErYEdI1ixpuJRy2SCwFJt8
	 lVCSDFtq2gEKcqR29ZP6JNVPZQobSCkg/IsOC4p/3Dgp6QvRkYbxJOtEqBxvkwxKsg
	 10gPrepuN9n3PonQTVtPdEmWnCGXSJxgx/6QAM9OQW7H/lFS1bG1wQ2xWQbcAfH1Ki
	 HU4G5KYrRpareJGa4IVC5HrYOZr13dvUQj0Br2epvj/QlOUPAltIoDZfvuotLTFxz2
	 9LLBuQKO+rYqzfoQBXQ5m3NcTW+TsUdsGScsXteM/3JKOYFOWJJDdDtIuILWqBPyq5
	 PSMCpgFOK7XZg==
Date: Sun, 21 Sep 2025 09:24:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jan Engelhardt <ej@inai.de>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <aM-aDAIbKqBMN2DQ@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <3ns36rp5-rp37-1nns-9q43-op05or6s26nq@vanv.qr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ns36rp5-rp37-1nns-9q43-op05or6s26nq@vanv.qr>

On Sun, Sep 21, 2025 at 07:54:31AM +0200, Jan Engelhardt wrote:
> 
> On Friday 2025-09-19 00:25, Cong Wang wrote:
> 
> >This patch series introduces multikernel architecture support, enabling
> >multiple independent kernel instances to coexist and communicate on a
> >single physical machine.
> >
> >Each kernel instance can run on dedicated CPU
> >cores while sharing the underlying hardware resources.
> 
> I initially read it in such a way that that kernels run without
> supervisor, and thus necessarily cooperatively, on a system.
> 
> But then I looked at
> <https://multikernel.io/assets/images/comparison-architecture-diagrams.svg>,

The diagram also oversimplifies containers, with system containers the "OS"
runs inside the container and only the kernel is shared.

It's interesting to hear how the multikernel approach compare to system
containers as well.

> saw that there is a kernel on top of a kernel, to which my reactive
> thought was: "well, that has been done before", e.g. User Mode Linux.
> While UML does not technically talk to hardware directly, continuing
> the thought "what's stopping a willing developer from giving /dev/mem
> to the subordinate kernel".
> 
> On second thought, a hypervisor is just some kind of "miniature
> kernel" too (if generalizing very hard).
> 

-- 
Sincerely yours,
Mike.

