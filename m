Return-Path: <linux-kernel+bounces-884700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 063BEC30D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEE684E5267
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E43E2EBB83;
	Tue,  4 Nov 2025 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MlmPrg96"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759F2DEA71
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257231; cv=none; b=O860BdFWsmRrVqGNDmvamKA3VSvaLwMp5iYvmGTqzDRviLfsK6y728gzI2kt9Pj2Nqf4xDIhBtWTxxr2u35f/I3wxI4eokUIDeJRyz2f2dj05px/eSRXNg37KuRkDjn4Y2RhOzLWaE+iHGUThSg3K+bcnzaWS49joTuuaNjbD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257231; c=relaxed/simple;
	bh=I36LzGSl9wytAsBf1yTXZ1w2SrwG6l/dCnsmOh1gGrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxOynPda3njFI/suucUP6i7saK7hxB/cB9aqnhoc6AYgunljtvQi8SHN+ty0jf/SWKIl3zsvaNiuKrqwzcArurOYoKp36WbYI2BOo7qgGjs60dZLOq5CYCCKaMMVVqMRKZuxsWI87sGyMcLsIvyxRxU1Bvhv97TVnm3SzcSUC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MlmPrg96; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dae5d473so4671575e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762257228; x=1762862028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I36LzGSl9wytAsBf1yTXZ1w2SrwG6l/dCnsmOh1gGrc=;
        b=MlmPrg96LFRqxvhrbK0I99Y3mY8Rrq0VCaGf5E8xXGxVFFGMtvcCyrKanpVtWafb+f
         qFl6CvABdtYGYlYZZ0sE+g7Kh28FAW7IP/WCDWSKiHPRc2UCzKFftKPBVoH3/pMw/YIR
         Eo+9/OWQXIQMIagvNfsUlSWwz+PjtK8pjQbAMy0glqhcb6vPexE1S1Al2tZxWInnrvDp
         gluSziYScLerys1iQW6Ya0fxIaPwDLIb92G0hdur+SEirXERwgAA06yRJIAYhFUQZsof
         2pPMHD8UJ65YmgCbL6+Z+HofKBx4J2iuI/VCRYKxPhEMUw17bGHN6IGGraOd9upsvab9
         xLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257228; x=1762862028;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I36LzGSl9wytAsBf1yTXZ1w2SrwG6l/dCnsmOh1gGrc=;
        b=mFGif2/gjI7a6ch3zipdjT9HTkCxBnm6hev59cUOrr2yJedc7dX1cg27fHmQisVux3
         gglBazWhCNgOFMii9RovorZ3Zs1MZIg6ror6oQxg4BhWbe/BtKSlsUcLN+hk0bEzd2WQ
         gNGTxKYc9eKssjI9yG7psKh9ahufUbKVC/WHletZ3b2GCY8AbdRl8NN+0VwLkmxDUS+U
         J9/kTAdiwra8iyErdWX9j4QAWIry4xvWrr6fWKxMey4UN5MHr8qXL9EI6effJH0VYGm/
         /bU6a9E9xQq/vJm0whthf1T4wceGmi/3OvpLbNcp5L6VG/eXtEDmEKU0N7/bDZm7DbLF
         Yfbg==
X-Forwarded-Encrypted: i=1; AJvYcCUC9CnHDdPrj/KI5DRv5JhzpaEfigsDYrzLyIh3Dv//jGJQQXPXXmQ/cGA+Tez91Z1vmhFBkQE9BWm1DpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsxecSRub/OvfoVoYtYLFPSslfI/dswacddEX/gNrO3WutH7K
	BaFt98iu7t6RwNL2vYxEqnZDSjJbxac8PwkV81x9z8TEDB3nJZD+UNAVR5vGsrlGxCM=
X-Gm-Gg: ASbGncvvejXTUjBgUfSY3+5FMpaxn2sNUmDYhIqVFn6iXF7FhTIsHznD9gw5VjmoopI
	k/3gvgnxn0958YFm6zAjXaOKY+mB3OuvXRb4jXjUyvjKbNrYJWEcw5oKULuWUsMt/XeG3aCT3Kl
	7oHJA7Jev/oTwevWToL3YDrtQG0yMsiOOEANEfM/b253pehMPNyxclTN+qmIKXghUbNTv9utd/g
	18oisdEt9Ll8pl8+smaC4sh6xn35OFI8x8RkuOTWGM0GK2RZTTuw7RFCnADn8fa3gKv7RVSu7le
	+tG3v1/3+6AV3CFz6uU94biunsfNBPfVPuk6XquEoToIKjFD2oCSoRbXFqPO2EOFxERTCiiFRdC
	Ma4fp73YrGqIt1Ccydxt/IdcVlvSKC+rFJomxYRCTHsW8J7jJr7JWT9BqqnbtGEeTfLxVYOz1kN
	JLKfrQ0JLq
X-Google-Smtp-Source: AGHT+IEvDHwONng4aJ6PO9esJ0vd+TzU9M+bzqzfCyIK9M1CiPuaL9xKsM8JexApKzS2Btn21bVVEQ==
X-Received: by 2002:a05:600c:1553:b0:46e:436c:2191 with SMTP id 5b1f17b1804b1-4773089c34dmr151966595e9.25.1762257227721;
        Tue, 04 Nov 2025 03:53:47 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755938f45sm16302215e9.4.2025.11.04.03.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:53:47 -0800 (PST)
Message-ID: <6296a8fd-bc2b-470a-a367-61c2d80fe8e1@tuxon.dev>
Date: Tue, 4 Nov 2025 13:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: codecs: Use component driver suspend/resume
To: Mark Brown <broonie@kernel.org>
Cc: support.opensource@diasemi.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20251029141134.2556926-1-claudiu.beznea.uj@bp.renesas.com>
 <20251029141134.2556926-2-claudiu.beznea.uj@bp.renesas.com>
 <bdb14543-e611-42d0-a603-300c0ea17335@sirena.org.uk>
 <70362ac1-244b-43c5-97cb-ebe8f5b90c3f@tuxon.dev>
 <56911e0e-0f25-4134-92fd-f89cb47fd9b6@sirena.org.uk>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <56911e0e-0f25-4134-92fd-f89cb47fd9b6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mark,

On 10/29/25 18:14, Mark Brown wrote:
>> Would keeping the regcache_cache_only() + regcache_sync() here along with
>> populating the struct snd_soc_component_driver::{suspend, resume} be an
>> acceptable solution for you? I think that will work as well.
> I'm not sure what you're intending to populate the component with there.

Sorry for the late reply, I took the chance and prepared a new version
showing what I intended to say here. v2 posted here:

https://lore.kernel.org/all/20251104114914.2060603-1-claudiu.beznea.uj@bp.renesas.com/

Thank you,
Claudiu

