Return-Path: <linux-kernel+bounces-825068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C906B8ADA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5CD1CC34FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CCA256C88;
	Fri, 19 Sep 2025 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="dHsqH5Bg"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60723BCE3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305180; cv=none; b=aExM/NgV6cXPflYAs10eLsFTnbwUck87lDQjcEn4iEkDTblrPZCSBr4oFSXaMNl94YHLXnNCtiNODKWIjCRu/nUuRklwot74XLqPy0KT2xB4zwx0eNcj3QmAn6YpbUJaLvU+dQEg/tj7H3xF+Ir0fZZDpUEbgdUQVcxm6FoBzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305180; c=relaxed/simple;
	bh=hSswRjdQ+04+nrR+tOkaECVX6apGop8z+9eTH/YRAUk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d2eEW20CiCF6mRl0rMbWIe/2FY5HV0UCHXROC2bMKfHE3vewsb5tkzQNgHEfC2/K8ssEjTlLMi8GgiJOOeoYlYgEJMPmwJ0CdaCosl2KF61+qdWVP48mRalnQWmF0nz6iIxfQuIyRMbbcfz2mrfCIulh1zgOpFrHuSxvUc/ucSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=dHsqH5Bg; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8936326129eso91489239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758305178; x=1758909978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PyDhfnNhpXNHSy1fs/Ww3WtAuz4kktx1C3rWmJRS220=;
        b=dHsqH5Bgc3PjRjFN9w+kyyUTNDEg9aObIROFWI3lAPPiU0lvdg7ydYai3FlssN7FaF
         +/IVRSMTqPjOBAqcPjhdHLPFZ5pdh0o0pLToWwodTdgFmk1IshzHzx4hB8o7NTv+DPZg
         WE4Rw84f2b1fqfwGmHmD7yajDThRKQ9JEm9lUo5YKKK6ysBQ9ChNdBoib4byRNKJn3iP
         r69TyVwgl+YMtfd9qAHNUJTeK6J1O3yOSpzK5JAVFQ3B4RypIjxe3ICXWf0w5Zfh87u5
         6j03EF/K5n0GOzHTZ9cr5bYfTTHvKJoWBdqIfUU5butR+bbHTciazZz47E/5ktC9RQ7m
         8U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305178; x=1758909978;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyDhfnNhpXNHSy1fs/Ww3WtAuz4kktx1C3rWmJRS220=;
        b=VYXV4TlHbvoHcV6UG3szsKKuEZB8b/4c9r+Pk6U7h8IHCgm0AbTUS2rEj/RI409St6
         LALXWDZC0a2x8+pe1Nf4NUTgW9nk0VkEENmjgXovTlVgS4PF+vf9ikjMh/BLYPEF5W2f
         EyP8GfAqDDMx17tOzc8mkbhkBSEEGN2M2fy68uAycgfmSp42gw2PnEB352mnJsb0iIGK
         7YgNBzFf7FGfGd9mn3BEW8Qh/BmBZnsA70AdKFF2i6YMzSs/GYY+AGgS4CkvDvlg2YNu
         qL6fA2JQPimReVyrcwPtiCBthcq7ic1+cjREB51YTtEUL60KbQkr3jFkps41WkLFyqp3
         GkFg==
X-Forwarded-Encrypted: i=1; AJvYcCWxApNk+l/JSa5VzV5alDgC3z9zbRvfU/BW5TAqvETdCzHf6RJuy+xSpYZyJsOsFDJ8Pf2pn9LsdeEa2lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzVZGovM6f9q6csUS7yCE5bSqGUEM8K440sjMDh5WJmq5qp3Q
	6OOLw8lfX0b0i485hh7VzF1usDmDC+5lgid6nuLGGpKdIqoLd0LGpXmmlPnJAY36ijw=
X-Gm-Gg: ASbGncunipvpRVPVFJ4Evw5VZzMKhAOFwgFmLk4K6GrzWglxsnDneBoCWyn78QCUTCM
	SR/cGZe7AKt9QR/oWpXz4+hdCH9h7il0ihZa+n9SiX5U2ChGa4DnNFSO1QXbKVUfKNab+VyLELJ
	6mggoDQDvJsmENeKZycFs3iiYjk/vZWtLDydaB8e/QdIn3UlawphNSlkJe7IReiW994qZrgPsAV
	qKyYrZxUjAr6iSMo2pXLWmwxUFOGytZayU4wZ4hcofSHkdY8I9KCfGvJtPhsGwrsnNlvkMrC6s8
	pe5YIm4NWqu0/GtbQBKzh4hgAPFo5oFWp9EMJjVD89P19rgB073MdBLCLl3K9WBnwmegfwbVbz4
	jm9ilXzs4UasYtyhtv5GwPIfnVeg8Jc11BVGZMI2qgjovGQSFE/wMi10o71aZUw==
X-Google-Smtp-Source: AGHT+IHsassX7VCPU49903k7FzEDerinifFoBfyC5zAcBlOttmj7mzgkmLRJ6A7BaHGoGe18lpW13w==
X-Received: by 2002:a05:6e02:148b:b0:424:1c30:a3a7 with SMTP id e9e14a558f8ab-4248197c46emr68662845ab.25.1758305177594;
        Fri, 19 Sep 2025 11:06:17 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3a59103csm2326715173.6.2025.09.19.11.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 11:06:17 -0700 (PDT)
