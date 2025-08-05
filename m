Return-Path: <linux-kernel+bounces-756894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF9B1BAD2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A20818A7283
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AB421FF53;
	Tue,  5 Aug 2025 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="rQJ3kaEX"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6438A218AB0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421493; cv=none; b=YzjtmRxECgywgNmpSqeI464UJ8acgworLALOXLXNkRo0FWx6g7/OcsC6VSkeH2WmU195Zjuyix6wSIC1FlCPXFWX2F4LLrCQt74bvwTnCd25WiNN24B/IsLahaeqUyy7GFgVMkaXc76QEQmK76TQwF2Lh1VWro9SRfii3VrfUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421493; c=relaxed/simple;
	bh=0izG4qu+r0SiyNyVy5TDQ7AxnFYT2GlAhDxiwIvyKvI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EydthH4MQTwWTNLGmzHuDGmjdqekD+uCAf6TIyQ4cHD6GzMd4gm9AbYLZ9PH/RZ+NMIi3h9fpWpMvQ1XGETsT4tfRHiC5B/ymN18IaHJrQZTC/T8ePQFQfDZpGs1htkM6f0ZEwt+VimwzZZ0hB55hJXDX2Y1Vhsposnl9XvyvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=rQJ3kaEX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so1028906866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754421489; x=1755026289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8DvN5lxS4knDsC63rKq5KShQ1HDgQJ8LBToB5QZ9RG8=;
        b=rQJ3kaEXnvI39wI9xciCr0YWo5M0Z1WEZX52VnwH7O7lEYgmE/TNauD0jUSHBHWFwg
         MSqQb//blcYv0MzrlA40HVMAQuNljkISJR/pW24ag8RGkLzLujbFnw07pu9/4YQ2yjYa
         BHzq241qtlYDVvbBPHOH/o2k9kdDfP414g4tXMkeDj4BaO6VLxvhu8YdwRnLbS/J5v24
         fUvMCkN3Zz1ee9Fzk5dAmbYPI7nQduV7KHo7sE1xq4r8eXQaqxTGJ+gIgyWdfiivpCEt
         OKc4iAUSgvIg0s2ftr8r4IJI+ueTWxWh0hBHfxB3GP2vbocA+2zrpbRdhYKN7lXsqa+Q
         lJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421489; x=1755026289;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DvN5lxS4knDsC63rKq5KShQ1HDgQJ8LBToB5QZ9RG8=;
        b=pJypjNew6us7dqiEVHlv0FXiHYLTWgAx/uq1Sakyau/BeRXLowSZcHXMc+8Sry4jE1
         dzxIg4ertyBjAGEylYf3wRCjloUP3v/K44xnics9iFAS6F/so6Pappa9eqvW2tUp7bNC
         3VvUaUk7NS3u9WRgh7EFIGcfSBu8tYDg6GLU87um0aiQuJ42XOC7bzv0gvsvJed6A3I5
         oW/kX2epOrWSwzoLSgFhwG/lkJpFDr/Yb/EGLYKzfDv6lWFfqwbVskGQzyPEQHBfzCrA
         lNGSVGq62ljh0WeWkr527So2D1Njo/7kCnhiaJZ9F2XO4Ae+Z2mYhlbKDxaxGKTIyqJY
         R8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWsoDXU/ll1qELMmXSbRL6pXFCc+lxHkM5Q/L0e0IEtFfBFymt0EeszAlnmZB5XETbhxkgnbUFZyJ7Xchg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGkknAR1x7nCsD3+ciMacdic5AQDJ4c4HEL3TWwiRMGVj+0ir
	CzkX0nn9szL9H5BXgZSGTyTDUnvXgtOGwL1G3XDXZp5Mfh5LCPYhH+3Kp3l6jJ8cYI0=
X-Gm-Gg: ASbGnctsRrNQpK7Jbd6LthvNrMZdEVQA9C38vBWBNqjmXtAXPMcMNUX0EwxEDX9GXo+
	9F+F/EF6A7yfrWFMhty8pNJ91EZnpc87FYBBHQOn53YdOP9brPlPY6RHSOa2SRRYLTiGTK3T849
	nqZ1VReEMwO15yPosDCPbx5XOi8/y3dmZzEm4NvgEt6cAlS7TFXq0HbxbFl1FPIX+D1Xmx8Gjo2
	LpAK9ed2ENZM76Bpnlhr+IjbDUsAnampcEaQ2/V5SNErloXpPLesEhoDiFsjU9e8GxrWnLb8Pwk
	4dOcUERoz2h8PU9RlXu0XfEhvhC3q1PXWLOXsEWAketWUHd8QZYMOCx+kRkvBnBb8WZaAgBsqZe
	vG7ddkzarnVO2nxn9zdrMPlTLw8Xz5zM=
