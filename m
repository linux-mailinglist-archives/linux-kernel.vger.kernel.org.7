Return-Path: <linux-kernel+bounces-883321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36D4C2D0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3458188B284
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FEC315D5A;
	Mon,  3 Nov 2025 16:19:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F382315D2F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186757; cv=none; b=ckFlOCzfwHclDT8wMPaF9lwnDVprRjUt6wDeIuY1Vd3RDlSxFdULGmz2VSRLPH2lWoEaJv5rUcWd4Y6icDoEAbNUblqQ5MliN/J3wYV+RDbl/FtC/ParvYEwBYuanb0iTmPh0XMHqKREllnmI2jc9n1cMH9PTjvQ26J0Xe+LPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186757; c=relaxed/simple;
	bh=3NEvPWappd5WAsbo97svJziz2GmABicCfs6qTFP1gVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvGddktpeH0N8n/MRMEulav5wbNzoqOOyFah/f1Kq25Nt8GjCnsZT3e14VUu4HsZakS9ZigckQhaJ4rJLVsTP9n6FdTzHEuVLorpRzV3DRDdJpWVO757ZyP1WOQnoczXDm9GfG9XdHs+2FtIDw0e/7pKCQIwGOJGR1DtGOr1wEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05FD81D14;
	Mon,  3 Nov 2025 08:19:08 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 119FE3F694;
	Mon,  3 Nov 2025 08:19:13 -0800 (PST)
Date: Mon, 3 Nov 2025 16:19:05 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"babu.moger@amd.com" <babu.moger@amd.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] fs/resctrl: Show domain CPU list in schema output
Message-ID: <aQjV+Q25+O/8DpBS@e133380.arm.com>
References: <20251031181722.250851-1-atomlin@atomlin.com>
 <SJ1PR11MB6083A4A7720723C14F3AE314FCF8A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <c26dierez6gzngp2syreufhdwhx64iuiox6cqrpeomz2ieuwkh@4l35mbkc4ez6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26dierez6gzngp2syreufhdwhx64iuiox6cqrpeomz2ieuwkh@4l35mbkc4ez6>

Hi,

On Fri, Oct 31, 2025 at 05:25:41PM -0400, Aaron Tomlin wrote:
> On Fri, Oct 31, 2025 at 07:03:15PM +0000, Luck, Tony wrote:
> > 1) You'd also need to change the "write" path for the schemata file
> > (treating the CPU list as read-only).
> > 
> > 2) This would break user ABI, so is not going to happen.
> 
> Hi Tony,
> 
> Thank you for following up.
> 
> If I understand correctly, parse_cbm() and parse_bw() would return -EINVAL
> if the user incorrectly included the CPU list, no?
> 
> I suspect the issue is if one can read something from a file, one should be
> able to write the same thing back and have it either succeed or process
> only the valid parts. I agree maintaining ABI compatibility while allowing
> the new verbose output on the read path is not ideal.

Partly, but existing software that reads the file is also likely to get
confused by the new syntax appearing when reading the file.

(Nothing requires the data read out from the file to resemble what is
written in, though it certainly less surprising for userspace if it
looks the same, and if the data read will be accepted, with the same
meaning, when written back in.)


Note, using a comma as a delimiter may be problematic with %pbl-style
lists, since if the list is discontiguous then the pretty-printed list
can contain commas too.

On my system:

$ cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
-->
0-15,32-47

> > Users can see the association between the domain numbers and
> > CPUs in sysfs.
> > 
> > $ cat /sys/devices/system/cpu/cpu0/cache/index3/id
> > 0
> > $ cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
> > 0-27
> > 
> > Maybe not as convenient as a direct read-out in the schemata file.
> > But the information is easily accessible.
> 
> No, using the above to establish the association is absolutely fine. 

In theory, a alternate write syntax could be supported without
breaking compatibility, say:

	cpu<n>=<mask>

instead of

	<domain>=<main>

as a alternative way of referring to the control domain containing
CPU <n>.

But I think that this may do as much harm as good -- if the user
doesn't understand the topology, trying to program the masks on a per-
CPU basis isn't going to work do what the user wants anyway.

So I think we'd want a good argument as to why this is needed / useful.

Cheers
---Dave

