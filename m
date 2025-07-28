Return-Path: <linux-kernel+bounces-748303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CFAB13F41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEEB3A7EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A942727EE;
	Mon, 28 Jul 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="QzqD0FZ5"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF21F9F73
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718035; cv=none; b=ZPkEWdcX6ekYRN9vrnVhjxAR1k4b3oGxavujWZ2D3tpXOUZYsXGhlOL+ToWAN06bOiN5h357V0jqCLYt2j6u2A1LrqMjm5l8mkzdzfcHJ+0yjav9KZrVBqlcZXYgGLaVqE6IFw3cd8uCaSYbJ/YeukbgkClMpd+R4ews/EnaOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718035; c=relaxed/simple;
	bh=Xb91t9iYll1tfZ8jj+Fe8p5aXdKrZAALX5hkvW1fTeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sgwakr0jsKTmJUPmc7zdvnpHoqkRh64Odud4wZxGSwa6aJFsyC2UI3qRZHAvBBA0EZC7bTK4dOzsCwkhENinSWZPSO5/ssu5710MvtrJsfzIe7l6nGuZchNym+FDMym5HhFMFp2SM1lhxKcThTHdSljS88QMXgXBVggKcWobrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=QzqD0FZ5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e3cecf0b53so20436925ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1753718031; x=1754322831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vA75icUEqF0I65qQDsqS6NAJyE6+tfqsXQddj1T3hko=;
        b=QzqD0FZ5wI7lu2NkIvwIFmao1GeIhoz4wOYttjeBUAsUcda7XVBz6IY9FuMotXSTg0
         +dWZdLza1wPctsyj3wONWIxoxcOB4t/+kgcM/EyUbdAzl55urT49QT5ox4/WMcitwraM
         XIR5VqCNWiJMeN9Ur8xsgufuDFU8hLFRb2Q0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718031; x=1754322831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vA75icUEqF0I65qQDsqS6NAJyE6+tfqsXQddj1T3hko=;
        b=I7Y9jZwA0+s6dvhjVicmK96DieX7Gu1uQu0VKsjgKmF+94o4lGJ7dJg5gJ3pWBlYWe
         Oi5YieJwmOvp85veWgrLV4MqVtaMP+irQBYMlXkCG4/fjvjkcffDNQmAxDAA/SJXCtB+
         XVQh8kAYLIKwdnixyCXULGG5kXNDprPnBx9HzdSBb1DxHDCwQEo+IUQY/A8uFF0BBAU4
         eURq3DxAIDNk2bQtfFOGrMS+Syj9NJ8gbhDBpTSRT94Ts72IWkj26LG5gfKMlH+yePEl
         BX2X5b4YJbRFoj7fQVbHDcMjs2KeiTRaTfTPV1sI9zY8jYf3RUXLeUmV0ZvfDFkCYlM8
         1IcA==
X-Forwarded-Encrypted: i=1; AJvYcCW5EKnGvkRf9OSTgtMlblDM9Il/l/tejz0fnk076VLM7SJ5Dx6cD0dQ+mGqZWh4Cg4dhkz8lu1HRgAHLxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwuNREuSxFp8cFouueVuN3adSfjNsJtZQ4EznhIsbLYy/w8Tb
	XmhD1uVrzDTiTZEHBrjK4a0Fg86XT8utOjKPMnpXZ5mBAGtoaEUgTlgLdhbdgkc4WA==
X-Gm-Gg: ASbGncveyFkTvDl09pFyUgMzv4SLascNzQYgqxTM5cj9q7k/cZhkJtXieqpzy6zO3eG
	cBpP5QgHvkTWpD517H1uf1kLQolOIM3PMY9Ah+Nz3+h5WA5le9NBGcBvdAt59BcpIXkjibDGPZe
	cKOEeZm62Wsf40cnD4YrhZ4mq5xPe1HSfm2j1K+r38gksx7nXpGtY03T7TZOa6vLez4WWguDfi/
	7j0E19WrBUvZztcwSo9cNYDC89Dl1+V1Ovf5AtXGNo3OG5/9x4l6NLnorpX7VLZPsja61DrGgVa
	RgNS0sf5EeBteP3cc2IFzcdMr3K+lvIj6wAOF4YY0+LRwaRGPiVjoJpqkO04MKBtpiSznnjedWl
	Lmw/Wt+RW4MCqzOUFHuVA/JS8tZmbaEMUqixAH1CdWa2OI06uXiZa9tvM8OUnJ+xXfjZl
X-Google-Smtp-Source: AGHT+IHGlI/3Pe8bkFG3tVYCr16gw07/QecOHAd3MsLl8dDS47dIcL8tDHYDVZgzeq/TKMa3hlOSsw==
X-Received: by 2002:a05:6e02:3bc7:b0:3e2:9e61:433c with SMTP id e9e14a558f8ab-3e3c531061fmr180543925ab.15.1753718031332;
        Mon, 28 Jul 2025 08:53:51 -0700 (PDT)
Received: from [172.22.22.234] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-508c9341e79sm1953738173.61.2025.07.28.08.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 08:53:50 -0700 (PDT)
Message-ID: <e07f0407-84e1-4efa-868d-5853b7e9ab4e@ieee.org>
Date: Mon, 28 Jul 2025 10:53:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/25 3:35 AM, Luca Weiss wrote:
> Handle the case for v5.1 and v5.5 instead of returning "0.0".

This makes sense for IPA v5.5.

I have comments below, but I'll do this up front:

Reviewed-by: Alex Elder <elder@riscstar.com>

> Also reword the comment below since I don't see any evidence of such a
> check happening, and - since 5.5 has been missing - can happen.

You are correct.  Commit dfdd70e24e388 ("net: ipa: kill
ipa_version_supported()") removed the test that guaranteed
that the version would be good.  So your comment update
should have done then.

> Fixes: 3aac8ec1c028 ("net: ipa: add some new IPA versions")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/net/ipa/ipa_sysfs.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
> index a59bd215494c9b7cbdd1f000d9f23e100c18ee1e..a53e9e6f6cdf50103e94e496fd06b55636ba02f4 100644
> --- a/drivers/net/ipa/ipa_sysfs.c
> +++ b/drivers/net/ipa/ipa_sysfs.c
> @@ -37,8 +37,12 @@ static const char *ipa_version_string(struct ipa *ipa)
>   		return "4.11";
>   	case IPA_VERSION_5_0:
>   		return "5.0";
> +	case IPA_VERSION_5_1:
> +		return "5.1";

IPA v5.1 is not actually supported yet, and this won't be
used until it is.  Only those platforms with compatible
strings defined in the ipa_match array in "ipa_main.c" will
probe successfully.

That said...  I guess it's OK to define this at the same time
things are added to enum ipa_version.  There are still too
many little things like this that need to be updated when a
new version is supported.

Thanks for the patch.

					-Alex

> +	case IPA_VERSION_5_5:
> +		return "5.5";
>   	default:
> -		return "0.0";	/* Won't happen (checked at probe time) */
> +		return "0.0";	/* Should not happen */
>   	}
>   }
>   
> 
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250728-ipa-5-1-5-5-version_string-a557dc8bd91a
> 
> Best regards,


