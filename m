Return-Path: <linux-kernel+bounces-890136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32195C3F4C4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B96188C3FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB21E51EE;
	Fri,  7 Nov 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="fPL4W9M9"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E826E6E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509731; cv=none; b=n9roYWNPALRgb+hpWVnyrCIeAEM81+W7QCAkEYZl21wGfvEV/ZG3UFc5b1eXOAWSOgRMjbQnQ+tM6aueuEg7xrpltjYkK9GjQhjQ595eMgP6/+cFFiz7FQ2GgNnQXJ9xr3scdHFF1ZjQfHSRL9xnBs18XG7aJ6U3nKPwbuuP6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509731; c=relaxed/simple;
	bh=JJGs4zIda6s1YsKiNN6VSjbE0TevdnhAVZj4houk4zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZRQK6boss37GnTrsbqcd15xnAys82KtQ9moBcKhbeTKXukHcIczv9g4trTZvrk49rOLBbkSn52nehR60ie/Xr+5meBv5IPYRrclZ2heLtrIbVzmQR+17ftG+dm1i4ZJum7W8Oc2PxEDeLz8T0cvf8rk/5c06f+CNOxN6ByfFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=fPL4W9M9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640f8a7aba2so908235a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1762509728; x=1763114528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sI3AaX9grHbjP5KjZYhTK6oQKUD2yVQSwBL3X3Q60WM=;
        b=fPL4W9M9YNIXN2+La4AF8emD2uG6M7TzB7mAg2wTgGhvckbXIXf6/8NJBdfPly1rM+
         a+q6hjcQn7G8Th/4D7HnLPIxv37Gf2Ty69LwmY2VXVnSWp8ZFJL90QhqfvgVnAWman7U
         fKkGaTfGbxG/7Eu6myq5wLxpQMFXsfplrsva4i8uXG6JWMFJIstyqlgP+ybUcNWiBkYy
         sEn1GAZgeGxDr02ZaN05DTORM6HIpHjKc3Efe9fteq80TzkRDBnQ4C5l4C1ZUNtj45QO
         ijtHpiWb6+h5I9zDa3OcEJ1WTiwr/z3oK7JV5QUAWvgwRLwdYYgB1QNiV0XPHJhgFW51
         DxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509728; x=1763114528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sI3AaX9grHbjP5KjZYhTK6oQKUD2yVQSwBL3X3Q60WM=;
        b=OLtQNiHslq0p1pxjRyD0TkgIOHpPV8OmnPvAiBM6vp/v2n34rAhjFYadXncXHJjWXc
         eMGCwHwlf5zZYQ4pwYIJ93cwv94jNIgkiA087GkCyZ6HKMsih6o1jKpasHg7bneEK7/3
         Nb99K8D10Dzh2uK0Z1q5+wDNyrIeDoyGsHJDS9/BqqmIGC08C97A90FUAPOf74N1wpkS
         3f5uqtsa4cobC3vBtXgkHL89xuJxJNhFBHBXo6mQ1kd3hC1cwreuZQBFqsk6QrQ9HUr4
         z6QRkQWkt2X7/FsQgpFHOV/984mFMMmzlZ4X45D5Fhk7DXR3GXreOoRZ3lmEl8+phlk6
         xcZw==
X-Forwarded-Encrypted: i=1; AJvYcCUJC4DCuhqZKdMYuP7PI5XW7JhDwPEqlto69tXVW2Z4so68MjTzHN2KG4gGdLQ4GK6JvaTaWSntVTMWN9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAgINrequAcAnWkEspgv33RXpSu+g27YvH5tximA0qCmR48qJ
	n8s2nC0beRjRvgC5M/r10t+PILvhfjHcEYzSKtBin61Gz2LUY2uS93uw0ApBDP+7uqg=
