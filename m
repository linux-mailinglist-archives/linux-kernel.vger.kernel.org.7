Return-Path: <linux-kernel+bounces-838355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68DBAF04D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D119323829
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C427A913;
	Wed,  1 Oct 2025 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NxXYjlUl"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7A27A917
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759286422; cv=none; b=VhhJ6abIY5xSGlAhmWWafldYrgNTSeZdsnXxlW7gkvoeABtc65ANp6I3BEZBADxhxni6ioGjO8lruDESElwicnKy9rAeLziv9fQljwb1AzQIXlN7ATp8/MeZxbz3SQCIhCTJzCP+eYoBeZ0FKouw9A2QCOlFtWRrHJnNDmQ0i5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759286422; c=relaxed/simple;
	bh=95ml47WxKM7OsxOqgZUIEYLPG88WDEDiHa7cU33WvXI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OVooLzNFgOzlPjqeYVPwqPcJBZgWkAfE9KD8d08xtPS4ZgU95twiXOhe6l3y4cmehG94p6QbLOlBNm/WFifcoOcfZuZSfG6ffbZ08zUlPlgdO5M03iJbri8R9OiRFTCITXAdBoQI4+KzWND6HQfaYJonvVzAtmVSWMWLsJRzkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NxXYjlUl; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-92613b9b1d2so124244039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1759286419; x=1759891219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BSiL8LGa2xahx7enK5ghNLiWs+z0ni4QqOBXClR3tWI=;
        b=NxXYjlUljkP1Y4EYOj4P3DbayC6sN2bH9FwfczVDPoJaPX6HRxjT4kiuCJYc9Z/sHF
         yyPzlKef4wdM69tma8IXC65CndjzmqtdP3S1DD8g6y6uHTtKgWfAbwCDKp9X1fLHuzwQ
         iEIILzaamYv4CF9ZW0No5xMAPt3vzOWnQRA780C4lYRVcqKWDoB4370SDuNx4UUMAcLe
         YowYJedKWvOR7AV3pckDq/R2l1d3RMg5zllc7X2GlnCw+BBnqXLQ7XD6m5wctnvv2s1w
         Qrafy9quKT9NXxKcEK6p/5gdQbyMtDkqSVNPtpkheS3nMnrS9iG9DwTX5tu7XjBiWL/y
         39Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759286419; x=1759891219;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSiL8LGa2xahx7enK5ghNLiWs+z0ni4QqOBXClR3tWI=;
        b=VSIT8N+MwpByUypsYtzw1bP0b8sFLcVoCG0zGsnVGnstLReflgA1I/1rV1Ys2fb76i
         b28Xkqr/gY0q/jJ+l4y4jxs9+HYVMsNJB77AYJ5RXRhDDCVrx9bX2l008foPQxHOHto1
         bv7OqpYBIEFdkRIuOl2Py5FUwDCeVeQ6RPUVL2U4Ph+UxFkZswXsa/VvCGUIfnnzuBKq
         9fjBzilJ25ahkkz0PJ55VREiWsGN7gTJNfB1dRAyT9VKovT+gfCLrCAU2n+nHQjmdiCY
         AtSdkvI1ksy+FpsRIvU82ev8YwHOlKa98dRQmopUo3DrRCm2pwtvIFatHHo3yh1hPNVi
         Bvpw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Cg9V99Pd4hcd8yUgPNtGajIUsYzIAqcJ/7dKFUh0BMFRs5uHWWs04cYXvJO222ELUqZvwC9aTxhZ1Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXxmaXj3sMv2SEd+Wkchi2Wgtq94GXKhAQ3tvpek/vpyetmw2
	ulM+k0VwRS2hVuTPyGe+P265+93bn/owun47wMgJbDIBMdw4oqAFAEoPzfr9BnpWhfE=
