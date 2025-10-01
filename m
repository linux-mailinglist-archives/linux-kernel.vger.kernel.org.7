Return-Path: <linux-kernel+bounces-838561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C29BAF8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93F11C34AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10966279355;
	Wed,  1 Oct 2025 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMw5wD2K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AC26656F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759305967; cv=none; b=UXKx5leUESoKD7Sd/dXcYqANb2x9VRQsCbFQ09WBlkYPJo0H6AjqiTvQwME46CzBhIJC5FO03L6T2PVz2Ps45MJu9DVL1KfXxXJaETfDCszWZj8NYSIaAq/uYdXmeZqNpWrwzWw7/uFFbTW3xSiE/maMfK45iFdC2m79LYOW4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759305967; c=relaxed/simple;
	bh=5haNAEiXLgQzh1JAlqW9TjWwiFhiqV+0nJNKffjfNHQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aCWpGitnJaTrf01SW2cdQ0mGL+j3lxGQOqiM1fJggYiaWLfpWPnjGF2qmuFWWvRHW9kDe9Qx1oc6ZTsmhjgpzIyJH1s18J5hvvyzx/7NOeY5RAYIXZXmaCdQ56YDvZgCUaxDD7qYCGsefznHfx+YPanJslwa1/vZZIuXvFTkUnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMw5wD2K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759305964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTb+HR144WzaCHAGjWTq7YSgDtzJUyYbacPJ6jqxs7k=;
	b=BMw5wD2KK6mW0/tooM084wg1KO0+DFhiRq43LEqNsAjLgfr16G3qUNjePy/vv841HOQYv3
	nvLoOH+sqPPXxXih0FPAZTPmnNxUptBrtu5golbAv0s64tdQjmYYyPmZeyk4jnbAjg7QHI
	Ap83b12t1tUrQx84mwBj0783FH4jJb8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-wdhYJizQOeaPKydE7Ik3Nw-1; Wed, 01 Oct 2025 04:06:01 -0400
X-MC-Unique: wdhYJizQOeaPKydE7Ik3Nw-1
X-Mimecast-MFC-AGG-ID: wdhYJizQOeaPKydE7Ik3Nw_1759305961
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso49179775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759305960; x=1759910760;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTb+HR144WzaCHAGjWTq7YSgDtzJUyYbacPJ6jqxs7k=;
        b=d8kYTA0onkzovYH57krKuR8MbZeu1cINX2aHanvu+aZq4vMqgpbgVY1uDiWj/kyBzN
         AH5Jkbee6eRKd5UJbtFS3lvhBYNp2JPxWwOdlHz3s0tzwcGGrgDwdoQDzQHQ1u324Ep2
         l1FpB7m09sRogPYix5m5ht8ehfSZTUpNGBnWmPrZcwlhfN5aUZCg6ehL7KcA2Bimybmo
         oys4spqYfASJUbGRzAil11gaZnsxKG5S5IIuM46ggSxbIAxKwmlpXpdBi4RtZsH2K4UT
         xL/tW1afBRHInJevx47PTZlO515mzLjRUK/1B8R8a8RDRf5J7pX1Cqxd8KVuPGsxE6dZ
         vhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiQTS1MjDKgoprlFxzAjDzxXCrzJn4cZWlUvJJMSxd24L8wPbsxzFUN8YppVZwkweSi8dZ12etwKuQwjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JyAcD6OCYNjwVMlkNS1rCwhEoE3rdZ5OBFoNch0C0YAx6cKn
	uQTWXVtB4N7AgLW4PdnSPJHQT/iFrtWehqEBu1EdDBYfJtkT+3E3wGAeesB7IbPWrkTeiRUUQ91
	7EJTb5nosnWsBihpmSRp/e0iDiR140p/ZJEQXWGi+mFrqC2welLg19RoFGqM6CtWpLQ==