X-Gm-Gg: ASbGncsnUmZtBEHe+H73KXmOzcLp6qkuRAEwGFj7GxmOpjq4erx4303yHsqIHs3bo4k
	P5BZvaBhlZ8yQZHKz4u1802qoRnHJ2hN8BpZxdDXXwV6zmzPyC7Fuj9blRHtAKM8ynAzrVWB5hS
	K095wFmqJN/wGtmEjVkLEEhmtfrnTVKOzR6zkTT4boL2tcJjjjJZw0k7hLNDTJ3fTOVsQysvNf/
	liPj2MeQvJDlq8sdXpZDKBwQThiS37TfDubwwIPPb+L4TD5/xsRUQphakFq8IdqpjYbSATu3Jsf
	Ls4/yOAlLg7eImF3qT3hYAYQALL3Q2PhTB7tK0aKU7jjoUZae70eqwkanuI7TAFn273T8JSffgx
	M2SycMr3P3Zvzq1ssKlaPTd+oFXt7T91Xd1h7wHzowJBxmekkRb9d0LYA+XXjauqIVUXbhCLpY1
	rrJ4Q+NdBZLY5lGIkhcSAbb2HkzrJ6FvUV6aeV
X-Google-Smtp-Source: AGHT+IHlT54Zkq9G78xurNR3OQ80FwPe+AHLLB41tVK7/67rPq4iDsWAMcHtSavKQD8aOgkIUNYv2g==
X-Received: by 2002:a05:6402:40d1:b0:640:b1cf:f800 with SMTP id 4fb4d7f45d1cf-6413f059b97mr2381350a12.4.1762509728210;
        Fri, 07 Nov 2025 02:02:08 -0800 (PST)
Received: from ?IPV6:2a02:810a:b98:a000::4e88? ([2a02:810a:b98:a000::4e88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8575eesm3693449a12.22.2025.11.07.02.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:02:07 -0800 (PST)
Message-ID: <03012c3b-ae9d-4591-8ac5-8cf302b794a5@cogentembedded.com>
Date: Fri, 7 Nov 2025 11:02:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] net: renesas: rswitch: add simple l3
 routing
To: Andrew Lunn <andrew@lunn.ch>, Michael Dege <michael.dege@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20251106-add_l3_routing-v1-0-dcbb8368ca54@renesas.com>
 <20251106-add_l3_routing-v1-9-dcbb8368ca54@renesas.com>
 <06213fb1-12dc-4045-803e-d2a65c7e9fc6@lunn.ch>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <06213fb1-12dc-4045-803e-d2a65c7e9fc6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +static bool rmon_ipv4_dst_offload_hw_op(struct rswitch_route_monitor *rmon,
>> +					struct rmon_ipv4_dst_offload *offload,
>> +					u8 frame_type, bool install)
> 
> Why all this bool functions? Especially when you have calls returning
> error codes you are throwing away.

The original idea behind that was - this is "not success" from an optional optimization step, that is 
not exposed outside. If it fails to offload - then the stream will remain handled by software.


But, there is a more interesting question about this patchset (that actually stopped me from submitting 
it when it was originally developed).

What do people thing about the entire approach used to detect streams to offload?

The situation is:
- hardware is capable of doing L3 routing, with some (limited) packet update capabilities - rewrite DST 
MAC, decrease TTL,
- there is interest to use that, because software L3 routing even at 1Gbps consumes significant CPU 
load, and for 5Gbps will likely not keep the speed at all (we did not have hw to try),
- but - given the capabilities of hw are incomparably weaker than capabilities of linux networking, 
which approach to take to detect streams for offloading?

Second question - how exactly to get the routing decision from the kernel stack, to apply it in 
hardware? I was not able to find any existing implementations of something similar...

What the patchset actually implements is - maintains it's own shadow structures for (subset of) routing 
information, and generate offload rules based on that. This is definitely not elegant (because the same 
kernel where this code runs maintains full-scale routing structures).  Also this is definitely breaking 
any complex cases - actually anything more complex than simple destination mask based routing.

I was going to post this approach as RFC at some point, raising all these questions...  but 
unfortunately I did not have a resource to complete that :(

Nikita

