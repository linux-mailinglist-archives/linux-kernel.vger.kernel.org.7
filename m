Return-Path: <linux-kernel+bounces-782974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BC1B327DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149A91C22241
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808D22B8B0;
	Sat, 23 Aug 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYOgm18d"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA123D7D6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755939621; cv=none; b=a2lDo30eAKVSjNnvHEGhLBmnBZsorAe2UpnFmNVUsraTTA4NCxGQ22n8MwSMbcFz9/YM4yDBzEZeSxiqT2r5jDw3rLyWQTnxMBSwKccTkEvWv2zp6UK285IKSlfpTDnWmBL+NMQNuOkd1jKjE/7zC+CnWLZ4az85/d17xWwBmFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755939621; c=relaxed/simple;
	bh=FudAgAKSc+eWc2hWehqLWzQsASEKKgo0Nzb21vtErnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHJkH61jFb4NDacr9mj9+ww1ociuHnkIMXQ7X3SzmUHorSnj4uFLbtFudCaPJEz+b0VR1dydxwDGKlYN9v24/m2SyhOoFxIy0ZKcgX2vMcQ9qksmDArweEcgha1wRzZoNPGHCFJity/CLNBmy6MyXGUjMTfwNqEZ4ZhKJVi0rk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iYOgm18d; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7aecf92so49471866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755939618; x=1756544418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FudAgAKSc+eWc2hWehqLWzQsASEKKgo0Nzb21vtErnQ=;
        b=iYOgm18dIxJnejFqrAZw1FyzuU4Vk5UU07A/k30atGiZcwPsHrJ9nVlypFUW0jPs1n
         KfFU5tF/Zzi0+VLy9NF08WaDYwK1plCWKyPcZdOaUSErvdXOrMuGyArVV3VF9rs2/uwn
         mhzjkPkENP6G2E2SeYEY5Ey6TKSTx4KXs6Fx5Av79W54xLuF2rutD2HuTRKEt1dx4gMO
         x4fdFV7XF3lqWNj/KVKGlW1ydSI/8PhjuTc2E+F7GtsLRsc8gYpR2CXdwLBZFTZZzkiy
         FTbswGOsnGf4mbmdg7NRk84Uo8gTYZTJiNfuJ5iSmi0dIDukeIuCyc8pq2IieN87YFRQ
         /qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755939618; x=1756544418;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FudAgAKSc+eWc2hWehqLWzQsASEKKgo0Nzb21vtErnQ=;
        b=YOjd4z9dzt2At92BfbCBnYnyHxmLy39LZq0PQdERpWsRdDrE9n0w3jYPbLI/Jtkojk
         n5TtCv6KrBUdnvhpkDqwKg0UWQClfHMew+YF6zdWwLLFyEOyw1YlS9HhsnHXo7hfaGIh
         uisjqc/2SGxEt1AkrhMini3NLCuEhHkcayR7HUgDInw8KbKpDcu/CIpjeTHyBev0kKfe
         wSazJg5NQ6miVZ4JVhfjPGsVwrRXn7V0DUnxas98twakzZCCULQffP5TTJFie+zppdHx
         FYvC2n3z+0KL4jjDZw6RQSJJo3Y8UBiGa5qahh2Pbu+CluyInHf9uIJLbz2cNvccdA0T
         p3nA==
X-Forwarded-Encrypted: i=1; AJvYcCUsxDxWtZQcmK426tEDE8mD4EgzSa0Xn++47KjajHlPgn11gO08AWMQbFxn0NGkHZyVuukur4Yg3v87ueA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvj563dEr67tisrr1e+cfq0EyTcqToG6hR0MYj1VGZJsuaX16u
	2M6x98LYN5gjL5K4qez77gvI1avcJmLDVCOvnYUeH49mjB5TOX11daUuCGByClrdyvQ=
X-Gm-Gg: ASbGncuO/584vfrq+ATRpej2v/+xfXINnVj4mxr1E9SAOinoSn079/ulIj87CJUXt72
	ntLDbuJdxyhFp2FzZEUORQJj2WgToWjtSmvhbh7aUjJjwSSGYe/1Iol8vVwqhOddzq1UPeYncri
	hsfLGSPvq2UHzUNBXbqyQ4XU0gUJrVpgNaQPd3VHyD+qC/zBx57sQVPMdaCPQfPSOTWdevzjcDV
	1fA/1ybKUvSvi9lZx5/jJjdlTbsZHh6TpS/cxfE/efNfdBSRWYS42MKAxKUhWzIt2bWBMwOMKgB
	jJttqVWzV0WtUrVY+Gz3w79vUFUxYAtrdGarE36HeZq9jZSz5kbMBXxi+UzKZ1VzQzAIsOBnLey
	l7OkVQNAnTfxbhno/xP0Gy3gS0Rz8S4a6G68yY+5yXPQ=
X-Google-Smtp-Source: AGHT+IFF6ycqlUrRBwaFvrj2Xr+Cw2HS4eO7rMsYmrCv8MGa2LJQxfuJYSOOsmb0nfzRpn4jiuGIxg==
X-Received: by 2002:a05:6402:13c5:b0:617:b5bf:f03f with SMTP id 4fb4d7f45d1cf-61c1b4d013fmr2702207a12.4.1755939618290;
        Sat, 23 Aug 2025 02:00:18 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3174f6f6sm1205522a12.51.2025.08.23.02.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 02:00:17 -0700 (PDT)
Message-ID: <a20d4a67-abef-4f97-95df-bcbeb0eb7d67@linaro.org>
Date: Sat, 23 Aug 2025 11:00:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: axiado: Add missing UART aliases
To: Harshit Shah <hshah@axiado.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250822-axiado-ax3000-missing-serial-alias-v2-1-54052d75467b@axiado.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250822-axiado-ax3000-missing-serial-alias-v2-1-54052d75467b@axiado.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2025 21:15, Harshit Shah wrote:
> Fixes: 1f7055779001 ("arm64: dts: axiado: Add initial support for AX3000 SoC and eval board")


Completely misplaced tag. Please follow submitting patches.

Best regards,
Krzysztof

