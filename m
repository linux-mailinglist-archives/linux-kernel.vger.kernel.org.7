Return-Path: <linux-kernel+bounces-771305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4056BB28559
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CF41CE7E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF001EF091;
	Fri, 15 Aug 2025 17:46:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B23176F0;
	Fri, 15 Aug 2025 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279976; cv=none; b=CDbdQoZAkLC1iNty899866iObNAMuhDDUsr5UD1kahOEnge3mDfOwdLTHL2JdN5AxNmRMkIAKm2Qyp2MIMwxCLe1n93B2tUi4gCifv4B7MCRZttjpxqi07/nOJiEhydRQkzhGfKafp4yXhzmarjZjsc/Zq/8JhukLr89lBHZy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279976; c=relaxed/simple;
	bh=4ajPDOFJebfMe7XQdfZqdZ3LNlqb//08IHbAj6MwXds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvcUDyq3vjh/fe+8m0z7I+9uRzhSrvnE974VDb3Bx6NWHd0h7yDOUpoMMHD3bhaMrWN3YNnrVgIDxAXzZfKYTtXqbtAwRMeR3NeBEUAnbx6idQBjIylplgkXTF1m2Q0OI6W8/VOoRM33OarNhGG4KRYCAXMMBI/9WVk+lmR6V58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302C4C4CEEB;
	Fri, 15 Aug 2025 17:46:11 +0000 (UTC)
Date: Fri, 15 Aug 2025 18:46:09 +0100
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
Message-ID: <aJ9yYZyQtMHyS4n1@arm.com>
References: <20250813175335.3980268-1-yeoreum.yun@arm.com>
 <20250813175335.3980268-2-yeoreum.yun@arm.com>
 <aJ8WTyRJVznC9v4K@arm.com>
 <aJ9IdVsSxppYh2QC@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ9IdVsSxppYh2QC@e129823.arm.com>

On Fri, Aug 15, 2025 at 03:47:17PM +0100, Yeoreum Yun wrote:
> > If we do something like mte_enable_kernel_asymm(), that one doesn't
> > return any error, just fall back to the default mode.
> 
> But, in case of mte_enable_kernel_asymm() need return to
> change kasan_flag_write_only = false when it doesn't support which
> used in KASAN Kunit test.
> 
> If we don't return anything, when user set the write_only but HW doesn't
> support it, KUNIT test get failure since kasan_write_only_enabled()
> return true thou HW doesn't support it.

Ah, ok, if we need this for the kunit test. I haven't checked the last
patch.

-- 
Catalin

