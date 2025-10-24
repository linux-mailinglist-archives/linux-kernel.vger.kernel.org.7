Return-Path: <linux-kernel+bounces-868745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD8C06028
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDEB1C272FE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1473324B2F;
	Fri, 24 Oct 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SAEP9+na"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211683233ED
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304610; cv=none; b=CJJjeH+RikCFBGU/pkMUfssYdY6UrZYsEw42Gx50xctWqoFvXqSHdiELb1g8Zy1h65YuvhB69nAk2eUvtycR6Jr+GSqml4IXZvUa0tqTySuD1W0hcAA3sFQbsQm1SU/Wf5DTbddgBdC2no/bSsQP5iFRkgSXo3c1XFJO3lzadDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304610; c=relaxed/simple;
	bh=eacDw9L87bd/XGtW7FWfpnn3HxRi6ROpecDKJ/IHQ8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HsujjqOx6Gc+OJ/tERLcbQaVRddyQewu9xA40N0bo+6LqbrDFBNRiHfXXxyrx6tEghVXGDchxxz3boTVhV+ppzOP+YIJfXJqz2Yudd8GIpmWLoUCwyOHsyFZY66eXn7BLquUnsNDsHZuasRr9BtU22mxQI9OtViu99jv7vTgX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SAEP9+na; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4A1494E412DA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:16:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 16D3760703;
	Fri, 24 Oct 2025 11:16:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3237102F248F;
	Fri, 24 Oct 2025 13:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761304603; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BaDn986q5yhbWKKWBePyq6Pb8smvvlHHR98lZRxcrVQ=;
	b=SAEP9+nackPJTf3w5lUHPqIxzSpqBkOG/SPRu/QjSdJ+uod2yNSqgvSUrBhLo1AVsPZNam
	lDNtnlTZ5MPC9WCZmRBd8iBaYEHPuc+aPxOY+7CG/WxrhCmyN0MVK+1b5471Z/9lytvn46
	eYYUcNBH2h2SFd/RXvZqG7s2prh4bi+FNDrSIdeQj9O1MIXtaET5ulyB/bDUGF8c+v3I7z
	e+gmElP3nLpUqU+P0QgsmEpcgMwx9nHCYLsT2RsnmaoHNZ60suFMIr/ysqNs84jHrmcgM+
	KUSYjNJWv41bUnO6CwaEPDAPJdgnth4UTaJ6KLbzRuS4kl5YBgTliEPDVPU5Zg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: niravkumarlaxmidas.rabara@altera.com
Cc: richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: cadence: Add support for NV-DDR
 interface mode
In-Reply-To: <20251024102611.310568-1-niravkumarlaxmidas.rabara@altera.com>
	(niravkumarlaxmidas rabara's message of "Fri, 24 Oct 2025 18:26:11
	+0800")
References: <20251024102611.310568-1-niravkumarlaxmidas.rabara@altera.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 24 Oct 2025 13:16:40 +0200
Message-ID: <87zf9gpn1j.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

> +	if (nand_interface_is_sdr(conf)) {
> +		const struct nand_sdr_timings *sdr =3D nand_get_sdr_timings(conf);
> +
> +		if (IS_ERR(sdr))
> +			return PTR_ERR(sdr);
> +
> +		ret =3D cadence_nand_setup_sdr_interface(chip, sdr);
> +	} else {
> +		if (chipnr < 0)
> +			return ret;

I still think this is incorrect. The chipnr value shall not be treated
differently from the SDR path.

Thanks,
Miqu=C3=A8l

