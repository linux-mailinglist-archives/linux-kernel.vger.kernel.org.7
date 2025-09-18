Return-Path: <linux-kernel+bounces-823671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C890B871EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D43B1CC3408
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D3B2F9C2A;
	Thu, 18 Sep 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdgu7m42"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F92EC0A3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230707; cv=none; b=ppltAAReJ3PazlEvuMt0rBmDh/K9+0ckdhm846tLXVaogWUEmuUjI5spaXJIFKFjH6z0Z6m64FWlvucasBXTFmkHBLEFm5XjijZdvZfFSMOBSHFHFpNQBgdZdOaks/RBibAg6s+ldB72FO1eZCxvISKMxA5YBANKoTwyOZ6ORj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230707; c=relaxed/simple;
	bh=0Orrvnym9z6mx+qpAqsBTHEzgkRRZum9L9LV5MLQZns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6c7wHZsUg8AU4RON7A70Jwt+BcBYpM89TJmIbGEwS1tZZhB2EEow4eRFzwqITbykbqvsbrvBopP2iNQJNrNZ69iGliiFLanG7RVJoJcK3EorP/hcsslF73jCGMQINBbB7hDFQqhf7hUZzuq/9sSgpwco2fa7KjNGsEUyu3v5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdgu7m42; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-467f6fd4e82so622725e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758230704; x=1758835504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otQb23FFW/XLhr6Oh4NQ/t5sBVjKo9CxPKgxi2MGprU=;
        b=jdgu7m42NDv6ixwTSCratw0l9mcTHs/P6NKZbRYnE6OfYFPFsju6KnRP+UixwzdCHW
         JVrtA99LnWM5Z982z0SOHpWmUVk7S52HqXHXauIFZn5r9VRM8frmst/KczF/RAtDuKBd
         ybTDX9rNq0vWKRR7gUB25uVYrUTg3qxumLQdoKBR4L3j0TAxtom2A6jvYeUYK55MJE2N
         CRFvjTNw1X5cqeSpc1Y3/4J5M2SFBS2gMbyKZvSKfm9Z+AY24ah8WyW/DXbFlQjQx8eQ
         /KqRwa5+C3ISqAWgLIv50xYCpTo4/G7nENkcelQdfrQ8pvvehHEDKqLVZNqSBTtHkRxS
         blfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758230704; x=1758835504;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otQb23FFW/XLhr6Oh4NQ/t5sBVjKo9CxPKgxi2MGprU=;
        b=aza7PygpIwDhpayMOO6S4tYwAsvClgKpLKoEBO06kmdYud/CDXIOBOMytBNojc7ayk
         DiSnHIe/yu/PDik4JHEFodb2epPa0ByRhFu/6W6pDFB0AYER9LB2h5FQ1OpAAPtQxm4C
         TWxBAiD4lKzLJsoCP1nrhlmVTf13iGncJnW5ADFr3G3QR+F24d1rsyhkvkpvEcPg/huy
         UbPl4z7PJVesP05sQdzk0VKxL9sJOHA3gqdoJLuVB+wn6pTvihBl02ur4lw2nY/Vg6mI
         2yuRfknvS/NQb8J1RpRWtqitiP8SIABcgxcwEdCvC9XpRmo7JDVN+gTD1Mmbk8fQUS09
         unWA==
X-Forwarded-Encrypted: i=1; AJvYcCUCi7PVtWOEkxtnaI1Z+JA4s32/RiCq1cUgBlFacXdyQqT3QwsGONXrndHm+WOgDxPTo6IdDIKHAt2PWh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gZaIYPxGkHeUgtawZm4AVUuk33Ains0jJaEaSNx2Q8nRRLhA
	JP1RMQfsJxPC1gMPaB/aGOqpkoevwlvK01lha7T6PqWiRbrE1EevZvI8RQTil/kdLO4=
X-Gm-Gg: ASbGncte1wPBWdmSJhHa6e8P+wkSSpZ4+qWx2WNSKEXt75NAmtFsUGP5KKeGMPKRmRk
	DLbWprMnONro4tsNlI6bZr7H7l2AJAUrrM5XqgX8kfV27593nR8yZjbIRrMH1Wr8/MYpqQuhw5y
	rPIUQDQBIOS5kD76G251CsP296NP57rFmvbyFgeVULqjQjx8G811G5Lxw8yJlmv0HocPeFBTw68
	l9nE5tbHpimOS8qibpxPx6aUlcRHAOa7DiCeRG5Nl3zo/Sqj07c1EcIZ6AOBk+vA5J8lMWZ4FLf
	/d2tFZGHgaupfIGaZC1LBG9/WxR8IETnoAvRX5aOjRdQEhMiM0cXWp1YMyTTmL+7afGyBxocTHG
	AQtgYM7RD83fNV1mmX8mLyR5QQkA3aN3z2LCBwMVGqFCyrZ4SlAoyT53ALdMcNChD2G6V+459x7
	tVzEghmMKI0hr8n50Fd4S/hCBvlJfDnW6ZDE/Yyw==
X-Google-Smtp-Source: AGHT+IH01Q3BMBxvVH7m//3u3Ebb9hjBK36gAEMhS02bZTEjbdioULidegt2Ht2MGCXIEyWOW0PaKw==
X-Received: by 2002:a05:600c:1f85:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-467ec45ff4amr4854965e9.36.1758230704012;
        Thu, 18 Sep 2025 14:25:04 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad359sm70611035e9.22.2025.09.18.14.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 14:25:03 -0700 (PDT)
Message-ID: <0bb932e4-9fb5-4ee0-bd21-6e30d6c8044c@linaro.org>
Date: Thu, 18 Sep 2025 22:25:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: Use of_reserved_mem_region_to_resource() for
 "memory-region"
To: Rob Herring <robh@kernel.org>, Ming Qian <ming.qian@nxp.com>,
 Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Ming Qian <ming.qian@oss.nxp.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250813214949.897858-1-robh@kernel.org>
 <CAL_Jsq+vUNtMw6JS0ac6a8LTdJBB+UepadpDxP_S8vr6QwUiNA@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAL_Jsq+vUNtMw6JS0ac6a8LTdJBB+UepadpDxP_S8vr6QwUiNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/09/2025 21:22, Rob Herring wrote:
> On Wed, Aug 13, 2025 at 4:50 PM Rob Herring (Arm) <robh@kernel.org> wrote:
>>
>> Use the newly added of_reserved_mem_region_to_resource() function to
>> handle "memory-region" properties.
>>
>> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>> v2:
>>   - Rebase on v6.17-rc1
>> ---
>>   drivers/media/platform/amphion/vpu_core.c     | 40 +++++--------------
>>   .../media/platform/qcom/iris/iris_firmware.c  | 18 +++------
>>   drivers/media/platform/qcom/venus/firmware.c  | 19 +++------
>>   3 files changed, 21 insertions(+), 56 deletions(-)
> 
> Ping!
I'll pick this one up.

---
bod

