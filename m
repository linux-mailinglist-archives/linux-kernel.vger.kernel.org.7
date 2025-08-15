Return-Path: <linux-kernel+bounces-770804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AAB27F17
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F209E4E60DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC73002C8;
	Fri, 15 Aug 2025 11:19:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF42BD58C;
	Fri, 15 Aug 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256779; cv=none; b=NWGan2U+9WHqm0vbyNDbcaxOmxAQ5lPVX/zkFHZrvnzOHQAv3XCDU9+VoUfIiPfqnlZbUd5YCIy5W0oEuC8JlYmPG7xhpEqjpRE7EsLBW9dm9uOJtwLq3kgAXzYHVIaLHFdTCL1CFEq8+FnK7Zlh3hMHiu5AyC7r71wBnSBd6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256779; c=relaxed/simple;
	bh=tmmn/mTbyDz6zft/q2USyM+hpFS9eINcgokcRHj/XSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiWyhy5ZOnklGXB7xTCqB/7800VzDz7+lXErvypT/vOl5VCEwePd5epGJ4jyxYswuS++99emSV4P/TndkeEc/TE4eMICJ7J0svT3B8DvnWqIwHufEqpDLhBdStxRPBqz3thaSV6rnBG0pHIfY3B4tfhchLBCOvf5MDaeUBm7n3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CE9C4CEF0;
	Fri, 15 Aug 2025 11:19:34 +0000 (UTC)
Date: Fri, 15 Aug 2025 12:19:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, glider@google.com,
	Marco Elver <elver@google.com>, ryabinin.a.a@gmail.com,
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
Message-ID: <aJ8XxLGiaVmWUCk6@arm.com>
References: <20250813175335.3980268-1-yeoreum.yun@arm.com>
 <20250813175335.3980268-2-yeoreum.yun@arm.com>
 <CA+fCnZd=EQ+5b=rBQ66LkJ3Bz2GrKHvnYk0DQLbs=o9=k0C69g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZd=EQ+5b=rBQ66LkJ3Bz2GrKHvnYk0DQLbs=o9=k0C69g@mail.gmail.com>

On Thu, Aug 14, 2025 at 07:03:35AM +0200, Andrey Konovalov wrote:
> On Wed, Aug 13, 2025 at 7:53 PM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > Since Armv8.9, FEATURE_MTE_STORE_ONLY feature is introduced to restrict
> > raise of tag check fault on store operation only.
> > Introcude KASAN store only mode based on this feature.
> >
> > KASAN store only mode restricts KASAN checks operation for store only and
> > omits the checks for fetch/read operation when accessing memory.
> > So it might be used not only debugging enviroment but also normal
> > enviroment to check memory safty.
> >
> > This features can be controlled with "kasan.store_only" arguments.
> > When "kasan.store_only=on", KASAN checks store only mode otherwise
> > KASAN checks all operations.
> 
> I'm thinking if we should name this "kasan.write_only" instead of
> "kasan.store_only". This would align the terms with the
> "kasan.fault=panic_on_write" parameter we already have. But then it
> would be different from "FEATURE_MTE_STORE_ONLY", which is what Arm
> documentation uses (right?).

"write_only" works for me, kasan is meant to be generic even though it
currently closely follows the arm nomenclature.

-- 
Catalin

