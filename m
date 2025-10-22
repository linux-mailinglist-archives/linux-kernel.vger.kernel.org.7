Return-Path: <linux-kernel+bounces-864640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B152CBFB3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CB62356946
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB83148BC;
	Wed, 22 Oct 2025 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ECosocxw"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832F1A317D;
	Wed, 22 Oct 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126985; cv=none; b=Z+snmGlnjlCImRAnA5JbaHIqRiGupid/+DN5Qs4M8+ROm8gFOBTSbHPDCOGGJgKk7/usYbSMoBJmdJDWCle9tDIX3KCZ9ZVRUDoh99dUdjsr3mCuE1miwha739nwQH+XgcS7VJ2ogz7nbaJFCOknWbgsIL8tYbgCwVYBGZX02aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126985; c=relaxed/simple;
	bh=kOeDBJUOTsaHtB7cOFBDjPa7bShYDyGvMabMkDa6UBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etCXWM+I9v9RLfLHKrGFS/bE+BvJ1AkLt8E27aY+RFnfsHLMpgIDJsM4wq7dc7VG6zZmjsPGGoFhsEh7oVRTeuvlg3FBFGbiRJEfkuijnfcrAafbJlfeyqd1XsplWwS/e+/Tn7TzPQdHHq9TSfeMivf4aajObKXg2Vg+KtSdzZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ECosocxw; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cs4LN6dKqz9sHh;
	Wed, 22 Oct 2025 11:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761126973; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0B8eIOq0EeIQ2pT2fHfbAXwPvpLXP+wRvaKeMEZJWo=;
	b=ECosocxwby7Uiwcw58J9Q/Y1gYNhwS0jlGY2L67JS3TgpSaWTcUR51JUAnLqLOos02CAt8
	ZFGUd4/pcBnGStsJz+o+VGj4aPCB1TvVTVOy32ssBCJ2bEctleGyFqcH9+SN+w+eQmusPz
	PNkENtOOgs3D7c+9j5Pos8kKSqoG3PkSEtbctCIPiw8liJKKCKluChXHdsFs6GY2TSnnfi
	Gg8fyulZryziT9+FqR7wD/XsEkoU9B7F5fCxR1i+EtBYhcafp+8U9J8NNalL0mCiuVDA/6
	Eev2XpR9WC1bXW1nwYqpubLBZUH1RIFQJYsnPUx0MoFrWrSqUohHEVZ1RyhYrg==
Message-ID: <9034243532d090cd51508375510dc03e90e57981.camel@mailbox.org>
Subject: Re: [PATCH] ALSA: maestro3: using vmalloc_array() to handle the code
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: tanze <tanze@kylinos.cn>, perex@perex.cz, tiwai@suse.com,
 phasta@kernel.org,  linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 11:56:08 +0200
In-Reply-To: <20251022092339.551438-1-tanze@kylinos.cn>
References: <20251022092339.551438-1-tanze@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 83a2916bb52487241f7
X-MBO-RS-META: e6c8uag3xt5r83ztk5gsioyyjsptrjy4

On Wed, 2025-10-22 at 17:23 +0800, tanze wrote:
> Change array_size() to vmalloc_array(), Due to vmalloc_array()

s/Due/due

> is optimized better,uses fewer instructions, and handles

s/is/being
s/,/, /
s/uses/using
s/handles/handling

> overflow more concisely

full stop: '.'

>=20
> Signed-off-by: tanze <tanze@kylinos.cn>

Is that your full name? Signed-off-by is basically a 'legal' statement
declaring that you as the code's author agree with the license and
stuff and declare that you're allowed (by your employer for example) to
upstream this code.


P.

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


