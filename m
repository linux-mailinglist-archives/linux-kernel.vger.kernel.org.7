Return-Path: <linux-kernel+bounces-821643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B7DB81D74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0206468057
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD2274B37;
	Wed, 17 Sep 2025 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IqqFv8b3"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEB25A630
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142449; cv=none; b=EZRJHxcfgWo5PcjR6eOan7/lnCdlecaTSq6YepQja2jVdbdLZ6ZjzMHP0oBEptLHtomDktlTH+EZ2xdaY6GnzkpxCZBu6wnHRyD8TW8tRJIPCxTM0rDM9c5g43tOnna9Z1h0Jni6kaEBJDmfts2dSUb0OsbVS1gI8Yc4nC35zvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142449; c=relaxed/simple;
	bh=K+W1WDio6lk+ITDSHWIHjSqoEIPRhq3FXhhJkTR7mH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBo0GmhDlOpeiaAp3RPbwgSfZx384a5y5CViX4TMnl/lptwsnupe49PXQxym3T4DK3P1S56Pc20sZ8EY7cmptQmu1FWi00AvzJ4oLq5mKbjf3GHdmbAe6UqVXXCz+uAAO2m9bggu1OL3hADd8R/auj8OpgFFgaFDdTOeJzj7814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IqqFv8b3; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-791fd6bffbaso2862756d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758142447; x=1758747247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcmqKXFeHUqx/Zd3AQldL9H7ZjaJD86SN/59W2f2bAs=;
        b=IqqFv8b3vcf2fDK44mE57FrYJTu6BxSHwlJTelsRxsGtobZ1Fz1uRI4u+FYpn3/r4i
         fmgLy/Ul5Astyqprqyu2R5xh/36I4HnFGUgtPhGZWVWigfrmP8iDo3Ao8m+lf5v8njef
         zQHNgT/EmoTOfkG1tn+jQ2FrkyQVTIDV+fU+9lIto0XtzMpR+FJ1Q4e96N3IP+rJIvIu
         0vimjBM8q4Pss7QaTiv5XVi6EwNFJ0ZcInD5eOQFAw/bLe+CwNGu4SA6Vkuzp+5J+xqq
         kFMIcvQDBswk+8cBzhQkj/iJ1LLCDebTwgS/lfjZ/RYqj5+DbuwKUDcS7iORFkoYQlc8
         xhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142447; x=1758747247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcmqKXFeHUqx/Zd3AQldL9H7ZjaJD86SN/59W2f2bAs=;
        b=L3KL4NkMjgoFMIjPUwFP8nvjiMo+wgjdF6WhgwgwFUIup2gn4Si4UQknASqEe4ceFQ
         +1g5ng/jX25ar1zidvmtOgZAEIb72bIAjqobh7+vKRjjSyJsUBg4kcETVPPueaUg7VZ3
         pT+yLsmkWBpTE677MqPYh9YPqMISjzuu2ZlxqtrWlM8FwUvWAQXKZVSto4WLF6B3vp2H
         Z3VSBd8B5VybikRoZ07h1jqeCemabfJvKWmhzAyra1lGsbSLr6/+6nndNBMdOSdxbqNd
         S4RMNfMmFKixlayLWquj/9+5Skv8hcUuY96+2dxD07wUx60qKPtWb54Cv1QFPUV2obDX
         1X8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIIIpWeTRB6/aDTPMz++J5r0sulHhs7KD9EmwJUb1qd/tHDQYEejxUSiMCx6WjItgI+F09zuYspxNhVuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/T6XSYCTOKxD7dPfDlhr6V7nMnGM1fz1BMAP2/tD4uWZ+c7c
	6cnWxC5A3IylCXxuGJ127ZD249XaVsSJNQNLVPOiooNzmjuYlXlDc1wgM+WC68M7kxDBly2Pelx
	dZcft
X-Gm-Gg: ASbGncv8MMYtRK79S4bxGB/0AMw0C0p4wOBy8RETpM8SdaoGoye/ltn2mAUMIBUqi4O
	Wi8tJvTRkTw5WQSh9KBEUgPo4DqNsjyjXH420g0V1tvzWi6zNLiembjAukSUvHEFyLRcW0Cd4Iu
	YJmARTI0r+lZTUdEaMHgjgf03NwEfeZ5mHrA1mW1mcyxpsWZX10B80gUBe72RMyLxx8WfgzETK9
	GIK5FZR2kXcNcaTFkMRJArTHOsvC0OB2o9yJQDF/ae7SSArnzK+2uxyufMykQj8S62mINhy/bgW
	zyaUqjJYPi0IpKRsf7z4iIbWYrOHzR7hh9F5UtJdOjO9TCOcQRZ6HeygWBCWqDbE2E9FlasIt8b
	TiO7QWLxzZ6ODys9GVLuiYHNl7SzP+2D7IWaVQ27B9APgxVeEttWJwd0yAmySVqhnse6Z7AiCHw
	vMbfErRANhLiZ8J7CrrpAHcw==
X-Google-Smtp-Source: AGHT+IGDXIKr016Rx3/Xv8gq8Sj5/rMui3SP4djoDyXpvBJ2Prp8xro0Uk1OdXAiTR7V4JoBTmiKeA==
X-Received: by 2002:a05:6214:2622:b0:76f:6972:bb89 with SMTP id 6a1803df08f44-78ecc438e04mr47323676d6.9.1758142446767;
        Wed, 17 Sep 2025 13:54:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79353c4d4b3sm1804606d6.51.2025.09.17.13.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:54:06 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:54:04 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 10/11] cxl/acpi: Prepare use of EFI runtime services
Message-ID: <aMsf7EP8W99QJFTI@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-11-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-11-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:12PM +0200, Robert Richter wrote:
> In order to use EFI runtime services, esp. ACPI PRM which uses the
> efi_rts_wq workqueue, initialize EFI before CXL ACPI.
> 
> There is a subsys_initcall order dependency if driver is builtin:
> 
>  subsys_initcall(cxl_acpi_init);
>  subsys_initcall(efisubsys_init);
> 
> Prevent the efi_rts_wq workqueue being used by cxl_acpi_init() before
> its allocation. Use subsys_initcall_sync(cxl_acpi_init) to always run
> efisubsys_init() first.
> 
> Reported-by: Gregory Price <gourry@gourry.net>
> Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 26c494704437..95a5ba395c1a 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -1012,8 +1012,12 @@ static void __exit cxl_acpi_exit(void)
>  	cxl_bus_drain();
>  }
>  
> -/* load before dax_hmem sees 'Soft Reserved' CXL ranges */
> -subsys_initcall(cxl_acpi_init);
> +/*
> + * Load before dax_hmem sees 'Soft Reserved' CXL ranges. Use
> + * subsys_initcall_sync() since there is an order dependency with
> + * subsys_initcall(efisubsys_init), which must run first.
> + */
> +subsys_initcall_sync(cxl_acpi_init);
>  
>  /*
>   * Arrange for host-bridge ports to be active synchronous with
> -- 
> 2.39.5
> 

