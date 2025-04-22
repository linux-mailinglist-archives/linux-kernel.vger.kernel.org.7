Return-Path: <linux-kernel+bounces-613625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F53BA95F00
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CE03B5612
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A24238C1A;
	Tue, 22 Apr 2025 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLCQbjNY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E7230D08
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305669; cv=none; b=ZfrkxrefKLqkFJoT9nM7WwQ0BKydbLSshzfuyeaRWnNWdpCH+GS5mpYFGYyoSQMNsaK918y1zNzb8S8Ow6aLEvgMI9H8LsPJplaLVp9wugWcvISMyGgukBF582AIuGnsK82ua7xKWs3dcmHqWUMt3JbZIaNBbSzQNqv4J2kwaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305669; c=relaxed/simple;
	bh=HjhLzE9Y/Q52iV3cqMbiQuwB2APqQ9fAC4HSJMOmcWI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DkeqtKRz7sa4Fj2HCgVxA3PxYSoJoAYArY/o4AQKtjACz9xHKl2vBHDYx6RhgbhSvyI7KZIt/i+G+TxmEPqWOKkh6pBHo4Y5HikmXE8CZlQClxiE86fOQO7js4cC8JGj7yaiV4/OWD41s7IbhuuuAdATnHKo8cEd0LlQaeXAlWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLCQbjNY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so44066145e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745305665; x=1745910465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6a3BQRbJn5uKf8xLcqr/agF+8C8ycJ/35awjwM1MZ8=;
        b=tLCQbjNYU4vONWrULizgRgx4kXgG4Q+cT54FK6XVHT4ILwOMdxMbgeCeICWXS/hkDu
         xktrtHLHx1QZG8oyFVwMHGoiH9h5tedIIpxP8Alg+hUBAw79IkCD5KgwMlaDCytkcPHN
         hsAKlIu8PDT17/fCtO5AkQQ4XEx9RSqEuZiWkXHBpHXoFCCyQFlE9DtIpYCP+MwKL4JY
         tNPtj1BP04TEtyentwGET2ojANmWkfZB9ts+IRH/Xv+j4hXgIq2ccjMSXicFj7WonRF4
         A2EEJjtjjlmySMFz9iDN0yDQKSOUKgMuT/f7F4IECcZT3n8dRdnO6d0VYE4ZU86dJHBu
         fVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745305665; x=1745910465;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i6a3BQRbJn5uKf8xLcqr/agF+8C8ycJ/35awjwM1MZ8=;
        b=Gp1j9HopKuWhFWtpK909YFrwEqq4m/WXM8rC1mclSwBC5ipt1BRdCFi3s9sNRqRkV9
         JZDLfUBtzrjM26kjf/vLe5epJomX+MDwiX36X5u4wpdY5iwynmAdjmM8pODVhDhLbn29
         +ED9LtHju2RAPyhuc6dpV+wf/40TY1bzpEzTz8Sm/xGK4xYIWvX5fmHkN7L3BQd/n8/C
         7Akck9Df97uwoOp6XhsBCKVLz1AImKMFYhM73sYlHWNTAEc6e/iT6XXKsOP1rVLfectt
         V5OsvodlCQWnx5bWSGi2//6Yo6QiNLRKBiK2nG1TcaUpd1xHMs/1MKF5xQwOJ2NW0JBq
         WDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6IGLWt07Xs69XPlqsYhJgZ3ZWO9bslOfDNRRMxIkRPmFfm6mZyvt1rqiPVFz2CDzKnZ+y+XQCCY19kEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzL5mHh54CrBptw/ql/sIJTuJgatUsJWdEf8Q7IAk67KUEEUa
	9clmyyZ6mkkLLyzEJ9wFsJsf1pQMf0WHT381gNGWV6MG4pViWZl0wDkXYjAYASI=
