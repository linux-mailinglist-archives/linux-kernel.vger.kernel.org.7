Return-Path: <linux-kernel+bounces-834006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7502BA395F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E017F7B3520
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1502EB84D;
	Fri, 26 Sep 2025 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RT5BCGCl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZ9RmACI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D586353
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888887; cv=none; b=RMseVXq7CAT7NkyY2GvraCbI22GXSRSFCs9m5A4tHzb2B2onolu7LT51w+P/t7VLKTibtKM38KUhoasY3F+qud3h8R8qLlVRDSIaJihMS8q2nr6Ta2Y3mpDtohJ8XF040Mj5XdXvmSXRF70r5Tzshwuc1i1p8DBSTE5sP+SI284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888887; c=relaxed/simple;
	bh=025+J32XfXKh9tiQzEFu9om/UxFWo4oDjP1jJRYqi8M=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hW+J7V4NMir+y5xF718SMuWBtoy6wJWhZxfVw5xFpbEMYQJK1VGRZ92vuVxlvOImjOLxahP82/hCaKtE+QgUsbSysy8rsc/CKoa9oviQDPDkbLD36knTmKC1w5QtvYU3MXh8jNqavNFF2PnBdgPhLFtzjeu1/rY+Ugzzib2u24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RT5BCGCl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZ9RmACI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758888883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhDPg+3tDEf9MpUD75Uir8jON0jMqHC/BgN+drVu6Ik=;
	b=RT5BCGClk8eYNLsWrCT9NGMhUhGTFCT+g6BuEE/ZgSTz46KzxrFGrxf5rfbhKDlmDfZ2dF
	0ZS3KTcwV38r/I9xpofwrp6oDTVzXVb1vUNGtVC5atdEjQoMCLN+n17IHw1IKYK5tNyqjl
	PpsWxBxMWoXH4oPHzHMNzFAg/azXKAospDHtzCjy+vga4mDcDWhgimkYd1OvPRfnzspNID
	2Ze8EmQLtt7inp+OT80QkQZUC/jlS4Y1D19uQy1zaHa3NBESKAPm1UybMXTmNJKVjTNHb7
	XuUCnx4CzTfl++4zbRBP36czEvE8qfTZL5xpxLFdff+pfnHvbojif7ItbBMl6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758888883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhDPg+3tDEf9MpUD75Uir8jON0jMqHC/BgN+drVu6Ik=;
	b=qZ9RmACIatl+hYddkSm7Z/zYxpY3meldLubKjVCBj7S4i2twoQgOwyHOKFHWfdMdyRASsV
	T6yNn6QBRnHYPVCg==
To: Thomas Huth <thuth@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Add kprobes KUnit test
In-Reply-To: <16b74b63-f223-4f0b-b6e5-31cea5e620b4@redhat.com>
References: <20250513151631.3520793-1-namcao@linutronix.de>
 <16b74b63-f223-4f0b-b6e5-31cea5e620b4@redhat.com>
Date: Fri, 26 Sep 2025 14:14:43 +0200
Message-ID: <87frc9h0lo.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

> On 13/05/2025 17.16, Nam Cao wrote:
>> Add KUnit test for riscv kprobes, mostly for simulated instructions. The
>> test install kprobes into multiple sample functions, and check that these
>> functions still return the expected magic value.
>> 
>> This test can detect some kprobe bugs reported in the past (in Link:).
>> 
>> Link: https://lore.kernel.org/linux-riscv/20241119111056.2554419-1-namcao@linutronix.de/
>> Link: https://lore.kernel.org/stable/c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn/
>> Link: https://lore.kernel.org/linux-riscv/20230829182500.61875-1-namcaov@gmail.com/
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> ---
> ...
>> diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.h b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
>> new file mode 100644
>> index 000000000000..3886ab491ecb
>> --- /dev/null
>> +++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +#ifndef TEST_KPROBES_H
>> +#define TEST_KPROBES_H
>> +
>> +/*
>> + * The magic value that all the functions in the test_kprobes_functions array return. The test
>> + * installs kprobes into these functions, and verify that the functions still correctly return this
>> + * value.
>> + */
>> +#define KPROBE_TEST_MAGIC          0xcafebabe
>> +#define KPROBE_TEST_MAGIC_LOWER    0x0000babe
>> +#define KPROBE_TEST_MAGIC_UPPER    0xcafe0000
>> +
>> +#ifndef __ASSEMBLY__
>
> Could you maybe change that into "__ASSEMBLER__" instead of "__ASSEMBLY__" ? 
> I'm currently trying to get rid of the latter in the kernel sources, see: 
> https://lore.kernel.org/all/20250606070952.498274-1-thuth@redhat.com/

It's been applied, it's up to riscv's maintainers how we should do this.

I can send v3, or a follow-up patch.

Or riscv maintainers can also squash that change into this patch, or
into your patch.

I'm fine with any options.

Nam

