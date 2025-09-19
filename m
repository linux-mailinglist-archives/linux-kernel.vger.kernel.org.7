Return-Path: <linux-kernel+bounces-824152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5DDB883C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DC9179BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97BF2F747A;
	Fri, 19 Sep 2025 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LLfIf4GA"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206252F7AAD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267540; cv=none; b=OU8eY61t0V85Hjvbmr+4ubLoTS5l505+atEt2jq8wmHrsAxWwKpneWZT+2kenacIdQskQPQvb6qiVcL9Ro2U7QUWrccs+xkDwV52plze8i0iib2hUk8oHImUcpVhvyTcEnG74Gp1nhS/MZa28JmLkFubrcr6onQJLLQV5tkEAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267540; c=relaxed/simple;
	bh=kMc6qIYkpkSaZVkYzK0h2R64lMZcG/aeYocJD7OH9t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0xK3OlBCtZnj7eAsdrCNSRHEkuKnJO1HTzBraB0Kzx6++aXBrHthPhLgU0MYEK74X0OjWWWwsBMmQ4awY52VezuyXXb9rW3wy6T8zRMWzfFb8ZkEUhuC2pmr+Z1AljtWK87srlZOj4GZci4viH/4B8hpureDTnt74uK/2ngFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LLfIf4GA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b042eb09948so317251366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758267535; x=1758872335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C52fJI8OZn6dmpJ0EOOlg/5SF4AUK9kWOko1av6xLQQ=;
        b=LLfIf4GAnVHjjU7p7nlOkC4EhaL2uxwAaiVPmwozaKqf/Tv9iNlt8JRYALD5QEJGq1
         vLnCmIBKAL8b57erjZBJQum377AcTR1Zc02OCH5DfOOEg0klz47zdq698d67fMZlIthG
         B5/l8VqVSkIfYMgYYlvy34sn/3fjjm7hCKI8738VPuATVWOvwxeiij0WAzMOIn2XuaXw
         z1HoaJ5F/iT03Wqp2z2gOBNYDNQvvpQyJbBbW52D1HTtWkNEdHSLdr0AZ9FLq3lxGNZ1
         PrCLb5fWQZsP+S4N/sFGAzUcylmgvYda6n8AwWiPMVVFmlpAnn4BAHmZEEf8Ec1M8qXW
         Aw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267535; x=1758872335;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C52fJI8OZn6dmpJ0EOOlg/5SF4AUK9kWOko1av6xLQQ=;
        b=phB65l8b4tcY2dLQLu2erWJ5Fsuhw77jxGBX0dRC2gqxnhgSkbIEdjpFn7G3xTWT3h
         jAMwxStz3g/S/C3B2Ib85juu8jysKLs/UJ/Ej4/J9gyKDnE1Cux+X7HiCzgd7QKmnDRI
         ayiNXMuL02LvL/mraszGhmRrZe7tBBtQSTUo5A/Hp14oGGdzmMh/4Os4saXSzOnTcoz9
         xQA+T/xelnBk3xpBmeQn6AGSKBjW5odiTTv6aKETRtM2FrS07H6SHsN7Easrx5sM4epJ
         P+T8X72+/wAOEVrx6J63Nme5R/Hj7YP6r9wDtEQ2CChp4OZUQYOK1BeXOwF7wLCt7inK
         jnGw==
X-Forwarded-Encrypted: i=1; AJvYcCXPAtBJIQRY2GpHgU+YhsUIL0YedTPHY2i69OqnyMcLxGKsxVPyHWw1Ee171GT0vXPKP+NXLNFZKCKro+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ztql9MWrg0TNVK6s0k3ECcoiw6ww5UKw6guLJpcfInl7tpP6
	5IAI9rChgLhAGflqF4lbkPIgHobooWFxQhbIg5HHfdHx8MFBl2E3r8gVGI91t4Ls5Vw=
