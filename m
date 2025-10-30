Return-Path: <linux-kernel+bounces-877602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62546C1E8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A766A189E504
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09832F7AC6;
	Thu, 30 Oct 2025 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eyO89ghm"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5182BE7CD;
	Thu, 30 Oct 2025 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805550; cv=none; b=an+6cS+7Cn+JeMpreU9ftTsr6LQ627U8OHDr2J0O3kjIUHVcARUY1ddVMQdBA2VovKqNhdG1zHTfwTE1lp/zbKyvBjtbGLNQIf10be9dLVl7EY79G5iaGD2bGaOUzP1n4imIRkqoeWXG8gLQRB0MSsgQpCiJT+SzF4LZqLZE6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805550; c=relaxed/simple;
	bh=bn5A/m1OsgUKHJhhjxySUo4eK7TU9DdBJ75InA0kzsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtC5Zet/kRYxZsSlzuKa8ZicJ9yqBv5S5FRDkFC41lng3rmaxuMxrUvJSBBGYQwb9LMmSyfAIBrmoz2dxxPSChYyHXDNnSKqkRPeRXlnPXst+C/YCWjmNW//y40Fr2nctq479B85gXepdXyJvBx9mV8KIY98gbz862yvIl9bKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eyO89ghm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mHpQwxRchZle7itzYGWAIJeSghjL379Sw36+lqWAIS4=; b=eyO89ghmZUjgAbspEFqpCh+LLF
	Kx/+IrtC6tTyglEAWbtCz15JdwlT6Pv1X37LjkKkbq7Jz9v9G9mi1tEiKLMvjonzODzjecpWx3e4q
	gO8ob/eSsUai1UdzddOkRkauSox9DLIXnpPJbK0BSOht/kKG6MK4FqExsCS9GT2kgfWpDwHuB8DJn
	7X8ykwMzQtea2lKIGn3YBCAlZe/on0zEYUZ7QM2DJwey0fcsZFjfxq5CJUncvauNDUFB+LNzyLRrx
	FpttQiGedd/lssOL2KeAtifTa2zmCZm8U/jMfSz7ZNVbXfrRXyFZkXxq7FN0oN1/K2sNyV0JUS0Sa
	rLY87LzQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEM6S-00000003YqA-1ESN;
	Thu, 30 Oct 2025 06:25:44 +0000
Message-ID: <6553266e-aa0e-4ca7-b83c-cf6df2764f3c@infradead.org>
Date: Wed, 29 Oct 2025 23:25:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kernel-chktaint: add reporting for tainted modules
To: Thorsten Leemhuis <linux@leemhuis.info>, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20251029043901.10755-1-rdunlap@infradead.org>
 <16cd7071-3c19-4e32-ba11-ce0856a6f2f8@leemhuis.info>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <16cd7071-3c19-4e32-ba11-ce0856a6f2f8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/25 6:56 AM, Thorsten Leemhuis wrote:
> On 10/29/25 05:39, Randy Dunlap wrote:
>> Check all loaded modules and report any that have their 'taint'
>> flags set along with a count of all tainted modules.
>> The tainted module output format is:
>>  * <module_name> (<taint_flags>)
>>
>> Example output:
>>
>> Kernel is "tainted" for the following reasons:
>>  * externally-built ('out-of-tree') module was loaded  (#12)
>>  * unsigned module was loaded (#13)
>> Raw taint value as int/string: 12288/'G           OE      '
>>
>> Modules tainted: 1
>>  * dump_test (OE)
> 
> Great. Now I wonder if the "1" really is needed, but whatever. I only
> mentioned that because something else came to my mind:

Agreed. Will drop that line.

> The script can be called with a positive integer as parameter to decode
> a value you retrieved from /proc/sys/kernel/tainted on another system.
> Then the module check likely should be omitted. 
> 
> [...] 
>> +echo "Raw taint value as int/string: $taint/'$out'"
>> +
>> +# report on any tainted loadable modules
>> +[ -r /sys/module/ ] && cnt=`grep [A-Z] /sys/module/*/taint | wc -l` || cnt=0
> 
> Maybe by replacing that line with something like this (untested;
> not even sure if the foo && bar && baz || foobar really works):
> 
> [ $1 -eq 0 ] && [ -r /sys/module/ ] && cnt=`grep [A-Z] /sys/module/*/taint | wc -l` || cnt=0  
Looks good. I'll test that and send v3.Thanks.
-- 
~Randy


