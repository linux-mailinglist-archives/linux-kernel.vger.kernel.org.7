Return-Path: <linux-kernel+bounces-832381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12968B9F305
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B281C2171A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF3307ACA;
	Thu, 25 Sep 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="StNsYGYl"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D12FD1B8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802629; cv=none; b=swVilwvTHt/FcQ3pEkdd63RhDlg7Ehcy+nTYEdDtnRRzAvFuWWiySXJn07cO1OSjUL8+M/qXNZykOOlcIP1GA4tRC2E37aGcWcRLP+0rVgyJgux1mtLenjB+6WrWIMH5UzxsB9ib49oJVw5a4LQUaqQvnWMXNuvtceYcBTf2OsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802629; c=relaxed/simple;
	bh=vgomaG/u0thPIen/u5fEAsol9ifdvARTkvcWUS9qze0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GHavQo3JU+jnHqfA97xCHpimvuNGaINPq1NNjZsrLpF96BG4qoh61TOl54OD0f6+MFXkoAhV6t72wmUyRp1jlgMKUXJmnlR9w5Q63kDuUwdZCcFBIx5vQ4hqG9VNoDIHEoYSpbWAua7GZS7zuq4eGLZqlIOoHDF613XVtNuueiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=StNsYGYl; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-889b846c314so30007739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758802627; x=1759407427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iiMnnhjmKlHUptnM90BucFSlyBtvswCn8MfVq9OViiA=;
        b=StNsYGYl0erLr5FKVWx4W9JZSyZNyKMHScuwKRWPR6RtKFXxVA4da6/bWzXOsx176b
         TMhJK7Ot708G300puVuls6G18fitfQdvIGDvjFGQfvShh7Y9eNOTddpodHL+US2c4j6U
         pv3S5NDHlVEIeoZAnvlKC0S/7MGoOUm5/e2DsjUYeyiQVRBS9YzTzfQ2/rbCmcgV+rMP
         fmYkORfD3kY0WmxhT3l2EDgMQIplNNpHaOKd8wv5LnBM+zffENBgJIu2/fgKbBWT3qa6
         aAzZD8aJpvQ6Vd8U96p1CD/oGORLGdgZrVamEiEKlbIFNkZ8GN/zT5hVSqlyXlDxniyT
         15qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802627; x=1759407427;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiMnnhjmKlHUptnM90BucFSlyBtvswCn8MfVq9OViiA=;
        b=Ueqn05LKHSP0zRlugh0+n304obEy/H+alpc69dHK5micOa2+6cVa607RiReBAdbIIH
         hO0VLnGEHNQxRrnrmjjxtiPsaxxnJuU/72ihydhuI1CwEWQs+a0bP+pHXf7yCiCxXM8k
         Z2CmWvC41KafkGFmZWNjyS+IqbcIU5M+ckYjNkrddjtpKbnrsJdNKOJPDZTl+6V2fqzF
         akWH0Zs49yIN1DJOxDgZTeKjI+DoW03GrMKr8IPAYWDGmuginEuTd/ieZwmqE+HVCMtB
         LQ+vPyWOL72tQJC+rJnRYoKLTEg9DWDmU7BbkP1gRHWkGmsksE95nvL/KaP72M1cPd6h
         Yx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdvpjz60G1+zXIf4oP3yhPg2eiTSnN7oJeMd+R5KrEJ3c2qSBj0JsrtrEusFbIfPhgTyvCY3n35ghXazQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Gfb55ITTJoBB2ckXVi0rfphAPnYZxUhwGdybu/xG+p+jzlvW
	1NNseoKt3oPjLvNDoCnFqSbCD0znvZ/8SLuJHOD+VVWcHDwJO3hNCZnQFjnN8RG3RN0=
X-Gm-Gg: ASbGncvS+D0PctH7pnxDQBjTiBmr7S9ja/ra9AgShgBMdEllpaHYm5aQlpu2+8h0XJO
	ROBJuFCM6uD18RcjsAc634GE/LHDv0GjrOj7f7LovdHxxHZb7S6XruvV8Fx8eQK6dAbsy12p1N6
	4EanMvwDT99Txlg5lu8AD3cM5W84VH2q2SDhcs/SZRa0YYj6dTNzq5F2yw/tCT2SDx7KXw4j2oS
	MmUaZPEsZ7YHvn7Y46rgKM5NUtbNLaEBcyxhZN4pa4qmP5l82B+Y1MsSGkYfJsZOMQpfF4//1Iw
	uoe7EIDsvVfZ3L0pK5EGbVtATaNsKA9AopAG/GhwWymQPF7p217AkuPEvLS1P9o4/1uLIi12UJa
	Duh5/YLjMDToDmI7weijYJb1TO0KMbgQdsSbYRBdCUjGw1LTaCdFh4BZA7xYqLA==
