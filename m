Return-Path: <linux-kernel+bounces-720710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6236AFBF8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B6D3B027D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84CE1DEFF5;
	Tue,  8 Jul 2025 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TT091p7M"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4724B29
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936161; cv=none; b=iywuz9+SnAX2qyYl28r2P6U2FsOLQuskVAkuyxd6hJq9AJv0TP5TC1R4E4qQ7/zd/SaNyRy0/okILsZesi3lDhX0N5sTpSlVr2em7wAisiwKZzmTjkfgLJhPL7HBBJv8jyBT/ev0OxXksnhPDssWhVkzalGbw4bRRPx3FCCtbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936161; c=relaxed/simple;
	bh=5/W5PDx2OgC/pBsDMzDvztUMs/25/b1FwBAaU2+4M1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBbN4xsMvvEmxZWkIJCWD3iyjakUnPeNVjTIrPQv/syOn6WyAh6q6r3UsKv/trzkrqw8/vSKKbrsD0bI99yZzeeeidrUOwrAb9UcURblGa7LR/4uJpd8a6GILNUs46e8SjBCrN6XLYUdj3BarKx/fSQ+9J/69U3hclgRWX3hsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TT091p7M; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso4059683a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751936158; x=1752540958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W485WHAP1uqJod7yt/QMj2+3WtWakaGzk8TE+3KhyPE=;
        b=TT091p7MIP3+W5/lVorl4419pv8I+NHeQw5YzUC2SWsAkc728EHZ1twm27BE/9xQSJ
         CVUbsYBgt0zWmfgcRfEr5koAtMqvQ8D/wUaBgN6IZimacbxvwOw06FpQ/v/gqftn7zV3
         3pLXj9d3YeuSRGqr/A5piIM/UjU2ljB0F0vTmbM74jDywAErFqvQmwXey3M+8UTm1S5F
         73uDmoALXwho95HoipMsgbzgT4LH70UR0bdSRQOqJz65uqjY3xzqEBhzTfMQcaKG0E+a
         Fn6etbvJqRD45FDmzDIduemqw0X/pL9MihDacJQiCKy/6KFgBVec6XC9v5yhbBQ9sRLH
         AmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751936158; x=1752540958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W485WHAP1uqJod7yt/QMj2+3WtWakaGzk8TE+3KhyPE=;
        b=hrZUmAIdm7BQ1kA0yTFyQ9WbJNSxh6l7JTrU1hQ2YRc6xjJTDuoUalEohNBoBB/yJj
         b8U6t9AZ49yjsBn5YHxztC4UuLsb2Z4qL5qqZlPihlu5K0ubNk4UP8wOC1apDSkA/A9P
         AfYmw/S9L1c8sSw5zJBnOJmY3iFRS83bX+UtCRG3mrhIQBVA+2wENlMASROPiJj0vSzF
         tfuXzawDWFkDMbXhPUXkrErdBWVKScRMcAmjUFxEsTmEoxQi4WY89pWsKUPdDI6FwW+s
         TZq6qfZU21NDSDXtIhgZxbkA4S1mtkl7SseUk5UM0RY+KA5L4i6pjpb3XS0pSB4ab3YA
         YTNw==
X-Forwarded-Encrypted: i=1; AJvYcCX0cgf1CT8Nx0CgCJ4rakwXzAy5gX9G/0mBznDx1dinHDD+lk3NoDQTMI9Coy/FDaboat1kv37VI3CnLCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfgXijn5vsuRUt71vn02uyAP79VSYid4A2+56iCd2P4mv01D7A
	ukDqliSaCSz38Hr6YrEHxNcBWJ32PtNCepCGfejkmOi7Hz6mp28LW50TMCW0pRYKdQ==
