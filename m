Return-Path: <linux-kernel+bounces-849321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92A4BCFD2F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 00:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575843BD475
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1A234963;
	Sat, 11 Oct 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SsfPHkma"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38970188580
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760221584; cv=none; b=RzbODyaV884pUWILDcN3fhY2GnhDLKtqtLhLpWY0QbcTbD1c60u35hgH3N7X4WePEAm8WAERHFyK61yuJiGj5NrrCf2aqVumOiWzQwrrAzNk9ykgL+HyoisLmkaIYriMfGWu4sSte8OA/T3tqR29+k9rsvQK2Pftzq+aukxfdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760221584; c=relaxed/simple;
	bh=7FznruyfzlyBCeC27qhDWNgCMsIWQBwvjajm92XpwT0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fYSn1wDgDR59PjOkBGxNn/KbnnVGWEyscOm8UWwZOfKYAo5nsBSlfBKHAVVnNPM8cm+56fpe7crDU973ovQ/ZZyEG2BVSk4gUWg7FHDeUKFG+S2rlnTndOG07L6iO0I9jfvbsOefB25RJmJrK2HTmeFnlkTodC7KA2tNrAg2R0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SsfPHkma; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FsgbOcMfTE/oFgBmBmKbPG0YjKvTmsKKa/N4VIyTa1g=; b=SsfPHkma+/xD3q+qYv/PrSfN8s
	wrSiwA3/igbPmUDt/uSeODXXx8vqkw8MkwuwRzDmv3VXKXq8NmjpjIRQG65Oi41n8oDPaaana2Br4
	aNqVO4EUOG3DRJvbesksXg9htw931Zf10YqI5fjc0rTLRJ4PyticzX4NRjzDU2xJurYkK2kDx/v4D
	Zt9XRzdX/hMiELKazqvKIwpNOc0YXC5JdBCgZv2jn/zUXIwagQDSEgQ5iEyKMv10Am/MCWhMFBFe/
	X3wnXusNH+Jt4bxTSl25IuZazQjH1o+ptJKY/5xa7dbghfor39JZg1EJUTWvmeEvUINfAf1eXpBUk
	7Ci7IY8Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7i2f-0000000AscZ-2xL0;
	Sat, 11 Oct 2025 22:26:21 +0000
Message-ID: <c0a5bfb6-4976-45e3-a936-b7a914bbe5a5@infradead.org>
Date: Sat, 11 Oct 2025 15:26:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: fix == bashism in kernel-chktaint
From: Randy Dunlap <rdunlap@infradead.org>
To: Kevin Locke <kevin@kevinlocke.name>, Jonathan Corbet <corbet@lwn.net>,
 Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-kernel@vger.kernel.org
References: <1531d0cd452f1870e1703c263b11d718c46b54bb.1760216665.git.kevin@kevinlocke.name>
 <f5949227-7bd3-4fd0-b873-e79d0768a1be@infradead.org>
Content-Language: en-US
In-Reply-To: <f5949227-7bd3-4fd0-b873-e79d0768a1be@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/25 3:07 PM, Randy Dunlap wrote:
> 
> 
> On 10/11/25 2:04 PM, Kevin Locke wrote:
>> When /bin/sh is a shell other than bash, invoking kernel-chktaint with
>> at least one argument may produce error messages such as the following
>> (produced by [dash] with argument 1024):
>>
>>     ./kernel-chktaint: 22: [: 1024x: unexpected operator
>>     ./kernel-chktaint: 22: [: 1024x: unexpected operator
>>
>> This occurs because the == operator is not specified for [test in POSIX]
>> and is not supported by all shells, as noted by shellcheck [SC3014].
>>
>> To fix the issue and avoid the error message, replace == with =.
>>
>> [dash]: https://git.kernel.org/pub/scm/utils/dash/dash.git
>> [test in POSIX]: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/test.html
>> [SC3014]: https://www.shellcheck.net/wiki/SC3014
>>
>> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

and
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> Thanks.
> 
>> ---
>>  tools/debugging/kernel-chktaint | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
>> index e7da0909d0970..051608a63d9f1 100755
>> --- a/tools/debugging/kernel-chktaint
>> +++ b/tools/debugging/kernel-chktaint
>> @@ -19,7 +19,7 @@ EOF
>>  }
>>  
>>  if [ "$1"x != "x" ]; then
>> -	if  [ "$1"x == "--helpx" ] || [ "$1"x == "-hx" ] ; then
>> +	if  [ "$1"x = "--helpx" ] || [ "$1"x = "-hx" ] ; then
>>  		usage
>>  		exit 1
>>  	elif  [ $1 -ge 0 ] 2>/dev/null ; then
> 

-- 
~Randy

