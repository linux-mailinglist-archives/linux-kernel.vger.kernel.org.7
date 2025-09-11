Return-Path: <linux-kernel+bounces-811406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B52B528A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054124638C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE67258EF9;
	Thu, 11 Sep 2025 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFa9Qw0+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C0258EE8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571806; cv=none; b=MR3XIXjsHhQAZqZdN4gr0Od7UUyO968BDbppYL6fCGYO456enhE6K711m7RqnmVfAOaTiufWdcVj8eV1K7vX7Zvqt3Dm51OAPr1TPV8q8/JumXvO9fccWnk+I6l139K/T5TvmIyAAxuj99ycym7t0XqBLLF2T0pLdpoFVt/7OtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571806; c=relaxed/simple;
	bh=rHr7FvJMHid/017FiYHUBGprb/Lqg7Kg3w8M/8S4xTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O3wYxA6jNXW4+Bs7InYkO8k8mW2ta97qAlnetWbvUWCEaaAz3KjcVBPMv0r56xjptfMshZEbNd2zKj6NaEe4L1mKjSgZXgEni5ASxfjUVdAp+nwnIR9SowkZXmTFBQxDUc7PgWC50eNGiTe52jdLfNb6is2VzIs5+nafPsf0sxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OFa9Qw0+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e7516606c2so39780f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757571803; x=1758176603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wg4ExbZFlSVxsqzRRKRc3ecOdjgPd8wu5LFpbr1o7eg=;
        b=OFa9Qw0+nUDn/AmP+noVeoDJBbqXFpfG3raaK3BEVciRyuDcnlRF83lx/QOvPJnWVh
         vHIVCeTR6zw2ZONJ5UcCIiL6g5wBrJAwganK+HmW4h9LkdDmSDMzjsziXxavKsBlFuVL
         qO0UDmcYQTrDZ1DR+VmvfNNlqtRB0453GCwjjj6w1N70GddSCCMJMR0Bv58M1GvixZq2
         y0XsUA/BQ/+LXG4a/4QvKRN1nJQmjhdF4Fr+Yn2ByIOFz5hXrjFmGw/jnDB/OO8klYpJ
         NMkuKcS3xMeKpU+GJjLQ7Z9Fz57DWNWQSNr/v9DJd7ERpwRddAjJ7ZjYqI7z77XGeVi9
         2gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757571803; x=1758176603;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wg4ExbZFlSVxsqzRRKRc3ecOdjgPd8wu5LFpbr1o7eg=;
        b=UTBZ6IImVj3yB7D2u3GGB/RCrfR7k6xCdzD5hJMED6N+++OynalBpDRcw36htTpgvI
         LcLY69sknQ4fPb+vjJ+ipXbbwlQeqJFIc3E4IflqwLXkYqv9RcwETcopn0w7NscMsrAC
         yJ1aQqJ4d9xjnMxqn7CqOqwT00fPyrrlUxvxIQ82NnZG8jUNnTtBwZyojSUuuRcIIr8c
         X84xWsHFpPbL8atoCMRVf0s4lXXKaZsobVw6QHdCs1BQvMuAuFDysNbxr3RXrCJslAiN
         5vCFXucbTMrmT6NrtrqpNpHKrTs2L+S8s4ulVw+MB1Cm38Bg9G81PpcEmrXEckX3BuE1
         ujUA==
X-Forwarded-Encrypted: i=1; AJvYcCWhUMNeZOCQOuaP+VQje+8yHtYLzOO4Nmms3eaW37W7biKgJuRCU/0Rp1YJJHCXpvaiEl1cooxf1FcNyeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPjO042uZ1j6lixUlh2DoHRI8Sg7Rbh3lo2ir++65jUhT3OR0c
	Gj6spwPJoe1glGR459OXyngcU2E4ZRF8NttMHt9iSTe4HosrT7/Vif2saz3gCf345aQ=
X-Gm-Gg: ASbGncsTwKx7LgF4NK/T23+jfz0pqLSN/h63zb2QcbxZYSBqjp4EcxVhleJTIcKuY35
	fEiNphdqkCBMSoGfMjdY9MpD/Zl92U6xQNzqbU5Vy2IbJ4YHQd+O0DQ6v370Yn7W7Ey3xBdgGGu
	44Vbk3gQy0dwsR37ovCGDtTarXTF9X3WOM6gNel2MHBROTn7cMih1o1TF7hRgVqY1YItoi6K2hP
	NHRFjJeqI55ZKSH17WIXt5UuQ/FfMWt7o5C7lNQRanODWAAcA47hMenJgMnn2W3IN9I0Sf4tg/6
	dhYcw7mCBVIuZSsWqOBWawI2WXyIIxyM18De20ONw8kJLpnGirZn9ntBo3PCWiI43Fn2muBgfFz
	CYRQoWugMbusrEUh4fqEk1RFkhYP8e+/NUT9v6YdjnWo=
X-Google-Smtp-Source: AGHT+IHzBt5hdqBctHz4x9S5F/NdBCGMXBgK0ytEDf+klfhGJCbW7H8wptMemYdfhxTy5YEqDCSS8g==
X-Received: by 2002:a05:600c:37c4:b0:45d:da63:cb09 with SMTP id 5b1f17b1804b1-45ddde81392mr91200965e9.2.1757571802617;
        Wed, 10 Sep 2025 23:23:22 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d822fsm1140443f8f.53.2025.09.10.23.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 23:23:22 -0700 (PDT)
Message-ID: <a52f809d-c8ae-411a-b305-46fd4233e2a0@linaro.org>
Date: Thu, 11 Sep 2025 08:23:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: lpass-wsa-macro: Fix speaker quality
 distortion
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250831151401.30897-2-krzysztof.kozlowski@linaro.org>
 <DCPKY2GED44G.I2DSV6ZBXYAQ@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <DCPKY2GED44G.I2DSV6ZBXYAQ@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 03:29, Alexey Klimov wrote:
> On Sun Aug 31, 2025 at 4:14 PM BST, Krzysztof Kozlowski wrote:
>> After removal of first AIF_INVALID DAI identifier, this kcontrol was
>> updating wrong entries in active channel count and mask arrays which was
>> visible in reduced quality (distortions) during speaker playback on
>> several boards like Lenovo T14s laptop and Qualcomm SM8550-based boards.
>>
>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>> Fixes: bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused AIF_INVALID first DAI identifier")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Reported via IRC.
>> Fix for current v6.17-RC cycle.
>>
>> I will be investigating rest of lpass macro codecs a bit later.
> 
> Any updates on other lpass macro codecs? Is something still broken there
> or are they fine? So I guess the changes for wsa and rx macro were applied.
> va, tx?


The remaining two - VA and TX - are fine, I checked them.


Best regards,
Krzysztof

