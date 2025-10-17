Return-Path: <linux-kernel+bounces-857143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB2BE6076
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA831A66367
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951421B185;
	Fri, 17 Oct 2025 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="imTp//37"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8237165F13
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760663962; cv=none; b=LvBP4gay7YK5IPTzoKV40FDbN621qRUHKdcTgA8ieaNNZwS0StMrYHw4Y8luVsqgTpk0t3R/A3X7loM1sFPM4KLewcQfhTVUYVKzylxhErqsvSu+iz/KQzqJD9liuOggvwDIUgA7HUjSgQ7OMRyOLklNEyRnWcV6Omv1tEqt9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760663962; c=relaxed/simple;
	bh=yC2fpAkcfnlz7vqXLATDdo4o+VVgv83RVVb90YGoSWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPNYXno8O3ZvknQHOKq9IQq7ps+O9JusxAFHXLu8BfhO54/UU8mryzE9e7x9FVtKQYlH4LnG+XzlF2KcZzYZLiQFL3vy5tQjje7UjiUuYM6K4DdMBZnaUHxOLv44UNEm6rYVgBgnXqO+T/4yzAYKNzYo/lHdxSQQeCCF7YUfBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=imTp//37; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <51f86d0e-e9dc-42ef-baee-0dfdd39b7cab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760663954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GdIKXKSuyoQ2I8o+Rbq8hN819PD6bayvqWnle+WNBA=;
	b=imTp//3755IrNDCBBNh+hP7nBOKNj+g3rU0OfOwdNwRYq7dnSjQkADbbgS7uGpGkm6vTse
	MIhzcPlu+Jw+G2bTUVX2bPyPPNzDOuAEwmwtzV00isvxhy7cXYPfc2yBFdmxMVx4gm3F+2
	XmMNLjwILu2ktOoE2KtPPW+J3PyLDJE=
Date: Fri, 17 Oct 2025 09:19:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tools/mm/page_owner_sort: add help option support
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251016201051.67097-1-sj@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20251016201051.67097-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/10/17 04:10, SeongJae Park 写道:
> On Thu, 16 Oct 2025 13:49:25 +0800 Ye Liu <ye.liu@linux.dev> wrote:
> 
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Add -h/--help option to display usage information and improve code style.
> 
> Looks good to me, though I have a trivial comment below.
> 
>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
>>  tools/mm/page_owner_sort.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
>> index 880e36df0c11..202eafed66a9 100644
>> --- a/tools/mm/page_owner_sort.c
>> +++ b/tools/mm/page_owner_sort.c
>> @@ -669,14 +669,15 @@ int main(int argc, char **argv)
>>  		{ "pid", required_argument, NULL, 1 },
>>  		{ "tgid", required_argument, NULL, 2 },
>>  		{ "name", required_argument, NULL, 3 },
>> -		{ "cull",  required_argument, NULL, 4 },
>> -		{ "sort",  required_argument, NULL, 5 },
>> +		{ "cull", required_argument, NULL, 4 },
>> +		{ "sort", required_argument, NULL, 5 },
> 
> Seems unnecessary changes.
The spacing changes fix inconsistent formatting in longopts array.
Since the format fixes are simple and in the same context, I put them together.
If you insist on removing these changes, I will drop them in the next version.> 
>> +		{ "help", no_argument, NULL, 'h' },
>>  		{ 0, 0, 0, 0},
>>  	};
>>  
>>  	compare_flag = COMP_NO_FLAG;
>>  
>> -	while ((opt = getopt_long(argc, argv, "admnpstP", longopts, NULL)) != -1)
>> +	while ((opt = getopt_long(argc, argv, "admnpstPh", longopts, NULL)) != -1)
>>  		switch (opt) {
>>  		case 'a':
>>  			compare_flag |= COMP_ALLOC;
>> @@ -702,6 +703,9 @@ int main(int argc, char **argv)
>>  		case 'n':
>>  			compare_flag |= COMP_COMM;
>>  			break;
>> +		case 'h':
>> +			usage();
>> +			exit(0);
>>  		case 1:
>>  			filter = filter | FILTER_PID;
>>  			fc.pids = parse_nums_list(optarg, &fc.pids_size);
>> -- 
>> 2.43.0
> 
> If you remove the unnecessary changes, please feel free to add below:
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ

-- 
Thanks,
Ye Liu


