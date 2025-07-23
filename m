Return-Path: <linux-kernel+bounces-742017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B64B0EBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0299B3BA7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5AD274B32;
	Wed, 23 Jul 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+rEbbDo"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98427702F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255919; cv=none; b=bCX1eINHPGmKhVXblq6TF1dPFOAjEOMS9B3CXFasqQmWWwq8nDy2RKR3k4B+0+M7xhBYLFhwAbuD7eichM1RDHA+Xa3l6Ko5fGzdE3MNQpGedHsNhIJEEj3RcYoWaIwdNrRf2Fy/ZLhjSrclYdQRAjwYEbIb0uwhN/eIi7kRd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255919; c=relaxed/simple;
	bh=aCVdLlPepbdE0li+hKmSqvbLYzrRG0cEPf/H2ErtKEs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tWpdbj9cpjiW/X8HcrbGpzytIwqCdKaQg8T7b+OqPm6px2lP+MFBLwYIQFEwxXxwEky5dliFyHpgBH2lHfnS4nv8UGcPMMgyM4W54wgHJYMWS88+Y1nI1TNY/s/jc8xhaltoy88gr5iRVKzra6Xkn7NMEpP4A0VAywPSuxN2Opw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h+rEbbDo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so4921243f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753255916; x=1753860716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsMQjx0LxGiew+0kejpLbcOVNd/QskKUIRO4t/3V5tc=;
        b=h+rEbbDo2rKFhsWcFUjfS+c4xY2y033Ovi/w8dnKs7eFxKPi1LVyu756lz5tweSGIv
         IqJz8Y6DTCoE88a7xOJgpChHql0ibR9FsKomO9+nj23XK2W3yJoabUlqTFDBfjPUY5w6
         yW8Rg67KBpovWQ7WJYnHpUykcqyU24sOp4LCrbirstqoN6dpq6vp2HeZHotfppWZ50BD
         ILf4OxOYsXelaNwBbrQX9Pavw/YPUmbFqDTNPYTTyqf1rmQAVc/sDY0m9jKbETfrJjg6
         PkvyPazgLNJQKjH53GSy5s8ukQNQpnBf7DEp2cpC/tq44Pqyi7bkrw4wxxMKb4KbR/8S
         VrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753255916; x=1753860716;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsMQjx0LxGiew+0kejpLbcOVNd/QskKUIRO4t/3V5tc=;
        b=TaQxdcVkfcoyKs3PsnZNr5YepfS9/gGhWxAQyPBMpyrSKaYiQp6Ku/RK98sCep0SZf
         bIZx2YVUfBOLte6dtFO7TGsSUHpDrswRHWDi6NKvoa5UY84cmObmrM7AXnvt364fhF6Y
         bpYtpSyh2HAQ6Xmrh/lZMN9fKW+fY91zZUGeBJ6UySCEOazfHs8QPRLGUgw6iydEtZuE
         kFiyT3SpslS/tppD+3E9GdiZ139v4a55fVJ6y5CWTM6LuOAYK4riCnKRiXFY8A6gfPXC
         zQTNRvTJfkvIfnUIUzH77/5drXck0DPib9We8h8SBwkDiG2zz/fZaz9JIZ2doH3Mmx2u
         2TPg==
X-Forwarded-Encrypted: i=1; AJvYcCX72tZTFhAoFxWBTEJGZXZOz6D/YBGYURyVNEUWgVP+FWuegWbzvTQA4EXbI2OxyYRBomLHPcBWiAYMuas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp2Q1x/YjZtfy7/8ZDSccnRAmMopyR7/d4WNiOReCU98FV2yfx
	mkQsdVVqg3OFvTRs4bgUtuPmyKeiaUuHd3o+RpElIZJQzqAszBkh18nKf48a6umwNfU=
X-Gm-Gg: ASbGncuH1Gzw3nM91vJxoYgkLqX3puAABSuTftjMuJACKraDGEjeDQicGgc528muu35
	5s9JtvZDhtpZVS5mV1gMflbUWH4piTxRDcjkN4TfmU4r4Mg5Gee+H1HHAqyGNusE2MW0h3mgsSB
	24qfCvK6h9qdUk/Tg66GXpAEV/7of3EG92VnctKpzdT94ljdDfyl/zqrifadRC2r60wpyR4u+Kf
	3w0zgSa+ds4z96hPEe5OdpY18vDqCDLTcvIKoYHgQ4zoPRTXJJlM4xnvx+M9YTZ9JLgrbkTdYe2
	+htNKXOvD6xzE+GR9C6VJLBLZqaKdq9nYkzwvGTKDDCZ7qVazEcmtXmnxw/2qthTwX7vHoBcDYU
	eLHwLaWEdst+EraecrmfwJDb1GJz3wjopfmZSkFnWU6DhllimT8W7cvkXJK/yGslfLJuXudCgl/
	E=
X-Google-Smtp-Source: AGHT+IEnTNf5B70Qm5PHVrXvXMMmuSQu9ZW3WQXoalvSypYkFRNdLXjfNz5NQe9X9fAdbT+v/+bFzQ==
X-Received: by 2002:a05:6000:26c6:b0:3b6:2f9:42b1 with SMTP id ffacd0b85a97d-3b768eedb05mr1434526f8f.13.1753255915643;
        Wed, 23 Jul 2025 00:31:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:8813:2f0d:f9e0:5294? ([2a01:e0a:3d9:2080:8813:2f0d:f9e0:5294])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bb96sm15602630f8f.30.2025.07.23.00.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 00:31:55 -0700 (PDT)
Message-ID: <c36f3ae4-8bd1-45fe-ae98-253b45b158a9@linaro.org>
Date: Wed, 23 Jul 2025 09:31:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 0/3] Add support for OLED panel used on Snapdragon
 Lenovo T14s Gen6
To: Johan Hovold <johan@kernel.org>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Rui Miguel Silva <rui.silva@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>, devicetree@vger.kernel.org
References: <20250402-wip-obbardc-qcom-t14s-oled-panel-v5-0-ff33f4d0020f@linaro.org>
 <aCw9pYehCdfXXeiR@hovoldconsulting.com>
 <aG-QyF12rGY55gcG@hovoldconsulting.com>
 <d431435b-4ac0-44aa-922d-0bde126ca563@linaro.org>
 <DBIMQO2CS0I3.17XLZPKPCVW2S@linaro.com>
 <e9c63414-8434-4e35-a159-66df1864f9f3@linaro.org>
 <aICO0CXxp4Vu331u@hovoldconsulting.com>
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
In-Reply-To: <aICO0CXxp4Vu331u@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2025 09:27, Johan Hovold wrote:
> On Wed, Jul 23, 2025 at 08:51:22AM +0200, Neil Armstrong wrote:
>> On 22/07/2025 15:48, Rui Miguel Silva wrote:
>>> On Tue Jul 22, 2025 at 2:01 PM WEST, Neil Armstrong wrote:
>>>> On 10/07/2025 12:07, Johan Hovold wrote:
> 
>>>>> Neil, do you have the OLED version now?
>>>>
>>>> I'm not sure, how do I determine that ? Is there something specific in the type number ?
>>>
>>> Yes, yours is the OLED version, the exact models stated above.
>>
>> Ack thx, I'll test and re-spin this patchset then.
> 
> Thanks. Note that this depends on this series as well which also needs a
> minor update:
> 
> 	https://lore.kernel.org/all/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v6-1-84ad1cd1078a@linaro.org/
> 
> Can you respin that one as well?

Sure

> 
> Johan


