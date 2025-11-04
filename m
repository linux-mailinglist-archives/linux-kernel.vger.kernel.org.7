Return-Path: <linux-kernel+bounces-883970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AFC2EF32
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0908218988B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC0223EA8C;
	Tue,  4 Nov 2025 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5fMGUL4C"
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974981DE4DC;
	Tue,  4 Nov 2025 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222830; cv=none; b=qUSHmz3c/Zo5fv3VXxNd4r4uAtqmQYjJeM7K31GF5i6JTdjMI8HDOVy7/A/RDzOu5CjMvSfcRef+MWSLhE3YAFzHdi80e9Jji9IUWl1A0zQE3aikDa94QFb+E6jRCaFTz6y9yhVipP8a9mInMaKZu42cYuYQX704GbuUY1rvUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222830; c=relaxed/simple;
	bh=O828h5KICt+CxEvVNrcn2W18GSriC+FVfgyjhNIRBsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUcNaPDQGpPBvnc7f7OYesbUrD4r38hTy2fcCUkNi3o48TwY+KQFkPk6xHuOD618B8XxqQCDZ7kt8YUG+bdlXiPaJDkmeI2e7PNPjLcIDtCJNVJ261Y5vFoTEtH2/Ab1Xf7kvqsz3R1a4pqQlEPUaz8vwsIZ4Cp4uE4OtKWUr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5fMGUL4C; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O828h5KICt+CxEvVNrcn2W18GSriC+FVfgyjhNIRBsY=;
	b=5fMGUL4CG0GbPCEQ4BfyTgfKq4Ur/10j59cFtq9svQdXjZTp9AZzzHnkhKDxUA/Z+nz85/WGa
	Jqwqdq0yj/8xwLLhytz3ljGEjlJLp6ncQsyIK922sHW2FyT4x9GKoVcPaGWjxmJ5MvzyUzp2dGM
	rtM9uLvdOsk3pXu/4rOTkuk=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d0sZg1WYhzpT1F;
	Tue,  4 Nov 2025 10:18:51 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id A3984180B5A;
	Tue,  4 Nov 2025 10:20:19 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 10:20:18 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <bp@alien8.de>, <david@redhat.com>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <linmiaohe@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <luto@kernel.org>, <mhocko@suse.com>,
	<mingo@redhat.com>, <nao.horiguchi@gmail.com>, <peterz@infradead.org>,
	<rppt@kernel.org>, <surenb@google.com>, <tglx@linutronix.de>,
	<tony.luck@intel.com>, <vbabka@suse.cz>, <will@kernel.org>, <x86@kernel.org>,
	<xieyuanbin1@huawei.com>
Subject: Re: [PATCH 1/2] x86/mm: support memory-failure on 32-bits with SPARSEMEM
Date: Tue, 4 Nov 2025 10:20:14 +0800
Message-ID: <20251104022014.7716-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103123920.GCaQiieAtEGz1nspWZ@fat_crate.local>
References: <20251103123920.GCaQiieAtEGz1nspWZ@fat_crate.local>
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

On Mon, 3 Nov 2025 13:39:20 +0100, Borislav Petkov wrote:
>On Mon, Nov 03, 2025 at 01:15:58PM +0100, David Hildenbrand wrote:
>> I rather wonder whether the memory-tracing code should live in a
>> memory-failure.h instead.
>
> Yah, move it pls. It doesn't belong there.

Okay, I will try it in V2 patches.

I'm not very familiar with the implementation of trace.
A trace/events/memory-failure.h file should be added, and:
```c
#define CREATE_TRACE_POINTS
#include <trace/events/memory-failure.h>
```
should be added in memory-failure.c, right?

If I have made any mistakes, please point them out. Thanks!

Xie Yuanbin

