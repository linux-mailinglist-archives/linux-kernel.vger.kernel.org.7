Return-Path: <linux-kernel+bounces-842019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF2BB8CA3
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 13:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B682189F631
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C4426CE0A;
	Sat,  4 Oct 2025 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="OfXButu/"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E8DF72;
	Sat,  4 Oct 2025 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759576343; cv=none; b=jGsEFyEu4wOV1GHL9oSe8WkDdSvbCj0/eoH/PB7cwKEyvLH6QUJX421ma0wTMK0IK1S+vnMx5y1evHuJTWNb+v9IxSgrd0iTotISLm0Q5cws7BZJcyjCP6KS8Wurj6thowANpW+RWZ6PrNAhXde2Q226m6TygwujXr+Y2YN49iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759576343; c=relaxed/simple;
	bh=b+vW8XmJHwvEkqXrQD81vA2ZXuY4RouSMS4t19KM8pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uahb2NVS4XBqjfAOxH8sQW95qIsOJPmtGr3DL8FY1PujVv8cpBmB7lihsa2Cd2cFBH2fOEsOio4ZtwKQo3Wx8+q9f3QK8QxS6IjWII+SBJgD0rRe+5tLC0zbKx+pKQhQaHD3X6R1l1QhUe/zf1hRATauo/PDxnaHQb9cl5M4j3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=OfXButu/; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KCaVhDOz2Z3mf9DFpWVfqYcdgkfbhEgEHiXYwCHCvyw=; t=1759576341;
	x=1760008341; b=OfXButu/S6vwwaeLtWdPDjPFaHhnW4NHu04aD4zYW/j38QjAoojhLzKpo5JpB
	EDZw56MHUt/V15J1QjTzMxusnJu/D4NZPscBZZ1RQrAibgonFsVQxAShMMZ0YjStWhD+EFQUFbjxW
	5bmCgIxAw4oJ73lyDZfuBkJAwdkDqrremSSGpV/yZXQIOwMQgVAbv4KmXh0JMGGb1Are2SCRxTc7P
	+KHTC6do/8eIlKtnp/luCdPwoqIJRoJkIgvhVsW5fzRNM01PsrJnvgzZeDSWIi8HSmN+wrBAeS7Iu
	0tzu/hlML9wYZyrIMk6GnEj8mzVGPT0X6wpmq4YtrqHMf0mrVQ==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1v50BR-002cCP-0J;
	Sat, 04 Oct 2025 13:12:13 +0200
Message-ID: <d9ae2341-b385-45f4-9359-550d1118efb7@leemhuis.info>
Date: Sat, 4 Oct 2025 13:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] Memory allocation errors and system crashing due to buggy
 disk cache/inode allocations by ntfs3 kernel module.
To: craftfever@tutamail.com, Ntfs3 <ntfs3@lists.linux.dev>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Regressions <regressions@lists.linux.dev>
Cc: Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>
References: <OaiQgS3--F-9@tutamail.com> <Oait04j--F-9@tutamail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <Oait04j--F-9@tutamail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1759576341;3c7a4580;
X-HE-SMSGID: 1v50BR-002cCP-0J



On 10/4/25 13:03, craftfever@tutamail.com wrote:
> 
> Oct 4, 2025, 11:55 by craftfever@tutamail.com:
> 
>> I'm expecting serious bug when writing large amount of files to
>> NTFS hard drive, shortly after memory allocation errors and system
>> crash occurs/ Firstly, I thought, than this is bug in linux kernel
>> itself, somewhat disk cache allocation error, but when I tested
>> same operations on ext4 drive or using NTFS-3G module, bug is not
>> present.
>> 
> To reproduce a bug, try cloning two big Git repositories to an
> external NTFS drive mounted with ntfs3 module.
Thx for the report.

What kernel version are your using?

You CCed the regression list, so I assume this used to work, which leads
to two more questions: What was the last version where this works? Could
you bisect?

Ciao, Thorsten