X-Google-Smtp-Source: AGHT+IGchv2CNYxx9JQbC4IeYd/wa2PLkKLFA1ut7JvKUIyUBucm43vFik72ll2XyHQiSOK+veiTDg==
X-Received: by 2002:a05:6e02:1709:b0:424:881b:ca76 with SMTP id e9e14a558f8ab-42595653b06mr40363335ab.22.1758802626788;
        Thu, 25 Sep 2025 05:17:06 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6a5adfa6sm750664173.58.2025.09.25.05.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:17:06 -0700 (PDT)
Message-ID: <ed0e5d82-040b-4642-8a82-611f6b0a401f@riscstar.com>
Date: Thu, 25 Sep 2025 07:17:04 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] spi: support the SpacemiT K1 SPI controller
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, junhui.liu@pigmoral.tech,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250925120909.2514847-1-elder@riscstar.com>
Content-Language: en-US
In-Reply-To: <20250925120909.2514847-1-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 7:09 AM, Alex Elder wrote:
> This series adds support for the SPI controller found in the SpacemiT
> K1 SoC.  The driver currently supports only master mode.  The controller
> has two 32-entry FIFOs and supports PIO and DMA for transfers.
> 
> Version 4 incorporates changes suggested during review of v3.
> 
>                                          -Alex

Please disregard this message and the one or two
others that got sent with it.  Something went
wrong with my git send-email command and I'm
going to try again.  Sorry.

					-Alex

> 
> This series is available here:
>    https://github.com/riscstar/linux/tree/outgoing/spi-v4
> 
> Between version 3 and version 4 (all suggested by Yixun):
>    - Fixed an underrun/overrun comment error
>    - Renamed a pinctrl node
>    - Formatted dmas and dma-names properties on one line
> 
> Here is version 3 of this series:
>    https://lore.kernel.org/lkml/20250922161717.1590690-1-elder@riscstar.com/
> 
> Between version 2 and version 3:
>    - Add Conor's Acked-by to patch 1
>    - Add Rob's Reviewed-by to patch 1
>    - Added imply_PDMA to the SPI_SPACEMIT_K1 Kconfig option
>    - Fixed a bug pointed out by Vivian (and Troy) in word-sized reads
>    - Added a comment stating we use 1, 2, or 4 bytes per word
>    - Cleaned up DMA channels properly in case of failure setting up
>    - No longer use devm_*() for allocating DMA channels or buffer
>    - Moved the SPI controller into the dma-bus memory region
> 
> Here is version 2 of this series:
>    https://lore.kernel.org/lkml/20250919155914.935608-1-elder@riscstar.com/
> 
> Between version 1 and version 2:
>    - Use enum rather than const for the binding compatible string
>    - Omit the label and status property in the binding example
>    - The spi-spacemit-k1.o make target is now added in sorted order
>    - The SPI_SPACEMIT_K1 config option is added in sorted order
>    - The SPI_SPACEMIT_K1 config does *not* depend on MMP_PDMA,
>      however MMP_PDMA is checked at runtime, and if not enabled,
>      DMA will not be used
>    - Read/modify/writes of registers no longer use an additional
>      "virt" variable to hold the address accessed
>    - The k1_spi_driver_data->ioaddr field has been renamed base
>    - The DMA address for the base address is maintained, rather than
>      saving the DMA address of the data register
>    - The spi-max-frequency property value is now bounds checked
>    - A local variable is now initialized to 0 in k1_spi_write_word()
>    - The driver name is now "k1-spi"
>    - DT aliases are used rather than spacemit,k1-ssp-id for bus number
>    - The order of two pin control properties was changed as requested
>    - Clock names and DMA names are now on one line in the "k1.dtsi"
>    - The interrupts property is used rather than interrupts-extended
>    - The order of two pin control properties was changed as requested
>    - Clock names and DMA names are now on one line in the "k1.dtsi"
>    - The interrupts property is used rather than interrupts-extended
> 
> Here is version 1 of this series:
>    https://lore.kernel.org/lkml/20250917220724.288127-1-elder@riscstar.com/
> 
> Alex Elder (3):
>    dt-bindings: spi: add SpacemiT K1 SPI support
>    spi: spacemit: introduce SpacemiT K1 SPI controller driver
>    riscv: dts: spacemit: define a SPI controller node
> 
>   .../bindings/spi/spacemit,k1-spi.yaml         |  84 ++
>   .../boot/dts/spacemit/k1-bananapi-f3.dts      |   7 +
>   arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
>   arch/riscv/boot/dts/spacemit/k1.dtsi          |  15 +
>   drivers/spi/Kconfig                           |   9 +
>   drivers/spi/Makefile                          |   1 +
>   drivers/spi/spi-spacemit-k1.c                 | 965 ++++++++++++++++++
>   7 files changed, 1101 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>   create mode 100644 drivers/spi/spi-spacemit-k1.c
> 
> 
> base-commit: b5a4da2c459f79a2c87c867398f1c0c315779781


