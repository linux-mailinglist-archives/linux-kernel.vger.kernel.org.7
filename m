Return-Path: <linux-kernel+bounces-762194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA9B20335
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A32464E0587
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74A1FBE8A;
	Mon, 11 Aug 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7wmcPXG"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA98F49
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904222; cv=none; b=ZbcShPW/B0zbIJxjWQKDUJes/HvbmKx9PFiwzsQPAET1VxLCrk0ZxSS+1szuiHXwqdE9igYkNAoLaXT+ZHTazVrUV/JB/U6yrXjA+cPpZTRhqBD8u2UOh+TF1wXWR0cnK7sLUIcZ9VzYoKFQX94nwhvZGJH3UtZm6mDyWwjBENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904222; c=relaxed/simple;
	bh=RgV3X8PbdbstKOgwdP5ORSeNGibm4oAEngoG/udq2RU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j+nkZKIJWsfsfKWpqw9GbZYr2r4nae7UrWsvhsHzjBt2sr9fcYK25eVk7eC+k0MaTdWGLaZoWUm4HTSSTfglE2FiEdBAfV6uH9KsFUMokVz3bwH1MfWZEc3JE9gSgxjNDEpvejZzDHBJbVPgik62cfh9pzk2ovhFa6hKfLUOTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A7wmcPXG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459ddb41539so12920115e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754904219; x=1755509019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s42/SiaYyYGVE6EQRVYHXEsbuCtqW4KnVk5DzB7k5Zo=;
        b=A7wmcPXGFfaW0JQdfV4pTwg02nhDtRagQhH25n58jfUOIMpUxv2nv7/X3nvOhtlhXF
         v3Co5vPLOWo+l4bVBzfJDOmeC7keIblu1iixaZa2RD9jZI1VFu7Ghz2XOuPNiewWNm02
         ZC5GDcTM+2Rkp44m9phTzntK5pJhzXwhFnjzp9CYk8BI7TaNVkDsnXhcIH7j+JspmZ8e
         FdXUMf1i9g7DdOohUJ9xm6LP58teitGHjTWBBZhrqLQ0OQDmqHvh/axxcGEho+2ZdQCT
         mhScgak78QCRku/rvbofP6epyxlbrRtNMd/9vlH9cSNpFj3NsOoyVr1KXHMUwZN3q5Sm
         qXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904219; x=1755509019;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s42/SiaYyYGVE6EQRVYHXEsbuCtqW4KnVk5DzB7k5Zo=;
        b=iEQgsrgY+RaSbalVfYQPETKG2wLi57nnDFu9Z9t9qcmtYYzNqKHUNpVgLzhEYhH1ZU
         icwvU6Q6iLMBeGfGugqUnz5xOx13g91I/5HwqdNQgpjh/wsozmU4Z+oOgqzQyLS4WJVI
         sRFdLkGY0p3qU4SgzTYDuoRzG5LqV+SDofttearI3PwrzIRCu/X1Dr7S7FeJzq+keOZj
         3TdvN3VbLD+Nag0grWYoG7covvDtSoQF3rmkxaH4Du/wI72Yhovcch9wGfPpeKxkrTmx
         IDt1j31yzAuV6NuWqU6D2DBDD+Bk5yfWMw3BIk7/z6D4Ul/TfCg8wMh5S8fkyUmaNxru
         b+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxEBSMIMZb/0H53KeZ/4859kFpT1sywl32qNM/vEKhWy5jtj5kd6JSx82LWlewB5hESwjUT1LuqHGzSUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJwT0cwgT0o+R5HmWE9UpAkuQa700gJ+PCNkq/UgAgjXwf5+j
	+QT9vz5itcTZCFMvVZyuqLJ3mPtHn1/Fzx76XZNRH9Zp+LU0qELYl53iuHYS4KZVDi2ixq0yq8O
	4XVlU
X-Gm-Gg: ASbGnct8XfKaDgrPs2mbbmEwD0L2xAQwlpMYBvjlzSibRPVgxVyALjZKOZrCzVGf5cN
	98m8UR1qmMiTnEGNHqgEmJahwVgrIWqaj7JYWYNxznMRW5jHVPDWr2xUEZ8QCY+a4Ny1PGp+o7G
	ZO/juxQzdDKU/FO0XrhbKzMZqPBlS89nn1MVYUzSa2PS/EruKiRwTGIo4fOvvPxEh7k62nXAO9s
	yRWnEtN62zHGvjZwF2jS2ahuygq49HEnoHvyL2Pjb6sYS9UWeXqtBJYTPj+45xB9OOlXQboy5or
	X0EEUF9Ojc0Cdm22dVKPPqc/8y+zEclnMNgWBvYmDCtXDWpaWcKa9hvTFL0+HRzqItbt6orO2ag
	O0Ml5sebnTpjKeHKnGbJ6o6kqd6UA/IY+y5FpUxb4A0y8bKA6VbFBZ7QOpTEgbV2hvEZ2rVQ9od
	Y=
X-Google-Smtp-Source: AGHT+IEdGL+y1Uqgip0hxEqXCVAiAkHGV2kdyCXZxciG28y4uXUjh6jqHgHg9EYUgBthnXXUxqCG4Q==
X-Received: by 2002:a05:600c:3b86:b0:458:bc58:850c with SMTP id 5b1f17b1804b1-459f4eaa095mr92514795e9.1.1754904219463;
        Mon, 11 Aug 2025 02:23:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b0fa:b045:4b82:de09? ([2a01:e0a:3d9:2080:b0fa:b045:4b82:de09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459ee17535bsm206884675e9.16.2025.08.11.02.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:23:39 -0700 (PDT)
Message-ID: <00dc25ef-923f-499f-91ce-1d2463c48b35@linaro.org>
Date: Mon, 11 Aug 2025 11:23:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] soc: qcom: mdt_loader: Deal with zero e_shentsize
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Val Packett <val@packett.cool>
References: <20250730-mdt-loader-shentsize-zero-v1-1-04f43186229c@oss.qualcomm.com>
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
In-Reply-To: <20250730-mdt-loader-shentsize-zero-v1-1-04f43186229c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2025 22:51, Bjorn Andersson wrote:
> Firmware that doesn't provide section headers leave both e_shentsize and
> e_shnum 0, which obvious isn't compatible with the newly introduced
> stricter checks.
> 
> Make the section-related checks conditional on either of these values
> being non-zero.
> 
> Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://lore.kernel.org/all/ece307c3-7d65-440f-babd-88cf9705b908@packett.cool/
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Closes: https://lore.kernel.org/all/aec9cd03-6fc2-4dc8-b937-8b7cf7bf4128@linaro.org/
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>   drivers/soc/qcom/mdt_loader.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 

The issue solved by this fix is still present on v6.17-rc1, even if we reported
a breakage over -next on the 22th of July.

Neil

