Return-Path: <linux-kernel+bounces-756179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14521B1B0EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78B23A8F80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8D25A2D8;
	Tue,  5 Aug 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYvsLKGa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0D183CC3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385790; cv=none; b=p8vpGfTAUQ2DfDA2XMBLm6ujD3CCuNBKNf5o8GiVczoVv8s0ee+0uFWnY2JBVxwHdNUQjJRFPH53cHQg03/YuPwSwyWUN6kI1IHtbi3hfCLhnfncvvfv9PphY+gOnokHoKS+rl9K/MpcBY9z0DdH2QB7L23QIATlvCi9lihzzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385790; c=relaxed/simple;
	bh=diPRIjS2UisxtCV44eJA8sTBgLf6GjYIu+377zJcDLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANQewWHWvTbHPGdoPJ6hzqlIgiulTtJFpntsb7SzJ6Pu3HO7X827h537pCbAXTg9bv9eCjphUqs4W1yWhp4VOwWjC6E0Yi7U39U/i/OYUmXNRr7LjxGPxSaCbas/9nLl7ReAeZuZgCCBm+OQGcCM7h68vsiA17o6vwHa57wlap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYvsLKGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73950C4CEF0;
	Tue,  5 Aug 2025 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754385789;
	bh=diPRIjS2UisxtCV44eJA8sTBgLf6GjYIu+377zJcDLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYvsLKGa8hd0nieMnDjx8d5/pmCW6rf8G7JlrVCyAB2VEYJicS5NMdpiGRTDkgWL7
	 ozceh0KHlUlOlMldpGmGb6/e6FQHKs69ioqqGoWn5UF91zn7/1bVjw/4wAAPeS5Chp
	 sZFn9ijyHZ/rz3/VdOIRse2dswl7t29XBWQDEaRJ9apN0PXe0j407+RhCZypuzsaHI
	 fSC3rmWDUQB+hOpn6JsV9xTDNtYGNq5qS1CHgbx6B5tsCB6T32zha23CzwQCmx948r
	 ncPVoloIYMQLoLX25lsKGWa9hekkKrCHIUdo2vAswMz4pC3HbN09f0QL400aOKnPzQ
	 X1v2guQg84mNQ==
Date: Tue, 5 Aug 2025 11:23:04 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/msi-lib: Fix fwnode refcount in
 msi_lib_irq_domain_select()
Message-ID: <aJHNeP2E76liHqUr@lpieralisi>
References: <20250804145553.795065-1-lpieralisi@kernel.org>
 <87y0ryf9uj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0ryf9uj.ffs@tglx>

On Tue, Aug 05, 2025 at 10:31:32AM +0200, Thomas Gleixner wrote:
> On Mon, Aug 04 2025 at 16:55, Lorenzo Pieralisi wrote:
> >
> > msi_lib_irq_domain_select() is used in other arches, I could not
> > test on those (don't know if they have non-[DT/irqchip/acpi] specific
> > fwnodes) - from a fwnode interface perspective I think that this patch
> > does the right thing, it should not add any issue to existing code
> > to the best of my knowledge but it has to be verified.
> 
> fwnode handles are architecture and firmware agnostic.

Yep, though to make sure this does not trigger regressions I started
checking (ie I am adding an additional fwnode_handle_get/put() in there),
some fwnode helpers (eg fwnode_find_reference()) returns an error
pointer rather than NULL on error, it looks like calling
fwnode_handle_put() on that value when OF is in use is not a good idea
(ie of_node_put() checks for NULL and dereference).

There is code out there that implicitly assumes what fwnode types
are used behind the fwnode_* interface or I am missing something.

It is not arch dependent but it looks like it depends on what fwnodes
arches use - that's where my caution stems from, nothing else.

Thanks,
Lorenzo

