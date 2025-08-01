Return-Path: <linux-kernel+bounces-753409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625CDB1827C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0936189E2F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85952571AC;
	Fri,  1 Aug 2025 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q53t7ZXP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0A11CA0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055104; cv=none; b=nfIcjlzlZpGjaVOGv+AE6aVRVhZqY6Hb/CUQGaZkFs9K4CNH+Nbg/qqrlqZpaYey8Kv7kdqNkxMe4JV80+GBBSwE3HxqcUCitnBve8a7FrhuNpr7cUsVcLHtUXlrmfTfegdH0Sw0roklO3VD8V4mU6KNtr1gpFemSf5G4UP0qzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055104; c=relaxed/simple;
	bh=f/o4P+Pp2v8VlkSNt1F64znTUTJCoWMXEp6OgqEsXCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzTniftCZHOizq1ouATsACxq2od8bzDzMoXo7xI02ryWNDtAeWqzQr7rW9ZDKzd5145FSn44hVnDhm5zt5oG0pvD6BDP9RDZyLC6U/Jvf5eVHNVNqtJNZmpKjnl+6NFUdkLhGB+Z9ghlyMzLLe+ogXpLUx6XVCtkk5mFn7vyRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q53t7ZXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD447C4CEE7;
	Fri,  1 Aug 2025 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754055103;
	bh=f/o4P+Pp2v8VlkSNt1F64znTUTJCoWMXEp6OgqEsXCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q53t7ZXPKwnpd85dORAB/aspsKSr4JpUa2IYNWPtySLgFJKk5Cu/Rr2aUmAWGW8HN
	 XtSo9op9M5fJBWpR/hdKPYAQoIjJLYgLrtIJ0K/SzPNH7+b/d2HMsq/1X/8hDQZJym
	 GmFONcP4wXe51MzQoVx4YBiSI5cATVXYHlR3gch4UevjzpwtbyTpRHuAPsxAlB7Gu2
	 peD0DuOLriBJvYhfdHZ0e2dINLyCzVBINvJA4P3quMb3UV8JXxcuSnt+pBStbX4EC/
	 hqPeDF0CjJm1uDb2bcmHNEXsBZKXIdhJd+Slk75UsMlXAB31YRXtKnDBlJXKcIIJLK
	 bbhrotRAIGGGw==
Message-ID: <941cc16a-7599-4ae2-9d2b-2ebb4728196e@kernel.org>
Date: Fri, 1 Aug 2025 22:31:40 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] extcon next for 6.17
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
References: <15ca3763-45a5-40af-93a8-449a9f1f33a9@kernel.org>
 <2025072609-knapsack-drinking-c979@gregkh>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <2025072609-knapsack-drinking-c979@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

25. 7. 26. 15:53에 Greg Kroah-Hartman 이(가) 쓴 글:
> On Sat, Jul 26, 2025 at 09:34:47AM +0900, Chanwoo Choi wrote:
>> Dear Greg,
>>
>> This is extcon-next pull request. I add detailed description of
>> this pull request on below. Please pull extcon with following updates.
>>
>> Best Regards,
>> Chanwoo Choi
>>
>>
>> The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:
>>
>>   Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.17
>>
>> for you to fetch changes up to 5f09caafc652bcee7a5247e40dd34d1de1ad7d7f:
>>
>>   extcon: fsa9480: Avoid buffer overflow in fsa9480_handle_change() (2025-07-19 12:39:13 +0900)
> 
> My tree is closed now, sorry.  Can you break this up into different pull
> requests after -rc1 is out, one for bugfixes, and one for new features
> for 6.18-rc1?


I'm sorry for late pull request. There are no new feature of extcon core.
This pull request includes the new extcon driver.

I'll send the separate pull request according to your comment.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


