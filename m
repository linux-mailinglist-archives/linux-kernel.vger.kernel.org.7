Return-Path: <linux-kernel+bounces-848175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D6BCCCEE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F3EE355656
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0A6285C9A;
	Fri, 10 Oct 2025 11:48:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D594526158C
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760096916; cv=none; b=RTOfWW4+ZbpnlBToGOpdF97xqQ99d1bja85PSp2bMKDlX+nQh6ziFw1/2iTnbIJZgLKec2ujU22o1NSXY3S740sFm07PN0AUN/08LujyyDyH3r4r9LTIwavw/ohnDCJsCG8bSN2pFYWv9nM5ne3Js4lfi+SmJe+cua8Vik/51O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760096916; c=relaxed/simple;
	bh=ykqxNFIiImfOy+/ooWN95ocKoQ/PJj4CQlL/ShSfoK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0kToon1RD4DjxgWta0y6kPzAqK6MGZwIe0GDEzTrKRAn1dGrfoIT7bXZPrfug0Igr2txl/KUy6b9kK9Z5TEznRhXROQrwtmtX6jJ4Ls1U/+5g9ZGXMELYCpplweMS1Xe9TDfkDwaRErokJOd7qJkL8B88DQuiw1yTQXgHdnVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 266AE1596;
	Fri, 10 Oct 2025 04:48:26 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CF2C3F738;
	Fri, 10 Oct 2025 04:48:33 -0700 (PDT)
Message-ID: <ed3d71a3-b454-4e9b-97bb-7eb4d0b770ec@arm.com>
Date: Fri, 10 Oct 2025 06:48:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coco: guest: arm64: Update ARM CCA guest driver
To: dan.j.williams@intel.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>,
 Gavin Shan <gshan@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Sami Mujawar <sami.mujawar@arm.com>
References: <20251008132758.784275-1-aneesh.kumar@kernel.org>
 <yq5aldlka6oi.fsf@kernel.org> <20251009113557.000053e6@huawei.com>
 <68e86e45599bc_199281005d@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <68e86e45599bc_199281005d@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Hi,

On 10/9/25 9:24 PM, dan.j.williams@intel.com wrote:
> Jonathan Cameron wrote:
>> On Thu, 09 Oct 2025 12:43:49 +0530
>> Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:
>>
>>> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>>>
>>>> Make preparatory updates to the ARM CCA guest driver:
>>>>
>>>>   - Switch from using a platform device to a faux device (based on
>>>>     feedback in [1])
>>>>   - Rename the device from `arm-cca-dev` to `arm-rsi-dev`, so that the
>>>>     host driver can register an equivalent `arm-rmi-dev`
>>>>
>>>> These changes are purely structural and introduce no new functionality.
>>>> Subsequent patches will extend this driver to add guest device
>>>> assignment support.
>>>>
>>>> [1] https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh
>>>>   
>>>
>>> I noticed that, this will break autoloading of the driver.
>>
>> Ah indeed.  You'd need to arrange for the arch code to call the init()
>> directly (possibly arch_initcall() as before or maybe directly from
>> arm64_rsi_init), which makes it tricky to do in a module as there
>> is nothing to kick off module autoloading. You could kick that off
>> explicitly but that's a bit ugly.
> 
> Does ARM64 not have the equivalent of MODULE_DEVICE_TABLE(x86cpu, ...)?

No, it doesn't. There is a hwcap based method, but that requires 
allocating a hwcap.



