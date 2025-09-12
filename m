Return-Path: <linux-kernel+bounces-813010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49EB53F94
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3641BC23D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319F548EE;
	Fri, 12 Sep 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mcRztRBQ"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9548381C4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757638801; cv=none; b=CKKxl55H5xIwURBP9EEq6a50DIgzQuwGeXeeU1fmC8Fwya7l9lF+I5DtSerPoFR8J5b+1v7MvbsOTf8mbe8JNzNYvjAcKYQBd+gW+7rfqEnXQFWDMgd6s+kSur51yjgS4tOfod/eanRRXL6tkUu9/AKCL2r+FpdZsC140EdVjV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757638801; c=relaxed/simple;
	bh=hG21TZiTIxm0mnOIOVe7TNRqU9EumPLVjJoAqk/JuoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3+EoKqgFOhu0qwin9PJFKcqC/oK6twlAHwqUuM/tlu0eQvCORB4vBra8iJ+Z0nxSGsIxNfcbhMIfA4y/L3P8C9yHPQoXoempg2Tsr/5XoCe3nAcw0ent22eil1gfY+NnfYbmwCghGJiV3vrqCghP3wMy8NQDVbsbEDVBs7lYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mcRztRBQ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757638796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMiBSaInF+hhMFgiKTpM6CvmtWD3eEqrpblFLp2j2fs=;
	b=mcRztRBQaFMlOm2orlCvPRojMiGJk0l7CngY10PlmoXqmkf6djqozSfCHOrXhPNhalswQD
	2EQBwYE4tHjCcFxNmjBXt5NF5wVUH56J5v6oE2zYgsMOKpIOO3sYK1UYKBAtNFKX0snY8N
	2bTMHsqNeYrIwrX5ydgmQQrwlmsAkJ0=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
Date: Fri, 12 Sep 2025 08:59:32 +0800
Message-Id: <20250912005932.2568228-1-tiwei.bie@linux.dev>
In-Reply-To: <579899d18d5aa4422f970d28e19dc363c9ed218a.camel@sipsolutions.net>
References: <579899d18d5aa4422f970d28e19dc363c9ed218a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 11 Sep 2025 08:59:57 +0200, Johannes Berg wrote:
> On Thu, 2025-09-11 at 12:39 +0800, Tiwei Bie wrote:
> > On Wed, 10 Sep 2025 14:10:37 +0200, Johannes Berg wrote:
> > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > > 
> > > > With SMP and NO_HZ enabled, the CPU may still need to sleep even
> > > > if the timer is disarmed. Switch to deciding whether to sleep based
> > > > on pending resched. This is a preparation for adding SMP support.
> > > 
> > > What's the rationale for need_resched()? Is that somehow defined for
> > > this? Is it what other architectures use? I guess I'm just not entirely
> > > sure what it means.
> > 
> > Here is a relevant document:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/scheduler/sched-arch.rst?h=v6.17-rc5#n37
> > 
> > There is a similar check on x86:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/process.c?h=v6.17-rc5#n916
> 
> Ah cool, thanks for the pointers. Though "1." part there is a bit
> confusing, I guess I'll send a patch to reword it :)
> 
> FWIW I already applied a few patches, but I'll take another look,
> hopefully today.

Thanks for the review! :)

Regards,
Tiwei

