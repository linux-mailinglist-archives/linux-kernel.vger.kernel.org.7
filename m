Return-Path: <linux-kernel+bounces-790360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57331B3A5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E8CA046B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E88320CAD;
	Thu, 28 Aug 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GpcF7xYc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DC212567;
	Thu, 28 Aug 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397802; cv=none; b=KOGpuciwBxC2F2u3hKXGEbowY+m0I/ou4v6kcRti6Aml+1yUk5x8G7xO1+bQ/eZE77apiaOEmHS9hs0E/CJM8q7cokbpgIhskZwnBE+Uv7WKBHpd5xUb4cBpnCL82do61lBdNGaZvaz0wcVyKPLXQDWfPzDHHjWpICwm8U1IQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397802; c=relaxed/simple;
	bh=dbxb4w4OJlV5sDEo57zFUE5nYfUGYzxZZDwgoF4J/Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cPDD2aIfKlYl62VN+Tzt5vD/fymeE1jUN1oXWXgvxQvxIHoUS/HeFBe5ko3EMnPECHPkrCMJROBON596SuFI/e2JMRwczZTu8GE1Omdg5bT6JLhv5LRrhda0PQWKnYaRePU9QWh0FPUSTiSGF7Lf6t9konN+rkfZfvXdTqsGSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GpcF7xYc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756397800; x=1787933800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dbxb4w4OJlV5sDEo57zFUE5nYfUGYzxZZDwgoF4J/Dw=;
  b=GpcF7xYcgB23BK6bxJ80U1JNAOWvKZMDyA/mNMTamrON4h+JrNl+vY6e
   cJgF87J+JPxoDW65T3Jsessbw0SXW7tfUdijirtuK4rcxO5Xqoma2aeRi
   gavNAEKSmlfrAB9VypuRKrRZ6VaWYhEzfAVVzRmFCdQv2TM9KHde13pN5
   aLOurrOIGPBPEF2SpZ973YB0dfpxr7BP2wXBv2PO09hovDqJIB0MXc6Il
   M3jlPQo5sEwekyJh7Oxf+kL6QVgVdQ4xtXmJmD6gkL9nqc1/Eg2Tp4qG4
   crnow5eU+GgLWs0GXe2AECJRmhO0a4sqtYd1RLwIXu+AnKsdoCczqbMOS
   g==;
X-CSE-ConnectionGUID: X9YiAgovSEikt4Ra+TjvOg==
X-CSE-MsgGUID: 9dg/711GTSemJKiM6lKqeA==
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="46343766"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2025 09:16:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 28 Aug 2025 09:16:18 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 28 Aug 2025 09:16:18 -0700
Message-ID: <08dd4d82-8ac4-43a3-8d01-f293db6302e2@microchip.com>
Date: Thu, 28 Aug 2025 09:16:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/32] clk: at91: add support for parent_data and
To: Brian Masney <bmasney@redhat.com>
CC: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <aLB7CJY9nMLoS1or@x1>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <aLB7CJY9nMLoS1or@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 8/28/25 08:51, Brian Masney wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hi Ryan and Claudiu,
> 
> On Thu, Jul 10, 2025 at 01:06:53PM -0700, Ryan.Wanner@microchip.com wrote:
>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>
>> This series adds support for parent data and parent _hw on the at91
>> clock drivers. This also updates all the SoC specific clock drivers to
>> use this format as well.
>>
>> This is a continuation of the V1 of this series here [1].
>>
>> This has been tested on the SAMA5* SoCs, the sam9x* SoCs, and the SAMA7*
>> SoCs.
>>
>> Changes v1 -> V2:
>> - Remove all the small sama7g54 SoC driver changes and put them in their
>>   own patch.
>> - Add the SAMA7D65 and the SAM9X75 to this update.
>> - Add a patch to move all common used macros into the pmc.h file.
>> - Update changes from v6.6 to v6.16.
>> - Remove patches that where style fixes and include those in the update.
>>
>> Changes v2 -> v3:
>> - Adjust each patch so they are fully atomic.
>> - Add a patch to have the SAMA7D65 systemclocks use parent_data and
>>   parent_hw.
>> - Add a formatting cleanup patch for the SAM9X75.
>> - Adjust commit messages that no longer show invalid information.
>>
>>
>> 1) https://lore.kernel.org/all/20230727053156.13587-1-claudiu.beznea@tuxon.dev/
>>
>>
>> Claudiu Beznea (28):
>>   clk: at91: pmc: add macros for clk_parent_data
>>   clk: at91: clk-sam9x60-pll: use clk_parent_data
>>   clk: at91: clk-peripheral: switch to clk_parent_data
>>   clk: at91: clk-main: switch to clk parent data
>>   clk: at91: clk-utmi: use clk_parent_data
>>   clk: at91: clk-master: use clk_parent_data
>>   clk: at91: clk-programmable: use clk_parent_data
>>   clk: at91: clk-generated: use clk_parent_data
>>   clk: at91: clk-usb: add support for clk_parent_data
>>   clk: at91: clk-system: use clk_parent_data
>>   clk: at91: clk-pll: add support for parent_hw
>>   clk: at91: clk-audio-pll: add support for parent_hw
>>   clk: at91: clk-plldiv: add support for parent_hw
>>   clk: at91: clk-h32mx: add support for parent_hw
>>   clk: at91: clk-i2s-mux: add support for parent_hw
>>   clk: at91: clk-smd: add support for clk_parent_data
>>   clk: at91: clk-slow: add support for parent_hw
>>   clk: at91: dt-compat: switch to parent_hw and parent_data
>>   clk: at91: sam9x60: switch to parent_hw and parent_data
>>   clk: at91: sama5d2: switch to parent_hw and parent_data
>>   clk: at91: sama5d3: switch to parent_hw and parent_data
>>   clk: at91: sama5d4: switch to parent_hw and parent_data
>>   clk: at91: at91sam9x5: switch to parent_hw and parent_data
>>   clk: at91: at91rm9200: switch to parent_hw and parent_data
>>   clk: at91: at91sam9260: switch to parent_hw and parent_data
>>   clk: at91: at91sam9g45: switch to parent_hw and parent_data
>>   clk: at91: at91sam9n12: switch to parent_hw and parent_data
>>   clk: at91: at91sam9rl: switch to clk_parent_data
>>
>> Ryan Wanner (4):
>>   clk: at91: pmc: Move macro to header file
>>   clk: at91: sam9x75: switch to parent_hw and parent_data
>>   clk: at91: sama7d65: switch to parent_hw and parent_data
>>   clk: at91: sam9x7: Clean up formatting
> 
> What tree did you develop this against? When I try to apply this series
> to Linus's tree (6.17-rc3) and linux-next, only 12 of these patches
> actually apply with 'git am'.

This was developed on 6.16 but when I bumped this thread I checked and
they all apply cleanly on the v6.17-rc3 tag. I also just tested on
next-20250828 tag and this set applies cleanly as well.

Ryan
> 
> Brian
> 


