Return-Path: <linux-kernel+bounces-750539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B77CB15DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB58C1894955
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3621E0BE;
	Wed, 30 Jul 2025 10:03:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A50A55
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869824; cv=none; b=cF86+mIsHrBAS/6MyK0fxOUuvPW5OocKz/w6HFsZTQfMv6Gfcv97TlkFxQuz2fPqvJKFt8HRhMky+b4ObpeSVJ8mxupAiny7ZQuaL8lzOIY8Y6VUeK3OLy4YDU+2EPy6EwSLe5uXEUSPbmmshawSVQ1pEHXw5GZMtYUdhzSI6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869824; c=relaxed/simple;
	bh=lniad1Z1YK2ll96TyqrJcqf1bW4m7i3amNDQuejT47A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfE6Mr5QfD3fpXY+rZmkmf+ZmYarlNPQTHRaxFmj/Tmvz8idc4C8obWtIHYbnr00A/Hne0Z15dKgNmFtqee91HNgb6dY5/MJVXb6CRV+8q/a5LB/OC3zZRvl454hzBMBCUXfpiR0cws8hf6UCm0E1/a5b14AnYh4c03IxcbClnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11DE91BC0;
	Wed, 30 Jul 2025 03:03:28 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F38E3F673;
	Wed, 30 Jul 2025 03:03:35 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:03:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: Avoid soft lockup in __kmemleak_do_cleanup()
Message-ID: <aInt7Fa6N7Y3zW_K@arm.com>
References: <20250728190248.605750-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728190248.605750-1-longman@redhat.com>

On Mon, Jul 28, 2025 at 03:02:48PM -0400, Waiman Long wrote:
> A soft lockup warning was observed on a relative small system x86-64
> system with 16 GB of memory when running a debug kernel with kmemleak
> enabled.
> 
>   watchdog: BUG: soft lockup - CPU#8 stuck for 33s! [kworker/8:1:134]
> 
> The test system was running a workload with hot unplug happening
> in parallel. Then kemleak decided to disable itself due to its
> inability to allocate more kmemleak objects. The debug kernel has its
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE set to 40,000.
> 
> The soft lockup happened in kmemleak_do_cleanup() when the existing
> kmemleak objects were being removed and deleted one-by-one in a loop
> via a workqueue. In this particular case, there are at least 40,000
> objects that need to be processed and given the slowness of a debug
> kernel and the fact that a raw_spinlock has to be acquired and released
> in __delete_object(), it could take a while to properly handle all
> these objects.
> 
> As kmemleak has been disabled in this case, the object removal and
> deletion process can be further optimized as locking isn't really
> needed. However, it is probably not worth the effort to optimize for
> such an edge case that should rarely happen. So the simple solution is
> to call cond_resched() at periodic interval in the iteration loop to
> avoid soft lockup.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

I agree, it's not worth rewriting this path for an unlikely event. So
I'm fine with this approach. Thanks.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

