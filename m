Return-Path: <linux-kernel+bounces-842542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254EBBCF84
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 03:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD063AF8C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 01:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C601A2C11;
	Mon,  6 Oct 2025 01:47:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA620322;
	Mon,  6 Oct 2025 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759715224; cv=none; b=lw1UPN8/PinEiLG7v4CTU3jBCwkT092Pg/eP55JpsP7+aGT9LXk1bU7cyVynajiN54lrY8e5bkZfB2XDnvm1VhPTxQDd9/VwBnf9Kin2phL4Qu/CJgvWh/hIIIwGFg6XnXKF+vZDop7bL0mkOwKqhbk69ng95bbCqj0UaoygkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759715224; c=relaxed/simple;
	bh=N6OySqPBxOK9f/FzRyvUMzJosyVnMvxjt3IhwU9BL4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uM4Ik9WDmO+eww8d7VWrM6KH8vQ+71GmVCnyNi7L3sCIq4ZHmIImQX3+k7I1tl+BBv4Tif79yFRZ+ruIKdQQv1ZhxDtSf1zT41VYYw6b5PA0TV0q+OlAGiIlnh7DhtVxFocQfp6eJWjyitE5TwJEt4cwyv79MSL9mNvKVknSFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229FEC4CEF4;
	Mon,  6 Oct 2025 01:47:03 +0000 (UTC)
Message-ID: <35272fd3-c452-4689-813e-03345ba43ea4@kernel.og>
Date: Sun, 5 Oct 2025 20:47:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] clk: socfpga: agilex5: add clock driver for Agilex5
To: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Ang, Tien Sung" <tien.sung.ang@altera.com>
References: <cover.1759482803.git.khairul.anuar.romli@altera.com>
 <e7e7e105327aafd54e58d1786a7a55ff0ea4aa9b.1759482803.git.khairul.anuar.romli@altera.com>
 <cd8e3d8c-314a-4a77-a3c1-665957f4ea9a@kernel.og>
 <374f4284-2c30-4485-a77c-154cde19c885@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.og>
In-Reply-To: <374f4284-2c30-4485-a77c-154cde19c885@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/5/25 20:39, Romli, Khairul Anuar wrote:
>> On 10/3/25 04:19, Khairul Anuar Romli wrote:
>>> Add the new Clock manager driver to support new Agilex5 platform. The new
>>> driver got rid of the clk_parent_data structures as there are no
>>> 'clock-names'
>>> property in the DT bindings and use parent_names internally. This is
>>> based on
>>> the previous feedback from the maintainer.
>>>
>>> Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
>>> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
>>> ---
>>>    drivers/clk/socfpga/clk-agilex5.c    | 563 +++++++++++++++++++++++++++
>>>    drivers/clk/socfpga/clk-gate-s10.c   |  53 +++
>>>    drivers/clk/socfpga/clk-periph-s10.c |  41 ++
>>>    drivers/clk/socfpga/clk-pll-s10.c    |  38 +-
>>>    drivers/clk/socfpga/stratix10-clk.h  |  43 ++
>>>    5 files changed, 737 insertions(+), 1 deletion(-)
>>
>> Do you want to add it a Makefile to build it?
> 
> I will add it to a Makefile in V2.
> 
>>
>>>    create mode 100644 drivers/clk/socfpga/clk-agilex5.c
>>>
>>> diff --git a/drivers/clk/socfpga/clk-agilex5.c b/drivers/clk/socfpga/
>>> clk-agilex5.c
>>> new file mode 100644
>>> index 000000000000..0013fab81357
>>> --- /dev/null
>>> +++ b/drivers/clk/socfpga/clk-agilex5.c
>>> @@ -0,0 +1,563 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2022-2024, Intel Corporation
>>> + * Copyright (C) 2025, Altera Corporation
>>> + */
>>> +#include <linux/slab.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/of_address.h>
>>
>> Remove of_device.h and of_address and just use of.h.
> 
> Will use of.h as suggested.
>>> +#include <linux/platform_device.h>
>>> +#include  <dt-bindings/clock/intel,agilex5-clkmgr.h>
>>> +#include "stratix10-clk.h"
>>> +#include "clk.h"
>>> +
>>
>> <snip>
> 
> Sorry, what is this snip?
> 

It's just a way to cut a chunk of code in the review process so you 
don't have to scroll through the whole email.

Dinh

