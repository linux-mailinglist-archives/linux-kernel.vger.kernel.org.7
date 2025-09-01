Return-Path: <linux-kernel+bounces-794994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D4FB3EB8E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FD216C4F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B421B9C1;
	Mon,  1 Sep 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ON+bbF07"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494D202997
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741930; cv=none; b=a4js+6YRgvlwCPjxdjs3WFwzBGP24BCyg8uBpTF619L1nYymMlZ3Rc6fBu7b7fmFZZhUZPzOpt+SdGHIbCMZEtZTEYE1JeV6wUhyMeLRNHRfgXunPdMPhV1XSced8mbFaDNq40KUVLKpes289ZVChU9BiiuImheL2zWgrHRNg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741930; c=relaxed/simple;
	bh=nepHmhe2my1/TS0/miMgoTId2J0/ckMsAUxgocThFS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3lsh+OC7xzp5/fJxzcAgcAM2+9wDrGh+xKBqJI8+22wrp4nDWqZdz8dw5NwngH6A8U4miydETL9isryq39YUr9VaU6EkgsN1O8z8I9irizGWgGTRXApxkdY96N0VeFozWdcq6khPLP+DBcs6jYhHfN5LP1aHUDO+24xspN3OPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ON+bbF07; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b869d35a0so13045915e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756741927; x=1757346727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvgVg4wMFIPRhYvz1pnYCKruwi4dt6JJzYxl+/aO7gk=;
        b=ON+bbF07pWk/p6YrAnZNPoBxJszxyGIh2IEYXkEfABbBTdDXcDL/vRyQFQuxkBkIGk
         viOJNhVaHQPH+mSFCsD7R3Je1X/O/Va18+IEMHxxCIvFxNBYvWkP0/CFRWnlobBS1+VV
         shV/4Vp/WCcuVxUktMGMd5Pbs55mACESbl76qVycLC5ZRuVXa8fBmVSNWxq/YfUX/OMS
         AIAJ8Fzob+NvKH+jI+TP8DEvJLpzBvfS7GgsOrnvbqcIrIGk+9OLwHxJjmYfkWAyGmDC
         83vHHcOiWKYBBcfWx/HfPPJjxZyDyrePqOpTAl65w7bR1Wj/HgK4XxpMEPvpWpt3x48P
         11Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741927; x=1757346727;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvgVg4wMFIPRhYvz1pnYCKruwi4dt6JJzYxl+/aO7gk=;
        b=ipHY7Y43cyEDUCz8cFzm0YnnYUz1Tq5eq1EXduJmDZS70jbRGHOM4MGah4Zpjg9f/m
         2RC7LotXEAyb8Z7nAbJFhrHxWsfTuey+hqRBV0fHa1xv58gd2BpdFKEOXe2vr940JwQk
         vpDXRU6yJNzUS4FKwyMh+Lh0q+sLIol1bekJ209zjDZaGC6nFKifcKL7WkvZBsly23rs
         TB/fixejMaCwvSy2ttHFc9T9mOx58eXHc3MjfoFWw2+buuStlIstW7xEOPf0duT2bNSA
         9tyt5OjamVfJB+60UIHCmcU5NEu/kNCMEuAfUVaclyxujgmiAtoJN/C5zkWAc/7OF/32
         w2xA==
X-Forwarded-Encrypted: i=1; AJvYcCX0pK1bfQ130YDEo2kPi/Y3Sc+Lp2mXNDkFs4Go2InrE1a3fUnbx06eZiCbMECiVfALY4OzPmsxF6VKxHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXaGVWTImqb2oI2xiODFN642nr1pZpnBpDgGYcDicKUKS4l1R
	w4D+FtGXC+fcuWWkZghBckE5OJod7KcG8MCSNrcUBxekDhXjUbTdWn6Ui8Bwr/dnBbc=
X-Gm-Gg: ASbGnctKIeVKvOVDaqq/fw9VOylw5xjSn/hhWY4YXMyNBq9jih2a4YzcA1kc3JjcAZ3
	39msQ/0bVslIyo9/pOp3aTQrnAUV4WC2DaQBX9FhJeCeH7lIIfYEY9Xx+5v76V13ncQEPcL3KM0
	EIxBsWabDlI8u6e4r5f+A3/Err7QlmcUFhrbBi+e3tYBOXNolP5oPv8HoTApOiqqt2tKBujy3j4
	8gwSB2uH4cMjCITyeYO32R3COyFbiIN6XXF2Xl+nuG0/YjGAlqV+6FLmI/REsSqLUJmNBWYnkOb
	R898goQ0iENmYlXPh6D40cWfTDMtJXLpOy5Ms5NaCdbstBcVglx9v9GdR/Ijg22Q3+f3oj4cn+E
	6jsr1AOuu5QOQKSfRKIJzS6ciw9AotiwwoYHWoGpCP6vGHRYGlq4mdAajpP5JwHAFiNmQd1MKRG
	L9wKd98orFF7FEQySLLD4=
X-Google-Smtp-Source: AGHT+IHcKqULDsn+c4qoRR0F28BE0OPsYdJT4mw5UiGUiMMns+V2I9JG1CinXmS84aORcGRwIQn16w==
X-Received: by 2002:a05:600c:4fd6:b0:458:bd31:2c27 with SMTP id 5b1f17b1804b1-45b85588134mr65644725e9.23.1756741927286;
        Mon, 01 Sep 2025 08:52:07 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d60cf93cb2sm6373216f8f.12.2025.09.01.08.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:52:06 -0700 (PDT)
Message-ID: <33e20d27-eb63-4a9c-b459-77021fb384db@linaro.org>
Date: Mon, 1 Sep 2025 16:52:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform: arm64: thinkpad-t14s-ec: new driver
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250831-thinkpad-t14s-ec-v1-0-6e06a07afe0f@collabora.com>
 <20250831-thinkpad-t14s-ec-v1-2-6e06a07afe0f@collabora.com>
 <899b2e79-572d-44f3-8dff-0d301f254b1a@linaro.org>
 <wyv3ounark6jccvhj4vp5qxgmn4bleq6hsqinr4s6r32kld4xp@lhbmetuhydns>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <wyv3ounark6jccvhj4vp5qxgmn4bleq6hsqinr4s6r32kld4xp@lhbmetuhydns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2025 16:20, Sebastian Reichel wrote:
> You can find it here:
> 
> drivers/platform/x86/lenovo/thinkpad_acpi.c

That'd do ;)

---
bod

