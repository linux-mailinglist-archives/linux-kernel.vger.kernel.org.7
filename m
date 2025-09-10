Return-Path: <linux-kernel+bounces-809784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63859B51201
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E2848209B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA3311C1B;
	Wed, 10 Sep 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgTTFU4W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9899310628;
	Wed, 10 Sep 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494890; cv=none; b=SHXxWLSRtiAFZS/pphcLdZhCI65B7tGHKZbDaQJDTpIwMkgfhUZKafecGZQgq+HDY+SH3kHwSq3aGU1mReuBcj2ZF8+vWkm7GHUUqrfLKSuPOQGULozhIP+rU9plXbD5b/c+Q97eGMRct9BNUsLYnEzmFiJgrOqut5+iSYupStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494890; c=relaxed/simple;
	bh=Rybcg1Vh4BsYqStJeY+6Xh4rBXoC7PDoI6Pf3cCJR4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PG+QI3A7JKeiRbcHM8B3xGzmMJRBcTW8NlC54AaJpV4wej+PrXhynpRbn7pxcBIvqVNGn9Jp1mBAnvOS5p711runBDA67EUUclQauJRrHR36FfWmgOgxgQ1VWrhoZ6eiupiFjbHVKuEliEW/nQmknW4pHLK/j1ddm47OQJHUWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgTTFU4W; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757494890; x=1789030890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rybcg1Vh4BsYqStJeY+6Xh4rBXoC7PDoI6Pf3cCJR4M=;
  b=JgTTFU4WvTQdM4JG735AA421dCNKeO0L+qP3mgL65GyPqZG+hR2PceKR
   O0LO6rR1eL5816606zNUE6ihWFLpghOP8/tJo2WXkgva1J6KxEgVG+xn6
   nQPPHIhFyiZ3BFTMZilo3quERh1t92ZoNjaG7ii3Qtc04YHRe1MdNh8zi
   mWsnhs20edcsneln2wgVxdyhtP7+N5Ou3wx7UBqOF3aDlL5w2LZ/5Ib55
   zy0okopo8IIvv5m1CMvwQ+Kv7kdT3zvnBgGrCACYSqP7GsVegvscxmAm1
   MU1CuPEyftGBRihQxZEULRIpduWKkvPnZGKWFyuMDNbjzN64OQ7wVNg6/
   Q==;
X-CSE-ConnectionGUID: LUe6vn+0SdaofmdbJkGZ5w==
X-CSE-MsgGUID: xKom4FZkQY+CAgNakVWKpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="77253122"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="77253122"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 02:01:28 -0700
X-CSE-ConnectionGUID: 278oqUfEQFK6KZQ0zMoLkA==
X-CSE-MsgGUID: NqAI8bN5SRK//ir8qeJxEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="204321581"
Received: from mylly.fi.intel.com (HELO [10.237.72.52]) ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP; 10 Sep 2025 02:01:22 -0700
Message-ID: <c25bf384-a312-47a9-a27a-a943cbd33050@linux.intel.com>
Date: Wed, 10 Sep 2025 12:01:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] i3c: master: add Microchip SAMA7D65 I3C HCI master
 driver
To: Durai.ManickamKR@microchip.com, Frank.li@nxp.com
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Balamanikandan.Gunasundar@microchip.com, Nicolas.Ferre@microchip.com
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
 <20250909111333.170016-3-durai.manickamkr@microchip.com>
 <aMCZw2v8Ey6aGbqk@lizhi-Precision-Tower-5810>
 <3229da67-9d67-47ff-9f01-0d71bfabb6a6@microchip.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <3229da67-9d67-47ff-9f01-0d71bfabb6a6@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 9/10/25 9:12 AM, Durai.ManickamKR@microchip.com wrote:
> On 10/09/25 02:48, Frank Li wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Tue, Sep 09, 2025 at 04:43:31PM +0530, Durai Manickam KR wrote:
>>> Add support for microchip SAMA7D65 I3C HCI master only IP. This
>>> hardware is an instance of the MIPI I3C HCI Controller implementing
>>> version 1.0 specification. This driver adds platform-specific
>>> support for SAMA7D65 SoC.
> 
> Hi Frank,
> 
> We have integrated the I3C HCI IP from synopsys. But the IP which we
> integrated into our SAMA7D65 SoC does not support DMA feature, Endianess
> check and few other interrupt status. So we have to introduce a
> microchip SoC specific macro to modify this driver. So we have below 2
> approaches,
> 
I'd try to avoid creating a copy driver for the same base IP as much as 
possible.

