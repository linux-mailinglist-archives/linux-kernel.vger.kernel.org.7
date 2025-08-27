Return-Path: <linux-kernel+bounces-788666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D8B38867
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF73173E36
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA0E258CF7;
	Wed, 27 Aug 2025 17:16:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035941E260A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314964; cv=none; b=SZybzenxKeAA+BrdWwdWOU/ix1fT87aKqKqx2pSE1XKR8FkjDK1jQEI71owAIY9/X2hywppiLUSfkcPH2abJVeqbVsKqdtLbeKX3O5jZ3rwOx3QhtpETysHTLbjEukPmYmXJvpKieoLs1UgwxUm344TjFYDR54c9f2+7v3g5ZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314964; c=relaxed/simple;
	bh=2M++ysA6in4XjKRui95jrb21Og8L6OD7vjQTDPLpSnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIDpiawx1e+KLocFhkdJ4m6mweP95T8dWwMOmlOjuBAn1CbxeyjvEz2hzKm3lYsyR1ej5m8CblOmLmhbe/YCqglShpywYLTRVmBUo7qAhXIJ0jl0U2SPlnmGT6aRFsLz4G95askTfmwe7vkWkXlSuj9nffgx/Pgizjaffj0wI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5CDA15A1;
	Wed, 27 Aug 2025 10:15:53 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 907663F694;
	Wed, 27 Aug 2025 10:16:01 -0700 (PDT)
Message-ID: <58eae4c3-51b3-48ad-b077-aefdff969119@arm.com>
Date: Wed, 27 Aug 2025 18:16:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm_mpam: Relax num_rmids parameter advertised to
 userspace
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20250820131621.54983-1-Dave.Martin@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250820131621.54983-1-Dave.Martin@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 20/08/2025 14:15, Dave Martin wrote:
> On MPAM systems, monitoring groups are identified in the hardware by a
> (PARTID, PMG) pair.  Two monitoring group identifiers are the same only
> if the PARTIDs and PMGs both match.  This means that the number of
> monitoring groups that can be created in each control group is the same
> as the number of distinct PMG values supported by the hardware.  The
> number of monitoring groups that exist in other control groups at the
> same time makes no difference to this.
> 
> Currently, the MPAM driver takes the cautious approach and always
> num_rmids = 1.
> 
> Relax this limit, by advertising the number of distinct PMG values
> supported by the hardware.
> 
> Code/Data Prioritization (CDP) makes no difference, since although this
> doubles the number of (PARTID, PMG) pairs available to a control group,
> each monitoring group now consumes two pairs instead of one.

Thanks, I've picked this up. It may get squashed into the patch that adds these lines
before going upstream...


Thanks,

James

