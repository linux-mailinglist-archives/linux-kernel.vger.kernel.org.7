Return-Path: <linux-kernel+bounces-747805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F363B13895
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF63B50B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78104254849;
	Mon, 28 Jul 2025 10:08:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C592512FF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697339; cv=none; b=B4XwtxV7FKdvdDOHjD6vLP+BjYXSUoyi0DVhyjTzLS0s09IU45Ps3QBmJY7cZo5EvQElE+rnEP3q4r6B9FYJUhLWQr6oMw0hCfnI40o9j1MtyjSjIg5nwlPqdp+WSuhnRvzGyJ/QNTokWzgKEW5dwpetge9mCBWHjQ6FFUnaJHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697339; c=relaxed/simple;
	bh=8/98U5yc2Mcr4KY7KhfBWnyPJpkI5PPnRKE9o4VWtNc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SafExoz5rcqER6qdMoF6YtdP96sfAn9/zT8hsUpr8oTz1Ab6LZE3OGbw418avlQXQuUocBdmaDXe/6USH4it9esNDbcoV5z+cCoH8jVt3JJMRe8YgZ5p9rr3bYZZOGpv3eZdlUadGTSTTT2l0BP+IMn12DFNnRRfascw6EPi9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brDfb5q5Rz6L5fX;
	Mon, 28 Jul 2025 18:07:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C71F41402F3;
	Mon, 28 Jul 2025 18:08:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Jul
 2025 12:08:51 +0200
Date: Mon, 28 Jul 2025 11:08:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>, "Rohit
 Mathew" <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>, Carl
 Worth <carl@os.amperecomputing.com>, <shameerali.kolothum.thodi@huawei.com>,
	D Scott Phillips OS <scott@os.amperecomputing.com>, <lcherian@marvell.com>,
	<bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, "Xin
 Hao" <xhao@linux.alibaba.com>, <peternewman@google.com>,
	<dfustini@baylibre.com>, <amitsinght@marvell.com>, David Hildenbrand
	<david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin
	<dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
Subject: Re: [RFC PATCH 10/36] ACPI / MPAM: Parse the MPAM table
Message-ID: <20250728110849.00004062@huawei.com>
In-Reply-To: <20250716180725.0000452d@huawei.com>
References: <20250711183648.30766-1-james.morse@arm.com>
	<20250711183648.30766-11-james.morse@arm.com>
	<20250716180725.0000452d@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)


> > +static struct acpi_table_header *get_table(void)
> > +{
> > +	struct acpi_table_header *table;
> > +	acpi_status status;
> > +
> > +	if (acpi_disabled || !system_supports_mpam())
> > +		return NULL;
> > +
> > +	status = acpi_get_table(ACPI_SIG_MPAM, 0, &table);
> > +	if (ACPI_FAILURE(status))
> > +		return NULL;
> > +
> > +	if (table->revision != 1)

Missing an acpi_put_table()

I'm messing around with ACQUIRE() that is queued in the CXL tree
for the coming merge window and noticed this.
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.17/cleanup-acquire

Interestingly this is a new corner case where we want conditional locking
style handling but with return_ptr() style handling. Maybe too much of a niche
to bother with infrastructure.

Worth noting though that one layer up it is probably worth something like:

DEFINE_FREE(acpi_table_mpam, struct acpi_table_header *, if (_T) acpi_put_table(_T));

That enables nice clean code like:


static int __init acpi_mpam_parse(void)
{
	struct acpi_table_header *mpam = __free(acpi_table_mpam) = get_table();

	if (!mpam)
		return 0;

	return _parse_table;
}

This series was big enough that I'm spinning a single 'suggested changes'
patch on top of it that includes stuff like this.  Might take another day or so.

Jonathan



> > +		return NULL;
> > +
> > +	return table;
> > +}

