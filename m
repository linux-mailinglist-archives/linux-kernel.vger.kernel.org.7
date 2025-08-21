Return-Path: <linux-kernel+bounces-779974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793BCB2FBD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260393B6A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3952356B9;
	Thu, 21 Aug 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpuhgHNs"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97621F416A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784857; cv=none; b=XCEAO0jPUEF7cZ9vW45YydfXr8m3mSu4uNCtshFapCnabali/TeF6gWYwtIcv/QMrfFNufYa54rzoygmu4137ngHBh11LyqOEFdJrRafwMPmCoci6cX0t/eNtkBHgh5Iwbzg7eb7kPV4Q/tkYUURaqXT1g7wWgLBBQXh7h6CLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784857; c=relaxed/simple;
	bh=n8EeR8AlRHg9lyRDsjg6aUEaZNeYvKvFAxGGH0Dl8PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNXiei8HZ0jhOPsXxlEgwfXCYNN4OQlMViyRhS2uqTGsThTUJFvlcZkQAUzz+lbLkEXC5SxWmJ+fVfm8s9MNz2b9tfoSORNTvt9ys8011h8Fa+9BHV4KEPbFVBLrjrdg5Sy/keAbHjV6fRSxHf+8hsdkkjYpdK1VO/kef+USp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DpuhgHNs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so7569385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755784854; x=1756389654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8EeR8AlRHg9lyRDsjg6aUEaZNeYvKvFAxGGH0Dl8PE=;
        b=DpuhgHNsOHT65Vei5tB/ZB30cwg4KJLeNLOztB1MDSGorv5MCbJZlG++uRsV3H5Jr2
         gVYqtrxDLBrDh/CtasgWJXUeUetYIHNlY+A7L/fNEDmk5kJnhW0LYXEWP29JW1f8zzek
         KEM47op/Swxzfy/AJtcWq0Owfv974khND0fm6evYn4qOicuahcyEYvGYrk0bi0kRzDHZ
         710hALMOUbWX8HPfxWwNX7U6JIULGluTl7U5yHVxb1FOejycOwyESTQDTNYiI3SdUpC0
         DRcek3NXySP78HjLtk0W3x1UuS1pyGOmTWHmnruE4AqkOsOKWoxbMH0YIBoKKAmVxM0q
         Li5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784854; x=1756389654;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8EeR8AlRHg9lyRDsjg6aUEaZNeYvKvFAxGGH0Dl8PE=;
        b=Rw1hRuXoxsraZLmuUV2ottpF6ybcAg5UoPm7YvAey2jev/imx2UGN4Qjd5LxHSYBVM
         rgXslIZy/CuFFHo7urrWU72yILSSdB/UUred9XGRIJ35VYSQDxaRlET4iwoieTLyxQxr
         PcuN6TXAw/R77bzRHstBtoMISvAUVba/5fTrLMiNL5SINkDbtfbCYtpMzbqxQQMT7L3e
         CFfJar8xMu0EjHTxQaMmn+XGSFYpRiGQoS3E6F99dZq5AoOWLUImmP3mV9Bytwr57+Hx
         FE54QVJr0TnV/3RlipnutwVtHLNQWCrV1HIzzcsM3/u+riJfvQp3h0RlKDY/PMwBuAu+
         TRbg==
X-Forwarded-Encrypted: i=1; AJvYcCWj283yjcw6gVQq7D0duXM1nQ7xnZcmzARKeE8orDXIFu8H3EHv/1EOoBkkL0OLIqPINjSfXPftL4PoGok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxhuD7AQMWZ/0KIUy1cN017gIrFq1vcSbWqmKU4aQv7TZmwRG
	RmhfD7OU6iUrsd1VcPEGo11AHbb4XuHVBq5xMcpVkDK7NBrNSPozNbTGN95DM/Nlk9k=
X-Gm-Gg: ASbGncvNLnoOIqw0QItrq4i2DDvq+T+yZZOaIpn6wYGZ0SA79cJ6E6umyE+A4Ba9UA6
	xeSQ8m5uInQZu86jhbsdfwGVRuyMHo2eC6tg3nr6GtkUkM6+7HoF69DVUVLPd1LonZwb/9ljc4w
	YHSL44fsxbeZ/gDmbUV4CFondDeRDoaJLLaLN7Yv+fB7ZjiypBRUVcI0LOpAXSX/M58/BGaeMEk
	+jlYryxG/JVbq2PnUWW+eHveFhm48LzKwOM9BjU0wxJ2501ud+XrHm/2u5+G0ROzIL9RP8GMqWK
	AzS/9uBOiiX4L/bdZEoV/TIzx8Id4xHYdZkpBIWzwNlI6eK6kwg6cHfGnfgd4uVb2W0/DtoXvRX
	AdhG0STD9elZWXsc3RpQie123aulD4UyFazW2I5CEJLMIsLHcmi9Kl9+xkMDkwLxA
X-Google-Smtp-Source: AGHT+IHkgchaFKWj5e1UqRbNztw1zXa8xxHeaBCgL2s4YsQqE8YJMTF31NEBDYvPnsH/XtrEWLoDDw==
X-Received: by 2002:a05:600c:a43:b0:456:1d4e:c127 with SMTP id 5b1f17b1804b1-45b4d7d687amr24197735e9.8.1755784854158;
        Thu, 21 Aug 2025 07:00:54 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e8de85bsm12008615e9.7.2025.08.21.07.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:00:53 -0700 (PDT)
Message-ID: <9863f7e7-ef3e-4f57-bbbe-9ac4aa88a426@linaro.org>
Date: Thu, 21 Aug 2025 15:00:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: iris: vpu3x: Add MNoC low power handshake
 during hardware power-off
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
References: <20250821-sm8650-power-sequence-fix-v3-1-645816ba3826@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250821-sm8650-power-sequence-fix-v3-1-645816ba3826@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/08/2025 11:54, Dikshita Agarwal wrote:
> Add the missing write to AON_WRAPPER_MVP_NOC_LPI_CONTROL before
> reading the LPI status register. Introduce a handshake loop to ensure
> MNoC enters low power mode reliably during VPU3 hardware power-off with
> timeout handling.

So right now upstream we have an incorrect power-off sequence.

In which case this is a bug fix and needs a Fixes: tag.

---
bod

