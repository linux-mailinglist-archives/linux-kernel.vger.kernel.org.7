Return-Path: <linux-kernel+bounces-746857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63D8B12C12
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 21:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537093AEAB0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA328A1D1;
	Sat, 26 Jul 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxJEf55P"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578EA1B4236
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753558668; cv=none; b=sxKGhjp5k4cM784AptkzKDyeACFjmkPR54U3co5aBf6ctdh21v3YNSJ6OdHFoWzaY1h4HhhYk+fah28+xkuzT6gIohCHAEz6U9QIuJzuTE5s7IiFIKZGpQwKNT2lG7dPiShWuidP0XGiyz7Zs7eGECfu0b9UWVKKzSRgGg+m1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753558668; c=relaxed/simple;
	bh=DJL9njiB5t8r0IADy2Rm/2L3q7CLuloHDDdLfnrmL4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6zNFJ1zJhHtjeeXBinu7vCMlymPlf2dLKJEho/sbAbzniGkZUtF7NbWmMUYFOCkLI5SvaVRe5x2BlVUqNxsw/IO8BWWNb04j/nS9NhtV10tCrNF5X7ZiFN9ruEfq5ABUnOHSYyu2gRoz6VF0Qfdkw6YEs1zqVbZ9FXuwHZxWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxJEf55P; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so25201695e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753558664; x=1754163464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/i/vrPolATXXjmXLFvSQ3cqf58SzJGGKxUaadid+ZCY=;
        b=kxJEf55PEI+XddQ4Sh4AdbFMVoEZVu+Y1EUTy6ZwpWdn+EW56TjOE7G/U1ZM+JB+Fm
         j5yN7+ugMC10Fo2e+YQFPtuutOWJleGYuqTjWNbtP6scCRy2BP1Qlx8EY20VcpYZKMQ4
         VX6DNIFhDGIHFcvmsXKJoWs3vP2qT3123ckB/+Zs0ISx3m0PQpdmN30Yz5eK4WNaa6Qv
         W9pS1e8LA7YpH83X44iqW1FrBjE0U/5m2FdGZYE/2X8mrTj91yHmrLHsN2uMdfPcAlwZ
         tyibaIvOBsTIKJMZvWOIRKzE2PPRqt4DwLxnFnLqlLjS7uc+1Djk4EevPI6TrkXczjim
         oeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753558664; x=1754163464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/i/vrPolATXXjmXLFvSQ3cqf58SzJGGKxUaadid+ZCY=;
        b=Tf4N1YapVk4EvsEuel/oKBoE1AfTXM2DPecUwBh589IsAYL3G1w3C4bsMLHZWND9ur
         Idp2Lsd2bIgRJZRmwStmFnNBIlrx28cSIFJMzs0KdUHiiRKCIeRv8hYNFSNwpq7tAgQk
         Dxwb2pD4TjbiCcCrZUryCkcXZsQ3jp+xUzYWU1tRm0+zk2QuGhSFHZJ7GbOfGA6L9Cy5
         IpMJsxhBxkkwaj6dXoivGF/Z5QtqNu66z9krF66/htKB59QrSgaKEO011PFfM574HLry
         15bbBv06C7hrMR0bZg/XZFayVYEA6LzVFLGaJIo/zV31pPl/1gvOPI8rLt21NymeMJbg
         DoEg==
X-Forwarded-Encrypted: i=1; AJvYcCWEKgouonQuEHS/RvfLd4pFl35/jGrOvsdbNGGsC3YWtsz8vWGDyn7IB4Zo923A5N8AHb72TUOysVtXz0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMj7UaLydQB7ps/T8YgnTo5ZG8JTN4qVktQXntwH0Rf/JdXLfF
	QCzBZQUriX1xs6wzuLLKLiWuud4LLOAo+SBGp1E5lmXiFs7++gAsSbbDpgDj05q6Nxc=
X-Gm-Gg: ASbGncu78TxI8seb4JLP+O1f4VvsEpIzoWSkbakVIYja4yZa90ohj3sJhPmX8e/1FSP
	NBJbgcNeJJzNO/D7RnlQMtVmk6uOw1VmLEiiydZmMZEmDcGloWYKW7RCaWBkoss3cYRrxZN6G8m
	73QYJrNgfWEKKRn/7K9ksayH1rtHNmeJ3SjHsMzpoWJZVWrZ2+KWVAG/OEfvWnWrTML1U4m/xZU
	PzItWWX5pN2eAFx0DxZQHVs1xkUCorM5gW7cnL7HTWmyAbAJ6j61Z4lcPSjT5SVOgFegtJUHPGP
	uGWg6RHNcl+l4hbG+MwGGa98cTHjDZPVpzQaezAmhYDzcem6cnrrqJciZQJrQDAxh3cFkxQ4kGM
	ej5rWfQC1l5LOCbjIHexlCPjEPc+4hLoVVGPF3MKYQ0yo2Sd/yDhxwz8DyT9z6A==
X-Google-Smtp-Source: AGHT+IFGQRIdqjin2YHWbI7au0ltKxC105b3PZKWfkXXQYEBwWKibS7P593LewBxzEdx/vZ0sU8pMA==
X-Received: by 2002:a05:600c:3e11:b0:456:15a1:9ae0 with SMTP id 5b1f17b1804b1-458755f3df0mr58800165e9.13.1753558664537;
        Sat, 26 Jul 2025 12:37:44 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b778eb284fsm3718859f8f.12.2025.07.26.12.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 12:37:44 -0700 (PDT)
Message-ID: <4101aa1a-efa3-418b-aa96-0157ffc7198f@linaro.org>
Date: Sat, 26 Jul 2025 21:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] clocksource/drivers/vf-pit: Register the
 clocksource from the driver
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250705160129.3688026-1-daniel.lezcano@linaro.org>
 <20250705160129.3688026-9-daniel.lezcano@linaro.org>
 <86dd0130-b9bc-46cd-9bbd-033eafbbd5e0@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <86dd0130-b9bc-46cd-9bbd-033eafbbd5e0@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/07/2025 14:02, Ghennadi Procopciuc wrote:
> On 7/5/2025 7:01 PM, Daniel Lezcano wrote:
> [...]
> 
>> +static u64 pit_timer_clocksource_read(struct clocksource *cs)
>> +{
>> +	struct pit_timer *pit = cs_to_pit(cs);
>> +
>> +	return ~(u64)readl(pit->clksrc_base + PITCVAL);
>> +}
> 
> The CVAL register is a 32-bit countdown timer. Casting its value to 64 bits before applying bitwise negation results in a 64-bit value where the upper 32 bits are always set. To avoid this, shouldn't the operations be reordered so that the bitwise negation is applied first to the 32-bit value, followed by casting the result to 64 bits?
> 

Yes, that's right

Good catch !

Thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

