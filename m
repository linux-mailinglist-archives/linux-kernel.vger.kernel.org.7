Return-Path: <linux-kernel+bounces-861526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2614BF2F60
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4AE3A7AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB7F2C08CC;
	Mon, 20 Oct 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="nhhMIwRC"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0341323C4E9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985438; cv=none; b=YdvEQajM1M8nOHl239dmREFtjRT6bswB2MtYapXL+O2gN9JuAHSLRGOTRjMhjM+N9tXlQFBLlLduPZvW+qQb2BnFaIWGT6LsK6Gi7XA8JQ12rGc7SLJ1LQLVhloWi8ynekATKEgZHTmz22J0YMFHuQ8YhGEwIgh5X/MRPXTaTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985438; c=relaxed/simple;
	bh=1vFXt6XRVipPdMLkxRp5oxg38DR886N+xgXmYyeXzbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyNEW7PYwQDU9OS9YGQhgcIm+uLTyNhjG6nCqMllJrCLYEGFgosmEsP8uWQH9wdAL4l0yO75b3XxieKd4Q6Vt4MQ8DSxIkc6nriEsaFvPwKI9EqNmQm3HgC1V7hujUCu6MfrfX9P2KpRAsPkAeaAGCfHw1j41/pGSS9ntOI/Jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=nhhMIwRC; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430d7638d27so18144215ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760985436; x=1761590236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jr/vYXNnHg5mvV0vPYpieCO6Isu4juKQ+h7apsb/fSI=;
        b=nhhMIwRCE0g1nky9C1Te47U7tSWrjASdLQaabFTv5ct3taXghMHTI6X6eyBfmV+Kcd
         aMAicmtW2JNX/1A3vJ8tIw68AdiW/v5mzyVSOuUq9DnkCZcNaLKCZZLxqKCOqjrL+Q56
         BgRw4jlHQXKIkL6nDwSbQQvC0VKfJ30/WIphj2UdSXg30PXgVEgSAJMQpOSlfzIxWgxa
         inH6o+MLpnKIzuiZGJqbg6I+Foit96pCWurCA3PV6R1SmB22N1C7GNTVCOTmrJsVUkQY
         5epO9ZJA7M8x9EDdNUlr9Iv1qry+0lueILCwiNy9VRrTOwOLgG1Q0mid9NLAukFx5LSo
         bYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760985436; x=1761590236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr/vYXNnHg5mvV0vPYpieCO6Isu4juKQ+h7apsb/fSI=;
        b=NIqAhfNcoQT8yrVtR1zJ46XGmhRmHST9de3Cq6LgvKyMGKJkN3BYOIbJmfZmaoF7AM
         mOGtEzQKqUf8G1R13BqiARmWh0rMF02Gjp1d9C+5UDgUqemSLm1RgVtN0D0leXr3bgEB
         09MgBBag+7VH1FFw2a5HhLi0Ssr9ymFSYtNfFoMf6DFNkTIyY3t9aLaaVGXd0SIZS6o0
         GJuO14/zGk0K3TGcCi+l4/41Y+70GJjph3aUvFIdlAMC4Si5YMOfkSlGgrFruAvZ15MW
         kq6RvCTQq5t8CwFMu1DQsoHskjptg/PgnvXhgrElZ4VSwYDoOIgi4ZYdYKvOfjxQ/xad
         3AJw==
X-Forwarded-Encrypted: i=1; AJvYcCU5lTejCOipJ5BcadU2mnoTlWdDsK+WOotybDuUW070+oF7RcPiNvbQiq/7a432a6Bt4R5MpHpq+SSRlFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzfXqae+aDMNho0UrZxXmx2geJ+vpmOz3dqXenKyqZNThpDgcI
	KdGJgBSbtBJniXkjvq1+cgche5V+SNwdReVsQKtbjHbYUaG7gSbcJFMvEp792K6WuE8=
X-Gm-Gg: ASbGncvMoExrOAch9BIu+GzOy/nsNjet54Pb05jlbtRRKG5KBlzqaEQfN/4n2EN388t
	EcD/pt6Jo5sO5sc7orLnOgh20I2Hq2ZlQKaMYhbJf/ol0u+mR8MIjmWDeErfhwXTSijbEdGwFz0
	y84HxJNro/iAT+L25A5u6H8eORLp7ICM2a50VeS0yhH1BxQXmen2/qKBoDE9lDc8xrwx1lr49Hi
	/EoEumaJeauflfLOHgRmogOd2O7v0eIsIbO11cea9QsPQbUaT90nXzHbzCaEJSHj2tGOxi1gbhO
	tRyGLcRN/5kwzJcGKsG2fN99DnvS7IfaLeAMRPx0DwgjqgwxGQjrLKw9RZ25vYScj367ng99FdS
	VRVJKq/2KRqxA43w29wTNzqH0NLI+rOKMcw3b5ysWaHOE0lgLlEY97O60U86fK3FecMENK5zTou
	DrsVxyVjblyfcf665NbSb07AkyAacYyQHo4YEKi8sQ63d9trKR
X-Google-Smtp-Source: AGHT+IElNLjj7kkxLdaR/W624I/459FfOH+dYJAUUw0iEYH3D4Q87WRcXxpP//DJVpw9S08uE/P7Hw==
X-Received: by 2002:a05:6e02:1523:b0:430:a973:7e53 with SMTP id e9e14a558f8ab-430c5294ff1mr183507015ab.21.1760985436041;
        Mon, 20 Oct 2025 11:37:16 -0700 (PDT)
Received: from [10.211.55.5] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d070ba35sm33475995ab.10.2025.10.20.11.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 11:37:15 -0700 (PDT)
Message-ID: <e40f28a2-960e-4002-8384-d99343b4fdd1@riscstar.com>
Date: Mon, 20 Oct 2025 13:37:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
To: Mark Brown <broonie@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, han.xu@nxp.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-3-elder@riscstar.com>
 <20251020-blinked-primary-2b69cf37e9fe@spud>
 <b28d71c4-d632-4ee5-8c4b-270649fca882@riscstar.com>
 <710c36f2-3551-4738-a965-f1564416348c@sirena.org.uk>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <710c36f2-3551-4738-a965-f1564416348c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 1:26 PM, Mark Brown wrote:
> On Mon, Oct 20, 2025 at 01:06:46PM -0500, Alex Elder wrote:
>> On 10/20/25 12:39 PM, Conor Dooley wrote:
> 
>>>> +          - spacemit,k1-qspi
> 
>>> Are the newly added resets mandatory for the spacemit platform?
> 
>> This is interesting.  I never even tried it without specifying them.
> 
>> I just tried it, and at least on my system QSPI functioned without
>> defining these resets.  I will ask SpacemiT about this.  If they are
>> not needed I will omit the first patch (which added optional resets),
>> and won't use them.
> 
> It might be safer to describe them, otherwise things are vulnerable to
> issues like the bootloader not leaving things in a predictable state.

I mentioned exactly this in my message to SpacemiT just now.

And yes, regardless of their answer, you're probably right.
It is *possible* that these resets must be de-asserted, so
it's safest to describe them.

Conor please if you disagree with this, please say so.
Otherwise I think I'll keep them in the next version

Thanks.

					-Alex

