Return-Path: <linux-kernel+bounces-854200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED7FBDDCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA24B19A2193
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876531A05B;
	Wed, 15 Oct 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCFsb2rz"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9831A7F0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521061; cv=none; b=iP/b7dPASp2QzaIi++nwBNLCGN3j6qGIl3J5A11KAgkI8Vf9V8Nqxb/eNTt75aQZMJfyxbNsPAJ2D4iFBWuLYuv4AT4v5yWs1IZgXQTHnXKvdt7crkmbq7PwtGjCrKYFA+oLp8Fs3JRueNc1lDxuC0CUUYIMbSReV3qKOlOW5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521061; c=relaxed/simple;
	bh=ZxAhK0m1Z8mJHinpImt8956zCK4MeHec3iwHPT6mMMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8lbCOtr7M3u3418CvuZrq2JpLqj4TK0Tiq6CbdGBhLZlnesPGYIqfUH4ijtt9nZURs45Cz4kp0fHcRWdv+PwSTVlexzCYlVIfjVwp6W0KdqwfGa/gVf8VG44BSkoG90EcZbsX2jBUN3KFjolou3SbOIs2JP0t8fF1NVi3H0zgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCFsb2rz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ccabf86-c194-48c1-9fa3-c7515742d63c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760521054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pn+PfUTaOErMrK4kmS5h/pJ01lIUFvcqGW1ChJWqgVQ=;
	b=iCFsb2rzBiWmerRPA6GOPsTAqKJCocKV2LmT4gTxHosP8QEbp3U9BE/jto+j0O9UfVinQP
	7qCesKpiU1DD/Pj6VOu9tmup59QIMtDzO3nSateHX9A9VJdu8h/aiMV3iQBvt1lpqOHeYj
	rC7+m0PonyxdJtGj04Jqvv9xzTEa1Cs=
Date: Wed, 15 Oct 2025 17:37:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tools/mm: use <stdbool.h> in page_owner_sort.c
To: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251015085843.104443-1-ye.liu@linux.dev>
 <cdd96bd2-f759-4637-b61e-c77fcd9a24c5@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <cdd96bd2-f759-4637-b61e-c77fcd9a24c5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/10/15 17:08, Dev Jain 写道:
> 
> On 15/10/25 2:28 pm, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Use standard <stdbool.h> instead of manually defining bool, true and false.
>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
>>   tools/mm/page_owner_sort.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
>> index 880e36df0c11..cbd195d7b5da 100644
>> --- a/tools/mm/page_owner_sort.c
>> +++ b/tools/mm/page_owner_sort.c
>> @@ -13,6 +13,7 @@
>>     #include <stdio.h>
>>   #include <stdlib.h>
>> +#include <stdbool.h>
>>   #include <sys/types.h>
>>   #include <sys/stat.h>
>>   #include <fcntl.h>
>> @@ -23,9 +24,9 @@
>>   #include <linux/types.h>
>>   #include <getopt.h>
>>   -#define bool int
>> -#define true 1
>> -#define false 0
>> +//#define bool int
>> +//#define true 1
>> +//#define false 0
>>   #define TASK_COMM_LEN 16
> 
> You forgot to remove these :)
Oops, you're right — I’ll drop those lines and send a v2.  :)
Thanks!> 
>>     struct block_list {

-- 
Thanks,
Ye Liu


