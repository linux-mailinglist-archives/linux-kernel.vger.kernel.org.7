Return-Path: <linux-kernel+bounces-745916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFC1B12070
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F201C28068
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C88C247DF9;
	Fri, 25 Jul 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="0kDuwkpk";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="EmYoIkMP"
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7423504D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455513; cv=none; b=cFsViHPeAGMoyLHEofy2iGH1FVFH2c2ALb2qcjEA+qO2soYifsZubKmm9ZLYuYArsAANhugMP/VyiEIsy9RCxvPAiStSsUzQlmP30C0jsh39ozBvshJMKyZKsCSwLSy9z2hnzpmz3LwY5QjOYWFn95+gaozXmRrTox8kYt6hApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455513; c=relaxed/simple;
	bh=bF8/csET5SNqtwj9JF9QFqV0DeWFFnRuoxPZBgbfsdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4CSj0qKQPxQ0qmPSXD5N+YKL9QBTT06Z1etUSs59+2sa/ssqTjdXJQLNGxvJZQX7umTyRzXnkp7fITMpEyY7FwtjIVy4labuPdeYQsdN7wWhD3+cvXi0v+lEOT4Ws+lzJaVAAiZqnpFyhDQ/p9IBlW2aTmdv/iFGE25AAK6mHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=0kDuwkpk; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=EmYoIkMP; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753455506; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=tl5AxARlMSzyRXW4Zbs7qJk+ktNSIeI/HtBHi+C3wDc=;
 b=0kDuwkpkk0Eqgu88+BdryaLUVPr1KZxJH2pCUHpPCjVZnUk2JCX8D3euS1xXujzvDK5R6
 AsiZCwZaIaeXsdR1QhHKyfU7fvufgo78tCXUQUiSzf6VejCBJBkQkJVfhOckBKX6lQZYwoZ
 TwzfeMdxogYbIvqCOKGq2PwEufO9yYzN75c1/cb0S8LdIVDAt92nKQ4z2hsTxTbObeD6FTV
 wFd4DOc2PO6B+oD1L1j38cOF0o++dUgQECvCsSxEQO7+yzQCxGtTXLizioUISAD3IxvtZj5
 lv1MqCMgzQIiBsV3GGH0JbXTVBTP6Vpn/w7ZQPSBmXd54gZdvyWLS2m9pgGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753455506; h=from : subject :
 to : message-id : date;
 bh=tl5AxARlMSzyRXW4Zbs7qJk+ktNSIeI/HtBHi+C3wDc=;
 b=EmYoIkMP0/hkCroHIkz7Cgk90HdjWMd90QzF4tge3VApLMiakhmA5C0nUADmJ3WG3VZim
 i/pSxZXhLW9n1KPKvhYuZZfMr9dH58OuNfhOla3xMdxZDdfF9tln1d9wQOlIa0MAze8MvZx
 aen3psbrJ2jC4x7cXRgW6DcBJ+ReWgQyriy4MKyl0/O/VjJU8iKhiOciW5gSvCzNMd/wrXb
 cEXgL/Mg48yYVa2PgFzWbOanGSMnfkbkpE8AHUVRTOud1JjlYTE6e1ERxmWo0E3xlZXQ9Q0
 snEpRgI1qynC2tJ0/kFAvlnYAWpwOFM5HyriV8Y5OCJklKxndnWvBAJYIBwQ==
Received: from [10.152.250.198] (helo=vilez.localnet)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ufJsI-FnQW0hPtRBK-dTGU;
	Fri, 25 Jul 2025 14:58:18 +0000
From: Edip Hazuri <edip@medip.dev>
To: perex@perex.cz, tiwai@suse.com, edip@medip.dev
Reply-To: 20250725144911.49708-2-edip@medip.dev
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Edip Hazuri <edip@medip.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 17:57:19 +0300
Message-ID: <2420183.ElGaqSPkdT@vilez>
In-Reply-To: <20250725144911.49708-2-edip@medip.dev>
References: <20250725144911.49708-2-edip@medip.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sR_qNS80Cz
X-smtpcorp-track: qD1hfG4MtXvQ.uEiO6Xf41mYX.3Gp_pwYq2I5

On Friday, July 25, 2025 5:49:12=E2=80=AFPM GMT+03:00 edip@medip.dev wrote:
> From: Edip Hazuri <edip@medip.dev>
>=20
> The mute led on this laptop is using ALC245 but requires a quirk to work
> This patch enables the existing quirk for the device.
>=20
> Tested on Victus 16-r1xxx Laptop. The LED behaviour works
> as intended.
>=20
> v2:
> - adapt the HD-audio code changes and rebase on for-next branch of
> tiwai/sound.git - link to v1:
> https://lore.kernel.org/linux-sound/20250724210756.61453-2-edip@medip.dev/
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Edip Hazuri <edip@medip.dev>
> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/hda/codecs/realtek/alc269.c
> b/sound/hda/codecs/realtek/alc269.c index 05019fa73..33ef08d25 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -6580,6 +6580,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
=3D {
>  	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660",
> ALC236_FIXUP_HP_GPIO_LED), SND_PCI_QUIRK(0x103c, 0x8c96, "HP",
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF), SND_PCI_QUIRK(0x103c, 0x8c97, "HP
> ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF), +	SND_PCI_QUIRK(0x103c,
> 0x8c99, "HP Victus 16-r1xxx (MB 8C99)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
> SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)",
> ALC245_FIXUP_HP_MUTE_LED_COEFBIT), SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook
> Power", ALC236_FIXUP_HP_GPIO_LED), SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook
> Power", ALC236_FIXUP_HP_GPIO_LED),

I'm so sorry, I forgot to fix the subject.
I'll fix it now




