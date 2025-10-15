Return-Path: <linux-kernel+bounces-854127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609ABDD9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A47134EDAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E73E30B525;
	Wed, 15 Oct 2025 09:08:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84EF30AACE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519293; cv=none; b=jVzPUSHl3RtulBRIad3iKom6wXv11NGUB7DSPZ5bESsI3U0BTaZKfLuBNUAO8WYglQZlAQPB+P3dTddvtzgtvyYQtqHAmlCwo5hCnxD22bHPOOZD22jMp3zslrPIWDuYakEUPyxcyfkpwgYmpK4tQtOI49Q3omEkESEe8NRKd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519293; c=relaxed/simple;
	bh=Rr9cZ40uhO3htuWyDtEp3kFvrwK9iyAq7ebJOOC4fMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJ9E6dIXE4bPe5QGuOoFtOmcioa8QVHdJor7d1eHyGVGmqzQH7BVQHFjLIlwx/8lYOkc2W2hgaFLX/FKcMP7/wmTx+bhrWRgRRwsiO0U/d6dSNEzoJYC4e/mVStuzgZ+BB9gK5FoLqp36YjKED1YOWu8BR4fpHgKa3jUX0GOS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8371655;
	Wed, 15 Oct 2025 02:08:00 -0700 (PDT)
Received: from [10.163.67.182] (unknown [10.163.67.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFC5E3F6A8;
	Wed, 15 Oct 2025 02:08:05 -0700 (PDT)
Message-ID: <cdd96bd2-f759-4637-b61e-c77fcd9a24c5@arm.com>
Date: Wed, 15 Oct 2025 14:38:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/mm: use <stdbool.h> in page_owner_sort.c
To: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251015085843.104443-1-ye.liu@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251015085843.104443-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 15/10/25 2:28 pm, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Use standard <stdbool.h> instead of manually defining bool, true and false.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>   tools/mm/page_owner_sort.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
> index 880e36df0c11..cbd195d7b5da 100644
> --- a/tools/mm/page_owner_sort.c
> +++ b/tools/mm/page_owner_sort.c
> @@ -13,6 +13,7 @@
>   
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <stdbool.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <fcntl.h>
> @@ -23,9 +24,9 @@
>   #include <linux/types.h>
>   #include <getopt.h>
>   
> -#define bool int
> -#define true 1
> -#define false 0
> +//#define bool int
> +//#define true 1
> +//#define false 0
>   #define TASK_COMM_LEN 16

You forgot to remove these :)

>   
>   struct block_list {

