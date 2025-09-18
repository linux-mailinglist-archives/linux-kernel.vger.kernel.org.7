Return-Path: <linux-kernel+bounces-823027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3406B8555D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8912F7C4337
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8F1EEA49;
	Thu, 18 Sep 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1YV6vDWM"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D182110
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206853; cv=none; b=ctyhvdypTftCFnxrMB6KrPD20ic4z0Uk0i6kGkraHn4IEN0Tq1rjnjn4JVOhWbzN8CglZI2FJzse8/3R/HNVQ91vOlXqHLFbVBl6M3SzDam84JeFsJ0o+3jTGDtAdCyU2UKuLwEQTgwTFuOQwAKtDLwtGWJzK3hk7qfFgvlT4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206853; c=relaxed/simple;
	bh=akaRzKCQx78YkRPr4p40L/GyehZvgbPiD0PCPnmsSFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVu450WarFaaEbCVHJ/39CF2l/hpM/hYME3+ETlrePPkL7BcfXTv0UM9vitEpFJH+ARG6qMLXHQLWjsQGDGqGgB/vVlF6ilHns0EwFtffYN1LjkAdcQ6m2lTk02TryH1VQ0Rjs8Y3r1d+PdAKLg3MyHGi3QXmNDQlTi80JdUQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1YV6vDWM; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42401f30515so5635885ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758206851; x=1758811651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAKrVBT0TdCvSecGbjneeeJlKJ2CfD2yiQLwxahqo/M=;
        b=1YV6vDWMH1oE8DE1gQDSvM0uc0uylqvn+u73kuydLS2N1LV+SGc9FjQ9uA8mfIOp2i
         pts8gU8JJm7LO5cPsU/H9lIgbZWQ3HR7BFqq3Cul/jgd7iyGJyoMYV4KChKTWGFafPXV
         xJzh+1Xn94qgLqsZzgKIzSltX6YDxHXMGaC0EzyxdGzMbOcvG/cbNHmzXDersOjorGn0
         7YnslRDqR0u9uoMPRO3/U7TAKkoc/NBsA5wDNenWzOdV9o+BCmHMjjfygYtvCIfSSd8h
         lvfwQuCQk6CjPmWDTUW2T2qFZDS/EG7hXSA0P+H+r0NmVQuRlV76o5faU/OI/mCo7AAa
         2kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206851; x=1758811651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAKrVBT0TdCvSecGbjneeeJlKJ2CfD2yiQLwxahqo/M=;
        b=R5C45b+rRoZyvHDD5T+HRy8OXtp+cPbTaP/3pZr6Sr6mt7FozYozuA8Iu1LPuYk3ie
         nkNuUNYtzVsKzXCKGiux7oQk1oVhJ1fXfQlXnLjQmbbln2FvbXNJYYsKuxdT7+9rZR8c
         03hQtjWI3XExw8Vj8DPF7hOhgdpxmXBHvjVFWoryc7RX/MFTQD2/Iri3+5f/3XSm2nSh
         TysWuheS6s0CuLQmWxtfAqEP7KDinyBBZn3PcICN+JjvvTgwrSkFw/OwXd4Eu1wVxq+5
         1ONjI7fywErRb2G8stCc3NZDFIlg/zhVUswOo3rcxtEOkA1JAhBtxt6Mpzr/iQN1pQES
         qQfA==
X-Forwarded-Encrypted: i=1; AJvYcCWBIveE7ieD73h5A0kA6WUBD93//rblV7VxqlT5YbkLFvfCOc16Y8mx/tan/oXVWK099XvB88kr5RwxkRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/hOd74l9AREpfzpe0jzmyKXhLpzBzP9Cmm/wgjgcBRsgW7j6
	ayrZetueJke0se299lQhFaQdmOW85J/grRU+Tlob+arCgusbJVft8Z8ACsrHHhONxKw=
X-Gm-Gg: ASbGnctjoBqQsrSHMNsM+rAk3eJ6lsMSN0ZidR0/aKbxXVmYYrQKfbLmQBBWIQVx5OD
	+I25w50H8bSRs4gV8b53+LaTv/lWhmUsOuGHpi/NF0BnPztsaGHeNG+2lztsvi4hqWnZXYoIJIa
	kNUfqhw7sAnqRb8lpw8+9sOWqShrxHJX5oZdJNQZKxqDDTdbwUy/irG/vG7XbdUnBTHwHCUU4v+
	g3QrJ34dpsYvAll5+AUOqrI4zq7DZWLc+mhVGye3h/Au0DJ2pCLCAP0xG/allRSfJS1PWT9drgh
	9EpxqmRqU8UxkCcigHtKpKfdFxgUlpcgngdlERz9gkfkbmuP1V+6Vv5YYNR83e6ceRlJ98O/ONO
	tklMYLZDXveB4fyQVg/uSRjnaOvbQCkKQEkkOFIzWJkSke26yj5JsYflZ54khfFrnBVq9ZImEFq
	8jkVODlQ==
X-Google-Smtp-Source: AGHT+IEwi75aX21g/zBSieivVckv6HnF5UMX8645TVtHJlraH1tEzr8ABh0L6G+D5Sf9/VskB4583Q==
X-Received: by 2002:a05:6e02:338c:b0:422:fc2f:b809 with SMTP id e9e14a558f8ab-424414d6c95mr62078845ab.6.1758206850744;
        Thu, 18 Sep 2025 07:47:30 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa6538sm995541173.51.2025.09.18.07.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:47:30 -0700 (PDT)
Message-ID: <cedaad98-1eba-431f-af4a-b84e106e5f65@riscstar.com>
Date: Thu, 18 Sep 2025 09:47:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <20250918124120-GYA1273705@gentoo.org>
 <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>
 <20250918143928-GYB1274501@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918143928-GYB1274501@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 9:39 AM, Yixun Lan wrote:
>>>> +	u32 data_reg_addr;		/* DMA address of the data register */
>>> s/data_reg_addr/ssp_data/? I just feel uncomfortable with redundant 'reg_addr'
>> My convention is normally "virt" or maybe "base" to represent
>> a virtual address, and "addr" to represent I/O addresses.
>>
>> This symbol represents the physical address that underlies the
>> "SSP Data Register", which fills the TX FIFO when written and
>> drains the RX FIFO when read.
>>
>> How about "data_addr"?  I know you wouldn't like "reg_addr".
>>
> another idea here, instead of introducing a variable here,
> how about simply using plain iores->start + SSP_DATAR?
> 
> so you can cache "iores" instead..

This code has gone through a huge amount of refactoring.

I hadn't looked, but now I see this field is used exactly one
place in the code, in k1_spi_prepare_dma_io().  It's still
needed though.

Here's what I plan to do.  Rather than saving data_reg_addr,
I will simply save base_addr, which is the I/O resource start
address that corresponds to the mapped virtual pointer, "base".

Then in k1_spi_prepare_dma_io() I'll use base_addr + SSP_DATAR.

OK?

					-Alex


