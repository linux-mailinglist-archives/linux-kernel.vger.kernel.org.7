Return-Path: <linux-kernel+bounces-887078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E568DC37361
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74B444EE8F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752333358AA;
	Wed,  5 Nov 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="p+qg5rB9"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E4325707
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365070; cv=none; b=n+R+05TUdWg2R1u6ZeR4ew4nPcp6RHVYa/0oerPtvLkHqKNfRmyT5tuwlTVjJMdo9zeqoHOFXKhRNgANuD63/vZW5KDw3k+bB6VkFJ7AfR3BDXazNV9ckqdlB0G3sr+ykCWil1QnglRVLNup1zCnqp7Tb7QxZ0p6jTROpaf0NcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365070; c=relaxed/simple;
	bh=tIgDGOVX99OdQ7xUMrv9gmtn1EgXPokG3WTHA51WYa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX4LBjQUAPjtkvHcCYlJgTNY6VWQfjBz+RuhIHaAzhQk2GvowF7OOHpgeClNaSp7hmmg9gKMjPzm2+PtiSfTbPi9RJDvUVb6wylS4E4Xork7erkLQaMfU+r5fhjMeE2lj2dtnPScGoey6DdhsKvq8DNTSb6pCCQ1ceDvVVrJ/Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=p+qg5rB9; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88058103dcfso1452006d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762365067; x=1762969867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDrtj0a1qY5KhyImx5VYDzDX8bVcvGFBBUFmZLDCfSw=;
        b=p+qg5rB9I7ZEesolYhegQvv+t3d5zVArOc803nNlc6FndePPV+FkJZcu3/Aes5Pp/Q
         X0ah9qDlM1DIWuF4f1p5bsaIT1tLGT7UWcyDVGoAPiVHbUnMXSxfIVCEjj0oRLJk379w
         p/rzpZ4fDcYZKEkw33V0VPCNUQ4/pi2eogoRNG1ZH6WHP2NhnV2h05wlrc1CZSLqOwkc
         DXK41s6HRPF3u2PWmqfiE6LZnSq5yNNsAhqvv9WT160BVNEGav2pR25CWDNdNHenpEnI
         7zkXHCUotnxhOIqCqWl2rBZ6EUjpdKjIuVCY7eyxPWpdyS6CBPdvA0fGAriHMuFQbp/K
         JsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365067; x=1762969867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDrtj0a1qY5KhyImx5VYDzDX8bVcvGFBBUFmZLDCfSw=;
        b=Qnd/Y47zjN8vSxraUfYZ0qxYNdT+fCNCkOH8PoTsRkQ0VF3LPgX73gcx/USbnmb2KD
         3Cy71+f6HfkM/ZCjsxil72vzjHrLuoxokC23bBU5to0A5vOvp4VIbdvI2SdcjhR0yRS5
         433oUMUpzdbbghSITRibGH2msQSpSwIbrHdtcxhYYRPHGLdd//CXXyxOBfrxS8DLeD+L
         Wm2UPcWuYkCFDELXv8vGHT/fY/wDOYilcP5EnIt0qNt1R+XNgj2BmFO8XnPuG/leKCQO
         8jdXPfHfRa+MxDGj5I+wc5YJTx7zyr4htKnUTcANUzngy6k3jBL4y0SMi48TFA7uS5Pl
         T94w==
X-Forwarded-Encrypted: i=1; AJvYcCW0NwmLvd540ctvs4ltO+atmmUBGgy1cU0hPjQ7eE4MVKMYgCcRfhxky+zeEkcv4m+yHNKt1KiJdxvanLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYrXKUp9XKjiAh7/4d0SZPjJ3DMhFCJWoWqfcv1iyf5yZ4GbL
	k8Dty5BlUjE0KnIIwge0jMJhRFNzWtsCP4tgaCwZvwGRc3OOBMd9o9Jv8YK8kMTrJ/Q=
X-Gm-Gg: ASbGncvGDpzgyu16PVstSDOFS/847Z4sjFAz+YuiAAnWAem7gVmKIafZLfwhiwCTaId
	B4BIDrFR2DBaVRpUKT0MnUmAai+7R2pm1/oi5DyECq7ciJU1NcFyaPfy3aqwNWRw2gbxYMfsRLU
	AydmpbY8Cs2OJaHoBwdXeXbtBa5nr5wdnEzkmLJS2kZDm3o1OyH7d6Kbf+978by1Mfm39Db3DJf
	vEAuvARi20sGDs5E9lsBFjcb9XLOso2noL7UBWzLINlYPZuTpQBFMCunn1jUzDf3XGE5JXHoM+9
	7/t+nGaNUHDhmaZrOoJtgWAAhfTsWhVijWfJD4FsEMpC0l0d4M7XjEYVsC1VrOJmyeZ8bY5MF5t
	BKvbLu26o9FUaY6JX6u6MZQBpjUpyZKEXsYIAdj7yL3c+B4tRRTmDHesz9MDxuWaQliynVxJOQr
	nmeX09qY59+Oe3pFjTG+UH8wtRZL3+1avdpVTiGBC7hbFNtSWCtMOMOZoyxvA=
X-Google-Smtp-Source: AGHT+IFbubKK7RHluWy72s0vGay11LKV+jA/RxKZTdEkayr9i/UfiWmuCSryIaOc1e9CcrXX+Lj9EA==
X-Received: by 2002:a05:6214:2686:b0:87d:e456:4786 with SMTP id 6a1803df08f44-8807119644emr57736286d6.45.1762365066850;
        Wed, 05 Nov 2025 09:51:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8808290d03asm1375476d6.26.2025.11.05.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:51:06 -0800 (PST)
Date: Wed, 5 Nov 2025 12:51:04 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-18-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:02:57AM -0600, Terry Bowman wrote:
> CXL devices handle protocol errors via driver-specific callbacks rather
> than the generic pci_driver::err_handlers by default. The callbacks are
> implemented in the cxl_pci driver and are not part of struct pci_driver, so
> cxl_core must verify that a device is actually bound to the cxl_pci
> module's driver before invoking the callbacks (the device could be bound
> to another driver, e.g. VFIO).
> 
> However, cxl_core can not reference symbols in the cxl_pci module because
> it creates a circular dependency. This prevents cxl_core from checking the
> EP's bound driver and calling the callbacks.
> 
> To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> build it as part of the cxl_core module. Compile into cxl_core using
> CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone
> cxl_pci module, consolidates the cxl_pci driver code into cxl_core, and
> eliminates the circular dependency so cxl_core can safely perform
> bound-driver checks and invoke the CXL PCI callbacks.
> 
> Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> parameter is bound to a CXL driver instance. This will be used in future
> patch when dequeuing work from the kfifo.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> ---

This commit causes my QEMU basic expander setup and a real device setup
to fail to probe the cxl_core driver.

[    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
[    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22

Probe order issue when CXL drivers are built-in maybe?

~Gregory

