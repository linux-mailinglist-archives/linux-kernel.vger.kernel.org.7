Return-Path: <linux-kernel+bounces-817887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CFB5881E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D01B22DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1692868B3;
	Mon, 15 Sep 2025 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP9MZOes"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A861C8630
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978307; cv=none; b=YEBaT+i2XEScf0KSMYN0Hk3MIsuWvOXcLGSSTZJGI0iezJElC8zWU+RPiqebs2sTukCUxlAOHdkboTgJlyJBInTpS4Ba32jQqg2v2M2MVlj9Cp05aGWZX8xyUyNbW6TsKm5ScpL/vZjuwIWQoHiVi5yB+ZSFnmH0JqnZSrnbnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978307; c=relaxed/simple;
	bh=DhCA90u7D3AwaG1VR64HFW/35fMpdcE6pkDbJ0hCWDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWzy6bULaqJ+ZDvORgThKM5doBcXz0ZXlggasBPoNu6WFKVi4n4gY65BBpi94+KR1DDgtmRnC8Q5hZx9yuIub1j03toJERIU5aiTq9sNice5QXW7y4vCE3V964VuPjfXH340JxWCZjqvpWSWj4rgfUq0XpdPiMjjMquXshuZT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP9MZOes; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4471810b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757978305; x=1758583105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+l7LUQcajOsjM5wGJwbkfQJik4Yq7alB7BOereQy2VE=;
        b=hP9MZOesqVvCVezhPhW3eMWmJllPXapGKkz2N+X23kqhxqXDKHfGDtRJhYH4w2EXV8
         3lZz3SUodUVeNzWL2OuDZWAzV0k5xyzgFVRv0mXdkrCe7FXcoGdnoH3A+ag8W6om0+V3
         prmqmpelS1du8gqO5t2mrb+TPxHJEwTQjch7g+z6pGaAxLIAA4RSk4vjYzxgyM/A7GjC
         /eP6ApjUnlRJNRD+4EX/TFt4M7n0p3AzsGdbravfb8g2Gs8rfRQrZNERvLLSLMZPZ5IK
         sjwRErA10Y4IXn7OxqfWuefUV/tkYJRRL6cCctxpRAI+zYNel0JYNuksoVuef0d1kbKQ
         j4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757978305; x=1758583105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+l7LUQcajOsjM5wGJwbkfQJik4Yq7alB7BOereQy2VE=;
        b=UkDX5aLmD7pjGRd7WNEg5d8vSh0p7duJqmSHbTrZj08RsShPfHWIzJ085ZT7ATD4VP
         XmhXZkZjzjbHdwH2eejS4D3NRMUIN6VZXHY1CPOu8p9BP4pC+A50gLvWyY/0FS8L+7Wy
         xBMo3GOzZjyxzU+qfntvqWRo5CxZJaPIsqrOyg/MywDQPd4EfOqsFfn15v5C/6MmWe7j
         E3ajpsQal3d7NpQpP5+knB5w3sHuME1yr5mk+A0roVvpOAxkpssd/cZg4eXRY0T2yCuR
         Ofjr3cDzLu7ru+paoIjPNjHKLTve1h2ACGwM46TMG6FOsI08Y/ix/GpHsrIeV+jQ6tmm
         I5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxbdKEdBaAjr/4DY+p1at5T6yyNVePAPLpmhS1kuYuLDx/FVXn8auVQMpawHMnNjI901uuCTC3lLQIxgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRMH9HfrLkCoS8ctAfgZOh5zoFjlldAWjKcJShPwPU0rnQG8J
	D/UPIFG5nl/cBbiOdsBXxXmJqR3hhRYdDjx4YEiSvGQAnpIxzT4lYFIy
X-Gm-Gg: ASbGncsSv3cRafbQlL00V4+ZEE+B50bPEc4YO44O2FOCH1Xu6zT7gm3+BLkAakD7uIZ
	Y7X9GT97+YvFiom+UYP7OAMDoqkcGdYkehOMvkYUURYSioLIu5CvtyVnrVEMLYhSjJfT2j4paQb
	fS3gbBEvkeSxAmOR9j4iX+LUi0rWSTvBvH3MT5KFyziitt309Zq4bLkAGSaGhy+Qaib3N+s7QUG
	xKcK2XqFmrzMaiY5aGW1bNoOPsIRY4Q5k6bg5o/eM6sbPa22hYJW9U9AOUTBUXXd4vuBTDxH9J8
	5V4mewMsfBTmzUo8XmmGHRW2ightkIETJHiFF1tIbkLXd2WbOwZAyPcqkGiAj3TXuQmEMbqfTJq
	J3js5pN10IuO7xaFCde9p8t2fBft1pdz5gELvim3kt5/+3eVeohCB0UsPNBbD
X-Google-Smtp-Source: AGHT+IEeWggDjh2aRCpx1suFPoqcxzvxrWOO8w9b7MPKM4IOfFG1MlxM/2ym7uq0iEUOJ01ZQNukyQ==
X-Received: by 2002:a05:6a20:6a25:b0:247:55a7:695a with SMTP id adf61e73a8af0-266ed65b2b6mr265970637.15.1757978305237;
        Mon, 15 Sep 2025 16:18:25 -0700 (PDT)
Received: from [192.168.1.105] ([59.188.211.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea0859e20sm324333a91.0.2025.09.15.16.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 16:18:24 -0700 (PDT)
Message-ID: <2fb684e0-449b-4377-81a5-5be03cdf3e6c@gmail.com>
Date: Tue, 16 Sep 2025 07:18:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: spmi: Add Apple A11 and T2 compatible
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 Sven Peter <sven@kernel.org>, linux-kernel@vger.kernel.org,
 Janne Grunau <j@jannau.net>, Stephen Boyd <sboyd@kernel.org>,
 Neal Gompa <neal@gompa.dev>, devicetree@vger.kernel.org,
 asahi@lists.linux.dev
References: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
 <20250915-t8015-spmi-v4-1-758620b5f2ae@gmail.com>
 <175794440092.2724212.9818605948916059174.robh@kernel.org>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <175794440092.2724212.9818605948916059174.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Rob Herring (Arm) 於 2025/9/15 晚上9:53 寫道:
> On Mon, 15 Sep 2025 09:52:24 +0800, Nick Chan wrote:
>> The SPMI bus found on Apple A11 and T2 SoCs are compatible with the
>> existing driver for t8103's spmi so add their compatibles.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

As stated in cover letter, the tags are dropped in v4 because the dt-binding patch has changed
significantly from v2. (really should be dropped in v3 though but that did not happen). And this
is actually a different patch from v3, the only difference is a newline is no longer removed.


>
> Missing tags:
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>
>
>
>
Best,
Nick Chan

