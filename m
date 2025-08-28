Return-Path: <linux-kernel+bounces-790423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA6B3A6FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EA13AEE52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41A6322DD2;
	Thu, 28 Aug 2025 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D723hnXw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77EA2749F1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399943; cv=none; b=u//pVjACAIbkibd02l42FcPEgsWzkJ/+SGUdMwbD2E1yYwbNUGxBXq/rIu86dNkphHW35NypJjYLQIpmj/6hJTbvWWozeuY0mvmnMsDtvZcqNcbZvxtQcGloE5ADiADGJhZEkU2u8rB73lXyYLn89FJzX75XjZeq09iidlnkTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399943; c=relaxed/simple;
	bh=F6F1t90tDYHI9HHx/dUs3bHIlZY2N4fRir8Q3403KXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIDvdbGm6WwI6b8Dr6x5f22z+2RPzeF3iQMz5YrOoi+g6JjyevJOwuP9xBetcEtuOiknbnr4Mvgc4k4Eas8tRzGS592ClVxjPn6a8FxeBsgMxeuwb/ft3z1vub5Py4JJVUwBvYu6obN9d6wKYkYENWtUpBDUnUT2kJYt1acqTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D723hnXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756399940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xee6NKuNIkTbreHLQ12czC3T2u1dvCFe2tAbj30qkQs=;
	b=D723hnXweBgOEaWDLhbBgFpNCwz+rNw2Ygde2GotG3KfUqAYhOYPYuXkKfG82jZ/HZNoMI
	iHFN4TIYRWbtV78Rd4D/6p50k+mpGc4wKTxm5q+TYNwDVNGGx6VcEIeJ0Uu4rf+x/1U7g/
	CVNM3Ffrsk6F6Wlylfv4vQYXkMOb8zA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-P6FrMAnVM2OgRSB5a8sgDQ-1; Thu, 28 Aug 2025 12:52:19 -0400
X-MC-Unique: P6FrMAnVM2OgRSB5a8sgDQ-1
X-Mimecast-MFC-AGG-ID: P6FrMAnVM2OgRSB5a8sgDQ_1756399939
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dd6d25992so26631076d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399938; x=1757004738;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xee6NKuNIkTbreHLQ12czC3T2u1dvCFe2tAbj30qkQs=;
        b=k2vKFxG7ZKeDIoNFt1p7lKfI4AlmJdmohnhgt+bU5bNiw/R4UOJitcPt5OYNHo4MxK
         qcx6Ca5ENt6K+tbwFbYfESHgVkVAHDrXEcU1Kz+juL3U4r8mYRff84HdCob3lV2KEx7S
         eT1CYEgJSywNO7DR0XBdSE+q6ITIzhLj6WrTV2zcGBoqla7PAK1HDplL5hNOs70qPRWq
         MaPCea7l+0vV17iCh8PTFjVQNoqrKsVfyCAg5mPkyfmA87ecKL6+DHjR1Vj5dIu8L96D
         kUCbqys9tdiwLnbzCG/aHXilH0I+xL/JYxwkEgFU1+FT0ixT1DwR1ISHbfEJrSl2JqnU
         zKSA==
X-Forwarded-Encrypted: i=1; AJvYcCWIi4Tw9soZypbAu2WyfpsMNWZyjQUahLXAOdEMVhFd0HB0sFwHNzxnRcpmD1S4vSVBD12pCEudaO2Fq4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QtDGSZGajmW+1u8U0jSgbe8aLhR9DrJpYFeJBJ/zDZaXqwEk
	SLjEYyv+8H9yesy5bgOW53nqAp0FBT2IhTH7bSDZaE2arv7xjET6svesdEcYs+S0Dz2sBEIaL+z
	A/003ERcdaJRbZBdC6DRS09zz04biMC9EhD48JlryVkK2qVCwKcptUGvsytw9aHvEXyfZzVziYQ
	==
X-Gm-Gg: ASbGncvJSdnYB5Q302AVCQlOg+ygoB2mGCLw0/89HkE7/GCG5398/h4yh49LMIzGkBd
	6RACO7OygdxD5CGNojUWwrcKId5XSdK101bHcWXyRBYB0mmkXMfISacE3R3zCJNVLdIAYFpGUyU
	Zz/fBjiZSBieMQVDffTMrw/k7CSsyYjO0Obe1bZgEpzNKxrHbJ6d9ePyimwzeuX9n4BYcciJqwD
	5Gf8dWMAbyafON55OecsOdpRIjhsWFiM+ivd8Kku6/CNlod/7yNAGjMxlkfPz8zAFK41Xp1ZoUg
	rgs1VcqAgaV9sZSViaeJVESzoFHsWXSpZskdsP4v93ykAbYnhgTqiNGmd2wDx6eHOG46/8phQtP
	Y/D3RwFmQqAbG96Mc2jQ=
X-Received: by 2002:a05:6214:4004:b0:70d:91e8:6cb7 with SMTP id 6a1803df08f44-70d9725f3e3mr251186736d6.66.1756399937787;
        Thu, 28 Aug 2025 09:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpZ4ICMlbvyyFxhlVpeB0jL0VatrVSJLDHmA5nepySE1dAK1W4TzFTEvJOVDIu9B0SbTwIFw==
X-Received: by 2002:a05:6214:4004:b0:70d:91e8:6cb7 with SMTP id 6a1803df08f44-70d9725f3e3mr251186526d6.66.1756399937368;
        Thu, 28 Aug 2025 09:52:17 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70de7e0ae63sm30790536d6.52.2025.08.28.09.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:52:16 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:52:14 -0400
From: Brian Masney <bmasney@redhat.com>
To: Ryan.Wanner@microchip.com
Cc: mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v3 01/32] clk: at91: pmc: add macros for clk_parent_data
Message-ID: <aLCJPlWTHcaxUze0@x1>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <f3ef0275345578c504b41710c67bfe1238c44c21.1752176711.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ef0275345578c504b41710c67bfe1238c44c21.1752176711.git.Ryan.Wanner@microchip.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Jul 10, 2025 at 01:06:54PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add helpers to set parent_data objects in platform specific drivers.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: enclose complex macro with parentheses.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/pmc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 4fb29ca111f7..0b721a65b77f 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -15,6 +15,12 @@
>  
>  #include <dt-bindings/clock/at91.h>
>  
> +#define AT91_CLK_PD_NAME(n, i) ((struct clk_parent_data){ \
> +	.hw = NULL, .name = (n), .fw_name = (n), .index = (i), \
> +})
> +
> +#define AT91_CLK_PD_HW(h) ((struct clk_parent_data){ .hw = (h) })

If you have to spin a new series, then personally I would put a space
before the {. I see both usages in drivers/clk/.

Reviewed-by: Brian Masney <bmasney@redhat.com>


