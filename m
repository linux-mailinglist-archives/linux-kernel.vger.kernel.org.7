Return-Path: <linux-kernel+bounces-843052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59614BBE502
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0072E4EE702
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EEC2D541E;
	Mon,  6 Oct 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEIN5pYn"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31C2D248B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760328; cv=none; b=uLpl/HHhKd5fkj6lHG8sO+YNFWt4hOC3zNen4Q/oSR4zCAP+d1FzyMgvl66aF/dhGmEE6i9vhyPK9QSuRd5GR8rrBno9jm19dfUoFcThhgxUv/QA+lPNDBkKpHArFxJ5WYqxG7/YbRd/dcIrykW6tlg48KvdgRhdbUduU3b/Gg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760328; c=relaxed/simple;
	bh=k0OmpDk0KNKJroNEEjqZ7d0GhZVyhTJVN01qDt9+co0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/tzG4OzjcDHDHzEQMAywbCbW3XgbOE8tQ2U1Dc6UcMOTM+4epi1D9oOsQ5Xy4bvmhIhU/AF3DvjqgTvZsm1X13yovWm01qc7FQ4EEatjev33cagHyTyVgAnAfTjzgCiJh4EBo5uWJFhhRSICDJLd+YREsdcTZg/hrqhEaPqirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEIN5pYn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so6444726b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760325; x=1760365125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CK17gYvAwLNg8wDIf4IUto7g150Ku1nKVfNs9DQl+2M=;
        b=fEIN5pYnIj2bGLp0Xdliu3LVkhNAa+r/RCfDL8I43rpdDm9NUg7l1/G25NG/uBI6Bu
         nFjFSfZXpI89CIVHQjP5eb58mlPKh7yXkyMDl50WUH1BFijRYhmWhJk4IPzPiIFv5nEQ
         W/ydrGUbhNmzMjGmUHXyR/G2jSCtjUSgzOV5Bhc40gaClSBugiSqX+ANt+32mX+0mKqM
         KlgjMmW9cCr6OdfJofnBhNmrWDsQBnU9L0LdeTu8oXpLuEc9P0+nn0mVx8Sq7rBodY/H
         L3CqEDMW6pkw2MoQk2v4jO5eIXqqbsV0TuemFoVG+DXHUek1lmjYi9ZshwOBPaBFWjFA
         uKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760325; x=1760365125;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK17gYvAwLNg8wDIf4IUto7g150Ku1nKVfNs9DQl+2M=;
        b=S3KDlUoJ31v+UPOBcJ2ygZskeYs0bdoNg5toDnS4ePW7IExhQ7zTPTRefcZnrRuIw6
         jDAOd0x2+i2TKs/EnaIwDhZR7P0NliBLoeBs4hYayXkgdRYHKaEhsG46i89+sIiqlwZL
         TW68Y/21uftttd78GCVBdT+0/avo34jY3sTb/JEAFwPZ1cpKG4o7LoZ/0j+yP+f8daBg
         deiWetVdPqmvlxIJLEfDwj43E1BP0zKAbNTqyS9JXDLkQXugQfwpVkQL0Wb6xfVB5P6z
         vT35Ow4hlHES0aFmqy/l/5+UeQeqo6yNuqTW8qPRVKnqrmae6OemOiihHnbc3lkUNkqz
         35RA==
X-Forwarded-Encrypted: i=1; AJvYcCX/iQBgpQ/wA7SkH4Ag0sbGsviYipxuZeX6NKdZ25jKGoIoRKTVekcFMP/uKxFdXVFWxtn8rWskaKwWJ0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eVldViIq6xfXMrqGsSby/wgj8AHDPjT0nzhZ59ye9PIfbSZY
	Gkm3CMlzV4VTJvwTEq3AbeuvJlvjeHucR1fKcOdpobczwRiHSNqBCOQyISxZfWvU
