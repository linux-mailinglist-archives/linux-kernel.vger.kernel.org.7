Return-Path: <linux-kernel+bounces-759830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34ABB1E37A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25661AA41A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3A26D4D5;
	Fri,  8 Aug 2025 07:24:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313142253EB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637842; cv=none; b=TghMrEDbunM0feod4yO+rtDPhQ1Ezoq5t7uoXJ8fYVWtTUX0rqP3/MvTNQ5quAtYOCr/5PqCQd8mNPleHQXlBxbt8ZmzJhlClVaETkLYTL6vrTAQAY0O+kBzgKker3qc76v4NTy6NN6mKPxc0NWNmyWyhUdrMbVoBH7X6vmfeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637842; c=relaxed/simple;
	bh=JeQT9rbgdoxHCmmrTlM2nMo9QQ4ZV8FDRonTXTosv+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOUdYInNVkvbu+DZerovr71OBFvpeBZi0q7w8kUj2gviGqvNmZvzYkTOC18lnz5mFhHOIITCiZuMlVFGhZT4ytql0aZqWIROQ7d611TKFX5ifpvolg9vvOvqyLivYRiEZPRnfruSy+oqqU4OkimMBwH4v7RYefGPlomxwvwh8cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A21B22EA;
	Fri,  8 Aug 2025 00:23:52 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30E133F673;
	Fri,  8 Aug 2025 00:23:54 -0700 (PDT)
Message-ID: <7f2b31e1-34ea-4207-bbdb-e83f7a147107@arm.com>
Date: Fri, 8 Aug 2025 08:23:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/36] arm_mpam: Add basic mpam driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
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
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250801170930.000051fe@huawei.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250801170930.000051fe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 01/08/2025 17:09, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 18:36:12 +0000
> James Morse <james.morse@arm.com> wrote:
>> This is just enough MPAM driver for the ACPI and DT pre-requisites.
>> It doesn't contain any of the resctrl code, meaning you can't actually drive it
>> from user-space yet.

[..]

> Whilst I get that this is minimal, I was a bit surprised that it doesn't
> contain enough to have the driver actually bind to the platform devices
> I think that needs the CPU hotplug handler to register a requester.
> So about another 4 arch patches from your tree.  Maybe you can shuffle
> things around to help with that.

Ah, I hadn't spotted that. The register-requestor code should only serve to
reduce the available PARTID - just in case the CPUs support less than the
cache hierarchy.
It's likely its the 'system_supports_mpam()' that prevents the driver being
registered. I'll move that into the arm64 patches - its needed so any id
register overrides in the CPU knock out the driver too.


> That makes this a pain to test in isolation.
> 
> Given desire to poke the corners, I'm rebasing the old QEMU emulation and
> will poke it some more.  Now we are getting close to upstream kernel support
> maybe I'll even clean that up for potential upstream QEMU.
> 
> For bonus points I 'could' hook it up to the cache simulator and actually
> generate real 'counts' but that's probably more for fun than because it's
> useful. Fake numbers are a lot cheaper to get.

I've not found a good source of fake numbers to use. Ideally it would just
increment whenever the task was scheduled - but I've found that hard to hack
that up in linux.
I fall back to reading the counters instead of the MPAM registers ... but its
hard to test for overflow or double counting with that.


Thanks,

James

