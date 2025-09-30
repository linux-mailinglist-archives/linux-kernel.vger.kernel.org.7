Return-Path: <linux-kernel+bounces-837744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E1BBAD16C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798BA1888520
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ADC3043A1;
	Tue, 30 Sep 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqQh4WIK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7091CF5C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239642; cv=none; b=OcBY4maOjefCA4fQLo1Y+ts4/vtze7qFSxHqHjLGCBCGEsBQ1n2+/yl9aJqnGCzx7pJaIhrvT9WtlS/TazW6qt85SXqxdrqXdik1kkNtK0C5ZPdS3E7xxMwMGMUZ5jPILxL+L4GdTl4olTIpJ/VEsCYlvgwipKJsjyxVGlpUwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239642; c=relaxed/simple;
	bh=hb7TMarqWXO178DpdiX/rXmmKCvnKm0TOcmJL56yQh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDWqOLXJTUDsZokgZTOqA4Z8hU4Od3dWyfEcLyrEuQ4M/tR+uWrn8n4NA2qO8AKu//Bh7tksD1aduAjasSbkp7mFNawY1OWoL679qoK/X2+5bvG4WL2WgNGnRKkES7q6ScNJp6w2SsMA9lrjCPdb2RVh0B94yDQm5TuF7bAYGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqQh4WIK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759239639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc1pUt9y2hsw8mhswnVLM/oUyK615tOMdAOq5LgQ9VE=;
	b=WqQh4WIK6AG6oMTpraTmpoiug2u3o7G4SESct+a0c9FoVOruC1aYMfzcGIaO9ubdTWbPjY
	loeBwd/Vnmp01bqtPkeP1Jx9XsgAvPUzOEe0JPp+AID4h7Uvaf+qxJxW3qtWEU56/wHehm
	25iLJ7h5RHuK+hvEOsBO4hPuKzoELe8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-b-HzPgjTMmyg6ZR570n9tA-1; Tue, 30 Sep 2025 09:40:37 -0400
X-MC-Unique: b-HzPgjTMmyg6ZR570n9tA-1
X-Mimecast-MFC-AGG-ID: b-HzPgjTMmyg6ZR570n9tA_1759239636
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so3303332f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759239636; x=1759844436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc1pUt9y2hsw8mhswnVLM/oUyK615tOMdAOq5LgQ9VE=;
        b=Or7vWvBtaNWk86ZqT8qmHDqVNSa9MTgMYLpXnNIUrqR4JNlFTeBTtwPhWzkkZemSjv
         MRzwF+Y5kEuGld2P1aG1nHEoWb0z1+QE4zHg6LtERdPLvtVUeR7Gd4lWfV8y0JVjfY9J
         eCwkyMVJ5yYWQZWsGJgtAt0VO72PzGVI/m/rxrWonIzp/HljshwNsgYLSDc3edkMb35E
         VHSVgHmRuubUDU342gB8FvUMQuCdJg4IH1QDkYsvDvwIfgsPvMdFAg8lfRGSFpitMg89
         0AOrdBP2h5HdVeOavsZwgnHCYRjF00wSTti1lMtJlmZp7352NkWlETVht+C7trxZgG4q
         npgw==
X-Forwarded-Encrypted: i=1; AJvYcCXlrhq/IS/Z6WS5hFzEyCcjTcE7bOth0ntXJjNKUFP175wtrtMWtlC1x3uI+4L+HWgaeSe5ZRXMXKJZ8QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLFT3ygYJ8tezqouBhOe/aolxLthxxl7Wq3jHW+/vpXgYEoOK
	mPFNnYDgsS+UBLYEzJ3Tl26w3pHRiIIZqMMhLM1UkjbSr97QDZREUpaifXpTY1/VKJuFdmlHXc1
	WG9qD4fdZ0Kq1QPqReER+zr2pk6syoXCFADuwjcV7X6mrT+hdr295qllqwjYGRs/BlQ==
X-Gm-Gg: ASbGncvvDvsK2EoLzFTpO0GpX9BSKrpXlf6ujSC7qv2KydY00tzFzue+lL2KbnSX/ex
	b/hJeTueZc0aFUbgEkf+X8h0Xer1xQIoUuWwpp5/TScc1ESewz6mzhek5JYzNheNgDkWq9ymfJZ
	GesVmEYO4PZU7FydOgIVn2f7xsrDFIskQu/S1wBjP04KMTzw/xxFadfeJpiCjhesrk1Gyok1Dz3
	2BkUvIuaRqRiQSb18v6NuEXJO8iT5TqxWpDnoLEQtmh782qlFzkJ7zIQMM8mQ6kHCyIVQk2OT/0
	vIwEiMU3MW3R0Ru+HStJYCDiM1lSwz4kpLLcVxOhIb4vh9ZZ+bdJjPnykyIuO4s5duxFieW5MW1
	xgTvas/vKWVQBtypC0Q==
X-Received: by 2002:a05:6000:3102:b0:3fc:54ff:edbb with SMTP id ffacd0b85a97d-42410d42821mr4360750f8f.9.1759239636233;
        Tue, 30 Sep 2025 06:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK1fIV99U75p9fIG0T9bgbW2kRrus2xjFJNs0OgF8YVoLPSJiOafXYnVsiEwLidRiRgrEggQ==
X-Received: by 2002:a05:6000:3102:b0:3fc:54ff:edbb with SMTP id ffacd0b85a97d-42410d42821mr4360711f8f.9.1759239635732;
        Tue, 30 Sep 2025 06:40:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm22686562f8f.24.2025.09.30.06.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:40:35 -0700 (PDT)
Message-ID: <a0006002-32c5-4595-a66f-258d4d17d52a@redhat.com>
Date: Tue, 30 Sep 2025 15:40:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/1] Documentation: net: add flow control
 guide and document ethtool API
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 f.fainelli@gmail.com, maxime.chevallier@bootlin.com,
 kory.maincent@bootlin.com, lukma@denx.de, corbet@lwn.net,
 donald.hunter@gmail.com, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 vladimir.oltean@nxp.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux@armlinux.org.uk,
 Divya.Koppera@microchip.com, sd@queasysnail.net, sdf@fomichev.me
References: <20250924120241.724850-1-o.rempel@pengutronix.de>
 <175921920651.1883014.4986159833879484611.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <175921920651.1883014.4986159833879484611.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 9/30/25 10:00 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> This patch was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
> 
> On Wed, 24 Sep 2025 14:02:41 +0200 you wrote:
>> Introduce a new document, flow_control.rst, to provide a comprehensive
>> guide on Ethernet Flow Control in Linux. The guide explains how flow
>> control works, how autonegotiation resolves pause capabilities, and how
>> to configure it using ethtool and Netlink.
>>
>> In parallel, document the pause and pause-stat attributes in the
>> ethtool.yaml netlink spec. This enables the ynl tool to generate
>> kernel-doc comments for the corresponding enums in the UAPI header,
>> making the C interface self-documenting.
>>
>> [...]

I'm sorry for the mess and confusion. This should not have been applied.
PEBKAC here. I'm reverting it.

/P


