Return-Path: <linux-kernel+bounces-864942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E9DBFBEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE6B1A04518
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68E344055;
	Wed, 22 Oct 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdhn8DOV"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DDF347BB4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137246; cv=none; b=TpVDMrl4z7f87G69hEdfYk4U2RI2IGT0VQQZh7yMqpxLYoalCeULsnOnx8QOHNb5xPQO7WX+sZCRk7NL03mFgqVzkVOgt2NuzK/9oGTKA7eO1G52eF44lq8FVNTvVRPpPs08lnuUEmhxFbVfPDls78dnU4E/8Au/VsU3ybAigO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137246; c=relaxed/simple;
	bh=i2VcWiJcaFfPTCfVHKG4siZQy2DpZw6VAq2A15maDIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJvpbbORiXEhg+67KKIwY+wJ/YPFhI/V3e98sj9qOPfcDd4lYkPoyjRaM2ldzUyRDEOzOZD7xnm4zQc7KG/MR7ojQNQRb5XxhMr9T0uXRI86MP27u8ICBoUi7pGmuAoGwbU22MA4sjav4bzWqndY3E2NvfgTtZQLwoFMwoN4OU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tdhn8DOV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1312896766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761137231; x=1761742031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLynAwLummNFnWwX4n28DdGVDlN0LC2dmV54+Wl5oe0=;
        b=Tdhn8DOVRg2EVZ3wofTU94frCbS96NR1xAJ9wdc/UlBMiTtyzlrSfoVCuW8tcmqNuZ
         B1JTn+GJ34yPPeLiiuPtQh/aFv2rae54m/ddD6jtnm4nH2CiTFp0NTFTZbpKHH0pe9G6
         yAhOFJIpklLnm1Hw4z1tFt3GVtSdo6m4Eb4BGH8Wcs2QIj3dPKp0PrVvv+Ko+i3YlGir
         6yuJy0T+0QNTcioqhxWXZkejk5oH8kXupucEu6PxK2P3kmOnmmUSS+bB8ogilhxWo7gP
         zTeiypLj9BgKu38l0FFoNuf1dvVu666kI7cGnFz0YBO6Ea2+ERT4VT3n5MnwUY+yX5Iq
         qXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137231; x=1761742031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLynAwLummNFnWwX4n28DdGVDlN0LC2dmV54+Wl5oe0=;
        b=H4Fb8kH4dUV++J79QHIdhIe+1LzeV91+nicgBXryL8/iaH1S9Uxr+gg9/NwlWrcBnv
         +mPpzJV1osSEX1anD68jOfkntu3m+T8b7Os1nPal1jc2uESvaWkGFXgP1wWdV4oxGxsO
         RE5RCGsv8CftSuy0ocoCFmmhqqC7imno7pwZ3b1fztj+IBZB1ue9q02tvnH6AB8AgdwO
         IydTBq6rA4koxZv3kxyJ0Jb4pfvGapRvrVro7+Z6AYF9+WOTt6UT8bzj6grGtdBevFe9
         iMM8Yol23u3mTZO+a+n/y+xFsNK8Qwq6lz9XvZFnwTql6KF4GFtQABaxd+ofANhPz+V4
         mzxg==
X-Forwarded-Encrypted: i=1; AJvYcCWtnN5ptBaFRMOlmm4uRu73aFRLAgAyXH2tFjX0XiKfQzrABRAVsJrmJtALs134GpNWuyVkipZTAoywecY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBtk6LMV/0+0amnA9+up1ELwHPvIPJlE3wgLuTjTeJqMC9ptsU
	lyOp9elwrrm5/eFY/H/XOmw1uH7KNorsjuupV289mZgLT572h2i9ihOI
