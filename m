Return-Path: <linux-kernel+bounces-857148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B14BE6097
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77285E2109
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284F51AA1D2;
	Fri, 17 Oct 2025 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OQUDtwAv"
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D4C120
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760664801; cv=none; b=sc87QsBrDnHf7dbg6Flxqa83qPW1G/cvKrdjDq0JFWzisFaZMXW7cTyQxk8wWJba0/Bpb9EQph/1uweiCXFQPPiJVxElqDQsLf23qS8mgfDq3r8kwgCrY/mLF6tnVTq6M1ptRYNrsVlrNYQljcGNDBZe02UJhvP2MdZzqK6dBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760664801; c=relaxed/simple;
	bh=cOZXmjsZS9OxXu4N7oRurav92/uEjQsnoWP0P8FrzTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/g7CmUvj1fLKTzo+AHqm2cq1tmmBUZfdt9/n5Zo0/AP8sRT/xyWi8XU8gLEXQ4+h5S2sQCayzdfpt+5lIHSc6TNfzzKFt3/WfQBUQ/qIvlohi2fC8Bk825/ZwxNvyU03AOzxYg+73BL3OG6PAKMi1iax/xG+UrU1TKGT5Qlpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OQUDtwAv; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cOZXmjsZS9OxXu4N7oRurav92/uEjQsnoWP0P8FrzTI=;
	b=OQUDtwAvSlzH3jJXM1px/U5utZvNgBVRCiVCLJOruIdAqY0bls74bIGexMC6gFOEXG4gowKA3
	lXpfsmNahdfpUzJgXH7ala4qw1jpAXKTWMZ0T8oE7D7H6CnrQt/PNnsOqlQ1tQ8vD5pbikwEATH
	1pZReGqKjZuM2OWPzy4BNx8=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cnnPy3vxYzKm6X;
	Fri, 17 Oct 2025 09:32:54 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id BC40B1A016C;
	Fri, 17 Oct 2025 09:33:15 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 09:33:14 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <akpm@linux-foundation.org>
CC: <Liam.Howlett@oracle.com>, <xieyuanbin1@huawei.com>, <david@redhat.com>,
	<liaohua4@huawei.com>, <lilinjie8@huawei.com>, <linmiaohe@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <mhocko@suse.com>, <nao.horiguchi@gmail.com>,
	<rppt@kernel.org>, <surenb@google.com>, <vbabka@suse.cz>, <will@kernel.org>
Subject: Re: [PATCH RESEND] mm/memory-failure: not select MEMORY_ISOLATION
Date: Fri, 17 Oct 2025 09:32:57 +0800
Message-ID: <20251017013257.1181-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016140218.15579-1-xieyuanbin1@huawei.com>
References: <20251016140218.15579-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Thu, 17 Oct, Andrew Morton <akpm@linux-foundation.org> wrote:

>> We added that "select MEMORY_ISOLATION" in commit ee6f509c3274 ("mm:
>> factor out memory isolate functions").
>> However, in commit add05cecef80 ("mm: soft-offline: don't free target
>> page in successful page migration") we remove the need for it, where
>> we removed the calls to set_migratetype_isolate() etc.
>>
>> What CONFIG_MEMORY_FAILURE soft-offline support wants is
>> migrate_pages() support. But that comes with CONFIG_MIGRATION.
>> And isolate_folio_to_list() has nothing to do with CONFIG_MEMORY_ISOLATION.
>>
>> Therefore, we can remove "select MEMORY_ISOLATION" of MEMORY_FAILURE.
>
> We already merged this?

Oh, I didn't know this had already happened.
I'm sorry about that, forget it.

Xie Yuanbin

