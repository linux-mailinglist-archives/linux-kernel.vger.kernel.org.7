Return-Path: <linux-kernel+bounces-826916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47793B8FA36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C5D18A15F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A44827BF84;
	Mon, 22 Sep 2025 08:47:13 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D28C120
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530832; cv=none; b=kTgcFo85j1gQ0qg+V4+5BfK019q2ojsEmACOzMwSpPw9JT+Yq+m2tAY9CnSq8gQZLyaxnbAMplJs7QUjEC8zmvx2TbM1jGLDMQgWgAoiXezwONS5Jwx1ZEVRd/a4kdAe4O/QlKmz8awKmAkBlS7AedVNNYs93UVu2eHivNTIFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530832; c=relaxed/simple;
	bh=dZ5tCfp3//VXG/mx0EYo3ZRCbw1ECQ/kHOKiOPgomhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUEKX3cggGY0U37yGafiD0kth46J87tJU63Ds7Wiyd/YdEWcE1YYd5uX5KVzeb5bDF4j5VD23P6PwybxX5Dn+lJMFqaG/EL/GgLw/yiBB4Rzv93mHB/+OJSmPmiW65Rj4XEQgVEvYVYoS7NPhXTjV38TmW+DF/4qe56YZPkyuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cVc790n5szddJw;
	Mon, 22 Sep 2025 16:42:29 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id EEB591402DB;
	Mon, 22 Sep 2025 16:47:06 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.108.232) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 16:47:05 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@redhat.com>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>, <ardb@kernel.org>,
	<arnd@arndb.de>, <dave@vasilevsky.ca>, <ebiggers@kernel.org>,
	<kees@kernel.org>, <liaohua4@huawei.com>, <lilinjie8@huawei.com>,
	<linmiaohe@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux@armlinux.org.uk>, <lorenzo.stoakes@oracle.com>, <mhocko@suse.com>,
	<minchan@kernel.org>, <nao.horiguchi@gmail.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <rmk+kernel@armlinux.org.uk>, <rostedt@goodmis.org>,
	<rppt@kernel.org>, <surenb@google.com>, <vbabka@suse.cz>, <will@kernel.org>,
	<xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH 1/2] ARM: mm: support memory-failure
Date: Mon, 22 Sep 2025 16:47:01 +0800
Message-ID: <20250922084701.27811-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <91041fd5-ca37-4a6f-981c-74aa92bb2291@redhat.com>
References: <91041fd5-ca37-4a6f-981c-74aa92bb2291@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100009.china.huawei.com (7.202.194.3)

David/dhildenb wrote:
> Can you send a patch to remove the "select MEMORY_ISOLATION" independent 
> of any arm changes?

With pleasure, I will send a patch later.

Xie Yuanbin

