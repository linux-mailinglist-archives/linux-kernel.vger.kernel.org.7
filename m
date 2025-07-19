Return-Path: <linux-kernel+bounces-737730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF01B0AFDD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641BE566191
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D732820DA;
	Sat, 19 Jul 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUcuGw1K"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279B265626
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927746; cv=none; b=qGQE/jfG4XWzhpbxogDJWuPdL5k8aSa2LrPV7n832RRM5K6WwU+GKlOlMEC8EZycIe8y+1dNXgotRtqUMABo2dAote4PRaKek5sYHlWBJMxsMRmhGbbFSleuy1kD3B2PK/qyYHUYTlelGQ/IeL9a3uunWg70Hmb9wBW8Oop9Va8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927746; c=relaxed/simple;
	bh=wtepDypkeMhA64tc9jG0iqRcyYUTxF8RypHrWqLVaTI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=tY0rhyUh8+8G5MoGPYA50lszbxLdCd1i3wfvRyx1fju/KvHDN4bI+qW/6Vl8C0snaqQHS/kr7dXzJSL3hluanOEeBrfIRm+JqNgvxSbMLqRTqwCN0UGOC5ITHNEHwJcn4RaVol1nOJBmVefeMY+8FDbjf9gDIgfCE8ZNFNR3Sgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUcuGw1K; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b5165cf5so3471607e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752927742; x=1753532542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XejapKfMui5dDcjtSacWCje+GiKYXgABl5n7gmYNd4c=;
        b=nUcuGw1K1VBbQMZUuCkOCQgJSE8UKJpbsTE3yi8nbR9StsGvbeuQvFw/1qKJ0J0B5a
         4b7bHsuEQ1qy2K6c+qlYi22va/vn9rMPPxS9UX+aGL1UUDPSW/Tto8DVp8Gtf3OS/gOv
         TNZeGqBwdkoXKdwLCJkJ6+3a5YY65QXunBzbN1JKzlbP19BkeyAgtYEX2ZW0/cLee5ZE
         JHYpVwWzWFysZFvw0CmofaiQkjVBt68LUmNsAUarciqtJc34XCpSYQBV9rXJhC3ppVUP
         ymJySYW9ODUFjm9bGtTWH5xd7RSXgcCM5vL2dwZNxl+0XtMZ312kjMqlE4hI+hAOs0zK
         8qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752927742; x=1753532542;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XejapKfMui5dDcjtSacWCje+GiKYXgABl5n7gmYNd4c=;
        b=b4CbGHkX6wXC1b5/zyyIHmx05vtZhsTA1cNCaPpw4jA//u91JlsNv4t6sNyMqqTTzf
         zsctWCpeQv1+Eim/tq1dSh7zn8TrGDo9ssYWYkYmA6A8T8qODEf+Q1pAQAOFSuEa7ZCy
         7vW8pm4hurvpUHnpvPJ9+K5vaL66xVlDUjbfUad/ubmdBo0xZXBfKHuPPJ5DKZP7W0eC
         27jZc9NN5zFyyVK2wfOs78AXd354Nven2FzdoYQAQj059RBgYD98ElNAJ9Y3WNE01W7N
         S1SGyCVkcbwEuTKeRFoFj3pZXGvasklvLFUiMtIc/ByvrDXpDhewzRQkuHrDptYXvmGK
         fkYA==
X-Forwarded-Encrypted: i=1; AJvYcCUVkFcn26gQV+r+cT7ENsDUvGmppfhHP9pT3rSL4BG6avBfBrjx/mIXLA+IyRSH8L3kD7pC9Jumub1pgxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLb2iIrAkOC6fS8yjZAs8Nl4fwFyidhU73CKBMAq04WeombZcs
	mbFPFLTH/2P+/DoFp6kPNungJdGPwlfoFlQznOjA1NBmIhdzAMLTP4SYrvVxRA==
X-Gm-Gg: ASbGnctJ7K+/JOlrkbPFrQQCrlltdQLKwJ3dpm7XfAR0wAE2dWUUbF5dnEHwuIRQjqd
	i2xhWKRGfocGUQLi/qT9y7LjnGPVkfh4ZQO1CbpF/HerBLzCe443WuWF8tcJYrNMsVPLV5gPJZ8
	s05nsZIq7lrKMJTwX5CCDMyDGKn0JsTN+47riGlqbASCCGQIBQof3YuqoJgidPz9Bc/vgLE4V/D
	9rEYRAV95lq9rgpkxpeEeuf/DbNRESCAzMLNpKaFc55EC7ij76Ya1RFsPYzxsU7Are4Wq8E5Ye3
	N+mGysI1xezG5RNoWbc1yz9NC4H/2o5Pj34gpFPHVYt7QtfNVpTsC5Cs0B62kP66mu9l4JqfIP8
	UaMaPsxry2gIl4wYbUUZqI9u0fbPtANUhwHeJ7++NNjOL8zj7MlRLeFnM0Yb7Zm+tq/go
X-Google-Smtp-Source: AGHT+IExIvUt4AUHK/BAtMyUwdRrdq/i39wNguGi1L8V3/TvLfLayoPRPXW2fyRrq8SlDsgG4Yx08w==
X-Received: by 2002:a05:6512:78a:b0:553:2868:635c with SMTP id 2adb3069b0e04-55a233db5f5mr3346293e87.48.1752927742034;
        Sat, 19 Jul 2025 05:22:22 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-54-30.bbcust.telenor.se. [85.228.54.30])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b9c8sm709048e87.9.2025.07.19.05.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 05:22:21 -0700 (PDT)
Message-ID: <f2f794bc-7c0c-ae18-70bc-97c7ffa8e235@outbound.gmail.com>
Date: Sat, 19 Jul 2025 14:22:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH v4] char: xillybus: Replace deprecated MSI API
To: Salah Triki <salah.triki@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <aHskWESzZdyBFj4x@pc>
Content-Language: en-US
In-Reply-To: <aHskWESzZdyBFj4x@pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, and sorry for the back-and-forth.

Acked-by: Eli Billauer <eli.billauer@gmail.com>

On 19/07/2025 6:51, Salah Triki wrote:
> Replace deprecated pci_enable_msi() with pci_alloc_irq_vectors().
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes in v4:
>     - Drop devm_add_action() since it is useless
> 
> Changes in v3:
>      - Some checkpatch cleanups
> 
> Changes in v2:
>      - Replace PCI_IRQ_ALL_TYPES with PCI_IRQ_MSI
>      - Delete pci_free_irq_vectors(pdev) in remove function
>      - Add devm action that calls pci_free_irq_vectors(pdev)
> 
>   drivers/char/xillybus/xillybus_pcie.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
> index 9858711e3e79..c8b4cdfe695a 100644
> --- a/drivers/char/xillybus/xillybus_pcie.c
> +++ b/drivers/char/xillybus/xillybus_pcie.c
> @@ -76,7 +76,8 @@ static int xilly_probe(struct pci_dev *pdev,
>   	pci_set_master(pdev);
>   
>   	/* Set up a single MSI interrupt */
> -	if (pci_enable_msi(pdev)) {
> +	rc = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> +	if (rc < 0) {
>   		dev_err(endpoint->dev,
>   			"Failed to enable MSI interrupts. Aborting.\n");
>   		return -ENODEV;


