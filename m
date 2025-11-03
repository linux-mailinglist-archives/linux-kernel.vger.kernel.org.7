Return-Path: <linux-kernel+bounces-882595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4C9C2AD60
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A12FE4EEB01
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9652F9D85;
	Mon,  3 Nov 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P72n8GwY"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E692F83D2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163261; cv=none; b=QWvi78u7pDtLUCAZxlHszNaH6s/hCbbT3WWIAjFoxGQd4v/NZIi5DhvRAj4jEj7jE6wX0p39Tar6I5D+3AeVIlJx7k7EgwoSxr1/9twrDRVSPWD2T6TW7lMhuSU5VFws1J+QXtoAcjnckaOpn7ab8tlX8KnzVzPBlOh4Ex53zQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163261; c=relaxed/simple;
	bh=LLMUyIe4Fx9AEEvn0jleJ4zqebz1qVtL6Af3Q9h+i6g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h9NImk2cn2y6x4wXfHXUEson6q/1uSOZ8p2KOTkoDtgBR99NQFNsgtkvWykgDj05BvzHexa7PVxPD7eJFMFRyPLLc8dMoAcXUHIu05TabcIorMtZqE9HyPjMie4Cl69So3KcyBAhewBrJ+5GwrBBjHKbE9b1cKRaUIQXmLKmUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P72n8GwY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so33819325e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762163257; x=1762768057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWAXx0S/pPXGVImvk7hrySXVZEromhVxb0VxrMIicFs=;
        b=P72n8GwYmjP9dgCb9s9tJzsejc9p1w5KbRe5Gw7NwGLAYKxWfu705dYYQIcRKXloyN
         oxHkI/kj/DTNXIBDD69qSZHSuo+HxjZaCnQ88tZ01tqtw+1cY2H6zuoc8Nz8m58ZFU38
         ENNLODUNQXQjkWuhIa26nps+JeKGMMcemhorDc39Dq6n26GqsRhy188yobLsC9u//EtA
         l/hcv2MjClaRPFhOWnkgqxlInySHMMbsV/WWpK6PybvaZCrJeMJc8whgVYYovZ57Krg1
         Ay4rFS9c3wnf/9cLEloRFpOAY5Z/PjYqWQ15c6SC0u3Y37LVYlRwjuVQ8yzdbsdejJdz
         K0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163257; x=1762768057;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bWAXx0S/pPXGVImvk7hrySXVZEromhVxb0VxrMIicFs=;
        b=CMHM4gZvwdW/acWx0RSErD+VqyEzsGiRco4s/D1nC50QfzdRZr71EYhXgJ9ALULmnz
         l6CW2VthAM3IgT2gaDl5SDKlsjBmdP7/fFrMIvpfP1kILNvEyvOtdrjm6xGnPhiTkgL+
         FhkEuipvCusYZ1iRHW9Wp/Vr4Ml8oGAuOMbmujsR1MliaQUpS9YW7zmVoF2sQpEek3hu
         4X3fV3om60p3O4MLq/JkaTfDWu2zuSmbOF9t5l8LbdbpHTN0WX/+5LX7U7h3LsQs1z0/
         RMXvNgwd0zTZCPTW7m1F7B8qQi/r8afDsMcxEzURjNOaqGFJWkp8iAv3hVRenmucnhx4
         LyYA==
X-Forwarded-Encrypted: i=1; AJvYcCWeswQHXmNyL94pSZAS6pIvo+B21ydroi70iu/6Izmu4Gp8w1KfaBj4+PqqlbJXUm9sod5KU29806yVWyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDOgoFXC3XFHC3Le+a8m8NvQxR9+ewoAhK00bOgIRKj9yFGW7
	yoh4sexqjJPfrdaC+ut7Js+294+Hs/epQ+Y6bbMwoK5SNyd3t9rVVr4Uq2fX9lj+108=
X-Gm-Gg: ASbGnct/AiES6S7R+EFkQrYyTQhvQUTE0YLkvVxdwym/vRz0jbV6yvgdB1Lia8cgvz+
	k20mggSKSeim+617EVb4xt+lEznuzVzJPCxQ8nG5/HyOQiXyHkGI9WF1b27VwlOtU/D9BWTRnzh
	s9+ZrUZ2/42DqQBLyMwE4SgQecSOpc+owt0v7IY0sILCLKg17APAV7Yi47Ywp7LLvcA4kRAhI5d
	+hbuE2wIV1ydcYn7IPlluFoeQtsYVJNN96fJt/hdGVkD2IUv9yNs6I1W3ikJWOlfbkWoD+2zB4S
	b9MFnGmMDEmKi/vufZzVU5sSVPUjHKR2P33uXZjVMixx6oQFY+zumRMCtBTcvNhVZrnK5NIUUA8
	TydE9PvHPZPAz+nwaWWSU1akwpfbJ957+6KbJfAOJI6EC98p/SPcsTmk9YbQo+8Jh5q7O/1nD/5
	xEtc4YYNfPORTJEsbRfRnLJ9ZldU7eoFyCXMrfcg1n7NlR
X-Google-Smtp-Source: AGHT+IFJTdtxUlC5NqH3U7Qd9RRa1ToHSLBe/u+l9wzF/fKHgtyig4wAMueqSDc4k0TKmlPFEUaTjQ==
X-Received: by 2002:a05:600d:4393:b0:475:f16b:bcbf with SMTP id 5b1f17b1804b1-477331dbef2mr57555515e9.14.1762163256713;
        Mon, 03 Nov 2025 01:47:36 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c374f84sm144227945e9.0.2025.11.03.01.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:47:36 -0800 (PST)
Message-ID: <31271df3-73e1-4eea-9bba-9e5b3bf85409@linaro.org>
Date: Mon, 3 Nov 2025 10:47:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 1/3] dt-bindings: PCI: amlogic: Fix the register
 name of the DBI region
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
 linux-amlogic@lists.infradead.org
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
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
In-Reply-To: <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mani,

On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
> have region for DWC controllers as it has the Root Port and controller
> specific registers, while ELBI has optional registers.
> 
> Hence, fix the binding. Though this is an ABI break, this change is needed
> to accurately describe the PCI memory map.

Not fan of this ABI break, the current bindings should be marked as deprecated instead.

> 
> Fixes: 7cd210391101 ("dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe controller")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
> index 79a21ba0f9fd62804ba95fe8a6cc3252cf652197..c8258ef4032834d87cf3160ffd1d93812801b62a 100644
> --- a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
> @@ -36,13 +36,13 @@ properties:
>   
>     reg:
>       items:
> -      - description: External local bus interface registers
> +      - description: Data Bus Interface registers
>         - description: Meson designed configuration registers
>         - description: PCIe configuration space
>   
>     reg-names:
>       items:
> -      - const: elbi
> +      - const: dbi
>         - const: cfg
>         - const: config
>   
> @@ -113,7 +113,7 @@ examples:
>       pcie: pcie@f9800000 {
>           compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>           reg = <0xf9800000 0x400000>, <0xff646000 0x2000>, <0xf9f00000 0x100000>;
> -        reg-names = "elbi", "cfg", "config";
> +        reg-names = "dbi", "cfg", "config";
>           interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
>           clocks = <&pclk>, <&clk_port>, <&clk_phy>;
>           clock-names = "pclk", "port", "general";
> 


