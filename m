Return-Path: <linux-kernel+bounces-868729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9740AC05FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC9D19A13BB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB9313E2E;
	Fri, 24 Oct 2025 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s6/2aArz"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365BF31076A;
	Fri, 24 Oct 2025 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303967; cv=none; b=CtXhQHEJZSQTtkDQ37hlrxOOdHZXokjQ7tIet0CPeQSevH45gLrsXlQCB4/jAPEjzAihvn4EuAA9E7QlBZslk0cEc6QfhVG61t/fxMgcHbh+gw7uJ/4UmYvvtAbGUACb0H0F4aJHAHzNFOXrdcmM5MD6ZHTmCYoVF6TBiZ4sg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303967; c=relaxed/simple;
	bh=lUtbpOm0HNwvHu4CwXbJ5Zxe40Lsed5WgdfeTdpcNoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lwqd0TalYM7EGCzHlsxGU/dXT2z8YuW7lAek1QO4SlW4Ks7Btdwrt4Ghmcr/JukD00eDvU4XQVZRzKjcBRhwoXQC480p5ByJ+ZIy058Tit4yuee9bJhpSGr3eBF27nVs8pmzQxUZZrhTwa7o/wrrYCVfeHBA0POvsEgv319YoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=s6/2aArz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ctKny0yWwz9tTX;
	Fri, 24 Oct 2025 13:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761303958; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtxpLaIOr4yTBDhQd/HrFTnKf9ZfodYckqNGD8tLD/Y=;
	b=s6/2aArzcq5R0lYNtxdfUkEh7D9GN+NDcC42bF1OY9Rh8t+Ztz+X9YQMVy2ERsqtn/XB3B
	YTkmmgy1UwAVrRPh/E/uIS5JaF8Mmr0BxttGZiKvRnlYi2zfYrK+8+EHj2zsJlHf7Qr5Pk
	Rp0pTXYvwENvleDERrC4gF4VJHuYkkqEl5M75DYopZOE0M3G+CicjCp0WLyFog77FzNDAy
	6T1R2HcFBjol93jtuXg4dejoJqh3qDHW1Lr4HjwBY5R64/U89q6FrFQalKMscvWaM3XhwK
	T11ouw11q2nNiJoHZOwIywbfyFfkiYnY4I+nOs/tgcJ6e1HKsuIWRxVdFW0Zxw==
Message-ID: <e189784c286a2d7f839e973eb88e287c9ea0774d.camel@mailbox.org>
Subject: Re: [PATCH v2] ALSA: maestro3: using vmalloc_array() to handle the
 code
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: tanze <tanze@kylinos.cn>, perex@perex.cz, phasta@kernel.org,
 tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Fri, 24 Oct 2025 13:05:55 +0200
In-Reply-To: <20251024105549.210654-1-tanze@kylinos.cn>
References: <20251024105549.210654-1-tanze@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: c9c6a7fe836045d3a96
X-MBO-RS-META: 35ty37qrsetkaz6zy9m36b3hfj9jntuy

On Fri, 2025-10-24 at 18:55 +0800, tanze wrote:
> Change array_size() to vmalloc_array(), due to vmalloc_array()
> being optimized better, using fewer instructions, and handles
> overflow more concisely.
>=20
> Signed-off-by: tanze <tanze@kylinos.cn>

Reviewed-by: Philipp Stanner <phasta@kernel.org>

> ---
> Hi, Philipp Stanner,
>=20
> Thank you for your suggestions.
> I have made revisions according to your requirements.
>=20
> Regarding the issue of my full name, thank you for your=20
> attention to detail. Since I am in China, I use the name=20
> "tanze" on many occasions, and the code I previously submitted=20
> to the upstream community was also under this name.
> ---
> Changes in v2:
> =C2=A0- Fix some issues in the commit message.
>=20
> v1:
> =C2=A0- patch: https://lore.kernel.org/all/20251022092339.551438-1-tanze@=
kylinos.cn/
>=20
> Best regards,
> Ze Tan=20

Well, if your name is Ze Tan you could use that :)

Don't get me wrong, it's not a huge issue; tanze just might raise an
eyebrow here and there and have people wonder whether that's a
pseudonym or nickname or sth.

What's fine for Takashi is fine for me.

Regards
Philipp

> ---
> =C2=A0sound/pci/maestro3.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
> index bddf47a1f263..3353980d5cd8 100644
> --- a/sound/pci/maestro3.c
> +++ b/sound/pci/maestro3.c
> @@ -2571,9 +2571,9 @@ snd_m3_create(struct snd_card *card, struct pci_dev=
 *pci,
> =C2=A0
> =C2=A0	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
> =C2=A0		chip->suspend_mem =3D
> -			vmalloc(array_size(sizeof(u16),
> -					=C2=A0=C2=A0 REV_B_CODE_MEMORY_LENGTH +
> -					=C2=A0=C2=A0 REV_B_DATA_MEMORY_LENGTH));
> +			vmalloc_array(REV_B_CODE_MEMORY_LENGTH +
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REV_B_DATA_MEMORY_LENGTH,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(u16));
> =C2=A0		if (!chip->suspend_mem)
> =C2=A0			dev_warn(card->dev, "can't allocate apm buffer\n");
> =C2=A0	}


