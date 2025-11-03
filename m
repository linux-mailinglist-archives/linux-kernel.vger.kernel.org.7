Return-Path: <linux-kernel+bounces-883387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6801EC2D4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AB7461F58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB57031A561;
	Mon,  3 Nov 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="iqSloNE4"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77030DEDE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188676; cv=none; b=syaDpaM87EK1yJq6OTdKSJZXVBLHvJTRzswgCTweEDzfPG/HJ4+GO0htvNerZvbSCTk8ImQty6bCigCn94gNpUeNvzqwXQlNs74p6Pe2V5MhESDltQkucMt1yegUjwGBGhkN1Om9k24S8qzLLk62Vy3HfkMLZ2OOcXqR2C6+Sws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188676; c=relaxed/simple;
	bh=9X5qYxyuX7GnNfRV7eA4zSQai4y1CCQShsSie8Vm55M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kmjHZM35XKBDyYOoFwAvKp8CK++QgII4VDYJHqOwVcjheS2kRRBaZmYksLnsIlE4T5C5brv+Fharm3yQ5jIDHJG+aH1gKc1ZeO7U0l8AYAYWDyMGQjUfiHHhyobbsRED01238CFOBa1SDjkTdgzPRFxI5dJn85SXTVgYzVq3V/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=iqSloNE4; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-940f8a73275so498879539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762188673; x=1762793473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ZYP6s7A0e6t6qMHErZJUr+ea4gjElbTNwHT5ZSG9V0=;
        b=iqSloNE47jdELzksVc0fnuz9fogLeKwgmZivkrfyPb7yGkOcOG6P0FJ/Rn5QgSgC1v
         49D7ExByxsmTH/H5jv/jfaeADVKncryNbXx+ntFypxjqLNMx8iCxkdn0D5KrdWVkiUjX
         Phpqqi9HU5CzjsH85qeDJNSkuirer2Qu8tcA4Dsc+6dRfNbWIljvwgbDyTEbdgKgI4e1
         pcbwx2nXRMoOch2a4fYUX/Z7qdedILVVBzTALJ+AMI3VfB4C7olxHjDa74u1bAvfyBPK
         u8xJLKmKRMr0OGMHDRKqb3W5s4sYL1lodGRx9fohAMSRuxKXLVHY3pRSuNBMABmIFBYn
         3vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188673; x=1762793473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZYP6s7A0e6t6qMHErZJUr+ea4gjElbTNwHT5ZSG9V0=;
        b=YGo9L0sU7u3kBLaliT7jGUC24OYGHJ0dYy8YRyZ7dlPJw6CcGmUCmJhknuZLSJEaSl
         wVeHSH75Vuswch2Tfu8cg66oaZQ3ycu3k4COptOIZZTxUqDFh/syoTaMOOHWR0UQQnF3
         buB4QIhVmTMECLIaOPctcMIgKbZuXRI6AluhnwZHSTHzkuihcOzDTjFfFvmsLwXqATyW
         Np97It8/TIAJVseFqI8RDdOCIypqeLeqV2TBxW8BGs7UIy059BQMHFVMZBN76rdu0Ncz
         GjK6ldkJMwHor0X90oGWwRt65EfLzRe8hjQad3ZazHn3aKvNHebGk+2qz96//rv9asFH
         ji5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHq74NA5D4tL1KUHVBax+xai2tenjcnRLmBMKv9Dw7t6V/EaFLEvS+MUZ+MGNuf3kl9p22UtJyvaW+kp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3D1qXIk+Ar3UxJO23DW3Aw/dUHbc7CsdhYZNL5Sfp2MgWIDf
	rs6s1Bo/rmYds1tC2SeMFCX0lkiZ9ZX8PF90EyuUSQB1p3+ZdVLwfQUBWH8heVlfPUY=
