Return-Path: <linux-kernel+bounces-807252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447BFB4A21E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57EB4E2BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6ED3002B7;
	Tue,  9 Sep 2025 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ITP/0th2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C1302740;
	Tue,  9 Sep 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398936; cv=none; b=afCCiMAEq7QCnHLdYzg3djGE+6e0HmDB4l515//WJJ5EkP3aznpXVK09e1RXTF95fbBq2KYuvbZC386suOiZZuFLi04G0t1bmTWsvR7ezYWAaWW+oQrfnNU8QEzHVrYm7v2wL9nyGF9zgOlyvwD56o8k2juKMOrTPXi+P0W3pBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398936; c=relaxed/simple;
	bh=4rkRBoLZgIEIaCabO4h6JlNqQyO0fcCJiekOwq/2hYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nK4p7/3FC1w+e51MXFcL87muNv7ahtubfb32bCai4nUUIvlNOiPidXF/QmfaBbI+6WNEBrLssrrkh3SXRJEcxviotFGINs++8GmWfBBYZ/aAnONZPqEkovF6Gu8KquyCi1ILxZ8xtzi43LUzvWStvImG1W9IaeKQSIq18/Nbbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ITP/0th2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FTJ7pzF/8gSabaIgTkVVYqrhoN2BcRC0CXQTEboR5Pw=; b=ITP/0th2/yHWIFcx7Suvj3zDPL
	CGKKz80cpOwEO4NegOQf/Sh5iXBer6aA8iDafp4PhZeYsZ1WUQF9vRNe0CCgsLsHSyEZ0ndzxk1Sn
	isWsk2CNlftMx15LKN7YC92AzSRRTk6EcZghinATDM7dbLDaVrxu8lqUp5rsmPwgw+ps7gW0H5NT9
	V2R36H1KjibDMAUwoZQwMflo+4JQFA+Rve1MYEN+ID3rsQhbCZO7MLwsOmsjeSxmywxHKl7hmUab9
	aNQtbAI+KuCGbW+OJjXt0XX8MEySnidtglTEiakNdJd5w8Ees7gQ0ToogDxtf6ka8QQCeGKsxdNPz
	kbb1hAFA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvrk5-00000004fJy-25oG;
	Tue, 09 Sep 2025 06:22:13 +0000
Message-ID: <5cec20da-b8a6-4db9-ab4f-78ec6b327d28@infradead.org>
Date: Mon, 8 Sep 2025 23:22:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
 <20250907233447.0cbe9954@foz.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250907233447.0cbe9954@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/25 2:34 PM, Mauro Carvalho Chehab wrote:
> Em Sun,  7 Sep 2025 18:22:22 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
>> Specially on kAPI, sometimes it is desirable to be able to
>> describe global variables that are part of kAPI.
>>
>> Documenting vars with Sphinx is simple, as we don't need
>> to parse a data struct. All we need is the variable
>> declaration and use natice C domain ::c:var: to format it
>> for us.
>>
>> Add support for it.
>>
>> Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
>> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Btw, this is still at RFC level, as, for the final version we need:
> 
> - to document this new kernel-doc feature;

Yes, I thought of that one.

> - to suppress (or keep) the end ";";

I'll need to see it, but I expect I would prefer to suppress it.

> - do some cleanups/improvements at the regex to ensure that it is generic
>   enough. For instance, the way it was defineded, it doesn't handle yet
>   variables with assigned values like:
> 	extern int foo = 5;
> - if it has a default non-zero value, should it be documented or not,
>   and, if so, how;

I think I came up with some examples (test cases) like these without even
knowing that you had singled them out as possible issues.

> - to decide if we add "extern" to all outputs, to none of them or if we
>   just follow what is at the documented declaration (the current
>   implementation does the latter;

Follow what is documented for now (as you have it).

> - to decide weather use "global"/"var" or something else.

Just stick with "global". It's fine.

> Also, it would be interesting to have a real case where we want
> to document kAPI variables.
> 
> Randy,
> 
> if you have some real case examples, perhaps you could pick this patch
> and add on a patch series after taking the above into consideration.

I just searched for some real case examples and came up with around 6 from
various source files. I put them into one source file that I will include
in a Documentation/ .rst file for testing and let you know how that goes.

Sorry for the delay. I've had some other things going on.

Thanks for working on the feature.

-- 
~Randy


