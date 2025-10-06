Return-Path: <linux-kernel+bounces-842762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA6BBD7FC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E122E4EA5F9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AB820C00C;
	Mon,  6 Oct 2025 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eun9mhZr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281A200BAE
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744110; cv=none; b=szUb186d8+6OJjlPLkHL64rvBwjLqUP+iJ5P2Qw+hF7vVshYVX9ZA2NAXSfvuBYrkdVLRC+d0zjpWFAxn7wrEbLhQLBu3TI6037a+jh/oatOiqbpJnAzaGOJQFxKuB3u0IaUGg1igA9K3QQgWZxFKdfAiFV5DLBcLQ1Zf+yQVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744110; c=relaxed/simple;
	bh=K7+0htyuoirxpSFu/xMi/nH7Dp6XDVMsELNSRKgsD6E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KIwUdbKn3A0s5EwjPnnnobg1/rvW1N2u5R40oeFVLgqPJ3UrvFO6sTlURB2T+AdfcZDbhQ3XIIHV/NkiOyC+3Yxo2ez3d7W3R2+UOc6HSNWNGHztEnR8jjYTGv+Myg/SLlGCq4i+5l8yUWsK2CB6oCkjNxR0g+9k6Kn62sf6IxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eun9mhZr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so23463985e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759744106; x=1760348906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9nCOIOWicslN4YZSsSssDCNnRYoc3KUcXalh/A1uR4=;
        b=eun9mhZrr9gdbQYQPeCodrWHFfrZpnvyRi80m1Yzw+2Kkp8m+G4Ynr8ARJhxym8JV9
         ryp8auXJj5a0NK+c/Ve0BBKX9e4lV66Q8Ulz9iGvC1Kigg1+jwxviAzC+jZPSRO6RtU8
         yIe4ifpACdJuHunLL1UghAYQICp/NINj7rP0IuMTY+BhTIHQP8otFej9hi6WNRjdf4J+
         oyqcaJzMDw9kWZpAexwJXMqxjoXfDHSaPAhn9rbGYtdN1OniXt1p24YV6lA9bfx2rqCP
         gPOR3BZOOrzOuc2NdXpZoN92IOHHAE4qXc7IIJ3jI9rkyQ4ezbSGpwLThUrJYdLWPozi
         7tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759744106; x=1760348906;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9nCOIOWicslN4YZSsSssDCNnRYoc3KUcXalh/A1uR4=;
        b=Ov58vJ4JIs6P2aHOhKcN48CNEx4tYPjcMv/TrhB0c9Yp+DxLQqu/exGfyki5pP8lLr
         2M7nQ90GrAHwjVdB/18FGg9iUQ3FGxvwtshQSqO7AGjQ+ZOrBJ0UOZbFOv4qv7pSdLxF
         j5URdNHrKN6J7aoA086ZqJpeuir0aQQl2ooNgwXnNyGRMbCrry0Zj0d7ODRwx83hyizC
         bbRhYOeGy48P4aKviNZuH0XF28AXk1PsWB7KzjZYkg240GQzg0+5qMQfjysfOgYbAOWB
         ksrxkLfR3fzJZTZ+klAmVa2GSFln6pc0M9YYsuUgt5iHrx/blnoFHKyJAqidBMobqKG4
         iNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6/HUATCYVmAuWK78OWiE9RnGF4EKrG1b//UeUmlvHa21wYfmIPyLMN/9dxLHj0ZPsEqzsngToczixovw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjhetup9ui5lpG6RcEoeMa6xji1MRm/K5xN831UR/WkHigy7q
	8zEYJrJSGaeH872scGUWRUnbvSKCT64nANv74gJyx/o73zhx9fbbrDgB4Cqlk8W4+ug=
