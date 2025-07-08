Return-Path: <linux-kernel+bounces-721895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFBDAFCF30
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE4E7A943E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7BF2E041F;
	Tue,  8 Jul 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cGb/ayJ1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F62F84F;
	Tue,  8 Jul 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988500; cv=none; b=JsQEDY8uH93C/4SlMUd2XA3yInQHZP/ackp+Z/lKeB193e0TpUsMBDHLM7VqTFAdewY+hd4nCQPbng90qEnNcQ2jYbzq7BjJGxkOQb/nok+Ko2LNxYGZcPUxe4yQlu+NEFUeCKCmYIRqnji5HRJU9XRl9lzNDufo27sKxwQaPlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988500; c=relaxed/simple;
	bh=yOtDgsdu7wJC8UkbZQQSMT685bR0tLrVnl4BL88io7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVAttvGD9ATGPurfIoUjFrx8Az+NlC+kbiUFQW8dmTYYXfZc2Vlbl1emHYl1VTHD9f75X+S/k9pQ90l4EC6j0grWS/Nw7z0NbtUszfT1scgomfe0JOWsI+aMFRBSLF3MaD626ogzs3RSpeXhUKR58beVusfPZM75yEItS1gxobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cGb/ayJ1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=fZH6UnjkpeTO2OIVhXQ7FSseI1MHzZZnRXHu/XXggXk=; b=cGb/ayJ15an3n/Doh/RYA5ZVcr
	v8m8PrekhBnbL+cthGzZOfQa0di8WxNUqa0NHL+7cEo63vrbQWacj97d7GHZEB52/IV0IcCzzopy8
	SajvWmXt1NJu6/WCpgzim3kXwuU4IXtmHmcBkPTLetNZgjNaU3WptmUu6grjVcfPO47NljmsgKFMO
	SBJbITJPLF2XaTJVrvML1sNRF82M/DdumSzKCQOdKqA6Fhdc3iaNKtJqptrX2Ao2NRjMUppcFg+2p
	CzM2gKN0CjuzvqWEi1ulPACHucgvYNu32TsKrFETpcC+C7wVP7kMRcs9EUI03w8YDtAg6uWFHKsMj
	DVgk2rCg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZAEs-00000000CdK-3ASB;
	Tue, 08 Jul 2025 15:28:11 +0000
Message-ID: <afe702b9-ec02-4c58-81e3-b4c244553e20@infradead.org>
Date: Tue, 8 Jul 2025 08:28:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] docs: kdoc: various fixes for grammar, spelling,
 punctuation
To: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20250707050135.2660457-1-rdunlap@infradead.org>
 <87qzyq6aeh.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87qzyq6aeh.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/25 7:10 AM, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Correct grammar, spelling, and punctuation in comments, strings,
>> print messages, logs.
>>
>> Change two instances of two spaces between words to just one space.
>>
>> codespell was used to find misspelled words.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> ---
>>  scripts/lib/kdoc/kdoc_files.py  |    4 ++--
>>  scripts/lib/kdoc/kdoc_output.py |    8 ++++----
>>  scripts/lib/kdoc/kdoc_parser.py |   20 ++++++++++----------
>>  scripts/lib/kdoc/kdoc_re.py     |   24 ++++++++++++------------
>>  4 files changed, 28 insertions(+), 28 deletions(-)
> 
> kdoc is kind of a moving target at the moment, so this patch doesn't
> really even come close to applying.  Hold off for a bit, then regenerate
> against docs-next?

Sure, no problem.

-- 
~Randy


