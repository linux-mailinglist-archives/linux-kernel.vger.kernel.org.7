Return-Path: <linux-kernel+bounces-836312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D8BA9487
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361DD169197
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD11305E09;
	Mon, 29 Sep 2025 13:08:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E913D8B1;
	Mon, 29 Sep 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151312; cv=none; b=aEveaYBtlgWPDapXUguphQo1DOXyoYs0JCM2uugCZN53PNOl18D1yA60BTAyRXEYSfpATBOKKM9Eh3i0nr/oKvxKB2tVgkYBdeo8PMwiIQ6f5XRrl9wnBTWS101M5cxydZ/J900jXP4S6Gl0hk537TnUWUhw+OwOKyEYsPJ/4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151312; c=relaxed/simple;
	bh=xOKXtyNPH2F/WSSFYQfBBIdzOpZLHQQw2ZY8GlDJ99U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwZUoPfOxeGPHrdYWdlqk5cE8kU/kRCn3GyAa28U5ZgwJBLOeCd5vWa749qIVfiLd+NVNxEO8Zonk8bRDRUW5JM6iqEjjCtzbjhHTibmB46G6VCslH8D2hYbu4KfyftfQ5hbbsRsk5Q9ieBAQ5oMkO9QtrPtnJXoTr9FBLGyJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A967D150C;
	Mon, 29 Sep 2025 06:08:15 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA1E33F59E;
	Mon, 29 Sep 2025 06:08:21 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:08:18 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aNqEwhUZd+prWdfK@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
 <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>
 <aNU5nCklRhuc4u3X@e133380.arm.com>
 <9dba03c5-cf45-4510-ab6c-2a945e73fd1c@intel.com>
 <aNW1vAd6Jhq6IkyJ@agluck-desk3>
 <1c7cc78f-c5ba-4fbc-9b17-61e5b72415ad@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c7cc78f-c5ba-4fbc-9b17-61e5b72415ad@intel.com>

Hi Reinette, Tony,

On Thu, Sep 25, 2025 at 03:18:51PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 9/25/25 2:35 PM, Luck, Tony wrote:

[...]

> > Director Technology (Intel® RDT) Architecture Specification"
> > 
> > 	https://cdrdv2.intel.com/v1/dl/getContent/789566
> > 
> > describes the upcoming region aware memory bandwidth allocation
> > controls as being a number from "1" to "Q" (enumerated in an ACPI
> > table). First implementation looks like Q == 255 which means a
> > granularity of 0.392% The spec has headroom to allow Q == 511.

That does look like it would benefit from exposing the hardware field
without rounding (similarly as for MPAM).

Is the relationship between this value and the expected memory system
throughput actually defined anywhere?

If the expected throughput is exactly proportional to this value, or a
reasonable approximation to this, then that it simple -- but I can't
see it actually stated.

when a spec suggests a need to divide by (2^N - 1), I do wonder whether
that it what they _really_ meant (and whether hardware will just do the
obvious cheap approximation in defiance of the spec).

> > 
> > I don't expect users to need that granularity at the high bandwidth
> > end of the range, but I do expect them to care for highly throttled
> > background/batch jobs to make sure they can't affect performance of
> > the high priority jobs.

A case where it _might_ matter is where there is a non-trivial number
of jobs, and an attempt is made to share bandwidth among them.

Although it may not matter exactly how much bandwidth is given to each
job, the rounding errors may accumulate so that they add up to
significantly more than or less than 100% in total.  This feels
undesirable.

Rounding off the value in the interface effectively makes it impossible
for portable software to avoid this problem...

> > I'd hate to have to round all low bandwidth controls to 1% steps.

+1!  (No pun intended.)

> This is the limitation if choosing to expose this feature as an MB resource
> and seems to be the same problem that Dave is facing. For finer granularity
> allocations I expect that we would need a new schema/resource backed by new
> properties as proposed by Dave in
> 	https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/
> This will require updates to user space (that will anyway be needed if wedging
> another non-ABI input into MB).
> 
> Reinette

Ack; while we could add decimal places to bandwidth_gran as reported to
userspace, we don't know that software isn't going to choke on that.

Plus, we could need to add precision to the control values too --
it's no good advertising 0.5% guanularity when the MB schema only
accepts/reports integers.

Software that parses anything as (potentially) a real number might work
transparently, but we didn't warn users that they might need to do
that...

Cheers
---Dave

