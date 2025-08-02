Return-Path: <linux-kernel+bounces-753976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA36B18B1F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 09:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD49560D0C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9611F3B9E;
	Sat,  2 Aug 2025 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFbvRB09"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9582D98
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754120599; cv=none; b=FaaFBKm/ogZjQNl48DNWBgja1T8RrEFOLkUtat2Zt7OQljzlGPHuVKimCvJYlZj2OuwBxalzIzfNpcRvbC1JJrjqreth2Ab4429JH8gdigXoBx33ntvoI85czg58jC+hduYxaso2gq43RJSzQNMTZXMt1uDtjM7UdR7ZNeNvGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754120599; c=relaxed/simple;
	bh=DWaYsQw/b7CDauqCYLsUDBJRWLxU/MfW6/zTsA2RC/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfdJi0ZHsOAIvnCx4E/2HzIS4SHvmznA3URiiyL0kt1TV8J0sc1PUGENigA5A+ZunyzuT4OyG2WFtS3IQ5VfznUQFXSOYlPOKUC88It5cVCRKUXujv5K0RnAWJ6PDbPX1/f79y61aWfnuKO0CcXH56HOMaPTh5/YxGEkqtYa2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFbvRB09; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-458bd315a76so38305e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754120596; x=1754725396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4tXbfxoTI7BxAQNn3dY0og7zllYrIL3yrRLiAHe0UUI=;
        b=fFbvRB09gDJk62EVCzg3qYYfKQdT3w8I+KKhCaLWK2hdwOS1s3Ccyp+jXQLUz4h32S
         N69YtRhlDQa9IoAkWMH/WW3uVEeP8S6fgzmFSRLPtlLHu5Rt9ZPibweUbD1aWj37g3RG
         IB2dntlbG4Fgt1lMPkfoM1If5hNBlWdJmf2LWsyyiqdlP9r6e51u645q1PN4K+sr68hF
         fID51W1rlckMov8bjcwikxMQmewknz2z991KVK6PPAEjgDUjBVCicv8o7K97ueDx+O74
         jgoeA51HrSwdo9g5P9KcvTARPEdj/rKMS47q8ttZj7mSafdamCe0HMoNwzm6K9mCaLgW
         G55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754120596; x=1754725396;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tXbfxoTI7BxAQNn3dY0og7zllYrIL3yrRLiAHe0UUI=;
        b=In9WKF1PTr8zjQpqnQcWsXvgwLoBQQ7u1xxOMjEmqSp2HsB/DijStCns8Mr4rYhyv4
         2VIQouAv+UNoTfAOfaZd/l9Nn6ZyeC8nrEI9OjepsAZhhGkT29KjdiBOIOuyfLYIXoUu
         gu1vCr86wdnzATdWFsZBhYIg0pbFMw0FSq2LJlrjPd3cwTBt79zgzK3BMUNBo0CW8cuN
         bKSq1cfNkIWKl7k8lEOWJF7AVQjX7vz4j85Nhzre7kzM9HbL1UcsOlBvzrysXinmEgNJ
         OAIdMu2aSI4m5g3Qfhgv/KCqzwBZe4E++hCEHAJTL5uaqLqYRIZeemsU2hmk9MJhSDFs
         INiA==
X-Forwarded-Encrypted: i=1; AJvYcCVwgI0Hy7gdHZf20vG1yAiZ8FOUgDr4GDOc2XNHvqqXdl5j78+avmPdYzm+/S8Ey+NwiRRxXKrIve/3Z1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZSL3zxJxcio1RZlTWzfwrmlTpBhkBRtuRqROaA8zCZ0R/wLA
	QDSobDA6rjlLVAZAqkGXC7FofuwSRCBAUVQk24zG2ytPQ01yQzzjkTcvwLFIThsMA0o=
X-Gm-Gg: ASbGncvNGk1ibflBd5dhaaSUd1GqvMT4r7k+lMs4dlY7+/Gqw6aZGm51/R6Pt9djP/n
	5bJ1JWa/2UKX6DYZ71PMumJT3BjyHRKmW9d+GQbT7xglRBiYQnMQqgM6vuCphVJcNZHv2qT47k6
	D9QFBMd6aVeHb+8tn20tTBL0jdPGBf4waUkE6cMAm6X2guXp9Do8z4QRU7KcGVqWFTXO82xefuc
	ellFOFNBbIYL6BnWjUQUh/EH2SUQRP1rN7mo6D6XDUar3hfh09rHmaKECodnhYs+7KQGXL37Lij
	yyCiZHkIU9dQkSYnaCFasxcMiNPS/LQmbE1jrBd3pz+D7Nh2YjNF078nhpoU71v4EoPV+B7wi1G
	yH0tAYk6p2py+u4aDVCBCV9E8CNFn1aT0aRwOrpsrtXw=
X-Google-Smtp-Source: AGHT+IF8nbxKKcKzgr46E8sQumi9SAlHJ4sqfPn24btFxKuyKh3hLU9mumOOWIdUpo/Ot/aWxLbd/A==
X-Received: by 2002:a05:600c:1c89:b0:456:285b:db25 with SMTP id 5b1f17b1804b1-458b6b743e6mr6489135e9.6.1754120595645;
        Sat, 02 Aug 2025 00:43:15 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45895377b3csm131252315e9.13.2025.08.02.00.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 00:43:15 -0700 (PDT)
Message-ID: <895ad082-bc6f-48e3-ae1c-29675ff0e949@linaro.org>
Date: Sat, 2 Aug 2025 09:43:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru
 Tachici emails
To: Jakub Kicinski <kuba@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Cedric Encarnacion <cedricjustine.encarnacion@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
 <20250801131647.316347ed@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250801131647.316347ed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/08/2025 22:16, Jakub Kicinski wrote:
> On Thu, 24 Jul 2025 13:37:59 +0200 Krzysztof Kozlowski wrote:
>> Marcelo Schmitt, could you confirm that you are okay (or not) with this?
> 
> Doesn't look like Marcelo is responding, Marcelo?


Maybe we should just remove support for these Analog devices?

Cc two more recent addresses from analog.com.

Best regards,
Krzysztof

