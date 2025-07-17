Return-Path: <linux-kernel+bounces-735733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ACFB0932D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6281886BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A512FD888;
	Thu, 17 Jul 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GktWIf05"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444E298CCD;
	Thu, 17 Jul 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773219; cv=none; b=HeQYDNBQpw3448aUJXziAUVlDEe2FBrF/IIu84cyXUfrDZ6J2wkTqvqmkoXDNgaj1JDlpK2GyvHkcs2aXFVQp42S01XxEtKf2IertUW9Eir8LSGtDiNFAjyJETU5QVA+U7XxO28uXVReIKKeY7vhI4qYAYI2hYDP6j0Pq1MgsC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773219; c=relaxed/simple;
	bh=B02pWnJ5/rxsvi0hM/QEk9wnk84aFP75o3grC0pcTOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mozRTDjBNWFaa6LRwBPsIKLuKi6Ghh977/1cyDKdctxPDhIALJq0777MwQgTQIhDYyO0CStqhlOCkOY1sQx/T07OgVSjggUsV8mlCIS0KMUxmL06kdDma2hVwp1WNwg0gXLlHQCT72FAzYbJG6CGLo7V8zpHYz6oRNfpc6cxSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GktWIf05; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752773215;
	bh=B02pWnJ5/rxsvi0hM/QEk9wnk84aFP75o3grC0pcTOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GktWIf05sJZO8I2S/I1OqnnO6Mudh/WGOn5DFrnnpr/dyzL4TTtYNknXPKJry3iNK
	 RtYsFQWJFkhPcEdwRc+rorYDOCLVbuaaq9AIcTT84YegVeUuqK2nt7y3QQDnl3srN+
	 t8qtzGzIncI0AMyvjAzjfu5Haw3zbjDJXzPsJIZp0lA+mIMkFqN9Q3BYrL1j7HvRhb
	 LZpvnZIdoHWdygggMMEw4g0ff4dl2V5Ovim7nv7K/MzyAPiWQ7SfIy2oKspqzLQl+E
	 hF/wPLidJXcoFQHJoY+iHMEXzUffjMSszySeRRT+Rrqe9dKLEGpsgo8196n2DAzlHH
	 Oe+MRezRN4/2g==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E244517E153D;
	Thu, 17 Jul 2025 19:26:54 +0200 (CEST)
Message-ID: <3a1c8ed6-c123-4a11-b2aa-405babfa2948@collabora.com>
Date: Thu, 17 Jul 2025 20:26:54 +0300
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
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2025071706-overarch-flaky-035b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 7:18 PM, Greg Kroah-Hartman wrote:
> On Thu, Jul 17, 2025 at 06:54:51PM +0300, Cristian Ciocaltea wrote:
>> Perform a first round of coding style cleanup:
>>
>> * Add new lines after several statement blocks
>> * Avoid line wrapping when 100-column width is not exceeded and it helps
>>   improve code readability
>> * Ensure lines do not end with '('
>> * Drop superfluous spaces or empty lines
>> * Add spaces where necessary, e.g. around operators
>> * Add braces for single if-statements when at least one branch of the
>>   conditional requires them
>>
>> This helps getting rid of the following checkpatch complaints:
>>
>>   CHECK: Lines should not end with a '('
>>   CHECK: braces {} should be used on all arms of this statement
>>   CHECK: Unbalanced braces around else statement
>>   CHECK: Blank lines aren't necessary before a close brace '}'
>>   CHECK: Unnecessary parentheses around
>>   CHECK: Alignment should match open parenthesis
>>   CHECK: No space is necessary after a cast
>>   CHECK: spaces preferred around that '-' (ctx:VxV)
>>   CHECK: spaces preferred around that '+' (ctx:VxV)
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> Coding style cleanups need to be "one patch per logical change", not
> "fix them all in one patch!" type of thing.
> 
> Sorry, but can you break this out better?

I could split this into something like:

- Fix spaces & blank lines
  CHECK: Blank lines aren't necessary before a close brace '}'
  CHECK: No space is necessary after a cast
  CHECK: spaces preferred around that '-' (ctx:VxV)
  CHECK: spaces preferred around that '+' (ctx:VxV)

- Fix braces
  CHECK: braces {} should be used on all arms of this statement
  CHECK: Unbalanced braces around else statement

- Fix alignment & line length
  CHECK: Lines should not end with a '('
  CHECK: Alignment should match open parenthesis
  
- Misc?!
  CHECK: Unnecessary parentheses around

Thanks,
Cristian