X-Gm-Gg: ASbGnctUoOPSQUhb431gvSyyyWX0VU4MfjiXLUCNknCrb2P9a2DnRbl5CSfn1T8LVCT
	RP7Av3u361Fn2siGre+bl1lwDMrSkNyM7r4PSyvArtwxVJjO0zHH/KYP073YMnM+RC6QK2r1RtR
	eOfmbvvdUWP9CJc+LWUyU6kQVB1UCq+VyVWuvYbOMUT2sk7WazanFUUwyNEswY/eyOlFXPzPzPC
	G9Vx+qo/+8xCy3C9MnhqHrQFHslVokM17XMkjFTpwLMyu+1LIWVIGttXZnX7uFJ86FfCfcKaAbU
	B6AlJeL/gj3YjtzZn4HIzP0nZ63rKSWS819FYFWBnWY6ocJS6eCq9BTNDHz152M+d9Zg3V/SVJh
	eoP7fDqiYU8rdJTJBK1WRdymb0aLZr2pgfZeGvMbhIP93G7dDgIiO0gEWuW7o
X-Google-Smtp-Source: AGHT+IE2Y6RL3XN7SOZqgdPNO5uGsxBxp2KziPU4v6b4C3QEfxLieWn8MgzQq9cvik6V8PHCA4N4aA==
X-Received: by 2002:a17:90b:2d4f:b0:311:e9ac:f5ce with SMTP id 98e67ed59e1d1-31aadd9b5ddmr20638582a91.21.1751936157723;
        Mon, 07 Jul 2025 17:55:57 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:990d:1c2a:935c:f693? ([2a00:79e0:2e14:7:990d:1c2a:935c:f693])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm166800a91.1.2025.07.07.17.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 17:55:57 -0700 (PDT)
Message-ID: <776de517-ed60-4cf8-8790-531c1cafc512@google.com>
Date: Mon, 7 Jul 2025 17:55:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] usb: typec: tcpm: Add support for Battery Status
 response message
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Kyle Tso <kyletso@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-3-8d06130bffe6@google.com>
 <iqsj5w5pqcbjof3vqohhzptdp5xj7bir6digzqes775at2tpj2@r7kzy4j2fqmw>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <iqsj5w5pqcbjof3vqohhzptdp5xj7bir6digzqes775at2tpj2@r7kzy4j2fqmw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/23/25 2:27 PM, Sebastian Reichel wrote:
> Hi,
>
> On Wed, May 07, 2025 at 06:00:24PM -0700, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add support for responding to Get_Battery_Status (extended) request with
>> a Battery_Status (data) msg. The requester shall request the status of
>> an individual battery by providing an index in Get_Battery_Status. In
>> case of failure to identify battery, the responder shall reply with an
>> appropriate message indicating so.
>>
>> Battery status support is only provided for fixed batteries indexed from
>> 0 - 3.
>>
>> Support for Battery_Status message is required for sinks that contain
>> battery as specified in USB PD Rev3.1 v1.8
>> ("Applicability of Data Messages" section).
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
>> Reviewed-by: Kyle Tso <kyletso@google.com>
>> ---
> (partial review)
>
>> +static int tcpm_pd_send_batt_status(struct tcpm_port *port)
>> +{
>> +	struct pd_message msg;
>> +	struct power_supply *batt;
>> +	u32 bsdo;
>> +	u32 batt_id = port->batt_request;
>> +	union power_supply_propval val;
>> +	int ret;
>> +	bool batt_present = false;
>> +	u8 charging_status = BSDO_BATTERY_INFO_RSVD;
>> +	u16 present_charge = BATTERY_PROPERTY_UNKNOWN;
>> +
>> +	memset(&msg, 0, sizeof(msg));
>> +	if (batt_id < MAX_NUM_FIXED_BATT && port->fixed_batt[batt_id]) {
>> +		batt_present = true;
> power_supply_get_property(batt, POWER_SUPPLY_PROP_PRESENT, &batt_present);

Will update in the next revision.

Thanks,

Amit


>
>> ...
> Greetings,
>
> -- Sebastian

