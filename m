Return-Path: <linux-kernel+bounces-812234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67851B534D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB6BAA1AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570DF33436D;
	Thu, 11 Sep 2025 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SDnrZy2v"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D029B8F8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599537; cv=none; b=T9q1o4o18uMTN4sRQE10g3a4WwVTZU8pZwvnNuL1QtskczdrQhLfcwKPuPxCsmIge++JIfiddnJFEoO8TEve6+6DoQy7Q66IOPcy32LFVa7n1ZX96s5FUEPYAoJWE3SpmIQdfCtjOWHfSIoUeMgUjvO8qb/nK+YBzYV7Ape1kg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599537; c=relaxed/simple;
	bh=ZRVLDX6fwrfDYhNM3J3FGUJH3ZvtwHGxkJzJLV/IGqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PbQS8XKolNMpyRNvBOOo0iPeEFLnTeCvEVEZZ5jW9CyaF3h89F5xpunK1P67GHkPXmLZ5ZQ2sW6GK5sND+DobRcOv3WGljAm6j+AZR/zwOSGrrVO6Z/sbcEdaTiIzBhPaa4xjwcvNhSiX7HcWdmpKx/KzfGMM6kqyXnz7mnmDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SDnrZy2v; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BD4B54E40C8F;
	Thu, 11 Sep 2025 14:05:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 938EB60630;
	Thu, 11 Sep 2025 14:05:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77946102F28ED;
	Thu, 11 Sep 2025 16:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757599534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZRVLDX6fwrfDYhNM3J3FGUJH3ZvtwHGxkJzJLV/IGqA=;
	b=SDnrZy2vS1E3ke7pypMMRvQhvZj3r4097DXXUas5BpMF+OOcY81Bk5GXG5/scIDl0JkPE5
	cBVoEmHCVCATnH3bdnQqDQyLvcAA/bYlFzaOyld5GNeT98l1qavrE6tOtXI6WoF+Zzy5Q+
	gPx6Z/yHj1J0DqfO1YJTlpaNVQzKcu2F8Ncuu9wnQRoY5nslGXNZG4c98ksmYRUoYzrcTb
	oDaYUFTyDiodl9CzbjViSAOUK+o1kNseqR+8I8PT7bASeRgA3YhcZ4GMcluMzYrGf/40kN
	zmGwxrTG7b6dFldNPV0gjD5LbShm+k6Ddgv0UnbumEce1Wxd1JzuPh3F++9toQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Gabor Juhos <j4g8y7@gmail.com>,  Santhosh Kumar K <s-k6@ti.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,  Daniel Golle
 <daniel@makrotopia.org>
Subject: Re: [PATCH v2] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
In-Reply-To: <mafs0v7lpi1j5.fsf@kernel.org> (Pratyush Yadav's message of "Thu,
	11 Sep 2025 15:03:58 +0200")
References: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
	<175708415877.334139.11409801733118104229.b4-ty@bootlin.com>
	<454e092d-5b75-4758-a0e9-dfbb7bf271d7@ti.com>
	<87348tbeqg.fsf@bootlin.com>
	<a208824c-acf6-4a48-8fde-f9926a6e4db5@gmail.com>
	<mafs0v7lpi1j5.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 11 Sep 2025 16:05:31 +0200
Message-ID: <87a5319j9w.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

>> Sorry for the inconvenience.
>>
>>> Gabor, can you check what happens with mtdblock?
>
> My guess from a quick look at the code is that NOR devices have
> mtd->oobsize =3D=3D 0 and mtd_read() sets ops->ooboffs and ops->ooblen to=
 0.
> So now that this check is not guarded by if (ops->ooblen), it gets
> triggered for NOR devices on the mtd_read() path and essentially turns
> into an if (0 >=3D 0), returning -EINVAL.
>
> Maybe a better check is if ((ops->ooboffs + ops->ooblen) >
> mtd_oobavail())?

Interesting, might make sense to do it this way.

Thanks Pratyush for the suggestion, it is worth the try.

Miqu=C3=A8l