X-Gm-Gg: ASbGncuyAR6gSO0tFfTWKsSgPAmF254NMge6tY6DRgRIxwKcqf+59MvLCOaA9GEhDLj
	5wIDXEFOsjIpRaRQr7xKiAcWA/gTFgEX2j+pXLN7yWaJmJdzA75G58V+tFSIn6eKCmSP1UPvoeX
	xUdBrmi4aGZLJXeJW3WPn9AEJHD9SFX0AanWCP4C9nKEbIoDerUUx+9/8605GxeUzgdG3SIIkLq
	HX4ZqTvYFtTYmyxn8pPWRT/TdO57HZ0CHB0eZJiEt3HJ5cQyoSwUcQV/CzFICIJfPwLlhjTjL2H
	Npr1XLodQoQqvKQGLrHm3+Ymx4cnUlo5O2ZYxPt564nYxNX2QI2LSUx4q+n9J6JWDxwJHhPG+oZ
	GpX3xddu+TNZvv4k5uss182zjS6icfY9sg7HhRKCtHQ==
X-Google-Smtp-Source: AGHT+IGZhuyuyTd1aKAi+fBtFosLneGcx8gx8yEr9OgXp4C95CMy9oC3K7BFoFpsdhrbZOu6d5TNSA==
X-Received: by 2002:a17:907:3e96:b0:afe:63ae:c337 with SMTP id a640c23a62f3a-b24f727a7f1mr237583366b.57.1758267535087;
        Fri, 19 Sep 2025 00:38:55 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f43924sm386437766b.6.2025.09.19.00.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 00:38:54 -0700 (PDT)
Message-ID: <0a20c765-ff72-4c03-af84-dff3f4850fa4@tuxon.dev>
Date: Fri, 19 Sep 2025 10:38:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
 <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
 <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
 <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 9/18/25 13:00, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, 18 Sept 2025 at 11:47, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 9/18/25 12:09, Geert Uytterhoeven wrote:
>>> On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The first 128MB of memory is reserved on this board for secure area.
>>>> Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
>>>> memory node (memory@48000000) excludes the secure area.
>>>> Update the PCIe dma-ranges property to reflect this.
>>>>
>>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>>>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>>>> @@ -214,6 +214,16 @@ &sdhi2 {
>>>>  };
>>>>  #endif
>>>>
>>>> +&pcie {
>>>> +       /* First 128MB is reserved for secure area. */
>>>
>>> Do you really have to take that into account here?  I believe that
>>> 128 MiB region will never be used anyway, as it is excluded from the
>>> memory map (see memory@48000000).
>>>
>>>> +       dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
>>>
>>> Hence shouldn't you add
>>>
>>>     dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> 
> Oops, I really meant (forgot to edit after copying it):
> 
>     dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x0 0x40000000>;
> 
>>>
>>> to the pcie node in arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
>>> instead, like is done for all other Renesas SoCs that have PCIe?
>>
>> I chose to add it here as the rzg3s-smarc-som.dtsi is the one that defines
>> the available memory for board, as the available memory is something board
>> dependent.
> 
> But IMHO it is independent from the amount of memory on the board.
> On other SoCs, it has a comment:
> 
>      /* Map all possible DDR as inbound ranges */
> 
>>
>> If you consider it is better to have it in the SoC file, please let me know.
> 
> Hence yes please.
> 
> However, I missed you already have:
> 
>     /* Map all possible DRAM ranges (4 GB). */
>     dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;
> 
> in r9a08g045.dtsi, so life's good.
> 
> +
>>>> +};
>>>> +
>>>> +&pcie_port0 {
>>>> +       clocks = <&versa3 5>;
>>>> +       clock-names = "ref";
>>>> +};
>>>
>>> This is not related.
>>
>> Ah, right! Could you please let me know if you prefer to have another patch
>> or to update the patch description?
> 
> Given the dma-ranges changes is IMHO not needed,

I kept it here as the driver configures the PCIe registers for the inbound
windows with the values passed though the dma-ranges. This is done through
rzg3s_pcie_set_inbound_windows() -> rzg3s_pcie_set_inbound_window(). The
controller will be aware that the secure area zone is something valid to
work with. In that case, if my understanding of PCIe windows is right, I
added this in the idea that an endpoint (a malicious one?) could DMA
into/from secure area if we don't exclude it here?

Thank you,
Claudiu

> this can just be
> a separate patch.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


