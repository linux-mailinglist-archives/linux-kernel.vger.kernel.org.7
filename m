Return-Path: <linux-kernel+bounces-795828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D09B3F86C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C10217F5BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E726E16A;
	Tue,  2 Sep 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZkB0TrtS"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3226CE2A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801919; cv=none; b=dJ5fGxmLSnwDlZ9mOfe/6josJzqACPfIirmg1tbV86u0kaW9Kd70ZWzZTn0n8CWblWqOcuEJdkJd8vk4/cWo8gG1aodi4S9IwYzMbvEKcvB5xTJeH97a73TW46qYOcCzFygemR3AG2FyQRvByWK2NdKm6RmGUpwcbH/T0W4nWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801919; c=relaxed/simple;
	bh=a0InZGvS5Dvd7mDtMz8ceM5qfGJbvL4twV0uKW17/5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jWRVfukfU9Xsff3ZpwRFN/R9h2a2jMiRhkhphMorFg/pF40d5C4N+wbap9HhPHSftQrm87r7GbzuBA/LKxPiVCWArcCfg1DETZMuoteJD3Q5ayi1pkQq1Oj8TFHB8XFs7RaMURFdXAtZQNa33pY4lmxfKDwGto9dKJ4iYYRWAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZkB0TrtS; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0C398C8EC73;
	Tue,  2 Sep 2025 08:31:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ECCA060695;
	Tue,  2 Sep 2025 08:31:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B92EA1C22D574;
	Tue,  2 Sep 2025 10:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756801912; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hBPhVeSiQFJP1Q2BlDNvNer2/fXDyfLy2fZLzTHFM3w=;
	b=ZkB0TrtSVQwjamvEf1iXhA0YN8n/fCpgacbjZ+Go5cE5Rbv+QYtztUHKPE3nTQpdat6ec+
	XMdjnt1t+7r1RFW/25HkoWtyycI5qAV6pmbiWVKNHZ6F+JVXWFltNHNMCaXftyTDJTJCYm
	PrzTyAjzDyVwcYCvvoSIKtRDxO4BWVD0pelYjDdMIE3Td3nFfgw40fedEU+G//nMPF8Qcw
	Rz6anLSYFbr85HSi/ETi7j61UPPhFc0CrC/a4O4ncacxr0jYPHwct93CQINdqR2XxkVVrK
	cZyMfenCkyC1zwN4D7xzJ/hFdx6fOfhWT2rQXPL0L2O5bhhWKKyK3z41m+jrrA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Cc: richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  chengzhihao1@huawei.com,
  yi.zhang@huawei.com,  yangerkun@huawei.com
Subject: Re: [PATCH] mtd: core: only increment ecc_stats.badblocks on
 confirmed good->bad transition
In-Reply-To: <20250902080117.3658372-1-wangzhaolong@huaweicloud.com> (Wang
	Zhaolong's message of "Tue, 2 Sep 2025 16:01:17 +0800")
References: <20250902080117.3658372-1-wangzhaolong@huaweicloud.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 02 Sep 2025 10:31:44 +0200
Message-ID: <87ms7dntlb.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Wang,

> @@ -2349,17 +2351,35 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_=
t ofs)
>  		return -EROFS;
>=20=20
>  	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
>  		ofs =3D (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
>=20=20
> -	ret =3D master->_block_markbad(master, mtd_get_master_ofs(mtd, ofs));
> +	moffs =3D mtd_get_master_ofs(mtd, ofs);
> +
> +	/* Pre-check: remember current state if available. */
> +	if (master->_block_isbad)
> +		oldbad =3D master->_block_isbad(master, moffs);
> +
> +	ret =3D master->_block_markbad(master, moffs);
>  	if (ret)
>  		return ret;
>=20=20
> -	while (mtd->parent) {
> -		mtd->ecc_stats.badblocks++;
> -		mtd =3D mtd->parent;
> +	/*
> +	 * Post-check and bump stats only on a confirmed good->bad transition.
> +	 * If _block_isbad is not implemented, be conservative and do not bump.
> +	 */
> +	if (master->_block_isbad) {
> +		/* If it was already bad, nothing to do. */
> +		if (oldbad > 0)
> +			return 0;
> +
> +		if (master->_block_isbad(master, moffs) > 0) {
> +			while (mtd->parent) {
> +				mtd->ecc_stats.badblocks++;
> +				mtd =3D mtd->parent;
> +			}
> +		}

I don't think you can assume the block was already bad and must not be
accounted as a new bad block if you cannot verify that. In this case we
must remain conservative and tell userspace a new block was marked bad,
I believe.

Said otherwise, the { while () badblocks++ } block shall remain outside
of the if (_block_isbad) condition and remain untouched. Just bail out
early if you are sure this is not needed.

Thanks,
Miqu=C3=A8l

