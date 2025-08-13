Return-Path: <linux-kernel+bounces-767506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6965B25551
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F71B1C8317C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939652FE57C;
	Wed, 13 Aug 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="jX9MmZ7X"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471282DE216
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120447; cv=none; b=OMxkpuSXdWIwQF+ENbEnhZOMJsO6Twk3WtVmfPHecq9BVaL1/486FWiUCMYohZJWLRz/K+CdKoXQvQSM4wKV0UTpTufqo+HgD9G0xdWcin0/r8n5rmvHc5uojNfPxbT4351Y95+KE/5u8+Q/dQLpR7LEc8ICPnJ7jpX9X0+Z/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120447; c=relaxed/simple;
	bh=Id+QsQELyg+pEjz6bWvXIyl5zJr/tcJ4oL7E4R2FyZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7hJUGWcj42U9zCoNGFotuo5EjHlc3PaHbjrcGT9X8gE1Szyq0cbEsdyOtaZ0eDUj6w5g67MvLVaB0DBsOm72PMC4s/KW9y90CDdcXsesi12aF0hVKDsGYskxxJ+bJbtM43RCjIWKMkH9ZDIoMr9nDMywyQsayksGuOp0PXhQCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=jX9MmZ7X; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e56fe7a3d6so2741605ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755120445; x=1755725245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrFzekosij5RO32ErAHxgIo8Kdw6RXeQrtvQE1dGiUY=;
        b=jX9MmZ7XBqH9fcrDEALVWSkpjxaHLhVzFCvKqRw6GHr7y98cToOnz/6PUGvpWCMsLj
         Vd3GrnuWV7wB/J+l34LUX0pby+NWaarYgTGK9dZT/g8WfnniIt1qRm8swyvjgAhZho3Y
         xKdswnj/J2J51seAr2vxAulnmPT8Ip3tEI0Q6zm1KLfcDJghaKlOvZBuMcDivz92yvn/
         ABJMBnk6XYwI666Jbt1GjELLJfYxoXxx6lz+ySJ1wZw0XbEBYvjL/p25dkLzpz7nx7TS
         k86kIykwrhjOsSRB65oGu6qPrI1IwBnIFoVIEZA9E6QhVMP1U26olLRw/czq0HZJEcsL
         DvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120445; x=1755725245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrFzekosij5RO32ErAHxgIo8Kdw6RXeQrtvQE1dGiUY=;
        b=HTQvDwFjsxfgzwKiOIVmgEeR1IZhshdS8hHmbvcyfwLQ+Ot8KnvNSyZFEJP/ZNl11R
         c+t51c2xFQnjCLDc2qsnmpOeHXoDftuj3k8aogdC8Rwn+NB1X6dGSpl8iewqKWB8mxfv
         +TTo6brh12gemNFarXIyKazC7pcru8PrzTmfj45FItsyOBzq1WCB/CQzG0sMprsE1qGD
         r9uaHWaS0g8lEW3qvpLtupNBTQAjJg8aK2JzLl4F08/8B2GvqIbI5/F5O4GRdL6SOUks
         7/YCGkY0NIBgWKQubAWaTnC8KYi4KGmVZtAIJXmnRdlYP3W8HkBxnhp9TXdNSJs74Y12
         iqSA==
X-Forwarded-Encrypted: i=1; AJvYcCUBTgFMHmcT97nwUR6/cKiDz5cQXHY1KozoQ110kmo6dOWqOCARVkqOXiswKwp+pfBxGX9jd/Js/olju4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4iGIMBFfG6yavoINr+7IYbQHrBSf3S5NBLwNnF1cZrsLRjWB
	fwlg+CMAWL+fnfx2wdAgimueOctcTHtjEezI5RWdPUp1n50FyEmKg6eqzimApWgNWcA=
X-Gm-Gg: ASbGnctjCqA4EPFTwzZRVXJIEA0YwMvQiFV/9Wqnqh9vqpnQxd0eb8rw8gJsrfXE1y2
	cYFUgxaX+L4G46Y7bUf9wvuX4dDnE9YK1SC2T+B7yYoD3dvgqLw15Q89RhZv5eY7SyZga/sd2uj
	3J/Y4eETtFXBJvtw8SY56WXzrnE5a8jsIFf5blAsf8X8yoEsAWzRkCcl5T1WBxscoqWN5kxlH6M
	lNbIk4AX/nFnMqdxfMFF7KfL10b33Or1t9qCZNNm7MWBzaSia2yj7+t21BdPhlX27IUuxqEqXrO
	Xd18MypsPFznovhHGaTVcqqPU5nR1oTw0eIxZEGPCt0wDme32AODM/FrKoKJcqNf5w/h7MD2oPH
	cGUapcBeFZP1QWiKyzBIHwINAAtaUD3hCRungzyFmUixfwhdYlq/MrjPFWE66qK4JDs3eIgxh
