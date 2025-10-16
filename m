Return-Path: <linux-kernel+bounces-856057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ABBBE2F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8872188786D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F45320A31;
	Thu, 16 Oct 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y8dFtMSF"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588E335BD8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611885; cv=none; b=ZL2ZnhckWWWquw+7wpFFKF56X+cfXCZV1zGA3Tu4v1dXUNeKbxyZQtEoxd1a9H7nOjh1+O+UsYFukHhoSXkxFkfz6Zu0FFDhJAt72rYDrJ9mZRk4Aw2X3E6vLVUTkO5Jubc/Rh92p/FCkM4AUrE76pFV86C9ifiL8XZ+lGUsrUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611885; c=relaxed/simple;
	bh=PM2SK4pEoOahomr/EX7T29PfwaLedCreBKWgmZbCPrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJqp9fty1zekkhPUfkSz9GLMHvB5o8XC2SsmNtE7tbAz6U04jbyOFChPSfTM3t44s9Qmj8TUsrnb9VoTegb/sDLYD+X5DAAXrU1T5qcpyEAFl+duXZGvyqnf7Q8Q0eCk2q/ReB7P8lY7LEQE0Ny1SjhSGD9Rp5T4Rz+D/J6D2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y8dFtMSF; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d288fc83-a1ee-4409-a457-83bc21356306@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760611873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mltHsNfESF6l4m5rH9ATu3tuf/qXFwaXLTvvIMtUic=;
	b=Y8dFtMSFd2GFUHd/xc6W8OPZmvtzDWg8pzpUHsJvZ0LD7wjSiAGvP8TTPwSluyfDINmjgQ
	HcsIAZVUH3iqf9VJvdnkmMCmOm4N1nUk0FUC5Sr/RdFeOfieW+x2mK8qys+WJJRnm33ryb
	V8NrgyCfkxYfXuvDAYi4LGm8FqoPF9I=
Date: Thu, 16 Oct 2025 18:51:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251016033643.10848-1-lance.yang@linux.dev>
 <20251016093310.rilvenglgnr65ojq@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251016093310.rilvenglgnr65ojq@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/16 17:33, Wei Yang wrote:
> On Thu, Oct 16, 2025 at 11:36:43AM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> A non-present entry, like a swap PTE, contains completely different data
>> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
>> non-present entry, it will spit out a junk PFN.
>>
>> What if that junk PFN happens to match the zeropage's PFN by sheer
>> chance? While really unlikely, this would be really bad if it did.
>>
>> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
>> in khugepaged.c are properly guarded by a pte_present() check.
>>
> 
> Does it more like to guard pte_pfn() with pte_present()?

Exactly! My thinking was that by guarding pte_pfn(), we're ultimately
protecting is_zero_pfn() from acting on a junk PFN.

So we're on the same page — I just described the end goal ;p

Thanks!

