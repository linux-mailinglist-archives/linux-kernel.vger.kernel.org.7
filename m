Return-Path: <linux-kernel+bounces-842248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC09BB9513
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 11:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E54614E2D59
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B22580F0;
	Sun,  5 Oct 2025 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CHgUuYxD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63713B7A3
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759656719; cv=none; b=nFZz7opVDxNElhdO5aaHAXZocc+x8Dpc15Gb60cUIf5xJ44TdGceRwSzBYKfPpd5fsnqRBNwPxQfOATs5ZbtAD+jVExBEky+muBLNZ9o87/XuGW4IwRWr5iaU+9dG6kxmMtLm49uYk4OM3PzLBZBzBkVdt4N9bF3rBpPTYKLEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759656719; c=relaxed/simple;
	bh=EaAdCc8eGHq9KRop2eVwGWD9GrifB9zju9mZO5I8up4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KePHuBpnnbmeS/Px/GdtEN8zDiTEt4P5J/IvD0y4gfOSmZ4N93hn81VSdeir0y3WruAl/Wb8nkSFl7DtPvYknd8pjNItwO7+LyAEm0rs+K01+JC7P2HQ/i2nlkRBnEXmccTAiRIfPaBbTKsuWY4f2NxkrrJ1o9zWGe80pi5dQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CHgUuYxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF99C4CEF4;
	Sun,  5 Oct 2025 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759656718;
	bh=EaAdCc8eGHq9KRop2eVwGWD9GrifB9zju9mZO5I8up4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHgUuYxDgRFsIyzbMV6djVpEX6M9BTPx1Lmcgo9rRZN0HvECFdxgf0MLjFuPLRaIQ
	 2EKJCs9C6sM3ZI/yte8+06iKfZMJcCkxVHY7BzOVmvsKaR/UGqm69WvKMHCGayLmWV
	 PqV72y0B9uTtcdSw1gzUGdL8ro7gcPXuWAxoMoag=
Date: Sun, 5 Oct 2025 11:31:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2022-50495: x86/xen: Fix memory leak in
 xen_smp_intr_init{_pv}()
Message-ID: <2025100544-entertain-pueblo-a111@gregkh>
References: <2025100419-CVE-2022-50495-fdee@gregkh>
 <87195904-6285-49d2-b311-b3c52526e682@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87195904-6285-49d2-b311-b3c52526e682@suse.com>

On Sat, Oct 04, 2025 at 07:30:35PM +0200, Juergen Gross wrote:
> On 04.10.25 17:51, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > 
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > x86/xen: Fix memory leak in xen_smp_intr_init{_pv}()
> > 
> > These local variables @{resched|pmu|callfunc...}_name saves the new
> > string allocated by kasprintf(), and when bind_{v}ipi_to_irqhandler()
> > fails, it goes to the @fail tag, and calls xen_smp_intr_free{_pv}() to
> > free resource, however the new string is not saved, which cause a memory
> > leak issue. fix it.
> > 
> > The Linux kernel CVE team has assigned CVE-2022-50495 to this issue.
> 
> Please revoke the CVE. This issue can't be triggered by an unprivileged user.

Thanks for the review, now rejected.

greg k-h

