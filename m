Return-Path: <linux-kernel+bounces-820238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71006B7CDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6258917ED9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D223BCFD;
	Wed, 17 Sep 2025 08:31:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36321C84B2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097903; cv=none; b=I730SGc8/DZMTpYwUdQa0fe6udQwpS3yYxRfH3eQyYUn7z7qUVYtTCrJhTEUpV7K//eP9SzDkQY6x+zd3PzXNJjUnvdWJmD57t3+HxX3ITzqHNnHUVqGhtNwOfKAr7+uUrgolNrMSqNg0IQbtYOK4ZCUDbvHFApRuQNnIfExsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097903; c=relaxed/simple;
	bh=M9UmLXFmf/H+p0ZBYHoX3xo/PpwRpsIwOwZtUvIBDGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlLcMLS1euu3jLfkVmGqXKdBN/yHvmdsPIFPRdK0CMR6Hv2wQODjlTMSsyIHusdPhtTp7guGUveKBNXHC4Om15F7m47YhjfkJnq2XJ3xdr2jQlETyrZyId3ZJR8IMeDujj0l6Pj/6igo5a5j8NFFlOJgPc1OktrY2XSREAr98eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D32F012FC;
	Wed, 17 Sep 2025 01:31:26 -0700 (PDT)
Received: from [10.1.31.40] (unknown [10.1.31.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 936693F673;
	Wed, 17 Sep 2025 01:31:33 -0700 (PDT)
Message-ID: <bee2351a-f264-4e3c-9c28-5dacc3605dba@arm.com>
Date: Wed, 17 Sep 2025 09:31:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] coresight: Fix possible deadlock in coresight_panic_cb
Content-Language: en-GB
To: Leo Yan <leo.yan@arm.com>, Sean Anderson <sean.anderson@linux.dev>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yeoreum Yun <yeoreum.yun@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Linu Cherian <lcherian@marvell.com>, linux-kernel@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 James Clark <james.clark@linaro.org>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
 <20250915095820.GH12516@e132581.arm.com>
 <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>
 <20250916160027.GK12516@e132581.arm.com>
 <a35e2d54-f1f5-4ae4-9daa-ae1f3a8a302b@linux.dev>
 <20250916164854.GM12516@e132581.arm.com>
 <42f1c98c-1432-47bb-9203-e878f011ff6e@linux.dev>
 <20250916171702.GO12516@e132581.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250916171702.GO12516@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2025 18:17, Leo Yan wrote:
> On Tue, Sep 16, 2025 at 12:51:11PM -0400, Sean Anderson wrote:
>> On 9/16/25 12:48, Leo Yan wrote:
>>> On Tue, Sep 16, 2025 at 12:14:40PM -0400, Sean Anderson wrote:
>>>
>>> [...]
>>>
>>>>> Could you check if the drafted patch below looks good to you? If so, I
>>>>
>>>> As stated above I disagree with a half-hearted removal. If you want to do that,
>>>> then I will resend v2 done with an rcu list and you can make your own follow-up.
>>>
>>> It is fine to disagree, but please don't resend v2 :)
>>>
>>> We have plan to refactor locking in CoreSight driver, I will try my
>>> best to avoid adding new lock unless with a strong reason.
>>
>> As said above it will be done with an rcu list, so no new lock.
>>
>> Or I can do this patch but stick the notifier block in csdev as suggested by Suzuki.
> 
> I am fine for adding the notifier block in csdev.
> 
> Suzuki, could you confirm if this is the right way to move forward?

Yes, if we are planning to keep a csdev panic_ops, why not stick in the
notifier there, rather than splitting it between core code and drivers.

Suzuki




> 
> Thanks,
> Leo


