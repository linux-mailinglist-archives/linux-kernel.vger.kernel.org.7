Return-Path: <linux-kernel+bounces-756583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F1B1B647
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A56418831AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2F7274FD7;
	Tue,  5 Aug 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkXxV58m"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CA23BD05
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403729; cv=none; b=goWp3mu+USMNlwq5F6u3trYIdNXfcifpbjYkzcyvsu2Rkej879tYxZ0/uaJcPp+VNnYqWhGuEs8RzYGz4d2FXjcVEFzI8GkEA2NixRr622RRXr/6wFxEH83pzScdnHEEPsiWtupeccBg0z127zj9yqvneWxNzuw0afjgQ76SsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403729; c=relaxed/simple;
	bh=qJ8/taLQitUUIhdItcIzmqYdvaRkRtZ5nft66CxqrJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIQOI2bOC7YwQmk9QaNxPnagv//viwSrAjUhbCxqK55xTApf87UWYy07EK7ExzE3udY+ZtLluKy66SUE1hMZ+66udDy0F3iLKUO2l5bgF1Z0leR4CaeFiqGttBdj1J2al/cEk5Tn17YXbM+oN9QQi3P5XJOHwCFw/aP+6Ecb1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IkXxV58m; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459e20ec1d9so7210975e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754403726; x=1755008526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGTx9IRcvA+XXMryjjYziS8V7I1KGBOHgcBA5x6CYF4=;
        b=IkXxV58mRoeBnEejZQZNPLyDWUg2zoZHBVOvE3FoQ5pTlt0dZ1uHceJbl2o9sFE2I8
         +Xwr2Qal8V5YOZSb3RNZ9kcfjO+tL8w/IVWDyeVw3BU/FG72n3ItpBL9N6+2umiiiKuV
         3gYUyspWV9bUblX6g5gooBS8c8Po64+vmLRMOKGINRa2CckhECYLlzB65QIRDJ27rezG
         /shUsUYOYX5cuglUaxM3IP2W6Vbg3ec78JjULUYA677/T7IXzbO6c7Nkja8IU5S/LqPi
         +68XkNFkhIEhv1XayuZXbxBX1WBEi1ILd+YCG486+HlRNcrBygkhYkE8LzzSUt2BBZNS
         nMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403726; x=1755008526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGTx9IRcvA+XXMryjjYziS8V7I1KGBOHgcBA5x6CYF4=;
        b=iEiSLGK2N4S3qWZSSlBHBvOyw4QDF5LuhsSMuuxKR7rhwkNFShzNBA1e39Bb3qUd3N
         4GQQYNj04m33iz727FrwzCvT3w+AgfBE502oj9LbMoot8C3pQnNQvSh84duNqTlfwtXE
         5+wlHO9mw6HOUgk49tU+G4UdEKqf7xpdKLWWVxh+L+NZdLgybGKFwCAXBaVB454NHskB
         QL6cqAFDJ/6i0wphiYOIESDwEXjVORkrBrkI+IHCNPijEYH0sB/hBozk6FKhZaOHLJNa
         wjeysvpEqZeY8p+wyMu5oKYwXJuumrOCVQmynlVjhw5nGEbpigMM2P7S6dnWsz76aFZJ
         VFfg==
X-Gm-Message-State: AOJu0YyYPra126dKYJHlUn31un4AiQVbqMXlmHeQuJf6spwGxX8cIHf4
	aSfM3ODjYW/kkF4nT+VMHl2hqD17fN0HS1YuXxuhnkjHSAfA7rjw5X7Yvu2sW/sTCt0=
X-Gm-Gg: ASbGncv53hKn2Cw/fKJOjEQ0HQqUszXNkosKOVYWpN14x98QDd1cKCXPJ47rJskdze2
	AoKiJcy8f5cLDp/bhv5x8vXC0yfV6MhjcVroegnkrWx2lOT3IBvkm43JEOoIi+GWD6ZmCJFaVTQ
	9s0XSY7iDLdJ/5E7jDHHCjrUPogWE8/fExJ8q7++/BwGuNH7oZ6d6CU2I3gsqs7ITrrz/JwiikV
	rWYDs3IbkkrdiWIeXzQTpNi7mHuiZR8QkoJ7ZqJKCGAF0yurmYqNLjITh7sVdqfFVw/96XGrn0z
	wk2E70M3xVbkp2sKX+nzvS3+TTFoLjQiTuWiWwlSBx9lX2PClvNr6eww5Sh1PpQvhaPPHblf/jA
	vWJD9l5qdG3uOTpxz0m8YDGm+TV+U6sPfhdKDgF/i93cjmHzvkwbNLl4YguDNGw==
X-Google-Smtp-Source: AGHT+IEV6DBi7tmNMcfo0RaME5apz6BIXyI7tKs984BhJlf5Fiwqa5jF2xcznh1s6/UhxXv+cODefQ==
X-Received: by 2002:a05:600c:4505:b0:458:b4a6:19e9 with SMTP id 5b1f17b1804b1-458b6a03d43mr109999995e9.13.1754403726118;
        Tue, 05 Aug 2025 07:22:06 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459e3d37439sm10609885e9.2.2025.08.05.07.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 07:22:05 -0700 (PDT)
Message-ID: <089a7ef1-97ec-4019-9582-653d20af6a75@linaro.org>
Date: Tue, 5 Aug 2025 16:22:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/20] dt: bindings: fsl,vf610-pit: Add compatible for
 s32g2 and s32g3
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, ghennadi.procopciuc@oss.nxp.com,
 devicetree@vger.kernel.org, tglx@linutronix.de, S32@nxp.com,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
 <20250804152344.1109310-20-daniel.lezcano@linaro.org>
 <175440262896.1529239.4583136749439718490.robh@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <175440262896.1529239.4583136749439718490.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/08/2025 16:04, Rob Herring (Arm) wrote:
> 
> On Mon, 04 Aug 2025 17:23:37 +0200, Daniel Lezcano wrote:
>> The Vybrid Family is a NXP (formerly Freescale) platform having a
>> Programmable Interrupt Timer (PIT). This timer is an IP found also on
>> the NXP Automotive platform S32G2 and S32G3.
>>
>> Add the compatible for those platforms to describe the timer.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   .../devicetree/bindings/timer/fsl,vf610-pit.yaml         | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Missing tags:
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>


Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

