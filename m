Return-Path: <linux-kernel+bounces-774404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28784B2B1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08CF5E42C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078AF273D7B;
	Mon, 18 Aug 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8AbGY9N"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78A272E46;
	Mon, 18 Aug 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545871; cv=none; b=XMt68RzsFcYDCBTi+gzmOgC51/MvvBctPFuzj4vfvhHxnISH4YEMnMUIBrJ/movsi/BI/YKqEjB4A3mUbn1vzzfbilkmm2gtl91Oy8ZHy5UbSoPYZmUrmr/bI8q8lCHKW+bFn6zJGRsz1ET51Re5iE6Vn1nbGvdlnxBtsy1S1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545871; c=relaxed/simple;
	bh=uecHdAuLHHO3O+6THsz5fKOvoGAxAfC+/EuWV+UkwqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6YV6LMP6d5NVE3FU9xWv+E+nBtMp8w5/aRlxDFzUcY+lQJaZcoFK+OsLBT1XlVbECWT2NijlBXBGwKovo6igHWGaZGSesv/Gxtqvua6j5bPj7imzW94QywyMJyF1BQUPM7dWxsuGwPrPN5WVtNaT8Y0oyGuIJStqUHKhjHgJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8AbGY9N; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2e614b84so4298861b3a.0;
        Mon, 18 Aug 2025 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755545869; x=1756150669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUZI7/7gjTcJObK6S9x9OXvUt5/wvIr0TD3UHQ6Mplo=;
        b=G8AbGY9NKBFJSTkYFF93Z3e7yo/ADgxOtqchQIE7AgP7i8DOlDe9y3Mr4og+snFrL6
         VpNhnN9WKYxDMjPk9P3+qaKmu4ewFfEQhCvkTYgSonSC/axyxgMyxhKNtBFnM/8ER8zO
         rqph2FyovuxQKxtuRvK3kehbIummsJTmZzy4G0RMzcMQpsKOK2QUKlzr5MlPT7Pz7Dxk
         KSIuukap6cC1DE5BwbEIzbNzN6wvpviSERtbJVGdihF+mYBp9trGUdJ5vdt1EuoE6Oj7
         vDqncIziFMSrsxjhJ7b7BK2O08gxpggEcmTqXWF929J7nqtVKlyNqqS9vAy2j4s+rI6w
         NPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545869; x=1756150669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUZI7/7gjTcJObK6S9x9OXvUt5/wvIr0TD3UHQ6Mplo=;
        b=flx1CNqGSxfNeXRBwO+X1XyHfqw8YZwwNXWkUvwjOceu7F8E94LgAPmnvpi0Q4bbUe
         20+v/qZqVeIHU+53uakZpD/hrtfaD/i1YrATgmLsAZNFUxFCTjkY4MI+SEaTxq3p3q/I
         WscMVmrSVx4e51v9XZCJrrOlR7f8bTjpqty4aCL5rAn74zZm07SWuOQl8Cp0KaZOa97C
         F1nKOKPEQr3zQ5LA5FEp6Voe7SwmovZ1RgkZRjOfUtr4Lf0vNXeYpd6usIrRjw8ce0kc
         OLWPyVrAZ/lI7oWrUVSQ7sMSM/lkgt+0LDEMtsw0TnBQcfzh2O1+LgSlHEo1OllcBWrG
         DbcA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Fa691lAIkhqDxs092viU11Tm7PeLY7VTzVEhsn96Lw1XhbZYM0O6pFmsXCyo8ROTcSrwizD+6PO4@vger.kernel.org, AJvYcCWrwPFGZonzql/eR4lf3Q9W8QEdHcQ1eOAclu6cDlKin8Jwkytbuayx9emZwEvsEyP7wrlDt0ua5jUIfi+l@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvW0WCls/chgCnEzGBD1jnhfgurYm3/xIsE0UKq/RO+ichyzl
	7icMRXULpDyF6JlWVlmldmj01w+v2ZivzzxZ/Rk0bQg9uP6hgVx6oMoZvR1VX2Ma
