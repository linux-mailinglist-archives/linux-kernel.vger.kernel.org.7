Return-Path: <linux-kernel+bounces-823144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E8B85ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD19C1888EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C0930F942;
	Thu, 18 Sep 2025 15:32:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44B221D9E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209531; cv=none; b=imt1nj6eznJp8eWNhaxJAudWjssgZswC35Dk/1lsAGN0RZ+6yeo5YzDV2dKdOvt/AQdARpfF4gvGu5XRFO8woy5dgK/xLE2AYdnkwYA1L6BIbah9hk6yWTMDliRZbcXYZFZrSn2N28xdZUXTUcvJ5hXszn/v2KbFadDuwHuLLN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209531; c=relaxed/simple;
	bh=sOuh+/3C2BDX2PtBbL2DHWaBCqtyD3fg5lisiZclUPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiiX73RrskobV37kJkbhaEKHCFrOIKyDoAjIOD7p/1A4gFXtL1g2dJkKB6Afc3jbL3bZASiZL+jDHoh6WbihdBKBOhqOxOmlrcR2HLN7Li48cGAKXKErD+fsl4Fn7PU7QEHm8PB9yo24zclMWf0iva5fVkVgJ++bQjX4HjK5KJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89847C4CEE7;
	Thu, 18 Sep 2025 15:32:08 +0000 (UTC)
Date: Thu, 18 Sep 2025 16:32:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, ryan.roberts@arm.com, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com, ardb@kernel.org,
	dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v8 5/5] arm64: kprobes: call set_memory_rox() for kprobe
 page
Message-ID: <aMwl9mujvFknSulA@arm.com>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-6-yang@os.amperecomputing.com>
 <aMv_nhEuCSHKp5J6@arm.com>
 <22732cbe-20f8-4d1e-b086-e34d0f9bbb35@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22732cbe-20f8-4d1e-b086-e34d0f9bbb35@os.amperecomputing.com>

On Thu, Sep 18, 2025 at 08:05:55AM -0700, Yang Shi wrote:
> On 9/18/25 5:48 AM, Catalin Marinas wrote:
> > On Wed, Sep 17, 2025 at 12:02:11PM -0700, Yang Shi wrote:
> > > +	page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
> > > +	if (!page)
> > > +		return NULL;
> > > +	set_memory_rox((unsigned long)page, 1);
> > It's unfortunate that we change the attributes of the ROX vmap first to
> > RO, then to back to ROX so that we get the linear map changed. Maybe
> > factor out some of the code in change_memory_common() to only change the
> > linear map.
> 
> I want to make sure I understand you correctly, you meant set_memory_rox()
> should do:
> 
> change linear map to RO (call a new helper, for example,
> set_direct_map_ro())
> change vmap to ROX (call change_memory_common())

set_memory_rox() is correct. What I meant is that in alloc_insn_page(),
execmem_alloc() already returns RX memory. Calling set_memory_rox() does
indeed change the linear map to RO but it also changes the vmap memory
to RO and then to RX. There's no need for the alloc_insn_page() to do
this but we shouldn't change set_memory_rox() for this, the latter is
correct. I was thinking of alloc_insn_page() calling a new function that
only changes the linear map.

> And I think we should have the cleanup patch separate from this bug fix
> patch because the bug fix patch should be applied to -stable release too.
> Keeping it simpler makes the backport easier.

Yes, for now you can leave it as is, that's not a critical path.

> Shall I squash the cleanup patch into patch #1?

No, I'd leave it as a separate fix, especially if we want to backport
it.

Anyway, for now, with the nitpick on the address variable name:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

