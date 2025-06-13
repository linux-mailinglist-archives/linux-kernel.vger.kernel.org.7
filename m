Return-Path: <linux-kernel+bounces-686038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDDCAD9232
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 17:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72CC189F85A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5720DD63;
	Fri, 13 Jun 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IRz3QDl5"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47352202C4E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830274; cv=none; b=lDmFHOOlykIbBIHW0xYykiKThvoDEdnRKqsRvSnGWgk49o+QHwbYbkBlwVwtgfQ7Y4sdQCAWPUCusJFaIKNnRwPIw7DR6dHjs/rwtZWNxPmzYm2VwA9c7utLpgmELF+2+fnu1ZMzx1LuK0MmI7TtQ2imFHljsOYdlBUt38HWUJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830274; c=relaxed/simple;
	bh=0k0685jiPxrDvImAtuIYSnm0V/jmg0N9/cne/apm2Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0Xq1qQPO0EiT86X4BnjG1774B439FTTEUQYSuZLlHQIa5Yd5/8fnf4hI/De7xYR3CWAmH7WEkEahHd9hosTbH9khZf+imlXIvTy8/KcaUoSWYt0nKxeW1973+SRQfEoQm0DRckGSSdRZoBNt70I3xrFxJTVQbIdx5eGJPjuZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IRz3QDl5; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3160819-f6f4-4079-9562-802caa2fef20@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749830260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27fXVhxsftq5EDoqBWvyXb7dA+Q8HBVNKfdnJWl2xe0=;
	b=IRz3QDl5Oaf6RGCCivGPUThJ0GToGh3KlZtALUtgQYMqrgWJ+JZK2lZPIfeLG4Ne09vrs6
	lRM43ovdJrUzgRco9Z9lLR3THckDkWE8OTIG/rXRKwdY6iCB/+Ag2fwNwNI9qKOi2VjhoH
	+ByATj80xnUHOoEN2OPUX3JxHEPLOXU=
Date: Fri, 13 Jun 2025 11:57:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] dt-bindings: spi: zynqmp-qspi: Split the bus
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-2-sean.anderson@linux.dev>
 <9f40295b-484a-48e8-b053-ff8550e589d7@baylibre.com>
 <46a7eba6-a705-4543-b967-e83ccc89e7d4@linux.dev>
 <6afc379a-2f9f-4462-ae30-ef6945a83236@baylibre.com>
 <dbe26b36-a10c-4afb-88ad-a6f7f9bff440@linux.dev>
 <4923f49f-273f-4166-94bc-afe39618672c@baylibre.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <4923f49f-273f-4166-94bc-afe39618672c@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/13/25 10:20, David Lechner wrote:
> On 6/12/25 6:44 PM, Sean Anderson wrote:
>> Hi David,
>> 
>> I am (finally!) getting around to doing v2 of this series, and I ran
>> into a small problem with your proposed solution.
>> 
>> On 1/23/25 16:59, David Lechner wrote:
>>> ---
>>> From: David Lechner <dlechner@baylibre.com>
>>> Date: Thu, 23 Jan 2025 15:35:19 -0600
>>> Subject: [PATCH 2/2] spi: add support for multi-bus controllers
>>>
>>> Add support for SPI controllers with multiple physical SPI buses.
>>>
>>> This is common in the type of controller that can be used with parallel
>>> flash memories, but can be used for general purpose SPI as well.
>>>
>>> To indicate support, a controller just needs to set ctlr->num_buses to
>>> something greater than 1. Peripherals indicate which bus they are
>>> connected to via device tree (ACPI support can be added if needed).
>>>
>>> In the future, this can be extended to support peripherals that also
>>> have multiple SPI buses to use those buses at the same time by adding
>>> a similar bus flags field to struct spi_transfer.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---
>>>  drivers/spi/spi.c       | 26 +++++++++++++++++++++++++-
>>>  include/linux/spi/spi.h | 13 +++++++++++++
>>>  2 files changed, 38 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>> index 10c365e9100a..f7722e5e906d 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -2364,7 +2364,7 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
>>>  static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>>  			   struct device_node *nc)
>>>  {
>>> -	u32 value, cs[SPI_CS_CNT_MAX];
>>> +	u32 value, buses[8], cs[SPI_CS_CNT_MAX];
>>>  	int rc, idx;
>>>  
>>>  	/* Mode (clock phase/polarity/etc.) */
>>> @@ -2379,6 +2379,29 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>>  	if (of_property_read_bool(nc, "spi-cs-high"))
>>>  		spi->mode |= SPI_CS_HIGH;
>>>  
>>> +	rc = of_property_read_variable_u32_array(nc, "spi-buses", buses, 1,
>>> +						 ARRAY_SIZE(buses));
>>> +	if (rc < 0 && rc != -EINVAL) {
>>> +		dev_err(&ctlr->dev, "%pOF has invalid 'spi-buses' property (%d)\n",
>>> +			nc, rc);
>>> +		return rc;
>>> +	}
>>> +
>>> +	if (rc == -EINVAL) {
>>> +		/* Default when property is omitted. */
>>> +		spi->buses = BIT(0);
>> 
>> For backwards compatibility, the default bus for CS 1 on gqspi must be 1
>> and not 0. Ideally there would be some hook for the master to fix things
>> up when the slaves are probed, but that doesn't seem to exist. I was
>> thinking about doing this with OF changesets. Do you have any better
>> ideas?
>> 
> 
> Does this work? 
> 
> 		spi->buses = BIT(cs[0]);
> 
> (would have to move all the new code after cs[0] is assigned of course)

Yeah, but do we really want to make this the default for all drivers?
This is really a quirk of the existing gqspi binding and I don't think
it makes sense in general.

--Sean