X-Gm-Gg: ASbGncuLcQbO++EUwKpp7UORlZuoSRwrUpUe/8cKStGsArQOZBvV2TQib9lxnf660OH
	8evYPBIEXrTqLe+Pd6ZGybCRpm8eRODUDzcF/50wAuiZ2/sKgACyFV+h6/6uQSKFHG0KODq9PFV
	WFtM3ckkmfNDqOfLid5cM9YiecB2ZRvOsqeVLOhAtK0v713WNBLBI+PM+md+TNqwAUvbj5HLk7D
	9+9uZNkHsBr6q8yCEK4fK+rWVOGl0RQMsl/7QIGRx+7Kwc/3mvk5gxIyuSsyxzPuQZ/7byG5URg
	gJEU3tUzdyM6UuOXvi4KNjCKgoNYSQNdsvPVneGZmjCG6AYjai5jjvnAAgKNDYgzmDvLRVXrJSm
	RvuOS+Y1chopaP18n798=
X-Google-Smtp-Source: AGHT+IFZD11SWLoIJGMw58DJpFTb40+2v+CLj8vwZcCfGd0/G/oVJ1klzm8Wz9czNbGBeMbJk9EC8Q==
X-Received: by 2002:a17:903:2381:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-2446d72558dmr174030925ad.18.1755545868897;
        Mon, 18 Aug 2025 12:37:48 -0700 (PDT)
Received: from hiagonb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d554619sm87613115ad.141.2025.08.18.12.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:37:48 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:37:41 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com, u-kumar1@ti.com, 
	hnagalla@ti.com, jm@ti.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>, Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
	Max Krummenacher <max.krummenacher@toradex.com>, Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH 18/33] arm64: dts: ti: k3-am62-verdin: Add missing cfg
 for TI IPC Firmware
Message-ID: <qxrtnwqsc5buihngdw3n5oqzj3yrrspvlfp3yn2aat42io5k6y@g3oqljr3hbvf>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-19-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814223839.3256046-19-b-padhi@ti.com>

Hello,

On Fri, Aug 15, 2025 at 04:08:24AM +0530, Beleswar Padhi wrote:
> The wkup_r5fss0_core0_memory_region is used to store the text/data
> sections of the Device Manager (DM) firmware itself and is necessary for
> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
> for allocating the Virtio buffers needed for IPC with the DM core which
> could be optional. The labels were incorrectly used in the
> k3-am62-verdin.dtsi file. Correct the firmware memory region label.
> 
> Currently, only mailbox node is enabled with FIFO assignment for a
> single M4F remote core. However, there are no users of the enabled
> mailboxes. Add the missing carveouts for WKUP R5F and MCU M4F remote
> processors, and enable those by associating to the above carveout and
> mailboxes. This config aligns with other AM62 boards and can be
> refactored out later.

Thanks for the patch. I was actually preparing to send the same changes.
This is relevant for us because previously we used a DTS overlay to add
the remoteproc functionality, but we also want this enabled in U-Boot.
By adding it to the DTB, it can later be synced with U-Boot so we can
use it there as well.

I tested it on our board, and it works fine in both the kernel and the
bootloader.

> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Verdin AM62

Best regards,
Hiago.

> ---
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
> Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> Requesting for review/test of this patch
> 
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 43 +++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> index 4e9a8921c95d..fba6f5c8d099 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -206,7 +206,25 @@ secure_ddr: optee@9e800000 {
>  			no-map;
>  		};
>  
> -		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
> +		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9cb00000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9cc00000 0x00 0xe00000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9da00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9da00000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_memory_region: r5f-memory@9db00000 {
>  			compatible = "shared-dma-pool";
>  			reg = <0x00 0x9db00000 0x00 0xc00000>;
>  			no-map;
> @@ -1321,6 +1339,29 @@ mbox_m4_0: mbox-m4-0 {
>  		ti,mbox-rx = <0 0 0>;
>  		ti,mbox-tx = <1 0 0>;
>  	};
> +
> +	mbox_r5_0: mbox-r5-0 {
> +		ti,mbox-rx = <2 0 0>;
> +		ti,mbox-tx = <3 0 0>;
> +	};
> +};
> +
> +&mcu_m4fss {
> +	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
> +	memory-region = <&mcu_m4fss_dma_memory_region>,
> +			<&mcu_m4fss_memory_region>;
> +	status = "okay";
> +};
> +
> +&wkup_r5fss0 {
> +	status = "okay";
> +};
> +
> +&wkup_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> +	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> +			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
>  
>  /* Verdin CAN_1 */
> -- 
> 2.34.1
> 
> 