MIPI I3C HCI driver supports both PIO and DMA. Not sure are there 
implementations where IP is synthezied to support both but for example 
AMD platform with ACPI ID AMDI5017 is PIO only and Intel is DMA only.

I have two concrete examples below showing how difficult is to keep sync 
changes and one sidenote about unneeded code for your HW.

>>> +static void mchp_hci_dat_v1_set_dynamic_addr(struct mchp_i3c_hci *hci,
>>> +                                        unsigned int dat_idx, u8 address)
>>> +{
>>> +        u32 dat_w0;
>>> +
>>> +        dat_w0 = dat_w0_read(dat_idx);
>>> +        dat_w0 &= ~(DAT_0_DYNAMIC_ADDRESS | DAT_0_DYNADDR_PARITY);
>>> +        dat_w0 |= FIELD_PREP(DAT_0_DYNAMIC_ADDRESS, address) |
>>> +                  (dynaddr_parity(address) ? DAT_0_DYNADDR_PARITY : 0);
>>> +        dat_w0_write(dat_idx, dat_w0);
>>> +}

This code calculates the parity wrong. See commit e55905a3f33c ("i3c: 
mipi-i3c-hci: use parity8 helper instead of open coding it").

If I recall correctly this becomes visible with the 3rd or 4th device on 
the bus and therefore was for long unnoticed.

>>> +static int mchp_i3c_hci_alloc_safe_xfer_buf(struct mchp_i3c_hci *hci,
>>> +                                    struct mchp_hci_xfer *xfer)
>>> +{
>>> +     if (hci->io == &mchp_mipi_i3c_hci_pio ||
>>> +         xfer->data == NULL || !is_vmalloc_addr(xfer->data))
>>> +             return 0;
>>> +     if (xfer->rnw)
>>> +             xfer->bounce_buf = kzalloc(xfer->data_len, GFP_KERNEL);
>>> +     else
>>> +             xfer->bounce_buf = kmemdup(xfer->data,
>>> +                                        xfer->data_len, GFP_KERNEL);
>>> +
>>> +     return xfer->bounce_buf == NULL ? -ENOMEM : 0;
>>> +}
>>> +
>>> +static void mchp_i3c_hci_free_safe_xfer_buf(struct mchp_i3c_hci *hci,
>>> +                                    struct mchp_hci_xfer *xfer)
>>> +{
>>> +     if (hci->io == &mchp_mipi_i3c_hci_pio || xfer->bounce_buf == NULL)
>>> +     return;
>>> +     if (xfer->rnw)
>>> +             memcpy(xfer->data, xfer->bounce_buf, xfer->data_len);
>>> +
>>> +     kfree(xfer->bounce_buf);
>>> +}

Sidenote, these bounce buf stuff are complete unneeded if your HW 
supports only PIO transfers.

>>> +static int mchp_i3c_hci_attach_i3c_dev(struct i3c_dev_desc *dev)
>>> +{
>>> +     struct i3c_master_controller *m = i3c_dev_get_master(dev);
>>> +     struct mchp_i3c_hci *hci = to_i3c_hci(m);
>>> +     struct mchp_i3c_hci_dev_data *dev_data;
>>> +     int ret;
>>> +
>>> +     dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
>>> +     if (!dev_data)
>>> +             return -ENOMEM;
>>> +     if (hci->cmd == &mchp_mipi_i3c_hci_cmd_v1) {
>>> +             ret = mchp_mipi_i3c_hci_dat_v1.alloc_entry(hci);
>>> +             if (ret < 0) {
>>> +                     kfree(dev_data);
>>> +                     return ret;
>>> +             }
>>> +             mchp_mipi_i3c_hci_dat_v1.set_dynamic_addr(hci, ret, dev->info.dyn_addr);
>>> +             dev_data->dat_idx = ret;
>>> +     }
>>> +     i3c_dev_set_master_data(dev, dev_data);
>>> +     return 0;
>>> +}

See commit 2b50719dd92f ("i3c: mipi-i3c-hci: Support SETDASA CCC").


