Return-Path: <linux-kernel+bounces-788056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D55AB37F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB03461687
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0622F745F;
	Wed, 27 Aug 2025 09:50:18 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF39299927;
	Wed, 27 Aug 2025 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288218; cv=none; b=JmWEGz1seDDUdmOrZAIXX2MTDRKlf2WPW/bvK/kWIRiq2XjdTAI6FMKbntVTF1fsPn5NsPQHak4y1Z6foOxEqwv0GJy/nN+6ZLf42+YEWj+UxgVqTBrb7P3AMc/VSpcGHlypjk7F7XQWHGpJKXHzNCDUvQB+hTWiVEagzrzEsqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288218; c=relaxed/simple;
	bh=z6CBsQ9Jrrtl65/IY31Nk8Vi0G1GqOhAOb8MYIiu7KY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qO2xik20RidV2l2qvxlhb1WTy/3+bk6F6HlNGil5DJ/MV52tIQuUo4zlcgRS+MzoJomscARZ8Z+1tRio9CO/eUhTdZyWWovtvc5OHD86C7VPZFRn8CxM3bXF/8YpBM8yKiUfq1+3QHT5EH/eGpLWy3mwvrg3qYsJapIi2Lci2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cBfnw1946z1R8xM;
	Wed, 27 Aug 2025 17:47:16 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FD581400DA;
	Wed, 27 Aug 2025 17:50:12 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 17:50:11 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <edumazet@google.com>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <helgaas@kernel.org>,
	<horms@kernel.org>, <jdamato@fastly.com>, <kuba@kernel.org>, <lee@trager.us>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <meny.yossefi@huawei.com>, <mpe@ellerman.id.au>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <sumang@marvell.com>, <vadim.fedorenko@linux.dev>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v01 10/12] hinic3: Add Rss function
Date: Wed, 27 Aug 2025 17:50:06 +0800
Message-ID: <20250827095006.1595-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <CANn89i+D+mmGms5eYxntwpyd3OX1yXz3c9xvjQT_XmmnvxJGwg@mail.gmail.com>
References: <CANn89i+D+mmGms5eYxntwpyd3OX1yXz3c9xvjQT_XmmnvxJGwg@mail.gmail.com>
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

> > +static int alloc_rss_resource(struct net_device *netdev)
> > +{
> > +       struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
> > +       static const u8 default_rss_key[L2NIC_RSS_KEY_SIZE] =3D {
> > +               0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
> > +               0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
> > +               0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
> > +               0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
> > +               0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa};
> > +
> > +       nic_dev->rss_hkey =3D kzalloc(L2NIC_RSS_KEY_SIZE, GFP_KERNEL);
> > +       if (!nic_dev->rss_hkey)
> > +               return -ENOMEM;
> > +
> > +       memcpy(nic_dev->rss_hkey, default_rss_key, L2NIC_RSS_KEY_SIZE);
> 
> I think you need to explain why you are not using netdev_rss_key_fill()

Thanks for your comment.
We use this default rss key for stable hashing effect but omit the rss attack
surface. We will modify this in next version.

