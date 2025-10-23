Return-Path: <linux-kernel+bounces-866237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F4BFF43C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD39619A5FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5D926F47D;
	Thu, 23 Oct 2025 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St0G8EnO"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6126F2AC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198107; cv=none; b=uNw4NIMXwEll6qJdGfLlp7e2TWdSSK8vfX2M2sc9lT1yR4a0fJ367KMz5yye3Y3usOipIs1X2j2KVR0TbH5435MdnBsZq7YEsf/rIAMrKzeKlNfSN4pNE3XjdnHwoKuTQEDgX6/sTThkt81BwJI0YvbTbnhW5GjD+Tnbj0eheHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198107; c=relaxed/simple;
	bh=fwXNHVV2OsfDgklhZiAQIp1sKiKkUwVMzcFG2SCy8y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ettb45ZA/ldBSe4Hx9fYXPImA1/l5Nu1Y9P8GPK0hk0e8v4bow2pPP62+9iZEqDEsu4WECXNr4AOQF3likIxAAMOJXD5tWP0CeeVdQmwXVeLQFpQ+sfb8pbSA+7usP8/6FR2daUxa2tDzuf5SmC4j1CTxsviRPJsfujzItKiH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St0G8EnO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57992ba129eso512916e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761198104; x=1761802904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVmnu0DcZ8PNVbYItIhiUlRCiDcnVxMhr+Gj1/Vdtvg=;
        b=St0G8EnO/7ctw7wWYLzFsPxXP3X47Mvrz4Bt6ld4C1OZxhq0oW8RJSXr0o4p3sh4AZ
         cBCyB1hFmqnPCAUT7McibacyiQ7uq6kOPzX61uNLiyWR1uEsC5AAEzQ/BWAkEPwoF1NP
         QQlT4AVxdljnwS6M9uo1/kaT8AN7rVWFKdhI6ueelYQzDJoALUUXHE6ux70AVfKT2jYu
         adOScAIdGDFuhPfiO9JVprOkOqyLJRAl3F/viyoVMW7pYHBDQVf6us5WVVGrPqUxkaRT
         5EV/QB0768DM+DriYoFQ6x3tnILCjGPw1cnOheJdk2OCmqT3pnYt1kF64GP71Vx6J1gn
         oW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761198104; x=1761802904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVmnu0DcZ8PNVbYItIhiUlRCiDcnVxMhr+Gj1/Vdtvg=;
        b=HBy9vIPf62aZaKdT7mqowRfhXFP3UOWB6AUzaJK8NV17uI/fh0vX5EgudqpHs1wwKu
         GX9BZVoDhbymxdjBXFXrAfQZNVfz15NYEdFkdaFrS6CS9z9LrM/SvIO/jDXI/dsVZtnA
         EojPj3thkl+PR5bfWl2NXOy+rbFff0UL3s9PfCDEm42ciSqQSm7r3VKx61ZXz46hV1E6
         fQ/quKyteZlDG3IcXmTyn0HhSJFulsw3gKH6cSIjKS+3DrWCzObWmJZNyT5hseRzl6Ee
         hqsNECyNnLv6MmcUt+t5KPBXL9VmIJ3w0v0m4m+zzat8wxOlG4DOeYFAxoNjyT51ZV/h
         br/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTa59RM2lU9e4MdpBV2WO+KmJm90w5RgEgpAgg2KJtQ7gjEGM4jVYnSShPpRDvPCIbUu7VuLmXTdxQ8As=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSTqymZq06zLZLsGjmXIwn3yPsC2kaZd2yiugPFExGYXI2oNO
	vCeseEkqjuOeAaUWdNXMWdAxb9PI69rnEH6xLifUvE1NwqQkA8XA4Mh+
X-Gm-Gg: ASbGnctN7t9GpaqfQ8/5S+Trsr2WlL26drhbgkyGwFAsZtCIBn6JuD73dnepfk4ec7B
	mXY+9mTeLtNIPgEPy3LSrgLhTak5WepBUM7pI4VTKi3SnsR/PlNKeAeZ/PL56eC5RWXmuHvK1a6
	S9OHkPL1bXNROpYrjZitKAuKtqLHGZFBNiD++wzE1uJCZf70z8GpUujTIuf/nFIa5/zfaw7khg/
	1V+68cdCkUKlo/Gq+gLv5mRcv/YJnJjhpu3AeQOf3Sn5pMaaWbBhKiiyUyYTpd5fWIqICC4I5EF
	WUCeJ6fb1c8ASVgCr72Y56rEbbtRrzbaAspq21Pf/vUdXce+xatwg5AXxO1GnMDFSG9gzwyNuRw
	4GRmiE9VSqDIbkzvQQw55lKav9FbGhiZMHwBnFpIvNk8N5UOf28ZR/ujA9Elub/wde5y40z0+Zr
	Vccfb68gxwg/mMxlpflEJLTP08+waWVsxQuJb77yHuj9542/RvQlBsDao53UlmmnbWb/D8
X-Google-Smtp-Source: AGHT+IFvTCGfh+EzRAJlvDZiUcGcWmXgVO1C2EBm2Vftv1WhIVV0oVHchDQFJ2UcgQEiCnOaTQzqpA==
X-Received: by 2002:a05:6512:3d21:b0:592:f4e8:720c with SMTP id 2adb3069b0e04-592f5a712d8mr391894e87.56.1761198103848;
        Wed, 22 Oct 2025 22:41:43 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4adf080sm454893e87.18.2025.10.22.22.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 22:41:43 -0700 (PDT)
Message-ID: <e215a74f-4c66-4e8e-bb10-b90d782de2bf@gmail.com>
Date: Thu, 23 Oct 2025 08:41:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: mfd: rohm,bd96801-pmic: Correct
 timeout-sec length and reference watchdog schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Timothy Pearson <tpearson@raptorengineering.com>
References: <20251020-dt-bindings-watchdog-timeout-v1-0-d0f3235eb327@linaro.org>
 <20251020-dt-bindings-watchdog-timeout-v1-3-d0f3235eb327@linaro.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251020-dt-bindings-watchdog-timeout-v1-3-d0f3235eb327@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Krzysztof!

On 20/10/2025 19:52, Krzysztof Kozlowski wrote:
> The parent node of ROHM BD96801 PMIC is also holding properties for the
> watchdog, thus it should reference watchdog.yaml schema.  OTOH, the
> timeout-sec property is used only as one number.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>



