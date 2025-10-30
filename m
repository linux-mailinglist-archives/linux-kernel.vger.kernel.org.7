Return-Path: <linux-kernel+bounces-877757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22F2C1EF40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3E14056C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E530FF2B;
	Thu, 30 Oct 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPkWtlYA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BB2F60D8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812329; cv=none; b=ZXTlSZSNtUkeP/ld+5Mp92XqAGvC5byzfVkQG2GNKf797L2L4cX+UF80HfCwbKhlB3sFnFfnPVhtHh1zbzcb6+bD+gpWq83XhfoiFuvIYpA1iJNX9i+xeQ3tJiCgFMX+aKYHfnqsqo/OUtKT4gs4f/NdyB63WK1ibKY4KZX0NzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812329; c=relaxed/simple;
	bh=X0R79ZjVCKro83gLlwKEEtUwluqz24nVk/lrlzVEZY8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I4EiiiM3ecOFoFGzowQNqDgZep1+eKRi+WFvX1Kjt15L9eW1GMAoN91ljxwNy8UEvg12WFSKyRYX7mPfX7q//U4w6dxHPt2CqHjU0HenMVQuREfhAbZIsut+D6Jko9Isy8gzdr3+lG47G/mhpgW0DLqZ6hW8LSteXn6otNI3jbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bPkWtlYA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711810948aso5506495e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761812326; x=1762417126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n22jjnKTjPV+2WeoUAlwQeRGh9RPW9Sz0+Vh4tXt1qE=;
        b=bPkWtlYA9saSuaMtgIO85AqxFa5i3++CwX76NJiy1bkBWHJT0XjvKAaTW0RhwQgM2x
         VPU2WZ5odZUOkGa7bopTOk9EOIKttY2ZAdPOsCutYAr0QwJXqGxGDvQXVPJe3tyNUP3u
         OB7+q4I+/P7aC6lltWdGGViFPakXOul2lPuPfLnJvvCVZ7t/xBB3lNsfSPQ/iv1x+gK3
         MgcNxuwkJKnmOqtuW4AiW/UwrRDQbWQRHNBvrF0pbjdo8ydq0IuARNH2wip9gxHjQZq6
         kCetb7/FsLHuY39RUk8Ar52Do3WXQhpDuWvJ1wglL1umZ8fqrxV1zR3oI5vwwjv8D49M
         pk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812326; x=1762417126;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n22jjnKTjPV+2WeoUAlwQeRGh9RPW9Sz0+Vh4tXt1qE=;
        b=RWx2AvRnOnJYmfpSdcSSWa9PmxSdVp0umeacsoS6RbxeDP4fe3ls2QoeudJ+E+NxUH
         pMa0t5T7IpWKfzJFLA5/zDiyFaHKK30pu2OOdWI5fhz+3AUEnPloCu5dow9mYhhLYhMW
         0D376xJXqPkDJ1uS3GL/FOHMF/7kwC13aB4dAuxEN/qazDahL1zz28YwkVAEdIrUzPFL
         YZZy47c0oNMKtP2oG7W4rYs/0xorTj6yDXVHSavfh69dxQlqYQG+BhYvN2LYH3CzmjGY
         U44ow6csDspwwRoUhEhtJRMriZbXsNUefak0beVxZ/PooGe8q/Nk/gwywvVJSHO8KKnb
         MvrA==
X-Gm-Message-State: AOJu0Yzid+LW+pFdNd+H5A6MbBgmSMzRXJaAas4KL+I1Q002D5Y/byMm
	7U4e/QI5lPikVImxTmxrwTA6hjsWB5I2heQnVz03XPrsERqUywHDRVE6e67YZLnmDUs=
X-Gm-Gg: ASbGnctg4S63Sb9MiPf8agKKsn9FlF5Xq3jOE/dut++VgMWgkj7WeVyzV73nKyn0xbX
	ux0ZwZmqzWvmYOZOzwknj90ngABN9Qdw+8/ddqBct1g8SrTM70SBLZW0h3uDVE+CoiueL3U3OWQ
	gKt1WYvBXbw/HY8QkTPAkn4XARvVsZJvwDcar6wYgeOsoYz+cuSFjMtw0MbAy5Xhr6RtCKmHR/k
	L2MC2yn2UMEWJ/feT4rpbfDc2y6ESi3NJYhJdE266cPeIW8CLp7fYwktO2Gt9i8Hp588ulwAGAb
	KzefA/Y06CZTEUZW5dQX7ysFiDLNfXp0gc9p1pT4ha/mbt+TYHDaPEFKlb6XjedOZGamG8cllBo
	/F3Oh6I0ws6WiRa/7bg33BtPyIxElTdXPGYZ5Vfj4gAbrEAgeELxsa2AXHkTxElbpziYPPeOl8j
	4OFh08jGPjF4UvhfWIYYTF6Ox27H4E4C71lgiXCzyt8eZHLcNJPDSn
X-Google-Smtp-Source: AGHT+IEPEKlS1MXFKcHH4eUEEpj3CY6CH7IIM3l1El1nu+O9i5LhtMn2UPjpukubmdgPWNokkI299Q==
X-Received: by 2002:a05:600c:45c5:b0:46e:376c:b1f0 with SMTP id 5b1f17b1804b1-4771e316cf4mr54045975e9.7.1761812325510;
        Thu, 30 Oct 2025 01:18:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3e45:b3e1:4bfc:5477? ([2a01:e0a:cad:2140:3e45:b3e1:4bfc:5477])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db964sm30787325f8f.33.2025.10.30.01.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:18:45 -0700 (PDT)
Message-ID: <dc589c50-aa4c-4bbb-b481-b3a66fcba095@linaro.org>
Date: Thu, 30 Oct 2025 09:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] mailmap: Update Jessica Zhang's email address
To: Jessica Zhang <jesszhan0024@gmail.com>, lumag@kernel.org,
 robin.clark@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20251029-mailmap-fix-v1-1-8534ffa12ed3@gmail.com>
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
In-Reply-To: <20251029-mailmap-fix-v1-1-8534ffa12ed3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 07:31, Jessica Zhang wrote:
> Update mailmap to point to my current address
> 
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Jessica Zhang <jesszhan0024@gmail.com>
> ---
>   .mailmap | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index b77cd34cf852..1c57bd649f04 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -352,7 +352,9 @@ Jesper Dangaard Brouer <hawk@kernel.org> <hawk@comx.dk>
>   Jesper Dangaard Brouer <hawk@kernel.org> <jbrouer@redhat.com>
>   Jesper Dangaard Brouer <hawk@kernel.org> <jdb@comx.dk>
>   Jesper Dangaard Brouer <hawk@kernel.org> <netoptimizer@brouer.com>
> -Jessica Zhang <quic_jesszhan@quicinc.com> <jesszhan@codeaurora.org>
> +Jessica Zhang <jesszhan0024@gmail.com> <jesszhan@codeaurora.org>
> +Jessica Zhang <jesszhan0024@gmail.com> <quic_jesszhan@quicinc.com>
> +Jessica Zhang <jesszhan0024@gmail.com> <jessica.zhang@oss.qualcomm.com>
>   Jilai Wang <quic_jilaiw@quicinc.com> <jilaiw@codeaurora.org>
>   Jiri Kosina <jikos@kernel.org> <jikos@jikos.cz>
>   Jiri Kosina <jikos@kernel.org> <jkosina@suse.cz>
> 
> ---
> base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
> change-id: 20251028-mailmap-fix-50434c548816
> 
> Best regards,
> --
> Jessica Zhang <jesszhan0024@gmail.com>
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

