Return-Path: <linux-kernel+bounces-866227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B09BFF3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BBFC358C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72701265CA8;
	Thu, 23 Oct 2025 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BqfO9UCG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447E261B8C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196284; cv=none; b=ULVtA0h3RR9LAYEqLbX1CfiuH/j4Kvw2OI5DQDVMQI12FC8dwDLIJNzSi7xLoU2NNH3Pn/t5oNo7AyOdbjhnAr9/M0Bb5+fWw5GRi9qDEicuS2opLPfLYNt2fUU+7W4H40YJV2YUgsl2FANiillnG0Ygx57QTsdFZELtbt/FfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196284; c=relaxed/simple;
	bh=w1LmB0SE2C+tSWh9OqT3WGhfCB5JmRvULI6W/A8+/1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxFxXkFT1HvUD8UqA0NcP2vLOw1HhniupDmlvuvJlJHZ1AXHdGSQljPj9o6CFw1m8FDWlWzVRmskWH+ARVjflZ8eWm2xNHUZo3noGGRYj2izpZv8+deHH0dIJ6jjWKzLWZpT/C2GHuy/kaQ5b1scs89zjyXn37NA25OhkeQABoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BqfO9UCG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso3612495e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761196280; x=1761801080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBvcm1/+MWpjtuc12IDJ3vwTa6noB7EaiS2kKGjrEYk=;
        b=BqfO9UCGSJI+ZSEmVvCODgujXi/oSa2IOkRElOV7rbxOY/kWFEtmSQ8+BDx/FPzQ0x
         k+nmo6Owt0f+rTXd1KE1vUsknNPXql/pWVqh+eGMgwRvloajCyE64u6PkEafTTO3E5Dk
         j0CdCB7qm6WIYFk+eT6u8pyjjEg3+t0hn/+S2tRfZBZ6MouLTsBjDAdyZGwiMW+Wcv0r
         EDxw92TStEG5qCt6kO5eUAnMjskgBb3xMTLUqJ/IiuiuGg+/Vzcm8NBGCHdA4oA98cn9
         uF3+MLPRDWUEPo+HiRYJHSOAtfB0t7vqchkekROrdYleUUXefTE6OqDfalrhyeQkNkhJ
         +GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761196280; x=1761801080;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBvcm1/+MWpjtuc12IDJ3vwTa6noB7EaiS2kKGjrEYk=;
        b=goHBYXGl80EpwwMPEJlilHITs89bG+CHB7HFOhni/sHBMGGj32j/4rXM4ryhkldKVm
         6hDzzYni/JVTRp6RF/MqYB27I1MbTyacZDH3y0EKnotECZ+PD6Tbsac3kwU/m0JlpgfV
         Metb+S4lqR1XU5uTQK8ukK1v2XU93Joio9Fu5ougiPyDJZbwOpStmkHIqwvTs9MsW0PC
         E5slc8sZIqaTkzAC1Ts5j/62dBUKVfa142FiAreljUZ6zY99OMY2chvWQSs5eIRmGPMq
         WZ0dgfBJSO0t+qd32Tt4xqK1aLnkzzJt8v0uj7IzidmZ41OzCeq/CR6ZI3gAiWscvUuf
         mKCw==
X-Forwarded-Encrypted: i=1; AJvYcCVw/YAhonvJamx/h8QrUNOAoNsi7S32rTj4rYIQ5MkjNOmd425Ceh3Sh36WghoQJ8/PB7xK3Xxq2NWtlvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcKk6lS2tfSf/ps1YRCajHloqNgjKVugyWdGHGN99IoSkdBPm
	FH5VPgIuDsrDit4JfiuKdQ9vSCd/AA1ESkAeP7bSEc5I5HuruFVzjC/gid+Lz5cZSQQ=
