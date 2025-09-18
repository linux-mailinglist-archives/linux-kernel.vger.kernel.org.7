Return-Path: <linux-kernel+bounces-781361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15E8B311A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2620C7228B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C413D2EBDCD;
	Fri, 22 Aug 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/fef6QA"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7ED2EBB85
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850795; cv=none; b=MpwajTgKLV9Y16a1k2U3/vGRBncKEjJoZW7kDIg4sOhDkuCbg6uxXZCRa99WnMLLCgX0MDOl18XUuKIHQeJfcx+MQXiXYiqstM/SWwReQGbpPf0orbABxVG2xGBeIP7HOWyB/0o8MdRUkIR2IMvf0Lge3KyLLpJ2fmLpcMzy6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850795; c=relaxed/simple;
	bh=fYJrd2g7WFm6z4yIUHs2tmTEfH/IBYpwGIudE8DUI2Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iavECjIhaX0j3iCcMCNN45nUb9Kzax+QQA0fIcLIODVzCSoZYRr7QG6kut3Ar2OY5UDEMy+0i/XKyx4BdjxDTNvj0pNLfsbsFFrTElAf3NWxVtdydRA55VPNUguuAqcOHXeYuXwNj+LUhkpAay1ZJd0yIdD4FLJ+J5WFdtWK7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y/fef6QA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so9760475e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755850791; x=1756455591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUBU+j8H4Ay/gKzx2DefRsd/tOgGE+9a4/c58V+37VI=;
        b=Y/fef6QABrfGRX3Tzi6SfVBjJpwLlA94wyNI7c55UJP0hzQWUqER0vWa0NIlK0CDaz
         tbVHKGv1EjH2LZSfmZBQ59SZMKkQg8XsvbWbagCZx0LtSmd5+XlorW/CQHoLv7HAAH5h
         6KcK5DmT07e1/S2VpAZR0CRx0XWQBhDRXaN0kwciNoRIwvYglJoHYiyh8n0zR2Zs9whZ
         8YQ7WbvDdvD0usqVT9pCBrbPpUNwri2/MtQXle3QAxtnX7yGfG4qFepBiFO+zeL6W96A
         EUmCbNbZ0ghIlil6vpB9NEVw0EEBMxWrhTz2QHoxC3pZO9BJ5cBrlSguzP+cY+2gCh/x
         KYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850791; x=1756455591;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kUBU+j8H4Ay/gKzx2DefRsd/tOgGE+9a4/c58V+37VI=;
        b=riybtjLb+HupUjnlxz8CxjZRz0x62O4sjbyJg9CVGBEJ0i3gD9evIR4BvqeltCLifI
         zEyZ1bmaDFMKo4/lx/f+UFke/aRtQub1K5SMrPDkb937RZV8YTUJNNvQeX2/Zy903ZPl
         zaImuicVrPKkLRWXVgMPrZvsgbhjWryD3ZNSDUQPVGUNX+toaLhmjbXmVRj7RCj2P+rY
         XXaCJfGXCtx20LZ2NrugmO9vJGHARzfsWOKQaTmYWC2CcUe2M1wDaygo23B91/4an7X3
         cn3AOckzoUg+6CMUqlcYesw8o4VTwZ92G3NJiVAyaKoVzJCHsMZ3XlhVPTwJ59Mpf0eh
         QyRg==
X-Forwarded-Encrypted: i=1; AJvYcCVEB62462wSwHenuX5rKv8xqb3DLG+MTZc1SiynZXWE2VwhO7PWjdLyuGNr+PvKBDOoyArE5G94fORtnl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHC+Og2t8zoAa8PAUy6NBauRsRu5rt0pPGDDSnE6Ycgwr3GOc
	BxyY8Zqtt5COLVOWZIQQFQbxu3IHbDyVTR8Axl48xS63GBD7Dz84aZ1+l6duIuX7UvY=
X-Gm-Gg: ASbGncseY16PvVZ2S8xwwi8ls81F/J6bXx9iJQpSyDyrmmn6So3DZS1PI1s7G17GhpS
	xN6V2LpaEu4ZxMgr71i4jBcPMDBM0PHGK4DOChDC05LYP3kRvGD2lpRLJINDxErPxnq4QU4v4Pf
	g7/Cc2U47vGKgCxzb/zwmOD5n2iSk1yAs6RsocVzAwD+/V0V04fqKKz+8UlyqCpTOZp8abpZw+n
	fgk1Wdus1pvWIL6HpgIWnmWhLf7AMuzKZVr0XjCmsl1oV3NIjDt+9E0BSLpILuHqMedxcyoqt6O
	SZd+3egzqrvRl507fdIXAc3MXYe2ft9JYeIuSxekiIRDJHBMX45EG8M4su2UtSWDtxHGpZnGbAA
	/++kXLrgrv/vGAqxFvETLPQzELYWSVAilrilxNvFsC1VZe2aB1qq5yppxXvkQ3uf6WE3A0Y5bkw
	4=
X-Google-Smtp-Source: AGHT+IGYmXDHANFL2t0O6/z4GzQMDxxubZ0LRneoCclAPeF8j5bCmO9Z2rmiq6pSYn1hXjYdeBI8dA==
X-Received: by 2002:a05:600c:3b18:b0:459:d6a6:792 with SMTP id 5b1f17b1804b1-45b517cfb65mr14663365e9.29.1755850791427;
        Fri, 22 Aug 2025 01:19:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3dd7:7361:c101:6a77? ([2a01:e0a:3d9:2080:3dd7:7361:c101:6a77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50dc41dbsm27816145e9.5.2025.08.22.01.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:19:51 -0700 (PDT)
Message-ID: <b4456929-cfd8-4e8e-9def-f7ce0a02d240@linaro.org>
Date: Fri, 22 Aug 2025 10:19:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: lemans: Add PCIe lane
 equalization preset properties
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250819071649.1531437-1-ziyue.zhang@oss.qualcomm.com>
 <20250819071649.1531437-4-ziyue.zhang@oss.qualcomm.com>
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
In-Reply-To: <20250819071649.1531437-4-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 09:16, Ziyue Zhang wrote:
> Add PCIe lane equalization preset properties with all values set to 5 for
> 8.0 GT/s and 16.0 GT/s data rates to enhance link stability.
> 
> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>   arch/arm64/boot/dts/qcom/lemans.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 64f5378c6a47..c7a09c3605a7 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -7657,6 +7657,10 @@ pcie0: pcie@1c00000 {
>   		phys = <&pcie0_phy>;
>   		phy-names = "pciephy";
>   
> +		eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
> +		eq-presets-16gts = /bits/ 8 <0x55 0x55>;
> +
> +

Please drop this empty line.

Neil

>   		status = "disabled";
>   
>   		pcieport0: pcie@0 {
> @@ -7827,6 +7831,9 @@ pcie1: pcie@1c10000 {
>   		phys = <&pcie1_phy>;
>   		phy-names = "pciephy";
>   
> +		eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
> +		eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
> +
>   		status = "disabled";
>   
>   		pcie@0 {


