Return-Path: <linux-kernel+bounces-846279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFFABC776B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1FC4E2E77
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB6261B9D;
	Thu,  9 Oct 2025 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOfDOFHs"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D923909F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989084; cv=none; b=SUe4DJ9lp8ByUTzxtcgrxZBWqSIow4FGG1j0HWwq9awdvozWw+OWZuDUaQ/cJFkAtyYHm0yKl/10/ilXEtpTRVnYBFWwnzKG6LdfY5JzRPhTDfOhgG/7sVVMqQq9ycmA4w5NNVDv+agtOILroYlcGU4dRA+hOe5Kr4wodYYB32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989084; c=relaxed/simple;
	bh=sJApoGWiiM7TfhpCO3WW2HApEZkmUqf/CSSTe03auiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNLBM+3/ljuU9YNg7X0GV1JxeurAcdck5hZqazXl/BpQ5Bwts6rQTXqLj8biw5YJiEfS2hHVDN8+APYGr7tZH3dIlQvLLMmhfAaXPwcIPbr5z7WM/NZeAMdYJRgCLp1X6g7K3b9Ho0KYint8LPbcOkrf1mpxFwU8WQh70EYGNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOfDOFHs; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so557722b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759989082; x=1760593882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1a1TDh3vUApkUWx9qh/h/KReuHUESkpSiNwCDqzWo4=;
        b=iOfDOFHs+t9/d8eEXk/FrL9sb4AZAu04Xxi6vHVVLiLX9zgu0iF3XqEXIODKHZJhbT
         ESjx45aYd0IVFSuPQM2KTPHFi3pZnAJgJ5NlA+QDkqViSUazHNmR8FY+YJ/FgnD6ZaLQ
         dP4jXEAoxYq0wqLMBrbdQApCu0FJGqGnig4Wl8ci000ESdVYflDh0fNsvYx58zApDL6L
         tfwqRADEv7XKUveRK5UBZwWajgxRGW8VXgsGw3ZWmytyaO0fLb7abd9m+5R6UUaBK5dN
         Dtt043ZMexSv6PkDHfUMOVer3upwE2D4V5U8ontCuOLB/Ny12ofp5SEFE3vf9PM1373B
         hOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759989082; x=1760593882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1a1TDh3vUApkUWx9qh/h/KReuHUESkpSiNwCDqzWo4=;
        b=bFcIBL/Q/+BvI4o/Sml0cPIBiF+K6/E7/jKgiU1I/SKImetFoDEPvvsomnaXHw4k7m
         Jxr5GrgpXqqbs5dlCM8vvuLAwXDWyzMwRYXcl8e4DLdBK/8PXVMJOJVPj+uMgR06C/jU
         AQSkIodiJIFI6fmXrCbnp/hGe0x9nuNs0wwiX8kkp/YPs2iTWvOZxlbKuHhGheQv5IKY
         A90z48J7OVvCOPoXZFuZ+V1hT2QMfferA0rMwhEwpDuGPBGkrCejCq139HXcfZ81IzcP
         DAbVwvAPZe+DE5sH/WEmKuA8ynkDu1/AXVdEgXcEQYz6bRtAFl5HOi6yDHx8PuxRtJu3
         X6uw==
X-Forwarded-Encrypted: i=1; AJvYcCVivJh5h8Kb3k8/WiI3Xnsfpjikxor0B6e6qvjWjZAYzy+yrUbu6M72Xutv0uiHeOjATytT8fkkDZXblQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/vielwk+yIwk9arTjY/6NBmUee5+9C8oEckd9Rw5twQgIA7R2
	D0LR4Qci/G1kOEfm54Leo13rjuHZmxn4AjASiiGtXigM9JiHHFiHWb0D
X-Gm-Gg: ASbGncuyWAXD2JWTNtQuaurLvNmACIqBjab0oV5neMjqFAEdw0E5kywbljv52/3wtbU
	m2Hs8GoOL6PAz8P4YQR3nbaDta9lRl7qiQVJI/3gSqKOLYGgw+Q1bKE/R/vYN7HdPmpce0kvNRi
	8ItkdD31QKvv5Ja+L77xZ2yblBMsk0ARkKXny2funM2Okeu8JvqQj9ptHKk3GOEpRY+wDACuprq
	jpA3xRlfvsA0c2AOq682svIIcP7bLvrK6Rwrwt42Hhn+jUF9oWAq7jgFEOE0VdaO1smAJEWf5Hv
	Oma2eCk0UctH+1kWpOhS7mPHpYgAXkxuSyQvzd/7oFP7/csUKKI09EB8bf6K9IIeUgpHxeJ2eUz
	Wy4XZS6+2vVmbdK7drL3rGTVyt3BIX16bwhQwmQTiJPmMOsgGFwsStLZiYToBn+CW9vR470qcD/
	h3bA==
