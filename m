Return-Path: <linux-kernel+bounces-871027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 859A1C0C43E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39F9634A7C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F032E7645;
	Mon, 27 Oct 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYafJsDS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE11946DA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552946; cv=none; b=Vm39yZWhWKiP4fhW7scKWM/7RPuYKW+d1ILAKI/I/r9A7tPwObwtLNU662eb2XbbdbuuHzV/pndIgvDz8z9MiX7M9nU7QpGW5iouxPzMVB/Eo3BcbWoSKGFmw0reINMo7itYQn9io0kAf/3yupOvkbPj8FbwCdF0kD6ObFCKnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552946; c=relaxed/simple;
	bh=WwKDAtuQ20D01jVdtRfvMGKLaalNFcjLEA1dkVK4nu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Easrzb0E5SNiKVDH64hErVxpTcNO/9yMMjgHqpNFVGEuwEPo5DUti48YCIJrt+/KKUfaRhKcBMgMg4lkWh7KE1fylQeFZdjte6hhYW0Gu71b0TJM9a84aeyO+xh8ssD6y2sRPI1M+B36OgwugaRxadaDKjnpZyoWA6eTAY4cfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYafJsDS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47710acf715so3902965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761552942; x=1762157742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VCBeTLhApGGiqkKyRfbUgLkYILC1Vq+3fS3KeJIjhg=;
        b=wYafJsDSV92CJvQavoZNvekebvfzD9WTLdm2D7FuRY3r6li+BWhqpWFUvKWO4aVCCt
         3/1zfmRM86NWta6cMcxa+9R0+DUNPdmhTYSnFZksSmfYyUVbWUjK61dORA2Y5HlhWCa7
         je/gtyM2BdcfffIsi7pIsb6pYwjpI2Pi8OBfW8PJA4XUCErqxome+PR8xPLi/NSbQkVm
         vl9zizyAmBT0J1PrY2+4j1QE4XYlMehsvp2V+x0eVYU8m2AuwYY1JKwTKzjXLBZ+YcO8
         d+WIV2wQM8M6hG9ZgGDE/j8vHDsX1DDFK90jSzYymsKZ9oUPqM0gerpOtYUOkbE/fay4
         HDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552942; x=1762157742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VCBeTLhApGGiqkKyRfbUgLkYILC1Vq+3fS3KeJIjhg=;
        b=fE358/cTqnfq+X3I/e9Li/VqZOZYPMO46pI6kQo60amwamwP9gBOyhG/sXcoTMG1d9
         l5VbF1HT/UGU6cPE0eq4SZzhqTuPatWoBo7qnaEzqvaDRGjblGcgJpBobAYEvOcLa29I
         1zY+53ivVRmy7TZl8ynrqQM9ziDBcPFeEPBe3fmnsH3yTm26p8vohGxoJgSH4q/7Azi/
         VsrK/+JpGXlr+L8fcMMtYH3jlaFizkgMblr1qIJOzoMzZ5xmxbXx83Inq2m8jfIoFYkh
         frJKGjln6RNYhHsshILWQL+OOxXD4yllLTNirso6mvGFBDCndqgMEQ5lsIgvTrDbbfd3
         M+NA==
X-Forwarded-Encrypted: i=1; AJvYcCUSvUlkyf74hw1c+jGNQYO3aTW79T7mjpCI53yuHP58KfYdAR3/Tl6Ijho/JhDq9Od7P/hFdxbnwQnYVVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKZ4OXnNv0OOVJZCKeYKBOfIqWgmTRKof2UE15DC7wvzBNJOx
	sGO2CHpDu7wSDn1APPm3CmRX6+12jbAHHjOmmlgzQuaWZ1AKjBofEgpUxrlLqqGTv1U=
X-Gm-Gg: ASbGncu1YnAoLWZgcct0qpWE1agpXvFxRv1MZXd0a8+rS29EZgdsgVTqSqmm4jA+HRa
	Pcai19LgFjj++RyOV8de9z9uHssxtLA/IfSM9nH4hbuj05TBUcSV7kkhkz1hg7SiVoackdEAk2q
	PNOOXblBCGCpczCKwBk11x1Z5eoH9ZYhYG5fXIIt0IVOh7xnyQtqsfIfeK2MC/fhZ85xc0i/bQV
	jdAc3f2hkx6y0ArmsM2oP8JTr/gTj+D1CWziBnCBCAaFdJBWDPqNgpD/iILqVuwN3kOchuPjpm8
	LMGQZL73k1ORWXFFCKkkKmQ14e3bcTXCUs9Df9zqla4cMcpaMTEOApjp2njDBRD1M/FLJ81Qk82
	kAgdPYFyFAE7jDuS5fU5HtYfeMdDAcce/QckE4ik0UZ0JjQKb+JT5omRJczXYIjvHgwVAbyMYjE
	kpUCOw4DEx5Cecb2/7
X-Google-Smtp-Source: AGHT+IGIWZ+lmA7GDak4870XTiv3Yj8BU4Bmg1GQHYPOkEGe2jc+lTeJlZIP+IYjxTa6CteNWBl2Dw==
X-Received: by 2002:a05:600c:548a:b0:471:ff3:7514 with SMTP id 5b1f17b1804b1-47117877736mr281675505e9.12.1761552942082;
        Mon, 27 Oct 2025 01:15:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475dd4a36easm122063665e9.10.2025.10.27.01.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:15:41 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:15:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Cc: sudip.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode0 an array of const
 pointers
Message-ID: <aP8qKZkEA0FUkaYC@stanley.mountain>
References: <20251026233432.1707-1-cristiandelgobbo87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026233432.1707-1-cristiandelgobbo87@gmail.com>

On Mon, Oct 27, 2025 at 12:34:32AM +0100, Cristian Del Gobbo wrote:
> Change g_fbmode0 from 'static const char *' to 'static const char * const'
> so that both the array and its elements are const. This addresses a
> checkpatch warning and matches intended usage.
> 
> No functional change intended.
> 
> Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 3659af7e519d..ceb89ee99ce0 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};

This breaks the build.  Please, at least try compiling your patches.

regards,
dan carpenter



