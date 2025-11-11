Return-Path: <linux-kernel+bounces-895467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7820C4E044
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDE43A60FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD183246FF;
	Tue, 11 Nov 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx4cjvlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0413246EE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866225; cv=none; b=NFY4GnHpi4Gl+fXZlOBF49CLDPovf9RC1yDRq3NxTvDAx8JhIXsEz081+UovKLzP3ezFZyIdLLmPCTjeTSDq7VbQF68q1Vw1HqCU2C7BftRN24AaIaCMWUUqDu3mOkpc5/Z947YQvYhSWpwKj0Q9re/NU26ezh/SKhKmDIRzKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866225; c=relaxed/simple;
	bh=MnQGngUYZB/AuquYMcvngj/vv0fvRZTP9N1ik/AuqZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZNJYrUvVsozK0ecxrroS6xQ7ubyx283AzxFjw1dB0wzutBfDwovhyanhvBiw63ZCPtZBxlnOkuuAvFhmy9djcIF120t7WbIJVpT0WFPSA+SVY4wK6ynAUvXqw+mT3FkYu4P3jFZjoSqwe7mJqWMIhQBs/LC0tF+gXZjor6VZb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx4cjvlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D0BC19422;
	Tue, 11 Nov 2025 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762866224;
	bh=MnQGngUYZB/AuquYMcvngj/vv0fvRZTP9N1ik/AuqZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nx4cjvlP88r0deet2wJMyBpLgRhoG5z585/MuON0PuaxnYs55RYvZ1IzQY6H9JByx
	 8bGGRsHDFEvVTPi1GFJlU1oIwYPn4M5SdsrRJX9Ooy1u69MchU64Wfpv/JPxpTWG9G
	 Jd1uIKXHmujcrw3CK2LUloly/bMW6Kp56MhenOxEz5AqeC4WvXoDBmB62K7MIbcOr2
	 h3C1DHdEyZHl7Lgag9Xlyn8nJ0JAgy5Jqng9hzmKIWQeVkRyD6exr1QQxCHV71J19m
	 hTyHcpPVc0vcXqTTz+mZd4mabIbcZX23RiHeq+5QDwdiewLoAsuK7FiLsyaYQ/tQg+
	 EL34ZgyDgZJCw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  akpm@linux-foundation.org,
  graf@amazon.com,  pratyush@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH] liveupdate: kho: Enable KHO by default
In-Reply-To: <aRIwSEF8Y0I6q8Cy@kernel.org> (Mike Rapoport's message of "Mon,
	10 Nov 2025 20:34:48 +0200")
References: <20251110180715.602807-1-pasha.tatashin@soleen.com>
	<aRIwSEF8Y0I6q8Cy@kernel.org>
Date: Tue, 11 Nov 2025 14:03:42 +0100
Message-ID: <mafs0cy5oafgx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 10 2025, Mike Rapoport wrote:

> On Mon, Nov 10, 2025 at 01:07:15PM -0500, Pasha Tatashin wrote:
>>
>> Subject: [PATCH] liveupdate: kho: Enable KHO by default
>
> No need to put a directory (liveupdate) prefix here. "kho: " is enough.

+1

>
> With that fixed
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>
>> Upcoming LUO requires KHO for its operations, the requirement to place
>> both KHO=on and liveupdate=on becomes redundant. Set KHO to be enabled
>> by default.
>> 
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index b54ca665e005..568cd9fe9aca 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -51,7 +51,7 @@ union kho_page_info {
>>  
>>  static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
>>  
>> -static bool kho_enable __ro_after_init;
>> +static bool kho_enable __ro_after_init = true;
>>  
>>  bool kho_is_enabled(void)
>>  {
>> 
>> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
>> -- 
>> 2.51.2.1041.gc1ab5b90ca-goog
>> 

-- 
Regards,
Pratyush Yadav

