Return-Path: <linux-kernel+bounces-778358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A8FB2E49A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C61BC8615
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC5273D67;
	Wed, 20 Aug 2025 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sumfq4St"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066F23D7E9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713044; cv=none; b=jcz/gghmvg/MJHvLep3JzP0Jatik76MS3AHNQl/ihUqVw2izzIj9tbbyiuwRykZv2PkoiD3XYx40k8r+wqTih1BnjNI0RJDbWvePf7uhLbtVr6iPtvUALVrNXCF6zbtD5wR8GPnjSNbD1Cxem11OrafNJO+yuN3ohLSGcQ//upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713044; c=relaxed/simple;
	bh=Jg/VgEyT42KWxvINZCjMHCZ/of+8bVvbbQhxPcXjl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOhlgHaZfTs3oqP1M+/TA+/rn19l0VnOSaM6Q71ZTGBwNZv0Q0XoYMxFUbCvp5RArT3yboWsWyzF+YzPKhdfCfXKFz0Inu+2L5ew/J9LxkO6iI6JzQdUSElIyZ4ZD3YH5emuBEKAzc/hAkoO4goGxvWiG82bZPDoUZvTdYCstkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sumfq4St; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9e4106460so167237f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755713041; x=1756317841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aQKiEZF89L/ytwh8BhBuwbvy8+KDU2LqHLLeKh/Ywk=;
        b=Sumfq4StDzcB3vPuDWVPb6gm0MemO4D85VUoLjBrYlQLaJseIR0M9g6qsCejOr0JsL
         6V877l1YhG7EbBWcWskUo2bNIiqvh1cRpK+oT1ErSjtcOkyNicgj2wIEuQ2IqQ+Veoi7
         ileELKR0nmEwnIyEFI8UH9zEaV3WiXhcx8FGhNmQJ8jHKKJUVYrQBEp/CwcT6tUto7sh
         8tTMP5M0C+Vc1/FJCWFkhJi8UO/vkyUbwWQx7ZBR9FhDFJhfZCd2mf/2yzUom7o6EKWP
         GdXJ1nEGeG8Wvv84ppcneHZcnh3VZsL1ZO58dhp0s303G81uwZPVm37Nfi8dNwLtGaRw
         55fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713041; x=1756317841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aQKiEZF89L/ytwh8BhBuwbvy8+KDU2LqHLLeKh/Ywk=;
        b=hZI1DXidES19FiYgFWKZo85dTN75vJRoAvvg0iqMHGqW3brxA8G6Bgch3g1guxoXbJ
         nfGAUk72eoLiF5SsKPXHlsR+SUDr32g3AzXjYhdCDHt0XNHjdHZ+CoIkzZnArwIwPUs5
         T0A8R7P/3dcVNECikWvtunwcP4jkYSMZ/7ZM0XqAMSr8f560YJjcS3XQYB4kA1X95xDz
         hiEcKy9WwRaewXJY7SEFb39FE/KUXYlKuLP3+MZ0J2x4HX/wPyogu40ShcNXE87j8kld
         3CpQM+SZt88NVDKQb++v46sEYdeqNldb5fsKN5T2YsBrHZTwJFFd9UGIsOOgNgQn+FVM
         p1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGa0aUcKqc7LaAT8BSA+39sJ3hZs9uj4qZArWq9ywksC8hci+/sZ/d+r7Oor112DBwiBOy/NHzPjG/CJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxuEes0iFJjNp91wp+GL7FOzawioZs0xrgi7czRYHD6+smxzK
	UPvD9YWxwOc7pd1q0BQ3jo3UBYm82OH7p+HIFX7C8VE7qbgSn8SmD4LxvhfxIA==
X-Gm-Gg: ASbGncst3TFq5qCWUN8CWkmu/Fm4AMQ70ifGufzCBzTRgfwRZGNDBfNa1BBER8xpT+F
	J3OF04s/PJYJTMjCNg0jklLv055Pz6DyoXBS48tdvlNM6QfiXkML1ZKPYl6Cf/pAdfgfiGgoXcT
	A9ISmIJq/AUeo0W7gkGIK3HALrQ9YaOnt/iCWyHivQ3E7Vw3GTB2xYzcCx72GKzgCexhQUmUDM9
	vwAcxgdPiufnqbhLYotON2JGivASzScKtyNnAvUiAFqA3hx2+t7FAV1FKv1j9Q4mEmIA4RWLOrf
	+PY2x7RLnUH3M2RMGUp85RB0cG+UB3pJf4upV58EiRJEzsJ7yPmffkYYEt6Bl1dQX1sHuoSBdFA
	8ES1Ctu9iIOoX8/5Mwb9TQ9OpWYgwwc1h26OQgJFyeFTbI1HF9+h+GpD0uAJ72E8p
X-Google-Smtp-Source: AGHT+IG0u+MKLOgxtPHNTftiOrn8pO4TB5j9mVCfFWAyE7O/jO53VFoQY77Hmc5dH5GpR5IIdXrpBQ==
X-Received: by 2002:a05:6000:4b0c:b0:3c3:5406:12b9 with SMTP id ffacd0b85a97d-3c35406171cmr2539818f8f.61.1755713040657;
        Wed, 20 Aug 2025 11:04:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074e38d7dsm8490589f8f.26.2025.08.20.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:04:00 -0700 (PDT)
Date: Wed, 20 Aug 2025 19:03:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: joro@8bytes.org, will@kernel.org, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: use str_plural() to simplify the code
Message-ID: <20250820190359.2680af50@pumpkin>
In-Reply-To: <20250818035331.393560-1-zhao.xichao@vivo.com>
References: <20250818035331.393560-1-zhao.xichao@vivo.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 11:53:31 +0800
Xichao Zhao <zhao.xichao@vivo.com> wrote:

> Use the string choice helper function str_plural() to simplify the code.

This also changes (maybe fixes) the code my adding "s" for zero.

Although I'd define it as ("s" + !!count) - almost certainly generates
better code.

	David

> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index eb348c63a8d0..b5c829f89544 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -265,7 +265,7 @@ static inline int get_acpihid_device_id(struct device *dev,
>  		return -EINVAL;
>  	if (fw_bug)
>  		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
> -			     hid_count, hid_count > 1 ? "s" : "");
> +			     hid_count,  str_plural(hid_count));
>  	if (hid_count > 1)
>  		return -EINVAL;
>  	if (entry)


