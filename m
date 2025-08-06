Return-Path: <linux-kernel+bounces-757627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D356DB1C476
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4BB167E76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C78260566;
	Wed,  6 Aug 2025 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kSDSihro"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86092433C8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476802; cv=none; b=XFFCuWvRQFV6+3uNSkON02+jrkMI6O+dq/8Qh/w9v+tbe2a3bmltbEXY6921xFdt0hPk68N73OaIvlPgXFZUsEXim+w24zO8+yySJcNVXP15TwKRHjRaK6WEnNkkN2J/vex6TB15FSFJhlPQxLJcIx9vU+TWE7V1HL94h4DLtgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476802; c=relaxed/simple;
	bh=TX2tAJkEQZa9XTS0GPqnY4OvS1tTNgim1be15DkJGB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chCIxt3jP54YtKKMiWmHEA+mMvgdjxPAh5SGlD3EO+1jS/WlvGljDxzcvCF9SuXIt5U41AE49E+JCOU12R1j9K4bLaV0keV4h2eRNFER0oXl7QgZNG8eKu4aRFmhW6cmIWqIWPNdJUQi8aFe0Ga+yvrRDjoAt/75Q6p4WaIArHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kSDSihro; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so10973594a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754476799; x=1755081599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=titscQ6aOjVW0NGtGerXnOmFu+BatzV4STGkNMkUG44=;
        b=kSDSihroNU9KLyb51iEBR892IPwE7QJaHnMmI35eTT65DPrxY3zb4QDbJc+DyrCY4Z
         V9GhntQslcDiIEOJ7THreD4U0e+vpjcG7tS2/0ZYfgMKI8drTYYUPH9RsJuCAxDz/CPs
         Jrpqr4FHGIwu7iOi/6hBJO19Np3YIB4DtlG6mQzy/Ch4g2DBWKb0zOu5znUFYskVKveT
         gG26h1FmUEZ6j6z3qwgjIiOnzGZquCA69FDnAn+SiMuBN2z5EZpwbkd2EZB1f/EweuE4
         PVq3kYXUgDXPj/jiX9bmvxErwSspLGYaJfz/VvVdMu3BQHGdNzASE3/Ba4IgrnzOYvN9
         Iiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754476799; x=1755081599;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=titscQ6aOjVW0NGtGerXnOmFu+BatzV4STGkNMkUG44=;
        b=nLHHsyosW9pTwGHOnkyheZiueMF+XMmnFsNd/a/0oEphLrsem6vUiYMdEcu4sAGiOa
         fCs8VoAAoTAWCyIrOpa9IdvDEONniRaNI1/XbyzzQlV7Gf2LMWJqVN/Ujwu0gVWr9G8T
         l34zt+A/zWAUuhZJhW2qOIQBbTb3zFRKmJ0EFcVYSMX+C9MNpwPbFwhqXPQ4sjb2MfU8
         KV2n5tF2/qGcVatgo4mGtWVw5QpJR8JPOYI53kO1qJCoK8ndkZ6rGLPIQNr6LGi4kzuT
         42PRDKYM7Fe4hgIXq7oYGYzaeaCLGBv0rgw9ImHUTz6+1XY1FFZ/2dGT5yKxraZoEEUz
         kgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0q93rCFDnZzJys/gKDjAXtdTNv0Gmuk8HPGfyGDNwpUjyT3kOxLD/C6YTA67cLjg/x182pJF2VMqCZZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTs4hWuHtdbY3zxXgCrutfZ2EIl59JqR9e17QItt4WqzDebjvj
	IviAw+u8lHfygSB9+ts/3xuiS969ih1brPLjmRE0k25S8uj1szbaiX5OGFZCXH7ogdg=
X-Gm-Gg: ASbGncsOoaTBUZhc9R4MLKPCc89z3f4Lu+EbSmbqN60tmBF9+SlNLy395vqnUJeYhC+
	lsejbAK3x4haIS36fZ8L8tXpy9JIf8rnWzuEZpQkkd5v4Jwi0vfmpWCONrbfDLROhgjd9uJdYoW
	OamhqTgiJRnxwtBAvR8kxT3c+bfOZ2Zg5Ozc3FQ8Ou8HwrEfVOBFH/CcjeT0vMawxzCOb7bBS0i
	423/dPHBOmHyTIuZqDlcutffirICKEQtxCu9es4iDw/kjKI0aJR05jZAjeLTqBqxqtuM+jBAtFl
	2wZTBi73n9pg/y9eGNv8GQw0QlpfoTed2mKD54HUfrJdzuccGzPN0+3rcZ2rAQOrQgCmVdI3+/5
	mvxtAk30DHzYa7Q6uk8lsolP1DZNmcU7cmqZc0F0tyw==
X-Google-Smtp-Source: AGHT+IHqnoMWs0fFU538b4C2IwDWUyKcR2dFyHunG3+0ppcR4vMBGndqEfDbUwOBbxO3i0Wbbgx9Zg==
X-Received: by 2002:a05:6402:2692:b0:615:5229:1d61 with SMTP id 4fb4d7f45d1cf-61797c96ac8mr1865037a12.3.1754476798802;
        Wed, 06 Aug 2025 03:39:58 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm10089403a12.25.2025.08.06.03.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:39:58 -0700 (PDT)
Message-ID: <3134db13-5fd6-4cf9-a8d7-97a5a39971d5@tuxon.dev>
Date: Wed, 6 Aug 2025 13:39:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250806092129.621194-1-claudiu.beznea.uj@bp.renesas.com>
 <20250806092129.621194-4-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXtdgxX3xVALj2t1cOQ7+2rEA3x=J=M4VkenMdqnHhNag@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdXtdgxX3xVALj2t1cOQ7+2rEA3x=J=M4VkenMdqnHhNag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 06.08.2025 12:48, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for the update!
> 
> On Wed, 6 Aug 2025 at 11:21, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add MSTOP configuration for all the module clocks on the RZ/G2UL
>> based SoCs (RZ/G2UL, RZ/V2L, RZ/Five).
> RZ/V2L is handled by r9a07g044-cpg.c, so I will move this comment
> to [PATCH v2 2/4] while applying.

Thank you!


