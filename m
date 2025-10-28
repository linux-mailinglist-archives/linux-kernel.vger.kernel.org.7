Return-Path: <linux-kernel+bounces-874606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56FC16ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC873A860C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676D3502AE;
	Tue, 28 Oct 2025 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MH0fqEk4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967E23EAB2;
	Tue, 28 Oct 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681115; cv=none; b=d/ckyLNfqyDZGX8+8hh5bTl/QjohcymIc1JgzB6trqhy3hBa3xu/Y5B6RR8HK2i+oqweNRAx6CS6ZMxfJtBI+UEfoSjRJ9VTuB+o/Y2lL/QteQlGzopEYY/LrAw+qn8HCjXnNDPUD5qrC6oDgG8sOXAa7PwG/abZlXo+URzbIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681115; c=relaxed/simple;
	bh=htFKx4A2/Osr6gH0BBd/NGYQeAjNolyie9mPXDQohdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFDXofUV1jKrkenhLwfbDRU1+qd7udskZtbbB79RgkZ3WrRJg32MCqlJAGKe4UQUAwb1iBNRZ5o3fSlfi7IhPX4h3pxbRRyXb81Jh574WdrwFNV4YlD3S9QWf93gjmR2c39nWuuhLa21XVVOiUbJ4v+APWoqbuTCckBOfoTL5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MH0fqEk4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=e5sasCky/OE1mIKsnQ5bZ4Ik3jFCkBaZchBG30xD9Rs=; b=MH0fqEk4hfWaGgBE9iEERnby/r
	n5uO5XSdrHT4JBJxg1X23RsoHtK56x4exRwzKY88tQYW2jbACkL8lUzfcnIIKTIfhk3zJM8tIHmIn
	vcP9ea5Fx5ptEmCF013p5TltdtqZS4aAJaoomGb0l8uqVSoqNsdPqlw8dh6OAJx/emzYA6rcrDTh2
	FImvUZAKyR0OtBtKASU5qJIc/4eUo7GseZdEs3mg80HNfWp0Q8/dLAmbExLRpsgqkoGQRo6oyH07b
	HMSmJATdNl+pTcvE0LoF4U009dp+7lTtqgUI3FsJeoeb/B0ijcvwqfpWMxdvrFS4znfgWhZFEBUEF
	cM7YQfuQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDpjN-0000000GZdv-0Nte;
	Tue, 28 Oct 2025 19:51:45 +0000
Message-ID: <892775bd-401d-46df-a730-a4f9a09f5149@infradead.org>
Date: Tue, 28 Oct 2025 12:51:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-chktaint: add reporting for tainted modules
To: Thorsten Leemhuis <linux@leemhuis.info>, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20251028071211.18065-1-rdunlap@infradead.org>
 <a842c1c1-948c-40bd-b564-9b746be69cd2@leemhuis.info>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a842c1c1-948c-40bd-b564-9b746be69cd2@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/25 3:05 AM, Thorsten Leemhuis wrote:
> On 10/28/25 08:12, Randy Dunlap wrote:
>> Check all loaded modules and report any that have their 'taint'
>> flags set along with a count of all tainted modules.
>> The tainted module output format is:
>> <module_name>: taint=<flags>
>>
>> Example output:
>>
>> Kernel is "tainted" for the following reasons:
>>  * externally-built ('out-of-tree') module was loaded  (#12)
>>  * unsigned module was loaded (#13)
>> Raw taint value as int/string: 12288/'G           OE      '
> 
> I wonder if it would be easier more readable if the format used above...
>> Modules tainted: count=1
>> dump_test: taint=OE
> 
> ...would be reused here somewhat. Like this maybe?
> 
> Modules tainted: 1
>  * dump_test (OE)

Yeah, I like that. Thanks.

-- 
~Randy


