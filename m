Return-Path: <linux-kernel+bounces-886945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1973DC36C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3374189DDCA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CF318146;
	Wed,  5 Nov 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntf9p198"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132432549C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360868; cv=none; b=LOFJ9/u4acv+ErqVDN82oSDjI9E2/AEfKnjqe1vzXPsCHCktFV7Mtvgc6yPLzn+zUkmJRpJs7aOFnwCHnPfx3ftPSEUCtf9smEvfzThUi3Zqg8RwoWiM89DkuudE097FHSGnFeTomYLOX2wEjSx2cFX8a2qqGbneIiDY38bWKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360868; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7/+O/cRIVovmKeykwjxmmB36dhZDzqsxESon1xrRWsFq0DxqUP2TH/falV4opLHBciaVjKkkGJZ4UmMhw2gsR/i6mnEfPx6ZUf4MQLNpxcWzVkajrofzxqbF8gyXaBZcw6m+Y+Fez78JfC/5Z1O3e+mOprbzqs/I/Y1p/6GiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ntf9p198; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b727f452fffso87496266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360865; x=1762965665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=ntf9p198LYgZDq7A6ZULqGUHxD5XmHeoF/F/1SNSpmF4+D/6ccfaT3aQCwGbmxk9Kz
         Gu+Nm1rUITC9Ge/6AEG/FWyFZMmkvWiYP4luc4ZOTbYjj0ALJW97ErHSCPHzFmFI055/
         M2usHoX1dHf4afwaE7ZKew2GOG0znqNs1diyB1OE8rvtGNJK5BfrNrsbJbHLj8Un7za/
         etVmowtl4POZqM6Nx+bSiauESMlyODMfWm0n/JG5QDQjqu2X+Qx5AYLpzgs5bbsPOjFX
         7tQ9Ymadlj6nv3igy5gS0BrvSqFyTVVADPkNGBy67jOqUYFZ1PV0n0DoE1VClk0+S689
         wK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360865; x=1762965665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=dqIcZpq5im4jEwUErnNESPcjU486dsLEQASoFShyZyKQE0jrqKaz7EDtOZ0Mok1yDJ
         7umsdZzI6TCuL6ifrrgZoz8Te5vjOiE/GlzAAM3srR/yU4gfotK6zwhMDsv3o9yhJIA/
         UI9QIctXrO64qNgcs/w5tB1QvinQe8p3WXOUQQC5TfH+6Bv62NhmQ1sHTz3l8v9yj2W7
         dTSBHzOwlJq2k0t1XSdhnwwpAGKdjcFn84gAdnbpb6GlxQzjFsmBZzLepDvB4RXmxKUn
         QKzc9JCXmzRE2ydVZGeXivwglHJjLrod8PaJ1oCvy/ejmyboaZioM9TwD17KP5AdU7B/
         Hszw==
X-Forwarded-Encrypted: i=1; AJvYcCU8FA0GQgaXvHGLOT7BJ59TlZ8i9IQGNW87XVK332NCdHnWD/6Fv/mgJQfJMh0Wfq8JCdPHSZBKPDinaCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBlH73svdkAjuNS1UKDc97RgXSBwJanpI1PiT8uTifbG6LdJ5
	O+suYz4JwSdeeetN2NZaZnFWYVNDm+fEAqmSNcwjsy7I87r0VG363RJN2vc0YFXQp4Q=
X-Gm-Gg: ASbGncsCgjvjFn8kOmuQ5vfjr5VmdMGVKLwFBbQciwfgGojzvdI2Qf+mP68oQpTd1De
	OQjIbwZS4Sm77C82L8jGpq+TVgT3SwYORsm83Q489FD/TpKBC/E6db3Z39A6r2vvnM+gDXl8m7Q
	BkEqUav9YgTGxUD3xZ7dd2mK0e2MdVGC+rRKnhrAwewJvhyv0lhcXMbBxlI2s7DptLJ5wh2ljFW
	uWH2m2dVzAnQibBPk6LUHB/Ta46xDxQO9xjVnzvqfn/wb0p+A8BsgeTvCDMpECnX1ag2S0kl4yx
	MDklnv4fTBdWPFs+E7lm+XC+pf+OwWUbARSCKY+vvmIEODON1Lm55huXaX1qGh7Q2S3PWfEYGfG
	dFQHohek8dg1G8t2YzPOYTZObMxR7bepHEbgo8RrcBUoYB3xiyKlgV/+pcpLJR0Hy69X43/TUjL
	fuS3FET+soSBlOWkNFm/3tHJ0=
X-Google-Smtp-Source: AGHT+IH2mUi79RN7exis38BOklTZsMNZ/FgOLFTlEt+kXnDPqwAEesKS5Bf1yq+oownV33g2WMoY3Q==
X-Received: by 2002:a17:907:9614:b0:b6d:6650:c3cd with SMTP id a640c23a62f3a-b72895a01bfmr1936866b.21.1762360864962;
        Wed, 05 Nov 2025 08:41:04 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937d88csm1932166b.25.2025.11.05.08.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:41:04 -0800 (PST)
Message-ID: <b081a4bb-66bb-4825-b33b-52b55649cd36@linaro.org>
Date: Wed, 5 Nov 2025 17:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/28] mtd: spinand: winbond: Convert W35N specific
 operation to SPINAND_OP()
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-14-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-14-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

