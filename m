Return-Path: <linux-kernel+bounces-883226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D15C2CD38
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5368189C6BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76531D372;
	Mon,  3 Nov 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZD8IbO1I"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E863191B9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183254; cv=none; b=Mt3CSUjahXyUYzUSDoVyHFYAi4MIo8bHrjQYGn622OH0dHJ1BYu7aSPZpVl0lIFUpdJpFsDWvA/g73IeqMSvogtd/R55Z2M7ImmcrD+aL/WA1aQrdOd+7wH4DxKFBX788S6AhMbDFgdQVopdb1irM5WVY47BHY2/7FbBa77qUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183254; c=relaxed/simple;
	bh=lCHtQe/XUv0C3M6ixsewWlKvViVNAryOiofDkbNl3Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CxKy6nc7Urmyq/++XFzrdey7Xb26DmaXdbxIt6MKvlClOoYtDyL0Xu4a6D0CmKunkecCuulF9AZWTyxuo6/XBa3nMA1kdr8NsY71+UXpvqRojlSaOmcfW5XP7vRCN9rqDxYcvj3HTV/y3V3I6G/EoIMPro2g7UQPlJ+u1Fbyyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZD8IbO1I; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c53400935fso2851913a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762183251; x=1762788051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UU3IMwLVIuqUs9WFksfEbffdOpEdabEos7vPHn21iN0=;
        b=ZD8IbO1IUwKTJ9T1AVdGhe4mLoahqyPmUahRXcclM0ECsRAdmvb1gM7r5K66qOnmAG
         5K3Dqe1tCMT/Ky1mGTweNNPK2nmAu9ylEL7gOrM3zcXrgUSZk4oaNyhENnsyBVaWoipM
         aiDhTrY6CTcmf+jPBT8OErwj93F0vsF4ye1HEbINUw4PbHXZ0Lp5wN0wsytBlg2o/Kk5
         d5YsCokRx/7VAvJwXs2on7ZDdWjETAnIFSJus1HpseQysnq8hyUkwFs5V4fRpWFaSU9Q
         pU7WmbT+fuF/zezkNPcbS1f2ToNy5SDmPUCsb0cbGC2WnMCrUolW3NiSYguf5Gas4E1u
         78yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183251; x=1762788051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UU3IMwLVIuqUs9WFksfEbffdOpEdabEos7vPHn21iN0=;
        b=E1+74o/aMSaswdd10C8SXRuZNqvu4uQfFHIcb2k5LkoUQ6QIW+0pvG9+IkfoV+r0wq
         2KpZrjJWV9C1CkhmeSakvJ83X3oszRNEp6i2iC58v+gHdGlRbEDmGMk+wU3oTnUmT7m8
         RVApI9TmrNRBKFC1bNXf7lpn7yAAmmiO3C2rvIZQn0Z6F55KltfJ2sazlkUlb4RGf61l
         lxuOAkld2UqmbGrMxWmswafnITDazgm9K/EQ/G70oDali5ZgjrOBE+8T8gwILsx9bPyb
         1KMGzL+50mDcyX2L+IPGycC7vHuw++1ttmhyBbRe59oRZA5f1LCz9Wmu2EA7njtvFV1g
         TrlA==
X-Forwarded-Encrypted: i=1; AJvYcCXqMNzifA1kpxgSFn///i+nw2rmCJWs3HSb6Ktmu4xt/PprRNu+qu+EhyvFayT9EEoChXzG8LTyD8Vop/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2Wqbpn1t1xcihuJFYg6rK94ubRk2uJtHZ3xWDnZgKMWm/V+f
	LMNbyokhoCej/QJOvgXIwWgYvc0fzriUWxzDO1mg4ZabfB2lyPjftzTmFDF+UdLwNSA=
X-Gm-Gg: ASbGncu46QjqHsn4SEW5GZjzEAlZdcynw67AZ6km94ck3RqYsFYm0dUPA9GOFud/K3I
	/DvsepQIc9iUvnCtDsp0+tcMfioUZIM7S5M1hOyPb+xeTAukglvc6S1vx60Ey7W0YvhPM8hrqhC
	fxwQQmNLzgVcxLW/EHO9K9RV8KegVlC0F1KrlXAky2V898tDnSb0M8GkbuwM32/MlUg7OoNE/GO
	jzbNJHp+dBR/ZP/3o4P2veFQtVA4ESyitbN9zwh6+25FKhNtufn4ayOPB13nA6kGPzJA4QHHln3
	vCA6RAhPkOBaS0P2BQvSVQeZuDSUTtVUdG8e8UTKzdxZmFGAZieowB4etDQcoJQEjDzxVuMv1qc
	adgDr9N6QTY3Avz9fO6NC/2D2P1uXXOpRiHjoUWnQNVTf1mA7CAUkbU8dCX+fz7IIH0L1oUJiNP
	4QvXSHC69VknHWVBVsKD4YX8GmQHpnfbbyvAchdCMnLzhOTe8EnqMI8M9f0UWU
X-Google-Smtp-Source: AGHT+IEI7oaPwbMLZyrFhJm3x/2HChGggXyz1ZeRNUlqpKNsCrcEcUIruRtbDhBeLo27AIpbulOZpA==
X-Received: by 2002:a05:6830:67e3:b0:7c5:3bbb:9ba6 with SMTP id 46e09a7af769-7c68c82fecamr8720707a34.4.1762183250808;
        Mon, 03 Nov 2025 07:20:50 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:37c9:fd3e:34ae:9253? ([2600:8803:e7e4:500:37c9:fd3e:34ae:9253])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c2448c9bsm208886a34.3.2025.11.03.07.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:20:49 -0800 (PST)
Message-ID: <3d2fde56-d82e-40c2-9d0b-2888160a642b@baylibre.com>
Date: Mon, 3 Nov 2025 09:20:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: aspeed: Add AST2700 ADC support
To: Billy Tsai <billy_tsai@aspeedtech.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
 <20251103105217.1764355-2-billy_tsai@aspeedtech.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251103105217.1764355-2-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 4:52 AM, Billy Tsai wrote:
> This patch adds support for the ADCs found on the Aspeed AST2700 SoC,
> which includes two instances: "ast2700-adc0" and "ast2700-adc1". While
> they are functionally similar to those on AST2600, the OTP trimming data
> is located at the same offset (0x820), but uses different bitfields.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


