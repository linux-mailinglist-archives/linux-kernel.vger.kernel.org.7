Return-Path: <linux-kernel+bounces-888548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D3C3B1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACF7B4FF101
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EB9330B21;
	Thu,  6 Nov 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vdwaa.nl header.i=@vdwaa.nl header.b="Mp3r7C+x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipUJmA3m"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AFF32AAA4;
	Thu,  6 Nov 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433973; cv=none; b=chaNHrpukRbSnxYwEjkMWrHpGHWag2lr090xbQrYfirD7m2LhzEAxlkaazAYI05iDKMSE51ue9KW/WFbCQu2eEl57b2Nq6GvCSy4yWCgiUZggQL68IgHExvF1A36sG7tKF8kyWKdPxhEhtPlAkt+DvRbBscfxaIZoM81CaUFF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433973; c=relaxed/simple;
	bh=JNRNJfZk/M2DMebQMpJh5c9oaTtadwPDLyrm08DR/ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5jIoHA4ibnta4m3DicY25fOqlCA1TG5K9e7//YwTVyN/YgSR3mRNI8BSSy/9ykV9jkLYS2BTEeNsK7K8Dqq0on5rw3NCns2uJsS3jTopIhW8Ww6RXvs5kKS4WGKd89If1zjCZis0sIQHGBo2/xUlKCwDaxhsfJaUP9fNFUg43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl; spf=pass smtp.mailfrom=vdwaa.nl; dkim=pass (2048-bit key) header.d=vdwaa.nl header.i=@vdwaa.nl header.b=Mp3r7C+x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipUJmA3m; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vdwaa.nl
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 859001D00141;
	Thu,  6 Nov 2025 07:59:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 06 Nov 2025 07:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdwaa.nl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1762433968;
	 x=1762520368; bh=Ox9ObyoIxaRhE3WEIQoEfOWN6rhA66eyylIhLTSftn0=; b=
	Mp3r7C+xFC+i2RtPFW3WkmvnqnI+augraGS3iLLzLlcvEO2lXxpDAvMObSkLMnZi
	1anK0bkWArQqtDdOjhW1FRKuCNidwsVSG2m+LeeapcNBjnP8X8fH48axQfYYtxa+
	2ZVZLq85q4KVjqDxr44iMQ+VvyE/5yJkxF3CC/YWDR1u4LtuMTvkTQ79DTZVorL3
	6UJXy9jwzpvNyQ4WH53rTWVB6ZpKxW1wxn1uZnsKR/jLaZiXeERZUf2+1p5RNptj
	vA4+s1zAU2nbmLPXMHnofhQ5wM7I+JVmANoai2bfsLaC+oP423jg746kFQPoEoxO
	q5V14f/g/sztxT88ITLmnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762433968; x=
	1762520368; bh=Ox9ObyoIxaRhE3WEIQoEfOWN6rhA66eyylIhLTSftn0=; b=i
	pUJmA3mHQSMD1eMhY1C8K04jEVnfUP3o639H0AeoENK1eWE4YIud/S4PC1pYGHK4
	juUdWQB5gWPM8+qPH9wNnufRNVyPQkkecuiVZEVfOmfoaoWj5zEPbabzcq/Bwgf7
	GXRZKbQygUgnCB73o6hmvdEPnkEmoZpQn5R72vhObf5bvpQT5azJore2K5cj/l99
	PcYdR0oeeCmC+aIA25OV0DU5LcxA96//wEhNOLvDEo+sV6qhi2e/0xcfSakALg8t
	taAqfgoEykt+ltCEKbrdgwxOe9V/v0fgW/vMnRkPwiIgEDFViBav/861X5uXhG/y
	CMGMrkVKQTwhKOxuQolZw==
X-ME-Sender: <xms:r5sMaYBEiDbcykKk20xjlg8Q9-LSISzazqnC5IZZg9tXmQ5PYj5SeA>
    <xme:r5sMaWgoSKxqe9d3VOidSgYJOO6X842-1I_wWR0MZ59o-dYbzv4Au1fGaA-d57cy8
    S1hDDTE3mYSXKH0infkgPteZ6ecSXKPRatBnPmODIO8lPiIHQMzZdc>
X-ME-Received: <xmr:r5sMadz0qSH2rDa_gCJ454_g0wlIHpLrYeSnnfgKL3TP9H-TnMA6BT15UzwVnCJ8dZcUujIBqZA7deJfxsmNINMGHrXLpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeikeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflvghllhgv
    uchvrghnucguvghrucghrggruceojhgvlhhlvgesvhgufigrrgdrnhhlqeenucggtffrrg
    htthgvrhhnpeeugedtgfevleefvddvkedtfffghfejjedttdffvddvudfhheetueefgfdv
    teejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjvghllhgvsehvugifrggrrdhnlhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepihesrhhonhhgrdhmohgvpdhrtghpthhtohepihhkvghprg
    hnhhgtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhkse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomh
    dprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:r5sMaf3J3rzfVKDXSW6zTd3x8AbjzYYCeWXQG08O12HKT9admgdG6g>
    <xmx:r5sMaa8jr7ZUrsZ56ZZUviEzyfA2TifMmMDaV5fM1GzFk8zQmrP0-g>
    <xmx:r5sMafoggtdQoz4XC9_tdTLC4FVHMi_qBjGEJf42M-FBXGOCL5xEpQ>
    <xmx:r5sMaUTWAGAlRcFmvyt0r5JHWuIaTV7Z4mR0vBnBWWEeo1RUtLWXYg>
    <xmx:sJsMaRqJOKes6kDPBe4COSj65xSrGPBV7S9H8iBmyMnt84JGKIg8Ht9h>
