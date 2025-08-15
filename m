Return-Path: <linux-kernel+bounces-771302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5DEB28550
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12B1AE8724
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F99031771A;
	Fri, 15 Aug 2025 17:45:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4343176EB;
	Fri, 15 Aug 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279900; cv=none; b=ojYcIfw/Nj9dThPnj+wsgXfGAiRwE9V7qYL0SQeikapZ5lTWhfgQ2QLkicpipiWI1NBeSrssvINudXbacLybjhtZXyrViuu9BueS+8Luzr9LG6G8YACmUR8SC+/jPAFJ3eGHJtplAPg5ltSxlYse+mJfA0wVJe8NuKMGoc8mJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279900; c=relaxed/simple;
	bh=RHqKw7XS72Z1iYiuqOd8YdRwnOhWkgqU6B1xQq+3GVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai3g3X9EJ8n/Z6+nHYXhgmiMPd6e6pzZRc864tkRya+QU31PfsY3Zht2FehxSPaWKxWSHe3QlLzWiZKfOuhVFfIAuKogCoPexzj00kgFp+YJA125hfh3ybB9wf/Dvkg5XYLYEo0Er+gMGXHvRH9wVpsIjiVTTRnsjOSBwtug4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A235BC4CEF1;
	Fri, 15 Aug 2025 17:44:55 +0000 (UTC)
Date: Fri, 15 Aug 2025 18:44:53 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com, corbet@lwn.net,
	will@kernel.org, akpm@linux-foundation.org,
	scott@os.amperecomputing.com, jhubbard@nvidia.com,
	pankaj.gupta@amd.com, leitao@debian.org, kaleshsingh@google.com,
	maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] kasan/hw-tags: introduce kasan.store_only option
Message-ID: <aJ9yFZ0aobVUPDip@arm.com>
References: <20250813175335.3980268-1-yeoreum.yun@arm.com>
 <20250813175335.3980268-2-yeoreum.yun@arm.com>
 <aJ8WTyRJVznC9v4K@arm.com>
 <aJ87cZC3Cy3JJplT@e129823.arm.com>
 <aJ9OA/cHk1iFUPyH@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ9OA/cHk1iFUPyH@e129823.arm.com>

On Fri, Aug 15, 2025 at 04:10:59PM +0100, Yeoreum Yun wrote:
> > > Like we do in mte_enable_kernel_asymm(), if the feature is not available
> > > just fall back to checking both reads and writes in the chosen
> > > async/sync/asymm way. You can add some pr_info() to inform the user of
> > > the chosen kasan mode. It's really mostly an performance choice.
> >
> > But MTE_STORE_ONLY is defined as a SYSTEM_FEATURE.
> > This means that when it is called from kasan_init_hw_tags_cpu(),
> > the store_only mode is never set in system_capability,
> > so it cannot be checked using cpus_have_cap().
> >
> > Although the MTE_STORE_ONLY capability is verified by
> > directly reading the ID register (seems ugly),
> > my concern is the potential for an inconsistent state across CPUs.
> >
> > For example, in the case of ASYMM, which is a BOOT_CPU_FEATURE,
> > all CPUs operate in the same mode —
> > if ASYMM is not supported, either
> > all CPUs run in synchronous mode, or all run in asymmetric mode.
> >
> > However, for MTE_STORE_ONLY, CPUs that support the feature will run in store-only mode,
> > while those that do not will run with full checking for all operations.
> >
> > If we want to enable MTE_STORE_ONLY in kasan_init_hw_tags_cpu(),
> > I believe it should be reclassified as a BOOT_CPU_FEATURE.x
> > Otherwise, the cpu_enable_mte_store_only() function should still be called
> > as the enable callback for the MTE_STORE_ONLY feature.
> > In that case, kasan_enable_store_only() should be invoked (remove late init),
> > and if it returns an error, stop_machine() should be called to disable
> > the STORE_ONLY feature on all other CPUs
> > if any CPU is found to lack support for MTE_STORE_ONLY.
> >
> > Am I missing something?

Good point.

> So, IMHO like the ASYMM feature, it would be good to change
> MTE_STORE_ONLY as BOOT_CPU_FEATURE.
> That would makes everything as easiler and clear.

Yeah, let's do this. If people mix different features, we'll revisit at
that time. The asymmetric tag checking is also a boot CPU feature.

-- 
Catalin

