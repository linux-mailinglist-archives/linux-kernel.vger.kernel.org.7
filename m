Return-Path: <linux-kernel+bounces-758964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5348B1D651
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8D165A1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B3326C385;
	Thu,  7 Aug 2025 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvkJJYre"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6891F4C99
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564737; cv=none; b=XLE77uAkxWRmC40AXjGC5Z9cA85kTliJLCmdZp6gEWkHJ7Z4CvGHg2yC8gcjagC3NDymw1jKWeg9B0hbw15RofX/9JNgXoXhoCOM/QyDOtPxEWHT1iRr48o8W8H1ebGNSw6IgsCBv7dfT37ubK2KBcNgJ2eLVJfT5GfTOf5uFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564737; c=relaxed/simple;
	bh=LFyGmIQMR58Rs4TZaKfP31Tc+fGtMZOG3Ql12fY9lU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFA8dO7sbdwsZDLcqXnvPYbda4Pb3DHbaHU8uGeu3fwDvx5aq4SeKLJWlDTZzDDfxMKe6BdJ+I3NRyIpTkQ/Ol06dChs6SFon+03dDx/g/8y66Hxsks1lqtQIeRlpgmGe1SsIIyiNT1WYObbeKDQbHvIYoNrrL7hxcImRZ0a6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KvkJJYre; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61531c16c85so92199a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754564734; x=1755169534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LFyGmIQMR58Rs4TZaKfP31Tc+fGtMZOG3Ql12fY9lU8=;
        b=KvkJJYreQi1u/SFeE9Y+N4jPqPUvpXdB6tKavDpAXKFOH99zX2r0iae2f0N03mj6Vt
         UFYy0D4PaxuS49NyzAskKa8Gtvmg9saDs3fFsviuE9p8XVQDjFRIr25lchHQGkpb3uhy
         kS8F4ZWaJEbGAbnDsp9JrnbMpo4DJJqHWn7XPXdtukiiPc+ttfLV7S6QGG779pyxbGjX
         uZtNpumIcB7eZv+m9KYaJoUbBkDVDWvqefQj1iaV/LEB+Tznoi1h3WZW/j4Epkuj0hhL
         4L1/kirrzMjtrHnF2c8VSrmo2vYcSm731a2w7nDzQj8WcBzwLS4UtoPhG2/6M6jcWpZF
         R8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754564734; x=1755169534;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFyGmIQMR58Rs4TZaKfP31Tc+fGtMZOG3Ql12fY9lU8=;
        b=s3RrG4eQ+9oC5r9hksvDEOyTPevp6pwIp8J4sHxgbNzKpZv9ZGYYMPZW52CIJ43d9u
         9e2Nrbt81KBLvaaJxnRj5yWuoD2SvCOGMNvgMbwM0krhCg4dgd9f02eCupZzU2Xii2eq
         lcUg2My8T1xHlnP8QmN/eGZWdGksNw4voyhgB+n6mHLbsYgn6ygxJcCsgXFIQQNwsIUx
         YafshwV6Fpk+wrhPr3jaLtZx4lAZo8SY+eTtvLPW0RvFlek1a2zDMrzZYO0FTejFGWxL
         ZoJ7/Pg3OcLZ4rKQ75n8cHILyVLBgBY1x4MnCPVI30dUi5/hZ1WD925PvEBRv11jHTng
         2vtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFvgoJZtsUor8ZE2wrmHvuzG3I0/2YBxhuc4UcPUU2B6rxe27VvePQ89lne15CxfsIi8cXcbMQYbdAa8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCiYaaVoVI0j2atCc69j76kUHHE2tv0UK6j2N87tPMTiFDjGU/
	bJ5cij/I0ha+LZHpiBPlCfCatpxVjRqUSQopBPaOuSmAjzX7GE0H1e1F2WuJgvFqxH0=
X-Gm-Gg: ASbGncumgDcD3FcV7Ss59+57G6gYOgc3uG+dLpxhWNgDAyZT7ChCAOncb01+VPPOy5L
	y+heb6ot71z0/etXwH/vyfF9+wf0oTv1PieYOCXuV9cIZh917zQkAhtlcx/bZnYE9GBEaK4TrL+
	FYTTXJITqRQ+0SH+UBKtqbk6hI8S2a+5OCFteoPqNDb2ynBuaxG4KLCWVfb00p7gCxTkc+1BDC+
	CQXeLeee0yuvWH/SCNMGYwyK6zI3lG1UBII68SwFM5V/uuWOTWfAXSOGAoGm6kb0mixUVI04LvH
	BDEnYGoD5LpkRGeWqyX6M3hup3x3IuBIQfJKQymeqOTLHZiEgSa0xm822durGkm2RdJ9+/Z9xbZ
	4r18fzuCfJPRZsxiuQbia5WR77a2mipmFJgwyC7XWz9A=
X-Google-Smtp-Source: AGHT+IG0MGxUcNNzxqOIwu8lt3gGqI/Kl3a4dy5p1ccfcQ+CYryVnARUENcRNCNP8MHLSG+XfQEzYw==
X-Received: by 2002:a17:907:1c89:b0:af9:3397:ee9d with SMTP id a640c23a62f3a-af9902f5784mr239225166b.3.1754564733615;
        Thu, 07 Aug 2025 04:05:33 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af986a477c4sm439667766b.56.2025.08.07.04.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 04:05:32 -0700 (PDT)
Message-ID: <37294484-a0d9-4b88-bdc2-0bf950cb1608@linaro.org>
Date: Thu, 7 Aug 2025 13:05:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Use SoC-specific compatible string for Samsung MFC
To: Aakarsh Jain <aakarsh.jain@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
 andrzej.hajda@intel.com, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 alim.akhtar@samsung.com, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc: linux-samsung-soc@vger.kernel.org, aswani.reddy@samsung.com,
 anindya.sg@samsung.com
References: <CGME20250807032459epcas5p1d6bd796f5b654c92372bdcc8a7926c22@epcas5p1.samsung.com>
 <20250807032449.92770-1-aakarsh.jain@samsung.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250807032449.92770-1-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2025 05:24, Aakarsh Jain wrote:
> This patch series modifies the samsung MFC version compatible to
> SoC-specific compatible.

You CC-ed an address, which suggests you do not work on mainline kernel
or you do not use get_maintainers.pl/b4/patman. Please rebase and always
work on mainline or start using mentioned tools, so correct addresses
will be used.

This also might explain why you could not read current kernel
practices/docs?

Best regards,
Krzysztof

