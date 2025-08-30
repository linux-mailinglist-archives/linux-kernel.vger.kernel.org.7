Return-Path: <linux-kernel+bounces-792875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE855B3C9F0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3D616FAFB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1EC25CC62;
	Sat, 30 Aug 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="deNA8p7P"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AC1531F9;
	Sat, 30 Aug 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756547731; cv=none; b=eEUCqh81aw7GSJGjmCHt0JfFXL+9E7Y3ZBQU3dQygsTqE4Lnfj9JFAQAOfG/tF1DQQDdVp4R1+BR7urQe4XG0GTWRClW/STJ2gWqDT5IwstmPkFOXmW9YR0FtQxTpnv6qJif7mRKCeR+tZ4NfeLpvO5J0Jc1LM82o4GDHko0Bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756547731; c=relaxed/simple;
	bh=bbTkg9VOabzO44YnmEVXA0NVE1Zz3kqfiBxtN679nZ8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GeGbrFpJpKf3re252rZsyKwpBQk6gcVrngAEGKa27UW7tfg6ULfOiGZM1AIPTgUn5XmnddCfGzO+CSuENfsXwBk2lILx0Fz+/vV1wrx8Tto4BIiOAovMqC/7q96v73Q24R8NVoCuHVrVusID7KFvVqrqyG+YSMr5nULsWLASFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=deNA8p7P; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756547715; x=1757152515; i=markus.elfring@web.de;
	bh=LfT2Mg3Wp5zN4MePAdXO0bh+Ixl52RXlU2Z358Vjx3E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=deNA8p7PHU9dMSSpwhhop9+nTiLedTgNjULDVyiz3/0DjcFrJQFRK08X/k7CB/fb
	 T0t7D7OuXyAIWS+SVVkFFnzlTIEk8sjdJdqbWwgEwcMCRXCHxsI2EhSq4WCmHm9rg
	 TmzAVLZv/s9bWDdA2fi1RR/DpdOylY+ZI/j2dXk2MVma91DEmMspYmSpnEAZYu8YH
	 5VZrs7PvAbYP8fDE+siIXYjgInPaI6xblllKvnc6foIaDu8pkLupF+V8POnFKfpBX
	 XtaEuz35+wIyjAQ6vBhAOxmrUqyD+4tZHV1UPiiNn0veDWBl2XsdYQghxfLGg7Lbm
	 ZvGh0tE8fP/7IZeesA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.198]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOlk-1v4M5H0UCC-00RGwe; Sat, 30
 Aug 2025 11:55:15 +0200
Message-ID: <0c2906f7-ded0-4609-b9a5-8d6949ab6e07@web.de>
Date: Sat, 30 Aug 2025 11:55:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>,
 linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250814172222.9448-2-ramiserifpersia@gmail.com>
Subject: Re: [PATCH v6 1/7] ALSA: usb-audio: Add initial driver for TASCAM
 US-144MKII
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250814172222.9448-2-ramiserifpersia@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TdP0lmSh8lIjCpCrBcIiMoqjGF2KMKzIn4nYFMxBx+L74ONS/Fk
 22L0kxKzS9z5pWiG5paEcqzSfUEbb0cBOcbp3fP5TshAf0rGHU6k1t7OkY8IjHhLZFbUS5d
 bZbM5XS4KTWuAb0xgwYAbtlPix4M5PyU9+6SJVbuWXtbXY0lmraOg4aR44ryiqzyKWNGihC
 JgqmOQSNrJpiJIX/OUdNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6hRLm8bGeWg=;0S88ZccCSd555tbyYzhYPWAPOKv
 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

> This patch introduces =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc3#n94


=E2=80=A6
> +++ b/sound/usb/usx2y/us144mkii.c
> @@ -0,0 +1,248 @@
=E2=80=A6
> +static int tascam_probe(struct usb_interface *intf,
> +			const struct usb_device_id *usb_id)
> +{
=E2=80=A6
> +	char *handshake_buf __free(kfree) =3D NULL;
> +
> +	if (dev->speed !=3D USB_SPEED_HIGH)
=E2=80=A6
> +	handshake_buf =3D kmalloc(1, GFP_KERNEL);
=E2=80=A6

Can another software design option become more attractive?
May the scope be reduced for such a variable?

Regards,
Markus

