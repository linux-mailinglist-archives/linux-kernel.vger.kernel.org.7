Return-Path: <linux-kernel+bounces-749655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F29BB15116
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622743AD2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42FB218AC1;
	Tue, 29 Jul 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R+l+A/wx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF30D1862A;
	Tue, 29 Jul 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805828; cv=none; b=JW+KKGCyreFbtWlqci2tCMXsj7dhAWPGrpd9eLMVXQyQSf3syPvW5X/rctoLLnNH0vhyNR/RRCPwsFbTFHtv8HHTVk63+QIS+LN1LIlSrshto70fLHfoOVVN77cQu1hoPkleTVrK8rRaQwuwJGYL3PYrBkYkNOPWWo4cDwNAwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805828; c=relaxed/simple;
	bh=v4tXSbGPU34ajbqF88SFay1xYtZbt8bLpQiIJMjph0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNoD5KWGfPF0UP1XYYzsWOu7iQBPZqND8MAcaAaegSWy+t8spdZ+5iydX5UBI7GOx95xN2Nq15slLArSW+PObZHouI1SsHUpzlLTeTfs2QivxUGYttcVJKmDM/huwhZqD/uWH+LqwNCWVbLp/0pbXnMcS3TmoaXybCVijYcTv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R+l+A/wx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XK7nWoA8y2onrTMcVrnzuh8RM9CdfoCZ10jEp1+6cc0=; b=R+l+A/wxPUKElCxWSy8NEydiaS
	2FR0OiUgW4jIfNgEfpbkBqAOwLIusLF0PfVOgrW76jbmOvaMGfuMJHcB64S5PTBOwQPg0+j1PNyrc
	LLMaHYAgV/uIODIqvUTWgiNoMZfAJ3K9qui8pGz5jHF/CzqAea/yTFe522ss3MlvdCuHSLkniekqZ
	hnEyDsXz9MESdMWGHiGvtmQebwyVkSr8CM8O72bjIWxoePrwJprwp2rm15zyutL1rIUArMG25QuHK
	qMVdcrSbMHq6w5QcjncpNm9vNGgDedo5gA+aD5mYwyYkZKdYGqQyCCwxC72gH6N7Uumvf4BXtSMAM
	NZlNzg2Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugn0g-0000000HFVG-0dD3;
	Tue, 29 Jul 2025 16:17:02 +0000
Message-ID: <aee17767-b8be-42ff-b00c-92f9aa46a521@infradead.org>
Date: Tue, 29 Jul 2025 09:17:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: tracing: Add documentation about eprobes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Namhyung Kim
 <namhyung@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20250728171522.7d54e116@batman.local.home>
 <f6cd51e6-c025-4182-8df8-a621379af6bf@infradead.org>
 <20250729115021.135bca64@batman.local.home>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250729115021.135bca64@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


>>> +From the source code, the sys_openat() has:
>>> +::
>>> +
>>> + int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
>>> + {
>>> +	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
>>> + }
>>> +
>>> +The path is the second parameter, and that is what is wanted.  
>>
>> s/wanted/want/
> 
> Really? That sounds funny to me:
> 
>    The path is the second parameter and that is what is want.
> 
> ??

Yeah, I don't know how I did that. Sorry.

-- 
~Randy


