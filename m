Return-Path: <linux-kernel+bounces-879328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A8DC22D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD36B4E7BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23622AE5D;
	Fri, 31 Oct 2025 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="iMipLv1m"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC54C81
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873383; cv=none; b=FqhJiD3tax9Csuv4xlSf4hpEpPWs7v0Bek3mqNfP3lq0S7v6xDF4pdlwPkI0uwRSqR0ihTde+3uQVF8hcRPwr+rg8XkDX7CAqzlpL98qfQe/IV7tYEHekMpZqKlU2jVySZCBISqUztL/czVzvMhL0XUO6pgRI/Jg6G6nklW3oM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873383; c=relaxed/simple;
	bh=4Q2e8S4JOkL/lipbI1pDbE41ejOeT3F2JXftXOKS9SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yugju5rBfSyvqfQU1JzLsAlpwq3rW8znvonUkeOjeedndMlPtnD/9/BOGjypctla5jAxBBYXXEVh/UIsnO2u6RM93IiRZtlJnoehO6l0He2CJrYiGgo+zYgVlPQ/9AcvlObBvXzPnR2myEsIamDcQvGjimx/LjiN7pz0IX5muPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=iMipLv1m; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-92790f12293so74298039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761873381; x=1762478181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNmWvB1sse+ll8fu7wLpbE6Pu2iBxbQUEY600bj95+Y=;
        b=iMipLv1mDx1Fjt+5AFoaW4WjxKtXSuyHyYXkC83im8Gj1CbZa7RQwQ42uDzZz8zRhS
         DDbhxScj3qaRPRvOP0ylTegZtYsy+dEOUnGcyKSPZS4pS/X1VfCqjjIKtoAIYGUAl//0
         wpAQalYv+W/bT3Ms0YrrCGF1ftueNbupOGSomXaOOjuNPDDJZG5rc/oE+TsRANIVvFZU
         ZG32wP4gXin7xFEsWfDtdQ3mRxO3om7AJDqaLxN3IAch/UJoEKCM6zgoe5+CNaWyq6tT
         1GyjcX+/lmgqDbbkt3fX1ZUVWpMNylQGmFxHmAsLUwIPNUd/2TwXjqeypIFI/G1anWs/
         kNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873381; x=1762478181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNmWvB1sse+ll8fu7wLpbE6Pu2iBxbQUEY600bj95+Y=;
        b=rzAQURZTtn1eA4+EqwZppX4cgF/mnEzpQQODTINGEMWaFENzwiS6cJyOP0/nCZqrZS
         wEwbMcb7KofwFcTCEZ7GKcSEFey1MygRQzsgcCC0CMWcK2LxVti2L3BOpXRW1E5uRig/
         Tea73KD5LVT49iDTbQscVqIBBgvR9SibFSVD9iSRY/ixTN19uU9qBizBnb7oKr1oMwb2
         Zp0Oz/Di8GdzpD3Wcly2J+u9WiprA4SeQAUCS7GD5hoLmcmXqrO4w5M1qqMJ3AJ78IP6
         BwzGwVRJdrq08iWiP80KpOAbfYcNlGUR373AzIG0YdnwoyKSSkZmUH59Q90IoEEFn0wL
         HMYA==
X-Forwarded-Encrypted: i=1; AJvYcCWCymfuOiIxwrB/ByskgJmdxYhpeaj6GH8FZIDZsQWsSK9DjlgHLGhYmYu6TF3+2JYVCNgjgcuw19xzjck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILABkABtx8KLK5Q7cKPwaoe6hJGeBhivHoGFNAG2PqvDIzAPM
	SkYFVybo1tSj5F8pB6kbMr8lqcXGOM7xxsz+kZIASm+eBKGTpRfGU5uEhKKNxVRjTFo=
