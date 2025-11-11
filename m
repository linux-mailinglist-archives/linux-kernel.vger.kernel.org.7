Return-Path: <linux-kernel+bounces-894903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA696C4C6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF413A4F28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABEA31BCAE;
	Tue, 11 Nov 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPgpBBMW"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CC31BC85
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849753; cv=none; b=H3/D0YZfOAL+VAfrolzKW3GyJ+TjzzpTBjbkL2Yogj0h7x8gTllc+Gq38mtq5IFmm2gS81ULWH4L+Ab6i8wmejDAgcLxjUENpCNkd3X6BBZcGW4XhQldra0LAVzhorhNweEiK0IpAp+xgPY5n7AUYtfUCH+Jo9dPYJSPWKB1F20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849753; c=relaxed/simple;
	bh=10TSvv6HjQ0PvGW3eNRhtcZMYyBdUfrKwKuyrp7+khI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boxJXtwHddfH/gpibZadfRCQ2WH09RvqjNty630Z13nBufCBZvVUfosHk2ebX+QtKgMX/7XDFuIUO6ysRCybcb5fxuaNXcIVNVmglR/wd2bOXwrDBESfh8Zbff6CjiUGd74MCXYr1ux4QSE5zCiRIq2nv61+ReOL+cgCIoAUiv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPgpBBMW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710022571cso37397675e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762849750; x=1763454550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VN4ssHT4SWqYZ2DLb2tv38+O6ZY23WjOxSeg+Op1aEM=;
        b=mPgpBBMW/Swsmds5wM9geAZlFrw+qBC/jwDggk4iwH18O4lT8JHvkp7CjmhqxHHHno
         Av6Zri7LVhM5xMbcUobWq+o5CQub/cVtBUPWyt5VrcMwGyKUTi+7KT3RF6Pl16QrZJnA
         xdx5urURTaFRfBwdl2Eq9NN7drZrifMDZyc6Ujm2SC3DEOwfsOMRrOWvlXj1MgRXw19v
         7kaHuWT3VIx+2Z0llbNlLskJ0YgdeWP9dSn6v+m7xeMIkXD3eXE3Na5I09JdGyxVg2Vb
         ciXOmaTVWgmgcbYpUZoNFqCL+BCVNrGUdGv0lmj0sjJyU6NvHtER0rtxvTNvlMixmFr7
         QIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762849750; x=1763454550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VN4ssHT4SWqYZ2DLb2tv38+O6ZY23WjOxSeg+Op1aEM=;
        b=w8M387Hl/4keYXZBYWrjX83Dp3UKYPpDQqhDCJzK2fCk1EqPa7DbfmadNCAXZg72sK
         AXscRodsFCqVB82xu0Wt91CLi5lmW51YbDukgdhU5GzH5d/t2YOixwfxYyefAq58IjYC
         v3hTqMnYFstF7n401leL4Rw2MVBtWGFFm1Z04atyJQEnYYxKUZsLfRj1wB4zbbL3nsnn
         JvluRaxJ0aWn5qkevg89wAF0A2uekfVmuTpNsY62bJr4bhhixyAGUAO+kLVwNBYSfO9h
         VA56a6hYzNAUDb4F4XRpHOU1Paf3B3L1VUh5DRC37XsJrn+cuD/EUQMjviw5ggJ5EutE
         Grcg==
X-Forwarded-Encrypted: i=1; AJvYcCXFF8d+/sttEx/dLSLWblKzWE5/VRSLgHqJqMNOVq/Gn/g99NHZ9+EFfdxHRzueh5AHlZ6fXPU2FeecLp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91Eryl/yp2zFPnwzxB5xxsQGh+uKBChe67lnq/fXblcMqo1XV
	NqmxjdqpYIOq1IbXBqNZSbxk08cqMr1aYdXQa2K2ZxZWy9k+AsyZEoHxdcHfJAnAJas=
X-Gm-Gg: ASbGncv/27LAj1Sb8xWiCMWMr59xlURhvy/N2syl4WHLUbvO/orTto/mmk6WciVdCbC
	DOj5QknpzWOT3JegvwqEKrEudHE7Xncjm9TDhLUMZd+enY840Nej7/Yjw9pES1QbPxMOfmLZTQK
	LDrZYPnLwcb1CzX/+ppcy79K0YqyfRSjA/ea97hjZXRyFmxy8U/DZ+Mvfm0q4p6Mxq48qkH61lt
	Y8tBcpIqAjn9OccMGKJGioYZVSHo24Q6V9kbNkAFpEdbyXLnLGLKR7M5Tg5aZ0JyO5L5miqZ1Gp
	qMiNVk/1troHwvT86EUQPqhx8GFCgCdYF6ImyCBcE0onkrOTPjE2W11mf1ax10H3xwlfUqoeEJ/
	Dkb3Ind5E3jPbyl5JOqzTaKoPEWDppQgVz8mKtNQ6p73zZw3oLFLy5JpE/ByAkGMWVEQ3ZjQxLS
	nwMxBBtEZ+1XpfP8+p
X-Google-Smtp-Source: AGHT+IEjfzQTdf31JT46i170Kox8+e9rzC9EAL1JgWdVxYnSZfKWgA72lGNi/67uAlpLK3cpt/PArA==
X-Received: by 2002:a05:600c:4f0b:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4778049cfe2mr34227345e9.2.1762849750375;
        Tue, 11 Nov 2025 00:29:10 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2f7a0512sm19591853f8f.18.2025.11.11.00.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 00:29:09 -0800 (PST)
Message-ID: <8263aa0b-f223-4e67-9923-9f7882b90646@linaro.org>
Date: Tue, 11 Nov 2025 10:29:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: spi-nor: micron-st: enable 8D-8D-8D mode and die
 erase for mt35xu02gcba
To: Bough Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-4-cde50c81db05@nxp.com>
 <7d8b0062-a6ec-43a9-ab00-3e11f0e2fb26@linaro.org>
 <DU0PR04MB9496D24A8424C578C942CDE590CFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DU0PR04MB9496D24A8424C578C942CDE590CFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/25 10:00 AM, Bough Chen wrote:
>> please dump the SFDP data for every flash that you touch, it helps us with the
>> sfdp database
> Hi Tudor,
> 
> I do not have this mt35xu02gcba on hand, I only has mt35xu512aba and mt35xu01gbba.
> I touch this chip because I notice these three chips share one datasheet, and seems only
> has different number of dies.
> 
> So should I drop this patch?

Ideally we don't change functionality for flashes if we can't test them.
If you feel this flash entry does not work okay, which seems it's the
case based on your previous patches, then just add a comment above this
flash entry and tell what should be changed. Then if someone cares and
have the flash, can do the changes and fix it as you suggest. Does this
sound like a reasonable compromise?

Cheers,
ta

