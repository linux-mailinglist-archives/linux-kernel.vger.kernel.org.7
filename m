Return-Path: <linux-kernel+bounces-878309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA72C203C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B20407B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3804316911;
	Thu, 30 Oct 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mshna2Ts"
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D752EE5F4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830833; cv=none; b=k9Q+SmPwTqKa3rHZrdI3g7LNiHLX5ws3w1XJmCMQuNI3wHeQlOGjTM2lsnZ7RSlgmjqSytChZxV965JW6aUCCzcoyRIxzlmzng3M3kIw9Y3XlK2ggqVkzKAgleIxb7Z95+NePc16+7ObwufrOp31ZtzJ5UkBEUgU/13txlvk8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830833; c=relaxed/simple;
	bh=1qUD48hf7Zf4bL0s/Ql9Y1pI9LG/2BGYn8uIuRM7T6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8DmwcPvMqMcXf93dI69RXdtzO1rCzUwsKwU16eQ6SSZ7BDzg5cRzB2RMCsf8GHSGfN3c8sXG0JiqlMF3eQg6Fk306C1mMY+vn0TYYa+kYO2RpzPT0qWOtSa4ZxIbQwOkaW5ikxwyhwbM6ZEu00P9DOkl5QcLsqZAAZmFOOsvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mshna2Ts; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-78f30dac856so12015226d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761830830; x=1762435630;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMXWIu8U60uApRCrqyrIhfDspTa+9zuuI22qzRz3bTA=;
        b=QSEmJgXAJNl+3xRhcgRxVpWxkk/5/xtYhofKMVNZdQoqrC/Oi32WXMHjeL2f421f+x
         W9aTI4q5Hm63jCapzDmYtlzgaK1ziZWx18nUQuZgOgQ3mVSN7o2NCsrCiextuQ+Ko/Fb
         VWqoCdWVICu8S8lnstgUYKGYGYjKGauMccXJs76HNo2LptTXv5/PbUOB22Yw4evNfwvV
         eGnZOLkIeW6K8owpR5HS3UY2xk/6tQX5ilAc4SOAMeAgCLZ7tNlT4vdSFQg/Fi5668UQ
         BOXTK860rLsfy1myBG6yJe2IcfE/I+m1Wfq8M+LkDhx4fnKw7A/a0xMIzqC1DrXu6Gh/
         bBug==
X-Gm-Message-State: AOJu0YzLzVOgjldLaOSQR2ff4+CKy92cAVcrdKqw+BH9NQh7JWLwQozs
	8RxrkexmK32rzCXMIQFf4Rrw0n+ZlTVz+ip/UAAcE0VYj6H+BzyKc8Ni6U1k8xY8mS2bl2OTsHC
	5HQgeOGv63RuyexQBoEjP4kzlS6HCV4Jr8CNJxn3+blm8ZoftN/HgAQ4teWaeRAmxEFi7VaeVdL
	mRYHgebMj8WD+K7P636wkdN8FRNkUC2g3rAJeAe2KtmD4mYXuLBN5Jb+G+oXrgBioTEpoJDbbOo
	I9SRqn84rMZj4Xr3AjMvLAuug==
X-Gm-Gg: ASbGnctYe+AIR2pKo+dKdbye9EnzxcUz2K0aFAhnkkztTBFSSzT0lA4XM9VZq4WasPS
	hg/Rc1BprPJtRDW6I8ei6Q2Jj+mk81x9gh8wWh8YdfMLtni3pYmWhXyN/4p4zQhUFb9dc9utL5C
	rQCCvhIayHdXkDhYEWpPTuBmN2sLE9cX0B+ZODnErf918bOKHqJ/id1+zrpC2LOeKxM6gECp6rv
	XLV92nqaLRrYlNmbVf/E2Rq+b6EkCMHg9GvppGaqKVhzUHomhyViKb30FqjAfgkcGAutl1WI5ZX
	mOOh08su4OnCcrgqx588OkYqwy7EPSfzvMdTMVSw56113K2KMvtexXlo1dnq69yw6zlUDjWIN0n
	TQvU9sh/7IQ9dmN9UXeTkVEjtHEiHvsV4E+fnDqbLDWHUdJQOR5G825J5zkoJFVl+MnaL1rgCPC
	7tSCtloupRac4zu89xALowvpA/dC5zFmaPcA0JMVL5
