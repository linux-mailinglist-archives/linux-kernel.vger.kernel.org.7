Return-Path: <linux-kernel+bounces-858039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94881BE8A80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FAA6E2323
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B7330310;
	Fri, 17 Oct 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="das2UgJ/"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DEF33031B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705335; cv=none; b=tF45HBrKkC+r+XdTY1zDY6umWVu2dl4RC68Fk8I8WvpMPA9Yibe802goNqrJG0aLN2yOFgS/L/Cdaz6V064vigOnet9/PwwSxlt5TnZtKHbqroI0jDoaaLilp5jLoYe52+tU46yiQneisnUDBPYUeqRE5Z3iTIoicbHt3Gjq3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705335; c=relaxed/simple;
	bh=lw5cb12WTQW5V8LKlGN3d+ABzL6hKt0x7IsEIl0HPdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffdSCgacTa0OiERrT6qmepXUClqElCgJhUxNXd7ql5B2O/0U9QOtMse/85tNgv+XXc/hOXkUMjnkQVAKAVchiP5v4Kxxblv5CO4xFtGNL9viyjf9vp5PXmO5xwyc9ybuGCAagTNfa/Sr7bh+ZEajCw4h8nT9cct0RDbehTq+UGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=das2UgJ/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-796f9a8a088so1865469b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760705332; x=1761310132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vm1q1yJNMMPqej5XCUEQWCVG1hgmSTxZ5v4pBOj1eAo=;
        b=das2UgJ/OdqBeODEJnZopFMVZMcNTNIGK5EzrEA0l0rCSYDsvAiPr+V5pTm12X4GzU
         Kk3cXA2toWNcsOxJvdEVZ1UslLRMSTe4yOdSlqq0KTsOQL+G+43zSNz6qqQXeX6hB9Ow
         NO+atH17rp0lZbnJzZiWpkRi0CKNRa2XCUmarZ/TIfayUzS9VQ340mrdpNYmm17RX6g5
         cPIDbR3gLcv1XprIsxlsDM/wlIUZ9/sYX5UG/xzuhZS9hm3ygjRo5Bvwc+qwGbHAlnv0
         HP3h9SKz4l0fQGovkJk06dvt7rjyDB1U76wCNBTP6LB09ve++fvJyvj42A8XsPSTb5dZ
         oieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760705332; x=1761310132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vm1q1yJNMMPqej5XCUEQWCVG1hgmSTxZ5v4pBOj1eAo=;
        b=WxdO/92s9uhp4phKKxwhnPm1MbUeWLa8Odd+d/S4C6A6Q8S6JYyWhyRkqHHkW7aGlG
         bgG6jmhrG1fPkKRw/wfPAykvRshnhT3cO+eE7ELzRLvKXVrLmPKmu8+DblICYz9YWAUN
         DsBwYBDOH2Bv7VBsOHKJvkiHoAhD1o4rqB/y2SI1ei0IKR+LWETasFBetYoWEDUDi+ZL
         eeb7246RJVZDEm5KHVGCG4jXfL/PLuHvNByqJJBfoBKdhBpTY/LJl3iVphPq/UKUY5O2
         1JYK165E4d1VfoWSb9oOdF4PQM+HDO16+1n1lzfLfSNZEnpIzJ8SXcXXO+FK9eThwAAf
         y49w==
X-Forwarded-Encrypted: i=1; AJvYcCWH1uIqCE2LAGtwcitpLSaVNrsi7B8NL0lt30X23bZfaFPrhkwhV+0R0E6MFzgOGiZkNXcuu/N9nr9DIkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XCjcwwolrfAtr9VkZHahIGp+byQXfIzqH23yLGzkWE+C6DTp
	/I4HoenUc1XPC24T2QPgpcjkCyJFhW+qQSKwWhp9FxtldbKTTKguO4qZ
X-Gm-Gg: ASbGncvjjrWQO+UctkiGzduDXoJ0Esvb3K4QOA+nwqy16Z1R5D36p+ai8XzmUrumdOT
	wcZ+3TYDB0X8g6/h/cAY6ggI4wzOo5e7XX+HpRtBlEwbl/bwpdJqkYTVLnxQe/gseBcARi5A6Oe
	nmVV5OHQ1yX+jVwP2GnPPtUNDKAcV3KZ5ltRt/Z5kOFujEd70fWe45xE0uFYA1Cy4/6Qe1UTEvC
	wt8xgRjVmpEb6o52AeXWPLlkMM/LeqNw0Njtbs0Wu5CktUwq5vhEBxPwVqGz538YR24omn/Bzau
	Hp3opmKLImy1/E52c9CcSLoxRJqg4lgIa9gSHfbQpociSBMDc4hg/VuXk0JUxGTA8vjRGdIViZ/
	V5WrwJteVKCyWc2PuHa8yCyl6d85MEdK71DkPclUIj8Xo6CEVIjBTS7zX70h2qQeDvOW048vHCR
	z58yLBy6pKxI0lZQ8coJL4RQ0=
X-Google-Smtp-Source: AGHT+IFwTxIM7KbRMRI4pagPw+NiPSPIsNhdBx3JaSyasAkdLl7zRtFXNHdz/QIh6BaZIRnxB4f6nQ==
X-Received: by 2002:a05:6a21:4d17:b0:334:a9f2:558c with SMTP id adf61e73a8af0-334a9f255cemr3877419637.5.1760705332044;
        Fri, 17 Oct 2025 05:48:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b06076bsm6390184b3a.4.2025.10.17.05.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 05:48:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 17 Oct 2025 05:48:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, khalid@kernel.org,
	david.hunter.linux@gmail.com, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/3] docs/hwmon: Fix broken maxim-ic.com links to
 analog.com
Message-ID: <826742f1-d1b3-49cf-a1d2-5a64d1e58d16@roeck-us.net>
References: <20251017105740.17646-1-spyjetfayed@gmail.com>
 <20251017105740.17646-2-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017105740.17646-2-spyjetfayed@gmail.com>

On Fri, Oct 17, 2025 at 04:27:16PM +0530, Ankan Biswas wrote:
> In 2021, Maxim Integrated was acquired by Analog Devices.
> maxim-ic.com & maximintegrated.com links redirect to analog.com.
> 
> Broken redirects fixed to their proper analog.com links.
> Fixes warnings in 'make linkcheckdocs'.
> 
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
> ---
>  Documentation/hwmon/jc42.rst     |  6 +++---
>  Documentation/hwmon/max16064.rst |  2 +-
>  Documentation/hwmon/max16065.rst | 16 ++++++++--------
>  Documentation/hwmon/max1619.rst  |  4 ++--
>  Documentation/hwmon/max31790.rst |  4 +++-
>  Documentation/hwmon/max6650.rst  |  8 ++++++--
>  Documentation/hwmon/max8688.rst  |  4 +++-
>  7 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/hwmon/jc42.rst b/Documentation/hwmon/jc42.rst
> index 19d10512f6c0..df47a5d265cc 100644
> --- a/Documentation/hwmon/jc42.rst
> +++ b/Documentation/hwmon/jc42.rst
> @@ -5,7 +5,7 @@ Supported chips:
>  
>    * Analog Devices ADT7408
>  
> -    Datasheets:
> +    Datasheet: Publicly available at the Analog Devices website

Please refrain from making such unnecessary changes.

Guenter