X-Gm-Gg: ASbGncuYYanzvHkOcFl3grjDu8IAwrc50417cETbYvDcrbb5asQ6s/7Ql0RzWsmBYN0
	QA18yl1HaS0sNACPnkZ5hS9JJ1imFv3GlHcvf2qFQ995nXKi1KDtBYDWKd46lhVIrIM2GjoUPJG
	u5h3G+ikAwGWK7cjPkkR/tBrW4JSQ+iPs57LRUMPu7kb9wVT5Alfm6RgpJdsN0OpKyIiOTXG7oO
	P/2QJR7b5gw4M0BmvkNAVsrvEWvSGjaGVoN8ZXYRDH2dz0YsZQAQxXcS7Kg3Q0L+2yCNR+DCXWj
	GH8MFNhVSu3/Tpu+1MW6RI3UYWh0F9Lu/tCFbDSCX/3W5nFDhrqXjGmeXarb12wbhRbH9AePldG
	ORWDaclwnS9Widw3ChcdqIsf4TeiOBrojZFaCXDTAbAY6Uocol5KkvQ2M4M3ghFoG6RBCsd+p21
	enfp5OXQlkdUtSiqc2Fax8o2lqojafnjdqqN6Onm/2
X-Google-Smtp-Source: AGHT+IF4xxWwH/4LfxxdEtp/ZJLyhKDeHy5QKQAhJFjWBy4txu4y5k6mqZ7NiiibuaIjhND7W09bcg==
X-Received: by 2002:a05:6602:2c01:b0:940:d7cb:139a with SMTP id ca18e2360f4ac-948228fff16mr371985839f.7.1761873380679;
        Thu, 30 Oct 2025 18:16:20 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a5a981f5sm144822173.46.2025.10.30.18.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 18:16:20 -0700 (PDT)
Message-ID: <f1bec6f4-bf44-4cbf-a676-fa81d81531d4@riscstar.com>
Date: Thu, 30 Oct 2025 20:16:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] PCI: spacemit: introduce SpacemiT PCIe host driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, dlan@gentoo.org, aurelien@aurel32.net,
 johannes@erdfelt.com, p.zabel@pengutronix.de, christian.bruel@foss.st.com,
 thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
 mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 shradha.t@samsung.com, inochiama@gmail.com, guodong@riscstar.com,
 linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251030230801.GA1660222@bhelgaas>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251030230801.GA1660222@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 6:08 PM, Bjorn Helgaas wrote:
> In subject, capitalize "introduce" to match history.  Or you could
> just use "Add ...", which has the advantage of being shorter.

OK.  I'll capitalize all of them in this series.

> On Thu, Oct 30, 2025 at 05:02:56PM -0500, Alex Elder wrote:
>> Introduce a driver for the PCIe host controller found in the SpacemiT
>> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
>> The driver supports three PCIe ports that operate at PCIe gen2 transfer
>> rates (5 GT/sec).  The first port uses a combo PHY, which may be
>> configured for use for USB 3 instead.
>> ...
> 
> I guess this doesn't support INTx interrupts at all?

It can, but I removed that support first to simplify the task
of converting the original code, and second because I had no way
to test it.  I planned for it to be added at a future date.

>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -509,6 +509,17 @@ config PCI_KEYSTONE_EP
>>   	  on DesignWare hardware and therefore the driver re-uses the
>>   	  DesignWare core functions to implement the driver.
>>   
>> +config PCIE_SPACEMIT_K1
>> +	tristate "SpacemiT K1 PCIe controller (host mode)"
> 
> Move this to keep the menu items alphabetized by vendor.

OK.  I was going by Kconfig option name, but now I see
what you mean.

I'll put it between PCIE_SOPHGO_DW and PCIE_SPEAR13XX.

>> +	depends on ARCH_SPACEMIT || COMPILE_TEST
>> +	depends on PCI && OF && HAS_IOMEM
> 
> I don't think you need PCI or OF.

You're right.  PCI for sure, but it doesn't look like I make
an direct OF calls either.  I'll drop them both.

>> +	select PCIE_DW_HOST
>> +	select PCI_PWRCTRL_SLOT
>> +	default ARCH_SPACEMIT
>> +	help
>> +	  Enables support for the PCIe controller in the K1 SoC operating
>> +	  in host mode.
> 
> Most help text includes both the vendor and the product line names.
I guess I didn't include "SpacemiT".  I'll add that, and will try
to come up with a few more words in the description.

Thanks for your quick response.

					-Alex


