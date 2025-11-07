Return-Path: <linux-kernel+bounces-890756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6C5C40D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00821888ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4872652BD;
	Fri,  7 Nov 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DVgU43yO"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C025C821
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532325; cv=none; b=G6rJXmEUhdELw84LndzBSHVY+NwNqp/ebf3DSUPdYtxhLzzyINJ7l0kfVYs0wJECRwGlm2EPhmGkbQVW8zNtq7P9xgtyEnV6zRTg0IK3Hs+aO5vt88uKbNxVXdfzdlSQTJoVsCtNQZOYOYRgf4He5OHKKOnR2XCg6xhHU5p9u7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532325; c=relaxed/simple;
	bh=MFFadW4AJeEGGVRTkSO2f2472oOyet6bJ32MOkismQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukioqFo2OGMFElzrB92Btt8B9L7b/TxNnLuiGlf5JGvX+DmbgSAt+1E2GdHI38Lae0CzvqaHjbFITDDFqHdn3XZvajvilzJnWtGdk6D0w0xk8gRm4tHyJ1nEtR4MfTisDyvV8TIxT2KzPGaAdce3toiQobAE4YtP/A4oEU7Mx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DVgU43yO; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-656b8ca52e8so370631eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762532323; x=1763137123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKxzSH4u8vYUIO96ehvgaJl4xECRM9a2L3UtEyYYLt0=;
        b=DVgU43yOEFrCihnj8pHxL1vfuce44aeZPsvS+cyySmIejZhiQvljERQgeblGp9IEoI
         VIxdCMpxE3Yp5kTx0WdrzCCurkLI86X+4fpNbXO2VvrvBDidTlkgtyCtfbKGm/yWysIA
         FQz9hCFzDkM1dhvdrhCC/wdmNmdSTk3vR7h+zIj74znkmuvc5IcJM1xczehVIW/F8tbn
         VqxMg8VRNPGisLyJeaA6oXg3bNGi8xCITQLQPXdyOP5GiP1pDQBs5jZo89MMrzkJ8oBG
         V57DM3L74T27D7JhDOjQLFeV/+ukhFaSYsObrB2f1DnfQGjUXi5zdyRpPKY1M9MpZKNk
         HH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532323; x=1763137123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKxzSH4u8vYUIO96ehvgaJl4xECRM9a2L3UtEyYYLt0=;
        b=NWP8NVYgaqEX/hual82qRL2kqFhIKst3CzetYrfy+zx3C4kCi9bPuQuvRUxP0UE5p2
         HcZXce8uvnYfJpvwAXtWZaCzPF4q+vLdWZFX4pxf3TrsTM2z+oS87zMiAMZPGXVwDQe2
         CnWhMOWV0uaMNYQjeB1rucc0CivQEs8iDM87w9RFUSxDQ02jW4T/GVcUuRbIY9Pt3HkW
         2+61h8mvMxjMg4jBm6KT/nqompEZa/3HUuTEs/jreJWA/I0MWG4vneXnSU7ArfgXQBQX
         olAo+UD5Kt6c8AA7/067DAFk1qsb5EPUnNxxyVVWJECJvBVCZ/yE8L5Dqz0gTRWUytA4
         4vHw==
X-Forwarded-Encrypted: i=1; AJvYcCXYALzf9hhJjDeA2xl6MO7Vde1oBJ9xM1FTKlwYCXK788ekz0zz3SBNnHJpVjcKQTvXWM5EYCkLgsaoxMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+xrE5lBUqOt0e/eMofFqSxFqyjAxvOte3sHPGiOpSb7e5uXX
	cCQ0h+3SMnyZe2K5XRzPBXMg0+hlbSfg+/IQH5aLGSbkqYWvboOHSr0KLz1gI+mRFXSzC2P2a0E
	XK75x
