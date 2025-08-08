Return-Path: <linux-kernel+bounces-759817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA28B1E332
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664A4724C0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE72225415;
	Fri,  8 Aug 2025 07:16:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB2A22B8D0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637413; cv=none; b=fFwu7MYR00CBSQQxF3gRz9CYYG9pSKk7qIySc4IDHL48ePPrmZVJyG0NrIHfVFBOCjX2wZiPRx8R/2+UmfMRr3IFyy4+yhX2Ag2ZrlLqa9Fy8kkzH60xqqAPH2t8Ioirt1V76MR+RCw75gxJ7/inuqrne9qhzakAmtOSSWgJ54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637413; c=relaxed/simple;
	bh=/MxKZXeJ6aRyXJfx0tIrEDUUhgRLvNaLJ5sKnWlhy7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV55K5Ex38AIS+BePzeOxkwt+aB4cuZTbLbKpxeufGg+FQrGyjoArSlChRUSxvu9O9aPJnkaj05Xkj/V4oShR4it356dqnzdenQxK0EIrgiDKfiHu9yfERAqzeiOFT8hbTrHCMjx+pROHDkkX2qYMiKFU/W+V0Huan9+6jYCeS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A621216F8;
	Fri,  8 Aug 2025 00:16:43 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61F043F673;
	Fri,  8 Aug 2025 00:16:45 -0700 (PDT)
Message-ID: <5dcfd6e1-fa09-4381-8c32-a2276f41ac8d@arm.com>
Date: Fri, 8 Aug 2025 08:16:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/36] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: Dave Martin <Dave.Martin@arm.com>, Ben Horgan <ben.horgan@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-28-james.morse@arm.com>
 <7ab40c09-3922-4e0c-85dd-00ff05be4ce6@arm.com>
 <aIeYgxJf9EASA5Zs@e133380.arm.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <aIeYgxJf9EASA5Zs@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dave, Ben,

On 28/07/2025 16:34, Dave Martin wrote:
> Although it may look like the globals are read all over the place after
> probing, I think this actually only happens during resctrl initialision
> (which is basically single-threaded).
> 
> The only place where they are read after probing and without mediation
> via resctrl is on the CPU hotplug path.

(and the mpam driver gets the first go a cpuhp, then it calls into resctrl).


> Adding locking would ensure that an unstable value is never read, but
> this is not sufficient by itself to sure that the _final_ value of a
> variable is read (for some definition of "final").  And, if there is a
> well-defined notion of final value and there is sufficient
> synchronisation to ensure that this is the value read by a particular
> read, then by construction an unstable value cannot be read.
> 
> 
> I think that this kind of pattern is not that uncommon in the kernel,
> though it is a bit painful to reason about.

As it's sparked some discussion, I've added a mpam_assert_partid_sizes_fixed() that
documents this, and will trigger a WARN_ON_ONCE() if these things are observed as
happening in the wrong order.


Thanks,

James


