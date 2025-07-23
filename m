Return-Path: <linux-kernel+bounces-742041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F54BB0EC47
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5013B7917
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529582777F7;
	Wed, 23 Jul 2025 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VIu3RiMc"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD0272E57
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256848; cv=none; b=sCsQHjbTkIJOULmoWYmtfaMgk8aQSQNgXQF0uL48ZrbmRSsZXRAOpjqkta0mgJyc+W2SvxaDWqx0fdNNKW/WC7nF+cGJTPSPV42K5Siracc4TvNeIKyjcl4HRpVHoZ3zsMMr6AHkmyLXfj4MvICAw8GqrqI9o8AI4zW8hBQMih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256848; c=relaxed/simple;
	bh=RkyJbynNr0CX73uojkXzexx9LHzGNdbm5mfiJ2fXhrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUYHY1QOppzCXCZOfBaU6mq0iPUVgcImZKYOUdEruf99/tgmB1EFWRfwWFE8RQSKDH9yTOdRMIdHVITmmGqG8S7z4w5XKaQCazOu7nUstG7dHhi1u76XQba7sfi3t6oJipVvzma51FWKEwpSvfj8d2zxGt2JBfDjEP6XqCKb0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VIu3RiMc; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=QdwtM+ZTobn78aFin1VxfehR87TJtajIWuTIlJuGaW4=;
	b=VIu3RiMc1TE02syEQwNuBjti6uiptRARgYNN0+LAri/La9G1cMGP9RPykKBftQ
	z9ILruiFz2VDheTiOQ4mf6oFMMwLNPKWMxMlsyi+HhRQio2xiJxYK0mndl/XLL+D
	w0ejlh1YcG4mU2C1m/EEfo0PdjrGVsoxhX6krUT+MDnMs=
Received: from [192.168.22.151] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHPKw3k4Bo1_HrGg--.1050S2;
	Wed, 23 Jul 2025 15:46:04 +0800 (CST)
Message-ID: <c7a32d87-efbd-47bd-9a18-9eb51e441a7f@163.com>
Date: Wed, 23 Jul 2025 15:45:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add stack trace when bad rss-counter state is
 detected
To: Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250723072350.1742071-1-liuqiye2025@163.com>
 <202507230031.52B5C2B53@keescook>
Content-Language: en-US
From: Xuanye Liu <liuqiye2025@163.com>
In-Reply-To: <202507230031.52B5C2B53@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHPKw3k4Bo1_HrGg--.1050S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww48uw4kJr48CryDXr4xJFb_yoW8GF45pF
	n3KF1DJFWkX342gasIva1qyry5tw4qqryag34kA3yfKr9xtF1FqF45Kr4UKF1qkryxK3WS
	9F4jgrnrAa90vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jr2-nUUUUU=
X-CM-SenderInfo: 5olx1xd1hsijqv6rljoofrz/1tbiMAGTUGiAiBfEtwABs3


在 2025/7/23 15:31, Kees Cook 写道:
> On Wed, Jul 23, 2025 at 03:23:49PM +0800, Xuanye Liu wrote:
>> The check_mm() function verifies the correctness of rss counters in
>> struct mm_struct. Currently, it only prints an alert when a bad
>> rss-counter state is detected, but lacks sufficient context for
>> debugging.
>>
>> This patch adds a dump_stack() call to provide a stack trace when
>> the rss-counter state is invalid. This helps developers identify
>> where the corrupted mm_struct is being checked and trace the
>> underlying cause of the inconsistency.
> Why not just convert the pr_alert to a WARN?
Good idea! I'll gather more feedback from others and then update to v2.
>
> -Kees
>
>> Signed-off-by: Xuanye Liu <liuqiye2025@163.com>
>> ---
>>  kernel/fork.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index cfe2f1df5f27..d38f1c5270ea 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -584,9 +584,11 @@ static void check_mm(struct mm_struct *mm)
>>  	for (i = 0; i < NR_MM_COUNTERS; i++) {
>>  		long x = percpu_counter_sum(&mm->rss_stat[i]);
>>  
>> -		if (unlikely(x))
>> +		if (unlikely(x)) {
>>  			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
>>  				 mm, resident_page_types[i], x);
>> +			dump_stack();
>> +		}
>>  	}
>>  
>>  	if (mm_pgtables_bytes(mm))
>> -- 
>> 2.43.0
>>
-- 
Thanks,
Xuanye