X-Google-Smtp-Source: AGHT+IElmlz9QnBe5OufyD6FnmFGzS7kcpowIwzns6/xXPnYi+RiCvWvyjbf/ljE8+s/ouEADwIAZA==
X-Received: by 2002:a05:6a20:3d94:b0:2e3:a914:aacd with SMTP id adf61e73a8af0-32da80bb99cmr8268979637.2.1759989082478;
        Wed, 08 Oct 2025 22:51:22 -0700 (PDT)
Received: from [10.0.2.15] ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099d4cfbesm19950324a12.28.2025.10.08.22.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 22:51:22 -0700 (PDT)
Message-ID: <162ad81c-a203-4196-985d-b48a6afeb4d7@gmail.com>
Date: Thu, 9 Oct 2025 11:21:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Fix sleeping function
 being called from atomic context
To: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
 dlemoal@kernel.org, christian.bruel@foss.st.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhanuseshukumar@gmail.com
References: <20250930023809.7931-1-bhanuseshukumar@gmail.com>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20250930023809.7931-1-bhanuseshukumar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/25 08:08, Bhanu Seshu Kumar Valluri wrote:
> When Root Complex(RC) triggers a Doorbell MSI interrupt to Endpoint(EP) it triggers a warning
> in the EP. pci_endpoint kselftest target is compiled and used to run the Doorbell test in RC.
> 
> [  474.686193] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
> [  474.710934] Call trace:
> [  474.710995]  __might_resched+0x130/0x158
> [  474.711011]  __might_sleep+0x70/0x88
> [  474.711023]  mutex_lock+0x2c/0x80
> [  474.711036]  pci_epc_get_msi+0x78/0xd8
> [  474.711052]  pci_epf_test_raise_irq.isra.0+0x74/0x138
> [  474.711063]  pci_epf_test_doorbell_handler+0x34/0x50
> 
> The BUG arises because the EP's pci_epf_test_doorbell_handler is making an
> indirect call to pci_epc_get_msi, which uses mutex inside, from interrupt context.
> 
> To fix the issue convert hard irq handler to a threaded irq handler to allow it
> to call functions that can sleep during bottom half execution. Register threaded
> irq handler with IRQF_ONESHOT to keep interrupt line disabled until the threaded
> irq handler completes execution.
> 
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  Note : It is compiled and tested on TI am642 board.
> 
>  Change log. V1->V2: 
>   Trimmed Call trace to include only essential calls.
>   Used 12 digit commit ID in fixes tag.
>   Steps to reproduce the bug are removed from commit log.
>   Link to V1: https://lore.kernel.org/all/20250917161817.15776-1-bhanuseshukumar@gmail.com/
>  	
>  Warnings can be reproduced by following steps below.
>  *On EP side:
>  1. Configure the pci-epf-test function using steps given below
>    mount -t configfs none /sys/kernel/config
>    cd /sys/kernel/config/pci_ep/
>    mkdir functions/pci_epf_test/func1
>    echo 0x104c > functions/pci_epf_test/func1/vendorid
>    echo 0xb010 > functions/pci_epf_test/func1/deviceid
>    echo 32 > functions/pci_epf_test/func1/msi_interrupts
>    echo 2048 > functions/pci_epf_test/func1/msix_interrupts
>    ln -s functions/pci_epf_test/func1 controllers/f102000.pcie-ep/
>    echo 1 > controllers/f102000.pcie-ep/start
> 
>  *On RC side:
>  1. Once EP side configuration is done do pci rescan.
>    echo 1 > /sys/bus/pci/rescan
>  2. Run Doorbell MSI test using pci_endpoint_test kselftest app.
>   ./pci_endpoint_test -r pcie_ep_doorbell.DOORBELL_TEST
>   Note: Kernel is compiled with CONFIG_DEBUG_KERNEL enabled.
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e091193bd8a8..c9e2eb930ad3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -725,8 +725,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	if (bar < BAR_0)
>  		goto err_doorbell_cleanup;
>  
> -	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
> -			  "pci-ep-test-doorbell", epf_test);
> +	ret = request_threaded_irq(epf->db_msg[0].virq, NULL, pci_epf_test_doorbell_handler,
> +				   IRQF_ONESHOT, "pci-ep-test-doorbell", epf_test);
>  	if (ret) {
>  		dev_err(&epf->dev,
>  			"Failed to request doorbell IRQ: %d\n",

Hi,

I just wanted to check if you had a chance to review it or if any changes are needed from my side.

Regards,
Bhanu Seshu Kumar Valluri


