Return-Path: <linux-kernel+bounces-810342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2432BB51900
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB041C879C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D758322A1A;
	Wed, 10 Sep 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5rKPwR0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226B321444
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513341; cv=none; b=HK57FSBSbWwkbgpyKPrcMCnHroxiaTlMzo/uYczL9t9iHIbauJU3O8X4rIP0MD/cyTdwOA++rw8ESjTP/7eE4/fXGQmA8A/hXpgThm5/jiHfAgVq+AOeEb4RDhIE/a9JqVKw/R/tELhzu95+UR/tl8s7q+RK7V/N8E+xXjSazwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513341; c=relaxed/simple;
	bh=jyWB+tQA8G60dRJ1a/3JvX4zUlNMFVNjVgIRaHfH1XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfIIslCWcwk2p+Z1NbdWgcZjMTgkAOzsufOzk4mF1R9m+oEyvDhf8/HOtbZGg4jE2975qgYmzb/NJTTCgl6qEBgyA8kK7yMEou6/bepOlFu3DbWH3c+biiGISOE/XSX2uCODXrdURUYsJ6002QM0nxJsi8hEmALfDE0EIMvGA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x5rKPwR0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so3909813f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757513338; x=1758118138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhI8c9fUpWOPpWCEzFMrs816kFgN9hDlCR19oA75+ZA=;
        b=x5rKPwR0ni9QYPahflyh7NA9BywfQ1qQ5La0+gVuhhZeJ9sK+AEoUC2X65Zx7lLWEn
         jqDPnfC3wtM+wkkqU7qpe9PoAaz1huAyCIUlJukCawdssv6AFIY6Y0Sh3tu9exrUniRL
         e0YhXb/VLJeaHd0idlMr6n2e4yABsciHBWwZP/6Xs4JBgPpx5vWOPqGDiPWXS6jUWZL3
         iSFI6cSJYaNYpKLZSJZ8bzBd2qur5DiR/po1Be8BW6TXu6Io1Yc9KsjW+3xMK8RqDVKI
         018cxnb4eSquZhCnwYXqDrKgRwyntTleHA2nnux/g0swOd3BWmkHIrJ4GAvWPricRrKF
         ToDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513338; x=1758118138;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhI8c9fUpWOPpWCEzFMrs816kFgN9hDlCR19oA75+ZA=;
        b=F4f6h2DAq8/BORIB9YHOBVwPy2Uvcz5+CfCFswpuLCzqnA5KEM7Em8toypqe7DVfb2
         xT3rvb29Hnbc8+8e/9x1wWVmuQoFRdatj4GTSCdffEixS9e+nAKXARWukD+p3oWAdKBF
         OMLiAbS86o92GT9FQg/km5sklnA1bJAhmDsZk0jc7geB1232TRudI9wBTemJ32EAJunn
         YNRIh9FOZ7LE1qmEbG53Q4ENNKbpYVgdl7EQDPwLPSOF+a8+TD/cQunbypm9jNWRo9hH
         /xZOH+OCYCJPFWTc0JqpC9WgqvKycZOt3b22PchuPQYFTxCmCH1KzC2AI98cZCmvhlWI
         +usA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0S25eU8QE4gZpnwuqWLzjvE5VLHCRhlhHqeyAQZ7+x3TLBB2bf8R+Hf8dkyXVoDXkwy4W+cks+O2G0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmEoPKEyn9rKNnj+4mX22dK0Ofy5YCNy2D+8FOhvg2OJVLK0Cc
	qGXoTs1X79+/mjwr/aahSbH9/YGpX9QEpIqQ2WGlGqmkv4mW1eIkR9+uKHLy0xsoRis=
X-Gm-Gg: ASbGncs1oyJNS5eokFuctkhFq2VHz1ZjdEJ9SGHtUDpgbdVw1P9eMbqlsjUQJJdoSvN
	K9On8nb6iV6IrIladwIdf0XwkE6naNbhwNdfRKLm1mtlTLu3C+lglX75C1kixGhgw73AEhTPORM
	0bzpvCqf4DgJLtG91sZ52O3Bhs54mKPi2BECbYYxStIOeh3KbA9A2vKxawnJHm50vNDnHRU1J7V
	AiKEDIiMBniZul/SQrQ6++3k1Qifj2TuQsrGmg/RNf6WpnUEBXLZy1YK9Ge2oq1Kp2fOCTO3J6b
	lQvluhnEXkPwxjJAm8BrYS2kcNGy+Sogyigx9CYhDk4lLDBIhUoo4Fv5nk43zy2eV7HYTIW6B/w
	Y8x6JqovSt4XrfrOcQj+C+IdoaDGjBZYtOT6NGHsIVX4cQ/chs52k1pqFfEH41tDkSpXo2sgWSw
	yphseUuhUHYlaQIjAUDqUej0R9PsqLpG6Nner6EPQe
X-Google-Smtp-Source: AGHT+IEU0i5tKvI1IML6r1qb9OCYAjtEaa8WFITlkibEW1V8pMtdtSftNzuAhODsfk/YrIRjrT2cRw==
X-Received: by 2002:a05:6000:24c1:b0:3e2:ac0:8c55 with SMTP id ffacd0b85a97d-3e643c1a48cmr13509406f8f.55.1757513338089;
        Wed, 10 Sep 2025 07:08:58 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223ea04sm6916892f8f.45.2025.09.10.07.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 07:08:57 -0700 (PDT)
Message-ID: <e72800d4-cb65-443b-be7e-0966a60fa5a9@linaro.org>
Date: Wed, 10 Sep 2025 15:08:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3.1] media: dt-bindings: Add qcom,qcs8300-camss
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Vikram Sharma <quic_vikramsa@quicinc.com>, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
References: <20250813053724.232494-2-quic_vikramsa@quicinc.com>
 <20250910104915.1444669-1-quic_vikramsa@quicinc.com>
 <21ea1149-9b61-487d-9afb-d3b8b41fe71a@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <21ea1149-9b61-487d-9afb-d3b8b41fe71a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2025 15:07, Krzysztof Kozlowski wrote:
> On 10/09/2025 12:49, Vikram Sharma wrote:
>> Add the compatible string "qcom,qcs8300-camss" to support the
>> Camera Subsystem (CAMSS) on the Qualcomm QCS8300 platform.
>>
>> The QCS8300 platform provides:
>> - 2 x VFE (version 690), each with 3 RDI
>> - 5 x VFE Lite (version 690), each with 6 RDI
>> - 2 x CSID (version 690)
>> - 5 x CSID Lite (version 690)
>> - 3 x CSIPHY (version 690)
>> - 3 x TPG
>>
>> Co-developed-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> 
> 
> Fast review only as courtesy to Bryan:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Next time patch which cannot be compared to previous version and has
> broken threading will end up at end of the queue.
> 
> Best regards,
> Krzysztof

Appreciated

---
bod

