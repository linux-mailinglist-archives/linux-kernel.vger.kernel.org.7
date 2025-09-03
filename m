Return-Path: <linux-kernel+bounces-798790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB9B42307
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2247B5400C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8819E968;
	Wed,  3 Sep 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="f/orEjsS"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA49E2F7441
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908266; cv=none; b=e7/B79sszWd+1lmYbbJDQF8Hi5/rMPG5NX55oLzjAZPUlsDqJiEYMGbL1q2A7GxYqHoSnue2eFagBbUrMfaeNl5IWaw0zRslVIMyUeXyAb9+bI/3X7SBzlHHOKOVwmBrciUycPZV5ZzoSI5ZjUI+Sek4Nkc2++jPgbGqKWRltRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908266; c=relaxed/simple;
	bh=HgKKOGM2p63WpTkYbbwVnU+fdtUN9eIMh2AP+3aa/Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUN/DLtk1mj8Ly4TEN0IoN5FEImM9AEi2dYSzNz2hwk94YhXJLhvrbvtvOa71SNlDvgVcNKcajYh0pBMymKYrVCojhoracVVhL79LGxH8gXGidwTk6e02FV463HksaMpmmjXIKokwGmGc1PWlmK3/qLAKjcNDJXPZOelNElR+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=f/orEjsS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so5475873b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756908264; x=1757513064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DF7NNzOTfeAplUyiGrcXUnjULOlHRrGxxOTtvokNWdo=;
        b=f/orEjsSGkyP5357H91a8EY4DoXe+/5FxdDNYgTjisODdd9/lOajJ0sjbGVeRHqT7o
         sNiLztIa3p5/21lMVn+tb8oPOL4ib0pzIGKrAVCjMS+6RQ/UZbtTXyD8ckRBaEi65F7X
         rPlBT934raTNK73i/SiCtkdBkE6yHNZdSKEJ0lNFxMMEs7r1jO8b7Nkks9otHkeRp3Ky
         koOZyQ0imK2FATfs4b1A4pmaUmfdYhTvAUg0uy8Mlq9uAOJl8IuBFEuTMlSKVESI0b34
         XwSWr2VdDCqPuNKUrKhXcIObChmndKKuZXh7J3rYAW/r5kP1bMSp0WsoeTBcPYPU4iAV
         h0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908264; x=1757513064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF7NNzOTfeAplUyiGrcXUnjULOlHRrGxxOTtvokNWdo=;
        b=dl02f73sXKlirQ9akqSsvGIV//grzDvH8jThwL/2BR+NNw7tQCBVz86/3xX93heUEm
         9xmRgmi2X3xfumvf8dXo5Qz3bsE+3G8gAG4OPfm+2jd5canmGtKAEjeoZyyD/9AD/9P3
         xyf9MwOn3Zd8+vGLTg1i0CHSOb8coxrbd1+6dzCaVFsQ/0hOYOBGXKRa12MVuC+f2Xfa
         ysG+7pnbq5QybNe/G8cresLgk+N1y9NOgOdYWqN3vlh1dUDgwDpkkWx/Mlxh95JfeY7j
         /i9iAjuaCOoUvGagzjnXjYF8TF7YN3fTQoMLzgNP52pNRwemj2bB+ov5NDdSuiCq0erg
         1wUA==
X-Forwarded-Encrypted: i=1; AJvYcCV//eDxmc4VtFZ9ND/n6efHJFBsB5QE/5sTTSMCsjXOK9kvTc+kmFVKd7GJH1/TyFByeKK+JdJ5SDoaPc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5x4Q4sRB72X29fmp4Z7pyi+lcqCMb4zBiMxRAA7t38wuEGN9
	3fvmGvkWjRZvIAHSRVO11oPitAz+FZhlldpAlXNfaQj2CqUg/cLDeuCWzGBiz1iuzHo=
X-Gm-Gg: ASbGnctxYd6tENJz58QH9iosyj1tEaCps7XQDL8O4/DRyyiFMBQDiArywZc61dan2XR
	3PEkkJJQX6LVNHoNzMzxdxJKQUjJ4yyOIGtKyEFAVRDMDEX+iYDpOTcUMQX1TPBYE+eVnybRBes
	W63sitiGnoW/grQTPJQ61U89xTXno7cpkj/CG4wl4i1m31RgjC1hLmT2vH2h0ZNBxnyREBXHl1v
	Gb7TM95QBl/rsoOzHSzjmhxAaFTWd7x7A2IrOzIeAwGU2AI5PlQ+5eds/1Pk+RzRlWm4GpStcG6
	ABThZR7DasGu3AXjRaGKRhjnLY2kWzUNh8iqNf+P3f89h07YAhdog42bCivE6qo2Sge2pszuYNO
	GauV7frV4Pte12Bgja8VLpOJd
