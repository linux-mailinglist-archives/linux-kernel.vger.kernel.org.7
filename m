Return-Path: <linux-kernel+bounces-733348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F70B07374
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08137B76A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA51194A60;
	Wed, 16 Jul 2025 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Etw/ve0h"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F51581EE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661826; cv=none; b=POF8dkmTBuJ/Dk3K07WvDZUjv3DfLtB3bZjfwHWUjIHeKlLWoMRk4+ISf0tG5xH1ojbUwazI6jPcYKPgAM1VX2d8z1kcw15k1dQBTJ+cKnpE/gvFJEHLz+EwM8+Dd+DDEG2/0AoVrtXcktQpk3BF0KdFSNsQhA42bwvREdgCJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661826; c=relaxed/simple;
	bh=tZSHvE7TdwzlP1qobY35x/N6TFretv4ZlFe9i0nhrMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxbCSWF73tCJh8MGEkgFqKngAzOaGQXUj7/VwqVqf11BtSXKNM2xqzlXw3xq55a1u/ORQWgHi22IjANDf8z7sKHvBr7AZDwkEt7rs62us/I29TJV8m5VWBEhQD0ZpBx6oQ3E50B/46SR/7LpU0NPZWpSlpkLCs14ZGRi7HqdtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Etw/ve0h; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4e57d018cso872006f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752661823; x=1753266623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6XnqCTUVDxXqLw605VpQiOmmAr4VEm5DLMnQo1CAZWc=;
        b=Etw/ve0hLeRqvik+eTi3Obb6UmcnU5VMb5TsKeDs1pOHtvO8I9nL8dVSe0gdgHk+to
         yWebIGVxdExcjazIkJeJLBCDfrZ1LVhkOVvuSF5i8QaMJ7QcYQAlfiXsofEqzeYHbKXm
         fI6We91gdYFwtpHCy7PYvSUYo4GXROoSLhNTQvqkLpUdaLA9078XcIYalP8p2j1wiZpt
         IwRHtIVsOsv6FSKrYJen+9rtHOkimIOMQxGgmA/cQC6R+2HYT9IxyobGuWnZxdgUCo75
         D4b8DPHSJpIGqOUKHylNibi4nEvKopkGOw0Pi0xDC7OldoO3SYLfiIQYCma9rpFQZg2o
         1pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661823; x=1753266623;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XnqCTUVDxXqLw605VpQiOmmAr4VEm5DLMnQo1CAZWc=;
        b=MQ907z+Ik7EXImlxmkNF3km+e3n1Rh1Xi2FjARsZWYTqPMFV3HlNeUWM5wXjr9DeAu
         NSefOrlVYVDHohOY4USYeYKVgiq6XrYSrHrvb2S6Vau+cCKUNz1L9+xFykZLnEdeGz4H
         FgRSryqGDfcjKEJ72gIz9FM7VUO1ys7uUwnG6IzkfARISZcHudUCb9yxwcmkctSbS0ZL
         Ug3AKonuHZHmJ/FpTut46dS8DB2AZ2aNXimt1Mo/ae43P2aowMpEftXyDfpsnQtNFwOM
         0IuO+FETii3+WNyvO/6pusn+yK1raz/PEeWu4K+JjRJ/NjH0pGTGq85YjTr4naCnhykm
         jUfA==
X-Forwarded-Encrypted: i=1; AJvYcCXfbTdC0m0cChbOUYkzFBZfKoslCsmhDAyeEM3whUCFS8dHecOT4k1kItE5ORERiSUmlhL9bWobvrlrrAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNUXoVz1wbHrclt//j9lL+T1entH049+3e4VYeV3IEhpYCqv3
	YirTbOQx1TGNsIzDQ8WZ+a9S1hFSVJoykZdR/bG6ZXHVvFdZ+vaTYBebJWkbClunRJ0=
X-Gm-Gg: ASbGncuTsv0a0MnEGWj6bFe6SUl1ydmQgTcPn+ngDtog7ELXKhjoVF223MB0LhtBo88
	GZtLqrB4R8evTFHjfEcK4cYEGdgu3b8LiWEVLm2J+Jh9UaBkjhECQt8Kk7a8+9SJEhwXE1BwqLf
	2lG9RlAh5eJA38LbSqkY6bfMdyYUhuGK44aiEqrGEGbLY9krw8uyLDshw41AhBdRfkPk90gh9A6
	WNhrLpxaVAvk4JYRpHrhggTC+9AjhX8v/VJsBgKIzLO7iwlTnuOLZ3clI4YwkVbMcgl5bc6H3sM
	gGdyUiGJZdjhqa14nh3oh3WEuyzgjGF2XCGWgiur+mXKdGvt4uIhQyRNOHJ8RpvuZ7LDvmp8upE
	kysT/u3fqJeejxrSeY5xDCqi6CJA5WYxIOzYZAsAa0Q==
X-Google-Smtp-Source: AGHT+IEWEOxnRmsY7CW6qzxqOxUEAfhDQBThVtGYsxYdHnrMvbBgNTYPuxWQrQr9DcPA8NVplhCfqg==
X-Received: by 2002:a05:6000:40dc:b0:3a5:3369:52f3 with SMTP id ffacd0b85a97d-3b60dd4a834mr810416f8f.3.1752661822704;
        Wed, 16 Jul 2025 03:30:22 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd15bfsm17790152f8f.19.2025.07.16.03.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:30:22 -0700 (PDT)
Message-ID: <8698f842-a464-47b8-8c47-97cda016e227@linaro.org>
Date: Wed, 16 Jul 2025 12:30:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 2/2] arm64: defconfig: enable Maxim TCPCI driver
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 openembedded-core@lists.openembedded.org, patches@lists.linux.dev,
 stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sasha Levin <sashal@kernel.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>, Arnd Bergmann <arnd@arndb.de>
References: <20250716102854.4012956-1-macpaul.lin@mediatek.com>
 <20250716102854.4012956-2-macpaul.lin@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250716102854.4012956-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/07/2025 12:28, Macpaul Lin wrote:
> From: André Draszik <andre.draszik@linaro.org>
> 
> [ Upstream commit d2ca319822e071423ab883bc8493053320b8e52c ]
> 
> Enable the Maxim max33359 as this is used by the gs101-oriole (Google
> Pixel 6) board.
> 
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Link: https://lore.kernel.org/r/20241203-gs101-phy-lanes-orientation-dts-v2-1-1412783a6b01@linaro.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/r/20241231131742.134329-1-krzysztof.kozlowski@linaro.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

No, that's not a fix.

Best regards,
Krzysztof

