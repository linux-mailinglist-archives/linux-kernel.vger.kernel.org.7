Return-Path: <linux-kernel+bounces-755383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC13B1A5B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61A03AB77F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE520A5F3;
	Mon,  4 Aug 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ne8IgZ+1"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583F1FDD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320773; cv=none; b=N+Slc9n+2N5BqH5s9EJv1umM5GL4tjgkyP4YnsFYLOueIP/rfJRzh6CGE4LQXQ2VbcHHuQyHFBVQta+jGweBJVPZ6v/n3xn+1ONX31jpHjrlKb/cFRfX3DQO51Jm2Fi19yRKlnyCeCgKxU31pJ1BV/XnbG//PfLv7KAkHinEEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320773; c=relaxed/simple;
	bh=2ctkyVkCddw7J9ojtDdkwwbhNHUgXi3U5sJoES+5Eg8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fjFBCZNMiE9C80Yl0p1xmvVUTnRAOc1XpNxRuXF71eGREcKKUS7XEGB84m7A1KTF0/4yu444C7qTQmU8TSFHovS70sbLpZudE1omdnW6N1AVleF9dmK+/CkioZ2woDUegXO2UrpK1IEr/7rYQQ5gwC/mqysqKToQ5lxm4VKhicU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ne8IgZ+1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so2966519f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754320770; x=1754925570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtfsrmeYAGdv6VNJegK9X7GXsxap8vbNDXlKO4YuuF0=;
        b=ne8IgZ+1JpoMvARB6B4crhNMp6bVf3vUifBFCe28Kkng7XgecOK/qb1kafIwqFWuvz
         I811xvwEy6L3vFR+SgNThrzwunK/TyMKiHzNtl+9IsJIxwlkD5b9e9LEl6j3vm89Brds
         55xJajwuEquakMAVe5xdJzqo9TBiQD8wFWsgMc+yVqD76ReaaTT2j4YlfvgMotlO8QvH
         vSzT+Tm1xR2lL09XSJOS0gg0lqk/0Hyp+tbMLg1QjHBmiYH4d3Z8KsKaI9e1BNxyllYC
         vk3/h0TmDm1JXrGwy4bENcsBmPnlVC5XQ7UNpYREzoqUKEcL1Kw2z/hzoBF6MjOp6vf2
         9A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754320770; x=1754925570;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EtfsrmeYAGdv6VNJegK9X7GXsxap8vbNDXlKO4YuuF0=;
        b=JvPDTmbIqyOSaHBsrwvJsPEkpdtS6dKJ9J7jqyntOxT8doXkPRKPdswRzwlNJddGLN
         7khrvRWn9mm88cUaN6ixcahQHsDBYTZeXrQl4zqcT5+rDkIj7mw7NKu2x653jSN0knaH
         PXXelVkAH+686Q71deGAkECpkZp8Nbw1hsoSE/uP1eNhj6BQyQ/87leX2+3wxlHtggAB
         xnQGKAJqSkScIkRY71y5az3khQop8xLErBqF2A7cHlSCd+l5JQNNK+KaoQ9Pgs2bVS10
         k5JszlMssUMWflS32faFAMxxEFsM34bGw1jb2iuyJL6tZdy9OOnxnFeP2VR/N1ZFHvrl
         v9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOyMOfPtx3t1vxg9++UDPU3C1mrvlzC9TKytgJnRiYF/e7W6zopc0BPEVmBWkifRbqWcfYEwxIwQdYung=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9tKPGr6rwshc7jRvNfiSoXdJYb7FSgCOIkEyKctI0JYvWfqE
	SfAt5BHB8Ehtj05zgpot5wUgdzki0kfBq3RGylXV2sGvhznxl0Rz0M+6pE4zesFnfss=
X-Gm-Gg: ASbGncu7OzO0hCh0qNjhF/MT+/DSePMM5R+Gq2SVkyzkipB6ay6A5nbH6Mtnwe8Yq80
	rOLaSDt58xdQZOZBl8/nwxMWK/ZQKsXWJqWaYhrQEQnqIHowPE5zdM4he1TKzw0CdMw1R+0cp13
	RutAc0bcJYfX0I6GW4bcnjRs5nwkgR6+YAACauN6LCiwLETXesUx2ZbC+RPVFsA8rQ3au6nQWqX
	uZmnrMUXoa0507w2R5v1LTWR5yy+6umklStabDJyXRyUgWhzGbhbTuLOvCn8B/3aLo0yJgixEOF
	YBSG1v4Mx6Oh2n5x7rBnKQAlZhAfVLZdF6A30x6IMnDxFDoveFwAtufPm/spZ/VEEJIi/ZERsoU
	impH7iN0G/tM+VwFD+70PANXpT2GYDdM9I0YVr1wcMoiIb7vitIdcDNsV2Nq+n2Y1R3ORSu/mnc
	M=
X-Google-Smtp-Source: AGHT+IFVF1ODkUB1OdYXOWOHu0AspSQEel4BFpbUYVZ+7jd2xVYD2zN7DNDKT6oJnKJ7NlR9U11KQA==
X-Received: by 2002:a05:6000:2882:b0:3b7:73b5:e96d with SMTP id ffacd0b85a97d-3b8d9470335mr6765893f8f.15.1754320769927;
        Mon, 04 Aug 2025 08:19:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3030:f63e:fedd:700f? ([2a01:e0a:3d9:2080:3030:f63e:fedd:700f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm15609805f8f.55.2025.08.04.08.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 08:19:29 -0700 (PDT)
Message-ID: <ca6aa2e8-d15e-4d7a-a440-5ab814699390@linaro.org>
Date: Mon, 4 Aug 2025 17:19:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm: panel: orisetech: improve error handling during
 probe
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, quic_jesszhan@quicinc.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, asrivats@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
References: <aIJagJ/RnhSCtb2t@bhairav-test.ee.iitb.ac.in>
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
In-Reply-To: <aIJagJ/RnhSCtb2t@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 18:08, Akhilesh Patil wrote:
> Use dev_err_probe() helper as directed by core driver model to handle
> driver probe error. Use standard helper defined at drivers/base/core.c
> to maintain code consistency.
> 
> Inspired by,
> commit a787e5400a1ce ("driver core: add device probe log helper")
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
>   drivers/gpu/drm/panel/panel-orisetech-ota5601a.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c b/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
> index fc87f61d4400..e971d1536654 100644
> --- a/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
> +++ b/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
> @@ -277,11 +277,8 @@ static int ota5601a_probe(struct spi_device *spi)
>   		       DRM_MODE_CONNECTOR_DPI);
>   
>   	err = drm_panel_of_backlight(&panel->drm_panel);
> -	if (err) {
> -		if (err != -EPROBE_DEFER)
> -			dev_err(dev, "Failed to get backlight handle\n");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to get backlight handle\n");
>   
>   	drm_panel_add(&panel->drm_panel);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

