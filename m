Return-Path: <linux-kernel+bounces-836337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D6BBA9602
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87B43B654E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE18307491;
	Mon, 29 Sep 2025 13:41:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702672C1594;
	Mon, 29 Sep 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153260; cv=none; b=I9fKQ0F1vtPEvS/8A3zpwOGJgFTjGxveSnBOt0tNWn5RkqMNz55gp3l2NzHbheDA96pyY/TIuwgpP8/sd1Vaa/sHSUXCyiTFik2VEm+hBI6xuofyYNtBSsLsWL+74BW0n9R6kMXISeUHHRaUCelB6tdwlG26GZeMTSemcXWz7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153260; c=relaxed/simple;
	bh=Ztt/WJDdgK4YyPlBZmQEPQ4pS88vmmm50tpR1xtDOw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGdcDUUWrSLYLUDCNu3LIz045UFB1I9ld4FwQBR+ywxb8Y32Frw57LV/TFDhZCMXc8blfxCTmYQcMFlGsKbHkoeTKpqdcFXQh619c7ltx5M5/6AcPwvFExXaL8zG9oIz69s4hc4DE2lilkL6+Vr1YoLulg54NAcqr7C6uUkG5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F388150C;
	Mon, 29 Sep 2025 06:40:49 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D8E03F59E;
	Mon, 29 Sep 2025 06:40:55 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:40:52 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aNqMZGLV/UXbe39u@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <ffe1c6e9-e951-42d6-99ec-ec6e7496f9b0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffe1c6e9-e951-42d6-99ec-ec6e7496f9b0@intel.com>

Hi Reinette,

On Fri, Sep 26, 2025 at 01:54:10PM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> Just one correction ...
> 
> On 9/22/25 8:04 AM, Dave Martin wrote:

[...0

> > For AMD SMBA, we might have:
> > 
> > 	min: 1
> > 	max: 100
> > 	scale: 8
> > 	unit: 1GBps
> > 
> 
> Unfortunately not like this for AMD. Initial support for AMD MBA set max
> to a hardcoded 2048 [1] that was later [2] modified to learn max from hardware.
> Of course this broke resctrl as a generic interface and I hope we learned
> enough since to not repeat this mistake nor give up on MB and make its interface
> even worse by, for example, adding more architecture specific input ranges.
> 
> Reinette 
> 
> [1] commit 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> [2] commit 0976783bb123 ("x86/resctrl: Remove hard-coded memory bandwidth limit")

The "100" was just picked randomly in my example.  Looking more
carefully at the spec, it may make sense to have:

	min: 1
	max: (1 << value of BW_LEN)
	scale: 8
	unit: 1GBps


(This max value correspondings to setting the "unlimited" bit in the
control MSR; the other bits of the bandwidth value are then ignored.
For this instance of the schema, programming the "max" value would be
expected to give the nearest approximation to unlimited bandwidth that
the hardware permits.)

While the memory system is under-utilised end-to-end, I would expect
throughput from a memory-bound job to scale linearly with the control
value, but the control level at which throughput starts to saturate
will depend on the pattern of load throughout the system.

This seems fundamentally different from percentage controls -- it looks
impossible to simulate proportional controls with absolute throughput
controls, nor vice-versa (?)

Cheers
---Dave

