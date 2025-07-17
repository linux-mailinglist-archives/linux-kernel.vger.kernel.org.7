Return-Path: <linux-kernel+bounces-735382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876E5B08E87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECF73ABD6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60352F5C4B;
	Thu, 17 Jul 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkcpRQaK"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411621ABA4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760312; cv=none; b=aCHXj06jIzntrCuX0S8oKl/bY2Ue3GZdMtwDyLCXrJfeXabf4xehEb0DNoXXsRAbfxK6e45+YlQHginH2qLJSw87vHpwXZaLYlD/8KVVLxejnHfALELDIvU0xdmMczdGO9adIMqpKgXXnF3UTPteaDCTKMuz493e8Tec/fBj/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760312; c=relaxed/simple;
	bh=DO85ijBf3l0LG8jIgGNjtR/j3ap1WuRJvPU/3POmsRo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=IunlFQqKRoM3vsSD7DVuABsaPNA5B02PyV4hsrzd8Vcek7M+KmXbH9g8Lb52P2ekC+u538mIzgARPx0kIPx8dIpOxnyra7y5BP26rO+rz9QsEERMark2i8L9FApY/uxwxLtkkuNJX7kYwZIHuZP7PDcX1qiJsK/86mQ6U2nOcBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkcpRQaK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b5931037eso7260251fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752760308; x=1753365108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivIZdf/crFeNX995hheITSjMZ5wf3Dr1e9eaPnavoUw=;
        b=YkcpRQaKJjHwcAGt4iy7nSpewNoFtwfu4FpZ1t5TrJxZ7dtyqDH6Hh4Y1i/qvxUxou
         tWCHRKmykMxDpkCP6CSOx//fwcLppOkmcWlrEye/4g08J5Vc3rNd2rytsJ2Ex4a9aI31
         0o5/UNZHFhQ0rE8PYsel8bkAJ/eynG5LRiU6PreGC9EF8d9WClNFvDz3T18Y/ww9CDh+
         jokd3sodo6YfAhq6MJMJ5LPT8GM50I+2fkMCLl0GuUSQcOtX/sl6Trg0K+JutCrrQPen
         xPqoTzuLvV0In5TZ2RL0bMuvjFSCrUd+HBk0sVSE5VI6LpvlX6/ZxGf1UuQpAN3tnupB
         qKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760308; x=1753365108;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivIZdf/crFeNX995hheITSjMZ5wf3Dr1e9eaPnavoUw=;
        b=esYcyCWqkv+l7hqRsdT/iX/Kt41ZhywPOkFuECxOJOtYmTVeu6SX2wYxdIvqJ3740o
         ZZ+bU2xkIAwpFHZJcp4BAFw3GzUd8zN71a4aQ42Rw2kYYxNei73/cKdBgPG0PSW2mVeY
         roAXvL3BK+OW8LciSfxR3bkl1xkfNU7HDsRdZ1uDWCq88Rj6tPhun2OLfv6jNT5FkQ8E
         /EGvkdjYf1ndJbMSnD59c0wqfvJU3sNC7IcjCXhIpPRyXiI1Hcs9EkSIRp3FZm8k5KwC
         vyaJGEtVSXPM396B0EjztUyE9zUZpuIxKVZVnJfm0hHBjQ4DL3yhkEXy5DX3iYdlUAa/
         q5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl4tZc7QhRBD4oyzb/SOkYgoTFfk78POOBlBXH6vaCgP31mhgxuQhLU25qjaUa4SJAQc7gfTaS+CqW42w=@vger.kernel.org
X-Gm-Message-State: AOJu0YySVFGrPDCND1Dl7lBVaGbADrzneIgAOF+yGQy5T+jrp25wFIR7
	4kDRpzzut03vSoSYP7QGnM5UBse2fM9zZDmpTe5ucNfRC2KBaNMzR6ip
