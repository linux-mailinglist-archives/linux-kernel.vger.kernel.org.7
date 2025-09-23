Return-Path: <linux-kernel+bounces-828496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D33DB94B77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FA3174030
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC530FC2B;
	Tue, 23 Sep 2025 07:15:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1E30FC3F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611719; cv=none; b=utS4wBrrWwK4GTeBvjRdrockEeg2+mVM0nImeN+xbn1arT7W3u21Vd+zKBNPh60aaFLM14XAjj9b4lD39kYOu1nqSZ4lhPpvdMbzLs3BNU2Cs90VxUtH+zh6h+0OLoG/+bfRQUka4I2ULJlbx3WnIyel/iRjm9AcuBcy9xSwWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611719; c=relaxed/simple;
	bh=mLohxNqb7hdss36qP5GpsT9wu+yEW+Yn19wv7p44jbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdfxP3xclaVJWTmo0huERwdhghk82DLJnXtwA4FAS93KjO9Xxpw+j4mY+5vsDyyPygHo+DrIY2DZWF/g6R5NYLQNw+NYYX/B2FsvjUIcyrxmtweCvzTvNecG24t4dp877z7FtKugNVakcmcETevNTYITkhWye6LEgjdxuoGTXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC997497;
	Tue, 23 Sep 2025 00:15:08 -0700 (PDT)
Received: from [10.57.81.133] (unknown [10.57.81.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E7D73F66E;
	Tue, 23 Sep 2025 00:15:14 -0700 (PDT)
Message-ID: <3aadd340-f2e3-4926-8a39-69a0162eaa9d@arm.com>
Date: Tue, 23 Sep 2025 08:15:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org,
 Yang Shi <yang@os.amperecomputing.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
 <fc43aa07-d4ad-47d5-8381-61d4a9b8c467@arm.com>
 <aM0-FQlepoxxGkRd@willie-the-truck>
 <ceaf604f-8ad7-4e19-812e-7eeace10d835@arm.com>
 <aM1E34lRjKg7nlRu@willie-the-truck>
 <38fa4717-9105-4bca-a2cd-914afc109570@arm.com>
 <aM2kg49jBia4VKYr@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aM2kg49jBia4VKYr@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2025 19:44, Will Deacon wrote:
> On Fri, Sep 19, 2025 at 01:00:49PM +0100, Ryan Roberts wrote:
>> On 19/09/2025 12:56, Will Deacon wrote:
>>> So how about we:
>>>
>>>   - Remove X4 from the list
>>>   - I try harder to apply your patch for secondary CPUs...
>>>   - ... if I fail, we can apply it next time around
>>>
>>> Sound reasonable?
>>
>> Yeah that works for me. Cheers!
> 
> So after all that, the conflict was straightforward once I sat down and
> looked at it properly.
> 
> Please can you check for-next/core? I forcefully triggered the
> repainting path in qemu and it booted without any problems.

Thanks Will, I took a look and didn't spot any problems. Thanks for squeezing
this in.

> 
> Will


