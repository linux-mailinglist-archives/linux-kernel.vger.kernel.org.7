Return-Path: <linux-kernel+bounces-758914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920CDB1D588
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4955E722F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568925F963;
	Thu,  7 Aug 2025 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvmgJ6zf"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470D22C35D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561497; cv=none; b=cM9YnuL1KRrS+uD2e62yi5tcwDpTv8JPnVK5SCoxYri8YfRrtI4M1DUVz+nyespOEq2zwIz2oJwBXfG/AJiEx2qFstId6xCeJgzT9XDPzNKKxmKchY5aFcythO897c1x6QTPQgvG6LOblOy8dt91v2jf+2qa9Ytt9JZbXuXCWPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561497; c=relaxed/simple;
	bh=O6Y8cVOuHgA/hdqV1bgBIn4O/CUwlnYyFlCzNIDIYM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToX8/kjN3764OXzP9jR3qSgiAv/6OYYg50A+xZgm4nDko3cXX4AGmcf2nvARYjjllXHEN3wH3QL3HrgBmSXmFQRBHLI2n0dwN/KGA4WmOAyNGjMMIOqZG/PZsfAFEghFmQC0c1CyKNDIq69rHAeCVhG3C6JikKiBOlhnIFS6LJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvmgJ6zf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so6606195e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754561494; x=1755166294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCEOeQAX58eFRpMAP8AQskjLHPoD1JzG7voJikyFC+Y=;
        b=gvmgJ6zfWuydL4/n/O1WHIY/Pk2l40OgMcfVxiEJEC3vX3ObpnQ6Tw5HZdpB2Bqbxa
         A3rxPcTOIUq6GBQMCjw7VdOlikB5h6tXxPMAV7LPL7UDcPPip4r0FxjsMAZ0D0U+VQ8Q
         B4k4po9JxcIfgvM01w+dYCZCO57I8WxlgmCaFdRdC48lmHwh831qn7RhORvTB1lyHsoe
         e2BPA9PLYjen6Z/ZYUIfi0lHxfzvBVW5N2nvNrMitbVe08SFrFQWdg5U2fM45HNqS4Cs
         HylUpQvW6iyMZ3dYwxXGrYyUu9xPrlrnDLvB1LPQNI8JL/4jl1wouSILsnrQn9mJYf8H
         15og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754561494; x=1755166294;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCEOeQAX58eFRpMAP8AQskjLHPoD1JzG7voJikyFC+Y=;
        b=vph5H/ZWeNag+/3UyvIN1Zwmc/3kkGpClC6UHKspJYe1gzyxS+020ZpddayP2P9F61
         Ntaym0iijstUvMAavl5Fjk4UzfbNZm1/a2eiUYBDD9h8nyCeJtq+dH9hW7jlkGQDGBN9
         SS087GNeFfJ48NsIcQ5h6VafXPImeEA0ZbDGIt5WKT74TLzeWtZyhHeQVgradhyxhi4d
         7nSlSj2DR5hWPEyqge1sIzytOd3/lv9NPQQjsk6ZNCE0lkyIE6IXtrHj0PCNRU3URi81
         97ad1EA+GurY6LgOLFyFPSx6F+uIpj9BaOauaQPJPOMIkcEiJ65BUXI9FolaqN29nWkG
         FCKw==
X-Forwarded-Encrypted: i=1; AJvYcCXxaBZDkpOhIm5yRfCf11dFI5EvOIvG+TGahEzmP0O+ZO5uXe4nmWhKWPRAsUnXeh1E221KXmBE7Z5bdD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamQHQjodIziFgWfbyVCXSBPAp00vcoJlz3LlV9ehkjrXAD5es
	3oQ5TzEna11NkaOzgSLXUWLG2MhtwFKy0hA8xg8zUHEI+WEIMl+SPzKOG5gvm78M40Y=
X-Gm-Gg: ASbGnctpfU3db/Zj1EBP2EtDdN2w4leFM27lhUi14Ig7Km4tugl0GEbPiUjXse9BGn2
	yzhE1CTa+jlzsHAvZ6hgcCFSQsjRYZrvc4pixxlqHSqBTgxw2deFkxsmjKTSPnCN5gutticdzlG
	SoCDnYBVjk6h4z6blA6pjeBaqpp33IWi0EVDPSsTihAlGclN8ZzT9693DhOgU7mP5Z1ArKLNUb7
	ae2Izxl8nwhLTMqknn0LcPlYfxuQXzv1o9fiAS3Zajq6ezKgEA33HGYe178lS8bikq5APCnWbh3
	99H6K+8+HGHNE3NWBgpRXFSkeFwsoTjg6bQtZ5mlGCP1kC5e7x+K5NWPbHLyidz5m+aQYg3BYxX
	ShXu50sgWXaTMG5GyjX/UFFxJBlJNT8y7Q4OkWFRrzLJ4p0ZP4TBWtWg6me35Z+Q=
X-Google-Smtp-Source: AGHT+IHhek7qLMtG/D0lLB216ukv1XprlpVNWNYygMd7NFMy48jfNMcwOJb/6mt3RoRrKwpkALkG4w==
X-Received: by 2002:a05:600c:4f4e:b0:459:e06b:afbd with SMTP id 5b1f17b1804b1-459e74b6367mr50737565e9.29.1754561493918;
        Thu, 07 Aug 2025 03:11:33 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e9464f46sm12001442f8f.19.2025.08.07.03.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 03:11:33 -0700 (PDT)
Message-ID: <40d543e4-e53d-4289-9b87-5ca8c0139bbb@linaro.org>
Date: Thu, 7 Aug 2025 11:11:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 quic_dikshita@quicinc.com, quic_vgarodia@quicinc.com,
 konradybcio@kernel.org, krzk+dt@kernel.org, mchehab@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
 <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
 <aJHgh8mon9auOHzi@trex> <ce9cf017-5447-457c-9579-700782f9f0c2@linaro.org>
 <aJRMUzF0GN2LFIZd@trex>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <aJRMUzF0GN2LFIZd@trex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2025 07:48, Jorge Ramirez wrote:
>> There's not alot of value to the user in that configuration.
> I dont know the user base but when I originally did the code (v7) I was
> thinking about security conscious users (signed firmwares) who might not
> be able to switch to the new fw release so easily (unnaccessible key
> management and updates).

Since the driver for the LITE hasn't been upstreamed the # of users must 
be ... zero

---
bod

