Return-Path: <linux-kernel+bounces-888810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9522BC3BF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D40B4EB4CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A53446DC;
	Thu,  6 Nov 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Agpg/LTL"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A5303A03
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441607; cv=none; b=NsFmfs86wZqIZ53wp4HouCGkrWSEjb7OJD7GDaFrnmJfel0yhdlg4h+OJYiInUH9uJ1ThRnCuopzd+qrWWG6qsp0SLd1VEqchGUB8QYEflcpFpZxXdix+RD61wu811JIFd07pjdq7uE+9MA3P53+h2/oFeDgULHWVwXaj1EXyI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441607; c=relaxed/simple;
	bh=epKk9hIgRG8WUpPbR0hGKihJpPTkNb6k5T028RwwyQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXfhCiLOL6IyWGOutTdHnJnSH9+ztvx9tohMUqmYwDMDn1qeDaOAl7U2H5zlCw6CsXbmONcdxMUWg3GP83838m/eGA1JaoA3Zf/rvG+1PLemfz8zqCGbumBtkwMSWAWXrEznu6rOL7Tx6m+vNDKQ0mj0A3koNQ6bN5496E/9f+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Agpg/LTL; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-78f30dac856so12586426d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1762441604; x=1763046404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ORQfgg+cW8yABsGzp725YgIcKrepRBh9vz20FOvD0Q=;
        b=Agpg/LTLMocuOYqXKgdFucVH55v0Zye8S99GGENTQjU2aDAnz/D2OBiROvs6hwe5Gv
         NBisqnShY4NHO2TtjskhzciKnQea1MXGxzeThswIWVPeHuuWG53/MI112uujeTODw0Xt
         r70L0MF0RcnpaSnow5VH+CNMpZOXrVMDoETNOPnQX78bOu+se58uAP84+eRAbeaUv/2v
         CB+m0l0Kv6DcdVkQoRkBhk+mSSVrd1/0cdy477ImcNDDQqAzmlIgRc7sBJTtgG73jS+M
         tZboYlYcSLi9OJb0UxJ77tr7dvqyJK9lK2QBK5Uv/LtPGa5Y4zzXlEUpHTAJp1ZkcKUF
         HCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441604; x=1763046404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ORQfgg+cW8yABsGzp725YgIcKrepRBh9vz20FOvD0Q=;
        b=KOSNB9AsLbAmNmK51WFmJNn9H3QKCWZjpIXvzvX7jIOQlhDggEUKNalD1ejZCtDmgH
         acocn6H7sl4uEAWjAundkGrdLic2awUVyBXx6PNUwXs9k0A9YcxSg6Vl02F55rpOboPZ
         21lX/oxRUy/sr/pQ9g/0ln9Qkr5pcMTdIBAY8DQl8l6GeHV+Mtwk0VgI8Yyb6iC3Oy7e
         Jf3GPsZZqjGb4SRLGrBZEMuRLK5UysXYB7qRmLcYpl4Al/jWBcEvGcPZg96WnOtf7kcF
         vuDPgqIQeSnAUJg3bpYBI9kfVvPUtbAYFu6QMSFcXvl3SUbMaFSSyGppo6gTDhFc5Kld
         8iXA==
X-Forwarded-Encrypted: i=1; AJvYcCXD/VUkhM1yeWlMP/W1ZRg2Uo7IagefypbGHtDKf3x8naa2sMOleZQOVVYc2wdKrU46kjAXwlgAWQAy/L8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzer/0KpVi+Bxkl1ZKw39Y6VsD4qEztiIptM/+zXHAFkvbyKdOB
	J8gKBrbBrzT7C4ep2HfsaWo+AFdybxxpv/xXqI65njAsZ+f2OU5ML6CMpbD2OhpR7g==
X-Gm-Gg: ASbGncu1uCUPQ9lCMPAnogrLfYWNvyK7geO194ChHnoOcynOjwhQy565lMc3qVVuryv
	Ml86NQ5cSHEmVnqfqp2NuAGOYZ9PUgKWnqdNkaccMlSyCmZyQ4rjlpF9eNz6/aSQU77VuWErUDf
	Nzeh7JpbXLwhH/+oFKQsVnWJuL8RftXdciVFzTZg/oGR45G1kodj/+XIHoHSDeECfBRHh7MLP24
	HdtCZnE/RNq3gJ+NdEZ+Ei/YgLLnegRIv7vquZm8X4TUSZuiE3XwbGRuLvvlW+rbfkt8An/u/wL
	Yp/TiRsysjXJgMT+9QmEc4smGwwBl//KE1+0vrGaJ07Mpm6emL88fF9pdVOJBzoAxx3e7sHES3G
	X9Jc5KwgMaXhGh7qzfP1QF/Uy3I2NyUvt59DAFduCeMhHSXeN+mqEEazAtliVe+yiQ910mcTVqW
	SnDla03vkKcJNOiCbjuwSbJe+pDGAFCA==
X-Google-Smtp-Source: AGHT+IFBo9a2vdeNFG6Kk55s6sYJCGm3S9KmBS7l6cyJk9i0cDOjX+l19Ru5Cp7b3iLIEfRbNdXt7g==
X-Received: by 2002:a05:6214:2583:b0:880:5813:1551 with SMTP id 6a1803df08f44-880711a9127mr101182466d6.30.1762441604295;
        Thu, 06 Nov 2025 07:06:44 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a08a29sm20453586d6.49.2025.11.06.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:06:43 -0800 (PST)
Date: Thu, 6 Nov 2025 10:06:40 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com, geert+renesas@glider.be,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 1/4] usb: host: Do not check priv->clks[clk]
Message-ID: <aa3eebb4-c2d9-46f5-a8e3-44f17d2ab32a@rowland.harvard.edu>
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
 <20251106143625.3050119-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106143625.3050119-2-claudiu.beznea.uj@bp.renesas.com>

On Thu, Nov 06, 2025 at 04:36:22PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> There is no need to check the entries in priv->clks[] array before passing
> it to clk_disable_unprepare() as the clk_disable_unprepare() already
> check if it receives a NULL or error pointer as argument. Remove this
> check. This makes the code simpler.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-platform.c | 3 +--
>  drivers/usb/host/ohci-platform.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index bcd1c9073515..57d5a7ddac5f 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -112,8 +112,7 @@ static void ehci_platform_power_off(struct platform_device *dev)
>  	int clk;
>  
>  	for (clk = EHCI_MAX_CLKS - 1; clk >= 0; clk--)
> -		if (priv->clks[clk])
> -			clk_disable_unprepare(priv->clks[clk]);
> +		clk_disable_unprepare(priv->clks[clk]);
>  }
>  
>  static struct hc_driver __read_mostly ehci_platform_hc_driver;
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index f47ae12cde6a..af26f1449bc2 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -69,8 +69,7 @@ static void ohci_platform_power_off(struct platform_device *dev)
>  	int clk;
>  
>  	for (clk = OHCI_MAX_CLKS - 1; clk >= 0; clk--)
> -		if (priv->clks[clk])
> -			clk_disable_unprepare(priv->clks[clk]);
> +		clk_disable_unprepare(priv->clks[clk]);
>  }
>  
>  static struct hc_driver __read_mostly ohci_platform_hc_driver;
> -- 
> 2.43.0
> 