X-Gm-Gg: ASbGncvQGZToLz266Pfj8oxOFEpqzlsh0C85rQccWTJSpTnRtAn/yp5Ham3iqRNK0Fy
	mlpDN8uBfMLa5iwEt0kW5s5tQ/+RxTO13QZCvEt9U9i84n9AADgTyin6YI+b6d5H+5jzFB52Uzc
	nLlgaO94MFxYvsoVG0LsiZiZXUb53elef/++urcytnp81WxfN0pavd2TUgO+NNpDPyIX42exwRZ
	HsYdvWR7BTvr26Z4F2CLIrgNnMR1WNPmj6h3jSgwQhkJeMjJgy5FQnCJzVbz2qgr3QyenoQkM2J
	6qmoBmVJraHVohijIbmJKs7nZwmo13+0uTZjrhnqNksdHWNgRZvCRVaaPS561Jq+OLZj9hHcqyj
	Vzq0caPNUhqXIkGgU5U4IsBfpixVU+9fHfNHnxDpM4HyZwa0z+99Qdaijs4gyzhWjmqqWQ4r/Y+
	f8ttjOpDpWGITk2vtym4s=
X-Google-Smtp-Source: AGHT+IERViLl8JWsqBiRvBQnkt+CyM86zrBZonOHrHEOXB8HhThhVqCeU64XpCcFS1zawD1h5Xuw5w==
X-Received: by 2002:a05:600c:450a:b0:471:21:554a with SMTP id 5b1f17b1804b1-4711787c0c0mr138571215e9.13.1761196279421;
        Wed, 22 Oct 2025 22:11:19 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aad668sm53195075e9.2.2025.10.22.22.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 22:11:18 -0700 (PDT)
Message-ID: <51af454f-6322-47c3-9e93-4fc07efc2b8d@tuxon.dev>
Date: Thu, 23 Oct 2025 08:11:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20251022194939.GA1223383@bhelgaas>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251022194939.GA1223383@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

On 10/22/25 22:49, Bjorn Helgaas wrote:
> On Tue, Oct 07, 2025 at 04:36:53PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>> only as a root complex, with a single-lane (x1) configuration. The
>> controller includes Type 1 configuration registers, as well as IP
>> specific registers (called AXI registers) required for various adjustments.
> 
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -266,6 +266,14 @@ config PCI_RCAR_GEN2
>>  	  There are 3 internal PCI controllers available with a single
>>  	  built-in EHCI/OHCI host controller present on each one.
>>  
>> +config PCIE_RENESAS_RZG3S_HOST
>> +	bool "Renesas RZ/G3S PCIe host controller"
>> +	depends on ARCH_RENESAS || COMPILE_TEST
>> +	select MFD_SYSCON
>> +	select IRQ_MSI_LIB
>> +	help
>> +	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S SoC.
> 
> Wrap to fit in 80 columns like the rest of the file.

OK

> 
>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> 
>> +#define RZG3S_PCI_MSIRCVWMSKL			0x108
>> +#define RZG3S_PCI_MSIRCVWMSKL_MASK		GENMASK(31, 2)
> 
> Unfortunate to have to add _MASK here when none of the other GENMASKs
> need it.  Can't think of a better name though.

Most of the register offsets and fields defines tried to use the naming
from the HW manual. Register at offset 0x108 have bits 31..2 read/writable
and is where we should be writing through driver, and bits 1..0 are read
only and have fixed value. These fields are named in HW manual as:

- MSI Receive Window Mask (Lower) [31:2]
- MSI Receive Window Mask (Lower) [1:0]

As bits 31..2 are read/writable, would you prefer something like:

#define RZG3S_PCI_MSIRCVWMSKL_RW		GENMASK(31, 2)

?

> 
>> +#define RZG3S_PCI_MSIRCVWMSKU			0x10c
> 
> Unused.
> 
>> +#define RZG3S_PCI_AMEIE				0x210
> 
> Unused.
> 
>> +#define RZG3S_PCI_ASEIE1			0x220
> 
> Unused.
> 
>> +#define RZG3S_PCI_PCSTAT2_STATE_RX_DETECT	GENMASK(15, 8)
> 
> Unused.

I agree with all the unused defines pointed. Will be dropped in the next
version.

> 
>> +/* Timeouts experimentally determined. */
> 
> No need for period at end.

Missed this one. I'll update it.

