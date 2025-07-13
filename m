Return-Path: <linux-kernel+bounces-729026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93119B030AB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2801894D48
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A62314F121;
	Sun, 13 Jul 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvQm2ctl"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C5E13D539
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752403569; cv=none; b=XmGsuTzHbxqe/aZoIMSW2Go9MTHl+KeBmND6ndIp+ixgKf69sv35x5CJ0pCpxxY4A1+hN//7EYJxRaGQuYwFkKxPYXjdMH01kepEVir6h5ZtG5PIRhXwcdIjlXdf/He5/kRSR6GVqjKpJtkOZts2vliQ+RIH+p+tF3z67TFRvEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752403569; c=relaxed/simple;
	bh=fxcYqU/Ko85orQcrgMRz1APpTamRupuJvJ5cDFN/yGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDfBlXYLP+VeGn8n3aqXr/xEEFPUg0jXA/67BXyPc3c7inHKFaIHlq12D5j0u4b3A1eEMJUKS/Z3NaeJhiHvvi2V6ln2QIH3xlSbehM2M+/zCRrl4ny6h+tML7wJOpROaHM9k3rxUggYjR2rPPTr81o05SMuGxMmwcIAbekU2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lvQm2ctl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45611d82f2eso590495e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752403565; x=1753008365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UInuwQ9XuwtQQSYEgiG3YbCOgVsqTkOCjiaX+cqahg0=;
        b=lvQm2ctlD4a60L2XmdHlZqP4/GdBErDzRvvQnpUVy0NwjnVKG3KMNUmFlBlLTVEYVn
         qNrc4PXCU38/lvDqqNlUhYyAklmgzjMBZo+y9n+WkMQ/kwVv50P7uJumT/xJek3k0gOM
         WUQA5nRaDzyjzlm1INCxlap6+7pDIGL9G35Tl1/3PXPu+8inFIKjRctG3GpQzDLazlSg
         P+HomKxcGGKAmcBYr3mGksqL15K0EX7d+tYKwBiX+rHfhlggOjGxRYXBk8x48vf4VoHc
         O3eHtjGfvxe4O/TncZcAPdCMqKjq7tym9yPu7ShbrdN7bYrUxC+J4FYP4nXmLqe6Ujh9
         XvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752403565; x=1753008365;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UInuwQ9XuwtQQSYEgiG3YbCOgVsqTkOCjiaX+cqahg0=;
        b=ot2PQ2FVpwPTXtol/T66aqh++VInPS+zlhYNJqBd3sDAPtvdaT2KGuQJYPNnI6EJwl
         BThM3tqDdxX66tk6uJxccn4Ybv3D9amvlbBupEsA0FO/9CI4ZJ6n9cZ3Uv0ppEEos6xH
         0x38YppIRmt15AIeIV2aUPCP5LmBU2fv5SJ0SSK3kw4HN089jJ2iPWNe4oLxC0yrmAmE
         u6e79HSKPe3ddCpOIAYlU86gAm4csrQZEYfP2PCbKazlFoEQ44BqwcGju1aUrgFDcTJ7
         +R+Q8rlTw3A0lGUjD39Qy/ev1ICxWVuOUwdX9DzNnkd8uSirswrdKxkDuQ3isNZ4BQ9t
         pkPw==
X-Forwarded-Encrypted: i=1; AJvYcCVJMATMTs6ocRjEYER4p77NtCD08lvMOuPsS6iJSAVo88yVRW+ErVz7xXY6UMAuXE1y7IXSRRlgbMYDZ4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JSyWizT84N3BFeYIgJVTpc0J2vEwBznQUn7ARJ3/hI3Vajz4
	oaQdNoASj5Xo3AdbTHkGsepJlOzz7Xa2TbfokrxJMH8vp6ICox70y8voSHYwxe+Tf14sDIk7N14
	W32fi
X-Gm-Gg: ASbGncv4UCmaaWDWdAum6EGQr8lgbg7pZY4uP6sONPf4fbwJXJw0LI9wswzTkoDgLqC
	EOJWFV8ADagbjt53Rqy9eyGPcm3Yzw2k7mlTPDQZYHhSjPENZsGBGuxhcui6r4HS2Cbq0NnBQzp
	ytekM7hm3xW8ONihBFeLBLwcNmHeumJLFoo7fdp98JwrM8mjJkl7TkJyfRq5kARZzIUYF+MS7k3
	vc6W9yvpyeEmsc5A/7439OYuX22RVgMqk/odemazhwYfyWSIuMLK2DrUaonJCROHMTBBcnCtysq
	4JWm7mv8gBeX61y+1/Qzt6cdmDZ3KpDTmCCYite/ABzBBeZLv2DghISjwqljntyjDbp7h9cH+Km
	KQcrQkJ3TVrVCfHWlp+jgGyzZACjRZmUi8uTbc/inK6cwZoSl6PYs
X-Google-Smtp-Source: AGHT+IGEivMrOAYbygpLWOUiG3esHWICU4xtijFfeQwmX9SWKq2P/KaAb2u5hO9x4lHS3NY27A5PLA==
X-Received: by 2002:a05:600c:8b16:b0:451:eed7:6d76 with SMTP id 5b1f17b1804b1-454f4297812mr34219715e9.8.1752403565093;
        Sun, 13 Jul 2025 03:46:05 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc9268sm9410915f8f.41.2025.07.13.03.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 03:46:04 -0700 (PDT)
Message-ID: <a1dd64ec-1c1d-444f-ac08-0cfddecdd91d@linaro.org>
Date: Sun, 13 Jul 2025 12:46:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dt: submitting-patches: Avoid 'schema' in subject
 and add an example
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710085814.21810-2-krzysztof.kozlowski@linaro.org>
 <20250710224419.GA10902-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250710224419.GA10902-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 00:44, Rob Herring wrote:
> On Thu, Jul 10, 2025 at 10:58:15AM +0200, Krzysztof Kozlowski wrote:
>> Subjects should avoid also 'schema' keyword, because all bindings are
>> supposed to be in DT schema format.  Effectively people get confused
>> that subject should not contain anything else than device name after the
>> prefix, so add a recommended example.
> 
> However, conversions should because if you say don't say schema, then 
> people will say YAML which I don't prefer. I prefer "convert foo to DT 
> schema" as lots of things are YAML and only 1 thing is "DT schema".
OK, I can rephrase the commit msg and contents. Will be longer text, though.

Best regards,
Krzysztof

