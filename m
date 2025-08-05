Return-Path: <linux-kernel+bounces-756115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A786B1B031
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E8294E1BCF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13880256C6C;
	Tue,  5 Aug 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZCCYivz"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0321C167
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754382600; cv=none; b=dmbQb1RaUipXp9ydKxJr7TdAb3vxQ+0YvF3AAoSLzCT8y377kIjR6UmqNthZmihIwhlMSpFKBrnRzpUKJc1wH7zdRzlgt32HVpGlWLJ84DEDpe7UgXWswwVz7KBEKfWlB6ifImnbRkWFyllEg466qAgWDSgpRRF62+1bj6x0p/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754382600; c=relaxed/simple;
	bh=vwzQhfg01r+binZbgcr7a/QRd8jw9d+nqmk4LD/Ao7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnGDW3swVfkRIjJyVDf5Kof6NCZOIGlRiRXWiBvYPsqTs+y2pscoKfPJQhSBqelrd0zpte5Vwf+fs2fEWkWXLlpJLAUGDkoq6+yIRdoOiF10UOJYUR9EAtdKlqsCCvBd4HTN3bShx0BTu9RHpLAcY4HRFG0C/cDZQPHbcOApvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IZCCYivz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7886bee77so4416342f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754382597; x=1754987397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyLVSQpb0tLUDxNzw0tajIN36UwJANGlESlbNcPlm/w=;
        b=IZCCYivz1UdBYRbyqXOFsSsdBD+OVewZ2mq5hBYhG3Ysk4YBNTV8sTXheoEQ7WccX9
         0p1QNCnqkUZ1awpVfCwbDdmD7Gx1MHFIQ6rKdeZlZy/JsiZL4HMFpV+GKt4atwHu+hwj
         tHtdzZ3pFFJ7rrBGj4AkirlShDMOaOWqQmUzv1vvZPzmx+2zowDn8Gtziu5dSwIql7DF
         EYTg/5E1vZnYkFv/KRWjoukykaO/P1H6jOwG6U46ubKnXR33QCUVeYEBOkUe2/QD4ZsO
         V1BfJK/0HXhtaS8h/X+GophK3v23cg9GNetIO8xAc65kI+YcSf/gKhRtwwFxUYxKm7Aq
         ra4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754382597; x=1754987397;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyLVSQpb0tLUDxNzw0tajIN36UwJANGlESlbNcPlm/w=;
        b=Vc425RtTl09aF2ZwnRRHA5QjUFeDeeJ0IK4BH99HeKy059zbSL+5YKevGU3ruqtGpz
         pS8OwwriAvedwBd463R5sLqw2l6wPnLqhVDs8gvmc230SIh9csOiJ6xiYa5S6W+EORHR
         KR48XxSfRkEUEFIgMm+3/spjq6kF0K+XTl2/ePrh1nI+EEUjbjHS7M/f4Q7G98eaJfuX
         qc/hPV6m8TmDjnZliXuZPEBVJGQPKusVGhCiJ3LIbA7oardPlwe5wWzDDR4Q9Ah7geW5
         jn/s7JCrvC/23XAYR55iUTw72aIcjvCBCqT5LkjtV38eZTj20BKtG/6RlI4ua35DSXq7
         jQiA==
X-Forwarded-Encrypted: i=1; AJvYcCWMe65NMLN3TSs9czGvZITGgLdDZRgsFvYdf56uYJ96Kn0uqO0zPd5G8AY8sSM3ycnAb/8WtGZ3RHfMl34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6LgKUxnVnP974DEI1czOsA8nrEzF3WOsd7D8u6lapHoy+bj+
	FfY0C+OmISBa3a6ctFHueWzLobFr1M+Wp72Wk2G70Wdvhe8eun5L38KawQvrexwMiQw=
X-Gm-Gg: ASbGnctX26wmhpkfSU0HXWif0d1jeSu9Bx4t0ADlNFX46WNEy7FW4HNn9Fht7fZ+NZ3
	g3yNZJInDvOlK0MPpNs0gWmv9eVi53kSfILitQ42HSKuBc+pKwhbmRw4JdbsYB+MAEZdoL4DE+v
	Ws1HKBADVda5BeBzvXequ2diqpJeeuxWJj8bqfL8EsNmCA5i1NKrE75mToIE4Af3a8gK4ByhtVo
	Xn0N5st2DK36iJMQWr2+VEgXAgKhH1IXmRjS9ok61JyXPcvRTN9khaAyTJsw/+492GSg+Vdymi6
	ampbYWB6C9PSIcP8HQaKbJ2wFVaejtR57LUqLVbjK9kygeMpTTeaVFfst3Ok2qRYtOm4FmK4t6h
	82SrdzIvmWX4HW1OPQb2tEsftUXMSY1yzMTrIMIRsqTyCU+lo9YPa3qelE9ULMNNnoVCoBypGUA
	==
X-Google-Smtp-Source: AGHT+IHxXn2yLf/O2bw0wSVQuR2yrp3qNWp/lca6o04wzOt6BocP+pKYn0NEJrwyp2gbNHx+3bV2CA==
X-Received: by 2002:a5d:5c84:0:b0:3b8:d79a:6a7d with SMTP id ffacd0b85a97d-3b8d947167fmr8598420f8f.13.1754382597141;
        Tue, 05 Aug 2025 01:29:57 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4595cffdb28sm98597745e9.32.2025.08.05.01.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 01:29:56 -0700 (PDT)
Message-ID: <a5c292ec-e59b-49f0-9681-a990128cbdfe@linaro.org>
Date: Tue, 5 Aug 2025 09:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] media: venus: Define minimum valid firmware
 version
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 quic_dikshita@quicinc.com, quic_vgarodia@quicinc.com,
 konradybcio@kernel.org, krzk+dt@kernel.org
Cc: mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-3-jorge.ramirez@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250805064430.782201-3-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/08/2025 07:44, Jorge Ramirez-Ortiz wrote:
> +	if (!is_fw_rev_or_newer(core, ver->major, ver->minor, ver->rev))
> +		return -EINVAL;
> +

This is the sort of error case that deserves a kernel log.

dev_err(dev, "Firmware version %d.%d < minimum version %d.%d\n, etc);

If I were to try booting venus with an old/unsupported I wouldn't know 
why the probe was failing.

---
bod

