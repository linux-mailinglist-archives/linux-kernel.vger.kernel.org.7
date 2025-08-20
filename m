Return-Path: <linux-kernel+bounces-776846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA8CB2D207
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178D85E3B69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4BF27A446;
	Wed, 20 Aug 2025 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4OJlt/N"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FCB663;
	Wed, 20 Aug 2025 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657652; cv=none; b=h49Zda17B/wGhjf1NwXm6qBfnjcWqq0W3AfYlZJtg18SiM9bIYC0uq4cSYm+vzor1/LcQlN6OAl7ZIUQ+Fb/03FLCpGn4p+p3Fqnc07X+lNI8o1EcSn//y9CLaIFCFY0hPrj3fbbxeQttzgHpDeD3G9DsuBCw/JllisbTTKTUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657652; c=relaxed/simple;
	bh=JKgaCr7lFgvAES2UujZEWfRkmOo5foqMlEXWqdUMs3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCg1lsyUpJlK8Su7gTK/n6EZ0dryxGfn9GDOma30eFkyQrX4S9Cv3l0yL580kDFblk2Uz31OYBAdWmFJ38l5X0vh7iABAdlc8PFtC/KX34U7IuCCi4frJS+1I0gfxUQrUd7D9dN9x5v1jEUb0CPoiJ6sat7X2aZ2DI82CS7n9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4OJlt/N; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b47156b3b79so359700a12.0;
        Tue, 19 Aug 2025 19:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755657650; x=1756262450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5o8thSzIALN1uPBnoTvMoKA6rLfBMmP8vLMFrWtTp60=;
        b=F4OJlt/NeEMZ3YiuWA83kocz5qqxCjrOrKS4TVXqkPXsnfqzMvZKdIaBZrvV7H5slY
         BNUMB9ykA+1Rs5cpuZvaHyrzQynZmuhV5WYEtsZE87KCRnaY2s585GkHVNSgKScn3Y+B
         +XpkiUOnYJWWoy4J6KRrYahnC1Lvwq2D2Ptwpgn03gD05ysMLc2ylsGFeRDeK8v04byO
         0BS7pWYBPdcpCEIeIce95oB3SuhDonBdu/TLHfhT9weG6s6S2XvVqnfG3g0dNkrXVmYI
         Fu70mBZZxNMdeUgIHUOY6z1aRvCurJ3hE48NjQ1oH3XAbDhl6qPpXDHykocS6wM0JdJy
         roHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755657650; x=1756262450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o8thSzIALN1uPBnoTvMoKA6rLfBMmP8vLMFrWtTp60=;
        b=xI3TL1tU/eh/yzSj3Kgm2Er12s4eekVbM1SKhW/zKJqiH2vF4vJ7AsLcbZhRYapCcn
         gP3cGsonrAC+PdcAA1qdmVutXm0LaUQT2verJChbByozw+LpB6VrSKVRQsBj3qzq8F0d
         cduQwMBG1oMZzs5GFiTla0bDLlps+OyQyGAre+79zq6n/alZsjLPgst/kgoWaaimY8s6
         kY2KIBv3hh0JtyP/PVyabJecdGJjkA7JAo4VjSjeJmnyG+nVi/q/mzq2r7jmAIBhuRKK
         gppX77IGuNOiQ9zzHA1aqMXtAe2IE6PqtxMy8xqDJcXwqvSubmAOQTOD0v10RG+ZN8+e
         MbaA==
X-Forwarded-Encrypted: i=1; AJvYcCVZic6Zua9w2tWGVv+pwadUQE9Nzd20ztjmzTHeYTRREuySegPY7rZaHKdeKdiv9OxPI1cuEgXk0SzO@vger.kernel.org, AJvYcCWfJnXsENHrmsFLEPh52esxEKHh6PeqYR4y1FQgEyF8hyb2xywhudctdjSPKbVQZofmc5Xnu0M8jAO78mfw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyth+vmqyz2FVEcrbx5UVidM2SVu942pBNfEgoSLvuHgQqBSdFT
	Aeg60dbbvz+uEpfdMcp48ul0ynhArfLPpQItuQvAqRtpFFWHzlLF07Ac
X-Gm-Gg: ASbGncsx687p4UanxQQeBbiBl9gJWYpg69u2F7zZ8leHNp97L24Fv6t3DWHN4JBUm+Y
	Gq9I5Uz9r/Iu2b2aoyMKsUzQVVkm4jYtv68pOsQOnOHZ1RD4XeB6IhoO3zSvHvptUA55zRQMxXI
	x1iOPnyDM//egdW3wn7fhxDIMXf16BItxK7UIRKPAUJ1fJ5TZU2n1dBFx6z3X8yk48whUIbmoE8
	259riyi1Mjbhx0ja6L7xTsPsea1vGb1KAaEyQGf7tustSmkn2NWtjnXBANGWdPVu0oECqcITyXY
	Jmp4sM1mrMGZW4ccOgN4CAbDtYNXkoqs6Xsz0UtRSrsfbxh241WBEz0lfwuO0DJ/wxGma7k9a18
	YA7H9I85LATrSqfY=
X-Google-Smtp-Source: AGHT+IHq6qOIwEilWM/BAT9k4oZ2UZBkL4UPMZyaTKIJz4HZq4C0Dc+kdcM0flbXi6E7TpzgZz7WIw==
X-Received: by 2002:a17:903:90f:b0:237:e3bc:7691 with SMTP id d9443c01a7336-245ee117b55mr18310785ad.13.1755657650342;
        Tue, 19 Aug 2025 19:40:50 -0700 (PDT)
Received: from anyang ([106.250.177.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ec0ddsm10880125ad.114.2025.08.19.19.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 19:40:49 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:40:44 +0900
From: Dongjin Kim <tobetter@gmail.com>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Change ethernet TXD timing
 delay value
Message-ID: <aKU1rJKzkkS4P+VT@anyang>
References: <20250819075522.2238643-1-tobetter@gmail.com>
 <20250819151019.877709-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819151019.877709-1-amadeus@jmu.edu.cn>

On Tue, Aug 19, 2025 at 11:10:19PM +0800, Chukun Pan wrote:
> Hi,
> 
> > Very poor network performance is observed on the ODROID-M1 Board
> > (REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
> > this problem can be resolved after changing the value of TXD
> > timing to 0x35 from 0x4f.
> 
> Can you try changing phy-mode to "rgmii-id" ?
> 
> ```
> --- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
> @@ -200,7 +200,7 @@ &gmac0 {
>  	assigned-clock-rates = <0>, <125000000>;
>  	clock_in_out = "output";
>  	phy-handle = <&rgmii_phy0>;
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>  	phy-supply = <&vcc3v3_sys>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&gmac0_miim
> @@ -209,9 +209,6 @@ &gmac0_rx_bus2
>  		     &gmac0_rgmii_clk
>  		     &gmac0_rgmii_bus>;
>  	status = "okay";
> -
> -	tx_delay = <0x4f>;
> -	rx_delay = <0x2d>;
>  };
>  
>  &gpu {
> ```
> 
> --
> 2.25.1
> 
> 
Thank you for suggesting me to try 'rgmii-id' again.

I'd remember that 'rgmii-id' didn't work with the very early version of
the board, however your suggestion works. Let me test the change with
more boards and submit the new patch when it's done.

Thanks a lot.
Dongjin Kim.

