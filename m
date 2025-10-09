Return-Path: <linux-kernel+bounces-847195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD8BCA384
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A0B3E6A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214ED225397;
	Thu,  9 Oct 2025 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eda23KLt"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB7224B12
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028175; cv=none; b=H5m4XO4IfOJLrCpIdhLLCDf4QExpvMO+SmAiIKqMiDm0Rlu8x4LHgINEqgovU7xwNuCGEkyT0Fxa9gNiGHLf3GOTq4n0p2goqOFYoGqIzLOLxvwZIm2QhZX6NoymjfFNGquFhoUpxNp6n9CJ4m5UxdQmnFYfIIZslqw1aEBfIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028175; c=relaxed/simple;
	bh=Eqo3HvooxmtLu1uxDnc9goIHIKP18xkGp2XZ3XQ/klw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DqzApaJoWvlMEBUNUV+M9L/0PUyCsyS/IgqdYdiGlVTThzb03R8BFrFqO7nxcUZcGkd6wxQmMeqWSnNqm/8AUu9DrDvfaYPKz9qYIx0d1h2VnMX/pD/E9LKWDydfp12nojaI1YtMbmLBChcncFN8hSvVJbayF0Km0dquXuseOfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eda23KLt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so12053385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760028172; x=1760632972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPMST/OYZXxOylWa/2TauSP8MZB4Vq6Zxq+da0/witg=;
        b=Eda23KLtR5IwBUCn5xo+Nt88qPxcG3z29qBcQLDOJF6fXmYFRlKK+5CmHe/uOIg/6j
         q271vOKb1GBDhyj+8yA2xdTAAXZ9HLCyj/wea3PE/zufgUPrXWQmJClRMEBMahfgQ3Zt
         Ysp5+SMUxDzAGw08vGqolWCigo7oBwXehzbV2/XEum+yV1nUHn1Yr9LihlMJUbLb1xX5
         6fjqECbwujCxnObXItI2FQea3TBWCqpfyeLBr0BORdDFffrfStg4bWB11n3KQmyb5z/g
         Y5RtRTcwd/TgZEzDSlSif1HSLxKEbyqHzC9Zr0eiyEfwgmfv4wjmYHmx9zcxqDXWvohA
         txOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028172; x=1760632972;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NPMST/OYZXxOylWa/2TauSP8MZB4Vq6Zxq+da0/witg=;
        b=UvwJeWeSiqRJf04vzgL0nBZn2qyhoDZrBbK2EH62tGlgeJb/j60PEZGI4rWdfKpNB9
         K2jFVhiQPUHCIuT7h/Du9Jus7KLt6APmQYxPjp09uF801weKqvPlH0+Yp4QT3DniTHRQ
         nGVSkfW5yXm9o7LwT+vb3oM6ZNPEpC+03Nxy6Mq6Y0IqvgFtTxygCvVCjVAhJJvFvzic
         u+WU6kvvL/swsu14TDJhP8qj1kYWN1vCqdvDjXvLe79bq1pIvO74dmw7v38ZhlcsUulv
         ncsfinFUxmdSYm7StWmbhV5fIzPnc2V7LOy1kVpYnTXgIHtTwQavrYE1OL42anZgJMYH
         xK5g==
X-Forwarded-Encrypted: i=1; AJvYcCWjqimlu5CoHFy6At5DxEAJtNLEps8nh+Rqjc+Yv+cm+YIdU5+WP9LO613U1GNga+wN8/dp2m1PhTt+0dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwYyxQVS4jwF42mhkKuZYOuQiP7q0eKg8VBULP0Is8bEH4kKh
	RqAe71CUICfSzYw2+SVLx9coGUqzCP2QbF+hC4+tx5/lbKYrUTWxgSZV3Cbf44r8igI=
X-Gm-Gg: ASbGnctCKQXTT/ZmDR7U920Jd1wq8UACEkL/dDkg68TCRXiKOSb3aTz4ust0Ipc7B65
	5wcY4z27AHNvpZmo8RSF1D2W15WQ5cxK1emyOiWi/l0gB16cSd2VrkObWwNgnsrTP88SU+LCwZ+
	r86OdzpGYkz8aVnWu8SsdF6RCqhwrqmcdUUgvWDlN6GFIXnbVhKevxXFgNkleJ/CKOczNLgAF4k
	cQgXE3wpRyureTX9qeyp3TjzpY3n51ZSmKJdIUGu3LKdUrc9qXpk2rqx4ZLhXL7NLqhL0X045N4
	XLr5SDuowqHrLbxvPkaXmo7Vv7eQ/KiTkkyh6sOugf1qTDyqnolgEMpB15Ovt68fujZ8BThKqZk
	D9bPD14Jot3gDuusDidNYMjsdckqMdqO2vSO5spI0hwP28bl4j+p/2bGwJwqnnrjlxxagjpscnR
	Q135+NJ1Re7vaFm2Mc1wwnxgTHSeU=
