Return-Path: <linux-kernel+bounces-891832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A1FC439E4
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602B9188850F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB4A241114;
	Sun,  9 Nov 2025 07:44:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23855193077
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762674241; cv=none; b=f2Fy8WI4HOLj56cGiRmjZA1kTkaJMTDg6hLwj3+uNk8Hs1os2SPWCZ2wTcV5fftLQCYYZYgvKZHQXu0cbxx43OfiwvtEfuWZxLr344BTDmv9bNSMnaGW5joN9ucz4lHBRg8pLKpnl0li3LmYs5LDUWHg8p8tcQricRnZEbv6m1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762674241; c=relaxed/simple;
	bh=0RMZ6w5340ko0HtUaBaDa9k+tHExkJVSmfrAY75w7Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S+CvlrxiJPH/RwvpZ20C6jY/hRYSsTEo0u0/wPQEmtg/kvRmeyLX75S9FV0FQMvg+wcviXU6IAqMvQHRKYFira+F53ako4zKZeoBsbNsDXaDufAYG/xPPTtq7d1avCxlIVN1uiBrm/m9qmf6yYi1HAHBIo/qufmofm806ZOhbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2169B2F;
	Sat,  8 Nov 2025 23:43:44 -0800 (PST)
Received: from [10.164.11.1] (MacBook-Pro.blr.arm.com [10.164.11.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7610A3F63F;
	Sat,  8 Nov 2025 23:43:50 -0800 (PST)
Message-ID: <cb17f29e-b45a-4275-ab2b-1443d909d944@arm.com>
Date: Sun, 9 Nov 2025 13:13:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Guidance on contributing to the MM subsystem and finding
 tasks
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251109113741.102337-1-swarajgaikwad1925@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251109113741.102337-1-swarajgaikwad1925@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/11/25 5:07 pm, Swaraj Gaikwad wrote:
> Hi all,
> I’ve been following the MM subsystem for a while and have submitted a few
> small patches (mostly cleanups and basic fixes).I’d really like to become
> more involved and contribute to meaningful memory management work, but I’m
> having some trouble figuring out how to identify useful areas to work on.
>
> I have also looked at some TODOs in the mm/ code and submitted a patch for
> one of them. I’ve tried looking into syzbot reports as well, but often by
> the time I finish understanding the issue, someone else has already sent a
> fix. I’d still like to learn from such debugging efforts, but it would be
> great to find areas where I can make steady progress and contribute patches
> that are actually helpful.
>
> Could someone please share some guidance or suggestions on:
>    - How to find open problems or areas that need help in MM?
>    - Any advice for someone trying to move from small fixes toward more
>      substantial contributions?
>    - And if possible, could you suggest a few small or medium tasks that are
>      suitable for new contributors to the MM subsystem, the kind of things that
>      would be genuinely helpful and likely to be accepted?
>
> I’d really appreciate any pointers or direction.
> Thanks for your time and for maintaining this amazing subsystem.
>
> Best regards,
> Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
>
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>

Hello Swaraj!

I will recommend to first understand userspace interaction with the kernel - mm selftests
are a great way to understand that. Personally, I had started by looking at
tools/testing/selftests/mm/virtual_address_range.c. I played with how the VMAs are getting
created and displayed in /proc/self/maps, and when they get exhausted, what is the gap
between the VMAs (in fact, it took me some time to figure out that the ranges getting
displayed in /proc/self/maps are in fact exactly the VMAs!). This forced me to look
into mm/mmap.c (now also split into mm/vma.c) and try figuring out how we find a VMA and
map it. Eventually reading userspace code sent me looking for the corresponding kernel code.

>

