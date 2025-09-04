Return-Path: <linux-kernel+bounces-800584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88800B4398E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A71B280FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312E2EC08B;
	Thu,  4 Sep 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqTbwK/I"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65CEACE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984030; cv=none; b=Hts1EkIAIDo58Zf2cmXcbpKZlC6gEytPrutBtHGb9ZixsBs4cVihSlIDHV36ax4U952BKh3JakMOOsWIuuUXDgg1ILT9B3Fw1zzEgK8f2BtUei2TuvWAxJrMkj4XklwCAGSHFS18FfBpk2dsPInAofXExy6mOKDJ0nyADcWLU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984030; c=relaxed/simple;
	bh=J2pBhxhghXplw0Hqz+kXCsTp6S5XJ7enN55w8p/Thrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r+HcNGXUotJr+Yuot+cJezaDtdpj9C9nZvAbJdUaohMn3NQvt5vctjH3W61P033/jA8PBx3NV6TTRGrgF2giWJDVbDKs7lEOLV3OQHP3FmXy1tlV1LYK9+eRw1Mf9kmc0J1ETyGUuaW5EN8gwS+7RKF2v2JmVN5pEwUDxxn+vA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iqTbwK/I; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0413cda0dbso12752266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756984027; x=1757588827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnJgKrqBWNihEnRqMKFhK2JevtMYzvav+LYzDruEobc=;
        b=iqTbwK/IFy9PCeCPoPgPvJtDvml4LJCsMxpd3mRSH0WwjgjMhi84mxCGdL+Uhk1z9K
         Rk0dF4W9WscfHQ8o8TBtV5bRoayJpUoaHdpV0xTz9t/If6kcP2ORjBda0RMi8VzFfkK6
         RfO/BCsIMU+GOGXOHG5qYqPB8DIKvtyn/EWaugE12KsVciyEEzfhWB1KzM3RXBKQzFTr
         lpQ6t2pbBpKB5NH/f4eh2twU+h4ds0OEiWMyf8xLPe/cvaXsRBFdwdYYwhVxmmmHNfqW
         yWF5lQ+8otqIEuboEpUaOO6vfan2ePAa4cLn+8vqpWZYkRooaftvfP49MpxeYUYXVZp8
         h0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756984027; x=1757588827;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnJgKrqBWNihEnRqMKFhK2JevtMYzvav+LYzDruEobc=;
        b=ikZRypjwPHpRWuYO2r7O4H/AuHelHkRscOx8CyFG7VT7jG1MtOet5lU4KzWjllZdjO
         LOClOno1LedWCqk8Klkkc4KXwTKwPPLJAxcOmEXlBksJpYoN2iuRPOvkwXlcLNM5fh+p
         FBoNJ1o7mV2yvyWunXxPn1Hq7g5iKvs/yhsVf3ZrTvTV6NcOB85Rj2fEOOru3cr/5jHJ
         62oKDbzPhhIObqbvmr6c3p7ii7X42qEpm0Jh7LElW5+LyWL6+GzwW6o9/6zAPdlEWgRc
         y1Ux5vuLVmQ1VGDZZAQ8sDUz0rA6hORLdtXtF4f/UEveYWyIRAdqrJFntPmpN7s6sSmX
         zmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrZg5+YpuSAsU4Wht/uaq4Y9htjP8rHWtTyOcKCzwk52KnSaOhjuW9MnsFPoidBm9/OTc9n0BABF9x4PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQpNKgcxUna4EufBIQV79TzF6TPka1h/o8xCwlELzaCdpw2H6
	Y1OMAoFC5CSzXvLBkt9R9I1y3+pxgkj4UHutyLmHa6ngLf29cFICTOlUYW/TzIJTtVE=
X-Gm-Gg: ASbGncuJOQWeRffyO07JOP7BI5/Nt5LpPFr161gpBLVREUz+yP4fKSDCxbnbONYzWs/
	lCJcSMjgatKqQvr03cMNTxqupdpK8D5rolnhEtLUxt87txFJV8oEdRRfCOQ2Bg2e6baRwPYTmss
	0GUk1xM1jVpgS5PZParj5mIArbkCWn9DkYU1fbOvYBV6KWlAVBTmLdBi+9VPZVvEikOXmB9cfrQ
	HFzG0enO4E4mhYRsFVn+3y3pgW2gieV64jFBSTvXAK9mq82rPQQOq6WGqAFa1z//3UZyvmow4V1
	uFomPdTF69LIU4bLY9RKJjYZGGTdkEoBdanMQlSSwq/Kx12TTGD0Usuu9j73W0gpjIOXtiB4Q6S
	ZTHK7k6LVOu7a9gso97/m9iaWMY72KgzN51elMtswkeQ=
X-Google-Smtp-Source: AGHT+IHDDYnbw6yuFfiawt8DM8tY/uQyhjYDMOq2PATM1vggCKzDOXH7c2xeLilfIc5CkgohDVaFaQ==
X-Received: by 2002:a17:907:60d1:b0:b04:74c4:e203 with SMTP id a640c23a62f3a-b0474c51d62mr188284166b.4.1756984027302;
        Thu, 04 Sep 2025 04:07:07 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0476e0d61esm217638066b.53.2025.09.04.04.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:07:06 -0700 (PDT)
Message-ID: <53c36fcb-0d8d-4a01-8c89-6734379c2b27@linaro.org>
Date: Thu, 4 Sep 2025 13:07:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: qcom: audioreach: Add support for VI Sense
 module
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904102558.143745-3-krzysztof.kozlowski@linaro.org>
 <20250904102558.143745-4-krzysztof.kozlowski@linaro.org>
 <79274958-52a0-4041-b4f3-365ee84fb088@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <79274958-52a0-4041-b4f3-365ee84fb088@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2025 13:04, Srinivas Kandagatla wrote:
>> +	op_cfg->cfg.num_channels = num_channels;
>> +	op_cfg->cfg.operation_mode = PARAM_ID_SP_VI_OP_MODE_NORMAL;
>> +	op_cfg->cfg.quick_calibration = 1;
> 
> This field is only valid in calibration mode, we can remove it.
> 
Ack

Best regards,
Krzysztof

