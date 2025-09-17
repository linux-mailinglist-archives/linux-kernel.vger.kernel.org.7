Return-Path: <linux-kernel+bounces-821370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A913B8114D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B8C62061E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36B2FABEB;
	Wed, 17 Sep 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lwLe+kEw"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9602F9DBC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127871; cv=none; b=WzqSrdm8cqGru8wBl4xx7mHq3xZS9MOMF8ZyHXMumF9Sg2mP/tyFXIFUY0fu1CKwGLyIWQe08cqEasRaYKqMB6X6zjvc0YWvB/BkEQuOWxZozyu8SAMHusrGYyZM70fvhgp7H9iR0vxwSsIXKEdml9g08nJwSTjiPiKg0d98Cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127871; c=relaxed/simple;
	bh=gwDqeO9pTlUdpXA9Yz5i6ic6vnRjW6m7pH/Sogrghyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdoS7T3ydEKepgLolcGFfSmfrRjda7aiMmjkcWZJ8UfqikR3EDEwNtoZNS5aTyam2tOn54zTHLmrkIOiOAMNItysnypF2RbRZwY4RzzTuziGkxS/Wiqg9vCxj62k7wjo8Jn6cI4VO3pk51fQbnvYeToLnfbGp1W6t37M0NS4lGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lwLe+kEw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso158095e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758127868; x=1758732668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZNcucLNP4mR46I0TWwPFtv0PUd9VAWxLOjNJ+Jrcyo=;
        b=lwLe+kEw9UJ+bGa96NfYgUtD61zui7E11GrMzUvFnicHQAA2n8YmEpr9ayWoIXvSzy
         12+PFUJJVdZOUirqmBhaLOCOXjbxrxTZ14L7btrj4LntTIPQujH/hthVQivA3bs0JDem
         KXJvqE4/tzWF6CkQXOW6o/92QxtdwN6vx1wsLvRzoqOnkUVGA5OEZR4bturRK4AR3vdm
         uUgqFTkcS6sFy6IIL2/MyIuDAMeb3h9gPxLkgQmEFvX5S78C8P8dlb+ntIg6nN5D5x56
         zWdFYsMYDghW9bqNiw3BpkVfBR5yuPdOw8RLW73HSaOpUSeR9uzbgXebpILellfVWBeO
         ddbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758127868; x=1758732668;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZNcucLNP4mR46I0TWwPFtv0PUd9VAWxLOjNJ+Jrcyo=;
        b=BeW3yNEBDFGO0uzloQX24JW/icBi0uNnrXB0x1yZXtukWhQ4U/zJa8C2HsSnMoNPIT
         5XgP4IMBSh6EZeXCPSHsNCBadZ4J4QzsF8ZOnGkc3At7RvYqf7LLBdaYCWXEQu54fCeW
         wplhFZuYcrvex07YMQPKqcbf3v+qsLD0WzBzXZGH4/Iac/QBxTamS1Rj43M17OEahbkA
         VEfDgy4/H5dXyPXZ42pv3YEM6vE64FaxIzFA3Wv1nn9f4H60xJASjp/b6dQZIUToAPJE
         IUE+O8ISpDWXDlIFbjhlOWzJy5cagERjumTd+1TidXedpasEBARHocP9s8qmBsvi83N2
         eusw==
X-Forwarded-Encrypted: i=1; AJvYcCWj4x5YjPxMoPtlspH7Z70NIC5SBm7JIMG4xRvZBmsQOo3/fv6N5j1aHKPj/ujKWmKM3rqUC0+pivC2PVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgoY5QG9dPDvKBMJ8sDqRCv7PjRVUKDvBRGRVw/3qh2KlilrLK
	gbu7glk05qEIpbqCHjAzgOHUC0ZpzztTYa6UwIxuZQPPGlIvaDYNwAC4KQiYhHz3Rnw=
X-Gm-Gg: ASbGncscY8wTLkGdmurZk9M9LueY++KCGh3RkVtDCvejIi6iWrgloNyNyviT4xJEnBQ
	06IdJk/PBGZIr8ra7Yb1rAuqePBRQE5TduFVoZRlBngra87CoxZBqy/zuxRlt8NlTYzoPzIp7+a
	UPz4cp3D+uXb6lMtVYHf34IjzP3B980ISWWQ5uIn4msjh9pChRdYIn/I1aAQEZg4o/OX705FO1n
	oiO5+wBPgLeltDml+TdrsF5R9xVTJSoyy0dgxM9JKkdYXfwzjZXNzP9oagPtLgdjeCMWD6cPw1T
	vcbGD7QoJPV2YMNLiKHTw+zl0KLDtoxuNrnxyHDFKLCi+V9mZgq88hI0F2H1mBEDBp0OxazIyMe
	dK6qfzXJTzoOHq+RzAYegnjcF60FskyA=
X-Google-Smtp-Source: AGHT+IF1nrUouqCOeE6wDOtkdHMD2AWyWimjxHxsQ94F2pzaPGFfHQDSxdsvbeXDPczFHDXsujKBhw==
X-Received: by 2002:a05:600c:3587:b0:45d:e285:c4c6 with SMTP id 5b1f17b1804b1-46207a83da5mr28634175e9.37.1758127868023;
        Wed, 17 Sep 2025 09:51:08 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07411f4dsm64874f8f.26.2025.09.17.09.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:51:07 -0700 (PDT)
Message-ID: <a59d7be5-f767-4ce5-9a88-5a9b340c6643@tuxon.dev>
Date: Wed, 17 Sep 2025 19:51:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: at91: PM: implement selection of LPM
To: Ryan.Wanner@microchip.com, sre@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux@armlinux.org.uk
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>
References: <cover.1758051358.git.Ryan.Wanner@microchip.com>
 <98b7e9347fd15e45e2606d0e89f09095887079fc.1758051358.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <98b7e9347fd15e45e2606d0e89f09095887079fc.1758051358.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/25 22:50, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> The LPM shutdown controller output could signal the transition to PM
> state for different devices connected on board. On different boards
> LPM could be connected to different devices (e.g. on SAMA7G5-EK REV4
> the LPM is connected to on main crystal oscillator, KSZ8081 PHY and
> to MCP16502 PMIC). Toggling LPM on BSR PM mode is done unconditionally
> and it helps PMIC to transition to a power saving mode. Toggling LPM
> on ULP0 and ULP1 should be done conditionally based on user defined
> wakeup sources, available wakeup source for PM mode and connections to
> SHDWC's LPM pin. On ULP0 any device could act as wakeup sources. On ULP1
> only some of the on SoC controllers could act as wakeup sources. For this
> the architecture specific PM code parses board specific LPM devices,
> check them against possible wakeup source (in case of ULP1) and tells
> assembly code to act properly on SHDWC's LPM pin.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> [ryan.wanner@microchip.com: Fixed conflicts when applying.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

