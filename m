Return-Path: <linux-kernel+bounces-795596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7DDB3F507
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D9594E27BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818112E172B;
	Tue,  2 Sep 2025 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhNiLz8g"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A62DF158
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793315; cv=none; b=skAiWsnQFwaE8kEHVo2QJYKyrb84UdOTblK8QIVENeXDnuB4kAA4C8ixSkOqIqOw3NmAez2UitgUhYt5Yvz2Xr/rH1TxGnNyhzhuu4PGZhPtdPPSwjWqwGzLZoRNgMNlGcZCLGjGgQe/N6Zof07nn8EyW3k3MixBue5R6Qwy5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793315; c=relaxed/simple;
	bh=QLmvwmUq5h9swX0zLB+DgvjIevRVWS9QWn5BkMcxYSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i73Euhq4845qqkbhf6DDAnj47Per02sVeWwMFfUzIUl9t1ai5w72WQv9q1jyeBqoqtG/6hsYzemrbySzPs/GGM52Hc0UfjlFx3JREUdb/FupbXiL2qolkzXKqrByrwekj1Y6gcAtWdaXtB7IVkzM1PuHcLsFnjeVxqDySyzeMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QhNiLz8g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0ce15fso6005765e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756793312; x=1757398112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aHeN40gFm9aSbsJ2megLoxDLeCwIuUbaDBPA1LSwj44=;
        b=QhNiLz8g0TrScz4X7OJPwJIH7hmIE/Oj0Ta2PJqrXafUpkHMyz4CVopN6y8cwXB/8m
         DhkabecL/PUpfASzzvtYW1cZwZuQ50QKjVRVJ7xMqnkX7GKfuonvp4f4MX5PK7OFAAzn
         z/fX9sOgGM/ZcbZB4NY0jF0DlQ6+NzzAFoB8Pxt5R3o/HOs1oLRBLvgypv3hi+jc5U+K
         zZmeUVzimdCJAYFl8HKCzL5BPt7Wt2jbs9cng+zEGmQcN0iVLJ0rJgSvNh85viJrKYPB
         6Vi3SjTn4qlbpSes3xlFPD9l38d463D973q5r4s+2NY0Z9URb71c6FCoGyCW8jH82Hsh
         iwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756793312; x=1757398112;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHeN40gFm9aSbsJ2megLoxDLeCwIuUbaDBPA1LSwj44=;
        b=sH6o/OkqPOH+BiB45a6rxQZ+Z3PX3542wXzGMnCANKKHg5+NXwfG+xecLcu9/kt7ZC
         xngxWGyBOV4jNkTc58jzD4tJstYPsnNaMcqKjqMM99gcWH0sZJ5K/vWV3DF1Onm8poNJ
         qX1mHzUF5fAIXeDDhBSBTHa7U+sSz3IcqkttEbzACcwBfIRaKNw1S90Q+k9WWHJzYkxm
         HbRj8JGyg+8lofDSjt848Ox6sSpwSYgZevorK4epsd1ddP3dHWic395OrrLNwnpONWiJ
         ExQ+CfRu/3WG5vmUMP7NZAdWJiw50S40x8WSnxLrYUFk158v1topO24JPlPGXpR7PzZJ
         POAg==
X-Forwarded-Encrypted: i=1; AJvYcCW5wxko1f6Kd1CLYzjAXvJ9Igi/0QUj8NzCWswn5AElEKEnC+tY6DUlky8wOldr0PB4ceOezL3OxUnhRqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaU5mZeRJ0uIFzFXDQyhg6KyD4KxiSmY/njRf/VE1X0YSwyfoE
	2jxWqBFkiQyRDG2UgTt69VkR2CkYQ9KnPmJsb9F/jPquqvySRvznj16qQT92VPB10Wo=
X-Gm-Gg: ASbGncsNnQXkUtPIgDXSbyvZ3Q4O5hhjZpjThUF2nG1lXTtktEDnRZu/PbpZuXhzayg
	Wg05UO8dk/PaSDoiBnnJ9kkl6Kk+C7TQ0LWhDB/O4G3kd6F8b+FDZ8vDhH1WPzI+Q33/dillKEc
	gkrngc0sW2MnEqMhpdC+/Ssb2pEwUQpUjUFgakcUtciGspG3egEsTkBR6JZMuhkZhZlHTCBGjP5
	ZIkZt2KZJPKWaBGx9cKHsFM+UewrSezeKA5wox8OCPnyBJa54VpjwI1AmY6joph4Umt50hBLgJ6
	RaYz+GnF8kyE6BkSMiqgi8D1q0ncSOs4WaEyGmCDrjpXxzS3IoPNhExMAPepcDRGWmRzxlLWIlo
	FRXWMB4a8IKhH7HVmJNZnV4LI1hDtK2UyLamIJ8H1iBYQOJQCF1Jb2Q==
X-Google-Smtp-Source: AGHT+IEB5wuckpDue9hE5Qf/P4F7Pt5W6ZlSWYjEWe35YrVRkFYFEWEYhjdcJ24PGqJvwq+T4CniLA==
X-Received: by 2002:a05:600c:37ce:b0:450:d5ed:3c20 with SMTP id 5b1f17b1804b1-45b81f23e6cmr60632745e9.6.1756793312438;
        Mon, 01 Sep 2025 23:08:32 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e380b77sm187960455e9.11.2025.09.01.23.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 23:08:31 -0700 (PDT)
Message-ID: <6889f493-f37b-43a5-add8-8e170e295492@linaro.org>
Date: Tue, 2 Sep 2025 08:08:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: lpass-rx-macro: Fix playback quality
 distortion
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
References: <20250901074403.137263-2-krzysztof.kozlowski@linaro.org>
 <bect6bxzxmxguqsrxkchbkhhxgz5lmnzzkwwjyvaca7qtlfz4r@lxmmfto2qkm4>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <bect6bxzxmxguqsrxkchbkhhxgz5lmnzzkwwjyvaca7qtlfz4r@lxmmfto2qkm4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2025 04:40, Dmitry Baryshkov wrote:
> On Mon, Sep 01, 2025 at 09:44:04AM +0200, Krzysztof Kozlowski wrote:
>> Commit bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused
>> AIF_INVALID first DAI identifier") removed first entry in enum with DAI
>> identifiers, because it looked unused.  Turns out that there is a
>> relation between DAI ID and "RX_MACRO RX0 MUX"-like kcontrols which use
>> "rx_macro_mux_text" array.  That "rx_macro_mux_text" array used first
>> three entries of DAI IDs enum, with value '0' being invalid.
>>
>> The value passed tp "RX_MACRO RX0 MUX"-like kcontrols was used as DAI ID
>> and set to configure active channel count and mask, which are arrays
>> indexed by DAI ID.
>>
>> After removal of first AIF_INVALID DAI identifier, this kcontrol was
>> updating wrong entries in active channel count and mask arrays which was
>> visible in reduced quality (distortions) during headset playback on the
>> Qualcomm SM8750 MTP8750 board.  It seems it also fixes recording silence
>> (instead of actual sound) via headset, even though that's different
>> macro codec.
> 
> Wouldn't it be easier to assign 1 to RX_MACRO_AIF1_PB,
> TX_MACRO_AIF1_CAP, etc.?

That would be basically revert of mentioned commit, so same arguments as
I used in that commit.

Best regards,
Krzysztof

