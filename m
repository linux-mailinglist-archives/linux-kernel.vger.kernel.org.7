Return-Path: <linux-kernel+bounces-899667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED4C58A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324544A095C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDC35971D;
	Thu, 13 Nov 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nrVDHH0J"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5762F5A0C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047942; cv=none; b=Ag6eGG2Kazc8hP+uNs7sthZVf1zt9xCaZnggis4BoNdQv6RICS8/tZwu8sZWTmwnvLYVO6bIfAFWBDACfe3bdmI3PGhlv24f7gK4fVqKARTVyhRIjwH9OfqrqlYmSWYGlQJEpxWMnplNAyd5kA0WrwXldnsp0yxxF4346J5K8VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047942; c=relaxed/simple;
	bh=+hzEjqiEbKk7CqzqS4tCem+ocMq5Ym5NmnnnbaFZuOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXHhOX7Gccz++sDmOyNUPC2l0uqq7k+dJAAH6l97nohgzt4A791EEmv8XSHUwIMlj/n3xYHFRUn/3Q68fU/LN2yNiQnKmLAAnNtJF5llYHguTdZy6oCE1bMFgPA0yAJgO8yne7+WbP7klqom0dAhrbHTURzpdZwYMQUZ1IMZAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nrVDHH0J; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f415ff1-834e-4544-a093-dcb4fd25d5c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763047937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbfnACF5OTG+C22l5VOv6/tW6U39u4VS9uuFSVlj28M=;
	b=nrVDHH0JXKy1x6XMICO/SM2U1WPndKvVMdCPswy7SV0uuTgfLfRi/4fyvij+HH7K3TlbB/
	7voKQ8Ftz5yo+WcxScG5yq+NMeZUoaT7k5I4zN6B2qwKf13hZyoiEZUehJ5OeGSm3RFg9D
	ABZhBX2EsB9sUb5v9N5hee8lF7qwnxE=
Date: Thu, 13 Nov 2025 10:32:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
 <mafs0ecreontu.fsf@kernel.org>
 <4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
 <mafs05xcpo9sz.fsf@kernel.org>
 <26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
 <mafs0ikgnn07u.fsf@kernel.org>
 <d00d42ce-4262-4736-8c73-5d2544e86d33@linux.dev>
 <33cbbac1-c247-4644-b555-998eea6e8305@linaro.org>
 <92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev> <871pm3iegf.fsf@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <871pm3iegf.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/12/25 08:10, Miquel Raynal wrote:
> Hello Sean,
> 
>> # flash_lock -u /dev/mtd/by-name/spi0.1
>> # flash_lock -i /dev/mtd/by-name/spi0.1
>> Device: /dev/mtd/by-name/spi0.1
>> Start: 0
>> Len: 0x8000000
>> Lock status: unlocked
>> Return code: 0
>> # test() {
>>> mtd=/dev/mtd/by-name/$1
>>> start=$(($2 * 64 * 1024))
>>> size=$(($3 * 64 * 1024))
>>> dd if=/dev/urandom of=$1 bs=64k count=$3 status=none && \
>>> mtd_debug erase $mtd $start $size && \
>>> mtd_debug write $mtd $start $size $1 && \
>>> dd if=$mtd bs=64k skip=$2 count=$3 status=none | sha256sum $1 - && \
>>> rm $1
>>> }
> 
> I am also working on locking these days, have you already started
> writing extra SPI NOR Documentation/process based on this thread?

I haven't started writing anything.

> I am also trying to clarify what is expected and what the API somehow
> does, as it was not fully clear for me at first sight.

I agree, as you could probably have figured out.

>> # flash_lock -u /dev/mtd/by-name/spi0.1
>> # test spi0.1 64
>> 83a8dc6125ec9672d18f7f18f92e16f867354dbe8e2f3b0aca52b9d0ad7d8ffe  spi0.1
>> 83a8dc6125ec9672d18f7f18f92e16f867354dbe8e2f3b0aca52b9d0ad7d8ffe  -
>> # flash_lock -l /dev/mtd/by-name/spi0.1 $((1024 * 64 * 1024)) 1024
>> # flash_lock -i /dev/mtd/by-name/spi0.1 
>> Device: /dev/mtd/by-name/spi0.1
>> Start: 0
>> Len: 0x8000000
>> Lock status: unlocked <<<< Wrong!
> 
> This isn't wrong, even though at a first glance the output is
> misleading. The API apparently does not gives you all the
> locked/unlocked sectors, it is way more basic than that: it tells you
> whether the full range you asked for is indeed locked.

Yeah, I figured that out eventually.

Actually, the most surprising thing to me is that the lock/unlock APIs
are not incremental. That is, if I have a flash of 8 seconds, and
sectors 0-3 are locked and I lock sectors 0-1, it will say "well,
sectors 2-3 should be unlocked now, but we're not allowed to unlock
during a lock operation" and fail to lock. I would have expected it to
say "sectors 0-1 are already locked so we don't need to do anything".
The only way to go from sectors 0-3 to 0-1 being locked is to issue an
*unlock* on sectors 2-7.

Conversely, if what you wanted to do was ensure sectors 2-3 were
unlocked, you can't do the naive thing and unlock sectors 2-3, since
that will try to lock sectors 0-1 and 4-7, the latter being disallowed
in an unlock operation. So you actually have to unlock sectors 2-7.

And knowing what to do is complicated by ISLOCKED only returning a
boolean instead of just telling userspace what sectors are locked (which
must be a small finite set of ranges (usually one) on all flashes I'm
familiar with).

> When you run "# flash_lock -i /dev/mtd/by-name/spi0.1", you privide no
> start/length values to the command. Hence, the defaults are picked: the
> entire device is considered for the check. The tool asks the kernel
> whether the range 0-0x7ffffff is *fully* locked. Answer is no, it is not
> fully locked.
> 
> In the kernel there are two helpers for that, and they won't give you
> opposite results all the time:
> - is locked:
>     - returns true if the given range is fully locked
>     - returns false otherwise
> - is unlocked:
>     - returns yes if the given range is fully unlocked
>     - returns false otherwise
> 
> So if you want the tool to tell you "yes", you should instead use the
> exact range you locked (1024-2047) or any subset of it.
> 
> Thanks, Miquèl

