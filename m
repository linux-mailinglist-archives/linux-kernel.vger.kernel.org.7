Return-Path: <linux-kernel+bounces-736338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E3FB09BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17321C43ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151F21FBC91;
	Fri, 18 Jul 2025 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p+L6hJT/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23BC4689;
	Fri, 18 Jul 2025 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752821289; cv=none; b=S/8lXywhn4LOsqa7NjZRL+hKZHulYK+TFf82Uvf3brmtJ75ufP7dfAJcqw6ayIQ9LgDiIFHAPSh8kjsGAAnoA/8NcmOHmJK8T+EFASRbvlKRJvODxBN2CSNi5eprP/hmcr8Qv6YD85cEXGCi+wPepa/D+EXXQIL0KMAk32cAuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752821289; c=relaxed/simple;
	bh=oGFDBkGGxu3hlekar5YeTUojSFRxuWUWJ1VkXJOSIV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0QyIYqTeMFVFVXSrsA4OERhodrWsCFJMMn0KBsW/6D4Ib0EXbvfvHKHnrtGkRuM7jT/F3S2zsX9J6qe5eaX43M4tgd5gH4KwXxNpfsmwSvskbe9iD3kjxUBN+0zAn5kK6sXmS1OLy7CbXumga362OCqWeJBlfux4ZvVlvHQLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p+L6hJT/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752821285;
	bh=oGFDBkGGxu3hlekar5YeTUojSFRxuWUWJ1VkXJOSIV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p+L6hJT/tncrbRQYybZA6C6WADg7SSOM8hQbd/wx56epq6R82LEveanN2UnvuMTZb
	 wbch8JREN27RZeypba46TFSQIWkacJjzrfE6eAwxxBJZ9GPA6dxd4mz+KVnBEdNXmN
	 nfWlBrIv8fRk/nIYmjsIYk8Bcu/ae/mBwiXjcl4gR74JzcKzxYaqfk+odHczsEGiOL
	 2hVT313cUnLYnuv+5m+YVV0DRqz0AtR3iPigc17RjK4zhNu+WtzCrLHyXg4YtflUOf
	 Vth1AAewIwEFWfzr0HIl7JX0iqrnP1SQ8B+PRye6N9ddd7Zm3EsKZez8JmKLvfA9Zz
	 zF8uIOXBURi/Q==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 87D3917E1439;
	Fri, 18 Jul 2025 08:48:05 +0200 (CEST)
Message-ID: <044fd9e0-b506-4b79-a708-04e40fd23935@collabora.com>
Date: Fri, 18 Jul 2025 09:48:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] usb: vhci-hcd: Fix space, brace, alignment and line
 length issues
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 "Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-2-2b000cd05952@collabora.com>
 <2025071706-overarch-flaky-035b@gregkh>
 <3a1c8ed6-c123-4a11-b2aa-405babfa2948@collabora.com>
 <2025071837-recoil-fifteen-a977@gregkh>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2025071837-recoil-fifteen-a977@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/25 9:26 AM, Greg Kroah-Hartman wrote:
> On Thu, Jul 17, 2025 at 08:26:54PM +0300, Cristian Ciocaltea wrote:
>> On 7/17/25 7:18 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Jul 17, 2025 at 06:54:51PM +0300, Cristian Ciocaltea wrote:
>>>> Perform a first round of coding style cleanup:
>>>>
>>>> * Add new lines after several statement blocks
>>>> * Avoid line wrapping when 100-column width is not exceeded and it helps
>>>>   improve code readability
>>>> * Ensure lines do not end with '('
>>>> * Drop superfluous spaces or empty lines
>>>> * Add spaces where necessary, e.g. around operators
>>>> * Add braces for single if-statements when at least one branch of the
>>>>   conditional requires them
>>>>
>>>> This helps getting rid of the following checkpatch complaints:
>>>>
>>>>   CHECK: Lines should not end with a '('
>>>>   CHECK: braces {} should be used on all arms of this statement
>>>>   CHECK: Unbalanced braces around else statement
>>>>   CHECK: Blank lines aren't necessary before a close brace '}'
>>>>   CHECK: Unnecessary parentheses around
>>>>   CHECK: Alignment should match open parenthesis
>>>>   CHECK: No space is necessary after a cast
>>>>   CHECK: spaces preferred around that '-' (ctx:VxV)
>>>>   CHECK: spaces preferred around that '+' (ctx:VxV)
>>>>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>
>>> Coding style cleanups need to be "one patch per logical change", not
>>> "fix them all in one patch!" type of thing.
>>>
>>> Sorry, but can you break this out better?
>>
>> I could split this into something like:
>>
>> - Fix spaces & blank lines
>>   CHECK: Blank lines aren't necessary before a close brace '}'
>>   CHECK: No space is necessary after a cast
>>   CHECK: spaces preferred around that '-' (ctx:VxV)
>>   CHECK: spaces preferred around that '+' (ctx:VxV)
>>
>> - Fix braces
>>   CHECK: braces {} should be used on all arms of this statement
>>   CHECK: Unbalanced braces around else statement
>>
>> - Fix alignment & line length
>>   CHECK: Lines should not end with a '('
>>   CHECK: Alignment should match open parenthesis
>>   
>> - Misc?!
>>   CHECK: Unnecessary parentheses around
> 
> Why not one per CHECK: type?

I've been trying to squash all formatting changes which are kind of similar,
but sure I can handle them separately.

Thanks,
Cristian


