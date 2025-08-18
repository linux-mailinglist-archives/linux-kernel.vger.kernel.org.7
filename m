Return-Path: <linux-kernel+bounces-774406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75EDB2B1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AAC520DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35BF273809;
	Mon, 18 Aug 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGW5MmAF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E562727ED;
	Mon, 18 Aug 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545992; cv=none; b=fICXeO9n13sa06FEz6Y7tTKdwgM92yLNFO19tKvg21wHTG9iqO20npLfZeTaPyvY/RODZ4+wM/cU+Lf+jcM+GOIT+0Jf6ugA7cAq/eNlkXDqe2+qRdtWNUimTW5ObI9/27xP+ialvwYS3C3JOu1XcUTiuWDMHmNk/pkg4htPW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545992; c=relaxed/simple;
	bh=rsqKujC74PKhDy4HTNDmFXCHDl5fhL13maDHnsuJfJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxrlmlYi4NE1sMBB909Ns7rgVXoZ8QU79xhLPZfe+ttyaQwUjKgc4AXEHd2HZyjN6UN/0aF40nq6a5iuMXdbMofYuvuQ68TPfLeO24WBN4LkAuRdoRA/jXIORZj06FIsLVpHmx/QplL5O7Ta44Hd508WMD8Nza5iyELAOtPPEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGW5MmAF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so4030592b3a.3;
        Mon, 18 Aug 2025 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755545990; x=1756150790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35JWfyFpsZnEop8+iFDta6CZEM405LCjsnR3UpcJ/2I=;
        b=hGW5MmAFRRMu0pWOGPvQlir7mJWjuXPdVJE5JjejksO20PG6Sj6yUBHaUUWfeAxeZM
         gVMfaOPHTcz9aBSUao+s/b1lRFUFj1hQ04+Iiz75M4VKoOZSL611YfxVO7F7A/ktqbo7
         v865Tn7fapTg1XeB8upJlpgwIuY+eMWDne8jbXQ6IjYkBcoZ9UHcRByxlZydsFbgI4Jq
         jJIDWaahCN+zuWOJU3FrmVQk+uQ+0ocHvXWYAPDXO2TaB+nSMJOpTHd6CzMLzM7nXWxH
         wtVMRWGoGySrBrcSPXGSxBFhs7OETHYRjVX6JIT/jBBgaKEexUkGyAKEofKLVJ9dw0UF
         ArZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545990; x=1756150790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35JWfyFpsZnEop8+iFDta6CZEM405LCjsnR3UpcJ/2I=;
        b=AfRn4oGBFiac86+u9NzO7ian3O36fbiRoeAhwUW9OjGEuOa2q1zw12uZoggNNgKcoy
         Ry4Fb+TpKKl/v1cQeobSTjNcMZ3WOhK9k63Kya2NPCD+zuYF0wTqQhXM3hP1lUgwMbwH
         9fLzL+uUYBfRsOVMUF2KVCCFMosRgyH1LkKpqLyA1gnqnpUdcJquyTlXHSP3y+vPcdyj
         4WQ3aTkuIGfetterOpbIZsGwXN26QUkibv9hMwHJ/vCuIfUAdZlZo1H1xZQ7R9wg8wHy
         /M+x18d6gmoZWns/QciqSVg53LtpGE9D6LJ6azJqAcWqG5IDvIjq0GLrpS0BH8zEHIvc
         jJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDVoXoYliqMv+HhbwjvIvC/vvNidKjSUpJNoICpK74fA22tFQppghKHQ5eCnaEWhxboDwGsDgjzpqR@vger.kernel.org, AJvYcCWnh26KP195n6JChC/TDhlSoRVnYLJHj8uRfyVstkjrd6WSxy8o2xBZU2lPV8Zuv31oB7Gs3X8D88uBVEBe@vger.kernel.org
X-Gm-Message-State: AOJu0YxMfUUlbaZ7O51XtyWHKyQ2gkw/VVRWRmx9ZEVp4ocUgRVRTNg2
	L5JOsQpigT8BkOmiZNvRAOJ1DUjFBZpWLdEaQiN75G6vwZ645m8G9ysx
