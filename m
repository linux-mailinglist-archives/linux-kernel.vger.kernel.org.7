Return-Path: <linux-kernel+bounces-808590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC489B501FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8BB1723F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47BD32CF71;
	Tue,  9 Sep 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JJDVe/ID"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE50335BDA;
	Tue,  9 Sep 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433431; cv=none; b=ZgjgrEmG2XWyNUGvN+rINLh40/F/zagHmFcYxDHrhgjots5QnOJMpwrWsMetG3bOkroEL5B1EvCb0RNTdOavLtBD/lYRm8AMAwAAZG5ep4MwJEMiInQQ1avOx4x/7C+F2KCdCmAKetf3LM+/qtP9CzWy/hkRXZMbniQJjt5ZhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433431; c=relaxed/simple;
	bh=gQDCBXANgMNTl28QYN1OVktCRSXH2BFS0kru/ROqykI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q+QusUlRN8Kro2cxPNpbl8xGO3EDcDfZAk6tO5uXXlaeuwix7yxaVJsI1YrrgEK2JYG7m7aj5+JDolMDnoDQILzom3VO/RkD4GYsAb8Po7XuM4+qemP2W5zqebo2Kr/qYOdQjFWd9L1OpnLWKHs7J5mh4PvXIAt2pE/bxv1UYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JJDVe/ID; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=fTYn/oQZldHMfiyz8++x/UhKa9E2oq3CZ7zKjnJIOzU=; b=JJDVe/IDsacUH2TI0ynxfmL5Nc
	BP6TIHEpZX8GOICN07rEhyJfWm2sVBzriTc13LvyHXVAKSkgkbxaGcgJhg/8Ma7i1SqVYOJPiW3S4
	G5mpTDo77m22FRtxcHe7KgKzFJExsVAoD6Hec89WJ/hHi5W/rbGPzBLGACOFUs/snzTmqQCPpknTv
	o9Tnff79ouPyVYQlkRgefuNeo+R0dD2lOx4K49HZqW4XrDp9z8kv8IQcEgVXFixhBAyMe0q4XhuAc
	NRFD0jF5FQOO4bTeON/ON2v6QS4XUN5kR+R/yioo9+4OMRk16l4+FFUezRZF7I1e/yX2ufopgyB1M
	RAwXr36Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw0iR-00000008Lum-3D6o;
	Tue, 09 Sep 2025 15:57:07 +0000
Message-ID: <c26160b1-f1fb-41d3-a8fe-acf589ad9f7f@infradead.org>
Date: Tue, 9 Sep 2025 08:57:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
From: Randy Dunlap <rdunlap@infradead.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
 <d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
Content-Language: en-US
In-Reply-To: <d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

On 9/9/25 12:27 AM, Randy Dunlap wrote:
> Hi Mauro,
> 
> I have a few patch nits below, then some testing info.
> 
> 
> On 9/7/25 9:22 AM, Mauro Carvalho Chehab wrote:
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
>> ---
>>  scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
>>  scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
>>  2 files changed, 55 insertions(+), 1 deletion(-)
>>


> So, I grabbed some global data from 6-8 places in the kernel and put them intoinit/kdoc-globals-test.c. Then I modified Documentation/core-api/kernel-api.rst
> like this at the end of that file:
> 
> +
> +Kernel Globals
> +==========================
> +
> +.. kernel-doc:: init/kdoc-globals-test.c
> +   :identifiers:
> 
> The html output says
> "Kernel Globals"
> but nothing else.
> 
> My test files are attached. I dumbed down (simplified) a few
> of the globals from fancy types to just unsigned long, but that
> didn't help the output results any.
> 
> What's happening?
> Thanks.
> 

My problems here could be from a patch mis-merge.
Maybe your patch was against a tree or previous patches that I don't have.

You could supply an updated patch or I can just wait until all
the patches are synchronized for further testing.
Or you could just take my sample and keep testing it.

Thanks.

-- 
~Randy