X-Google-Smtp-Source: AGHT+IF5zvnDRbVTnzuyo7QCvds7DrqcKUP8pYldpNd7ZP9dP9q6luOXliT/fbdOtrdM86gZ/xBt1Q==
X-Received: by 2002:a05:600c:1e28:b0:46e:394b:4991 with SMTP id 5b1f17b1804b1-46fa9aa0e3amr59814195e9.11.1760028171510;
        Thu, 09 Oct 2025 09:42:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee? ([2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489accbsm6885755e9.14.2025.10.09.09.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 09:42:51 -0700 (PDT)
Message-ID: <e10594dd-cfc2-4d5e-bc1f-35aca05be027@linaro.org>
Date: Thu, 9 Oct 2025 18:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251006-topic-x1e80100-hdmi-v5-0-c006311d59d7@linaro.org>
 <20251006-topic-x1e80100-hdmi-v5-2-c006311d59d7@linaro.org>
 <141e33fc-c963-4f58-a69c-e7068c9ec6e8@oss.qualcomm.com>
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
In-Reply-To: <141e33fc-c963-4f58-a69c-e7068c9ec6e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/25 11:31, Konrad Dybcio wrote:
> On 10/6/25 3:55 PM, Neil Armstrong wrote:
>> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
>> of a combo glue to route either lanes to the 4 shared physical lanes.
>>
>> The routing of the lanes can be:
>> - 2 DP + 2 USB3
>> - 4 DP
>> - 2 USB3
>>
>> Get the lanes mapping from DT and stop registering the USB-C
>> muxes in favor of a static mode and orientation detemined
>> by the lanes mapping.
>>
>> This allows supporting boards with direct connection of USB3 and
>> DisplayPort lanes to the QMP Combo PHY lanes, not using the
>> USB-C Altmode feature.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> [...]
> 
>> +static int qmp_combo_get_dt_lanes_mapping(struct device *dev, unsigned int endpoint,
>> +					  u32 *data_lanes, unsigned int max,
>> +					  unsigned int *count)
>> +{
>> +	struct device_node *ep;
>> +	int ret;
>> +
>> +	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, endpoint);
>> +	if (!ep)
>> +		return -EINVAL;
>> +
>> +	ret = of_property_count_u32_elems(ep, "data-lanes");
>> +	if (ret < 0)
>> +		goto err_node_put;
>> +
>> +	*count = ret;
>> +
>> +	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes,
>> +					 max_t(unsigned int, *count, max));
> 
> if (*count > max)
> 	return -EINVAL;

Yep

> 
>> +
>> +err_node_put:
>> +	of_node_put(ep);
> 
> __free(device_node)

why ? ep is not allocated, it goes up to:

static struct device_node *__of_get_next_child(const struct device_node *node,
						struct device_node *prev)
{
	struct device_node *next;

	if (!node)
		return NULL;

	next = prev ? prev->sibling : node->child;
	of_node_get(next);
	of_node_put(prev);
	return next;
}

> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int qmp_combo_get_dt_dp_orientation(struct device *dev,
>> +					     enum typec_orientation *orientation)
>> +{
>> +	unsigned int count;
>> +	u32 data_lanes[4];
>> +	int ret;
>> +
>> +	/* DP is described on the first endpoint of the first port */
>> +	ret = qmp_combo_get_dt_lanes_mapping(dev, 0, data_lanes, 4, &count);
>> +	if (ret < 0)
>> +		return ret == -EINVAL ? 0 : ret;
>> +
>> +	/* Search for a match and only update orientation if found */
>> +	qmp_combo_find_lanes_orientation(dp_data_lanes, ARRAY_SIZE(dp_data_lanes),
>> +					 data_lanes, count, orientation);
> 
> You can zero-initialize `count` and drop the custom error parsing above

Good idea


Thanks,
Neil

> 
> Konrad


