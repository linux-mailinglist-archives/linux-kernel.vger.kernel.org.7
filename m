Return-Path: <linux-kernel+bounces-872340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F6C101CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B8674FD4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5431C58A;
	Mon, 27 Oct 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XrqSVjkZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1D2BD033;
	Mon, 27 Oct 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590610; cv=none; b=VGsBrJ3ifUS5MR6sONzXbIQrc7w220ZOnA8awoJ2ituSU0KH2Q7CP57qftUNk5EoU7xj+33vrZcz/kDuxKYRjbl4F6yk3xLHjjsWnRqzFwdmJ4WFRE2A4zIoYBOdTbn7gwn3/WX3RMsH+YHQ5w0VE9TXf5Fj2T2mal0JCSRt8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590610; c=relaxed/simple;
	bh=So8NP6f8CaWcwExTfv/Wr0A00X17Unsc7FQQ3al+beQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I4dNDHuHXCSw1Eo+4LpkWkpvtP+iQl7yzRk8mpF+Z9yBNjeGLmn+j6ZKdxBt43DAgFLcFzCGV1lZoCjRrltBnCqZdl1hFrlrtRAqnpmRBhzyk79caRcIF0tXkp1QnZ1UH7w9u54G5ojl4mI0KBZ0fQtJJ7HXYADgYYwOU1+RPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XrqSVjkZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=kuIVSUiix3AgqKsXyCQ0motbBK2F3l1jAUwSf8sfp9Q=; b=XrqSVjkZVoL8la0GFf6b7aMJTC
	YX2uv1YcOntDybx1GKPTQdO8VoX880cF2WLnXF3mY/YslDiUSc0/jJk6OwQI270BEGo5KnL/lbBWO
	HGnyD+oxyhcvVM/EjVblqIorjpuBif05+Mf8FlJpO2nbKgbaZlQR0L9QJeMvTaUYvhxnqK6ZpDyEj
	liN6Haa9gxbkNKGQ03wW2In6J9p5K+szn6eeWTePNGIg/R0brxKDJP/Cq8lYhNxoW3UhQCDS01q/V
	mBYjbR9S0adudlN7M3Qrtb4tWTEsL1+8/BFHC+Q9f1VZfhXC6zP/9XWG3XsAjcLzT74BJF0UbpbLn
	K4CRRBtQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDSBj-0000000EYtK-2mcO;
	Mon, 27 Oct 2025 18:43:27 +0000
Message-ID: <2ab04392-f133-4ebe-943a-c58050b36f13@infradead.org>
Date: Mon, 27 Oct 2025 11:43:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] Docs: add Functions parameters order section
To: Jani Nikula <jani.nikula@intel.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20251025162858.305236-1-yury.norov@gmail.com>
 <20251025163305.306787-14-yury.norov@gmail.com>
 <723c936f92352352c3b1a84b858d684f5b7a0834@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <723c936f92352352c3b1a84b858d684f5b7a0834@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/25 2:02 AM, Jani Nikula wrote:
> On Sat, 25 Oct 2025, "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
>> Standardize parameters ordering in some typical cases to minimize
>> confusion.
>>
>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>> ---
>>  Documentation/process/coding-style.rst | 48 ++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index d1a8e5465ed9..dde24148305c 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -523,6 +523,54 @@ below, compared to the **declaration** example above)::
>>  	...
>>   }
>>  
>> +6.2) Function parameters order
>> +------------------------------
>> +
>> +The order of parameters is important both for code generation and readability.
>> +Passing parameters in an unusual order is a common source of bugs. Listing
>> +them in standard widely adopted order helps to avoid confusion.
>> +
>> +Many ABIs put first function parameter and return value in R0. If your
>> +function returns one of its parameters, passing it at the very beginning
>> +would lead to a better code generation. For example::
>> +
>> +        void *memset64(uint64_t *s, uint64_t v, size_t count);
>> +        void *memcpy(void *dest, const void *src, size_t count);
>> +
>> +If your function doesn't propagate a parameter, but has a meaning of copying
>> +and/or processing data, the best practice is following the traditional order:
>> +destination, source, options, flags.
>> +
>> +for_each()-like iterators should take an enumerator the first. For example::
>> +
>> +        for_each_set_bit(bit, mask, nbits);
>> +                do_something(bit);
>> +
>> +        list_for_each_entry(pos, head, member);
>> +                do_something(pos);
>> +
>> +If function operates on a range or ranges of data, corresponding parameters
>> +may be described as ``start - end`` or ``start - size`` pairs. In both cases,
>> +the parameters should follow each other. For example::
>> +
>> +        int
>> +        check_range(unsigned long vstart, unsigned long vend,
>> +                    unsigned long kstart, unsigned long kend);
>> +
>> +        static inline void flush_icache_range(unsigned long start, unsigned long end);
>> +
>> +        static inline void flush_icache_user_page(struct vm_area_struct *vma,
>> +                                            struct page *page,
>> +                                            unsigned long addr, int len);
>> +
>> +Both ``start`` and ``end`` of the interval are inclusive.
>> +
>> +Describing intervals in order ``end - start`` is unfavorable. One notable
>> +example is the ``GENMASK(high, low)`` macro. While such a notation is popular
>> +in hardware context, particularly to describe registers structure, in context
>> +of software development it looks counter intuitive and confusing. Please switch
>> +to an equivalent ``BITS(low, high)`` version.
>> +
> 
> GENMASK when used for defining hardware registers is completely fine,
> and *much* easier to deal with when you cross check against the specs
> that almost invariably define high:low.
> 
> Which other parts of coding style take on specific interfaces and tell
> you to switch? Weird. I for one don't want to encourage an influx of
> trivial patches doing GENMASK to BITS conversions, and then keep
> rejecting them. It's just a huge collective waste of time.
> 
> Anyway, that's a lot of text on "function parameter order" to justify
> BITS(), but completely skips more important principles such as "context
> parameter first", or "destination first".

and usually flags or gfp_t last (if they are used).

There are several exceptions to these, but consistency helps and
lack of it has caused some argument problems in the past.

-- 
~Randy


