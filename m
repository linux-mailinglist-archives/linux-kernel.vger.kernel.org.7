Return-Path: <linux-kernel+bounces-767975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94BFB25B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CD8883D29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981FE2264C4;
	Thu, 14 Aug 2025 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AAfrzkn7"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311932264A1;
	Thu, 14 Aug 2025 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151078; cv=none; b=Tg9zrzJG3EZv0RfUXOWosba66Rk6UfuwHLYWHWL8lB1bkkiSjoN4ncUgrBLmX9L8CCii3k9JSrS5+aK8a02o4vW+y1FHfVSmNMBv5xB2P5Mn3x0D+HCWru1LwPtoHqoskt2peKNvFudgltbC8ZMpUSzq3WKePTS5V1ZhwUYqcAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151078; c=relaxed/simple;
	bh=DnXdPc7ABxLygYVJDuIfEzT/1IavykRtS1/c+9WhEug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG5IrNevR7kQBGUg4pY+vERtQur16LIReDCm6Wkba3FvYvXwcm3ljqzc9wV1h8gFzVGyvqsveaYng5apvnO9RYNlH9WYtnPAqB/Z2lvEM+P5OEmKOXKd4pYlADnXNC/tBT8s/qOlfzXvT6YLT0oFVDQ0Q1J543qWsrE0rsQM3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AAfrzkn7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Us2ovdjyNrwh8OtJg8jW/y3MdOFxfd+CPZH2ahT32bM=; b=AAfrzkn7qGE7ijaY0b6WMZ46Qv
	e6JZz9fP8bXaidpVzlQnJ7PV4D8C5cxp1GnS/cKSVyWjVBN1eoxRu15Cq4HF+sOtllyCMupTt8Yfn
	PtNqsJZEbyKSf1QBtcB59Q8YWyqfe5IBvJ2ppZeRrYnijaoFjrM260MT8ncZm0RxJVccnjxL6z5qj
	/rELSNwBDpvcVQce0GIZW5NCrM7jFOFpFZi+fAs/VN+aaX5+2HqiYkYeA+2PZiP9HCs7vICWBw7GY
	S02tsEayxdxixbJ440AWaUmrclTxgJkj07Vwp4OwO4QdiGC1oJ0h6hyxHCbtDi1nM6+cb1EQfuZNS
	PKwjPHGg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umQyJ-0000000Fsea-2z1V;
	Thu, 14 Aug 2025 05:57:55 +0000
Message-ID: <0942c623-626e-43f5-90f8-552adc8d00dc@infradead.org>
Date: Wed, 13 Aug 2025 22:57:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] docs: Move the "features" tools to tools/doc
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20250813213218.198582-1-corbet@lwn.net>
 <20250813213218.198582-2-corbet@lwn.net> <20250814013817.249eb3c5@foz.lan>
 <a18c897e-8679-4155-932e-4bdb9e37f25c@infradead.org>
 <20250814075612.30ca0050@foz.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250814075612.30ca0050@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/25 10:56 PM, Mauro Carvalho Chehab wrote:
> Em Wed, 13 Aug 2025 16:42:42 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>> On 8/13/25 4:38 PM, Mauro Carvalho Chehab wrote:
>>> Em Wed, 13 Aug 2025 15:32:00 -0600
>>> Jonathan Corbet <corbet@lwn.net> escreveu:
>>>   
>>>> The scripts for managing the features docs are found in three different
>>>> directories; unite them all under tools/doc and update references as
>>>> needed.
>>>>
>>>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>>>> ---
>>>>  Documentation/sphinx/kernel_feat.py                           | 4 ++--
>>>>  .../features/scripts => tools/doc}/features-refresh.sh        | 0
>>>>  {scripts => tools/doc}/get_feat.pl                            | 2 +-  
>>>
>>> This one is the next on my list to convert to Python, but I didn't
>>> do any changes on it yet.  
>>
>> Just curious, why does it need to be converted from shell to Python?
>> I'm sure you will explain that in the patch description (or cover letter).
> 
> The rationale is the same as kernel-doc and get-abi: there is a Sphinx
> extension that executes it. By converting it into Python and splitting
> the code into an exec and a library, we can use the library directly at
> the extension.
> 
> Besides that, the code in Python, specially after using modules and 
> classes, become IMO clearer, making easier to maintain, specially if
> we avoid functions inside functions, complex class inheritance, lamba
> functions and multiple statements on a single line.

Thank you for that.

-- 
~Randy


