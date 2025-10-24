Return-Path: <linux-kernel+bounces-868736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76CC06047
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25AC55855CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B500314D2E;
	Fri, 24 Oct 2025 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C+M7i9nH"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABE1D6AA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304334; cv=none; b=Ep9ApF1LIejRylTMftl2j5mxRpnLsHdJ9HuE4q1Uc+8BbkuEDhxCOlyaksPunmMcmkc4c5cSHav/o600rcHrmwQ3GNw+A8rFjMgHTrH4LRJTVGKp5HxWPHi0F3DR1J9uoqOzGu9+D16DtefbE2u40SNrh+xNlfZ4vwSldmMDS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304334; c=relaxed/simple;
	bh=pxTQyyVeuV42VG1uYkKU65NnRD7jJRYEUtD/DYthKF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p2vcL/zXPVPjgcCKZOp15JKBqby8D81UWYJHyhmZi0Q5SdLpeJkPfArHM4JOI5k4wwd2+RlbdZ4XH8/6t+wSe7AgPpY8Y+xjGY32YGmSELjxjydWthUuWPEOMbRJpOf1uh4LBOPgUeODpcOWMskDJKb5ZsDFWBr/rzAdhKgK2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C+M7i9nH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C7BF3C0C40F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:11:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A7ADE60703;
	Fri, 24 Oct 2025 11:12:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A3CC102F247D;
	Fri, 24 Oct 2025 13:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761304314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vse7BFpQSZKGEFHYELT9rSihMyyNPAxVb6yV+MS8nJA=;
	b=C+M7i9nHsiZCr0kOsA3TLOzcvEti3GGZzsuqJDbCMh3qjQJFig4VIW2PWE1PQQv1VRwBl5
	O/PRfqRmIxRTTfL15P2H7B+2p7lWQj3H6fzyKHBnGtUvMHQPa4N5GbUShBE+etxqA/EWeF
	WfsXwjI88mDwQcdjKF+jDBeESmz2rM7fdrYXsuCsgObzRQ6Yk7I9J7JdMYHNpdAT2kSJD+
	A9eXbXnyrOmWAgjbWT4BjT14dU+36J1a9RC1M3j4wdhiVrVlkD7D23FBOpo9jz6W/FM03o
	E121D1bOEKskDclLAEhh33Y8eDxz2NzukqU5zIyDb9ZexUtGbOpBg6ZQQIh8kQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Cc: richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: cadence: Add support for NV-DDR interface
 mode
In-Reply-To: <4a6577ff-7417-4d34-a683-2402736fd9d7@altera.com> (Niravkumar
	L. Rabara's message of "Fri, 24 Oct 2025 17:47:11 +0800")
References: <20251024071306.242227-1-niravkumarlaxmidas.rabara@altera.com>
	<87bjlwrbqd.fsf@bootlin.com>
	<4a6577ff-7417-4d34-a683-2402736fd9d7@altera.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 24 Oct 2025 13:11:37 +0200
Message-ID: <875xc4r1ue.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>>> +	if (dll_phy_gate_open_delay > NVDDR_GATE_CFG_MIN)
>>> +		ie_start =3D NVDDR_GATE_CFG_MIN;
>> Can you double check here? I would expect < instead of > given that
>> you
>> compare with something you named "minimum". Maybe it is legitimate, just
>> warning.
>
> I have double checked, the logic is correct. May be I shouldn't use _MIN
> to avoid confusion.
> In v2 I will change NVDDR_GATE_CFG_MIN to NVDDR_GATE_CFG_STD.

Ok.

>>> +	if (nand_interface_is_sdr(conf)) {
>>> +		const struct nand_sdr_timings *sdr =3D nand_get_sdr_timings(conf);
>>> +
>>> +		if (IS_ERR(sdr))
>>> +			return PTR_ERR(sdr);
>>> +
>>> +		ret =3D cadence_nand_setup_sdr_interface(chip, sdr);
>>> +	} else if (chipnr >=3D 0) {
>> This isn't very clear. Please make it a separate condition if you
>> think
>> you must handle this case. Otherwise you're mixing it with the SDR
>> vs. NVDDR choice, and that's misleading.
> Noted.
> I will make a separate condition check as below in v2.
>
> -       } else if (chipnr >=3D 0) {
> -               const struct nand_nvddr_timings *nvddr =3D
>                 nand_get_nvddr_timings(conf);
> +       } else {
> +               if (chipnr < 0)
> +                       return ret;

Why do you check chipnr only for the NVDDR interface? I don't think it
makes sense. chipnr should probably be checked before the whole if()
block.

Miqu=C3=A8l

