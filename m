Return-Path: <linux-kernel+bounces-881865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17705C2918F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55216188BB3E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343EB2264B1;
	Sun,  2 Nov 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vdwaa.nl header.i=@vdwaa.nl header.b="cZFUtgif";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sni/lJFH"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E91F936;
	Sun,  2 Nov 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099760; cv=none; b=lqxvAaN43bH+yo51fOk7rn9rKgPm8rH0R22M+qtkxN+XwXLRctz14FgqNUcgMvsKSgf9ZAQdj9WhpfPIqe3/dbLiMlKxYlLiZNoFfEvzVJHmGqK42CWL+V1xCYqsU2rWh7ZZC44FGN4nOEAYPsgaRPtKDP8yRHb6jdl4uv8XcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099760; c=relaxed/simple;
	bh=02yOzT/MfAxPwJQ0s1xz9sb6jU8v6aHQX0MTWgfFgAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxW1vKyGd5nFN8JrVN0U4FE0S5Ogw8qhwEIUJbZCr8ncHsqpIx24YDPMOGmnFMcPtx/m966fNXU9CdQ5QfiI47GORCeVckyhRzWj8ptqJAvIQPu55azMH0gUQ/3t6rpCTvHdBzrjlKvA7gySyIe9NonMOlSKJE7cU+s0eZsE9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl; spf=pass smtp.mailfrom=vdwaa.nl; dkim=pass (2048-bit key) header.d=vdwaa.nl header.i=@vdwaa.nl header.b=cZFUtgif; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sni/lJFH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vdwaa.nl
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04E567A009A;
	Sun,  2 Nov 2025 11:09:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 02 Nov 2025 11:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdwaa.nl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1762099755;
	 x=1762186155; bh=G3jMpQpiJmokl/FxS/n12cifMNwDQ5leCuxYy8EpM2Y=; b=
	cZFUtgifno8JlctyiLotQwzVMPtO3N8zJK00I0gyYBRnRHDg9RpukYDJ58aGGaor
	wbOaNH1gUKZOlQtZgVgsmwRUkXX2s7Da3ns4m+mW4ILFGhr3K9tvRdvZ4pRZWQUP
	CdPT/I9uVKcsaRHGTOwt12oEQiCsCm6lzpT+8w+I5hGurSKp8BTQulXs49OT8hyi
	ghKVD8AfKouVBx4JCSr3J+IkCBAbBeO8hgmqexerOT2xThdgWIhU8s2m97oybNRh
	2L2B/MSYV5zfzcdUWWlIG4NFwYhLEiUgxxOsJkL+9Fupg4VbfaAuSiG1Jz66IUW7
	L5IssFwOtMZDh+cTuBKxkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762099755; x=
	1762186155; bh=G3jMpQpiJmokl/FxS/n12cifMNwDQ5leCuxYy8EpM2Y=; b=S
	ni/lJFHPdnEfQvbuc9eDYf3nd1pCydw1sUF6+wZYTCx5TVl1obEG98VfXuylqlbO
	L9i844jsqIHNEJGV03UDoFnyxyDguuOvEvcgCC4KhQxixkeDBon2B38oyRb4aulJ
	BP/SUK5N5R7r8Om2em9OUKHeT2cKuRsJTJjv3sBfK8s7MUg2tCmiT6ggQagBeVb0
	ZRsG/ChSQFszm7QQPfM4+svGpLb/Aaj4OEbyFlRzyc3k0/F3Jvf3RI9BO7h5EHcL
	G1viVNiyI1ff4dQ+iuRR9HICw+N+WjlYAYIAJS2gnm4g8I59PLFdXDx7armfQtLO
	PpXcqYBYRb5jBjC/L/wqQ==
X-ME-Sender: <xms:KoIHabpYRLT7xNIV_keKtzggbxbcLDFsLINescwLlvCOECAF4TwFfw>
    <xme:KoIHaRrhACFCbY8qnnygOFvzTzRnX-PksKgPm0-oDbs8vU57ombpMvV8Bh0ticFRC
    RENXRHMsxYqyOre5BQniKD2nfkL4FVQf_B5ASrHnGwbENJILtjaZHk>
X-ME-Received: <xmr:KoIHaaaEWGpoGkPzYc6Ls9NsJnGv0EXUcnIkVuSbFk4_K9A-Zcdz3LNhc38MlEe9ppB_x-CoU3RN4s-LV9rpc43hapw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehieelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:KoIHaf9-mT4QmKF9GMGYICk50t5rdWvlno8BLetU2DOud9mTl2BT1Q>
    <xmx:KoIHaYkBpkuVHhm0ybW0XOLxBTxwqIUuWVEPZ-mitS8fo-RaudCCnA>
    <xmx:KoIHacxy6KCk45nDm03aWKcfbAUVOAbRnW7o0q0AHg7Y3Z3odDaZPg>
    <xmx:KoIHaa5YrJcDe5pmA12LzdBpInlH-pD0_1o4M4fnjZIdTeg92VDp_w>
    <xmx:K4IHaVQxfrTubUoAUcubqNhrkdR6XYd9KhO1JZd4Zkw6KQ9r2F2j1tcZ>
Feedback-ID: i2d0446dd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 11:09:13 -0500 (EST)
Message-ID: <dfa70284-04ce-482d-8d79-cc0ee8b4bf6d@vdwaa.nl>
Date: Sun, 2 Nov 2025 17:09:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: ideapad-laptop: Add charge_types:Fast
 (Rapid Charge)
To: Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251020192443.33088-1-i@rong.moe>
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
In-Reply-To: <20251020192443.33088-1-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 21:24, Rong Zhang wrote:
> The GBMD/SBMC interface on IdeaPad/ThinkBook supports Rapid Charge mode
> (charge_types: Fast) in addition to Conservation Mode (charge_types:
> Long_Life).
> 
> This patchset exposes these two modes while carefully maintaining their
> mutually exclusive state, which aligns with the behavior of manufacturer
> utilities on Windows.
> 
> Tested on ThinkBook 14 G7+ ASP.

Tested this patch on my Lenovo Ideapad U330p, it now advertises that 
`Fast` is a supported charge_type although my laptop does not seem to 
support it:

[root@archlinux jelle]# cat /sys/class/power_supply/BAT1/charge_types
Fast [Standard] Long_Life
[root@archlinux jelle]# echo 'Fast' > 
/sys/class/power_supply/BAT1/charge_types
[root@archlinux jelle]# cat /sys/class/power_supply/BAT1/charge_types
Fast [Standard] Long_Life

I'm wondering if the battery extension API allows to not advertise a 
property if it isn't supported or if it should at least return -EINVAL.

Greetings,

Jelle van der Waa

