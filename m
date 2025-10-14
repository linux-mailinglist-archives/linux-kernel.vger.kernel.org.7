Return-Path: <linux-kernel+bounces-852891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCACBDA2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D922C189A704
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8142FE04D;
	Tue, 14 Oct 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgt9EIQQ"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372132FF152
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453766; cv=none; b=VYNtuNRLNIQajrYQIcuI78zhSUtut16elxdLvonYyI8y3crL+/BfQcbaAQxn2yvlskqURrkRh3ocgBGnAJmNaEH0S6WzxYr0iquRjg+JGUNl1GI6fjdfMX6lZqEoJox6oH3atlLXJZ1XBhWepL+aMgk6pgoemjI7TqaQQFtEmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453766; c=relaxed/simple;
	bh=t0eECElMdZi3rnWW3mPDtAjVKIQVB4ZInnz89Xn9HVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHW52zxZJNAz3B7UliS82ABJhrdUma2vCXP+AONZAjvSMsVQ8kOEgjGXWRcQaD3HTEkOmcjcOtobDU6Sb+2zBEofZBUEASPfgBuQUi++CWSklWGclP8u5V06Wq91Vpo5xZLxtU/tUIkiFxz4pNdpmnSwncBbw0f9jZFSsZnjTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgt9EIQQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b609a32a9b6so3212721a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760453764; x=1761058564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TCeJh+2MAsHiwUgHhTjgOc+5NEn5HUcdm8yoLhNeLn8=;
        b=bgt9EIQQZWioFzMmHehR7/BVgARyVnhDbfOrS+dyYuQ5qH8fn6npzBdkCqk9IXG38j
         tqTSg7y1Y8v/CjAmtHkW33UcJsBrVlk/isa3PsyNQ5PY+Mb9gFq5dCHTf7hgDHFv/mEo
         yvPlZ9Y/FZxJDKe7JSjirUNN9gOeRoZ8g2eya7xr/PX7QWyt7v3dCQJ0V/XNlBIjkj3Z
         bjZU/qYAGqDuraaN0evKGKDGDVe+Quz0WG7rQanEoBhuNsOk64Po+1I5U6YWu1e98bCw
         ILlwmW4RJLd8ze66xwYX9ov9bWfiN0/c5AhC1uYy3sGqgP3dU2NX7vYkSbW14EQbh6nt
         APlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453764; x=1761058564;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCeJh+2MAsHiwUgHhTjgOc+5NEn5HUcdm8yoLhNeLn8=;
        b=LraP5yvTnk6eFJtR+5xSkf7WY8uIxxG/NGbm47orVfoXOlhup+8U4QvHDQEuSt7n1+
         UAQUphoWXlGxJhcg7+iWfRD6k2qzUhzyFk9mdHmAPJ+LvA1sKSyfPl6dd2qXGMQDkHcY
         LbfoMEgsKbKEWbfxNY8rQ9wdzFesZVxV3Q2UNNPOS+4MbO0J7xwhNeeKatnXKvod3C28
         CcOu2xkPoP95dMkuq06DYXPaBHSeNWVvxEI1mAxrTuy/qJExQkFh2/H5FDAMV5auZgsN
         EAUtrP4EYZj4+GrUDE/z/anp/MHagiJky09ZsVqQziv5XV3UseEXOGdG9pF2nIZCpnZJ
         4OWA==
X-Forwarded-Encrypted: i=1; AJvYcCUP2EydO5fjZNBFMvcasiuwpHcxmBRGAznZ8StHKyqDrLQpUFqRiuoEMSMZQ9zeqbvWRQIhmS73GMSOnvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwInxs3v/JqqJWjyo7w+ui+ilHD9c0FnF8huUAntoJ7ucAZuOs6
	0rinDCBHDkyibUlkxDEIL2cHOnRW44+fp2gdHwJIDAoUIKbgpXk4XDg6
X-Gm-Gg: ASbGncuwIh4VH91etuYiEBsZeh3SsLYeNOPiLFoRNbBh1hhyjzwt0tFHt+Ub0Xv4b4p
	Co7qFwxdTjkUdnwfVtA960sty6U6j1xT21VOE3BG+MkQnfQamZr+wSjtZd47NHe431Lep/OHfOs
	bQ83V/OisU8JihYKo1dT8Zl7tz5km+L3CemATH3SJlLwkbj6ISnr0oNja01OEZiPSnqo59DhI3E
	u35HAjNCI9MISxVO6zZx4jGp32yWucgzQWPmST20/VPAsU55w0kGB7rjOwrWTO2ArRbwlLMBHII
	JTJGTDFtfcr/EFLTKZC4qq3YBVYzcn2lFExNrMGvM5RkkqCp7GUhRkyIIolOREpCUiqQ8XBCFnr
	Zhf3kwOMPUGp812S53xHa1yR6Dd+9R+7w+9HtaTbTQJE+VHSq649W49x+AFQOpNyvvL2Ar9E1Y5
	PudMnRhbNTGQwOH2rYFwAFfhVV
X-Google-Smtp-Source: AGHT+IE1OUFOl6jhgKK1/TPdVLq11c7/IYvBqnfdZ5u0TuC+oW7V0h6o5BV4kWd62d3sektGSqNaKw==
X-Received: by 2002:a17:903:f85:b0:264:befb:829c with SMTP id d9443c01a7336-2902721634bmr256845555ad.9.1760453764329;
        Tue, 14 Oct 2025 07:56:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e179cesm166256325ad.34.2025.10.14.07.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:56:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <255ddd95-3b22-4f34-b8b6-f32ce79ca13b@roeck-us.net>
Date: Tue, 14 Oct 2025 07:56:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: watchdog: Convert TI OMAP to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013213136.693752-1-robh@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251013213136.693752-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 14:31, Rob Herring (Arm) wrote:
> Convert the TI OMAP watchdog binding to DT schema format. The compatible
> string list was incomplete. The "reg" and "interrupts" properties were
> missing. "ti,hwmods" is also deprecated and not required.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


