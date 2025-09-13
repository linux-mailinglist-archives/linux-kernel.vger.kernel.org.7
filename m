Return-Path: <linux-kernel+bounces-815314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68B2B56282
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096CB1B23DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332EF212576;
	Sat, 13 Sep 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gFE6aTbE"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA848C11;
	Sat, 13 Sep 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757787768; cv=none; b=QtowAH/lShU0f1qyKzL6K2oTshHCUhIKG5PPdk/W3RB+LRYNIxJ1W1q9DftOcElIdFt+8/I1QPFh2UY84BF+uEfFuJjW629tNUfcQGQyw7/VAB0utshCIRJ3iKYzeopfyUXUzlcqrdMTSwCaWoZfe1l0GbCGJT4/1gSOAN10SLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757787768; c=relaxed/simple;
	bh=rRVxYk+oOe/ib4hGtmNubv4xzDGaSg4PVpOJ2ViiySQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FN2T/4YtqJTvNvTHoGWq/qsQ22N19itoG9yTfRomgKwpxU5KozZQOv9WLQZO+2EnqIt2vRhN7WxtyfrT5h+v/Tt4L3TQzjI4hA83WbpJsFUaR92Xr7mPGzAN0iSiRr5+TidCW8PFIfJUJMAP4/fyMgF5iMy8Cu9YTgsUf/zEDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gFE6aTbE; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757787757; x=1758392557; i=markus.elfring@web.de;
	bh=Ksl6YFtMydbXmNW5IGhz8B/+TXMx0f0NMlOcWwG/F3Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gFE6aTbEgoPGoWUNw5AYx1xivLxTk59jLRssO73VwdMIYz8ftD/rye2SDf/cpbbp
	 bsV8ZHIHkG3wU/hHd+5UQZoQ4CGi5vNnW4hkeRSvKsrfJR1JAoSd66xvP0DrWuLee
	 GPMN/Pfg3igIN6LXTEWU8MZXZc+grsw4aWgwk7xV3YM8Gq7qQtdQ95fC6NqrbWbEV
	 oim4dfXhyrgsBVDIW5VPIMiwSojEEOgXEGUJXRCLZUWYFGRfQIgIV+ExGzVLBOpZl
	 0s3TTYB3h66WlhdD2/V5UNswUQARZG1/mtiO+ODYh/iWLax0ox/xVxf6ViTBeDZ0v
	 RcWoi5+bbdXdYOxdVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.217]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumNN-1u6uEw09lz-00sN5A; Sat, 13
 Sep 2025 20:22:37 +0200
Message-ID: <81581ae8-1528-4598-80a5-5d8f4e4dc795@web.de>
Date: Sat, 13 Sep 2025 20:22:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v?] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
To: dany97@live.ca, platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matan Ziv-Av <matan@svgalib.org>
References: <MN2PR06MB5598DFC94FB13E9F809F0EB3DC08A@MN2PR06MB5598.namprd06.prod.outlook.com>
 <37610abe-e6ea-4694-be63-1a7147c52b73@web.de>
 <MN2PR06MB55988311E10C20DD6EF0CB97DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
 <f8726808-9e34-44b5-b6e2-27e898c53321@web.de>
 <MN2PR06MB559854ADB7D4F32EFE9A2E25DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <MN2PR06MB559854ADB7D4F32EFE9A2E25DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9DaC30fyVO/KbWStv5+aKF72e/j93RhbX1/u04/9iy7fNoORkTY
 fyWttYCoALBEHtveJ+WZXVL5bZMR0W97kcyxK5ekHjVd60io3lQ7xpI4XSq3yeCYi0uBluE
 3tERZXA/FXMiYn1RTEfcarBf8LDLqG1pOE8fqSifuLbcRn64P1eTjYTsUJvKOrZA4S+2rYp
 r78Hop9K2VisokSH197EQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:faWQwaRQWMI=;qDICxUIWkoLpnfFD/Nsd3SF753Y
 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
 TF69zLx9ZpSaWFHi4bK

=E2=80=A6> Signed-off-by: Daniel <dany97@live.ca>

Would a complete personal name be preferred once more
according to the Developer's Certificate of Origin?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc5#n436


=E2=80=A6> ---
> V1 -> V2: Replaced bitops with GENMASK() and FIELD_PREP()
> V2 -> V3: Add parentheses next to function name in summary line
>=20
>  .../admin-guide/laptops/lg-laptop.rst         |  4 +--
>  drivers/platform/x86/lg-laptop.c              | 29 +++++++------------

Will further items become noteworthy here?

Regards,
Markus