Message-ID: <5463beb7-9909-4cb0-bb39-9f2d1aa4d2fd@riscstar.com>
Date: Fri, 19 Sep 2025 13:06:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] PCI: spacemit: introduce SpacemiT PCIe host driver
From: Alex Elder <elder@riscstar.com>
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
 <5d5eacff-4c32-4df4-8da0-3b55974b74aa@riscstar.com>
Content-Language: en-US
In-Reply-To: <5d5eacff-4c32-4df4-8da0-3b55974b74aa@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/25 4:27 PM, Alex Elder wrote:
> On 8/13/25 4:22 PM, Bjorn Helgaas wrote:
>> On Wed, Aug 13, 2025 at 01:46:59PM -0500, Alex Elder wrote:
>>> Introduce a driver for the PCIe root complex found in the SpacemiT
>>> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
>>> The driver supports three PCIe ports that operate at PCIe v2 transfer
>>> rates (5 GT/sec).  The first port uses a combo PHY, which may be
>>> configured for use for USB 3 instead.

I'm following up on a few things I said last month.

>> I assume "PCIe v2" means what most people call "PCIe gen2", but the
>> spec encourages avoidance "genX" because it's ambiguous.
> 
> Yes, that's what I meant, but I did try to clarify with the
> transfer rate.
> 
>>> +config PCIE_K1
>>> +    bool "SpacemiT K1 host mode PCIe controller"
>>
>> Style of nearby entries is:
>>
>>    "SpacemiT K1 PCIe controller (host mode)"
> 
> OK I'll fix that.
> 
>> Please alphabetize by the company name ("SpacemiT") in the menu entry.
> 
> OK.

I will be renaming the Kconfig option to be PCIE_SPACEMIT_K1
(instead of just PCIE_K1).  I'm renaming the source file to
be "pcie-spacemit-k1.c" instead of "pcie-k1.c" as well.

>>> +#define K1_PCIE_VENDOR_ID    0x201f
>>> +#define K1_PCIE_DEVICE_ID    0x0001
>>
>> I assume this (0x201f) has been reserved by the PCI-SIG?  I don't see
>> it at:
>>
>>    https://pcisig.com/membership/member-companies?combine=0x201f
> 
> I hadn't even thought to check that.  I will follow up.  Thanks
> for pointing this out.

I inquired yesterday about this, and was told that this
will be finalized next week.  I told them that the driver
would not be accepted upstream unless the vendor ID had
been properly reserved by PCI-SIG.

>> Possibly rename this to PCI_VENDOR_ID_K1 (or maybe
>> PCI_VENDOR_ID_SPACEMIT?) to match the usual format in
>> include/linux/pci_ids.h, since it seems likely to end up there
>> eventually.
> 
> OK.

I will use PCI_VENDOR_ID_SPACEMIT and PCI_DEVICE_ID_SPACEMIT_K1.

>>> +#define PCIE_RC_PERST            BIT(12)    /* 0: PERST# high; 1: 
>>> low */
>>
>> Maybe avoid confusion by describing as "1: assert PERST#" or similar?
> 
> OK.  I struggled with how to express this to avoid confusion.
> But I do think "assert PERST#" is better.
> 
>>> +    /* Wait the PCIe-mandated 100 msec before deasserting PERST# */
>>> +    mdelay(100);
>>
>> I think this is PCIE_T_PVPERL_MS.  Comment is superfluous then.
> 
> Excellent, thank you, I'll use that.
> 
>>> +static int k1_pcie_probe(struct platform_device *pdev)
>>> +{
>>> +    struct device *dev = &pdev->dev;
>>> +    struct dw_pcie_rp *pp;
>>> +    struct dw_pcie *pci;
>>> +    struct k1_pcie *k1;
>>> +    int ret;
>>> +
>>> +    k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
>>> +    if (!k1)
>>> +        return -ENOMEM;
>>> +    dev_set_drvdata(dev, k1);
>>
>> Most neighboring drivers use platform_set_drvdata().  Personally, I
>> would set drvdata after initializing k1 because I don't like to
>> advertise pointers to uninitialized things.
> 
> OK, I understand that and will do it the way you suggest.
> 
>>> +static void k1_pcie_remove(struct platform_device *pdev)
>>> +{
>>> +    struct k1_pcie *k1 = dev_get_drvdata(&pdev->dev);
>>
>> Neighbors use platform_get_drvdata().
> 
> Yes, that goes with platform_set_drvdata().
Actually, many of them use dev_get_drvdata().  And I think
that's why I used dev_set_drvdata() in the first place, to
match dev_get_drvdata().

But in any case, I'll switch to setting and getting platform
driver data.

					-Alex

> 
>>> +    struct dw_pcie_rp *pp = &k1->pci.pp;
>>> +
>>> +    dw_pcie_host_deinit(pp);
>>> +}
> 
> Thank you very much for your review.
> 
>                      -Alex


