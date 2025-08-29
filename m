Return-Path: <linux-kernel+bounces-791744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9F8B3BB46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA89167AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A16314B85;
	Fri, 29 Aug 2025 12:27:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871B1FCFEF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470443; cv=none; b=i0eXfKsa4r2m5EE2ALwz546X+g82868kNo32uaWIk6cBz8/e/hvoicrhrdWiif5WCxJe7YxZsnqGO5jIPbokKR6GWdbVojCgm2T2Rt3Ys4h/BTT3F9AI4HqRF9bI9QiRWrqaBSBW1tigQ/k/k/AIWDfbJ+s89HQX4gHtijy9EoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470443; c=relaxed/simple;
	bh=LxJJO/rrCgTUPxH5wQFV/Ck2Gyg1fMWyfiJItZwQr2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrupvwHm9C/v/X1twmi8ug1h7jkLUz4oUSrsiLUkLWGOZsmsBINHHMeHTq3GLETtRikurQHnyvc2vC/4r8XQI5crvCmB69NC3EX76u9P1454Qxf4vIpOZZcmeITkr8kf22EJbKv0PMPlLpfGpG0jZRc0pwhejQmST/E5FWeOPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9B9F19F0;
	Fri, 29 Aug 2025 05:27:12 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B753F694;
	Fri, 29 Aug 2025 05:27:20 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:26:49 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH] arm_mpam: Relax num_rmids parameter advertised to
 userspace
Message-ID: <aLGciannXznRgwsb@e133380.arm.com>
References: <20250820131621.54983-1-Dave.Martin@arm.com>
 <58eae4c3-51b3-48ad-b077-aefdff969119@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58eae4c3-51b3-48ad-b077-aefdff969119@arm.com>

Hi James,

On Wed, Aug 27, 2025 at 06:16:00PM +0100, James Morse wrote:
> Hi Dave,
> 
> On 20/08/2025 14:15, Dave Martin wrote:
> > On MPAM systems, monitoring groups are identified in the hardware by a
> > (PARTID, PMG) pair.  Two monitoring group identifiers are the same only
> > if the PARTIDs and PMGs both match.  This means that the number of
> > monitoring groups that can be created in each control group is the same
> > as the number of distinct PMG values supported by the hardware.  The
> > number of monitoring groups that exist in other control groups at the
> > same time makes no difference to this.
> > 
> > Currently, the MPAM driver takes the cautious approach and always
> > num_rmids = 1.
> > 
> > Relax this limit, by advertising the number of distinct PMG values
> > supported by the hardware.
> > 
> > Code/Data Prioritization (CDP) makes no difference, since although this
> > doubles the number of (PARTID, PMG) pairs available to a control group,
> > each monitoring group now consumes two pairs instead of one.
> 
> Thanks, I've picked this up. It may get squashed into the patch that adds these lines
> before going upstream...
> 
> 
> Thanks,
> 
> James

Thanks for picking this up.

Will that be in the next snapshot?

Cheers
---Dave
> 

