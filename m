Return-Path: <linux-kernel+bounces-791059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FF3B3B19B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B517C1BA69AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14FD2253A0;
	Fri, 29 Aug 2025 03:31:53 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF6199931;
	Fri, 29 Aug 2025 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438313; cv=none; b=AC0Ja+ATC/MGdE+1ByC9Kb0VB+J9vFEZvNsZTccaxHOQzIZy7jaokrBdDDQJXeJTDYy4Q2g4Uj33OqKXjF0kzskgI92dutnxYOC9Np6DXrX1HRJT4OV/gAyIXfQpaZyktFLg8halBCXfwIWOwKxpwdFEUV/tebxIJyLJ2SvRC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438313; c=relaxed/simple;
	bh=UhUig1WQs5r9O91kNC6dcY6jU7tD4ywv9NrFPfCV2SQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKnuFbVMfYe1vyYweH9SgtaYpFnFU+9Yw52RGdr/qdKm12vos5eaj3XPKxh6s6Q7Ke17ub5Y9n1LGJnJQagXz1gItBIuemwlvGLJIqos7nu+Rbnc1nGnAJu0u/wx1a/XRtu7Qx0D2J5WvkMrkXLFESaT8FS35gS3z4j42vQ38T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cCkJG6kVZz24j3V;
	Fri, 29 Aug 2025 11:28:46 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B11AF1A016C;
	Fri, 29 Aug 2025 11:31:46 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 11:31:45 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <vadim.fedorenko@linux.dev>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v02 01/14] hinic3: HW initialization
Date: Fri, 29 Aug 2025 11:31:41 +0800
Message-ID: <20250829033141.1707-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <02dcf1f8-3ba4-4f79-897c-bf5a5007cc70@linux.dev>
References: <02dcf1f8-3ba4-4f79-897c-bf5a5007cc70@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> > +/* Get device attributes from HW. */
> > +static int get_hwif_attr(struct hinic3_hwdev *hwdev)
> > +{
> > +	u32 attr0, attr1, attr2, attr3, attr6;
> > +	struct hinic3_hwif *hwif;
> > +
> > +	hwif = hwdev->hwif;
> > +	attr0  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR0_ADDR);
> > +	attr1  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
> > +	attr2  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR2_ADDR);
> > +	attr3  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR3_ADDR);
> > +	attr6  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);
> > +	init_hwif_attr(&hwif->attr, attr0, attr1, attr2, attr3, attr6);
>
> well, get_hwif_attr() name is misleading here, as the function doesn't
> only read values, it also sets some of them. if there is no other users
> of init function, it might be better to merge them.

Thanks for your comments.
"get_hwif_attr" is actually misleading. In next version We consider
changing this to "init_hwif_attr" and the old "init_hwif_attr" will
be replaced with "set_hwif_attr" for better readability.

> > +
> > +    return 0;
>
> there is no way the function can return error - what's the reason to
> have return value?

This is our oversight on error handling and patch splitting. We missed
the error case for "hinic3_hwif_read_reg" that returns errors when
PCIE_LINK_DOWN.

