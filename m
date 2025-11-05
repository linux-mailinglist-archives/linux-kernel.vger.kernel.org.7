Return-Path: <linux-kernel+bounces-886957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F43DC36D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F153318C69FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D655133E356;
	Wed,  5 Nov 2025 16:46:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47DE338937;
	Wed,  5 Nov 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361217; cv=none; b=hC29ybsNGmMHgbnuX1Q7H/fGri6CDRtGz3gqY7NqlbeXyt/uVgYUCZ6dcSQwpCZNwSQAUhk4eb3+Nq4QrAq0VPKBf8ehp+ri7djB2Na8VKxHzbVI6hlPCCK22bYbXZ1JlUz1ux0jxHSAJBQngJoi1b40RsFRAaK21A2eag33HCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361217; c=relaxed/simple;
	bh=6vd3aPSiG5+reeBPaEB5n4YXfTaIJp8goryBdSf8UK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWHjmHV0F3uXq9orKcwkv3t7Gb2ktXaSy8MDbjRGGNGzdLkhd5e51aKK73ha7rJ9XZNnb53cKu3yG76upzViNUzavHBLCCOlIq/dT8KVoWsrpR/iuskvonIBBtGfSwNWTecKLNuV6Ie4zb2KBCfdnU2gJBbc23uDrdaqLBQyTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7CEC169C;
	Wed,  5 Nov 2025 08:46:45 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7113D3F694;
	Wed,  5 Nov 2025 08:46:48 -0800 (PST)
Date: Wed, 5 Nov 2025 16:46:45 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Babu Moger <babu.moger@amd.com>
Cc: tony.luck@intel.com, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	corbet@lwn.net, james.morse@arm.com, x86@kernel.org, hpa@zytor.com,
	akpm@linux-foundation.org, paulmck@kernel.org,
	rdunlap@infradead.org, pmladek@suse.com, kees@kernel.org,
	arnd@arndb.de, fvdl@google.com, seanjc@google.com,
	pawan.kumar.gupta@linux.intel.com, xin@zytor.com,
	thomas.lendacky@amd.com, sohil.mehta@intel.com, jarkko@kernel.org,
	chang.seok.bae@intel.com, ebiggers@google.com,
	elena.reshetova@intel.com, ak@linux.intel.com,
	mario.limonciello@amd.com, perry.yuan@amd.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	peternewman@google.com, feng.tang@linux.alibaba.com
Subject: Re: [PATCH v11 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
Message-ID: <aQt/dSRgtQNfJPCj@e133380.arm.com>
References: <cover.1761844489.git.babu.moger@amd.com>
 <deb3a4f19d6e138a502b136034fb88ad8b8c9c75.1761844489.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb3a4f19d6e138a502b136034fb88ad8b8c9c75.1761844489.git.babu.moger@amd.com>

Hi Babu,

On Thu, Oct 30, 2025 at 12:15:35PM -0500, Babu Moger wrote:
> AMD's SDCIAE forces all SDCI lines to be placed into the L3 cache portions
> identified by the highest-supported L3_MASK_n register, where n is the
> maximum supported CLOSID.
> 
> To support AMD's SDCIAE, when io_alloc resctrl feature is enabled, reserve
> the highest CLOSID exclusively for I/O allocation traffic making it no
> longer available for general CPU cache allocation.

Does resctrl have a free choice for which CLOSID to use?  (From the
code, it appears "yes"?)

Could this be exposed as a special control group?  Or could IO be made
a special "task" that can be added to regular control groups?

e.g.,

# mkdir /sys/fs/resctrl/some_group
# some_group IO >/sys/fs/resctrl/some_group/tasks

This would assign the group's CLOSID to IO (in addition to any tasks
using the CLOSID).

Or, we have some special file:

# echo foo >/sys/fs/resctrl/some_group/io_devices

This would assign the group's CLOSID to the device "foo" (we'd need
some manageable naming scheme, preferably that maps in a sane way to
sysfs).


I'm not trying to rock the boat here, but for MPAM we're anticipating
the need to be able to control the CLOSID used by devices that are
behind an IOMMU.  (Arm's SMMU allows a PARTID to be configured for each
device I/O context behind the SMMU.)

This is desirable for assigning devices to VMs, so that their traffic
can be managed alongside the VM.


Do you think SDCIAE could fit in with this kind of scheme?


[...]

> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 108995640ca5..89e856e6892c 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -152,6 +152,29 @@ related to allocation:
>  			"not supported":
>  			      Support not available for this resource.
>  
> +		The feature can be modified by writing to the interface, for example:
> +
> +		To enable:
> +			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
> +
> +		To disable:
> +			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc

"info" is mostly read-only, though it does seems a reasonable place for
per-resource global controls.  Today, there is already
"max_threshold_occupancy".

It doesn't feel worth trying to introduce a new hierarchy for this kind
of thing, but the name "info" does not suggest that there are writable
controls here. 

To make it official, does it make sense to add something like:

--8<--

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index fbbcf5421346..0cc9edf8d357 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -72,6 +72,10 @@ The 'info' directory contains information about the enabled
 resources. Each resource has its own subdirectory. The subdirectory
 names reflect the resource names.
 
+Most of the files in the resource's subdirectory are read-only, and describe
+properties of the resource. Resources that have global configuration options
+provide writable files here that can be used to control them.
+
 Each subdirectory contains the following files with respect to
 allocation:

[...]

Cheers
---Dave