> 
>> +static int rzg3s_pcie_child_read_conf(struct rzg3s_pcie_host *host,
>> +				      struct pci_bus *bus,
>> +				      unsigned int devfn, int where,
>> +				      u32 *data)
> 
> Would fit in three lines if you want.
> 
>> +static int rzg3s_pcie_child_write_conf(struct rzg3s_pcie_host *host,
>> +				       struct pci_bus *bus,
>> +				       unsigned int devfn, int where,
>> +				       u32 data)
> 
> Ditto.

Will update both of these along with:

rzg3s_pcie_child_prepare_bus()
rzg3s_pcie_root_map_bus()
rzg3s_pcie_set_outbound_window()

that have the same symptom.

> 
>> +static int rzg3s_pcie_msi_enable(struct rzg3s_pcie_host *host)
>> +{
>> +	struct platform_device *pdev = to_platform_device(host->dev);
>> +	struct rzg3s_pcie_msi *msi = &host->msi;
>> +	struct device *dev = host->dev;
>> +	const char *devname;
>> +	int irq, ret;
>> +
>> +	ret = devm_mutex_init(dev, &msi->map_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msi->irq = platform_get_irq_byname(pdev, "msi");
>> +	if (msi->irq < 0)
>> +		return dev_err_probe(dev, irq ? irq : -EINVAL,
>> +				     "Failed to get MSI IRQ!\n");
>> +
>> +	devname = devm_kasprintf(dev, GFP_KERNEL, "%s-msi", dev_name(dev));
>> +	if (!devname)
>> +		return -ENOMEM;
>> +
>> +	ret = rzg3s_pcie_msi_allocate_domains(msi);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = request_irq(msi->irq, rzg3s_pcie_msi_irq, 0, devname, host);
> 
> Should this be devm_request_irq()?  Most drivers use it, although
> pci-tegra.c and pcie-apple.c do not.  Maybe there's some special rule
> about using request_irq() even though the driver uses devm in general?
> I dunno.

In general is not good to mix devm cleanups with driver specific one.

As it was requested to drop the devm cleanups from this driver (especially
devm_pm_runtime_enable() which enables the also the clocks) I switched the
initial devm_request_irq() to request_irq() to avoid keeping the interrupt
requested on error path, after driver's probed was executed, until devm
cleanups are called, and potentially having it firing w/o hardware
resourced being enabled (e.g. clocks), and potentially reading HW registers.

E.g., accessing the HW registers while clocks are disabled on the SoC I'm
working with leads to synchronous aborts.

So, I only kept the devm helpers for memory allocations, resets
assert/de-assert and the mutex initialization.

> 
>> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host)
>> +{
>> +	struct device *dev = host->dev;
>> +
>> +	for (int i = 0; i < PCI_NUM_INTX; i++) {
>> +		struct platform_device *pdev = to_platform_device(dev);
> 
> Looks like this should be outside the loop.

OK, I kept it here as it is used only inside this block.

> 
>> +		char irq_name[5] = {0};
>> +		int irq;
>> +
>> +		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
>> +
>> +		irq = platform_get_irq_byname(pdev, irq_name);
>> +		if (irq < 0)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "Failed to parse and map INT%c IRQ\n",
>> +					     'A' + i);
>> +
>> +		host->intx_irqs[i] = irq;
>> +		irq_set_chained_handler_and_data(irq,
>> +						 rzg3s_pcie_intx_irq_handler,
>> +						 host);
>> +	}
> 
>> +static int rzg3s_pcie_power_resets_deassert(struct rzg3s_pcie_host *host)
>> +{
>> +	const struct rzg3s_pcie_soc_data *data = host->data;
>> +
>> +	/*
>> +	 * According to the RZ/G3S HW manual (Rev.1.10, section
>> +	 * 34.5.1.2 De-asserting the Reset) the PCIe IP needs to wait 5ms from
>> +	 * power on to the de-assertion of reset.
>> +	 */
>> +	usleep_range(5000, 5100);
> 
> Consider fsleep() so we don't have to make up the 100us interval.

OK

Thank you for your review,
Claudiu

