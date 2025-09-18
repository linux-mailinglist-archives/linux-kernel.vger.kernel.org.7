Return-Path: <linux-kernel+bounces-773550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F910B2A1B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17885611BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3F3203A4;
	Mon, 18 Aug 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpsN1Ccf"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917127B358
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519967; cv=none; b=X9H8rjxyQOUlEtK8Q5HrGc/SnIuT9tdb9qbgaCtwWusXc+xmjLkXep94EbsxtN7P6Yu2FbSjdVK8fK6iOekli7G0pQttMp587wdCf46Lz7l+VDdhxj52H7D/FZBK4bPQge+gxf+dVAB8GVdByOlyG/hD2tjMW78KA0q6E3PdKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519967; c=relaxed/simple;
	bh=7KvajDYvWJjalQ4l/9THQAIY4swE+8ugK9Z1et0TsSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iumoj36ZtOpmLqH/T/aUFKfOaAarypWPyHaRHZXiF6VPRobw57OuJV6vpkcT/8rXJqAT7BN/xbIxJJfdB773nNRLWvU9v+LTiboeA510NMoIep9ifOFmbfMkmcW/9M6HLODHP+HNb3em+7j2E6PRI1+Z99xOgHkwYof8AEn/rVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bpsN1Ccf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b657564so429464a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755519962; x=1756124762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tAZmeq8pmlYrW4A5HG1VS0D7sZdBXHMG49sTfa8cmGo=;
        b=bpsN1Ccfqjgh8dFd7VRB4MSDo/s0OaCPz2VVlUlz/YWGd7gacs2eXga12azpZBNSKx
         w9AI0P6FIWj/mjm2Dn4DiSwMxzggKKp6MDGUnn/+GbLTEyOI2sO58qeNQ4ie7CRyXczj
         P1YAi4491r5ZL6eCjmxOK4pKsgrnHdloQfqiOsOExhQiJJtrr40rYKVZTqV0KYbjYajA
         KI6H1lXuDsJ54M5s0Y1w+rI7nyQOHPOOxDP/Ecnd6o3e6B4M5ow3Fs8I5qygotFSqCJw
         J4ISjZUZZ1EaQERjtVBYOEp93q46OvhYQymjhFWGKUSTsuMc4BwSzczvoxVja3PM+X1f
         fGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519962; x=1756124762;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAZmeq8pmlYrW4A5HG1VS0D7sZdBXHMG49sTfa8cmGo=;
        b=MgrM4fphJFSXPhd88BBLkRg2tPOhiYoAGnNCtnqtPXEjDG6IfINEOlfhylaU2r3wn5
         uxZ7NI8bQ+xFdL/LFyYjmMQ/lOmfwNvZRSuQGnZiGj+fz3UwVsKCkb86XSOmEoRbySna
         VOeC8bZNftdojEU9YVWD6F8WqoiS7HtsyKxP6UhU6arTda12JAqc0IedZknHfDUUKH93
         bAsmaJgw4xWd+/GsTtjmpo1agxwtculI3acBUJ7jH1ve13Se05xWxiAEZfqOAHPR+Xqe
         2bJii7CSHyGvX0oMbjaFXfc2wr6LgqHEKFhsqsoaiDv5YRdKnjbYq/Tv9B0y044pU6ie
         xHxA==
X-Forwarded-Encrypted: i=1; AJvYcCWSj89mkNVINj8aGwT9q2FYvS1v6BTzWNNF2Mgl6xbfJOcP+BSD9QHa/4XLhve1wFPvvGN6lF2yKEu0Gg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLGVf5UwyrIjBJfMO6bvWOLqYXRSWuw2a/fr354ue1sobMD8u
	dxUf9yDj2WzQkC9AU7QDNJXDWRoQ0bOUnGBBe2NCOf9Xi+rS0xdHeYHZA5OZYpUgczk=
X-Gm-Gg: ASbGncslEZ3p8VkQ4+ionFcAmhy5jT1PJNXto8P9layeFmJBNKmKtj1rZrE5Mnj7K6k
	w5uMcyWt5wcjkkKFSiI8FpICPZMUHVKs37NfvtjLvw7lm20LPBVXAb9tlu5/3/cUQ/9RzcmHek8
	+hKgRkgnfsHfSihepMSNb/LlUo+tKjF+Higj7YcGOoRJYRZ8pOgg916YGlVSfa/WhYiVxTvGZjF
	gMQM0RqVjtf5yNStkIlfExOF7XFdYvFw1nkouzsx1isGkiFzmXmL4HcKyP6J1xRoNLzkdUkGYdh
	pLndZxGH9WKkmZPFRy6+UQyABSjpgrB2QF+mIwwhpOZdvLRR45UOetJU1OWcFh1oV4fTK6gDNHy
	UA5Cst8XFTYInutBXsQ/EMGhFFubNBE+96WsmNrxYVbp31nPL6wOtBQ==
X-Google-Smtp-Source: AGHT+IFoRYLvOXd0/rNQvuMSRJ1Y73JHRE4yWCRI+6TS79L5MLfSj0aAF/iDDPk9ov6MtqfUgkTjIg==
X-Received: by 2002:a17:907:9627:b0:af9:a9ea:f42f with SMTP id a640c23a62f3a-afcdc1f4d0emr512427166b.9.1755519962483;
        Mon, 18 Aug 2025 05:26:02 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce73e39sm803578966b.34.2025.08.18.05.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:26:01 -0700 (PDT)
Message-ID: <855c21ca-b16b-4af7-8545-992a7b80a562@linaro.org>
Date: Mon, 18 Aug 2025 14:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ASoC: qcom: audioreach: sort modules based on hex
 ids
To: srinivas.kandagatla@oss.qualcomm.com, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250818122240.1223535-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818122240.1223535-6-srinivas.kandagatla@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250818122240.1223535-6-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 14:22, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Sort the module defines based on its hex ids.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/qcom/qdsp6/audioreach.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

