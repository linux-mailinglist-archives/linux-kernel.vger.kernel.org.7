Return-Path: <linux-kernel+bounces-869871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EF4C08E65
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E53D04E33C4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573F2DCC1A;
	Sat, 25 Oct 2025 09:20:41 +0000 (UTC)
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13A2571C7;
	Sat, 25 Oct 2025 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761384041; cv=none; b=s/Mr7i0gSK+g4UpPehkzkw85dtpJsLnpGstRdWLfrcvnfHFsRuQR9+Uyx5sV3X9mU2YxJoxK0kK/9NeQrWsfB4vlOFsn4fzcu8KmH33jgLjBIR6QmTg75oxtMx8RM/r+kgUZN3ItChX71kPovpG8oITfWEa5/zG3+hpdDJlcqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761384041; c=relaxed/simple;
	bh=a/7w0cv9SePtN+yT6WvEUld+KZUwIPYLnxRDREiCCIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XX75M9cn4y5b/GDwLqmBPtijAG8xl0Kx/cU0T+Z91izn+Qs2NamRbKWZkxzWjt3mTTCS2ilK1jYmlc6+nL+qiibTrReLd9zIx+7jhVm9pRe70AKiT7oZ4u5TB0gU2FllHq69lZZS1zmyG0q5IAAzfGIyJNWiwEV9mekb3HlBe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 1E8C44CE13;
	Sat, 25 Oct 2025 11:13:54 +0200 (CEST)
Received: from belgarion.local (unknown [IPv6:2a01:e0a:a6a:5f90:41bc:b925:1818:463c])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 50F58780505;
	Sat, 25 Oct 2025 11:13:36 +0200 (CEST)
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Peng Fan" <peng.fan@nxp.com>,  "Daniel Mack" <daniel@zonque.org>,
  "Haojian Zhuang" <haojian.zhuang@gmail.com>,  "Jaroslav Kysela"
 <perex@perex.cz>,  "Takashi Iwai" <tiwai@suse.com>,  "Mark Brown"
 <broonie@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: codec: Remove pxa2xx-ac97.c
In-Reply-To: <fd5451a1-9720-417a-915c-1ee3149426f2@app.fastmail.com> (Arnd
	Bergmann's message of "Thu, 18 Sep 2025 09:15:23 +0200")
References: <20250918-audio-v1-0-e9d0df5c60d2@nxp.com>
	<20250918-audio-v1-1-e9d0df5c60d2@nxp.com>
	<fd5451a1-9720-417a-915c-1ee3149426f2@app.fastmail.com>
User-Agent: mu4e 1.12.13; emacs 29.4
Date: Sat, 25 Oct 2025 11:13:05 +0200
Message-ID: <m2jz0j4a5a.fsf@free.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Thu, Sep 18, 2025, at 07:44, Peng Fan wrote:
>> With commit ce79f3a1ad5f ("ARM: pxa: prune unused device support") and
>> commit 2548e6c76ebf ("ARM: pxa: pxa2xx-ac97-lib: use IRQ resource"), there
>> is no 'pxa2xx-ac97' platform device created by machine level code, so this
>> driver could be removed.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  sound/arm/Kconfig       |  10 --
>>  sound/arm/Makefile      |   3 -
>>  sound/arm/pxa2xx-ac97.c | 286 ------------------------------------------------
>>  3 files changed, 299 deletions(-)
>
> I think you are right, I was sure there was still a way to use this
> driver either as part of sound/soc/pxa/*, or as an alternative,
> but now I don't see how.
>
> If we do this, I think we should just merge pxa2xx-pcm-lib.c and
> snd-pxa2xx-lib.c into the respective callers in the sound/soc/pxa/
> driver.
>
> Robert, can you confirm?
Hi Arnd,

That'a a way of doing it, yet I would have chosen another path.
I would have taken all the code out of sound/arm/pxa2xx-pcm-lib.c, and
injected it into sound/soc/pxa2xx-pcm.c The reason is that the PCM code
is used across AC97, I2S and SSP. You would have to duplicate that if
you were to inject it to its callers.

I would also see with a keen eye the removal of sound/arm/*. Unless I'm
mistaken, this code only works in platform_data environments. And if you
want to leave only DT code, well ... the long term should be to remove
this part.

The code in sound/soc/pxa provides another access to the same
functionality (ie. sound on pxa platforms), and is DT compliant.

On a personal note, I only ever used sound/soc/pxa/* in all my boards,
and never arm/pxa/*. I'm not aware of any remaining users of sound/arm/*. 

Cheers.

--
Robert

