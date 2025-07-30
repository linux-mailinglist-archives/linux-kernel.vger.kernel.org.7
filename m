Return-Path: <linux-kernel+bounces-750201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478BB1588C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614253BBA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0561DC9B3;
	Wed, 30 Jul 2025 05:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuypJD6l"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F93FE4;
	Wed, 30 Jul 2025 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753854358; cv=none; b=sCBuZQuOnMQefmVbdCcI1UeIWO5vVM/eIpA+5uEhGMi0pYcKLcpOxhGGTJ9Pf73jWQcdLcK/ZRBnSKLROLpabr3GIA+85W1IdbA1qala1bDWpW6fuR7NG8OEGsoFidl1nMT6J6Uy3uD0d+plikk2AXWQqdWDGILAYsfDsB1yKWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753854358; c=relaxed/simple;
	bh=KZoZK1rcYkkxyHx5ObLMMN4blyc7hLLmxQ5+q0sGkso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNNT6Vf4K+QgXJTHhx4p3UsYYAYbtVjn5ydYS3xTdIB8Uxh5FUc6ys5TtW7OlwZ6USwXAv0Uml0U7dBLuC2pCH/9Zybial0pFccufrf52vL1NdyB3N4ycBiFwl/Tm+8dcd96ALXR+o7K5yT7Kpw0dw6JEgM34EzDv4dgPFqR8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuypJD6l; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b34a71d9208so4870521a12.3;
        Tue, 29 Jul 2025 22:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753854357; x=1754459157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYJ5UsLhukcdLpdN5YPrMM3j0pbYHwc96itkt9ufV9U=;
        b=GuypJD6lUhDn2/856miZmYjEUJEVA+jCkWd8cx6N1ihfLHPKeg52xhrDt1YixwmzSN
         ziOo8ERHoiOvDrTX6Tw5h4Yf7+nkMTC4vboZG4qsXboahv5ehuwNSQElPVFJXIlDN4fU
         x4Rmlnu5GkIdTQSdPdkeA5fCX/80p1bO4/+f+vofc69zceJwPa7cFspjjhDWJAlbmrid
         a5gO18M6GxiII0J/b8BAXlL3PptJfi7/MAWGUbfjf+8f5qzT5hfVH+mVEx6w9xJ4Jfuz
         GUXSEmyq8ZhiaRv6EOEFHeEHXuo34Ga2pELsIvEq7NpAQBtMxNVDjc9JZW56pi0lcqab
         sNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753854357; x=1754459157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYJ5UsLhukcdLpdN5YPrMM3j0pbYHwc96itkt9ufV9U=;
        b=UXW1kFDIlHOSqrsjy6p8W4rf2Hgh3KyxNtX4sE1k6UWnfGXhvFOCf5IduFJOp9nTxg
         dg2HqQxNtveuT0nIfYXMi+B9UdjWcN43ko8VyyRHZTJBCIKtGSDOyKoISqsCzoShMmCH
         sRVp32ToiuvO71ft/6E+Bcrpd3K98poJ3KQjmcvOzfuwWb0m3KEbplbWalM42wHFx7X7
         WDNGh3T4a2AzBIKoJJvIxGi1pcm+IBeFo4LZD47HcuXosStjLGiKc8SdRjpfPZwE2fBC
         nIVx0cC+fSriNz2hNROpQgL2xJQMfZHtdnOhEG7qCAY/lweg7HjP0negLkd/EghjmE7e
         r2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKufiXOuVJkIq3gp/4G5aphp1Kd0ezDep/Oqs77vFBnzwVAwlcYHiBv3eXE+G8p+PqK5yJzCnpS8Zpjvv8@vger.kernel.org, AJvYcCXi05yUNVq4ZUlJFyEH8iae8drovxggARjHtpb6kDevRdBjCw+gt6LgkUyoAXC3DiNnBXxNSLP054M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFUdz3Qix2AzIRvynbBNYxzOd1MZVp1N9RjUVf8SA+dxFqDki
	WFbYC9qeYDtxLnRUqcL8QMeRSo56FQtxHRmdj5sZ7KJKWAfCpct5KpPYcaTEggQo
X-Gm-Gg: ASbGncsxcaq5A0A7jWHog+QsWzGrOyOzM7NI/CfXhijU4x0UOA6+5IYUuyL6rmGEBUa
	g2ZYw5F4Gc0bPKGCmYrLQvoe3SWyBScfdxgJjR4j6Jv0rThKSF4DWw19nHg5djkoyIJnuYeZcmz
	fCqZZGC60/dj+R1wxUSe+iC/uhUI1P7gehm+RqO8kJfjSx6BFmXtdMkimZo2IiSu6P+3VS6HySx
	euRerTXCCV1Jfxx4jRCjPCGi8lQpPBzsr6gPIzGKTQ2+k6kMgqItaM3iPCf56e9y1KwFFbq5dr6
	MobFT8OzB/54RtrXGfTcnuThBaCUo+t5qKPZBSoMMQtu1TKZL1Lr+t4tcNGlddVG0HBkeAxRWQc
	eSwE/+D48wgQ60wR5wbPPtVQneztOfA==
X-Google-Smtp-Source: AGHT+IF9yBjkayx2wuj6T6s+spuO+R1Oc6LEEfBfGn7Z6tb1KtGUScNknnweSaF7hUDHVQVtYL24Ug==
X-Received: by 2002:a17:90b:4c49:b0:31e:eff1:71a5 with SMTP id 98e67ed59e1d1-31f5de4a9ddmr2744703a91.29.1753854356563;
        Tue, 29 Jul 2025 22:45:56 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da6141sm902027a91.1.2025.07.29.22.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 22:45:55 -0700 (PDT)
Message-ID: <48bdb92f-799b-4f93-acde-fb68f4345edf@gmail.com>
Date: Wed, 30 Jul 2025 12:45:47 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Documentation for 6.17
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <87y0s81lqe.fsf@trenco.lwn.net> <aIl3j8klCw6xWyH3@archie.me>
 <aIl7DKlKcy7vauos@casper.infradead.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <aIl7DKlKcy7vauos@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 08:53, Matthew Wilcox wrote:
> On Wed, Jul 30, 2025 at 08:38:23AM +0700, Bagas Sanjaya wrote:
>> On Mon, Jul 28, 2025 at 07:35:53AM -0600, Jonathan Corbet wrote:
>>> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
>>>
>>>    Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://git.lwn.net/linux.git tags/docs-6.17
>>
>> Hi,
>>
>> It looks like this PR slips through the cracks (not merged yet?).
> 
> Patience.  Linus will pull this at some time during the merge window.
> Probably by the end of the first week.
> 
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

