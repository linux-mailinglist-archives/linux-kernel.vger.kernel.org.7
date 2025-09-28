Return-Path: <linux-kernel+bounces-835440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A02BA719C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8BC3BA660
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673EC13B284;
	Sun, 28 Sep 2025 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVM6Wzkn"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06320147C9B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759069898; cv=none; b=Pw10W6wicxa7w6Tpf8QNaih5lW9Hlvr/CiJFLuaJHT+A6Y6lYdpUS6ONx8ylQmvq3bYZ2cgxPQ1q59Ys6qB5rTk8rbOXgddkYwaxsaW1M/mhK7Jhl09vunQrh5xCj7+j7zzzzPkJ03sHEMFJE6mAZETSR41fT0sfNMjP/qpqYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759069898; c=relaxed/simple;
	bh=ItFmGJIZUsjauXk4IBmkjqXUpPsyfWZYBQyF9nT8sJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOP39lIciVB421jFIIEghmrT97rvXtLjtEgBb/bV5WokZbWqw9sgjl8O615gI8qoLbuAa8iuD+IEop6Ob2N8ru8e8HJO+QydvT5tWVaZKgKrWOaElUh50WA3cOb4mLLum4FSGQjnTL032l2Fz6T6h2qateBfCsJ1KV89RrVjrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AVM6Wzkn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso21737675e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759069895; x=1759674695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lk5CQ9hpHLxRgqfNWWxK3LXxIXI2E6NJZOo1XKYj1M=;
        b=AVM6WzknhP+0ISXCbntlC6Ck0CF/stDSTCjuJBJSF41OU20Kgq9DYb/pcka8w7OcUf
         3JrgnB7ky2DapbZdUuUH/3U6KvrzlxC0jOqSlVSuhb8Y4RCYkgWk9/GYJ2YyLFuFvBAp
         EvS8JRux4xIo8AbNbB54pjId4w6Ejjdy1JadGImahFQFi3SdfoHMvlC1B1aheQei31cq
         okrYuWddD7xF+8MIV6kLcTemK+5Ri9MZJPd3rCgyUvbe30DV99zor9sivAckIJwqthzA
         Bzu6P5hB2HDA/8tXrl0u2O/cUrSBwJwD35pvFvGPVhrUka0Lr9pCLljpwNFwlwh8kFjF
         CiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759069895; x=1759674695;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lk5CQ9hpHLxRgqfNWWxK3LXxIXI2E6NJZOo1XKYj1M=;
        b=Qf2Cixwq+RkSTDS0mQpJaQtnNhSg2tWaEFKlVWpMoEL++LT69s4yxjKpyX6FpNl/xa
         CBhYrkWOxzstdoBd6PWLvHXxc7LREOT9ZgoAFEngunq75gEVBeRSwur7bER3y1RUh1SH
         58ouNOK+UgfoKdyUu1aRyfaEDeP3MadWIC017NeENqn6lWcHSunF+jefvxKrUF6JWAVA
         779GQ7mZRk3HCnC3SUcboCsWiG3SBBBP4Lk6DayIsbhr+gVPR4WZdb3x3W/Aj2boVBN1
         bvwTWW57IcEVk+QsSN0u+OTQfh6zc+uuwToK7rT7RQr4xCV0ZyMFYRQglj3vGpmP1Rkn
         LFVg==
X-Forwarded-Encrypted: i=1; AJvYcCVnTtxe79xuyAsjlDN72ip6H/E8CUtM7UB7iAZwtP6RXfsIpJwLJ8BEs/zY9s+8A+2+ASn1voT8N4nnCiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyslaJGLNB1oBbBVO7BpZ2romip2t8juBzAHovY9lF/N6QdXV7h
	rqyx+RuJkofKnp9DphHypSKKu6Q2OlN/IDIYmcnO/yWwgPt1/PlSxfkZt0O2kvU1VOI=
X-Gm-Gg: ASbGncuIf6TfF/vvcspsU2NeTGJtJ2l3U4VQC8TF3+0JRvBKkOXD0DM7xh32FIEkmux
	xqItefZMt7iV8OQlKKNSOeTbwPzZ0aOKjBjIZyVxrJgL1sXMvJQmqhrPK0B7Vt5UYRnKoakt0Nv
	Mqa1CNiYmdQzgj0XUkDQiau/dqGI6a4E5JAmOlA3kIoRkn9QB98/B1TAEZOk/JURSMsjwRS4WIc
	zFa/URGPRF7U/474yK6zjwZpTpkqfiewIAFufcraZDrG9oOdgRYyqZ8gzEDb+jcjsGXqdXMNCaM
	g21H3FYFYHtTgeViPP1uR7wBvGEshadpI7IvYMAEAc0tR51HR7qF7EGB08ypAnxcshEbw6FbVNv
	768X3kCdLr9K6ygF1CwYo3XjWC28aCTBFZtRxV5wNBaCf8MCdOQqdYP32VK5tmlv547fgSHOYZx
	TqjkIcXuEyZVEiIy8qTg/VWCjE4BW+pPM=
X-Google-Smtp-Source: AGHT+IEEhQexfM/F4JIJe17ctZWPZUJrahxBOKEhTqyR4Y3AE6l5ifGji75EdFxa/fR15vbOd1XStA==
X-Received: by 2002:a05:6000:2507:b0:3ec:d740:a71b with SMTP id ffacd0b85a97d-40e47ee096cmr11720935f8f.31.1759069895255;
        Sun, 28 Sep 2025 07:31:35 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e902sm144002505e9.5.2025.09.28.07.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 07:31:34 -0700 (PDT)
Message-ID: <993e130e-9a5a-4dbb-a272-c3be83f5e722@linaro.org>
Date: Sun, 28 Sep 2025 15:31:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1-dell-thena: remove dp data-lanes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Laurentiu Tudor <laurentiu.tudor1@dell.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250927032240.20759-1-val@packett.cool>
 <b6066559-72f0-4f1d-9134-c93f732fa6dc@linaro.org>
 <kgy2l2lmj6mv3er3nmvvpw44zort5cmhdkkix4oxijfojr4wol@tnxjxnlkum5f>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <kgy2l2lmj6mv3er3nmvvpw44zort5cmhdkkix4oxijfojr4wol@tnxjxnlkum5f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/09/2025 07:18, Dmitry Baryshkov wrote:
>>      fc582cd26e88 ("io_uring/msg_ring: ensure io_kiocb freeing is deferred
>> for RCU")
>>
>> With that fixed.
> I think that's a bit of the overkill. The usual style is:
> 
> The commit 0123abcdef01 ("foo: bar baz abc") has broken this-and-that on
> my device.....

I meant the usual style :)

---
bod

