Return-Path: <linux-kernel+bounces-882599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F063C2AD93
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F97D4E7E9B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ED32F9D82;
	Mon,  3 Nov 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTc9cz+8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F72F9980
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163423; cv=none; b=CqQFmnEzowFC3eGDrbxBZINb65Pc09EuSLKJI03HonIFC5unfZSTyYm0K31Xfzr+zlWRlMFK+sWW/Gg/eAl9pml6ZRY6nquequEaiFsr0KW8T0BS9Zxl1rx0FjKnkuRVhfLWzvzxW0oQlVK3hmSK8mc1Zodz9isMiFnDrGWZcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163423; c=relaxed/simple;
	bh=lLdro4UCejX2T0cIjEIAFpHkeF9T6b7n0Tt52fX1K9M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R9Dz3QX2ROEazJlwe0JTTFUBBTu0TtnmigAIhFcQEf/IE9pc0GfPw5rxuKt8iRhmfVFKo3IwWJWFOxQJjyyP5wmm/y6FiZwGCRUB+RyQCJGWQbfEmVLLBytlvRvOZRZBQx2A2yP5QEMKARuD6TO10lm0QH+f5xQRXVR/pCW+Odo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTc9cz+8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so37340755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762163420; x=1762768220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkxRjtj8Zko1T2xij3oDoi3JjwhxKLKuoC0vibst6Dw=;
        b=QTc9cz+88GfFLIx1Z5AlfQmnkOnNLCc3W67DvqHHiXx/W3Z/ZRecLLkrIBoa1jhlu2
         COc1xKp8U+tXjSpxYFtD7nEs/uNlyfR3LEZdVTH22J2+JBYrSl5aIYs7z2Z2Xo2IpB+s
         M5AEKii5wjnoUkzIE9BGf2ugjsi+f3eVRysvAcgFqW01MkMEkajens6/VfjUCOWePocO
         buQ8DnfPGt14dFj3dF0uVDAm+s7aQwsI3T+c3Xa0jYnwJ9M5EEemqFNhPjPtlp5C8SGm
         bowvtE6phABrwULn2mYM3vOw1JHFjIkNhr9MyWe5xrJKIKXxQ8fzbqDSVpYA/HvjyqKG
         wkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163420; x=1762768220;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xkxRjtj8Zko1T2xij3oDoi3JjwhxKLKuoC0vibst6Dw=;
        b=CKdPZNKd4insMJBzWP/S18jNtWN298RsujVo13Arumx1PArmLL87L8l6Rical3PjQv
         JHQl4BMT7G9OMc3X6/V7MBJZa26JH6QgTs4gAe7M+aopgBg1yEQCLFxNzpEGE8g6d+Nb
         mXmUeztLjxN6PL18K24RQIQncAji+FmNlIrxdVxf4pVFGVj68HyC2Sdt0YWJ9L+I4tBv
         oMIHH0uEHKbHXhadUPGTEcNtHRBB02c5jBw/I5EeTFmllvTajoUmjznQ4oexMD8wIIJu
         aU0sR89mhSH3XL4pSdhHQ8pk4ZuIlcJ2P/tlgDBkyjj27IQrkr8Ra65o/tc13r5ruO/x
         au/A==
X-Forwarded-Encrypted: i=1; AJvYcCV71/6djKV6CtGpV3HAo5y41wOxu5pbaX+kZm2A2pqkoMcVj/bO/URILBlMlvxW7533hkQmxIcs4lGl27A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jX4L11y6osBdQ7V8sjMHve4BUS3c1gbLVRsBIMH4VWQDLOv4
	6OQxwLu8JVrK4B6nh+m+PlDEDEucPVnRsvjvXyWvWYE+Zw60xHe1NUQUCvPqQsctSRo=
X-Gm-Gg: ASbGncvjrGNNTELjvmESxnDoYxvxNUb4+Xl1GWCJSaYUQncaQtA1v8tDqBh/nj84pOa
	1Hqz7iHhK/RCb5kJyRhX4ITCahxPtEv0LmMVv8Hq+aLyU6gohmiPxswbispZLNmP4vzjbCgtk8n
	iLCeHyzDS5HBd5f6w1rTpaL6lgpTK0gi8mQ9593FijWuk3D7ZrRy85VSSa/cpQnZqUpcqvmgQur
	RD6i+vRiKDioPnn4Bh3EZjAumVjAWr3OxpvETpTThNz8yVYnuVcD0XHjNx2iQVyIHyDFF2nm2nJ
	yfPspbiJheApTym0saYichVdUPAQIQmjNdfsH7npb/IhFNHb3sdAEBJ2ckdg3r5GJnEZh7xFz5k
	uJvboLrxApoHs3BPcojXjEncGUCNR65CeHZkC2bGszeuPDOFATJ+5ViiqNjBtJTtFX3u+FIkgJI
	CM7uDmz5U9rXynpqnmi4HnoG8ssltXrlb85Da5cMU08xW0
X-Google-Smtp-Source: AGHT+IHrNu7b4MLVFNafM5XudQwLx9/rw/9sFxikTt/B5JVYOos8PxRbnxL+oXtoVWVlGPVam6SEPg==
X-Received: by 2002:a05:600c:5249:b0:471:145b:dd0d with SMTP id 5b1f17b1804b1-4773087230cmr102374215e9.24.1762163420204;
        Mon, 03 Nov 2025 01:50:20 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcd45a9sm84684815e9.3.2025.11.03.01.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:50:19 -0800 (PST)
Message-ID: <83d07b54-d584-4297-9aae-2a170c0059d4@linaro.org>
Date: Mon, 3 Nov 2025 10:50:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 0/3] PCI: meson: Fix the parsing of DBI region
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Yue Wang <yue.wang@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Andrew Murray <amurray@thegoodpenguin.co.uk>,
 Jingoo Han <jingoohan1@gmail.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, stable+noautosel@kernel.org,
 stable@vger.kernel.org, Linnaea Lavia <linnaea-von-lavia@live.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
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
In-Reply-To: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> Hi,
> 
> This compile tested only series aims to fix the DBI parsing issue repored in
> [1]. The issue stems from the fact that the DT and binding described 'dbi'
> region as 'elbi' from the start.
> 
> Now, both binding and DTs are fixed and the driver is reworked to work with both
> old and new DTs.
> 
> Note: The driver patch is OK to be backported till 6.2 where the common resource
> parsing code was introduced. But the DTS patch should not be backported. And I'm
> not sure about the backporting of the binding.
> 
> Please test this series on the Meson board with old and new DTs.

Let me try this serie, I'm on a business trip this week so don't expect a full test
report until next monday.

Neil

> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Resending as the git sendemail config got messed up
> 
> ---
> Manivannan Sadhasivam (3):
>        dt-bindings: PCI: amlogic: Fix the register name of the DBI region
>        arm64: dts: amlogic: Fix the register name of the 'DBI' region
>        PCI: meson: Fix parsing the DBI register region
> 
>   .../devicetree/bindings/pci/amlogic,axg-pcie.yaml      |  6 +++---
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi             |  4 ++--
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi      |  2 +-
>   drivers/pci/controller/dwc/pci-meson.c                 | 18 +++++++++++++++---
>   drivers/pci/controller/dwc/pcie-designware.c           | 12 +++++++-----
>   5 files changed, 28 insertions(+), 14 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251031-pci-meson-fix-c8b651bc6662
> 
> Best regards,


