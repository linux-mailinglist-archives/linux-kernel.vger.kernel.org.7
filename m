Return-Path: <linux-kernel+bounces-894635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A5CC4B76D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7DA188E0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65CD273810;
	Tue, 11 Nov 2025 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xiGFAE4B"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC129275AF5;
	Tue, 11 Nov 2025 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762835823; cv=none; b=n9/Y2/+wkkXx6hKk/GzDnBYj8iigOuamrDpeVKq5aWU8gmv+faHKWK62LKthRJmS5FtTdvYbxZ6k+jZ4HYusXqfiqKeUrVBJA2s+c/4wdU3sqXx58KeJGVl6cq1UTkYXxLwDxgWjgnIZOVmQXftxuwDHP5L7yfcDp+F2ncy+rIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762835823; c=relaxed/simple;
	bh=DO7ur9f5H1ZRUCiFO/Sct64D+Ey3WhsVSZbWrgDekSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDBl3D2v8KCZ8Y49P7PMwuWt/9kmoVuVnNNnTo4xY9//iHFHLdh//CrSMBhBZ9A0CWICdsgxDIgV9fcr4zZKJ8q+VXVOwldQVecpqvv5bA+SE/VfdFHw7DJXXyZ6hYinWoMB7gCd8wjSR9cEDgcGWV2dNJJgiCatVVMbooK0rrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xiGFAE4B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=40/VsnXsFcSLiJgKtc8jxrHRh6TFqjSmtbILrCIHYBk=; b=xiGFAE4BIGLIcVkDMDid+HwM6U
	8B5FP9TE0g5HTAHMGF+oTK3YwsiNIYWp0amW2u9KSxqvH93NFCm2ARzSXzDRVpAL5pkqTMJiEJJ+d
	bKU3qU/wDLNVlCylY/worARgJcdpN9zHNnCwsLjOgAXMKk6a0uoTACandDk7Qt2hHGBPHpWp03T4m
	+7h4OZEVpymlQjRQMPpNzZyg0r4Y33v49zXUZmRRyvaokGVlP2sUXTXoQB/hG5GrLyvcLLEpOoS64
	Tlzu6VzGNC/1LkYlwPSLIPdOE2Pcu2e2S3KZ0Mf8VFV7iZKk3GduI9AOFC1TdIIe5MssUfvXjm8Z0
	EBTNViXw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIg7l-00000006VqT-2A4X;
	Tue, 11 Nov 2025 04:36:57 +0000
Message-ID: <e1799bf2-e261-4f36-9e1b-de324be9dd0a@infradead.org>
Date: Mon, 10 Nov 2025 20:36:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: ipmb: Indent boot time loading steps
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 openipmi-developer@lists.sourceforge.net
Cc: Corey Minyard <corey@minyard.net>, Jonathan Corbet <corbet@lwn.net>
References: <20251105125449.45643-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251105125449.45643-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 4:54 AM, Bagas Sanjaya wrote:
> Steps for loading IPMB driver at boot time, written as enumerated
> sublist, is indented instead on the same level as its parent list.
> Indent them as appropriate.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/driver-api/ipmb.rst | 48 +++++++++++++++----------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/driver-api/ipmb.rst b/Documentation/driver-api/ipmb.rst
> index 209c49e051163f..dd99d034272b7e 100644
> --- a/Documentation/driver-api/ipmb.rst
> +++ b/Documentation/driver-api/ipmb.rst
> @@ -48,35 +48,35 @@ CONFIG_IPMB_DEVICE_INTERFACE=y
>  
>  1) If you want the driver to be loaded at boot time:
>  
> -a) Add this entry to your ACPI table, under the appropriate SMBus::
> +   a) Add this entry to your ACPI table, under the appropriate SMBus::
>  
> -     Device (SMB0) // Example SMBus host controller
> -     {
> -     Name (_HID, "<Vendor-Specific HID>") // Vendor-Specific HID
> -     Name (_UID, 0) // Unique ID of particular host controller
> -     :
> -     :
> -       Device (IPMB)
> -       {
> -         Name (_HID, "IPMB0001") // IPMB device interface
> -         Name (_UID, 0) // Unique device identifier
> -       }
> -     }
> +        Device (SMB0) // Example SMBus host controller
> +        {
> +        Name (_HID, "<Vendor-Specific HID>") // Vendor-Specific HID
> +        Name (_UID, 0) // Unique ID of particular host controller
> +        :
> +        :
> +          Device (IPMB)
> +          {
> +            Name (_HID, "IPMB0001") // IPMB device interface
> +            Name (_UID, 0) // Unique device identifier
> +          }
> +        }
>  
> -b) Example for device tree::
> +   b) Example for device tree::
>  
> -     &i2c2 {
> -            status = "okay";
> +        &i2c2 {
> +               status = "okay";
>  
> -            ipmb@10 {
> -                    compatible = "ipmb-dev";
> -                    reg = <0x10>;
> -                    i2c-protocol;
> -            };
> -     };
> +               ipmb@10 {
> +                       compatible = "ipmb-dev";
> +                       reg = <0x10>;
> +                       i2c-protocol;
> +               };
> +        };
>  
> -If xmit of data to be done using raw i2c block vs smbus
> -then "i2c-protocol" needs to be defined as above.
> +   If xmit of data to be done using raw i2c block vs smbus
> +   then "i2c-protocol" needs to be defined as above.
>  
>  2) Manually from Linux::
>  
> 
> base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f

-- 
~Randy