X-Gm-Gg: ASbGnct7gZaZxpITsfnQdo8ahNCBw7saZldyhuqHa7BxUJ6I3tfPra6gxp39yy6B2+7
	fjJBQDH/3xm3ufszvUiQPCot83qsWKNu4Lc8Bln53Ip1A7mAr6d8kZ01OI2gZAwD512vFo0bw3k
	SqQATbJNZt1HNSpFpmP/hfPLkTRtoswsO7gnkXpAo/gl9qRb+7kzSN6SZKKYMLolFQvLSMhp23+
	b2+syXnQCOyYVuGsCO9KjSuHtF45Xg4EV8PqRNWKPI2lC4PmkP4Yz7I14rzgaUddVJU7O00ziEQ
	GOaosqHzPxvCJ+dqbDCkBCUxq+9jjdqtFs8mHyt/h8yrRFkV+VMPWPoeVbcFVp7w0nkAj50tDCR
	lDkJ5s4HkpF5MJqE3pUse+YIO60DotLNAtO8SrL2w0lTKwn3s+7fIT/1UYGVzgCL6LnGFyInP0a
	IBzo6GDddm4jFAu31mPyi7
X-Google-Smtp-Source: AGHT+IFnQ4AKi2u/W+a6GpDqwlkdiwJEehpu9YBKfYz9D/hyyMA4l6KRgEzrqCbvLsuK4qiSaJzeAQ==
X-Received: by 2002:a05:6602:6287:b0:922:6c20:45ef with SMTP id ca18e2360f4ac-937a9ff849bmr348732439f.7.1759286419402;
        Tue, 30 Sep 2025 19:40:19 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-92d06cc3b9esm184392139f.12.2025.09.30.19.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 19:40:18 -0700 (PDT)
Message-ID: <4ead7693-4174-4494-b997-c0e4159809af@riscstar.com>
Date: Tue, 30 Sep 2025 21:40:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] PCI: spacemit: introduce SpacemiT PCIe host driver
From: Alex Elder <elder@riscstar.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
 bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de,
 johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de,
 mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com,
 quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-6-elder@riscstar.com>
 <sptrmspkmqrwsh2iv4rmha45vsoz5ks7vhcdp3dytsxyabn6qn@mmk7z6tf5wcv>
 <21ad322f-5abe-4a97-9373-d027b846ee8c@riscstar.com>
Content-Language: en-US
In-Reply-To: <21ad322f-5abe-4a97-9373-d027b846ee8c@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/19/25 5:10 PM, Alex Elder wrote:
>>> +static int k1_pcie_init(struct dw_pcie_rp *pp)
>>> +{
>>> +    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>> +    struct k1_pcie *k1 = to_k1_pcie(pci);
>>> +    u32 offset;
>>> +    u32 mask;
>>> +    int ret;
>>> +
>>> +    ret = k1_pcie_toggle_soft_reset(k1);
>>> +    if (ret)
>>> +        goto err_app_disable;
>>> +
>>> +    ret = k1_pcie_app_enable(k1);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = phy_init(k1->phy);
>>> +    if (ret)
>>> +        goto err_app_disable;
>>> +
>>> +    /* Set the PCI vendor and device ID */
>>> +    dw_pcie_dbi_ro_wr_en(pci);
>>> +    dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, K1_PCIE_VENDOR_ID);
>>> +    dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, K1_PCIE_DEVICE_ID);
>>> +    dw_pcie_dbi_ro_wr_dis(pci);
>>> +
>>> +    /*
>>> +     * Put the port in root complex mode, record that Vaux is present.
>>
>> There is no 3.3Vaux supply present in the binding. So the supply is 
>> guaranteed
>> to be present and enabled always by the platform?
> 
> Actually, I don't know, I'll ask.  Thank you for pointing this out.

On the Banana Pi BPI-F3 platform, this supply is always on.

There do exist other (SpacemiT K1-based) platforms that enable
this supply using a GPIO.  I am not able to test that now.

However I will add a property in the DT binding to indicate the
3.3v supply.  I see "vpcie3v3-supply" used as a property name
and unless someone suggests doing something else, that's what
I'll use.

					-Alex

