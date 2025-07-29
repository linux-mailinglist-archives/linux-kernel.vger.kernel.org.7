Return-Path: <linux-kernel+bounces-749175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44308B14AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8A37A5DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF4226541;
	Tue, 29 Jul 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqeaXP3A"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE690213E66
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780635; cv=none; b=Nwk2JGtvArBYJ932E5fN9cbT2Bh+1vvhMXBTp+XHWgXUFFC3uhUFeDfjXn5Dodis1g5yyvspCWr6+as7JJUybKmo/01K+B9SWXEnyMO2FVn8Wtj184RqlsX0twc63/lvn03C5ZnJPbZNvm7oDhP12U5AG/8c8XFwYDAlV3Q+X1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780635; c=relaxed/simple;
	bh=M6rFzmVVrJYTEDtPq6tO1uhk8mTDCIssB7aBkjUROs0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N0t5ThqmiLqhYGmManBFJCLcQo+5rNDDhYd2ffS+2S6WGSbaQ5kkVf3B5wi8NzlkogMzL0gFGifpEYK4rGHvIDtVNc0JnEyjmjnKO57Mfo1KnkJVlBHFAEG9PYQMRR4WVjYvllGnrTx2F7X/0kttXJ7APiWfkppusDkr6HqRuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqeaXP3A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso55846095e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753780632; x=1754385432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d60OURvTslskqUGqUM8qPLgQLo0x++CgR9duN5Eh1VM=;
        b=rqeaXP3ABFWn/bwcWEEBiDosBLr4iuqFrJiGX3cLVjcKJNQYP4PS6Z15qwMXot4HHm
         qOZQHRWpqZPgZj5pF7GjxJx6c0RBq968n38gmwcv2oQtvNIKCz1ijNja/diQVZzDMOZO
         qybBQOe92NdrjgmhlB25mHfiRHzWM404C5kgXMq4YbD9L4k39QXGqfrG0WUFL0HBkaoO
         iX2ieYreVW2/Bv76D4H1jo0WFxYwa+VTvZHg3w0eAvVuI03E8rtqVe67vv/h6auVigKZ
         SHHgWDU3+Wh4aYbSc9xu1thDaGb9gbgTOYtf1+EbnGmegXS8LzmSxycNc97y8mppliyu
         uSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780632; x=1754385432;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d60OURvTslskqUGqUM8qPLgQLo0x++CgR9duN5Eh1VM=;
        b=Nh5ld270yGFVEE5a9ZnILUsj455ZIawIiymPuqNDybRFVAGV0A9DQbx2PFOfPKSUxZ
         wdFaQoMFsVEDakbTwcBbHTcpS+DXjfYiLgQmmBEYGpInmVtteySFmF2QglZbLveBOmg7
         sMrMhDS24/ytN8B37BOi8DyqCB1lHfyj3fNxn0vrf6psIBOGPqKAFWmB4pYh7qE94Bgk
         vbHpJ1KHtD1pAPjRCDzDyc0v/A5BxDA1YXH/RSuYnz6di5ZALNKqc6UuDDVCGxtu+UnE
         9dGyM5dunf/ucRZbbUbFpgqAgPCi/PcDVY9Lugi7CHsrfEEDt3/gRo++HRbExVlhcdMb
         WCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyxGuTsq8Z+W9bS1JzgY5qzR5op7bbVUUWo/Tx9pQptm/KHJqfPxyALR7x+dXh/h2nxzPQhHai11woNvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFpKMCugy1D0JTrSd/XUpYvlIiKkC8geRn8eZdV0mPVVA7jBG
	myJHZGKnytMixo0kaSi9ROIbr+0LIRac29s3YNyRYOTKsdaYH0tQIZYRfZfJ1xBUPZ0=
X-Gm-Gg: ASbGncsO4gHA6RhOSmi4bC8gCIDWjEZtkZLLd/bAXGFFacjwF+OYRAjvB/kaBa1LDOJ
	EvDoO15cb1dSETk8TRr/mc2uWD28K+WztECwrfdJ5h6hRsR79jiydoXLmcQEUVMF/W61nafZ5Kx
	YGLzWwS/hEjCa5dyFjFabX8zp32hft+eDWiMh06YiTfqIPpjPwZ8MAlv4K7OT0kTELMhm4rtRSg
	dx6I6tM3kqh0AMYanr7gaJRwhwBsjhnhLlGN8UyiTHA/Bmd/h0LG8CsYaTXqhkAG3CcPCsNtjQ6
	jQ6Qph/75UGl8iBysM8mksdL9BM3/Ckx64Gs+tuS0+YY/fS5jTyUPHPk/IfcJImIcjBsZ8X+oSx
	ZlBz1oySZ2kDoIzDkMqFuYGNNiTj1QCA1yhp9/CzqYg8BADjiGiQ6zJWzNNhwbpX7ep+mc9bX
X-Google-Smtp-Source: AGHT+IHy8IlF5EsVFcN+ZeaLeXgccCzDTIMzFkralNzOHDs6W5E1jDZ+/O6pm9Q3S5ZwVCt98dtyVw==
X-Received: by 2002:a05:600c:1c07:b0:456:2397:817 with SMTP id 5b1f17b1804b1-4587c530cc4mr82620185e9.13.1753780632006;
        Tue, 29 Jul 2025 02:17:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3ae8:20b:c783:9328? ([2a01:e0a:3d9:2080:3ae8:20b:c783:9328])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705376d2sm187799235e9.3.2025.07.29.02.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 02:17:11 -0700 (PDT)
Message-ID: <8cbbf5f8-84b4-43af-89b9-0ee4bc0a2591@linaro.org>
Date: Tue, 29 Jul 2025 11:17:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/3] drm/panel: novatek-nt35560: Fix invalid return
 value
To: Brigham Campbell <me@brighamcampbell.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org,
 jessica.zhang@oss.qualcomm.com, sam@ravnborg.org
Cc: dianders@chromium.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250729054435.1209156-1-me@brighamcampbell.com>
 <20250729054435.1209156-2-me@brighamcampbell.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250729054435.1209156-2-me@brighamcampbell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2025 07:44, Brigham Campbell wrote:
> Fix bug in nt35560_set_brightness() which causes the function to
> erroneously report an error. mipi_dsi_dcs_write() returns either a
> negative value when an error occurred or a positive number of bytes
> written when no error occurred. The buggy code reports an error under
> either condition.
> 
> Fixes: 7835ed6a9e86 ("drm/panel-sony-acx424akp: Modernize backlight handling")
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt35560.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35560.c b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
> index 98f0782c8411..17898a29efe8 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35560.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
> @@ -161,7 +161,7 @@ static int nt35560_set_brightness(struct backlight_device *bl)
>   		par = 0x00;
>   		ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
>   					 &par, 1);
> -		if (ret) {
> +		if (ret < 0) {
>   			dev_err(nt->dev, "failed to disable display backlight (%d)\n", ret);
>   			return ret;
>   		}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

