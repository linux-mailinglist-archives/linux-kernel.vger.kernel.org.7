Return-Path: <linux-kernel+bounces-739395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC88B0C5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2093AEF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB302D8383;
	Mon, 21 Jul 2025 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="L6hICBFr"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18E25760;
	Mon, 21 Jul 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106834; cv=none; b=e34tFQ20XfYHAXVZVDieO7wJ/Zv7oGWARggY0+ynHKdhOtZO/rgO+s0kMLKSXxTL2OYKHnZz46FSSjHAOBHmZ+p8HBg0b01LOG8+ZLnHWJ5zB0RhibRJNn/+69amuD42dD49gJjIGYzOyegcaAsjUOwDgvcgkCoy9AyNN/5vfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106834; c=relaxed/simple;
	bh=dDLMu3QMebK1FNoFV8C9HWrYSHaETjLsuu7VqLx3ohQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=trApO+UjQyi3I9gJs40cacSzhjOeOskkoRJ2plXefOyiC0Dr3VchHCtm5F3Xct3iZGD+xcGMc4iwRWPeXL9n9laKDwcWWvRlPRvsfk2bMu+Ln7vtSPfGox4lDdBi4GLn/A1kRQFXLWfJOD/JgjCXU2lWQandCDuM/OTu1QeA2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=L6hICBFr; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753106820; x=1753711620; i=markus.elfring@web.de;
	bh=ZsDyDq+vPnzmCgLevKW+7+zFB/U94giZ1IBZgijPiZU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L6hICBFrkn3UB9lECy4IpyUQ0iix48z4RX37/aHmZB2PDHEDGEZKJJmyjg0FtFvV
	 sEQEv2g2yPAv/ONUkU89MMOIl1b975wUSrvkhhno5zHQ43Yaw1DNk2XNn/Wal3n7P
	 cQ4M0dsOnsMFsZeSmMZ2Qa8chMQaWpr6cPX6Mtsedd+2mv7B+aaXfY8O3vUpHgL/X
	 lJbpx/xkm8zhPkhEdV5AfJdmzhLQc01C8WdjMeTxCU+8VjdCfw6BOLA9sbP4OE/N5
	 xtL9lRUbu8NcmNBp9zXKNMH2x1126lQ0yMBaqzDojVb73ETd9MTDXllqXeQRrOBxd
	 SUIDjIunFpl6mcH0sQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3V6G-1udJCb2xwQ-00AHhd; Mon, 21
 Jul 2025 16:06:59 +0200
Message-ID: <97a70a4e-6d86-4576-af05-1b2f0a1108a1@web.de>
Date: Mon, 21 Jul 2025 16:06:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Erick Karanja <karanja99erick@gmail.com>, linux-sound@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20250721114554.1666104-1-karanja99erick@gmail.com>
Subject: Re: [PATCH v4] ALSA: usb-audio: qcom: Adjust mutex unlock order
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250721114554.1666104-1-karanja99erick@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BhrWUiftQeQGW86dJrsKAv2LuV5AnYeB11S4AkhWHr1gMf9wuxg
 QbQFcsa2Y5r+K0qzeG7EALzHquWe1g+4J0DcBgQkFK2pCxz0ps+8rOdKkPEIG3ri1aaHTkn
 /0wpUSCrfP1z3csmy7KxNHYtSKMG38Qwas331UY7XzQEJZ/qVyU/+tbJ1PcT44CL3PZCWa1
 ycx2aWxCdc9xZAxJn4tbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R/Cp4G2EjRo=;LLACC8fVbLSCRDYBKyS1ljjIn3j
 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
 Lyt3iQuGGkUSJiFEs2x1eng=

=E2=80=A6
> This change reorders the unlock sequence to first release chip->mutex
> followed by qdev_mutex, ensuring consistency with the locking pattern.
>=20
> Fixes: 326bbc348298a ("ALSA: usb-audio: qcom: Introduce QC USB
>                       SND offloading support")
>=20
> changes since v3:
>  - Add the correct fixes tag.
=E2=80=A6

Please take another look at patch requirements.

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n94

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n145

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n784


Regards,
Markus

