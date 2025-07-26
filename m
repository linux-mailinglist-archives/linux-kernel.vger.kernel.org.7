Return-Path: <linux-kernel+bounces-746604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16755B128E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE7B7A21FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B451EBFFF;
	Sat, 26 Jul 2025 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zcmQ40e9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775F63CF;
	Sat, 26 Jul 2025 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753502528; cv=none; b=XoFxMHtcpp67ta+NcEw2UL/atJZdiqr4HZEa6HnOpFcrem6BJJ/JXKQ60pAi8I9NFbfGimID8oNkuYHTVei2CYVLJdTi0WuQIgvn9iP7Syoi2M7fzd//isgNNBmSYkTj1KdEAMUyTBKPmqDy9KQvizstXc2HtrvJqlU8YFz41mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753502528; c=relaxed/simple;
	bh=vWdAYFH+9+HudBhqOI4uVPMOFshO0UkS3lTM/Ehr4So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpSwrI9jeadTc5t+pfySYQMhZbIGsjHrz6DRj0Llv8+fbQS51o+F/hlpPswP+DYmiaFTFwzDz9FUrNVzTBJVVWHuGRpfL5TQFgKYphwJHHy2EjEqGWe62rafg3vXCTBXZzvbMMKlVLtt6VLGBAA195yv69cXOwmsbn2SOu8y40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zcmQ40e9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VhFLFN08/7pTue+UlCH23caiQjbrbJ++9vSN0PiESJE=; b=zcmQ40e9USeqwGaDnF3UZ71DY2
	/uz+9mvCh42uIlWzxLkUAClD0SAz3lT1oJNZcPRwcfBwwzWwNvwQ8+WrczKq3ztF05OtX8jJozsP1
	PlyoX/uikXSZRIyB0B+/UZb2qtaAJz3s1+kN+84BNbz7eGBzCZXiWOBzIls8Dt6GgSs3Ib7b5Czl+
	iegus0/DvEsT4xTmVnJ93ivZyT33+xRTO4uSY4mihkWnMKo7aosPf+8giys0SStyizmf6SlERVMDM
	uaTTHIf1fyrnn1iHpgYd7L5XKPDv/gq70EqK1AFGzAo2UUDua1eTWXms317sMvcHoV2vLJ5Wnpy/0
	kwT4DTVw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufW6n-0000000B6ex-2sdd;
	Sat, 26 Jul 2025 04:02:05 +0000
Message-ID: <776b195d-713b-4899-b621-4a69ba2b160a@infradead.org>
Date: Fri, 25 Jul 2025 21:02:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation/ABI: Fix typos
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250723203250.2909894-1-helgaas@kernel.org>
 <20250723203250.2909894-3-helgaas@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250723203250.2909894-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/25 1:32 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  .../ABI/obsolete/sysfs-driver-hid-roccat-isku       |  2 +-
>  .../ABI/obsolete/sysfs-driver-hid-roccat-koneplus   |  4 ++--
>  .../ABI/obsolete/sysfs-driver-hid-roccat-savu       |  2 +-
>  Documentation/ABI/testing/debugfs-driver-dcc        |  2 +-
>  Documentation/ABI/testing/debugfs-hyperv            |  4 ++--
>  Documentation/ABI/testing/rtc-cdev                  |  2 +-
>  Documentation/ABI/testing/sysfs-ata                 |  4 ++--
>  .../testing/sysfs-bus-event_source-devices-hisi_ptt |  4 ++--
>  Documentation/ABI/testing/sysfs-bus-iio             |  2 +-
>  Documentation/ABI/testing/sysfs-bus-iio-dma-buffer  |  8 ++++----
>  Documentation/ABI/testing/sysfs-bus-rapidio         |  2 +-
>  Documentation/ABI/testing/sysfs-class-fc            |  2 +-
>  Documentation/ABI/testing/sysfs-class-power-rt9467  |  2 +-
>  .../ABI/testing/sysfs-driver-input-exc3000          |  4 ++--
>  Documentation/ABI/testing/sysfs-driver-ufs          |  2 +-
>  Documentation/ABI/testing/sysfs-firmware-acpi       |  6 +++---
>  Documentation/ABI/testing/sysfs-memory-page-offline | 13 ++++++-------
>  17 files changed, 32 insertions(+), 33 deletions(-)
> 


> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer b/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
> index d526e6571001..06313befdfaa 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
> @@ -2,15 +2,15 @@ What:		/sys/bus/iio/devices/iio:deviceX/buffer/length_align_bytes
>  KernelVersion:	5.4
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		DMA buffers tend to have a alignment requirement for the
> +		DMA buffers tend to have an alignment requirement for the
>  		buffers. If this alignment requirement is not met samples might
>  		be dropped from the buffer.
>  
> -		This property reports the alignment requirements in bytes.
> -		This means that the buffer size in bytes needs to be a integer
> +		This property reports the alignment requirement in bytes.
> +		This means that the buffer size in bytes needs to be an integer
>  		multiple of the number reported by this file.
>  
> -		The alignment requirements in number of sample sets will depend
> +		The alignment requirement in number of sample sets will depend
>  		on the enabled channels and the bytes per channel. This means
>  		that the alignment requirement in samples sets might change

"samples sets" ?

>  		depending on which and how many channels are enabled. Whereas


Otherwise LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

