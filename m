Return-Path: <linux-kernel+bounces-874013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF5EC15517
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B533502059
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF831815D;
	Tue, 28 Oct 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLF1iaPI"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020043328EA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663568; cv=none; b=lcWgu/aj3XR0mjA6+t3gzq0T8/KdtzDMet7IudM4P+cEWZiXwlOqPnMPBHl8ig4ofrNOFAFPsIWC+EsmSsqaHX73SkpNPyaXn37+eUxBWXnq8Uk867giKx5nlWp3SpkfxzKBP9Apb6ne0SiUZ9pr6wkAy1Vc5YXROHn/QDVAD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663568; c=relaxed/simple;
	bh=BiMRdmRoIl7l8nrxxTw2GsV6D3ZsuisFdGa3PGy0pkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNieSQEbs3ClwtmT/CZRvMy/DT/otQCUD7JPDY1QUCNE0KVFw4a9qBzBT84h+/tiM7t7mLzipmrcC2DRU4n4lYxeZKxihI8if/jbFizQFkpYHJ0RCpFZ6fap5b1DLloJDRvbyGEva7eX8ZOo+d2hGppMRvKmbsgx955j3rgjA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SLF1iaPI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4711b95226dso76623025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761663564; x=1762268364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tEghCQNR+Ghq6UpTXWvvavmRHa5Qip/flVo1Z/DEyg=;
        b=SLF1iaPIPjZxAi6ztRLlgMKYM8X9eP3e/CHT4vlsGVX78dPbNtA2a9RkLoW6/LfBYw
         cfcclfH9fjVkbpEvgds/w7/wUYheE5o1crHXg2bE0W0LFvaz39QFv573EJkProej28m8
         wlOZ8t8he+oqMab0/AJ/Y3aNQZphs6CBMbf5dkNM0wYJV7rIAu2+mX46SPUuuqCV7aga
         G2fu1qaVvsC3+iMa1czDKOrTKjYCdhZS38aAUjefAroKkYxoWebo2CxnedK3vdG/cqMY
         A5HOtfwu80d1Z03Ucz4XI/YEdJw6z6HWcUVKHEUiwHZMElIi/+jP4M8IxC5HtQ3j7NxN
         rtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663564; x=1762268364;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/tEghCQNR+Ghq6UpTXWvvavmRHa5Qip/flVo1Z/DEyg=;
        b=CVyy1Qe4xXPhbUmQP7h5i9c62I924bZ8dMN7kHY6E+8OkExwF7nB7mA5QH08WAfjWh
         Tw12w2W5w5bE3tBm7mvI5OGxDmkEAXUrCphjx7pnLp9HC9EXLXS2uccoupKlMz4Uav14
         kAEWFbKL+3E7R7DdvhkHbmiabviM8GPJSoSI7gJO2QPVJXzCI6cIxe+XIrBcwFEr7c6Z
         LQlS7Y1WivWiZmf6bUJ2gbrLO0TGqXMvXQWK4+4M1LYFQuMljgd/rNlZnwgvmTjaKDuu
         YheLmcCLw8RvqFehs/nL29gjvGP0D6Bxn1vGNtqo625UlyHlv1L5JtUMwHrKTj3QlL2f
         p9Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUXW1KTnkcfYRVIiBSC5voG4U2JqQKTeTq0j5PF/fhP2t/KK7//tcwrG0c5J/44fmnZCk0Q2lGsrcjHwjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIi7GyCfqPaevgG5nuGIjRuCFLsOBMpXGhnJPIkPYK7svsuLeE
	yau/CuHboRBmCVhxNzXk39wC6Hfg7N9ejspt43SppbTpjfDHAkAmnYP6JKQ3cGKZcRI=
X-Gm-Gg: ASbGnctX6lmjB8ivZ0DKvFiGFv265LufhqLQzCOpWsnQUMHF3EU7dctB5ESejO4z4Q7
	r60oAtQ/UGUP+FGHp5u9HaeozWMk1qfSTCIHidI5Zs1RHrXpNDKwKQ75+Ru/oiv8NLD5Rkd06uQ
	umL1F9hGZRrV3EtUplW70xY38ACl0jGlu2xjJUH4U9UW0reZsxz6HdQpyXwQeBizJ7lC6g5gq5V
	nr9NI4ruzGoHZL789c/UT8HhakU9Z/wjK7aOeK6yfs5VHrrbJLV+WkC6FMh+b/MjMbssiF8GzFl
	LkxBy+xPFVnSCnaOzUAIOAvsfSRyumIz5mYhDK14eIG0H+HIu4przOsey0TnQN8xXwnFtl4OO+v
	HNXQuD+Xyy8np7Y7FF4jVdfVcHOvUQU518HXq2+UDDhgUpnTPTGHiYigqfBuMmRTTr42j34hCzZ
	FbEkZjJA76sOQE0d155mTyV98MY9nIXS7BJCV8Nb2FctfTJRnAyA==
X-Google-Smtp-Source: AGHT+IGOmwoqGCwG34+95+/SGGOROMTRrOMrQVKEuSflYTb4BVwyTWmtHHtiKHl1c6fvvdxlmco53g==
X-Received: by 2002:a05:600d:4345:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4771ae1fcd9mr10527035e9.20.1761663564212;
        Tue, 28 Oct 2025 07:59:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5? ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718fe63e0sm21630235e9.3.2025.10.28.07.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:59:23 -0700 (PDT)
Message-ID: <da061f7b-bbe8-4810-97b2-3122563592df@linaro.org>
Date: Tue, 28 Oct 2025 15:59:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: typec: ucsi: Skip setting orientation for UCSI
 version 2.0 and above
To: Abel Vesa <abel.vesa@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028-ucsi-glink-skip-orientation-for-ucsi-v2-v1-1-93e936ac59b4@linaro.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20251028-ucsi-glink-skip-orientation-for-ucsi-v2-v1-1-93e936ac59b4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 15:39, Abel Vesa wrote:
> In case of UCSI version 2.0 and above, if the orientation is set from
> glink as well, it will trigger the consumers along the graph (PHYs,
> repeaters and so on) to reconfigure a second time. This might break
> the consumer drivers which aren't currently implemented to drop the
> second request of setting the same orientation.
> 
> So lets leave the orientation setting to the UCSI generic implementation
> for all platform that implement UCSI spec 2.0 and above.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/usb/typec/ucsi/ucsi_glink.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 11b3e24e34e2b4c21df20b6bec69619a0292c7bb..e68fd3fd0f54bfa3c5998519b17cf187bb363ec8 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -209,6 +209,10 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
>   	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
>   	int orientation;
>   
> +	/* For UCSI 2.0 and above, orientation is part of UCSI payload */
> +	if (ucsi->ucsi->version >= UCSI_VERSION_2_0)
> +		return;
> +
>   	if (!UCSI_CONSTAT(con, CONNECTED)) {
>   		typec_set_orientation(con->port, TYPEC_ORIENTATION_NONE);
>   		return;
> 
> ---
> base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
> change-id: 20251028-ucsi-glink-skip-orientation-for-ucsi-v2-6d52c6644d46
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

