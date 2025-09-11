Return-Path: <linux-kernel+bounces-811344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFAAB527CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DA71C21C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7002235072;
	Thu, 11 Sep 2025 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lhNU6ot5"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A7329F3C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565583; cv=none; b=M6mvEt2y+vrxm82WCur6QIDsTK36uI32C7egOfeAIv4eexFHza8swFjjKiBnNgJ2DDv3K+BLTfu6IMs+HdmM7uow+jL8EI0HdmE/aAUW2hetvFmAqmxIPJJNzi9t0VxcMpIWLJgGVBXE+YWqi5Ulwtv7Pe6+d0SkYn57JPpVVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565583; c=relaxed/simple;
	bh=Eb2YpN/GpvqAukhCaCtPJ+NO9DUUXd610bCVc69jZFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PuAuKIH+Hbmdbc6VGPsjrOaR2PkpkeBfO/Aq8QQ4Zuw7HfscbY8rHSTMBZnRAdFhSFdhA2MDk8dOkHGLepT9nxvo9LJkNc1eZH4ZNIX/xdVSvLn1OL1us4zx937ydrV0y0Lo/kGYKsN91673LT+k3uxjUx3DuSay4efIEF2Bj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lhNU6ot5; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757565578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHsKNkmYTmJBP9KB/YBLwA9+2JO6pQ+tShTIt6iAYVk=;
	b=lhNU6ot5mzf5oOormW/Wo0BbD5jEljjFjAuoIcDK8kmgjlcqAFJjlaphvqe89aElNS1XOC
	Ux301Y1erFASvLfCC0xPzs5umBLTxORc+c3z/RjaRYqcsycRwFnpT0kprBRRu4KxHUq4Cx
	z9+C2fYw/OumvykKsT516wva/BiqxlI=
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
Date: Thu, 11 Sep 2025 12:39:18 +0800
Message-Id: <20250911043918.2950727-1-tiwei.bie@linux.dev>
In-Reply-To: <55cace5b8e1078bd04b4a1acb5df9faa6a83b6e8.camel@sipsolutions.net>
References: <55cace5b8e1078bd04b4a1acb5df9faa6a83b6e8.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 10 Sep 2025 14:10:37 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > With SMP and NO_HZ enabled, the CPU may still need to sleep even
> > if the timer is disarmed. Switch to deciding whether to sleep based
> > on pending resched. This is a preparation for adding SMP support.
> 
> What's the rationale for need_resched()? Is that somehow defined for
> this? Is it what other architectures use? I guess I'm just not entirely
> sure what it means.

Here is a relevant document:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/scheduler/sched-arch.rst?h=v6.17-rc5#n37

There is a similar check on x86:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/process.c?h=v6.17-rc5#n916

Regards,
Tiwei

