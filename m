Return-Path: <linux-kernel+bounces-773491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8F2B2A0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A83188BDF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18DF31B10E;
	Mon, 18 Aug 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7PzZ3BV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783119D8A8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518005; cv=none; b=Qr89R6H+iXllzr9TvtaR/V1N5TyqeWI4dzIVLpVz2H+x0lN4/gX7yg6EtK98p0Os46yyChIGoKz8O3I2pon0U+RR36M4hQ9YJDOngcobgRoBolwEelKEC/S4BdXCSd5ZhjUjZcl5mYsyE9HjsCnBigasRfvQERMwyC+rK+hbyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518005; c=relaxed/simple;
	bh=ZCMXsVlHtqvHp9HOjuFdwqmzaSfIoEmF+vzlt2RxC6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGuECkTgX/s+oEjI7FywOmtWLVAli/W7de1PwjVnjWh5OOctP85WinlV1H4j+FrJ8TKjWC0T8qpD0F0OhhtyKcQ9GLkJKBup46a+rujdysstBCAmlwPW/FBiRVgGr9wfEnUIDZne1PUmNw8HiwS116Q+0apf02YBCVA8WwsZE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7PzZ3BV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61a54560cd1so48520a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755518001; x=1756122801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fuR6jAMBV4ZTTjPzdysECiSK5P/2INKf3lMZTVfus0Q=;
        b=U7PzZ3BVooxxh573KcLqW5cso69QHJ2g0rgR5bcsnPtDICP09FVwAWkr/fBjqY6D/E
         Mv7YAgPjIlVXUd6bjIwCgOnGQma4C0E8FoWGwImXftxNh2kc7dedLhh7TeCMIykO0c8A
         EyqYjOrZVrywCJSkugYeDmogrVN/YlxEIAgQeruo1id1+bekB3iR87GmxDBoG21p4RpY
         aDzz6FJ+M+zAXUf5xK/4MxOCvQcZt/FPBKKI8E92WPk9I5ViUk4TtnFeuOIe/l2mSEoy
         Txg6YduzMmqdhmddjIIxKVHbim9J/iYh/5crXCYWr4LNBjRxfcTpSUbmdiMhGcUSO6d0
         vgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518001; x=1756122801;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuR6jAMBV4ZTTjPzdysECiSK5P/2INKf3lMZTVfus0Q=;
        b=ojIkofFV3pS83hporIUYv3uFbp1mEfJv6WdI314Ub8lDUrBZznM1cKtR1pyCJWeoTV
         xJQt7oBy7emxGEBxQ4PsI/uUxzd0FfA0wwOn9e0Kh3aDvM3uYuCc7dj7chpF0tkvaDoq
         obwB0yAWXQByodIgCjRu4Hg4kymYWqIoskKDKIiP7jRrdz3yktVQ7+UHHn32Kg7dB05M
         wrFK0eOt083+rlr9fa3tgw+NANOW4gtd1rXJmGxBs5B3UcXBirqOwHTK1S0x1k2CbD7A
         34kq9XrALMBQ2VL4AUALpPH65EpcPXNSanEUNzJZ0IQv45uMzJdhmeYLf9AsXrD7w77w
         pJpA==
X-Forwarded-Encrypted: i=1; AJvYcCXM0JUFyOuThYfKSQPwsLH/3ilYiXhC81aaeNNKyAnTHmM8KiJQXlTvAxTdfjcFug692yAW3LL3bJGasiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+IdbhLiV3FsyT2zKNkQIWRQyVF0VTpaac68HgAyuqo4nVhI2Z
	XYt+RimWLOQQins8KidXo2RMyqiwbpwT5HUez7WvOlOj04k2DQpfUTSBngsV1s/PdLU=
X-Gm-Gg: ASbGncsUvKm5bsTtaO/LUvcMhBmZYWLJfV3k+tDIKOf9u1MItpekGOZeMPjyjZmzKFv
	TnFhx8PkEmWESM5WZwcemLdPbZwF5hEJW2KEz+gOIenbYFG1mhVU/MIYBvgWzecNdxgCq/byIwP
	pBuE/7CXe5bAUvbydsfLqhyKLKE72Khyt3PcQUEnD4YHAiUI+n+vIYD4N1S1t9s1Hdx8Jy32Fds
	5hJFhTDs9sDKkBqPJyULOwl3rPXXc5UpXCu9GcVwwWcxggl3lYZ3RJKxM300eYkYGUHIQJ43UUI
	3o0Ed5svupPN632oOMZ79L6pokgPcGmcoHmR2hBc7CAd6gwe644v2R2p8OpX1oV8dpRxRuBgGRU
	d+noU/BsxURkLiYdJXVu0ZAoA7DEJJtKtF1oZQI/KODA=
