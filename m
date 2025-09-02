Return-Path: <linux-kernel+bounces-796560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A234B40296
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6733487225
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26FF3043AF;
	Tue,  2 Sep 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pKQeqfPK"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789E2BDC17
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819019; cv=none; b=T4xYjq2+mGSiWhcDbH2NYHotGBTUfjSj+bh6+g24MeaZ4WXClTe1hx3pJaVcuY5orFxuzWwyyWleIGZn1s3FpeycXjfpIWBV5si8j4gYv8ruW7mS8P4bN5S4HCFt+anzBue1m9IOog+8VVrnZHwnBML5S2ZVbysP+snAofxXaB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819019; c=relaxed/simple;
	bh=57B7B6BubeyfbaohI7kZ6axaAJDdQoHWU7qVqQPSP6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Otknt1AFIyRs7nnpxR7dYDR2VbKCa+rN6S0tJ02wODJXc/Re6+hCwplD4DpRKGWLNdklh5x+NJXysfVPgUsonRZPqlJtgBuYxF8Fj6zGLFdEmPOyKA++dmbq5A61EujxxHOq3GyhVjhBxbhOryexCnXSy8Q3XG7O1+jtrHbbXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pKQeqfPK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5660C1A0D65;
	Tue,  2 Sep 2025 13:16:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D74960695;
	Tue,  2 Sep 2025 13:16:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 248A61C22D253;
	Tue,  2 Sep 2025 15:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756819013; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OD6qhRDyS8q2kCor5yPA7YDO6FHMm1Wu843InmsDchg=;
	b=pKQeqfPK532IYnPuEdIw0daG1ELhvGs9hWjeL6miEsqUWjkImbjVc1681eRK2vsVOVJlTc
	bRnJUgbmkTdkK87w8WxyJmycw1WLrgzZMdhKjEQ9Qa19UG7vKrN773KUDp6od6+L9HeyeD
	P4qFOrx72oryIb1J576IhQs59ebIkECGfWV8BrIMQRwj1sd4JmSR9HrH2HvcHyQsvxbeJy
	qftxJ7amt4jASpYDIj5zqZZOyObSGYaBb4wH3+XfalNkGf90rxh4Pc+MDT2HDxNXibsPrV
	Xm5yT4FLCvbUKAiTwJK189aFcvHZys9osAzHHY2q+ksI8cb+BA1HnTfer3nRDg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Wang Zhaolong <wangzhaolong@huaweicloud.com>,  <richard@nod.at>,
  <vigneshr@ti.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <yi.zhang@huawei.com>,
  <yangerkun@huawei.com>
Subject: Re: [PATCH V2] mtd: core: skip badblocks increment for blocks
 already known bad
In-Reply-To: <95bf5e07-7f03-efb0-da9b-cb50999c2524@huawei.com> (Zhihao Cheng's
	message of "Tue, 2 Sep 2025 19:41:06 +0800")
References: <20250902092732.2244544-1-wangzhaolong@huaweicloud.com>
	<95bf5e07-7f03-efb0-da9b-cb50999c2524@huawei.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 02 Sep 2025 15:16:45 +0200
Message-ID: <87ldmxm1tu.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> @@ -2349,11 +2350,19 @@ int mtd_block_markbad(struct mtd_info *mtd, loff=
_t ofs)
>>   		return -EROFS;
>>     	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
>>   		ofs =3D (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
>>   -	ret =3D master->_block_markbad(master, mtd_get_master_ofs(mtd,
>> ofs));
>> +	moffs =3D mtd_get_master_ofs(mtd, ofs);
>> +
>> +	if (master->_block_isbad) {
>> +		ret =3D master->_block_isbad(master, moffs);
>> +		if (ret > 0)
>> +			return 0;
>
> Hi, Miqu=C3=A8l.
> Here, should we keep the same logic with the lower
> level(eg. nand_block_markbad, onenand_block_markbad) when 'ret < 0' is
> returned by master->_block_isbad. Many specific nand drivers(markbad)
> return the negative code when 'isbad' fails.

Good question, I guess in case of error in isbad() we shall probably
still try to mark the block bad because actually marking a block bad is
probably more important than returning correct statistics.

Thanks,
Miqu=C3=A8l