X-Google-Smtp-Source: AGHT+IHhxOnH0kTjTpaPF32KB8bFgpsjlYZNdzvmJrAc6sUo4I9UVSc/FXuQewT8WYi7PJE6uX0raQ==
X-Received: by 2002:a05:6e02:b27:b0:3e5:4869:fdd3 with SMTP id e9e14a558f8ab-3e570810a71mr11947605ab.7.1755120445360;
        Wed, 13 Aug 2025 14:27:25 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e56ddf9ad0sm4921475ab.34.2025.08.13.14.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:27:25 -0700 (PDT)
Message-ID: <5d5eacff-4c32-4df4-8da0-3b55974b74aa@riscstar.com>
Date: Wed, 13 Aug 2025 16:27:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] PCI: spacemit: introduce SpacemiT PCIe host driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de,
 johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de,
 mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com,
 quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250813212219.GA294849@bhelgaas>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250813212219.GA294849@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 4:22 PM, Bjorn Helgaas wrote:
> On Wed, Aug 13, 2025 at 01:46:59PM -0500, Alex Elder wrote:
>> Introduce a driver for the PCIe root complex found in the SpacemiT
>> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
>> The driver supports three PCIe ports that operate at PCIe v2 transfer
>> rates (5 GT/sec).  The first port uses a combo PHY, which may be
>> configured for use for USB 3 instead.
> 
> I assume "PCIe v2" means what most people call "PCIe gen2", but the
> spec encourages avoidance "genX" because it's ambiguous.

Yes, that's what I meant, but I did try to clarify with the
transfer rate.

>> +config PCIE_K1
>> +	bool "SpacemiT K1 host mode PCIe controller"
> 
> Style of nearby entries is:
> 
>    "SpacemiT K1 PCIe controller (host mode)"

OK I'll fix that.

> Please alphabetize by the company name ("SpacemiT") in the menu entry.

OK.

>> +#define K1_PCIE_VENDOR_ID	0x201f
>> +#define K1_PCIE_DEVICE_ID	0x0001
> 
> I assume this (0x201f) has been reserved by the PCI-SIG?  I don't see
> it at:
> 
>    https://pcisig.com/membership/member-companies?combine=0x201f

I hadn't even thought to check that.  I will follow up.  Thanks
for pointing this out.

> Possibly rename this to PCI_VENDOR_ID_K1 (or maybe
> PCI_VENDOR_ID_SPACEMIT?) to match the usual format in
> include/linux/pci_ids.h, since it seems likely to end up there
> eventually.

OK.

>> +#define PCIE_RC_PERST			BIT(12)	/* 0: PERST# high; 1: low */
> 
> Maybe avoid confusion by describing as "1: assert PERST#" or similar?

OK.  I struggled with how to express this to avoid confusion.
But I do think "assert PERST#" is better.

>> +	/* Wait the PCIe-mandated 100 msec before deasserting PERST# */
>> +	mdelay(100);
> 
> I think this is PCIE_T_PVPERL_MS.  Comment is superfluous then.

Excellent, thank you, I'll use that.

>> +static int k1_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct dw_pcie_rp *pp;
>> +	struct dw_pcie *pci;
>> +	struct k1_pcie *k1;
>> +	int ret;
>> +
>> +	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
>> +	if (!k1)
>> +		return -ENOMEM;
>> +	dev_set_drvdata(dev, k1);
> 
> Most neighboring drivers use platform_set_drvdata().  Personally, I
> would set drvdata after initializing k1 because I don't like to
> advertise pointers to uninitialized things.

OK, I understand that and will do it the way you suggest.

>> +static void k1_pcie_remove(struct platform_device *pdev)
>> +{
>> +	struct k1_pcie *k1 = dev_get_drvdata(&pdev->dev);
> 
> Neighbors use platform_get_drvdata().

Yes, that goes with platform_set_drvdata().

>> +	struct dw_pcie_rp *pp = &k1->pci.pp;
>> +
>> +	dw_pcie_host_deinit(pp);
>> +}

Thank you very much for your review.

					-Alex

