Return-Path: <linux-kernel+bounces-746603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3642FB128D4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0EFAA6786
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177E1EE03B;
	Sat, 26 Jul 2025 03:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbDFEemZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165B184540;
	Sat, 26 Jul 2025 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753501650; cv=none; b=dcZkxTMUW6L/am9H6n6druqxfd2WdEa51iel01dmQShR8zHgRTAyn5F7C30iJSqz/An2Ks+Zvt58eXWV2SZaJiDWgay435OPBDJQZc2oke0DHmLT4NB7f2Q9fZaA/i8/jrOVyyBZ7eCANyIXTrTfHh/5pIjrh5CLmHPwu0FKl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753501650; c=relaxed/simple;
	bh=oBLhY7yNq2ednLOX+i3mQmhq4v1Lzt1I/27ysRSSWyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nImv0HW40eBLvG2pxTR9wcBkEUFjnSrf7t+jVGJxZi7/47hiRsCa6ZEuqDIsroEUlxKK2CGqM0TEF3j1HPpofL5KFTYQCmFJZmyFRyWd42rNa/G3PuxXkteqWEtBrIHmPBvgrpe1aZ/LMLANOcMtKF1+4WlDZ0FXnexC1bDxnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MbDFEemZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=y3vtaWo74dVpfN1sAJs0ADB5dYrI5gxvYIp4sPyNUTk=; b=MbDFEemZTc2tPNUE5lR3chPTWb
	Sga0WULQuRck5wZzc5KpXEZk5rIOFesIygipnX7gEjFRpNfrEcrjLEBsueM9MvedH0EtTkIvQUFmD
	Q1saXNcWijpLsstBLvyQNlH93RNF8c0UjJ1J9VUTrOd479irIeGvNb+S6Bu+JX67yL/GlYNdYdq43
	lBVS7wKGgtNn/WZjrN/y2hlYhBmTzLu9FozwfXUDAHXsT9qYN9UKEE5qCya2hIoE46LUo0hi5GwFQ
	UY42gpxe+Pen+Cl7FfC4Hzap8x1LJ73pg3Ty5u42LaFuOqWyLajtMDhdcXOFYMVxI1u6A4w47hzvP
	CWEhiAfg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufVsc-0000000B5zp-3GmA;
	Sat, 26 Jul 2025 03:47:26 +0000
Message-ID: <b1d3fcab-b857-4c12-9779-8002a6bc065b@infradead.org>
Date: Fri, 25 Jul 2025 20:47:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add Ayn EC Platform Driver
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250726033841.7474-1-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250726033841.7474-1-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/25 8:38 PM, Derek J. Clark wrote:
> Adds platform driver for Ayn Loki and Tactoy Zeenix handheld devices.

Looks like s/Tactoy/Tectoy/ in all patches & cover letter.

> Tactoy devices are rebranded Ayn devices with minor modifications to the
> DMI. The device EC has multiple features implemented by this driver,
> including a PWN fan with manual and EC controlled automatic modes as
> well as a user deviced fan curve mode, temperature sensors, and chassis

                 defined ?

> RGB control.
> 
> This driver implements PWN fan and temperature control via a hwmon
> interface, and an RGB chassis interface via a multicolor LED class
> device. I attempted to break the driver up into four logical patches.
> Patch 1 adds PWM fan control via a hwmon interface. Patch 2 expands the
> hwmon interface by adding the temperature sensors. Patch 3 adds the
> chassis RGB interface through the leds subsystem. Patch 4 adds ABI
> documentation for the sysfs entries that aren't provided by the standard
> interfaces, but are needed to fully control the device.
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> v2:
> - Fix nits from Alok Tiwari.
> v1:
> https://lore.kernel.org/platform-driver-x86/C7073C0E-3D58-41C3-99B7-A0A5EE448700@gmail.com/T/#mb795b8f5e5ff3c5b88fdd62bd6c97eab404fbc4e
> Derek J. Clark (4):
>   platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
>   platform/x86: (ayn-ec) Add Temperature Sensors
>   platform/x86: (ayn-ec) Add RGB Interface
>   platform/x86: (ayn-ec) Add Ayn EC Platform Documentation
> 
>  .../ABI/testing/sysfs-platform-ayn-ec         |  59 ++
>  MAINTAINERS                                   |   7 +
>  drivers/platform/x86/Kconfig                  |  14 +
>  drivers/platform/x86/Makefile                 |   3 +
>  drivers/platform/x86/ayn-ec.c                 | 965 ++++++++++++++++++
>  5 files changed, 1048 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-ayn-ec
>  create mode 100644 drivers/platform/x86/ayn-ec.c
> 

-- 
~Randy