X-Gm-Gg: ASbGncueRAGQo/AVUTtJlWzzTF4djZbYGBoQUrMzHcG37Kz2lylrMt7PbGaL+QZdaxA
	keJKkECQPo+o3VZaongH0ZbJoCLemGXnufbAZ4jM8GMopr+BQgjHkhYv2PZ9hbVI7oQxGcxen+V
	qJFB10LaVkIeWxNFUhMy8lWdnc0HgkEZlQWLjVDsMegB+QNw4Ij2XSvZ6wKXEe80e2xE4FoLnaV
	I/xlCvZYexTGcA6/Z4BDwrNX8WcW/vo5bMsizqXfQXscKIEvlIxPtF1WCZOf4fj+fm1NQV4dI9Q
	lBVmG61Tk3LXJwFc2Ho/96FKtmDX/P/9NhgTDW/ebw9vnfJ4SUXlNSZJhfd2Rv6o3BfEqFQX7U2
	Nnru7Gt00HZEeA2j3TuQvUsdhUomKW0s0YCsXs7Sbox46dnb/9zeGbQNKE1G7ISOwT0vugb/6dF
	v/l23LdCmxmuqnxAFAa6/xP8RJVJlauDzh
X-Google-Smtp-Source: AGHT+IGCiRZUzBeTTRPZMe41X5ri9BkZhxAmfickbiqaWRlTqLIQgiyG0FTuaEpUWryBaH8SWItowg==
X-Received: by 2002:a17:907:6ea8:b0:b3c:f0a4:b324 with SMTP id a640c23a62f3a-b647463a1a4mr2231638666b.21.1761137230559;
        Wed, 22 Oct 2025 05:47:10 -0700 (PDT)
Received: from [10.25.209.134] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da25c9sm1360292166b.11.2025.10.22.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:47:10 -0700 (PDT)
Message-ID: <41ab3845-6d6e-44d1-9bb6-b62e58ab6522@gmail.com>
Date: Wed, 22 Oct 2025 05:47:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: clock: document 8ULP's SIM LPAV
To: Frank Li <Frank.li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
 <aPJZ6dDRyyl3Qg4o@lizhi-Precision-Tower-5810>
 <cdecae8a-7fb9-4ac2-a412-1a18c4783ffa@kernel.org>
 <aPZTwf8O8tkqnDhx@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <aPZTwf8O8tkqnDhx@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/20/2025 8:22 AM, Frank Li wrote:
> On Sun, Oct 19, 2025 at 12:05:27PM +0200, Krzysztof Kozlowski wrote:
>> On 17/10/2025 16:59, Frank Li wrote:
>>> On Fri, Oct 17, 2025 at 04:20:19AM -0700, Laurentiu Mihalcea wrote:
>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>>
>>>> Add documentation for i.MX8ULP's SIM LPAV module.
>>>>
>>>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>> ---
>>>>  .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  | 72 +++++++++++++++++++
>>>>  include/dt-bindings/clock/imx8ulp-clock.h     |  5 ++
>>>>  .../dt-bindings/reset/fsl,imx8ulp-sim-lpav.h  | 16 +++++
>>>>  3 files changed, 93 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
>>>>  create mode 100644 include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
>>>> new file mode 100644
>>>> index 000000000000..fb3b9028a4c3
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
>>>> @@ -0,0 +1,72 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/fsl,imx8ulp-sim-lpav.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: NXP i.MX8ULP LPAV System Integration Module (SIM)
>>>> +
>>>> +maintainers:
>>>> +  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>> +
>>>> +description:
>>>> +  The i.MX8ULP LPAV subsystem contains a block control module known as
>>>> +  SIM LPAV, which offers functionalities such as clock gating or reset
>>>> +  line assertion/de-assertion.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: fsl,imx8ulp-sim-lpav
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 3
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: lpav_bus
>>>> +      - const: hifi_core
>>>> +      - const: hifi_plat
>>> dt prefer use -
>>
>> I don't think we ever expressed such preference. Where did you find it?
> It should come from review message when submit binding-doc patch.  but I
> can't find it now. But at least, compatible string and node-name use "-".
>
> It'd better to add to writing-bindings.rst. It is hard to search whole
> linux-devicetree mail list or brain may cheat me. It is good to keep
> everything consistent.
>
> like:
>      " vs '
>      VCC-supply vs vcc-supply
>      ...
>
>>
>>> lpav-bus, ...
>> Then just "bus" or "apb".
> core, plat is also better than hifi_core, hifi_plat


sure, let's go with "bus", "core", "plat" then