X-Gm-Gg: ASbGncslreAfJ20G2kUZchmcWOCVgoHZTtr2YTJ4TaQR4oyG3LmjgAwajIJVxBIxlXW
	vglpW7TZOLXoDWA/TdB+8UaImJ+kbhu1vWa6xIcWaGShWufFsWvhjiqJlj7ZUppQ68QMcGyO78J
	6V8UJxIBzfDS6mfPtzgVkehC+goy0Xze83S4eOuJWnxTcBSpjZ3NsfwK8VKLJ+TPn3hrEaARnib
	Dm2jWdGCxsZxJlkRQ6wu7fNVIa9xOWmNjJyTlZ3F6sffZTLLqbpBuHrAdEM/XsO0nRs9N/HtPCC
	A8NFK/68N6Ub9Tdnz7XSFe5BuhLU42ifDaXYGUFookOGXBXBMmCCsN83+AgjVpzh0TMSFjuUyvw
	sMx5tcFhoFkblQPTBow==
X-Google-Smtp-Source: AGHT+IHoQqch/rixFWxT15tJy0SJvow1uQ/1aou3lnDMI0B3Bb0LfLM25ogmt9gQblE5yATucRyg5Q==
X-Received: by 2002:a05:600c:1e0c:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-4406ac1feebmr119671555e9.33.1745305665458;
        Tue, 22 Apr 2025 00:07:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b137:7670:8eb9:746f? ([2a01:e0a:3d9:2080:b137:7670:8eb9:746f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9e38sm165457015e9.2.2025.04.22.00.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 00:07:45 -0700 (PDT)
Message-ID: <571b6484-d3ac-4aca-a055-c143f7e4a5dd@linaro.org>
Date: Tue, 22 Apr 2025 09:07:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: add iris DT node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250418-topic-sm8x50-upstream-iris-8650-dt-v1-1-80a6ae50bf10@linaro.org>
 <asfwnyn5grm426vq5qatrxfffv3wmbuzx6266rblanzqepffzx@7773dcxfaqe4>
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
In-Reply-To: <asfwnyn5grm426vq5qatrxfffv3wmbuzx6266rblanzqepffzx@7773dcxfaqe4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/04/2025 01:05, Dmitry Baryshkov wrote:
> On Fri, Apr 18, 2025 at 03:20:35PM +0200, Neil Armstrong wrote:
>> Add DT entries for the sm8650 iris decoder.
>>
>> Since the firmware is required to be signed, only enable
>> on Qualcomm development boards where the firmware is
>> available.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts |  5 ++
>>   arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  5 ++
>>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts |  5 ++
> 
> I'd say that these are 4 commits.

I could make 10 and still be coherent, but do we really need 4 here ?

> 
>>   arch/arm64/boot/dts/qcom/sm8650.dtsi    | 94 +++++++++++++++++++++++++++++++++
>>   4 files changed, 109 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>> index d0912735b54e5090f9f213c2c9341e03effbbbff..69db971d9d2d32cdee7bb1c3093c7849b94798a0 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>> @@ -894,6 +894,11 @@ &ipa {
>>   	status = "okay";
>>   };
>>   
>> +&iris {
>> +	firmware-name = "qcom/vpu/vpu33_p4.mbn";
> 
> You shouldn't need to specify this, it matches the default one.

Hmm ok

> 
>> +	status = "okay";
>> +};
>> +
>>   &gpu {
>>   	status = "okay";
>>   
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
>> index 76ef43c10f77d8329ccf0a05c9d590a46372315f..04108235d9bc6f977e9cf1b887b0c89537723387 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
>> @@ -585,6 +585,11 @@ vreg_l7n_3p3: ldo7 {
>>   	};
>>   };
>>   
>> +&iris {
>> +	firmware-name = "qcom/vpu/vpu33_p4.mbn";
>> +	status = "okay";
>> +};
>> +
>>   &lpass_tlmm {
>>   	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
>>   		pins = "gpio21";
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> index 71033fba21b56bc63620dca3e453c14191739675..58bdc6619ac55eda122f3fe6e680e0e61967d019 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> @@ -824,6 +824,11 @@ &ipa {
>>   	status = "okay";
>>   };
>>   
>> +&iris {
>> +	firmware-name = "qcom/vpu/vpu33_p4.mbn";
>> +	status = "okay";
>> +};
>> +
>>   &gpu {
>>   	status = "okay";
>>   
> 

Thanks,
Neil


