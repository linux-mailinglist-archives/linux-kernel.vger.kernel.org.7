Return-Path: <linux-kernel+bounces-850838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D6BD4588
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78EB2500E63
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5330ACF1;
	Mon, 13 Oct 2025 15:01:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D830AAC5;
	Mon, 13 Oct 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367700; cv=none; b=KQq+TXNjLikXywf9doDcdEtdNu51FPJFjMprZN3j2s3dlddd7jHB6x7MsCtUrroOocbWQCapanAvDBkXCXVsswYoUHJ/SGL3Nj2LCJhEV+1I8dqO7APwQsknMKyGmDhrV+INhDGYlzHrgNdCskKD4MvTB3NKv8FDFIn5dfoaZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367700; c=relaxed/simple;
	bh=npZxGViZkB9a3DGvNWyMmq2TkbP7Rw2Im4b896H8SPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyXnr5IJ4/fh/e9KHNPdLp/eOwZzskiZxTWd+T9W9pP45h45ghR5te5xyJl3mqH8Q4HeJf5x111Yl0JFyNTmREp7g7uv29XmwZUn0wAGPP6oXNRc7FXVq6XU0km2KTT6sAyDNNrLldjdNPcffSsYYFeuFgF6RjG+CjNavlzkIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F32DE113E;
	Mon, 13 Oct 2025 08:01:26 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C7523F66E;
	Mon, 13 Oct 2025 08:01:32 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:01:29 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aO0USQCzrj//t0Gr@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <883591c4-6301-45f6-a671-ca55974aaac0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883591c4-6301-45f6-a671-ca55974aaac0@intel.com>

Hi,

On Sun, Oct 12, 2025 at 01:15:07AM +0800, Chen, Yu C wrote:
> On 10/11/2025 12:48 AM, Reinette Chatre wrote:
> > Hi Dave,
> > 
> > On 9/30/25 8:40 AM, Dave Martin wrote:
> > > On Mon, Sep 29, 2025 at 09:09:35AM -0700, Reinette Chatre wrote:
> > > > On 9/29/25 6:56 AM, Dave Martin wrote:
> > > > > On Thu, Sep 25, 2025 at 03:58:35PM -0700, Luck, Tony wrote:
> > > > > > On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:
> 
> [snip]
> 
> > > Anyway, going back to the "#" convention:
> > > 
> > > If the initial read of schemata has the new entries "pre-commented",
> > > then userspace wouldn't need to know about the new entries.  It could
> > > just tweak the MB entry (which it knows about), and write the file back:
> > > 
> > > 	MB: 0=43
> > > 	# MB_HW: 0=2
> > > 	# MB_MIN: 0=1
> > > 	# MB_MAX: 0=2
> > > 
> > > then resctrl knows to ignore the hashed lines, and so reading the file
> > > back gives:
> > > 
> > > 	MB: 0=43
> > > 	# MB_HW: 0=3
> > > 	# MB_MIN: 0=2
> > > 	# MB_MAX: 0=3
> 
> 
> May I ask if introducing the pre-commented lines is intended to prevent
> control conflicts over the same MBA? If this is the case, I wonder if,

Basically, yes.  Note, this is only an issue for old software that
doesn't understand the new entries.  New software should omit the
entries for resources that doesn't understand or doesn't want to set.

> instead of exposing both MB and the pre-commented MB_HW_X in one file,
> it would be  feasible to introduce a new mount option (such as "hw") to
>  make the legacy MB and MB_HW_X mutually exclusive. If the user specifies
>  "hw" in mount option, display MB_HW_X (if available); otherwise, display
> only the legacy "MB". This is similar to the cpufreq governor, where only
> one governor is allowed to adjust the CPU frequency at a time.
> 
> thanks,
> Chenyu

This could be done with a mount option, but I am concerned that a
single resctrl mount might be used by different tools while it is
mounted.  So, maybe a global control is not what we want?

I'm hoping that we can design this in a way that is sufficiently
backwards compatible that we don't need a mount option to turn it off.

Can you think of a userspace scenario that would break, with the
proposed design?

Cheers
---Dave