X-Gm-Gg: ASbGnctZiZrv8oVK3qX4eGKtxG5g7nn4Gb3PsWjTyC4AOTUhxGRmdNfRotSOaBDVciy
	TfQ6nAy2adt3zQnf1BEXBNOKmgVfd+BsQRLRNsfHGm9vZxtTbfbrZkRisx62Pj3uSsQe54yUJYU
	6MVQAOc53yrpG4ZKVQv00LY6srbME0V9e5CS6qJIzB0eSNg1u8g+iw4I2QrnxJ4L+vtmx/5wNDI
	+7E3NQDpINOznMbPgbMkofIGd/Fhcrikuk/ubIpNrRnU9uFkf2ZTLTUcq7+x79ZPLs27ejREKoO
	ReUmPMbwP2vjsBOE5HOr2VF04KhYhknq3STpdvLAVjZ4ugM3uqEkEmVR9AB8038vcvxwbZUxhFK
	kNHVJECrsWi3jL+lafxj4it+YmZpNhRbe4qfkpe4SkyEdu53WZ8QKfZwY9DTcyN/P3QSLz/1mNS
	bIdCrBj7MPfCsGW8JTxfUEjiG77Ww=
X-Google-Smtp-Source: AGHT+IEtNxlbVFFWezzK/SaGtuPwKo272TEGVXiS0sDNJ1j0UC/5uBY5FceXCv8FXS6IrSRPjNnCpA==
X-Received: by 2002:a05:600c:3b1f:b0:46e:3dc3:b645 with SMTP id 5b1f17b1804b1-46e710ffc1amr73835685e9.3.1759744106291;
        Mon, 06 Oct 2025 02:48:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:2dd0:9118:d7f5:51d9? ([2a01:e0a:3d9:2080:2dd0:9118:d7f5:51d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e96e0sm20168586f8f.33.2025.10.06.02.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:48:25 -0700 (PDT)
Message-ID: <64ae6d27-d89b-401c-bf9e-027967e6b859@linaro.org>
Date: Mon, 6 Oct 2025 11:48:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document lanes mapping when not using in USB-C complex
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
 <20250930-topic-x1e80100-hdmi-v4-1-86a14e8a34ac@linaro.org>
 <c8dca827-b089-48e0-9dc2-a5b6e3c5b88d@oss.qualcomm.com>
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
In-Reply-To: <c8dca827-b089-48e0-9dc2-a5b6e3c5b88d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/25 11:43, Konrad Dybcio wrote:
> On 9/30/25 9:39 AM, Neil Armstrong wrote:
>> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
>> of a combo glue to route either lanes to the 4 shared physical lanes.
>>
>> The routing of the lanes can be:
>> - 2 DP + 2 USB3
>> - 4 DP
>> - 2 USB3
>>
>> The layout of the lanes was designed to be mapped and swapped
>> related to the USB-C Power Delivery negociation, so it supports
>> a finite set of mappings inherited by the USB-C Altmode layouts.
>>
>> Nevertheless those QMP Comby PHY can be used to drive a DisplayPort
>> connector, DP->HDMI bridge, USB3 A Connector, etc... without
>> an USB-C connector and no PD events.
>>
>> Document the data-lanes on numbered port@0 out endpoints,
>> allowing us to document the lanes mapping to DisplayPort
>> and/or USB3 connectors/peripherals.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> [...]
> 
>> +          endpoint@1:
>> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
>> +            description: USB Output lanes of the PHY when used with static mapping.
>> +			 The entry index is the USB3 lane in the order TX then RX, and the
>> +			 number is the PHY signal in the order RX0, TX0, TX1, RX1.> +            unevaluatedProperties: false
>> +
>> +            properties:
>> +              data-lanes:
> 
> Can this be described in a somewhat reasonable way to be non-compatible
> with Type-C properties for more validation?

I tried, but failed. Let me try again !

> 
> If not, let's just maybe add a comment like
> 
> # Static lane mappings are mutually exclusive with typec-mux/orientation-mux

Ack

Thanks,
Neil

> 
> Konrad


