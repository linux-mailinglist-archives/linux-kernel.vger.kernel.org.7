Return-Path: <linux-kernel+bounces-747154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81371B13069
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9EF177F24
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993FE21CA00;
	Sun, 27 Jul 2025 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PjiFFmnP"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7098EEC3
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633506; cv=none; b=h65mQupAGDl/cKpiE4IAgodubCPv5JG08M1ua42j9dwtdAVuma6BBKDiNvhX7QzTBbZWBvThAk1cKJGGeUHsfC+sJxJikV/JkL8xGmIyiK8U5GP5O5EsQSBj2v+dHHrJ34MecZBF8qFB1jqyVlJzOclRvn70i2b+lzKs5HLePLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633506; c=relaxed/simple;
	bh=UZJZdb2zCF9ZBCE29YUkeb6sVTYY/wS14j1gY9DV92s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VZadzgnhIZvJMhb5uwcK1psYciGFOHuEdEHRdd9pMi7EuruXi3nzXRGncKRuyReU7l+HO2UsKKdW2nOyhz94yAM9YV8R4Z8iPb53DYM331y5LF9bz36lwkp5yqoS3GmPZVsCJA6ApW3p3vmELbNQhOemFGonStYgCKui7nib7Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PjiFFmnP; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753633496; x=1754238296; i=markus.elfring@web.de;
	bh=nWvRmgF1O9iN3qF32r262RxuZuzmPLyZtASjmnOz2P8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PjiFFmnPMu8yqAi2rTIxUe6smeW62KdrROqVKqCRaJiWbWWOZZn67tBjeG6BmLUb
	 +xsSYbIPeWZa0IEBUpy9yUJxbBedAuX0FToLlf8kDoJJYWB40akIuVQo7fBKflZ0U
	 mMl/GPn614syRVj1JnCcG4CXKFnWLAvMWeZOOJ2VWZiHAym3Qiamtl7bKNXApZ167
	 VAU9ul6xJ7aNAt1Xw7RUIrkYQmKRGbcUtrGo7xC2q1QF8TSaxK55zcl4JMOpyQWBk
	 f/6BbPrlSxAQ1sjb4IyH/7SG5nESbzCh2PBoYTysNin7uq70DIY15wY/pc0aZhucI
	 zmhkoxaumyt+4lCK3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1usSmY3FP3-004KLx; Sun, 27
 Jul 2025 18:24:55 +0200
Message-ID: <b107c2a6-bb56-4b15-bf0f-d9eca8163aa1@web.de>
Date: Sun, 27 Jul 2025 18:24:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Salah Triki <salah.triki@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <aIH4t9Ekj8hn7EEk@pc>
Subject: Re: [PATCH] bus: fsl-mc: Check return value of
 platform_get_resource()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aIH4t9Ekj8hn7EEk@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:94FTvMI+ksk/TrFczzDS89VeEXLm/i2dwJ11YOJ4RrEHwOsdIjI
 DbKmAxYpy7Il+w3Ybv0hm4RX0cBB5cV57+uTdrdydQTD8NELmz/uYiwqY3xCvP5TOSYAeQr
 dZDxp7eeiaILhbrkfG0CTieC+qB4R7QmD4Mjmuj0og0GqiDy9+tSyHc6KzphWxg+87N6pHp
 WZLpVLi+yjwRkOE1tOazw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6rjctOuWe24=;EMrg7ITZmedLsw7OxgbhcQrI6Zb
 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

> platform_get_resource() returns NULL in case of failure, so check its
> return value and propagate the error in order to prevent NULL pointer
> dereference.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc7#n145


=E2=80=A6
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -1105,6 +1105,10 @@ static int fsl_mc_bus_probe(struct platform_devic=
e *pdev)
>  	 * Get physical address of MC portal for the root DPRC:
>  	 */
>  	plat_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!plat_res)
> +		return -ENODEV;
=E2=80=A6

I suggest to omit a blank line before the if statement.

Regards,
Markus