Feedback-ID: i2d0446dd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 07:59:26 -0500 (EST)
Message-ID: <489d1b5f-4177-4a8a-855c-adc65f794177@vdwaa.nl>
Date: Thu, 6 Nov 2025 13:59:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] platform/x86: ideapad-laptop: Add
 charge_types:Fast (Rapid Charge)
To: Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251105182832.104946-1-i@rong.moe>
 <20251105182832.104946-5-i@rong.moe>
Content-Language: en-US
From: Jelle van der Waa <jelle@vdwaa.nl>
Autocrypt: addr=jelle@vdwaa.nl;
 keydata= xsBNBE6QLAIBCAC3O6LmF+GKvOh7IV00TG+EKAQHAwjESnHGJOW58lKK7eAYn62ZM1uy0+6h
 yCMu5PD7+ND6U1gcgTTHYwNK8AaJt7yY4FRssgdcJk59uJBwROZtllotClJ893CuB6Wgr68b
 07gIRbENYrB8rEoGfpUG//8/ep7sY8PS03jnFb4ll6mPlUE2oQVdYOlXgF4f9qkkIi4SQeE2
 MTuERaOrDuUNDlroJ7Yfx3J/rL5Qjn578/TKCAxg0pns6VIA/P9spRGmLhT4zP+OxZXeSZme
 IxcwFdJJXHr4oGaZvqe1yHlMmKR98rrIfPWhkw2Ls/XIZIxf6prT0XyczbzBnC2y1JyNABEB
 AAHNIkplbGxlIHZhbiBkZXIgV2FhIDxqZWxsZUB2ZHdhYS5ubD7CwHsEEwECACUCGwMGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJUX8WhAhkBAAoJEMBghjN8UHc+mFwH/jjN+Qob4O36
 YiieajRwVLGuYdUDt9Z655oQYU8V4qbWf2tjUtqTYXrxLnaY6xQoYouRz9yFbh9dIKZb67ir
 7AeVgCOtWVesGxAlGH6EY5JBZcsN0v0ScsivqQAv/Mv+4HK+XM57YlyRagD8tkprYskioWHg
 OwQfXAO6nlm4BJHWO9bHJUMgiGs7I190IKQG7iLBnJuGjsOFuy5KTLpnv+w7twmz0H+pkUPe
 jVHfJlJWdN4v1PigpgpjOR6ZepSIggMk7dHsa6GNLUOzi61yYVFe60+EGXhwyJIqSt56a4oR
 jMUcXaOugGr+JwC8Eq7Pg2+aFk+8fbe0oUzZJucHGnDOwE0ETpAsAgEIAK4Usb7B00WRxCZG
 HtM973F7V4OhOKv4kZKduxtu71bVUZsTuzn4h+m8guJ51uY/I2icUrN9gJG5aEzRqPuQi2L7
 KmZUjs3pscZWgUgiT8UZFDR6RuQ4k3CcWobsRCjYZdSblSZ8ccrLJE7xSbwKMXjAh2PEiaQT
 lS6wQbn6mHv4y3H9QVHs7+jXbmfHCxnVcwLqRmpuegSmezDaL5TlSc102voiXinhrWEZUvAB
 KDh6VuJ/60Y6zelCXVsEjRaApz90iXY1nifLhkHM8B2wG7Pum3V3X0Y0QTVD+z3EL1iq5mFu
 epKp//IOeeJN5iwHcRSJGy2s1oOzjRDyPv6v1AUAEQEAAcLAXwQYAQIACQUCTpAsAgIbDAAK
 CRDAYIYzfFB3PvDuB/0dI13hSYHW27c2Rq8BaGbIhXYYETtPD5B25/P1JJ5OQZkPmVq+vSHw
 uzUaDZHy3ZcwE+xFXzlkwXGdWos07JUGo74zV3HfeZxVEPv0HB9ACqQVU/JKjLZNj2SfhgzL
 4F+O4Zgdsf0YaZG09F5PbMvbhoCZLfAaKWz/4fLEfhrDJLhrphUyPDXosn0UxPkDv0iiixn4
 V+bEZ5/wd8dRWi58R/iND+gRGsBREm5SpzdhnsarwoX6YdsQ449379enDNUN7jV4C3Gkon2s
 VwI2ZZbS10cY8rFSAV/CJA2E9daRoz40DI0tgXgLBAVhy7y5HWZJsDZexU0HFKJfkDi7RUPj
In-Reply-To: <20251105182832.104946-5-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2025 19:28, Rong Zhang wrote:
> The GBMD/SBMC interface on recent devices supports Rapid Charge mode
> (charge_types: Fast) in addition to Conservation Mode (charge_types:
> Long_Life).
> 
> Query the GBMD interface on probe to determine if a device supports
> Rapid Charge. If so, expose these two modes while carefully maintaining
> their mutually exclusive state, which aligns with the behavior of
> manufacturer utilities on Windows.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> Acked-by: Ike Panhc <ikepanhc@gmail.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2:
> - Only expose Rapid Charge on devices that support it (thanks Jelle van
>    der Waa)
> - Reword commit message
> ---
<snip>

Tested on my U330p and it doesn't expose the "Fast" charge type as expected.

You can add Tested-By: Jelle van der Waa <jelle@vdwaa.nl>

Thanks,

Jelle van der Waa

