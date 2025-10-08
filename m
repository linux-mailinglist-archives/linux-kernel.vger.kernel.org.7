Return-Path: <linux-kernel+bounces-845633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A5BC5907
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7585B4F4739
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE552F2602;
	Wed,  8 Oct 2025 15:24:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569763CB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937050; cv=none; b=LskcIQHiPg+Nf68Mb/FMN/LH95mbueDrxFf97IF46KwKSWpryBA25hk0pdmZshAnQwgwxtX/Z48v7AZ3mgrF8oZs1d5aRO6/QLfVASO1UorQgzzYWbfHZBFfbZdVYtgEevJ6WNXD2Ixp9ZOV/YObTiTOoIzHb3riyveg6ob6ndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937050; c=relaxed/simple;
	bh=MMyPuLv4DMsbJW0nHM2Ei7EwWKrIv6Mq3xsVAUkXDjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbiCVgpGCC8AFFkaWIxnWoZ7fpQFs3go9gb7poIObanBZU6qz4V+uRYYxG2i+IhW1Zh0uYNjfPMVXqw9VWkeWQyzZ9/4jiksUuA13jET4nR6oFmnWt0MA79x99J8xDCa6zNihemDk6ZCnfiQATncDCRxuCus6s7INTmFYC5EH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C2B22FC;
	Wed,  8 Oct 2025 08:23:59 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5028B3F66E;
	Wed,  8 Oct 2025 08:24:05 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:23:57 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, tony.luck@intel.com,
	james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-kernel@vger.kernel.org, peternewman@google.com,
	eranian@google.com, gautham.shenoy@amd.com
Subject: Re: [PATCH] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
Message-ID: <aOaCDee7xbhA0ji3@e133380.arm.com>
References: <515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com>
 <fe06aa33-3351-45d4-a687-ff88a689be6e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe06aa33-3351-45d4-a687-ff88a689be6e@intel.com>

Hi,

On Tue, Oct 07, 2025 at 01:23:36PM -0700, Reinette Chatre wrote:
> Hi Babu,
> 
> Thank you for catching and preparing a fix for this issue.
> 
> On 10/6/25 4:13 PM, Babu Moger wrote:
> > The issue was observed during testing on systems with multiple resctrl
> > domains, where tasks were dynamically moved between domains.
> 
> (please let changelog stand on its own and not be a continuation of subject line)

[...]

[Quick, drive-by observation:]

Can I add that the commit message also seems way too long?

I think some of the description of the problem symptom could probably
be after the tearoff -- there doesn't seem to be a clear statement of
what is actually wrong in the code, or of why the change made in the
patch fixes it (or if there is, I struggled to find it.)

I puzzled over this for some minutes before I figured out this patch is
fixing something that is not upstream, yet.  A statement to that effect
would have helped.

Possibly I didn't read carefully enough...

Cheers
---Dave