X-Gm-Gg: ASbGncunjHV4dQwHq9nx3DXHvMtGcL+PhbgyeKrNJZist7KoseYEYvJmZfF519s8pLR
	3NaxuPbYTizDLJ2Y7EYXsiVoOvnQNP5l6saQz79YeKWB38Oo3XBDUa23mf3VuieFmMFB1QpXTGE
	z7MA5BQbIpxgpNSEbxgB4KIQA0GH8X0virUD9hb8kNEX0v52wvQ3RWGON8gU9PrjOHoICYhUvom
	oOBmD4V6iFKpcMLzP2+lNXaYqib310/WZVtwiJ2N0t0JOzU0WWAjM8C0GIwFq+mVKfb49JhV6e3
	mGKavbZcjWO4HHr0k0ckH+lqi/CNmd6E+Y1nMq8qNmFJHwNVt/ko4OPBHSNNz80iIukebnwyHW9
	92tBwf4hZcyXNfk6SBEkLeS5V+P0CYkuh1RRcnRHRdbhnRwY4deeNbSJanw==
X-Google-Smtp-Source: AGHT+IHVEJFgeNixBZTanuB6ZWr0QH+FMiKXCO72FKkgbsWC3FCLFSs3a27JmolNAUWbZI+Rvg9Nbw==
X-Received: by 2002:a05:651c:41cc:b0:32c:a006:29d5 with SMTP id 38308e7fff4ca-3308e36bde2mr23738881fa.9.1752760308125;
        Thu, 17 Jul 2025 06:51:48 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-54-30.bbcust.telenor.se. [85.228.54.30])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134e3sm24419841fa.11.2025.07.17.06.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 06:51:47 -0700 (PDT)
Message-ID: <aed95641-4c95-5fbb-f359-885a3e2144f7@outbound.gmail.com>
Date: Thu, 17 Jul 2025 15:51:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH] char: xillybus: Replace deprecated MSI API
To: Salah Triki <salah.triki@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <aHf_88zgSElheIZ-@pc>
Content-Language: en-US
In-Reply-To: <aHf_88zgSElheIZ-@pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Thanks for your patch.

I can see that you've chosen PCI_IRQ_ALL_TYPES as the selector of IRQ 
types. As far as I understand, this changes the behavior of the driver, 
allowing interrupt types that it shouldn't...?

Another thing: I have to admit that I missed the need for a call to 
pci_disable_msi() when the device shuts down (which is what 
pci_free_irq_vectors() effectively does). Thanks for bringing that to my 
attention.

However, as this is needed, it must be assured that this call is made in 
any case that the device's initialization fails. This driver is using 
the managed device API, so I suppose the correct way is to add an devm 
action for pci_free_irq_vectors(). It appears to me that just adding it 
to the remove method won't be sufficient.

Regards,
    Eli

On 16/07/2025 21:39, Salah Triki wrote:
> Replace deprecated pci_enable_msi() with pci_alloc_irq_vectors(). And
> add pci_free_irq_vectors() to free the allocated vectors before removing
> the device.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>   drivers/char/xillybus/xillybus_pcie.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
> index 9858711e3e79..fc7bffbd36ed 100644
> --- a/drivers/char/xillybus/xillybus_pcie.c
> +++ b/drivers/char/xillybus/xillybus_pcie.c
> @@ -76,7 +76,8 @@ static int xilly_probe(struct pci_dev *pdev,
>   	pci_set_master(pdev);
>   
>   	/* Set up a single MSI interrupt */
> -	if (pci_enable_msi(pdev)) {
> +	rc = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (rc < 0) {
>   		dev_err(endpoint->dev,
>   			"Failed to enable MSI interrupts. Aborting.\n");
>   		return -ENODEV;
> @@ -112,6 +113,8 @@ static void xilly_remove(struct pci_dev *pdev)
>   {
>   	struct xilly_endpoint *endpoint = pci_get_drvdata(pdev);
>   
> +	pci_free_irq_vectors(pdev);
> +
>   	xillybus_endpoint_remove(endpoint);
>   }
>   