X-Gm-Gg: ASbGncs4H2qb2Qt9eE73sTlJC8+E/3BB3FVsFJTXfZf4mhZ7GG8S94fDisPATLYf3dT
	lvF5+w6JdaGXRtOLtPCjg6+Sui+Ixr2y6KGcobreXxF1S4ktQJFtP5zRI5MT6/e4UuIRn7Dw9RN
	UTl6m1Avdp2yLDsIXaJbG6yzhiVJGd2mP+eRPavwGl4MAHvrlzWkPb5TT0ayiVewTG2qvsbk7e0
	+9XqDCPdOybCMHliwwE2XwPNQiFXF/GioY0pvbMSsMCpa0wU4FXPB6WsL4M4s2xQGd5hFWTpD/5
	dtkRTTSHCkq2clqU9gNhbgjuNFk+kNxI7FPxYnf/qDZYIjQAoXd6kbwoE6OLR7aLcagsI0deDaU
	EDBfo+/XXj1OB1DK/l5EcZNVQyQ1SPE/ryg4mQ1oAVz2k/lWwWKYdmGwvC9ecju1UwW0wcPGjbY
	whkcMO+3k7zWmxiY62W44XGOBbb+3Z6GZq5YbGwXyZf+3R/kSUJiKOEdW9+5l5
X-Google-Smtp-Source: AGHT+IE2+yDv7v36BhseMR5mBBfzrZuo9RFPzh74b5U7OD0iR5I9ldD4Wg4txKPbQueeWlJzRoQklQ==
X-Received: by 2002:a05:6808:2226:b0:450:d0c:50d9 with SMTP id 5614622812f47-45015ecf630mr1798144b6e.40.1762532322867;
        Fri, 07 Nov 2025 08:18:42 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7bb8:950b:327d:4ba4? ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57d63adsm2528160eaf.14.2025.11.07.08.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:18:42 -0800 (PST)
Message-ID: <de424e9d-95cd-4a42-8f1a-97ad04f5f9ef@baylibre.com>
Date: Fri, 7 Nov 2025 10:18:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] iio: adc: Add support for TI ADS1120
To: Ajith Anandhan <ajithanandhan0406@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <20251030163411.236672-3-ajithanandhan0406@gmail.com>
 <fd432bbf-f6c8-441a-882f-f8e52aaca0e9@baylibre.com>
 <a7532aa1-2acb-4064-b10c-b1f7022d589b@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a7532aa1-2acb-4064-b10c-b1f7022d589b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/25 9:50 AM, Ajith Anandhan wrote:
> On 10/31/25 2:43 AM, David Lechner wrote:
>> On 10/30/25 11:34 AM, Ajith Anandhan wrote:
>>> Add driver for the Texas Instruments ADS1120, a precision 16-bit
>>> analog-to-digital converter with an SPI interface.
>>>

One note about the review process. Any suggestions you agree with, you
don't need to reply to specifically. You can trim out those parts in
your reply. It saves time for those reading the replies.

>>> +struct ads1120_state {
>>> +    struct spi_device    *spi;
>>> +    struct mutex        lock;
>>> +    /*
>>> +     * Used to correctly align data.
>>> +     * Ensure natural alignment for potential future timestamp support.
>>> +     */
>>> +    u8 data[4] __aligned(IIO_DMA_MINALIGN);
>>> +
>>> +    u8 config[4];
>>> +    int current_channel;
>>> +    int gain;
>> Since inputs are multiplexed, we can make this gain a per-channel value, no?
> 
> Yes we can, However i want  to keep the initial version simple so would it be
> 
> fine to support per-channel gain configurationin upcoming patches?

Absolutely. I really appreciate splitting things up like that as it makes
it much easier to review.

> 
>>
>> It also sounds like that certain mux input have to have the PGA bypassed
>> which means they are limited to only 3 gain values. So these would have
>> a different scale_available attribute.
> 
>  Since, I'm gonna enable all the 15 channels. I believe we have to have all
> 
> gains(for differential channels). Correct me if i'm wrong.

Yes, that is how I understood the datasheet. Differential channels have all
gains. Single-ended channels and diagnostic channels only get the low gains
(1, 2, 4).


>>> +static int ads1120_write_reg(struct ads1120_state *st, u8 reg, u8 value)
>>> +{
>>> +    u8 buf[2];
>>> +
>>> +    if (reg > ADS1120_REG_CONFIG3)
>>> +        return -EINVAL;
>>> +
>>> +    buf[0] = ADS1120_CMD_WREG | (reg << 2);
>>> +    buf[1] = value;
>>> +
>>> +    return spi_write(st->spi, buf, 2);
>>> +}
>> Can we use the regmap framework instead of writing our own?
> 
> I’d like to keep the first version simple so i will add the regmap support in the
> 
> later patch since the single ended has less spi transaction to handle.

It would be less churn to implement the regmap right away. Typically
we try to avoid churn if we can help it. So this would be an exception
to the general suggestion that splitting things up is better.

