Return-Path: <linux-kernel+bounces-870456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE0C0ADD3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371403B3659
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791C2571DA;
	Sun, 26 Oct 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyz/GNnF"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0E38FA6
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496674; cv=none; b=rpLV8SJM9VqsT4/cnXXOcvn2gt8ZDz9Ai2MWerK+HskbjnYXQ6ABbNMgVvXbBgPWxdKHaF8GPL9QwWJHtPGy4saMjj5w+fgCdQx7SLFhZ3WXbkWW6pelhbApkrFqzoy0qrJzUHdtjM2cwyY5VtK9LZrvDyEj4UocCIBBr4sn6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496674; c=relaxed/simple;
	bh=Jn7ngMBWIUhPYmq3HsmvV2FyXT31L+46gLuKAYt+qfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgSBUggMMLvdtNL+CkvEwr43GDzXUXhv3pgmzQ4fi6l1vUjcZkPRmWRAcG7ZAVm4ViESHZKHOIE6opuTAcjNpQgxb1TufjCDF2RBWoQT0V7rmgx10kguzH5wF41uL8Spq2scoODJSLfNwd0RCTlVFTDoaSdkoavh9IXpJmSx8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyz/GNnF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so506001166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761496671; x=1762101471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XxEe6D+FFfQqIEEbE4sKMO9/YUuuqd9OGSQoRJvBWE=;
        b=hyz/GNnF0aCD6+j5VZLNSwr5I/e++NY0+Qh5HeeM5t4U+kBRfipDmegwE3UmvV79J+
         uWdgZyQFWUyItGQ8QqCKzD4v0q1EzanyXytVCg6VXiWyCbMtHklksjRaw/HdFOJw/G9f
         vVvx8V3aqjmD/D9YCaEXisbwmGR4lduR9yc4bmLmLczjkzId1SvSm8FzdrfixZCZB74T
         9ICmqOpivpdMPx/idChI57Yvdh9IF0d0fyyrtaGDUidJklATrmWwnmIpqm5F2SwQHg9v
         5zTtMlJqo9EshP3asxflvPpjI0lkoYpJKg3Ktn7W8PlwB/ylXFagSHUo0SbOo2htYwnB
         TzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761496671; x=1762101471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XxEe6D+FFfQqIEEbE4sKMO9/YUuuqd9OGSQoRJvBWE=;
        b=sGGpnl18eE02/bhmZMktdXJH8HvpWi2tqxlerOrlYLSiBLWmBdzilTj/S8Vomwf5M+
         LFbsp7q+F7a16VIuux+5BDlshy5jlvnqQL2MOChVQGLxRtAxUNzUvnbztkt1EGXDrr2C
         bJGGkLgNPZdotBNp8EPs58FTwMNYrtISEuoGuEGjXoqL4qBo9kHBrKclk6wO1xDnZ8Ih
         ZfQej8a+PNX+G+Q05FB2/X49wuQBDsjipJ//PV8BkSDSkx+xCMYZ2R7KYHWexmnu4Mn2
         yT/xzrqwZmUbpVwHYJz6ZC1WIXXwgo9ripN6EK8Rglbx+rRW05WxTKBRwCuZ3OKM0eKA
         x+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeAEJNzYMvuiJd+4Gw6yk78ao3FXTyNVVaWSx4bEi5QITPrW8eZGSOFOPn35xQgYJqvB0NHeUvIjHz9YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJHdzFyGw5S2YDuiYrxuPhqGFH2NO5hg+vDR/cCXvyPR91Nxl
	5DZVqQbtjbFF7xnh7AXBhWBUW7+6ynvVuhXrOJVXz7l+NVF6Ge4fPzEQ
X-Gm-Gg: ASbGncvechN+1NV7SWsSRoO4NQQk2L+BMGPHw13FcZR9UNGoy+YMUDDAc4e5274NXk9
	O7CrXOa2NXtvydYfqBT0ta1MOP/kDN+3aIgNySMatx3lfrJ82xTqjJ/yfGA/hgekep+aVg+/WvI
	w4hCDPCWXxo+0Ogfe0k3BI5vPwT0i5+4WbWCA1GvWP7zfMaRC53sS/sBmNaAwH/UAb3nJ7t1wWL
	4H1FQ87MT2MfOp9FKEHtw4jNecwymkOX6TyZ0VJpfskiePzmAi+Cd0tb9w7FKjwNuXDnh09/ybA
	6NveV0U9M0C/ZXRtqgMuFk4cMoUdoebrbsldOhfQrFAHe0Zbnyn0rnKOi7yGY6tgLLqwapZ/mnE
	Vw939z/8CRkS9NyL4392GEwmCWpiHtHEsJIvdOTii2fMrchWMFAYALaOM0qtoGAORdurwnhQQ3+
	SPW4QXEA==
X-Google-Smtp-Source: AGHT+IEoV/OCny3StslIHhY+HhBv9Tk1poW78TbiqX3CKYhoXcDxOU8er8pKIVdW2dVWKc/kXQmqZA==
X-Received: by 2002:a17:907:968d:b0:b6d:6c8f:6af6 with SMTP id a640c23a62f3a-b6d6c8f6f3fmr960640266b.16.1761496671063;
        Sun, 26 Oct 2025 09:37:51 -0700 (PDT)
Received: from home0.fritz.box ([2001:a61:123e:4501:d88:2861:1686:c41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85445e81sm498050366b.64.2025.10.26.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 09:37:49 -0700 (PDT)
Date: Sun, 26 Oct 2025 17:37:47 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <wla7ldkhm3mca6eadlx2cith43pcvdg4tertmrhjufqa7wqnc7@fcfacbnzcjvo>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-1-0f8ce7fef50c@analog.com>
 <20251018161143.0a89495b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018161143.0a89495b@jic23-huawei>

On Sat, Oct 18, 2025 at 04:11:43PM +0100, Jonathan Cameron wrote:
> On Mon, 13 Oct 2025 09:27:59 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> > monitor capabilities SAR ADCs. Each variant of the family differs in
> > granuality.
> 
> Resolution?  I'm not sure what granularity means for an ADC.
'Resolution' is the correct term here, thanks.
> 
> > The device contains two outputs (gp0, gp1). The outputs can
> > be configured for range of options, such as threshold and data ready.
> > The device uses a 2-wire I3C interface.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> Otherwise nice simple binding. Nothing to add to Conor's review.

Best Regards,
Jorge