X-Gm-Gg: ASbGnct7KmCFgkc+36HxK2GjdGy1umGU9HOGyr6OJUFsR9v2niWYlvjR5piJKwWfW7q
	mIYF0t/RaKC0/Iq4QCOT2iGAHV7br4XYb9dcSaXIW4vDdge9pkmx61G7G3KuZ242L2/Jw+V16PA
	rubuHI+8v4jIbGI0lsQ+Bhm8ZP9LutgcLA+ij5CSTtO6uiQY7W6YC8wCnRxzhBZiYdyfzM3M1Vb
	mXeYKHYPn74J8UvkrtrUaoZHi/53hmjwQFpWtnq2YtVhx6X6xo3S+u9SnvaYmIz6sbRONgkmC7L
	8mYsBQf1WgM2jlcAWIr/mzkIGlmWx5dd+iFtp0JKXmDCgKeecK4Jox710LHkS4PblqrlCf46l7R
	J7CPbISRlrdRzGY8ABoT8iXqMLBQO26op3fAymOFWGsxRtlXil8GTnJqqPsDkSWtguU/En/9+Yf
	2GsQz/j6NhmN6nHeaONvPh9cd1krveU/oDvx1VTPf4x3XZ7j5Fn24=
X-Google-Smtp-Source: AGHT+IG3IvG/mEvLf0CP6EjG0xRAhCkqKP6lfBEvoWKsucXyQJGlFuxO7exsoiSwRmrN+GNPUYV9uA==
X-Received: by 2002:a05:6e02:174b:b0:433:2d6a:ec2b with SMTP id e9e14a558f8ab-4332d6b190fmr50614775ab.24.1762188673045;
        Mon, 03 Nov 2025 08:51:13 -0800 (PST)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7226ba48dsm324005173.49.2025.11.03.08.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:51:12 -0800 (PST)
Message-ID: <6872beb1-f27f-48b9-a756-5b7faa380cec@riscstar.com>
Date: Mon, 3 Nov 2025 10:51:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] PCI: spacemit: introduce SpacemiT PCIe host driver
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, dlan@gentoo.org, johannes@erdfelt.com,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com,
 thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
 mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 shradha.t@samsung.com, inochiama@gmail.com, guodong@riscstar.com,
 linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251030220259.1063792-1-elder@riscstar.com>
 <20251030220259.1063792-6-elder@riscstar.com> <aQU4rGzrB1-Vu7C6@aurel32.net>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aQU4rGzrB1-Vu7C6@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 5:31 PM, Aurelien Jarno wrote:
> Hi Alex,
> 
> On 2025-10-30 17:02, Alex Elder wrote:
>> +/* Disable ASPM L1 for now, until reported errors can be reproduced */
> 
> Thanks for adding this function.
> 
>> +static void k1_pcie_post_init(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	u8 offset;
>> +	u32 val;
>> +
>> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +
>> +	/* Turn off ASPM L1 for the link */
>> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> 
> Why not using dw_pcie_readl_dbi() instead?
> 
>> +	val &= ~PCI_EXP_LNKCAP_ASPM_L1;
>> +	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> 
> And here dw_pcie_writel_dbi()?
> 
>> +
>> +	dw_pcie_dbi_ro_wr_dis(pci);
>> +}
>> +
>> +static void k1_pcie_deinit(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +
>> +	/* Assert fundamental reset (drive PERST# low) */
>> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +			PCIE_RC_PERST);
>> +
>> +	phy_exit(k1->phy);
>> +
>> +	k1_pcie_disable_resources(k1);
>> +}
>> +
>> +static const struct dw_pcie_host_ops k1_pcie_host_ops = {
>> +	.init		= k1_pcie_init,
>> +	.post_init	= k1_pcie_post_init,
> 
> Unfortunately, while I can see the effect of the change with for
> instance lspci -vvv, this happens way too late in the device scan
> process, i.e. after pcie_aspm_override_default_link_state() and causes
> L1 to still be enabled.

OK thanks for this information.  I am going to contact you
privately to get more information on your errors (and those
Johannes is reporting) so that I can try to resolve them
before I post the next version of this patch series.

					-Alex

> 
> I have tried to move it earlier, in k1_pcie_init() after writing the
> vendor and device IDs. This works as long as "nvme scan" is run in
> U-Boot. But if I don't run this command, it seems that the change is
> ignored or lost (i.e. I can still see L1 enabled with lspci -vvv).
> 
> Moving it at the end of k1_pcie_init() works fine, like moving it at the
> beginning of k1_pcie_start_link(). But my knowledge is too limited to
> know where is the correct place.
> 
> Regards
> Aurelien
> 