X-Google-Smtp-Source: AGHT+IF1APw03/g57XmrCRLPRGpzFqKfZPNAZEXzjhiiwCZgq4h8v9nOpxisxIx7dzP2ziBJeIDBXg==
X-Received: by 2002:a17:907:9627:b0:af9:a9ea:f42f with SMTP id a640c23a62f3a-afcdc1f4d0emr506220966b.9.1755518000578;
        Mon, 18 Aug 2025 04:53:20 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72cfesm776327966b.46.2025.08.18.04.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:53:20 -0700 (PDT)
Message-ID: <f75a5ef0-d742-42a4-81c7-85b33028265d@linaro.org>
Date: Mon, 18 Aug 2025 13:53:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ASoC: qcom: audioreach: deprecate
 AR_TKN_U32_MODULE_[IN/OUT]_PORTS
To: srinivas.kandagatla@oss.qualcomm.com, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250818112810.1207033-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818112810.1207033-2-srinivas.kandagatla@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmgXUEoF
 CRaWdJoACgkQG5NDfTtBYpudig/+Inb3Kjx1B7w2IpPKmpCT20QQQstx14Wi+rh2FcnV6+/9
 tyHtYwdirraBGGerrNY1c14MX0Tsmzqu9NyZ43heQB2uJuQb35rmI4dn1G+ZH0BD7cwR+M9m
 lSV9YlF7z3Ycz2zHjxL1QXBVvwJRyE0sCIoe+0O9AW9Xj8L/dmvmRfDdtRhYVGyU7fze+lsH
 1pXaq9fdef8QsAETCg5q0zxD+VS+OoZFx4ZtFqvzmhCs0eFvM7gNqiyczeVGUciVlO3+1ZUn
 eqQnxTXnqfJHptZTtK05uXGBwxjTHJrlSKnDslhZNkzv4JfTQhmERyx8BPHDkzpuPjfZ5Jp3
 INcYsxgttyeDS4prv+XWlT7DUjIzcKih0tFDoW5/k6OZeFPba5PATHO78rcWFcduN8xB23B4
 WFQAt5jpsP7/ngKQR9drMXfQGcEmqBq+aoVHobwOfEJTErdku05zjFmm1VnD55CzFJvG7Ll9
 OsRfZD/1MKbl0k39NiRuf8IYFOxVCKrMSgnqED1eacLgj3AWnmfPlyB3Xka0FimVu5Q7r1H/
 9CCfHiOjjPsTAjE+Woh+/8Q0IyHzr+2sCe4g9w2tlsMQJhixykXC1KvzqMdUYKuE00CT+wdK
 nXj0hlNnThRfcA9VPYzKlx3W6GLlyB6umd6WBGGKyiOmOcPqUK3GIvnLzfTXR5DOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92Vcmzn/jaEBcq
 yT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbThLsSN1AuyP8wF
 KChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH5lSCjhP4VXiG
 q5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpFc1D/9NV/zIWB
 G1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzePt/SvC0RhQXNj
 XKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60RtThnhKc2kLI
 zd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7qVT41xdJ6KqQM
 NGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZv+PKIVf+zFKu
 h0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1qwom6QbU06ltb
 vJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHpcwzYbmi/Et7T
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250818112810.1207033-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 13:28, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Deprecate usage of AR_TKN_U32_MODULE_IN_PORTS and
> AR_TKN_U32_MODULE_OUT_PORTS as the connectivity of modules is taken care
> by AR_TKN_U32_MODULE_SRC_OP_PORT_ID* and AR_TKN_U32_MODULE_DST_IN_PORT_ID*
> 
> Also this property is never used in the drivers.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  include/uapi/sound/snd_ar_tokens.h |  4 ++--
>  sound/soc/qcom/qdsp6/audioreach.h  |  3 ---
>  sound/soc/qcom/qdsp6/topology.c    | 10 +---------
>  3 files changed, 3 insertions(+), 14 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

