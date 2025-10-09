Return-Path: <linux-kernel+bounces-847516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C795BCB14D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E12554EE118
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2B286438;
	Thu,  9 Oct 2025 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sXezy6hB"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA767286429
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760048865; cv=none; b=NsR5ZeM8YDEIX7yaoneqEFosbCf5hvry71EgHrt36PR1HKv1BNzVGZP3pxW7ifS3tg74Ipgdl1MZvn9i4fZFzh2nG/qjfhLD9trYkqL48Etau+YvtV1WdifvnmexZ65ZDnw4RRIArR3SWVomY8T+P5Ib8DsqKH1//QN8fCvsgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760048865; c=relaxed/simple;
	bh=Ddw8geg/UoAIpad9rvOiwEJhpdlCn2DWJvnODY5flGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZV3pHW/XGZ7AQNXghiWrl0EJaboX++k8zdH1ItVmDbeo/htNyHtWe44XjO4VFnPcQVTgNyvFP2FmVO5lYoqUbqSEJJ0h4FYJRVJv9mK2Fanny1KFozVOKPPisKBw6XfDMHWtyajXdgY21doQ1YHdaNftJvOkL+Od0jffL4kyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sXezy6hB; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760048860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ujFrv0xh6X+AbyNTLbcjgj4G3ocHTzbMroNDhXWDY4=;
	b=sXezy6hBbRnMlWwgmqKMDgcmyxqSI26fRtHU4IgRPvFablQO0951tAceAetGkJUT0tb8Sq
	mg6RqTMGjiFZadjCi6KCpOgvqxxm+p3hSRrBWD0SRhl+dO34DZKMupA2MljOLW/FEenoR9
	gQPLEXfVhMm6gQsgF84glRMboH+ea/Q=
Date: Thu, 9 Oct 2025 18:27:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Michael Walle <mwalle@kernel.org>, linux-mtd@lists.infradead.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
 <mafs0ecreontu.fsf@kernel.org>
 <4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
 <mafs05xcpo9sz.fsf@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <mafs05xcpo9sz.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/8/25 08:30, Pratyush Yadav wrote:
> On Tue, Oct 07 2025, Sean Anderson wrote:
> 
>> On 10/7/25 09:15, Pratyush Yadav wrote:
>>> On Mon, Oct 06 2025, Sean Anderson wrote:
>>> 
>>>> The datasheet for n25q00a shows that the status register has the same
>>>> layout as for n25q00, so use the same flags to enable locking support.
>>>> These flags should have been added back in commit 150ccc181588 ("mtd:
>>>> spi-nor: Enable locking for n25q128a11"), but they were removed by the
>>>> maintainer...
>>> 
>>> This makes it sound like the maintainer did something wrong, which is
>>> not true. Tudor had a good reason for removing them.
>>
>> I disagree. The maintainer used his position of authority to make the
>> submitter second-guess their correct patch.
> 
> Sean, you are being very combative over such a small issue. You must
> test your changes. This is one of the most basic principles in software
> engineering. It was perfectly reasonable from Tudor to push back on
> untested changes.
> 
> There is no abuse of "position of authority" here. When things break, we
> get to do the work of putting the pieces back together. So of course, we
> are reluctant to take things that increase this burden for us. Having
> contributors test their changes is the simplest of things we ask for to
> keep the quality bar.
> 
> Beyond that, I'd say that a little politeness goes a long way in life.
> Especially towards the people maintaining the software for free that you
> (or your employer) use. We are both wasting our energy on this debate.
> Please stop. Take a step back and think from the other side's
> perspective. And try to work _with_ people, not against them.
> 
>>
>> These flashes have capacity of greater than the 8 MiB that can be
>> protected using 3 BP bits. Micron (and ST before them?) addressed this
>> by adding a fourth BP bit. This is consistent across every flash in this
>> series, and is clearly documented in every datasheet. Defaulting to 3
>> bits is buggy behavior: we should assume flashes behave per their
>> datasheets until proven otherwise, especially for less-popular features
> 
> If I had a euro every time I found a bug in a datasheet, well, I would
> have enough money to at least buy a nice dinner. My point is, datasheets
> are not perfect. Only running on real hardware gets you the true
> picture.

Well, it's even *more* buggy to pretend that the datasheet doesn't exist
and just do whatever you please. Might as well reverse-engineer every
chip that comes across your desk from first principles with that
attitude.

The locking doesn't work on any of these flashes without these flags. If
you don't believe me you can try it yourself. The people who submitted
the original patches certainly didn't test it.

--Sean