X-Gm-Gg: ASbGncuS3hZlHYuY1NdMTrdU3VC7gKbLtOMd7pIetj4uQncLVvACUQqoyfIJ5E+n0TB
	Ihzdebb/JuPmtZYFmkOIQKC2/15C8hCkUSyIeHJJFV7Hy3qLOUviFxPnYw7Yb17JKmxEdQcPfNq
	gDLWWuSp1F47P+DYk2RdeeQL4SBhiXoNyDCzA0VL4q9EU1d+AThR9r+0l77Qula1GsUP83cUzDo
	gLCPsn8o53o1vud+xUa8c9KbdcKufoWitZYaFGOTvB5QrQn10EaBrDL7CSlmGocduJLeruY/rD4
	88SEQaddQvDmQ/NFEtEnGJ30pYJPQpq1eTd8uElqenSh+HgjTh0TXbjgiVqHK3mtl9NR4iA314d
	EdcfANCk0lOCX2j7fTr3emfxMTW2RYg==
X-Google-Smtp-Source: AGHT+IGydVew6TKOYCHSMUAx1U3DIa9x4LQIW/1PWuj/aMxwX6Vwe2dlC51Swfi7YoObxa0NRbjXuA==
X-Received: by 2002:a05:6a21:6daa:b0:220:b161:431 with SMTP id adf61e73a8af0-2430a6cd5dcmr788844637.7.1755545989791;
        Mon, 18 Aug 2025 12:39:49 -0700 (PDT)
Received: from hiagonb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f6ea2sm369307b3a.62.2025.08.18.12.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:39:48 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:39:43 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com, u-kumar1@ti.com, 
	hnagalla@ti.com, jm@ti.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
	Parth Pancholi <parth.pancholi@toradex.com>, Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
Subject: Re: [PATCH 16/33] arm64: dts: ti: k3-am62p-verdin: Add missing cfg
 for TI IPC Firmware
Message-ID: <o25lp7k7igtxtyycud2oynyughysq2egn3klnvrelc4dsshye7@2h2jquxcfw3l>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-17-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814223839.3256046-17-b-padhi@ti.com>

On Fri, Aug 15, 2025 at 04:08:22AM +0530, Beleswar Padhi wrote:
> The wkup_r5fss0_core0_memory_region is used to store the text/data
> sections of the Device Manager (DM) firmware itself and is necessary for
> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
> for allocating the Virtio buffers needed for IPC with the DM core which
> could be optional. The labels were incorrectly used in the
> k3-am62p-verdin.dtsi file. Correct the firmware memory region label.
> 
> Currently, only mailbox node is enabled with FIFO assignment. However,
> there are no users of the enabled mailboxes. Add the missing carveouts
> for WKUP and MCU R5F remote processors, and enable those by associating
> to the above carveout and mailboxes. This config aligns with other AM62P
> boards and can be refactored out later.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Verdin AM62P

Thanks!

Best regards,
Hiago.

> ---
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Cc: Parth Pancholi <parth.pancholi@toradex.com>
> Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
> Requesting for a review/test.
> 
>  arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi | 42 ++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
> index 6a04b370d149..0687debf3bbb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
> @@ -162,7 +162,25 @@ secure_ddr: optee@9e800000 {
>  			no-map;
>  		};
>  
> -		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
> +		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9b800000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9b900000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9c800000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
>  			compatible = "shared-dma-pool";
>  			reg = <0x00 0x9c900000 0x00 0x01e00000>;
>  			no-map;
> @@ -848,6 +866,28 @@ mbox_mcu_r5_0: mbox-mcu-r5-0 {
>  	};
>  };
>  
> +&wkup_r5fss0 {
> +	status = "okay";
> +};
> +
> +&wkup_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> +	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> +			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
> +};
> +
> +&mcu_r5fss0 {
> +	status = "okay";
> +};
> +
> +&mcu_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
> +	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> +			<&mcu_r5fss0_core0_memory_region>;
> +	status = "okay";
> +};
> +
>  &main0_alert {
>  	temperature = <95000>;
>  };
> -- 
> 2.34.1
> 
> 

