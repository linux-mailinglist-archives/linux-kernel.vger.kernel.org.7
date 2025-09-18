Return-Path: <linux-kernel+bounces-773875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDC8B2ABAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698071BC48FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F9D21ADCB;
	Mon, 18 Aug 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+nkcjTy"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8D21773D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528043; cv=none; b=ci7pJJW2bdg6fa13n28DN5q3Os4+UOXwsPuUhYZbS9p7PDK0HWt8NyRRANi92ZWOEB6jkS6kzdtw3XNHKc8yT2UNdPs/UNqUivbmPW9uvLwTybBi/Z6X6lhSUbX/pUFWaXUi6ghKJgBYYClgdiXjyk9EncSKYSmv3GgngDSC9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528043; c=relaxed/simple;
	bh=2ZaJCmUGUWFI2691PtyZ+t+uRC2hC8+mdqFNaXvQQ8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3cCvQYT52GDlfAdt+b2+7xiTgZ/qTfKWrgygpdiufR7c+k2MNomZ1R6XJnJYhposO5Kk/YFmoshaK9+QBRoTpYhm+VmT8q3i7npaFEITmaNJik9gZ4yBT5gttqM3gmQBcR68HMr6yvCPcTtynQ9YJVaYEzodUb5lqlaZxR7tdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+nkcjTy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b668b52so514628a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755528040; x=1756132840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rkuv3deTwkLJySiCGcIOU6jTciVhHJ/4TSG9zspb+08=;
        b=i+nkcjTyoACVUS7yi37zGatsUo2TFNHylcyK0vJrnJhx3XDuwq8C8fRCHHnpn5wxHY
         LbtezZpp8idkjUIMwgqobeA76yCoQNEvH6Fw0Hlo3xjkH3shdKJ4b4UoOweWHQff9hLn
         PawwfynRX4RkjCgBRkOmFS55BUelhfdLukjx/1Xy06RNZ5HHEcH0Yr2+HsMJvHpPr5GS
         Xj1UZFyqxrRQxrlol/kUV5nLu+GFjb45g5wjcfKKT3DTJfXQeRebRZ2kTqRitIMbK8dj
         3mIT5K8rNbFkwcD1lRyMUUf6yBT378THmo6B6DFK8rN1g80V9K+5/RubI44QdOZVw7Fq
         fm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755528040; x=1756132840;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkuv3deTwkLJySiCGcIOU6jTciVhHJ/4TSG9zspb+08=;
        b=UtyRbWL6qhnbH3SJtYxJ/y/56VN0pWai60rdVDuP+5DiotqNOuak6cs6sT28Bo34tR
         hKFS/tlB5Eioqp3n4pZHfZvGklfDTzdjhRnmr3L1KjuQH0lQvx5A+9P0/0xyeGXpCh1A
         TuQtuRQd0LsoA6TMs1toLTwyOUveQOlEPCEVbSzALG8vHnFiS7c0pdKgZWjaNNq92uws
         HYZi59OxxIHabZOfXzn+W8ZGN4RL2HMInjcFjp4xBVrKdgURyGucAQxL2hUswuvdJVUq
         72Kd+akhaVe5GHzGFen1u18tXWEzQbUcNOcU/OFmeTvk9LJc5KXJI4RrZAM1gp67x4xV
         qHIw==
X-Forwarded-Encrypted: i=1; AJvYcCUqg+DpJbn3jphQnrX0xTkdA2XTD+Bh54eQ/Q3wgU3CDzFBlmWGwycq520jsdn+HLhxxcPPAOXKTr5MgFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdhWBMlvi/clNGdOyVxTTUjWprJgtjeDRoAA300xs6CkunTbtc
	NXO6o9hmJS9RTrT+/ZIRh6sT3UrJ8TadWpMYIE7IqGF4yFh6hrQq4wbUUQvdYRc6eVwwLFyqmM7
	edvKm
X-Gm-Gg: ASbGncvto6UektpAmemzvQQjp/16tgYW084Airs1bmyEPmJlhTJy3y14tpQVAFlMsWG
	qHS5jzk+e0k9kV/wvWz5fBZmztIeY9mfP3mI20nziAqvJkzj0fUFPM28K7FZIATxoKrCWGo6MnC
	3RthZD5PJXZ6KGA0BIhKOMpzR6Vc+hXEbfNmYTSXmztTU4gYwDqyed3apd7fc6cum76G5kN2+pj
	eCMTIRiMF3bZYhH0DwuJQSUH9elsRgeHd80oPTeKyhScRtcMIFaAFPSDm7FiAlouu+M2BHzIBDQ
	nAD0qxGT3VifqxTcJXk9xbIhyp5Bp0YPvq77IJXQIR8h02X3xYufkVsw5bH/gD2w8HQ+1oWLmmP
	u5BJkPkCqhVNy9lH8/Cs+7MEXePoZoH8hUEasWRw6IRCZ1R9TBL0KIQ==
X-Google-Smtp-Source: AGHT+IHVO2xx2tTkcDBEtjuj4gJHVvzoY8oH8BXEzlWOPZtIJIQCQyKKLIJ/tfJYozpgD5KVlcHpvw==
X-Received: by 2002:a17:907:3fa7:b0:af8:fc60:5008 with SMTP id a640c23a62f3a-afcdc19d2bfmr473164466b.4.1755528040250;
        Mon, 18 Aug 2025 07:40:40 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53c46sm815872866b.18.2025.08.18.07.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 07:40:39 -0700 (PDT)
Message-ID: <74bc063f-b9a3-4ff6-b907-3f8803beed28@linaro.org>
Date: Mon, 18 Aug 2025 16:40:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] ASoC: qcom: audioreach: add support for SMECNS
 module
To: srinivas.kandagatla@oss.qualcomm.com, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818125055.1226708-7-srinivas.kandagatla@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250818125055.1226708-7-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 14:50, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> This patch adds support for Single Mic ECNS module, used for echo
> cancellation. It also makes use of audioreach_set_module_config to load
> the calibration data for this module from ASoC tplg file.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/qcom/qdsp6/audioreach.c | 27 +++++++++++++++++++++++++++
>  sound/soc/qcom/qdsp6/audioreach.h |  1 +
>  2 files changed, 28 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