X-Gm-Gg: ASbGncsNoblymTNWjefL3m1Hikqf76cZHV7KadSUR7NQ4NicqPlhsfgNneb8uzyoh9O
	gcWriE8pkchQcIwlvq1j62DBDttJeYTxfm/wRdvfkwnRZbKbiCQEsKhdiTl8tN2ADy9XXeZwza2
	sezEijIJraDV31KBDDYRfGUnUFvc/PYoCphCT7Uma+juZn8+dFQYOYDyeA/LoStAEcDDdurh/4D
	Q8KQwWV4giA09baKIfA4vwTSZjSd0J0g9uy+lgiZx63LvAbpJs/FMl7oX3WpR1oL+Ks14ayGV+i
	TK4yS6yPXRRJzeSDA1mffsyUb2XHAb2tCsj0xBaXyshF9a8ujIWeP9cdSjZqwOdK9qRujYjFgnZ
	hXO/e4mnn0/fkK0RwYLsd6OoRKbbnPOVV2uLPznulNhY2vIm7rupl7GwuK8V1cdyaFHPk+Za23M
	q8mLrTUmm7FlUlJEtjkyiOn9MT5Cywow==
X-Google-Smtp-Source: AGHT+IGvpR5f8otgqmwL+gF07v3iruSrjYTkU+pZ93D5rZfCIP8x+f6JPTDEZH0GFXLEaEAj7s0yug==
X-Received: by 2002:a05:6a00:2d22:b0:780:fd97:77d4 with SMTP id d2e1a72fcca58-78c98d61f76mr13233001b3a.10.1759760324803;
        Mon, 06 Oct 2025 07:18:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02074663sm12903935b3a.74.2025.10.06.07.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:18:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6e7eaac2-0859-4bfd-b76b-2f81e384a91c@roeck-us.net>
Date: Mon, 6 Oct 2025 07:18:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: Add driver for Gunyah Watchdog
To: hrishabh.rajput@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20251006-gunyah_watchdog-v2-1-b99d41d45450@oss.qualcomm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251006-gunyah_watchdog-v2-1-b99d41d45450@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/25 00:37, Hrishabh Rajput via B4 Relay wrote:
> From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> 
> On Qualcomm SoCs running under the Gunyah hypervisor, access to watchdog
> through MMIO is not available on all platforms. Depending on the
> hypervisor configuration, the watchdog is either fully emulated or
> exposed via ARM's SMC Calling Conventions (SMCCC) through the Vendor
> Specific Hypervisor Service Calls space.
> 
> When Gunyah is not present or Gunyah emulates MMIO-based watchdog, we
> expect MMIO watchdog device to be present in the devicetree. If we
> detect this device node, we don't proceed ahead. Otherwise, we go ahead
> and invoke GUNYAH_WDT_STATUS SMC to initiate the discovery of the
> SMC-based watchdog.
> 
> Add driver to support the SMC-based watchdog provided by the Gunyah
> Hypervisor. module_exit() is intentionally not implemented as this
> driver is intended to be a persistent module.
> 
> Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> ---
> Gunyah is a Type-I hypervisor which was introduced in the patch series
> [1]. It is an open source hypervisor. The source repo is available at
> [2].
> 
> The Gunyah Hypervisor doesn't allow its Virtual Machines to directly
> access the MMIO watchdog. It either provides the fully emulated MMIO
> based watchdog interface or the SMC-based watchdog interface depending
> on the hypervisor configuration.
> The SMC-based watchdog follows ARM's SMC Calling Convention (SMCCC)
> version 1.1 and uses Vendor Specific Hypervisor Service Calls space.
> 
> This patch series adds support for the SMC-based watchdog interface
> provided by the Gunyah Hypervisor.
> 
> This series is tested on SM8750 platform.
> 
> [1]
> https://lore.kernel.org/all/20240222-gunyah-v17-0-1e9da6763d38@quicinc.com/
> 
> [2]
> https://github.com/quic/gunyah-hypervisor
> ---
> Changes in v2:
> - Move away from platform driver model since the devicetree overlay does
>    not happen by default.

This is just wrong. Platform drivers do not depend on devicetree. I am not even
going to review the rest of the driver.

Guenter


