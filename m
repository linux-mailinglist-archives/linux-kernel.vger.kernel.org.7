Return-Path: <linux-kernel+bounces-838529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE3BAF663
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C4F3A6F02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF226B2AD;
	Wed,  1 Oct 2025 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx4vxKwL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024D2309AA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303514; cv=none; b=BOywKiR9oV/vWSP0LgnHdWj2ZANkPtgaYtNLUwuXOh0D+PY87lWIQtT2o+wBN56iO9E92Vq4OYyZ/oaPFIyxBiQYH+Agl/YOVD7cUIHGlbUrPb+FWPWhMvFvN3eDx69+hro8o2FMVD3dUu9d3sfyiLDggrfggKBcU2+cF9GlpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303514; c=relaxed/simple;
	bh=r7NA1kRD7RYmpKkMZ5JqC1r1jYDj2NzCHIGDJwN0hGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaqtO07LfywdOv5kW1mu2pv6w+oViT4P1bsjJrbFmQhpIqfNqejdjDA/I8NgSydYUH/vo9Dksikj4IZt8Z6Y4MncNF4YYqlKecjRS9Lvyx+Vj4OYvVexbMXUQLOB82uDuLjEeeWupHPpul4F6qTnswQEXHFWDi6pE4zwMcxncSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hx4vxKwL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759303512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONrm520dkd+lQqlPmyPFU3y1WxiCuM4kiuFUCUUyuHc=;
	b=hx4vxKwLx2mIZQ5QKul05ELwdClQSGR4ZPHmES4sgdg9+6aPiCQxdTf7PdwSPLVmiAnw4c
	n3a902hvQGOf93heGkf2kS0x18CBA3NyuZfr4pSMfbBs4r+7cHKMWn0gTVVVeDYtWF26lg
	EQro18k1zojAdFW6ceyS0n++iSHx+ZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-jiMRV9QyPRelrvH3nXY_7g-1; Wed, 01 Oct 2025 03:25:11 -0400
X-MC-Unique: jiMRV9QyPRelrvH3nXY_7g-1
X-Mimecast-MFC-AGG-ID: jiMRV9QyPRelrvH3nXY_7g_1759303510
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso1536745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759303510; x=1759908310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONrm520dkd+lQqlPmyPFU3y1WxiCuM4kiuFUCUUyuHc=;
        b=GdMH7jfX2vsVhzunFwRaS8seKf7XaWMKAQBERNihAmtNXfsp9Gdx69+/gC2TF3wEHp
         8qq++MzStHmXt4k0yR21Y0t6tnMhG+S+DUuDDL79hZU3WSdDG2HJZJtUzAOfE+rQv4io
         McGTv/OfKTFIq8V6iYtXZDU9cFQaMaRO1/qN5Kd2Ev5s1+C0lq1exuN96JvZ+hHu1dsk
         hCo/AKRnP/t0T6oU0FrrP2Uoj0euFPxDBLWka0KfYIY6+UmxUeLoclMTcnV5Ve0lskhx
         UxdUy9L3tgi2BEHHxUIuRNnIf3IxW8VsOkCNfFQ+ckLuPyZJABd4m1UTGRp1V7O3fdNo
         l8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVdAdLcFu3ZjjG8SFHuuC4VDlX6g4tuXzrjNNqZR9KYBQmj3ZHdM2wa+JoCV+a74Ar4qOABWlrxP5HyHXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiO687ocLVSfgta1LmHUeUfstJF4b/zrYJMv4EOuLOl7g0zh7
	vv5hGYQrcpDGhjK6j55b0Fxup6iz3DQss2okVayPh6v1o/qFx/gbCvQAeYrN2eY7BvLF7ZgUWY/
	TR79Fk7e4wvUtNymllKZBTpfWRzkRtZg/uou4KGpFrbnD/A/UyzZ+Ypy9T4U0gW0sXQ==
X-Gm-Gg: ASbGncvzfC9+m5zBqdeCuSPXNwWQPV2R9mL3o6PjoO4PmbmBf0EiW55as3h+fQyNYhZ
	j3Un/3MoT1S+UNaQqB1tcazz30rv/DSqQ9p1p5SNUoCCRtQfXRunDfsGuyx0uxdy9zN6LvNJAYA
	7gS7moJVHR2ps0jrPsfB23ypRuEtX77kZeMDspUwMiYbBkWFuFYKWiOJ+RAccnXdoUsgf/ePvPZ
	X3uy1dsZGYmkYnPvRX5f6hsY3PbHKZVif80TdGM+Paw1820eI8zN0icDGmeaukDUruTzBLIunVE
	Csp60umzvxwp8DmkJX7QwrdUWZ9nwSbXqcRruC59e0JXvCbJKN8VjzYbUESDRZAYwnP1kjRBO/c
	qieIrqINBUgjvzL9suQ==
X-Received: by 2002:a05:600c:a210:b0:46d:e5bd:2ba4 with SMTP id 5b1f17b1804b1-46e58d16578mr35721305e9.18.1759303509718;
        Wed, 01 Oct 2025 00:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYANHEU4wHCl6KF8iSKnSJvFPjuGdoHZjMN7oYFUa7TE3yY0tBZuepifFCIEmjJ4HCuCIziA==
X-Received: by 2002:a05:600c:a210:b0:46d:e5bd:2ba4 with SMTP id 5b1f17b1804b1-46e58d16578mr35721095e9.18.1759303509297;
        Wed, 01 Oct 2025 00:25:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b8343sm25823335e9.2.2025.10.01.00.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 00:25:08 -0700 (PDT)
Message-ID: <d5aaff54-04dd-4631-847c-a2e9bd5ad038@redhat.com>
Date: Wed, 1 Oct 2025 09:25:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/2] net: stmmac: Add support for Allwinner
 A523 GMAC200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250930172022.3a6dd03e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/25 2:20 AM, Jakub Kicinski wrote:
> On Mon, 29 Sep 2025 18:08:04 -0700 Jakub Kicinski wrote:
>> On Fri, 26 Sep 2025 03:15:59 +0800 Chen-Yu Tsai wrote:
>>> The Allwinner A523 SoC family has a second Ethernet controller, called
>>> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
>>> numbering. This controller, according to BSP sources, is fully
>>> compatible with a slightly newer version of the Synopsys DWMAC core.
>>> The glue layer around the controller is the same as found around older
>>> DWMAC cores on Allwinner SoCs. The only slight difference is that since
>>> this is the second controller on the SoC, the register for the clock
>>> delay controls is at a different offset. Last, the integration includes
>>> a dedicated clock gate for the memory bus and the whole thing is put in
>>> a separately controllable power domain.  
>>
>> Hi Andrew, does this look good ?
>>
>> thread: https://lore.kernel.org/20250925191600.3306595-3-wens@kernel.org
> 
> Adding Heiner and Russell, in case Andrew is AFK.
> 
> We need an ack from PHY maintainers, the patch seems to be setting
> delays regardless of the exact RMII mode. I don't know these things..

The net-next PR is upon us, let's defer even this series to the next cycle.

@Chen-Yu Tsai: please re-post it when net-next will reopen after Oct
12th, thanks!

Paolo


