Return-Path: <linux-kernel+bounces-824729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36CDB8A019
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CF93AF4F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD031329C;
	Fri, 19 Sep 2025 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kd606FTl"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5198227EA8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292588; cv=none; b=PUsW6cXhcg52I0g2c6o8gLd62CBGfYs3AIfUrTGWn/GkoCidp3zoQOtPYVjslAkLGLhvTV5KnEc9lHC2iBuCA97xNia6qLLQpgIsnr/l/1+JGr4NmOnQSYUw9p7rGyJIy2RGYQ8khJo7ZrjgxCWdYorAmk8mVCwkF9dirmyARA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292588; c=relaxed/simple;
	bh=TjjXjSoFhC290sr1MFSurGUASvtLJpRdQFNuUGp2HpI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iCTI6liPP2Usbw29h0yCU8DbuCmVi6gSFHC72ODU7HyYhwJsI69TK1BURRlVYRLbUsuAZLD/YP7SDF9FQ0Of0V4SWu+j5Z+cQM8o24uvS5YnDF9lh35B3/n73IenCBbWipqASC+23zIxqWNBrEAqblpBXbuQx9+EEAfPpRb/Mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kd606FTl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso12251825e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758292585; x=1758897385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ki7qAfO4qaImjGJ2JfSFUybYdIzI88oPzTIZNv7oRHU=;
        b=kd606FTlP9cIGfDUaltvdK9BjlzcrfK10fXpLsxRsedxi3oNdwBvefHPwPplrZ5zJh
         Rl9jYfIOSdeWgO76OKrMmkkICd9W8hmPp6WssNHd8UNXXiqSYwegZcvmdwI9Ukfe4skX
         cPXNPlb9ChkWhIvruxG9XLu9MdvgsTW8MTHhUtzpXz4XAzbpFxmtUOQ5/L0DW8bpufPj
         WcXnyFc5iZnT/38DX0nBT/+Quf74JmTlCRZn0L5gVF+gO/vdlcfUbPjK+5Oiiedx0QNK
         XPnL9NSpuu1dXHNoEIDFWTh6003lukn1mZ/+MuLt/7W8Mg2rSB5sGXjmw3RL2TKgeph8
         q1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758292585; x=1758897385;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ki7qAfO4qaImjGJ2JfSFUybYdIzI88oPzTIZNv7oRHU=;
        b=npRgjeFQCloBogIvLmAWSTWjPk2GcsZqng+9bffEiLwxC/tch9MH+JlF1BHSGjWWJy
         srBTWcpNa4EssWv5Trex7+rfDuxaWDb4rZDMx0RN/Exh1Pv2Ju/ZLnNK01mJO5xri8Cz
         wZ5IgF8JG4wDdMEb5tDrUe7Q40l7xl2iGLU/uJNYY6Z0QyyUTRCwEPsdXKb5moGGmiCj
         Dv4lrcVGPGthgt38c5h+G2J/qpBckXftNwELXxd3vnADWjUFncHj4yTqysTnPjHMHMMD
         QC5hrzERZMumA/XRZIx6HmTQ5RFfZlZNY2ELNltjQ04Ij9WN3fYNWPIDQcDRBLNUI9nJ
         G5oA==
X-Forwarded-Encrypted: i=1; AJvYcCUKbTy1u0CW/7UEmj0u+dnhvOSOExBj8cLkzaeam/5dIuE1P+LiGsn/Mdo2marDgSS2bByEkqTwHzdS0s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1qL6ioHkvWWUJa3AeVBNXDABdSDBILLSAbasi/6Da4SEErdu
	2sqQHJHtw5MeCa3XPPgWktsYHn73IwmSth1qJi5zS1pW9L8zef+p8OSWpPXMz1FCQ00=
