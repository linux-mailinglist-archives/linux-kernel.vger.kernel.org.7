Return-Path: <linux-kernel+bounces-752018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3C0B17074
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374C01AA3050
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F02BEC32;
	Thu, 31 Jul 2025 11:38:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21F2C9A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961913; cv=none; b=MXEj1Zy0X9y8YO2PCHGzsa/ZjqIjE90hC8tljbKANf3FtF5fpR7/3GboZKhx/MCX1bXn2s/CsuQjObuI5569KvILNGm2xCl3OpN25NZMxbk6iQDXK8AVFyrcVy0yuYfj74cWodezlEPWPa1OcUl9aDQrGSnjePbqUgATtr4/aOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961913; c=relaxed/simple;
	bh=8+9BOKKVlh5xxAfKH86HDUA0p/1DSpmo1GxSVSsBhjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIxbpvZqodOP5ybrKafvPvLbkofJD2gcP+dtRPQ5CaAYDP4m11nRyjy+npyTAfECbBvn7hq83hQZYdvcb5RH42+YBbQmOuxFXS/5eNoEF1VcsSvZI4nh0S3kWRFKnUWYgwO3p0WIqN9Tq2h1AWBUyvnvQEzwOzTwpNH5FEoJxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FB0C4CEF6;
	Thu, 31 Jul 2025 11:38:30 +0000 (UTC)
Date: Thu, 31 Jul 2025 12:38:27 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
	anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
	kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	david@redhat.com, mark.rutland@arm.com, urezki@gmail.com
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Message-ID: <aItVswTcGVz_A6K8@arm.com>
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aIpPsg1Kij8Knnjl@arm.com>
 <8f89490b-bac5-4297-a4a8-9e9c4a8f5ef5@arm.com>
 <20ab00da-e85d-4f18-b482-bb406275693c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20ab00da-e85d-4f18-b482-bb406275693c@arm.com>

On Thu, Jul 31, 2025 at 10:00:15AM +0530, Dev Jain wrote:
> On 30/07/25 11:59 pm, Ryan Roberts wrote:
> > On 30/07/2025 18:00, Catalin Marinas wrote:
> > > On Wed, Jul 23, 2025 at 09:48:27PM +0530, Dev Jain wrote:
> > > > +	 * mmap_write_lock/unlock in T1 be called CS (the critical section).
> > > > +	 *
> > > > +	 * Claim: The CS of T1 will never operate on a freed PMD table.
> > > > +	 *
> > > > +	 * Proof:
> > > > +	 *
> > > > +	 * Case 1: The static branch is visible to T2.
> > > > +	 *
> > > > +	 * Case 1 (a): T1 acquires the lock before T2 can.
> > > > +	 * T2 will block until T1 drops the lock, so pmd_free() will only be
> > > > +	 * executed after T1 exits CS.
> > > 
> > > This assumes that there is some ordering between unlock and pmd_free()
> > > (e.g. some poisoning of the old page). The unlock only gives us release
> > > semantics, not acquire. It just happens that we have an atomic
> > > dec-and-test down the __free_pages() path but I'm not convinced we
> > > should rely on it unless free_pages() has clear semantics on ordering
> > > related to prior memory writes.
> > 
> > I can understand how pmd_free() could be re-ordered before the unlock, but
> > surely it can't be reorded before the lock? I need to go unlearn everything I
> > thought I understood about locking if that's the case...

Indeed, it can't be reordered before the lock as it has acquire
semantics.

> You are correct, what Catalin is saying is that my reasoning has a hole.
> There is no obvious ordering between unlock and free(), but
> 
> mmap_write_unlock() will happen before mmap_read_lock() ... (i)
> mmap_read_lock() will happen before pmd_free() ... (ii)
> 
> which lets us conclude that mmap_write_unlock() will happen before pmd_free().

Yes, in this sub-case, mmap_write_unlock() on T1 will happen before
pmd_free() on T2 if T2 waits on the lock.

-- 
Catalin

