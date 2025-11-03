Return-Path: <linux-kernel+bounces-882276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B326C2A0BA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEB6188FF55
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05BA3EA8D;
	Mon,  3 Nov 2025 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kGqVV/lJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E849EEBB;
	Mon,  3 Nov 2025 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762146932; cv=none; b=atVv3qqbUgaf1ICApju0IBNoQreqv0GkLiZh29yN0/FFZ5vM7TML6CWq80C9GTiqqy8vojwLxcxznf5JFcq/e6w8PtdpKTJt3ohTIQt1HM33jSQzNMp5a1tSn8A70jaAswd2x2qsrpFHiBOeje2dPEfbcjHsl3Q1sdXrfgQmGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762146932; c=relaxed/simple;
	bh=gjuedjcAE6rhzrNrj9SbWpvLGSJvDNjH6Fu60Xel1d0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jHbZotXms9Git/27kHjlPXUl3f6x3Dtt3HuSr63Ad2DNn6nuikrNTqX/aWqsddRW6BAYhW70LVHkfP3WGIApSe2RRuzuxgeULr7B3ov30Gp7e6k+z8VxYD8LqC7ps6gbkBhDz1DkmrHjHZUVC69crm2krptNz6wqCZy1kv2RgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kGqVV/lJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/5FjxCiXURw1daIJqFrL5fIP5RyDBI+cUYrL7n7fNX4=; b=kGqVV/lJBLa67iHFxotWLgZr7P
	AUUxbwE5y8N1iX6UKbv2i2niy04WV22NcH0fQTgt5aj7Hd9MJ3gmbKonKx6J+YKmzA+wl0iIXpN9I
	b2Ob0uCph5WaUQAygEVclUWL1VynZzxvFJJztqR7U4SQyGy1PYdAhQ+Vqlg8c+QKGwU6X5Z42WMC1
	QNpVAqFGSv9hmNMSXA6jfbWGA5R1t5y3wxfTLed0E1R3l7mzZ9+wiCEtGE/rTvIjRFkLb6glucDQ6
	AQa2S+FT2ut1IaJOnPOANl0QdZAAv1QHprstMfxPvFEPKt9RjBo4zndo0GGIdbSebltyF6WKXBruA
	3SQr7zVQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFmud-00000009DRJ-2CUX;
	Mon, 03 Nov 2025 05:15:27 +0000
Message-ID: <267c950a-3f6a-41d8-9dfd-2334b43365b7@infradead.org>
Date: Sun, 2 Nov 2025 21:15:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: uacce: Add explicit title
From: Randy Dunlap <rdunlap@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Accelerators <linux-accelerators@lists.ozlabs.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Jonathan Corbet <corbet@lwn.net>
References: <20251103025950.23159-1-bagasdotme@gmail.com>
 <e95704fd-68fa-4093-835c-ca220a9c3f5d@infradead.org>
Content-Language: en-US
In-Reply-To: <e95704fd-68fa-4093-835c-ca220a9c3f5d@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/25 8:58 PM, Randy Dunlap wrote:
> 
> 
> On 11/2/25 6:59 PM, Bagas Sanjaya wrote:
>> Uacce docs' sections are listed in misc-devices toctree instead due to
>> lack of explicit docs title. Add it to clean up the toctree.
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>  Documentation/misc-devices/uacce.rst | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
>> index 1db412e9b1a380..2ca539b7d6c799 100644
>> --- a/Documentation/misc-devices/uacce.rst
>> +++ b/Documentation/misc-devices/uacce.rst
>> @@ -1,7 +1,10 @@
>>  .. SPDX-License-Identifier: GPL-2.0
>>  
>> -Introduction of Uacce
>> ----------------------
>> +Uacce (Unified/User-space-acess-intended Accelerator Framework)
> 
>                              access ?

Aside from that, on v2 you can add:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

>> +===============================================================
>> +
>> +Introduction
>> +------------
>>  
>>  Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
>>  provide Shared Virtual Addressing (SVA) between accelerators and processes.
>>
>> base-commit: e5e7ca66a7fc6b8073c30a048e1157b88d427980
> 

-- 
~Randy

