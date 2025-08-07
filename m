Return-Path: <linux-kernel+bounces-759150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC2B1D934
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F402C188A8E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480E25C81B;
	Thu,  7 Aug 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGG7fkuo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F10255F3F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574062; cv=none; b=kkktXlP4Tzz5MxIU0uMiO0FhRBe6JUqj0ssylKtiQ040ZOBxKtgJdykqWfXreiY2gMgaK/mvHfqtDUA6EUU7uNDB6fBVYhn0gBOq4d8J5NTEfXhc/9h64lOmPUyyb7z+EuQ89JVaPfa2iZ/DuUD+vFsJJSo7kuN5sAAGXf/gXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574062; c=relaxed/simple;
	bh=375BZlAGU9D1HYGrwP/hldapJabUqFGFwSkWx/PmrJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh8jNnYIkwmkpl0YDf5bIBr5hpvF+Eli+z9K3LZ9CvqDjZnpEV4XrS8/VKu7V0pJg3M+VkJ1xplLFfBGzzGKJ++pZgntLooORNlestRfQpNMyDdp5YCLjZ+jpFbw7PKJBprLxiy/TCZsDSlWMeU5MNRTWgW7tlpxqAUDtyvDqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGG7fkuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89F3C4CEEB;
	Thu,  7 Aug 2025 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754574061;
	bh=375BZlAGU9D1HYGrwP/hldapJabUqFGFwSkWx/PmrJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGG7fkuoZLXMk3vT05sdyfeJBHL6uvP9LGYWzClflbP6F/0KGZZs89OH6tttZftfw
	 gfOVPTX351ZOB3p2AzVz8JfoTL++c7Ju1ZAnHSHfEQg5AheTI67HjtDBhugrVAWAyQ
	 P520ch8tvED3EAbdnwxpv7WYv0IKPaZfbYTQyHTllaRwxBAC6fG2DPip5mFMOqcGH/
	 xYdD65OPnt9fZBhDl8bwPgayztXmqwkXZ1phl0044TegmLg9ecN4392vtBS4oWvSPa
	 dR9U9GiAX7GwSqNlNQGtSU7xingxObrtIQCm3x7QH7xOtu+7GxYDUYUp/Y+uiqNeeB
	 rNCS3vY+qTzqw==
Date: Thu, 7 Aug 2025 15:40:57 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/msi-lib: Fix fwnode refcount in
 msi_lib_irq_domain_select()
Message-ID: <aJSs6dxHIYIGIH0Z@lpieralisi>
References: <20250804145553.795065-1-lpieralisi@kernel.org>
 <87y0ryf9uj.ffs@tglx>
 <aJHNeP2E76liHqUr@lpieralisi>
 <20250806150818.00004a84@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806150818.00004a84@huawei.com>

On Wed, Aug 06, 2025 at 03:08:18PM +0100, Jonathan Cameron wrote:
> On Tue, 5 Aug 2025 11:23:04 +0200
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> 
> > On Tue, Aug 05, 2025 at 10:31:32AM +0200, Thomas Gleixner wrote:
> > > On Mon, Aug 04 2025 at 16:55, Lorenzo Pieralisi wrote:  
> > > >
> > > > msi_lib_irq_domain_select() is used in other arches, I could not
> > > > test on those (don't know if they have non-[DT/irqchip/acpi] specific
> > > > fwnodes) - from a fwnode interface perspective I think that this patch
> > > > does the right thing, it should not add any issue to existing code
> > > > to the best of my knowledge but it has to be verified.  
> > > 
> > > fwnode handles are architecture and firmware agnostic.  
> > 
> > Yep, though to make sure this does not trigger regressions I started
> > checking (ie I am adding an additional fwnode_handle_get/put() in there),
> > some fwnode helpers (eg fwnode_find_reference()) returns an error
> > pointer rather than NULL on error, it looks like calling
> > fwnode_handle_put() on that value when OF is in use is not a good idea
> > (ie of_node_put() checks for NULL and dereference).
> > 
> > There is code out there that implicitly assumes what fwnode types
> > are used behind the fwnode_* interface or I am missing something.
> > 
> > It is not arch dependent but it looks like it depends on what fwnodes
> > arches use - that's where my caution stems from, nothing else.
> > 
> 
> For the many DEFINE_FREE() uses there is a check of IS_ERR_OR_NULL()
> 
> E.g. Here it would be 
> DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T));
> 
> IIRC this one was an early use of DEFINE_FREE() and later discussions
> argued for always adding that check purely to allow the compiler
> to potentially optimize away the call.  Sounds like it would be
> more generally helpful here and I can't immediately spot any negatives.

Neither can I - at present I don't think that's a real problem
(ie we would have noticed) but we can add the additional check
you suggested above.

Thanks,
Lorenzo

> 
> Jonathan
> 
> 
> > Thanks,
> > Lorenzo
> > 
> 

