Return-Path: <linux-kernel+bounces-793463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3933B3D3DC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1380F189CE9A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510EC26D4EB;
	Sun, 31 Aug 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="O29geZKM"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188FC257848
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756649604; cv=none; b=t/3SunbULy1KGwb9aIf2TGws9V0QXZZSTmrZteB/Uv44hkGmApxxiJa/jazwdVHe09O8srY5+1z1+t1VZAfHXuYI1iIdGAHEuSLkfe+cahN6V3c/q/b4v8yj99YM0k04/wnKh9JAF7TPn22+gq/KG5E8xNPzipyJd8YsmptOSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756649604; c=relaxed/simple;
	bh=NNaRzc54R7CkH8DGod84aqEZIb1kdPD8DIczOdskT5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0Q/ir4jvi1u8NimW+yN+ESaUxfL5PWh6QpNxYPLql6My6tIgkBc89NFrY3B7663iOgqzROJ4vnEAxR//huXyM/QOQQ2FuaE2bWdIGFt0Qiz891dcwrdcAo/ptwGJMt8T5OGyigPQTiEJozP4BXeC1lo5QWk89uCEsW3mHe0UFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=O29geZKM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7f901afc2fbso299220685a.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1756649602; x=1757254402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZYLdktZ4EPO06YD32v1q0DpK8GiNv05c9EBnf+HoCw=;
        b=O29geZKMmzrLZzRwJdLGYMPODpfdZoO4R5zPykibV8/KA6hWs1WzLvzch2KWTutR1Z
         rl791j0cLnbpDlo8A9rT/DipI16oUUUloWeCd/8VKM+oEXB0qrmldl6Wn6GoBJQt85Aw
         eQ/jNuKHtNLYYwnjSdSgDGABnuA0lzGZ8MHoFBU6FVbY83lsm1+eNFNlPOuroC5XlPM+
         Phue281M/aqU4I+UaeGSFruxx/IlxP1NRxyNswtAUhE/de8VSx8/rbQzRqqTBF92jpc0
         1c7cKkay188khUT4k4brf1p68kP/X6kn1cfwnSbJBAFqxMF4nwT/lj00pTKDhS2V7oL7
         gi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756649602; x=1757254402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZYLdktZ4EPO06YD32v1q0DpK8GiNv05c9EBnf+HoCw=;
        b=l+awZYKJ6RPtHvJA6XQiGfGhXwbta6g7yFJSEGvUcCzrJc/PYm0K7Lfe1uqsbdWHN7
         fYf50ZNBsfuHOVV9Lld7A57Wxwy53ORn8qqeNlSjvf9rU+98xbkYcd3HYsKU+eDZ2Uaz
         eFTfx6MRSsEb3H+Qtyi68qetiImGVFAhQLeGkRVNqln46y2VAv67ptK55gZ/tzYeEJ0w
         2vGY1w0h9MtSfj/4NuzlajOdyD/zqgQ1MRpFBHlJwjgjzVIs2r8G9PzCsPV76RNs1Mp4
         q5JDa1fzgCjnOiGOJqJdcDePNfA0DGGhJOBMo2O+p+e/Eago70/o55uVgcAUnBPYBq1m
         StOw==
X-Forwarded-Encrypted: i=1; AJvYcCUmoPkKGfxstLtH0QnhCArmaYFVJLjxsysrvNOQyv1PMh1G5e1nmp2ZOjR4EpbTsbKoZFLSyA9YF4THI1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiinKMF8Q4V8xIm50RvkMzJOSe0Kqw/USZGcT8Xm7/NT9Z7jhL
	B+N06ta0djqHr4Y2uaaDHpC5TE7bm/wvBxzZO6L5CXLifRklAvJKvbvJoZaHLfxk/A==
X-Gm-Gg: ASbGnct6EPQd+brl99rtXNbBjXnNpjGYABg+Mx5TZDwd8Z+be2BTYchxKATCb17JxFt
	OfGZSVY2ReEhrx9Sc9s8LdnFmHSeQRoS5ENbxjnDDUJhSeDu/PvJdd95booiWnDOMOjwstQscjK
	GTCCHBDGaSS8kV6x+po6SYUrs4+tXPERTNxx+KhV6CQJo2rewa1v7psPxe0uwz3qXkOpYl+NZ/9
	PP0C/0emSxyIYrHgqeu0XPlSbxD/Hy9RsCRZauxQP5eD4E8+YR/+ViDCI3XmX/+c0Zk1ZXNhcGs
	n/pJpqOC1XKUrkLXZzgRUKz0XEpLXLSNRdvGoOcVXop9RhOBNwT07jr0vkkIN7FOa4qT9IcPxX7
	WPp2LaRv0f7m19o7e+0AXNE//N+2QAg==
X-Google-Smtp-Source: AGHT+IE8Mqej1JDZrtuPz7sl66EYUl3Vb5Z2gtzRXa0W+3TefhnO3F5sshyISi1xvDod49i2QcLnew==
X-Received: by 2002:a05:620a:172a:b0:7ea:61e:3ce with SMTP id af79cd13be357-7ff26f9fd08mr460588985a.4.1756649601956;
        Sun, 31 Aug 2025 07:13:21 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::f777])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1484a7a8sm512990985a.43.2025.08.31.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 07:13:21 -0700 (PDT)
Date: Sun, 31 Aug 2025 10:13:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: ohci: s3c2410: Drop support for S3C2410
 systems
Message-ID: <188881e4-09a7-49fb-8128-ea7ee85147a2@rowland.harvard.edu>
References: <20250831122222.50332-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831122222.50332-3-krzysztof.kozlowski@linaro.org>

On Sun, Aug 31, 2025 at 02:22:23PM +0200, Krzysztof Kozlowski wrote:
> Samsung S3C24xx family of SoCs was removed the Linux kernel in the
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
> 2023.  There are no in-kernel users of remaining S3C24xx compatibles.
> 
> The driver (named s3c2410) is still being used via platform code for
> S3C64xx platforms.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> Changes in v2:
> 1. Commit subject (Alan).
> ---
>  drivers/usb/host/ohci-s3c2410.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
> index 66d970854357..e623e24d3f8e 100644
> --- a/drivers/usb/host/ohci-s3c2410.c
> +++ b/drivers/usb/host/ohci-s3c2410.c
> @@ -448,13 +448,6 @@ static const struct dev_pm_ops ohci_hcd_s3c2410_pm_ops = {
>  	.resume		= ohci_hcd_s3c2410_drv_resume,
>  };
>  
> -static const struct of_device_id ohci_hcd_s3c2410_dt_ids[] = {
> -	{ .compatible = "samsung,s3c2410-ohci" },
> -	{ /* sentinel */ }
> -};
> -
> -MODULE_DEVICE_TABLE(of, ohci_hcd_s3c2410_dt_ids);
> -
>  static struct platform_driver ohci_hcd_s3c2410_driver = {
>  	.probe		= ohci_hcd_s3c2410_probe,
>  	.remove		= ohci_hcd_s3c2410_remove,
> @@ -462,7 +455,6 @@ static struct platform_driver ohci_hcd_s3c2410_driver = {
>  	.driver		= {
>  		.name	= "s3c2410-ohci",
>  		.pm	= &ohci_hcd_s3c2410_pm_ops,
> -		.of_match_table	= ohci_hcd_s3c2410_dt_ids,
>  	},
>  };
>  
> -- 
> 2.48.1
> 

