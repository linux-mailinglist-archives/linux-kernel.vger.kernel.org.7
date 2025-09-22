Return-Path: <linux-kernel+bounces-826623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F9B8EF55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F91188FE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FFB1F4289;
	Mon, 22 Sep 2025 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tSKKE5uZ"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C126AC3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758516661; cv=none; b=aOPhE68l061Imr20WSCTcbRiEvyOCS/s8FjAYoTS3jZFyZRcv4bOZ1Pbt+g1jbBZw6T1W4GhmWPnEOmFtTxE9rVmsBZrQCkQDNDFoTrMtB4MoG5iRDCmSNkxLvdfnW3leKFrEBOBdBBFBZUi5WaPYT1FiHtgCEIAJloozuroYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758516661; c=relaxed/simple;
	bh=EJpecCmvYVnW7+hEqEIcBODJ3WmkmrgoXzFssouN4Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tj3BHKHrxq6EMRRw2IrRx1wg3BCks8AP3dn1aTgPeJide47NVFe3gqBYh6ERH4ytImZZqvWLrT2AizFxi4u+fc3lnLPA6DAXlNtLSrSXHU3tJluTv42RCUltQLHXMysqAQQTi9EJzo4utG/bFRZgttgLTlm8RdAcY0fwiBVKJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tSKKE5uZ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758516655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwgsf+oOu+Cs2yHtuw1gc40ABzClXDU5V0q0ZXbaVqg=;
	b=tSKKE5uZia5W1YJpJE1LHPCwdzQLSumM+IE2wmINU4dYzOgcgOHeCvBuqdTZDW3EUnr08x
	NfcIgYeZ/QQKZYxcWcpp1DKZLlX3eTLp2hSF+cJ2bThYggumrmQXwOpJDKG68Mt9uLCbPV
	9drP/z0vnulkh8W871WrSMCPdsO9OSo=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: linux@weissschuh.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Date: Mon, 22 Sep 2025 12:50:20 +0800
Message-Id: <20250922045020.48158-1-tiwei.bie@linux.dev>
In-Reply-To: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sun, 21 Sep 2025 22:00:41 +0200, Thomas Weißschuh wrote:
> On 2025-09-10 13:59:02+0200, Johannes Berg wrote:
> > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > 
> > > We are going to support SMP in UML, so we can not hard code
> > > the CPU and NUMA node in __vdso_getcpu() anymore.
> > 
> > Correct. But does that mean we actually have to implement it via syscall
> > in the VDSO? That seems a bit odd? ARM doesn't seem to have getcpu in
> > the VDSO at all, for example, so could we do the same and just remove
> > it?
> 
> It is my understanding that the UM VDSO exists to cope with old versions
> of glibc which would fall back to the old vsyscall mechanism if no VDSO
> was present. That could fall through to the host kernels vsyscalls.
> See commit f1c2bb8b9964 ("um: implement a x86_64 vDSO").
> 
> If this is not necessary anymore, the whole VDSO on UM can probably go
> away.

The vsyscall usage was removed from glibc a decade ago:

https://sourceware.org/git/?p=glibc.git;a=commit;h=7cbeabac0fb28e24c99aaa5085e613ea543a2346

"This patch removes the vsyscall usage for x86_64 port.  As indicated
 by kernel code comments [1], vsyscalls are a legacy ABI and its concept
 is problematic:

 - It interferes with ASLR.
 - It's awkward to write code that lives in kernel addresses but is
   callable by userspace at fixed addresses.
 - The whole concept is impossible for 32-bit compat userspace.
 - UML cannot easily virtualize a vsyscall.

 ......"

The original issue could now be considered resolved. So in v3, we no
longer turn __vdso_getcpu into a syscall wrapper; we simply removed it.
Perhaps we could remove the whole VDSO before we implement the "real"
VDSO. However, its implementation is clean, so keeping it wouldn't hurt
and it could serve as a useful starting point for the "real" VDSO.

Regards,
Tiwei