X-Google-Smtp-Source: AGHT+IFBlpLNtgdmmoa5SdWAbPJh9KJ+b6IiZlofc2uxPPTjS7ICUieyCle+dJztVNFLBP++9ETglw==
X-Received: by 2002:a05:6a00:1a8f:b0:772:4759:e433 with SMTP id d2e1a72fcca58-7724759e59emr18474843b3a.2.1756908263633;
        Wed, 03 Sep 2025 07:04:23 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b65a2sm16961841b3a.34.2025.09.03.07.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:04:23 -0700 (PDT)
Date: Wed, 3 Sep 2025 07:04:23 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org, naresh.kamboju@linaro.org
Subject: Re: [PATCH v2] Bluetooth: Fix build after header cleanup
Message-ID: <aLhK5wEHgxc3BIgb@mozart.vkv.me>
References: <202508300413.OnIedvRh-lkp@intel.com>
 <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
 <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>
 <aLNRvzXE4O9dKZoN@mozart.vkv.me>
 <CABBYNZJBDgQHwmx82H2XJ-LCeOsxc77PPo6NA4zzT0dt7Uxddw@mail.gmail.com>
 <aLcQsE3x9o4BzXxp@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLcQsE3x9o4BzXxp@mozart.vkv.me>

On Tuesday 09/02 at 08:43 -0700, Calvin Owens wrote:
> Some Kconfig dependencies are needed after my recent cleanup, since
> the core code has its own option.
> 
> Since btmtksdio does not actually call h4_recv_buf(), move the
> definitions it uses outside the BT_HCIUART_H4 gate in hci_uart.h to
> avoid adding a dependency for btmtksdio.
> 
> The rest I touched (bpa10x, btmtkuart, and btnxpuart) do really call
> h4_recv_buf(), so the dependency is required, add it for them.
> 
> Fixes: 74bcec450eea ("Bluetooth: remove duplicate h4_recv_buf() in header")

Hi all,

My fixes tag was wrong and Stephen's automation caught it in linux-next.
I'll send a v3 in response to this with a correct tag, it should be:

Fixes: 0e272fc7e17d ("Bluetooth: remove duplicate h4_recv_buf() in header")

Thanks,
Calvin

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@intel.com/
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  drivers/bluetooth/Kconfig    | 6 ++++++
>  drivers/bluetooth/hci_uart.h | 8 ++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4ab32abf0f48..7df69ccb6600 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -312,7 +312,9 @@ config BT_HCIBCM4377
>  
>  config BT_HCIBPA10X
>  	tristate "HCI BPA10x USB driver"
> +	depends on BT_HCIUART
>  	depends on USB
> +	select BT_HCIUART_H4
>  	help
>  	  Bluetooth HCI BPA10x USB driver.
>  	  This driver provides support for the Digianswer BPA 100/105 Bluetooth
> @@ -437,8 +439,10 @@ config BT_MTKSDIO
>  
>  config BT_MTKUART
>  	tristate "MediaTek HCI UART driver"
> +	depends on BT_HCIUART
>  	depends on SERIAL_DEV_BUS
>  	depends on USB || !BT_HCIBTUSB_MTK
> +	select BT_HCIUART_H4
>  	select BT_MTK
>  	help
>  	  MediaTek Bluetooth HCI UART driver.
> @@ -483,7 +487,9 @@ config BT_VIRTIO
>  
>  config BT_NXPUART
>  	tristate "NXP protocol support"
> +	depends on BT_HCIUART
>  	depends on SERIAL_DEV_BUS
> +	select BT_HCIUART_H4
>  	select CRC32
>  	select CRC8
>  	help
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 5ea5dd80e297..cbbe79b241ce 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -121,10 +121,6 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
>  void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
>  			 unsigned int oper_speed);
>  
> -#ifdef CONFIG_BT_HCIUART_H4
> -int h4_init(void);
> -int h4_deinit(void);
> -
>  struct h4_recv_pkt {
>  	u8  type;	/* Packet type */
>  	u8  hlen;	/* Header length */
> @@ -162,6 +158,10 @@ struct h4_recv_pkt {
>  	.lsize = 2, \
>  	.maxlen = HCI_MAX_FRAME_SIZE \
>  
> +#ifdef CONFIG_BT_HCIUART_H4
> +int h4_init(void);
> +int h4_deinit(void);
> +
>  struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
>  			    const unsigned char *buffer, int count,
>  			    const struct h4_recv_pkt *pkts, int pkts_count);
> -- 
> 2.47.2
> 

