Return-Path: <linux-kernel+bounces-848316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F07BCD62F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 239424E030E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D842F3C32;
	Fri, 10 Oct 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZLZwCgd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D9C28466A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105237; cv=none; b=swOU1B8S9noyGLbRw0u2RxHGLY2wPMf6xfLFg9F1LBxSqndEcCK7IuEKYPBxEzbsBPiIHLIC4S0ZCCNhFCI9p2Zc66omz//a4HZI8pf/xy7WkW37w73LtRu6pGGs/L4UMFFHbLBxHcIrdQFqnW37zCL/NfzmmTjWNv05qJoHm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105237; c=relaxed/simple;
	bh=EpvvbYbzvU6zmy28zGsL/hrDErMFtA16oSibI9TggNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhIPGK25q/M7GLWwNqdnVjbuLH5uG92fLI9hdmopqe+s5ycUAOSga3G2mfD/KCmErD1LkR+6b82CaoovwcSSSGFmRX8SoGYUh3lAucNBY/bJ4NG9U0jTWrKvgt/ZYOQbobKjsSkpCwY9dqjCgQqSYv0n6UBQhb8Dayl/QUj13+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lZLZwCgd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so14625965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760105234; x=1760710034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Enu1DPq85k1M2WpWSEeI3rs72YHXo8vk1sE+FawP+Qo=;
        b=lZLZwCgdincZK8sEABhFZMr0j9WNDZ4uPN4WK/DvAn026vQAcW5o5YK5QHcF+wiBrI
         Uwgzn4TlduPRKm8j+0sjSq6AekZY32zPs3MgWugCxV+hkGBcbmGMXX44ghV0MC94LGKg
         NEJGxN3jnKHXtYaMhTa7VXCcasAtY21Wtm1pxv3wTmsXBI07CIRi4vkhW91WWuY9wlKw
         VLixueMZgw/NoUkB9d0Ey21l1zSp0G3D5/dXM68c1d2Seq7no5ONZ/MU7kLzl8AB2YRl
         bm4eKyarbpUi4HpQV/rEoP8QJpT9jz9A8FMynLzG6YTkPjUzUAdQnUh3opbL6Bm2wWJ1
         3AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105234; x=1760710034;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Enu1DPq85k1M2WpWSEeI3rs72YHXo8vk1sE+FawP+Qo=;
        b=jiRMqSI0u6TmzvxukD0k6uYgmrCkVhH12+9O352Ojar1sjpImDzcwSFoY/EIZefh2A
         tSUsZ5NWEoWWFSugjcsI1URu42Cz/l4MyMMYX1nQpTKMvHyhK62FmzpbwGHx6hgrPQP1
         bKAC3q0bTb6BqT/CcsWBHqk/xwVrvsSyJTA8cHzS9Bo2nRgcL757CohZUQrLRuP6A+//
         lnce0JuXkfqd0WYiCnVsxMP/3/WFpvBArlmeuwZZmw1cSXGOLtLnoKXTDro4jYedXQYL
         gG1/n3aAfRjHes10U62tqJA/Rjq2zJ3ZQn/0Zz1wiotJo815tizeD+GDzu4A1d8AHtFi
         U6PA==
X-Forwarded-Encrypted: i=1; AJvYcCXsSIKAdG0K66XWl+xRUv298wUyKUybqq5wQmp+1ZyFHcJ1av226XXytRvl6ec6vF0S0/2kUoyEb0VoE+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPy3L0K3YfNsn7ffuTR50g45bkq4nmGV50vECWn+SqEyZhak5v
	qGjfP+HSwu2lQ4CYd6a3nUo3mAue2u/2XbLmIgEEk69c3U+bTboeQ5lFS4BHwDIDGMI=
X-Gm-Gg: ASbGncvtY/LamWqTJOXN0AZd73rVl1vRyFxm3+eCJDcvtvaZ6+g4OpHaH+tP4N2SqL3
	zk+UvSEBQLwnJioPSX2mxchUbEL6NOSJSbkrXI+UcYwVmq11EzoDi4YD9DC8G2RDhZ3iLd7v1L3
	Gju5OJwCdmHO1/kSnBgp72eLkiQ/Z7T5Z1vFMl17xc4/8t+IQzOpxTZHuB8xpQ9bQYNtj73awvN
	+jZeF/ya/Fr9grxBTbqPs6Y3/m5B2/GFc0pvDXH/rdxZftDu9xlEeO0yHYfEoFlc4Y21f/QiDZD
	ZFfkISWGIgMi2yn5fU/0fCIBZPBnbf3ZMuWwGICxfEYdtPfhi7Kp9uXHL61oLIRrWp6HzQrlgMF
	GKEjoC8Gdk5bJDn3EnnBw5isGdIXDaHejdLfmt5TAj1PhWXaR2BymboZI6bfkY4o=
X-Google-Smtp-Source: AGHT+IFolS4C8hT0Zmg7bmr6SzhI/cPbFJ3OA3Pjp2+/sYyehoF+n9CTxeFrReeZKbRbn30lJJ9YTw==
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr80864615e9.36.1760105234051;
        Fri, 10 Oct 2025 07:07:14 -0700 (PDT)
Received: from [192.168.0.36] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583335sm4343474f8f.18.2025.10.10.07.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:07:13 -0700 (PDT)
Message-ID: <f033a8eb-df80-4f71-a941-09ba209f5901@linaro.org>
Date: Fri, 10 Oct 2025 17:07:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: crypto: qcom,inline-crypto-engine: Document
 the kaanapali ICE
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
 trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
 Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
References: <20250924-knp-ice-v1-1-1adfc2d9e83c@oss.qualcomm.com>
 <36759154-4e7b-4cc9-b50f-ffb51a0b8aaf@kernel.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <36759154-4e7b-4cc9-b50f-ffb51a0b8aaf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/25 13:51, Krzysztof Kozlowski wrote:
> On 25/09/2025 08:29, Jingyi Wang wrote:
>> From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
>>
>> Document the Inline Crypto Engine (ICE) on the kaanapali platform.
>>
>> Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

