Return-Path: <linux-kernel+bounces-848481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8BBCDDA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4238819A36C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6A262FE7;
	Fri, 10 Oct 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SF/3xsLq"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11024EF76
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111135; cv=none; b=YlaW70LKdDtOULduaYsmhzVG7elS74pHxTk830fMW6onIvbMYIlyw2TENAztWHpnBkWcGGdPZAPRLhSrIEfRDnwGGPmNDxbPd+ARHokiTll44TfoO4olD4bCy14y1ORl+Gte3swhcRl9o1IivFeCtPAi0AXiHco7W6BGIRjEo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111135; c=relaxed/simple;
	bh=PpLrDV3x/wfq0EN0mjbIaGypJSVqYiOvCLRspEKPQ80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niSoIxGIpBawWL+Sy8s2hOdZz+P4+zrPZDlfaiqcMDoUNz4l/mXHDT7vCmeObUzhMnskeaZGW7naG2TmCFxzv2DUcN2E8WQd9yagN9pRCx7DlBUzoAdyjfYOI6S3cskYDCzFepR1paML0htYpAMMfuWC/W3FbA3StIB4veAQrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SF/3xsLq; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d00d42ce-4262-4736-8c73-5d2544e86d33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760111130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eASh6cvJVj3ZQiKmd81xQ1N7sMEhlMr/vAwAJqYpdfs=;
	b=SF/3xsLq2Uaq/8N8nWIy0srJ0SSsnv2VxPXLeZL+6NBZpb64arhUuhnoW/VaFeAvZrGmWA
	5Y4718lwCC5xD9+56bWbUb58zMYqwjlpZO4+KArRs54208zlz23x6xuyEexyIPbNQwUjd0
	v9sY5E8rTqGFa6M3jx4dtQanShvZBZ8=
Date: Fri, 10 Oct 2025 11:45:26 -0400
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
 <26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
 <mafs0ikgnn07u.fsf@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <mafs0ikgnn07u.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/9/25 19:07, Pratyush Yadav wrote:
