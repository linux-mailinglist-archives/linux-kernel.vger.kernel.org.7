Return-Path: <linux-kernel+bounces-730475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2577B04544
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E831188860F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412025F78D;
	Mon, 14 Jul 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKK4RAHI"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A0A256C9C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509549; cv=none; b=lemJ334qQv5Y/Zq4IJkBV5u1sHZxQepp9gFFI13ycuLzScuggxGoKlYn/+nsaxuEfdjiEU5jalmmFRdkn7ngoA4jeJjlMDDbQM+fQice2eP6n8yoMcOwyWuJ3J8kn58QoaxZY614bDUm5TQSuGK3JV6Zff8xINvwui5FSSAL4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509549; c=relaxed/simple;
	bh=Ud5cVeqCrhSqByxBQEPlGgrKvjboJ0YYy+W542jSiCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B79E61cyj77r4YPGbIR8ZEP0Mr4Fkc2BIW+f9hcQxTgbRfRrzQA76vF+Bkr5ZZy/QPkY5c1J6SbPhC6M4Bkle9CfeKhESOZmTwkEl3x/sIN80rmQoQ0buJDIlWyJ2yg7ETqvv0Uw6zh3gxNEMFL3GbPCWSo9HjagZD0y0a79yBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oKK4RAHI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso4397905f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752509545; x=1753114345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzg/M3LkGVFpt8ELQhzn2f3Sv5jfT0EMwgEqK6jhlaQ=;
        b=oKK4RAHI/c2qGbAdUDrRmQYB4lEciQUuRRPKFDT0Gyf3eRGykwEsQy5y1l3/L3oio1
         ro9Y43ncK/+ojdNT7pUVDu+xVsrmSOiexmJx6Sj0UdC34rGYVLlgxwuUwU5dQ9kyeE/q
         NkXpATrnJzi6LvCpONOim/Dpx00IVE5mQ7bZoId8kNNAouUbtbwKp1zRzUaqezGQFger
         gzGgDzht+9Ko0x4gUdWIl2IU3nDnTidYbWucfrSmgm4fQw+03pgriJk9v8qxm8RN+kOS
         Q9RW+Qc8+bLWdKrIvJrzyIIBB90PDQ18d1Ny+lX9T8hcrFVz6sEmrVH/XZmtygJ/RRvw
         nbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509545; x=1753114345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzg/M3LkGVFpt8ELQhzn2f3Sv5jfT0EMwgEqK6jhlaQ=;
        b=vxRBW/V12zl6EvCSS2yaNuytsQMorQUMxwGZT+v39GVqDDO82Es/AOEHH//6l2KLX4
         KNvrgQD9OFt9iTuvfY2kdN/DcwsfZQuk0yfRWeq31SRzGJ8a2sdEmuYrQHUtldNAzGx/
         rtsxx0PajD1tELz7WkiLxIJO1ZlBpIpkrvL9etYaCkeUJ5tHJNycBYS7tRa/KmVCFe5i
         hebsYYsGsVCFDFGpVz3deV+lNpHmF+xNDd4/1lPwJ3URfxHMEj+LpDKc8/C7Xr+So0Bp
         eBWV0m9DrOmGIlHDAYUTbXLgkJ2/K851h2pjyZEsE3flTx1bs51EPls5yhKGweeLUp82
         m3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU13RraUiiaVWKD69K9rie8hGT8FvdLUIjH8BdrVsYaWB++M4td7oUWzxUHlLIfGC+UyxsIt07U0txGV7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFYC9lMfVG0+Vyk7BG22WYhv+qqoU/OWcTQk0ovqOVGmOhOxIa
	6cLDAesodqH6bipZpjo6DNGBd6Y7MxXlb8FwXx8m5dpemRS03gd0o1VnKYQyuu+TaFM=
X-Gm-Gg: ASbGncu0OrZcOg4Jp4AAifK9smXmXDoYIMtQ5kolxPBwnE1c+yFO/3w0y+Pi3Gefm7o
	Kf5F8VPsQ1lIbtOwg+KuH3dx27b+6YP7/KUVjn8DAsHglRu27lClz3Qm33tV7sVl21kWyEx2IVo
	SgqawwjJ9cqhB2dobm6t60u54AZiE9EMf672VYqIYrujW7YFyvWl7vl66e12OKJQbXtCNWECGui
	nt4SA46DJlkqA6Cbjq8ixbwICuOwRHh0080pZkQvYGZa5GVDUkhYVskIuvpH9Y8fj4/nLM8SlhM
	g3UosA+X5YFw5M3k+N3WeaYV0CcIgAhrUAYDj5IxYUO0OvmchTVUZ6Mf2pcjkuuxm+WRF54mW45
	VNuq8f+cBqFJGxJqrPJX4FZwjBJjSS/+1fZXhTay7ctQnT0PB4moXSPlt7gREOIksDOBtmhkoY0
	6iHDIoRQ==
X-Google-Smtp-Source: AGHT+IFVO69NK6TLVDV9V9ARXGldGhKQ7IorXlDR8Y5hpNvYSeqRuAaCbC3iULGdQkY9+PrDjKAl7g==
X-Received: by 2002:a05:6000:2181:b0:3a5:52cc:5e29 with SMTP id ffacd0b85a97d-3b5f18565a3mr10560074f8f.7.1752509545082;
        Mon, 14 Jul 2025 09:12:25 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:151f:275b:ea0c:492a:7f48:847e? ([2a0d:e487:151f:275b:ea0c:492a:7f48:847e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1fd7sm12606620f8f.26.2025.07.14.09.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:12:24 -0700 (PDT)
Message-ID: <ee1dd7e4-c34d-4c94-ab44-b2425adad4e5@linaro.org>
Date: Mon, 14 Jul 2025 18:12:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dt-bindings: timer: fsl,ftm-timer: use items for
 reg
To: Frank Li <Frank.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Animesh Agarwal <animeshagarwal28@gmail.com>,
 "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20250523141437.533643-1-Frank.Li@nxp.com>
 <aHUhLSDQ/vdrg3hX@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aHUhLSDQ/vdrg3hX@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/14/25 17:24, Frank Li wrote:
> On Fri, May 23, 2025 at 10:14:37AM -0400, Frank Li wrote:
>> The original txt binding doc is:
>>    reg : Specifies base physical address and size of the register sets for
>>          the clock event device and clock source device.
>>
>> And existed dts provide two reg MMIO spaces. So change to use items to
>> descript reg property.
>>
>> Update examples.
>>
>> Fixes: 8fc30d8f8e86 ("dt-bindings: timer: fsl,ftm-timer: Convert to dtschema")
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Daniel Lezcano Or Rob
> 
> Krzysztof Kozlowski already reviewed. Could you place pick this one?


Yes



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

