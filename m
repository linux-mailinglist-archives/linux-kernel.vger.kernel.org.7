Return-Path: <linux-kernel+bounces-846138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC68BC7231
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564F13BA79F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4188819FA93;
	Thu,  9 Oct 2025 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeaOoTks"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC591A0BE0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975118; cv=none; b=BGp9FHymETo17Cn2EmgJq3j9p4uvThAaJSO1O+r5+/z8Gp4cMab7kDV9YZWiGZyFmq2bhk3lCvWyCATTfNp4uP3BlBOlF1SLJFsSZP4S5XVCYCz8ViBpzO9fdHNqIjWxz2hrB1iWPOYEok7zEb7p/6+QemgH0jF9itPHKcKRLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975118; c=relaxed/simple;
	bh=cBbOyvyZ60m9YZe8t1WrE6nNLEs0DHt+yuPxFq4aEwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY8+JyEP3iT2ZlFs5/YXuIdWtLiT+b98UIy4ccmpjb5mivDrkFdviWN3dDW0h1rgn9lKMGsuQoLAwvUicSk8QvCEhanZ1u7T0dlP8MFmLnwTHG2LB5xl+y54QSnCTgCwLWLJZMWWIcSWuQEc5kuzAXOJGzsV+KzG7hWszAn9A5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeaOoTks; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7811fa91774so383662b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759975114; x=1760579914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2aGfciQxVmbM+4l+bNDs3L4I0WH01Ha6lKiSJ74aDco=;
        b=OeaOoTksmUgF99l4uyLBl/lvuXiKLe0VALVsZhTF3+CtKWeJi1XOnbOCdX6NE4Mv0z
         eajM0qNNFgDr7cafrhMMOqnPygCCzuwGMbAyVC1O6n8HkFO4AYsbP/Ghnkdjge73Eu//
         hF5LNRmEZEmpsZKSu/Kpw4Do2qvBpm4tC4xULLE1/+sbO+53EuPgPJC3SfuuUjIbQLbu
         6hYw90ZFlvMgTB4n79tB8XQuhxPorUQLDsOL+WGqz1D3QoucUh1K+iLxCsjlFXjf1W0p
         riRpXEVzOq8SxWf2JPB7KZXe8s8SSFvmcRx2ZL2rtJcVw5wnwa2LDUcxMbZiDAOcJqWD
         UCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975114; x=1760579914;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aGfciQxVmbM+4l+bNDs3L4I0WH01Ha6lKiSJ74aDco=;
        b=fUsUcd2Z0epZT8/8gevo0vM5aen8jSwPfkzdNRBnae143xnwfCkqox26F9C1FFnZ+i
         A8o41xs2eo9bMJ1tsEVvRezU225MQ8hQFSYO7qjC98QunLLFlyF12D8j5JYEiImt4mPD
         WfcCwQJZFgEhLiqbeW2OM9s49HBC322glR4zskFTo8fLGi5mWJeueKLUN/EW6oOULV4i
         nRK2lmc9mdmzlw40l97m6v7H4+tECkctq6m6fACOMuDWev80xT+kv1By0KXEa38L9Sqe
         FqMcWMKOLCqBtlAHwaoFemjOhQiXq29S2c8vMrJV8GCSlrmA8uJh+oO7Srw9D9J6pd6e
         otYA==
X-Forwarded-Encrypted: i=1; AJvYcCUBDV3KAMCe/P36J1VN5C2CNcgiSdIffEjFNjyB5A3OMD4fNGa/lruCHOQwvkZsjc8/ipda/IXOAYgRzMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvesfSwXI1s2gA2LTiRVEEA63SJg/bWk9cRWOvx2iQIOfulqgn
	aV9pFJtGLMsxi11oLhHjBFM8FOYBf7q93h+1PZ5sd/7Z4TyQlwIYgOIz
X-Gm-Gg: ASbGncuplEyDTXb/hrOis2zinluSDk84OnJhAmfLqgFruKJsCAl2goPlT8EkL/rLwzA
	ledUe6UBNvEd+W3qz9oPutoA2xJrOVf8umDKqLakPMon+1OqUf+oEgq0qaQ4Ra7+D47nx3QVOxl
	iS74TKXzYD+6OoSLQ7y4kQPEiNOJP4YVFYNPT8OqfieRz/5+zKBnYRDnzFADvlvJ7FZ33ELmPCn
	qToudkKAOjvYHEk2YbgkpeY6s/IR/HXqBHXoPsPpkoyYNKG8r8zMJI2nICb0RfzUibKS9N2neBc
	mC1NZrpi21wtXIetFYAZLqi3OvFsGQulDFDkYsHLFOdQmshw9NLaBuqtojWX2Trvmuep+q1ZYhd
	fV40Lg9/G035P0cnpVPTMyDo7kF8ASZ/v6qJCEm7UyZmaKhzqbMCpKAwQd/TeoSSTNcX0SE7kMo
	+lchKZjriSISx2ycqAUgXH/D0nQ3H7sw==
X-Google-Smtp-Source: AGHT+IFRnXDNLeO6K/K3wthKcVdDZ0k79jHMKp0eRtg+qp5MtCtdWauMOoFNlF0VJLS/II4OcfTVwg==
X-Received: by 2002:a05:6a20:3956:b0:303:8207:eb56 with SMTP id adf61e73a8af0-32da8190b86mr7638215637.5.1759975114450;
        Wed, 08 Oct 2025 18:58:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51102259sm4986725a91.7.2025.10.08.18.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 18:58:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c7d01ff6-0e09-4ea1-8c5d-59be5e3fff16@roeck-us.net>
Date: Wed, 8 Oct 2025 18:58:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] hwmon: Add Apple Silicon SMC hwmon driver
To: James Calligeros <jcalligeros99@gmail.com>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jean Delvare <jdelvare@suse.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org
References: <20251007-macsmc-subdevs-v3-0-d7d3bfd7ae02@gmail.com>
 <20251007-macsmc-subdevs-v3-6-d7d3bfd7ae02@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251007-macsmc-subdevs-v3-6-d7d3bfd7ae02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/25 04:16, James Calligeros wrote:
> The System Management Controller on Apple Silicon devices is responsible
> for integrating and exposing the data reported by the vast array of
> hardware monitoring sensors present on these devices. It is also
> responsible for fan control, and allows users to manually set fan
> speeds if they so desire. Add a hwmon driver to expose current,
> power, temperature, and voltage monitoring sensors, as well as
> fan speed monitoring and control via the SMC on Apple Silicon devices.
> 
> The SMC firmware has no consistency between devices, even when they
> share an SoC. The FourCC keys used to access sensors are almost
> random. An M1 Mac mini will have different FourCCs for its CPU core
> temperature sensors to an M1 MacBook Pro, for example. For this
> reason, the valid sensors for a given device are specified in a
> child of the SMC Devicetree node. The driver uses this information
> to determine which sensors to make available at runtime.
> 
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

