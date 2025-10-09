Return-Path: <linux-kernel+bounces-847549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C831ABCB2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 894C14E23C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD464281356;
	Thu,  9 Oct 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iotmq0jN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1020487E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760051240; cv=none; b=OR880ZmEHlBxlxRyTwzExAr3oFHkAy+BbB1nqEO7kzHjRpYX0aw3vkxQu/qbmG+wkXOzupAraFoyzEqm71uAlScovxh1Pkczpc04gr9EzIC1o1k5Sr5VCx58fLjYSCQvs8MX7wOZbplQeF4lTmZ5CC8F+gU0flLiXXi9k0pPeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760051240; c=relaxed/simple;
	bh=VuZi1lEE9TEqbZTVyJT1+D0UPh7TxkTdE3a65WkY4qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rrm78iqvBymr2uDrzFavLNANSGvABpJlQ8esMQ4gOkFs7+z8U6A/nxnYkNL9saD4HodJ7x+xHOBhGbX2wcQwIChqJ87dqitGR40LdHKzYoHIF/eivbcMfEM7f51tVzXkxymPhc2dhAcm//+HMwxhI+QTnF6VAk8k+QBrwkLD/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iotmq0jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F28C4CEE7;
	Thu,  9 Oct 2025 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760051239;
	bh=VuZi1lEE9TEqbZTVyJT1+D0UPh7TxkTdE3a65WkY4qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iotmq0jN10ENuY21u2jPC9E8n40czyk/FV/Fzc3Sc4zjSXdrbPb/Qmb1XRsG4HKKh
	 UJXbIziCKVcp3I3y41dERPSmgOtkQtgoeJsYcxc7YniX68WuVCyKRkXtnI28tXyXSU
	 /uFrcKWDPz15Ahlf5/RX5HpThGEdk3hRHXkXh8tl7kVTpmZ4fpoEqcz+ZhnSMcSjc9
	 qo+u2bQJfBU6OnlW6bZIedci4GHs5Qk4qvLTYm2Tibq+8IXIDq+1yHF1jW8OjnoTMZ
	 VmDJp+X2vCPueaRYsGSXtI888D/+5M/yqL6NxwTwN3GbU6f5Ua6Cq9UUBv82fJjO/N
	 U0mCTBiQKGUtA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Michael Walle <mwalle@kernel.org>,
  linux-mtd@lists.infradead.org,  Richard Weinberger <richard@nod.at>,
  linux-kernel@vger.kernel.org,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
In-Reply-To: <26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev> (Sean Anderson's
	message of "Thu, 9 Oct 2025 18:27:35 -0400")
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
	<mafs0ecreontu.fsf@kernel.org>
	<4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
	<mafs05xcpo9sz.fsf@kernel.org>
	<26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
Date: Fri, 10 Oct 2025 01:07:17 +0200
Message-ID: <mafs0ikgnn07u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 09 2025, Sean Anderson wrote:

> On 10/8/25 08:30, Pratyush Yadav wrote:
>> On Tue, Oct 07 2025, Sean Anderson wrote:
>> 
>>> On 10/7/25 09:15, Pratyush Yadav wrote:
>>>> On Mon, Oct 06 2025, Sean Anderson wrote:
>>>> 
>>>>> The datasheet for n25q00a shows that the status register has the same
>>>>> layout as for n25q00, so use the same flags to enable locking support.
>>>>> These flags should have been added back in commit 150ccc181588 ("mtd:
>>>>> spi-nor: Enable locking for n25q128a11"), but they were removed by the
>>>>> maintainer...
>>>> 
>>>> This makes it sound like the maintainer did something wrong, which is
>>>> not true. Tudor had a good reason for removing them.
>>>
>>> I disagree. The maintainer used his position of authority to make the
>>> submitter second-guess their correct patch.
>> 
>> Sean, you are being very combative over such a small issue. You must
>> test your changes. This is one of the most basic principles in software
>> engineering. It was perfectly reasonable from Tudor to push back on
>> untested changes.
>> 
>> There is no abuse of "position of authority" here. When things break, we
>> get to do the work of putting the pieces back together. So of course, we
>> are reluctant to take things that increase this burden for us. Having
>> contributors test their changes is the simplest of things we ask for to
>> keep the quality bar.
>> 
>> Beyond that, I'd say that a little politeness goes a long way in life.
>> Especially towards the people maintaining the software for free that you
>> (or your employer) use. We are both wasting our energy on this debate.
>> Please stop. Take a step back and think from the other side's
>> perspective. And try to work _with_ people, not against them.
>> 
>>>
>>> These flashes have capacity of greater than the 8 MiB that can be
>>> protected using 3 BP bits. Micron (and ST before them?) addressed this
>>> by adding a fourth BP bit. This is consistent across every flash in this
>>> series, and is clearly documented in every datasheet. Defaulting to 3
>>> bits is buggy behavior: we should assume flashes behave per their
>>> datasheets until proven otherwise, especially for less-popular features
>> 
>> If I had a euro every time I found a bug in a datasheet, well, I would
>> have enough money to at least buy a nice dinner. My point is, datasheets
>> are not perfect. Only running on real hardware gets you the true
>> picture.
>
> Well, it's even *more* buggy to pretend that the datasheet doesn't exist
> and just do whatever you please. Might as well reverse-engineer every
> chip that comes across your desk from first principles with that
> attitude.

... or, you know, read the data sheet, write the driver, and _test_ if
it actually works?

>
> The locking doesn't work on any of these flashes without these flags. If
> you don't believe me you can try it yourself. The people who submitted
> the original patches certainly didn't test it.

Right. So can you send the patches you _did_ test on the hardware you do
have? So this time we are sure we got it right. And reply to the other
review comments? Without that, I don't think this patch can make
progress.

-- 
Regards,
Pratyush Yadav

