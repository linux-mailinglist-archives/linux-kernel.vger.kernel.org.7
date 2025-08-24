Return-Path: <linux-kernel+bounces-783703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C64B33170
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562DB443808
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D62D978A;
	Sun, 24 Aug 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0Ohjmpt1"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE23188596
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756052886; cv=none; b=OtThCB+sBmxGYouFYgDkquKlE6c4cMlVhQX4k1WkSz45yvLZUMz6AvqEAdIKWP7za9aOumv1lMcsebBcH6ueAqMtXNyWFejM+j2JDPTXzahNk7HkYGrbVjt6pObni75ZQDcqRJRgr3gKT9xqqYlBqcoyl98aHUlGRI7zC0mB2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756052886; c=relaxed/simple;
	bh=LK3zJ270+fZwO5dYxJjnZ/1hiPqwVQV1MH/2HKHBrRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLq3lrL/ptroq2AlqZ/Kw23GQgHeLkttvaCHkafW87wmp3eHbomMibIvJpmXiFpWZWfqdvJH+o5c6K9KbQVYXV5Nv1L5hMIFmM3WQR+Bi99mDDSZMAbzqiAzUH2UPP4homgqHRvXZzU8tyqCWZGJ/ezjJhhO/48I+orJYPeiYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0Ohjmpt1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 98DE11A0C63;
	Sun, 24 Aug 2025 16:28:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 715CA605F1;
	Sun, 24 Aug 2025 16:28:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A43C31C228BA3;
	Sun, 24 Aug 2025 18:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756052882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LK3zJ270+fZwO5dYxJjnZ/1hiPqwVQV1MH/2HKHBrRA=;
	b=0Ohjmpt1C3U7/UItkLrbTjVweRrkgUSsjSTrcRwgwsZsFLmsMRhkfoVf+pNBlIPh+FXCd5
	B5eQdC7qk5ejqT3TtxK5wITgoDu2k5kesf8Eb63mLEz/UW7Q3ABbRNm4b9MebCJwb06lS+
	V3Z5/Ykob6oI+yGNdxZOlFCusRZvRHjkgzozgMA4s6iMykOrpm6J2PEsi/4D8R2RQ64Psn
	seS+EcFNbT16QC3f1QuGNWnpLnYjah3OnvaJLHMGaOTT1CKWW16myVOjS6Aa4j3KBOGEDW
	dsy59YoenI731Kwg4QoErP2+gWsv2+fgqk6Bz+q+/FlDuHPHRyRGiRexv7Ag0A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,  Takahiro
 Kuwano <Takahiro.Kuwano@infineon.com>,  Martin Kurbanov
 <mmkurbanov@salutedevices.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Frieder Schrempf
 <frieder.schrempf@kontron.de>,  Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] mtd: spinand: fix direct mapping creation sizes.
In-Reply-To: <20250820122100.726451-2-mikhail.kshevetskiy@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Wed, 20 Aug 2025 15:20:58 +0300")
References: <20250820122100.726451-1-mikhail.kshevetskiy@iopsys.eu>
	<20250820122100.726451-2-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 18:27:52 +0200
Message-ID: <87bjo4it13.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Mikhail,

On 20/08/2025 at 15:20:58 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> Continuous mode is only supported for data reads, thus writing
> requires only single flash page mapping.

Please remove the period '.' at the end of the commit title.

Thanks,
Miqu=C3=A8l

