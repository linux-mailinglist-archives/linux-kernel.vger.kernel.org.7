Return-Path: <linux-kernel+bounces-807233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A35B4A1DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF414E6F16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB04302CAB;
	Tue,  9 Sep 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v/0Z4cgL"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B24315D36
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398558; cv=none; b=O2YZMDizwEktC763sxrO2ZO6W4t2WPosS6ezKtpzx273LHCh2ZznhdiUMbMVMUXjCPoHxeOIk5/wR5SNJO4OtFkz7SkzXv97GrkYWxcxWOLeTp+HchraWwQBYnj+yIlbflFl5YAm7F0+CifDoivZanRKXCxlNaods0X16v1o0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398558; c=relaxed/simple;
	bh=K9TvDqzwwEGVy3bxrE5cDjXb0bzlK07GFKLdW4JPkg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGP5DAt6V9/qBsNpGRU7/QvK42Uf2oKeHHQWp8vQm8/V7tySj2qtP6wumZ0HTG6hi8R+6M7oAMkRGwD4YtmWTvhq4jJhDo8EYl+l+pyCpMRTXY6pWnWFBd3qynNQ1XAP9H0mHan2yOtjHMBwojvAft6K4Om0GaF/8mp0PDlA+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v/0Z4cgL; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <953544be-1be5-4745-a027-e8c0be7b027d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757398552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0f43r2+G2MTHogFG4Kd662rlFkqbAoJ3O2gzPVjJRQ=;
	b=v/0Z4cgLTAbFBMK9eHbRTNRLDbMjpP60H7zKA6Q57i6tasGunFc/NqIxB/E12TX5vQVQb/
	m/mePYPQKEr7k4wEd/CqZ/q+Iv2Cu2FNCCyaansMscAHTa76fdURJcg9Tw7t22rpe9VojX
	mM6MFetCDy5tJdJFa9u3JU3wDMfFSQw=
Date: Tue, 9 Sep 2025 14:15:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, chizhiling@163.com,
 Youling Tang <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20250711055509.91587-1-youling.tang@linux.dev>
 <jk3sbqrkfmtvrzgant74jfm2n3yn6hzd7tefjhjys42yt2trnp@avx5stdnkfsc>
 <afff8170-eed3-4c5c-8cc7-1595ccd32052@linux.dev>
 <20250903155046.bd82ae87ab9d30fe32ace2a6@linux-foundation.org>
 <bv4t7a6boxh4dmjl7zsmhd74wm5hyfpdivypmrqerlpn23betz@tw52mlf4xf3s>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <bv4t7a6boxh4dmjl7zsmhd74wm5hyfpdivypmrqerlpn23betz@tw52mlf4xf3s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi, Andrew

I see there are two fix patches for my patch in the mm-unstable
branch, should I send a v2 that incorporates these fixes, or is
it not necessary?
Thanks,
Youling.
On 2025/9/5 20:50, Jan Kara wrote:
> On Wed 03-09-25 15:50:46, Andrew Morton wrote:
>> On Tue, 12 Aug 2025 17:08:53 +0800 Youling Tang <youling.tang@linux.dev> wrote:
>>
>>> Hi, Jan
>>> On 2025/7/14 17:33, Jan Kara wrote:
>>>> On Fri 11-07-25 13:55:09, Youling Tang wrote:
>>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>> ...
>>>
>>>>> --- a/mm/filemap.c
>>>>> +++ b/mm/filemap.c
>>>>> @@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>>>>>    	unsigned int flags;
>>>>>    	int err = 0;
>>>>>    
>>>>> -	/* "last_index" is the index of the page beyond the end of the read */
>>>>> -	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
>>>>> +	/* "last_index" is the index of the folio beyond the end of the read */
>>>>> +	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
>>>>> +	last_index >>= PAGE_SHIFT;
>>>> I think that filemap_get_pages() shouldn't be really trying to guess what
>>>> readahead code needs and round last_index based on min folio order. After
>>>> all the situation isn't special for LBS filesystems. It can also happen
>>>> that the readahead mark ends up in the middle of large folio for other
>>>> reasons. In fact, we already do have code in page_cache_ra_order() ->
>>>> ra_alloc_folio() that handles rounding of index where mark should be placed
>>>> so your changes essentially try to outsmart that code which is not good. I
>>>> think the solution should really be placed in page_cache_ra_order() +
>>>> ra_alloc_folio() instead.
>>>>
>>>> In fact the problem you are trying to solve was kind of introduced (or at
>>>> least made more visible) by my commit ab4443fe3ca62 ("readahead: avoid
>>>> multiple marked readahead pages"). There I've changed the code to round the
>>>> index down because I've convinced myself it doesn't matter and rounding
>>>> down is easier to handle in that place. But your example shows there are
>>>> cases where rounding down has weird consequences and rounding up would have
>>>> been better. So I think we need to come up with a method how to round up
>>>> the index of marked folio to fix your case without reintroducing problems
>>>> mentioned in commit ab4443fe3ca62.
>>> Yes, I simply replaced round_up() in ra_alloc_folio() with round_down()
>>> to avoid this phenomenon before submitting this patch.
>>>
>>> But at present, I haven't found a suitable way to solve both of these
>>> problems
>>> simultaneously. Do you have a better solution on your side?
>>>
>> fyi, this patch remains stuck in mm.git awaiting resolution.
>>
>> Do we have any information regarding its importance?  Which means do we
>> have any measurement of its effect upon any real-world workload?
> OK, after experimenting with the code some more and with rounding the
> readahead mark index up, I've found out we need something like Youling
> proposed anyway because otherwise it could happen that the whole readahead
> area fits into a single min-order folio and thus with rounding up we
> wouldn't have a folio to place readahead mark on. So with that I'm
> withdrawing my objections and feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> to Youling's patch.
>
> 								Honza