X-Google-Smtp-Source: AGHT+IGhtgMG1n0UhNe1tpSDtTnCW5uUKijjJTfvp8F0NXYO5GiDD7Wj3hLbFlKV+iKcJ0QPfWRSCQ==
X-Received: by 2002:a17:907:f816:b0:ae0:a359:a95c with SMTP id a640c23a62f3a-af9903fd219mr13094066b.34.1754421489546;
        Tue, 05 Aug 2025 12:18:09 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af9584b1f55sm544973266b.55.2025.08.05.12.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 12:18:09 -0700 (PDT)
Message-ID: <eb7241f5-4b52-4fac-8cb8-07d4a9958cdb@tuxon.dev>
Date: Tue, 5 Aug 2025 22:18:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH 2/3] clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250704134328.3614317-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704134328.3614317-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXGvNgv9hGhcr5MhTL+X_E2f-2kz2NEqhG1fw_dBC0uBA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMuHMdXGvNgv9hGhcr5MhTL+X_E2f-2kz2NEqhG1fw_dBC0uBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 04.08.2025 13:00, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, 4 Jul 2025 at 15:43, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add MSTOP configuration for all the module clocks on the RZ/G2L
>> based SoCs (RZ/G2L, RZ/G2LC).
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/clk/renesas/r9a07g044-cpg.c
>> +++ b/drivers/clk/renesas/r9a07g044-cpg.c
>> @@ -242,163 +242,163 @@ static const struct {
>>  } mod_clks = {
>>         .common = {
> 
>>                 DEF_MOD("gpu_clk",      R9A07G044_GPU_CLK, R9A07G044_CLK_G,
>> -                                       0x558, 0, 0),
>> +                                       0x558, 0, MSTOP(BUS_REG1, BIT(4))),
>>                 DEF_MOD("gpu_axi_clk",  R9A07G044_GPU_AXI_CLK, R9A07G044_CLK_P1,
>>                                         0x558, 1, 0),
>>                 DEF_MOD("gpu_ace_clk",  R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
>>                                         0x558, 2, 0),
> 
> Perhaps these two should have "MSTOP(BUS_REG1, BIT(4))", too?

According to table "Table 42.3 Registers for Module Standby Mode" only bit
0 of CPG_CLKON_3DGE maps to bit 4 of CPG_BUS_REG1_MSTOP. There are no hints
in the description of CPG_BUS_REG1_MSTOP neither in the description of
CPG_CLKON_3DGE registers that leads to having bit 4 of CPG_BUS_REG1_MSTOP
for AXI or ACE clocks as well.

I tried to play with MSTOP and clocks at runtime to see if there is any
relation b/w them but can't establish something.

I tried the following steps:
a/ remove the panfrost module (at this point all clocks are disabled and
   mstop != 0)
b/ devmem2 0x11010858 w 0x130013 # de-assert the GPU resets
c/ devmem2 0x11010b80 w 0x100000 # switch the module to normal
d/ enable different clocks and read one register as follows:

1/ gpu_axi enabled                   -> devmem 0x11840000 fail
2/ gpu_axi, gpu_ace enabled          -> devmem 0x11840000 fail
3/ gpu_axi, gpu_ace, gpu_clk enabled -> devmem 0x11840000 OK
4/ gpu_clk enabled                   -> devmem2 0x11840000 fail
5/ gpu_clk, gpu_axi enabled          -> devmem2 0x11840000 OK
6/ gpu_clk, gpu_ace enabled          -> devmem2 0x11840000 fail
7/ gpu_ace enabled                   -> devmem2 0x11840000 fail
8/ gpu_ace, gpu_clk enabled          -> devmem2 0x11840000 fail

From software point of view I can add it, it doesn't harm. With this,
please let me know if you prefer to have it.


> 
>>                 DEF_MOD("canfd",        R9A07G044_CANFD_PCLK, R9A07G044_CLK_P0,
>> -                                       0x594, 0, 0),
>> +                                       0x594, 0, MSTOP(BUS_MCPU2, BIT(9))),
>>                 DEF_MOD("gpio",         R9A07G044_GPIO_HCLK, R9A07G044_OSCCLK,
>>                                         0x598, 0, 0),
> 
> "MSTOP(BUS_PERI_CPU, BIT(6))"?

That was a good catch, thank you!

I played with it at runtime and it seems it should be here. It is not
present in table "Table 42.3 Registers for Module Standby Mode" either. It
is also valid for RZ/G3S so I'll add it there, too.

Thank you for your review,
Claudiu

> 
>>                 DEF_MOD("adc_adclk",    R9A07G044_ADC_ADCLK, R9A07G044_CLK_TSU,
>> -                                       0x5a8, 0, 0),
>> +                                       0x5a8, 0, MSTOP(BUS_MCPU2, BIT(14))),
> 
> 
> The rest LGTM.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


