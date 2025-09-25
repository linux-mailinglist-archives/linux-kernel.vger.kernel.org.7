Return-Path: <linux-kernel+bounces-832519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C75B9F8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76441892CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479327FB10;
	Thu, 25 Sep 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoAelVsh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681D27FB2B;
	Thu, 25 Sep 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806597; cv=none; b=WGBN6EU7+r8NmooKyMcWrZ0YSbrQ5GDk3qnC3xBoNyjzv57SXQUIlJ1NhPKNIdzyw3QkZYAt8dRtqmuuPBq+2D3oVtkVh7n58i6wy8tx7ZgREdgB88tj4+ccgtxR612Ji+oAIb7izQd38Wd9mwUP2ZLaQuNSEN9LGMbAh0ZUPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806597; c=relaxed/simple;
	bh=4iWz/voiEz7siZfjIqLm43TubG/Oii1lMo/evkOfHWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umi+JaCnXpFaWcllHH4KYvj+Agn4Z8oY2vFUhM5PEiEFHAb9kGaCv3utnPfZGg1wj4DEIMt632nA6koTCix6kESjRjGk3oVWBQMRFTWIZETfZdyUicSnkBjJJwS8j49ryZ9RyrrahN5NvuzkOZQo3Bu5WocoKAlKoGWvVQukYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoAelVsh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758806596; x=1790342596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4iWz/voiEz7siZfjIqLm43TubG/Oii1lMo/evkOfHWI=;
  b=hoAelVshcs6bND/KzxNRL0X7/iwOVtC4eE9R7rUpAzGrJ4R+CBwIG3h/
   oMBgNGrkSfFf+0TFNzoQ9hUMq/VF36shrPGXwa3GN3FVnkBWX8cgHmRC0
   30kGLc2O5AcXeLFpboP4V55ClLHZa7D50DPkp2qUTPDWKOv6V/qjb1Ka4
   8i/9NHBb7ka8r3mdI6+lml0LhVIcmaCNCROUoOVwxNKYLgYyOthzPPIL9
   vuUo/17X/2I+Je5/a42CtOekVOS82Jsyi4N4dHD6CpfMzeP5FldAbWG/Y
   ICBrPQK3DIckHD4sSgHwyWjdLWSvPAKlJxah2J3Lyn4JVVWWLXbVcjXF2
   w==;
X-CSE-ConnectionGUID: x1TfWolVSAawgUdZFDMxog==
X-CSE-MsgGUID: tcZFM1eVQeaex68+sPwvGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60822892"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="60822892"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 06:23:15 -0700
X-CSE-ConnectionGUID: 61lDqMiaSL6gENqN3DozbA==
X-CSE-MsgGUID: k8SaqhLvQp6Ar1H+hx1rFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="177169144"
Received: from mylly.fi.intel.com (HELO [10.237.72.50]) ([10.237.72.50])
  by orviesa007.jf.intel.com with ESMTP; 25 Sep 2025 06:23:12 -0700
Message-ID: <9708c09f-5cd7-4197-b245-04d92f6b1400@linux.intel.com>
Date: Thu, 25 Sep 2025 16:23:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] i3c: mipi-i3c-hci: add microchip sama7d65 SoC
To: Frank Li <Frank.li@nxp.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 balamanikandan.gunasundar@microchip.com, nicolas.ferre@microchip.com
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
 <20250918095429.232710-3-durai.manickamkr@microchip.com>
 <aMwy9MQOf3pG4Fvw@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <aMwy9MQOf3pG4Fvw@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 9/18/25 7:27 PM, Frank Li wrote:
> On Thu, Sep 18, 2025 at 03:24:27PM +0530, Durai Manickam KR wrote:
>> Add support for microchip sama7d65 SoC I3C HCI master only IP.
>> Features tested and supported :
>>             Standard CCC commands.
>>             I3C SDR mode private transfers in PIO mode.
>>             I2C transfers in PIO mode.
>>             Pure bus mode and mixed bus mode.
>>
>> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
>> ---
>>   drivers/i3c/master/mipi-i3c-hci/Makefile      |  3 +-
>>   drivers/i3c/master/mipi-i3c-hci/core.c        | 28 ++++++++++++
>>   drivers/i3c/master/mipi-i3c-hci/hci.h         | 12 ++++++
>>   .../i3c/master/mipi-i3c-hci/hci_quirks_mchp.c | 43 +++++++++++++++++++
>>   4 files changed, 85 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c
>>
>> diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
>> index e3d3ef757035..f463afc4566a 100644
>> --- a/drivers/i3c/master/mipi-i3c-hci/Makefile
>> +++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
>> @@ -4,5 +4,6 @@ obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci.o
>>   mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
>>   					   cmd_v1.o cmd_v2.o \
>>   					   dat_v1.o dct_v1.o \
>> -					   hci_quirks.o
>> +					   hci_quirks.o \
>> +					   hci_quirks_mchp.o
>>   obj-$(CONFIG_MIPI_I3C_HCI_PCI)		+= mipi-i3c-hci-pci.o
>> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
>> index 60f1175f1f37..cb0673d62c03 100644
>> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
>> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
>> @@ -8,6 +8,7 @@
>>    */
>>
>>   #include <linux/bitfield.h>
>> +#include <linux/clk.h>
>>   #include <linux/device.h>
>>   #include <linux/errno.h>
>>   #include <linux/i3c/master.h>
>> @@ -651,6 +652,9 @@ static int i3c_hci_init(struct i3c_hci *hci)
>>   	hci->DAT_regs = offset ? hci->base_regs + offset : NULL;
>>   	hci->DAT_entries = FIELD_GET(DAT_TABLE_SIZE, regval);
>>   	hci->DAT_entry_size = FIELD_GET(DAT_ENTRY_SIZE, regval) ? 0 : 8;
>> +	/* Microchip SAMA7D65 SoC doesnot support DAT entry size bits in the DAT section offset register */
>> +	if (hci->quirks & MCHP_HCI_QUIRK_SAMA7D65)
>> +		hci->DAT_entry_size = 8;
> 
> #define MCHP_HCI_QUIRK_FIX_DATA_ENTRY_SIZE_8
> 
> 	if (hci->quirks & MCHP_HCI_QUIRK_FIX_DATA_ENTRY_SIZE_8)
> 		hci->DAT_entry_size = 8;
> 	else
> 		hci->DAT_entry_size = FIELD_GET(DAT_ENTRY_SIZE, regval) ? 0 : 8;
> 
> in case other vendor have similar problem.
> 
Are DAT_entry_size and DCT_entry_size quirks even needed? Does your HW 
read nonzero values and you need the quirk?

>> +	/* Microchip SAMA7d65 SoC supports only PIO mode */
>> +	if (hci->quirks & MCHP_HCI_QUIRK_PIO_MODE)
>> +		hci->RHS_regs = NULL;
>> +

Please use existing HCI_QUIRK_PIO_MODE quirk and then you don't need 
this added code.

