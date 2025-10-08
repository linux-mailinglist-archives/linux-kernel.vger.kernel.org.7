Return-Path: <linux-kernel+bounces-845427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A7BC4DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085EC19E1EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812EA2494FE;
	Wed,  8 Oct 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2Ncq3Tc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0193F9FB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927100; cv=none; b=CpbeaDgJyWLgnPxf2OThHGBw3T5Qjmj0IbYE+6RFXyEZJPCxjy8LL/w2i+3gvseDQpJ8ILRfRWa4woVMXTWDOXGECjQBXZ/w2saG6MTlX0smOvraT/SxLb9IGN62PjdVL+uoJVOdnOv9jxe4klMwIDlTzQvS6FoXHCrK790v6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927100; c=relaxed/simple;
	bh=ZhixgKI1C4ISlwRUAfei6v0l16wxlircNMUwJwT/hjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CwNbyXLxyxicdGfoBZvHkktt6uUQA8eQrwGO702nrBq0ZQrNOBBOFJXn0h9l0uqmeL8PgLy9xtbNwRIfWq17pmvN9nc1Y+yzIiqsvCrNjqUJc60RKjszM2f5oPCIHm4vpjLEEF9rhUnpCFV7NF/LU0wpt8NO8v81tjT3mpCxing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2Ncq3Tc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725D6C4CEFF;
	Wed,  8 Oct 2025 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759927100;
	bh=ZhixgKI1C4ISlwRUAfei6v0l16wxlircNMUwJwT/hjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M2Ncq3Tcw7zaOSjLHS74BvWZskunIuF0UILJEHiR0RzmBiFCGqBKeIyl8hVp7r38u
	 ZIEJJKJouqGlWe37GzU9pE8VPqQ2q9kvqsAjeWkstS+DZqRHtc8H9b7maStL9DmmyC
	 I9ti2UVeU2nahceJTfjsmh67gHJz1bJzJbJ6XsMI/4z+Lgl40afu4iKthg+cJIYXgq
	 W8Y7QeySxgtQo4IvTi0kPITB9idw5/aDbiqEQHX6v/s/+7ZNqTG+CNWNS2PA11raPO
	 N5wNX7GjIZUCihtrra38I0iXMfREYo+W/j/C89Ha56k8a6whPlAI56sIwFh+JNsd/i
	 TAGbPHvF1oQLw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Sean Anderson <sean.anderson@linux.dev>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-mtd@lists.infradead.org,  Richard Weinberger <richard@nod.at>,
  linux-kernel@vger.kernel.org,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
In-Reply-To: <27d13306-79a7-40ae-af88-069d1f71f016@linaro.org> (Tudor
	Ambarus's message of "Wed, 8 Oct 2025 06:05:36 +0100")
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
	<21760ebf-99f8-4ea3-8841-e023e00ae574@linux.dev>
	<27d13306-79a7-40ae-af88-069d1f71f016@linaro.org>
Date: Wed, 08 Oct 2025 14:38:17 +0200
Message-ID: <mafs01pndo9fq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 08 2025, Tudor Ambarus wrote:

> Hi, Sean,
>
> On 10/6/25 11:38 PM, Sean Anderson wrote:
>> On 10/6/25 18:34, Sean Anderson wrote:
>>> The datasheet for n25q00a shows that the status register has the same
>>> layout as for n25q00, so use the same flags to enable locking support.
>>> These flags should have been added back in commit 150ccc181588 ("mtd:
>
> Were the flags removed upstream and then not added back?
>
>>> spi-nor: Enable locking for n25q128a11"), but they were removed by the
>> 
>> Sorry, this should be commit f80ff13135cb ("mtd: spi-nor: micron-st: Enable locking for n25q00")
>> 
>> https://lore.kernel.org/all/20200421063313.32655-1-js07.lee@samsung.com/
>
> The rule is still true today: I don't queue patches that are not 
> functionally tested, even if they are based on datasheet info.
>
>> 
>>> maintainer...
>
> Don't point fingers please. If you feel the context is worth
> mentioning, specify it in an impersonal way and add a link to the
> discussion in the commit message.

+1.

>
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>> Tested with a mt25qu01gbbb, which shares the same flash ID.
>
> Would you please let us know how you tested the support?
>
> If you feel generous and want to give back to the community, you can also
> describe your testing steps in the documentation from:
> https://docs.kernel.org/driver-api/mtd/spi-nor.html
>
> Also, if there's going to be a v2, please dump the SPI NOR sysfs and
> debugfs data, see how in the link from above. We're keeping a database
> and it will help us differentiate flashes that have the same flash ID
> but different functionalities.

There will need to be a v2. I'm not applying the commit message in its
current form.

Would be nice to have a sysfs and debugfs dump too. Sean, the data we
need can be found in
https://docs.kernel.org/driver-api/mtd/spi-nor.html.

[...]

-- 
Regards,
Pratyush Yadav