X-Gm-Gg: ASbGncvJmEaU+4RnYlWEkoxA6suo8KU0oV5O/23kkKqqiuUnUNpxZnostBwzTH7WHhF
	jwpKBCVWvJk+gQrhBMPkvUnGXB+7kpDrGh3svtY/HiLPcsrV8ohkpqlaYAbY6vijqQ5i6ADxw4g
	YW+kopjM8qTQGCIFFLm26C5pZZLLTUr3ojnR2RzLv/N7BjDsQOqn+muY7N/TeL8w8n6KvZZb9rf
	Lfqw8AMSbB7ifLnZhVPM5cV8ZFpkQqI+Uq99m7XJ4gFwr0tz3oxVHSVB+DcJmArrJBlANiUGsPB
	sRwL1kCnoqtsPntu8TurGfsj6uaS/q9LgMgJz/XyjrKfNVNYmErAi++2O/NltBRmbrQQmzBd2ex
	EkFdm/EF2WECgpEUxoA==
X-Received: by 2002:a05:600c:a404:b0:46e:6339:79d1 with SMTP id 5b1f17b1804b1-46e63397ae5mr11782815e9.5.1759305960537;
        Wed, 01 Oct 2025 01:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK0k0YsqKjJ0KQb6IWjzPtVVlPN29UZlYbY/QuFx9mxVtSijrKT1lChFjdgZCBijgjZoxIGg==
X-Received: by 2002:a05:600c:a404:b0:46e:6339:79d1 with SMTP id 5b1f17b1804b1-46e63397ae5mr11782525e9.5.1759305960082;
        Wed, 01 Oct 2025 01:06:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c44bd75sm30723575e9.4.2025.10.01.01.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:05:59 -0700 (PDT)
Message-ID: <02355e42-9b63-4ea5-a75f-0f4e20323379@redhat.com>
Date: Wed, 1 Oct 2025 10:05:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/2] net: stmmac: Add support for Allwinner
 A523 GMAC200
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20250925191600.3306595-1-wens@kernel.org>
 <20250925191600.3306595-3-wens@kernel.org>
 <20250929180804.3bd18dd9@kernel.org> <20250930172022.3a6dd03e@kernel.org>
 <d5aaff54-04dd-4631-847c-a2e9bd5ad038@redhat.com>
Content-Language: en-US
In-Reply-To: <d5aaff54-04dd-4631-847c-a2e9bd5ad038@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/25 9:25 AM, Paolo Abeni wrote:
> On 10/1/25 2:20 AM, Jakub Kicinski wrote:
>> On Mon, 29 Sep 2025 18:08:04 -0700 Jakub Kicinski wrote:
>>> On Fri, 26 Sep 2025 03:15:59 +0800 Chen-Yu Tsai wrote:
>>>> The Allwinner A523 SoC family has a second Ethernet controller, called
>>>> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
>>>> numbering. This controller, according to BSP sources, is fully
>>>> compatible with a slightly newer version of the Synopsys DWMAC core.
>>>> The glue layer around the controller is the same as found around older
>>>> DWMAC cores on Allwinner SoCs. The only slight difference is that since
>>>> this is the second controller on the SoC, the register for the clock
>>>> delay controls is at a different offset. Last, the integration includes
>>>> a dedicated clock gate for the memory bus and the whole thing is put in
>>>> a separately controllable power domain.  
>>>
>>> Hi Andrew, does this look good ?
>>>
>>> thread: https://lore.kernel.org/20250925191600.3306595-3-wens@kernel.org
>>
>> Adding Heiner and Russell, in case Andrew is AFK.
>>
>> We need an ack from PHY maintainers, the patch seems to be setting
>> delays regardless of the exact RMII mode. I don't know these things..
> 
> The net-next PR is upon us, let's defer even this series to the next cycle.
> 
> @Chen-Yu Tsai: please re-post it when net-next will reopen after Oct
> 12th, thanks!

To be clear: given Russell's ack I'm applying the series now, no need to
repost.

Thanks,

Paolo


