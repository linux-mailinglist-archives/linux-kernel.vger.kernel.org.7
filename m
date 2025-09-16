Return-Path: <linux-kernel+bounces-819284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C1B59DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F5C4E18C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749531E8B1;
	Tue, 16 Sep 2025 16:42:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4531E89B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040933; cv=none; b=LQVFDajpQuP5f8g9UD2yCZM+sykoxnWK/Di4TBppZz7mAm6B8h0o0aRpWhCBpuBQN9BCfAIEJKloSQ9lPkEGWRGx471JESYOQnildbTf9n7wlLJLAr/apGwxbVFNAjQRh5ZWTbfABbgmcN+LJLY+m4SdAIfHWQ3HmJHVBHrBD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040933; c=relaxed/simple;
	bh=XTdW0Jm4BqvxemoqhpdxskTwoKO8q2AucJvqJN6/1VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQE2MrbqJD9d3nM88fqy/+wFD84fBwEXpyfI05/NRVDqGL3BAsl9Ha5TtYcNkXpZL/EUpd4ERcyMkVZPggmbzTYrB0bsxdLbCXSvH2DVL+MXItEkw6BqX8YApy95iI7tfaUc85qCU7Z+8pfM4XK0IVV04dk6XlZ53Tkb3LK7yVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 372A11063;
	Tue, 16 Sep 2025 09:42:02 -0700 (PDT)
Received: from [10.57.4.241] (unknown [10.57.4.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB5903F673;
	Tue, 16 Sep 2025 09:42:08 -0700 (PDT)
Message-ID: <8f426702-4897-4177-aeae-4fe2b7155fae@arm.com>
Date: Tue, 16 Sep 2025 17:42:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] coresight: Fix possible deadlock in coresight_panic_cb
Content-Language: en-GB
To: Leo Yan <leo.yan@arm.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Yeoreum Yun <yeoreum.yun@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Linu Cherian <lcherian@marvell.com>,
 linux-kernel@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 James Clark <james.clark@linaro.org>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
 <20250915095820.GH12516@e132581.arm.com>
 <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>
 <20250916160027.GK12516@e132581.arm.com>
 <6fbd24b2-3315-45e6-bff2-2c39e899e8f5@arm.com>
 <20250916163840.GL12516@e132581.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250916163840.GL12516@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2025 17:38, Leo Yan wrote:
> On Tue, Sep 16, 2025 at 05:09:01PM +0100, Suzuki Kuruppassery Poulose wrote:
> 
> [...]
> 
>>>   From ea78dd22cbdd97f709c5991d5bd3be97be6e137e Mon Sep 17 00:00:00 2001
>>> From: Sean Anderson <sean.anderson@linux.dev>
>>> Date: Tue, 16 Sep 2025 16:03:58 +0100
>>> Subject: [PATCH] coresight: Fix possible deadlock in coresight_panic_cb()
>>>
>>> coresight_panic_cb() is called during a panic. It invokes
>>> bus_for_each_dev(), which then calls bus_to_subsys() and takes the
>>> 'bus_kset->list_lock'. If a panic occurs after the lock has been
>>> acquired, it can lead to a deadlock.
>>>
>>> Instead of using a common panic notifier to iterate the bus, this commit
>>> directly registers the TMC device's panic notifier. This avoids bus
>>> iteration and effectively eliminates the race condition that could cause
>>> the deadlock.
>>
>> Well, if you are going that far, why not register the notifier from
>> coresight-core ?
> 
> I have thought this but gave up.
> 
> When register a panic's notifier, it does not provide an argument for
> passing a private data. So the code below uses container_of() to convert
> notifier block pointer to the TMC driver data, as a result, the code is
> specific to TMC driver.

notifier_block in csdev ?