X-Gm-Gg: ASbGncvQbgor3uWsQXD1m2H2eoLtBjzFAi6a6sd7mjAwfpnqgbQZ2bFqpob9+KYiWcS
	W26o/YD0+Hub8aJbkY5PwgKg5Dcu2Pbd/JohYZwfoqCGfZyDDpG9r7uFGPeLvcEWB8c9cu3wywy
	uHuxZW0MZPOzn+7ZENKAiB9hi1h8mR8I6rGIMjaEt5XLiTZaCTJuftx9A15QJZ0dgVNKlwXeeHk
	Ihkfrpz1a9oEhSWoVotfav/atSlojCp6yQFp1CF76+Ko+cGy3Oohk7hj/bts7LixTvs979g+Sfn
	NRNzmGbo+qtRRgcpDkvOq9nvBVlXmar8jxH+2ubejM9en+J71y3ySmO2+G/kE7yQaF/hlvBfmYi
	b6JBY4Z6INxn0tzGKL0J2KLNoy/CZsN5lM5LBYVsqKSvmICNmzimNCEeaVDk0fNmYtHSU0vSi
X-Google-Smtp-Source: AGHT+IH5vrQPKYerDhA6I6iQ9DqZ/m8nF6zTFVhUr5PFv+QEeSA57WDealwtSdVJmyo8SQmPDRYqgA==
X-Received: by 2002:a05:600c:19cf:b0:459:dde3:1a56 with SMTP id 5b1f17b1804b1-467eaa881e0mr30634565e9.28.1758292584629;
        Fri, 19 Sep 2025 07:36:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:77b3:66a:b2a0:c20f? ([2a01:e0a:3d9:2080:77b3:66a:b2a0:c20f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f0e28c83d6sm2164989f8f.56.2025.09.19.07.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 07:36:24 -0700 (PDT)
Message-ID: <bdd942ef-1ede-4f9f-ab90-ea7ac8995b92@linaro.org>
Date: Fri, 19 Sep 2025 16:36:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: document Sharp
 LQ079L1SX01 panel
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250912064253.26346-1-clamor95@gmail.com>
 <20250912064253.26346-2-clamor95@gmail.com>
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
In-Reply-To: <20250912064253.26346-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/09/2025 08:42, Svyatoslav Ryhel wrote:
> Document Sharp LQ079L1SX01 panel found in Xiaomi Mi Pad.

The patch doesn't apply on drm-misc-next, please rebase.

Neil

> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   .../display/panel/sharp,lq079l1sx01.yaml      | 99 +++++++++++++++++++
>   1 file changed, 99 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
> new file mode 100644
> index 000000000000..08a35ebbbb3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sharp,lq079l1sx01.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sharp Microelectronics 7.9" WQXGA TFT LCD panel
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description: >
> +  This panel requires a dual-channel DSI host to operate and it supports
> +  only left-right split mode, where each channel drives the left or right
> +  half of the screen and only video mode.
> +
> +  Each of the DSI channels controls a separate DSI peripheral.
> +  The peripheral driven by the first link (DSI-LINK1), left one, is
> +  considered the primary peripheral and controls the device.
> +
> +allOf:
> +  - $ref: panel-common-dual.yaml#
> +
> +properties:
> +  compatible:
> +    const: sharp,lq079l1sx01
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: regulator that supplies the analog voltage
> +
> +  vddio-supply:
> +    description: regulator that supplies the I/O voltage
> +
> +  vsp-supply:
> +    description: positive boost supply regulator
> +
> +  vsn-supply:
> +    description: negative boost supply regulator
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  backlight: true
> +  ports: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - vddio-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "sharp,lq079l1sx01";
> +            reg = <0>;
> +
> +            reset-gpios = <&gpio 59 GPIO_ACTIVE_LOW>;
> +
> +            avdd-supply = <&avdd_lcd>;
> +            vddio-supply = <&vdd_lcd_io>;
> +            vsp-supply = <&vsp_5v5_lcd>;
> +            vsn-supply = <&vsn_5v5_lcd>;
> +
> +            backlight = <&backlight>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    panel_in0: endpoint {
> +                        remote-endpoint = <&dsi0_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    panel_in1: endpoint {
> +                        remote-endpoint = <&dsi1_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...