X-Google-Smtp-Source: AGHT+IFJ1yRg6tFgTPogB6aJCSU8vwP0oQWbcEIjrJlqhh5D7Vn6aS7CY3t5JxZOWDETkyEjQ3UzN3bOz3Hp
X-Received: by 2002:a05:6214:226b:b0:766:3902:b9ca with SMTP id 6a1803df08f44-88009b28968mr96317186d6.25.1761830830162;
        Thu, 30 Oct 2025 06:27:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-880119ea5a0sm4041406d6.15.2025.10.30.06.27.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:27:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c0e0d12ddso26914916d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761830829; x=1762435629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dMXWIu8U60uApRCrqyrIhfDspTa+9zuuI22qzRz3bTA=;
        b=Mshna2TsQvVKIzAvgujix4VB32mru7m+fwrBly/loT9MWa+DeZy4JZpe9IHEyOk09t
         WLM0M9pFloTNiI2E5BCc40W46pXAslcZ4vZqqyxpSHRuIQJu9XOrV5DL9BFtJzzkGh1h
         4zxnWi5thbdAjmohHCIDYWaFQBmL3zFQtQNY0=
X-Received: by 2002:a05:620a:45a7:b0:82e:6ec8:9887 with SMTP id af79cd13be357-8a8e3b9b881mr886990785a.24.1761830828814;
        Thu, 30 Oct 2025 06:27:08 -0700 (PDT)
X-Received: by 2002:a05:620a:45a7:b0:82e:6ec8:9887 with SMTP id af79cd13be357-8a8e3b9b881mr886986885a.24.1761830828170;
        Thu, 30 Oct 2025 06:27:08 -0700 (PDT)
Received: from [10.176.2.229] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25e8685fsm1259974385a.50.2025.10.30.06.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:27:07 -0700 (PDT)
Message-ID: <17ed1078-772e-4c01-ba7c-63c58d89c0d9@broadcom.com>
Date: Thu, 30 Oct 2025 14:27:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Add null pointer check to
 brcmf_acpi_probe
To: Li Qiang <liqiang01@kylinos.cn>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Cc: linux-kernel@vger.kernel.org
References: <20251015071607.96415-1-liqiang01@kylinos.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251015071607.96415-1-liqiang01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/15/2025 9:16 AM, Li Qiang wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.

Thanks. However, it does not make sense to just bail out. 
settings->board_type will still be NULL and apparently that is not an 
issue. It is used to fill the firmware request (see struct 
brcmf_fw_request [1]) which is done for PCIe devices in 
brcmf_pcie_prepare_fw_request() [2].

So struct brcmf_fw_request::board_types array may hold NULL pointers 
which is not an issue.

So this patch does not solve a problem.

Regards,
Arend

[1] 
https://elixir.bootlin.com/linux/v6.17.5/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h#L67
[2] 
https://elixir.bootlin.com/linux/v6.17.5/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c#L2264

> Fixes: 0f485805d008a ("wifi: brcmfmac: acpi: Add support for fetching Apple ACPI properties")
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
> index c4a54861bfb4..f8f6433bdf69 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
> @@ -25,6 +25,8 @@ void brcmf_acpi_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   		settings->board_type = devm_kasprintf(dev, GFP_KERNEL,
>   						      "apple,%s",
>   						      o->string.pointer);
> +		if (!settings->board_type)
> +			return;
>   	} else {
>   		brcmf_dbg(INFO, "No ACPI module-instance\n");
>   		return;