> On Thu, Oct 09 2025, Sean Anderson wrote:
> 
>> On 10/8/25 08:30, Pratyush Yadav wrote:
>>> On Tue, Oct 07 2025, Sean Anderson wrote:
>>> 
>>>> On 10/7/25 09:15, Pratyush Yadav wrote:
>>>>> On Mon, Oct 06 2025, Sean Anderson wrote:
>>>>> 
>>>>>> The datasheet for n25q00a shows that the status register has the same
>>>>>> layout as for n25q00, so use the same flags to enable locking support.
>>>>>> These flags should have been added back in commit 150ccc181588 ("mtd:
>>>>>> spi-nor: Enable locking for n25q128a11"), but they were removed by the
>>>>>> maintainer...
>>>>> 
>>>>> This makes it sound like the maintainer did something wrong, which is
>>>>> not true. Tudor had a good reason for removing them.
>>>>
>>>> I disagree. The maintainer used his position of authority to make the
>>>> submitter second-guess their correct patch.
>>> 
>>> Sean, you are being very combative over such a small issue. You must
>>> test your changes. This is one of the most basic principles in software
>>> engineering. It was perfectly reasonable from Tudor to push back on
>>> untested changes.
>>> 
>>> There is no abuse of "position of authority" here. When things break, we
>>> get to do the work of putting the pieces back together. So of course, we
>>> are reluctant to take things that increase this burden for us. Having
>>> contributors test their changes is the simplest of things we ask for to
>>> keep the quality bar.
>>> 
>>> Beyond that, I'd say that a little politeness goes a long way in life.
>>> Especially towards the people maintaining the software for free that you
>>> (or your employer) use. We are both wasting our energy on this debate.
>>> Please stop. Take a step back and think from the other side's
>>> perspective. And try to work _with_ people, not against them.
>>> 
>>>>
>>>> These flashes have capacity of greater than the 8 MiB that can be
>>>> protected using 3 BP bits. Micron (and ST before them?) addressed this
>>>> by adding a fourth BP bit. This is consistent across every flash in this
>>>> series, and is clearly documented in every datasheet. Defaulting to 3
>>>> bits is buggy behavior: we should assume flashes behave per their
>>>> datasheets until proven otherwise, especially for less-popular features
>>> 
>>> If I had a euro every time I found a bug in a datasheet, well, I would
>>> have enough money to at least buy a nice dinner. My point is, datasheets
>>> are not perfect. Only running on real hardware gets you the true
>>> picture.
>>
>> Well, it's even *more* buggy to pretend that the datasheet doesn't exist
>> and just do whatever you please. Might as well reverse-engineer every
>> chip that comes across your desk from first principles with that
>> attitude.
> 
> ... or, you know, read the data sheet, write the driver, and _test_ if
> it actually works?

Which I did.

But apparently it's not enough to confirm that the datasheet does
describe the hardware.

Which is frankly absurd because the first generation chips have been
obsolete for a decade and there are literally dozens of variants of
these chips and none of them have any documented difference in the
status register.

The datasheet is innocent until proven guilty. While it's important to
verify its claims, it's up to *you* to prove it's wrong. You have given
me no evidence to believe it is incorrect.

And you would prefer to believe that the existing (broken!) behavior is
better? The one that clearly no one tested locking with because:

- Locking literally can't work with the "default" BP semantics. BP holds
  the log2 size of the protected area in eraseblocks plus one. The maximum number
  of eraseblocks that can be protected with 3 bits is 1 << (7 - 1) = 64. So
  if you have more than 64 eraseblocks (the smallest flash in this
  series has 128) you have to come up with different semantics:

  - Enlarge the protection granularity (e.g. to some multiple of the
    eraseblock size or to 
  - Add another bit to BP (what Micron did)

  Both of these are incompatible with existing behavior and need
  feature flags since they can't be discovered via SFDP. If you pretend
  that BP only has 3 bits, you will either not lock the whole flash (if
  you wanted to lock the whole thing) or you will lock too much of the
  flash (if you only wanted to lock part of it).

- Locking is broken based on the documentation. Every datasheet for
  flashes in this series clearly shows the 4th BP bit in the status
  register:

    https://media.digikey.com/pdf/Data%20Sheets/Micron%20Technology%20Inc%20PDFs/N25Q032A_RevJ.pdf
    This is the only exception because it has 64 eraseblocks and doesn't
    need an extra BP bit.
    https://media.digikey.com/pdf/Data%20Sheets/Micron%20Technology%20Inc%20PDFs/N25Q064Ax3.pdf
    https://media.digikey.com/pdf/Data%20Sheets/Micron%20Technology%20Inc%20PDFs/N25Q128A.pdf
    https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/6657/MT25QL256ABA8ESF-0SIT.pdf
    https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/789/N25Q256A.pdf
    https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/7156/mt25q-qlkt-l-512-abb-0.pdf
    https://www.digikey.com/htmldatasheets/production/1952775/0/0/1/N25Q512Ax3.pdf
    https://www.alldatasheet.com/datasheet-pdf/download/585916/MICRON/N25Q00AA.html
    https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/6242/MT25QL02GCBB.pdf
    https://www.digikey.com/htmldatasheets/production/2058522/0/0/1/n25q016a.pdf

    etc.
 
- Locking is broken based on my testing.

- Locking is broken whenever anyone else tests it on one of these
  flashes. And they all fix it in exactly the same way:

    f3f2b7eb2f1c ("mtd: spi-nor: Enable locking for n25q512ax3/n25q512a")
    f80ff13135cb ("mtd: spi-nor: micron-st: Enable locking for n25q00")
    bcc0c61e6134 ("mtd: spi-nor: micron-st: Enable locking for mt25qu256a")
    a2a3e5430e7b ("mtd: spi-nor: micron-st: enable lock/unlock for mt25qu512a")

- Locking is not in your suggested test procedure for new flashes
  (although it probably should be if you're so gung ho about mistrusting
  datasheets).

- None of the commits adding support for these chips report testing
  locking:

    c692ba6de1c5 ("mtd: spi-nor: micron-st: Add support for mt25qu01g")
    7f412111e276 ("mtd: spi-nor: Add entries for mt25q variants")
    bd8a6e31b87b ("mtd: spi-nor: Split mt25qu512a (n25q512a) entry into two")
    9607af6f857f ("mtd: spi-nor: Rename "n25q512a" to "mt25qu512a (n25q512a)"")
    21ed90acd178 ("mtd: spi-nor: Add Micron MT25QL02 support")
    a98086e00420 ("mtd: spi-nor: add entry for mt35xu512aba flash")
    56c6855c81c8 ("mtd: spi-nor: Add Micron MT25QU02 support")
    835ed7bf1260 ("mtd: spi-nor: Add support for N25Q256A11")
    61e4611864b3 ("mtd: spi-nor: Add support for N25Q016A")
    cebc1fd06907 ("mtd: spi-nor: Added support for n25q00a.")
    f9bcb6dc8013 ("mtd: spi-nor: Add support for Micron n25q032a")
    2a06c7b1fd23 ("mtd: spi-nor: Add support for Micron n25q064a serial flash")
    c14deddec1fb ("mtd: spi-nor: add support for flag status register on Micron chips")
    867f770de812 ("mtd: m25p80: Add support for Micron N25Q512A memory")
    98a9e2450667 ("mtd: m25p80: modify info for Micron N25Q128")
    3105875f6b89 ("mtd: m25p80: add support for Micron N25Q128")
    8da28681eb14 ("mtd: m25p80: add support for Micron N25Q256A")

There is no evidence that the status register has three bits (except
when the flash has 64 eraseblocks or fewer), and there overwhelming
evidence to the contrary.

--Sean

>>
>> The locking doesn't work on any of these flashes without these flags. If
>> you don't believe me you can try it yourself. The people who submitted
>> the original patches certainly didn't test it.
> 
> Right. So can you send the patches you _did_ test on the hardware you do
> have? So this time we are sure we got it right. And reply to the other
> review comments? Without that, I don't think this patch can make
> progress.
> 

