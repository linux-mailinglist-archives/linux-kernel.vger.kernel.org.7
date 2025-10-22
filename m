Return-Path: <linux-kernel+bounces-864094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2309EBF9E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D36B4E4C53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF57E27815E;
	Wed, 22 Oct 2025 03:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hEgpd6Jw"
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0E224AF9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105529; cv=none; b=Hiw6l5hcMzGhUbuwAs+62ICptljAbtXKdoiZ63IZRkYahojjaWFACoQAXK7MMei4yOFWW+zAoGcH8AQvLTgOSsS0wR+JawKnfQNKV6p1fUYJp7LUXCFa9FSajZVPKzEjCmj8BkmnRXt2dxq7zWmwMtPdzwgoncjtIf6NkdT1BTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105529; c=relaxed/simple;
	bh=km+g0XPH4yDDwLqQ/6BpIJliLoLcAkSlxXyzmPgqKOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2E/iQ6zpFW/gaIHzJcaAAh6uKWqe2D+P6QdFyjU0jXmRAv8H0ccpBPShBZIJfSqQr5jxTozAuOo36/aqzLYQd8LULliF7kIhMJn8p0RWPhO23oUT+CyMbift2MJOH2V896Ze1vY31oVEkEZD4KDzrw22Qhh00aEEtdh4inCqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hEgpd6Jw; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=km+g0XPH4yDDwLqQ/6BpIJliLoLcAkSlxXyzmPgqKOY=;
	b=hEgpd6JwJZ9quWIenfHDoy8zHH1ttczMOU8UzFAFadDe/tw5k8si5ua5TPmAOYpWIWbDBeUYg
	kpi6IRBrHAwfVRscLYxugeW6yhGaVr6NTN63WUwwypBSiV8YywDevppMYx4VTaYhlNDNBpAX1S3
	Nm0SURSZqZT7deMLCWopl/Q=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4crwPR6f9PzLlVs;
	Wed, 22 Oct 2025 11:58:19 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D710140155;
	Wed, 22 Oct 2025 11:58:44 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 11:58:43 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>, <nathan@kernel.org>,
	<ebiggers@kernel.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
	<kees@kernel.org>, <dave@vasilevsky.ca>, <peterz@infradead.org>
CC: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH 1/2] ARM: mm: support memory-failure
Date: Wed, 22 Oct 2025 11:58:37 +0800
Message-ID: <20251022035837.1915-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922021453.3939-1-xieyuanbin1@huawei.com>
References: <20250922021453.3939-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100009.china.huawei.com (7.202.194.3)

Hello

These patches seem to have not been discussed for a month.
Does anyone have any other opinions?

https://lore.kernel.org/all/20250923041005.9831-1-xieyuanbin1@huawei.com/t/#u

Xie Yuanbin

