Return-Path: <linux-kernel+bounces-845262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055EFBC4313
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CB719E0B9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D1225B2FA;
	Wed,  8 Oct 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mK3doMt2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D3243376
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917046; cv=none; b=UME687gs15FFI/u1i1p7GKw/OA90D8skly+V+9uMMor2xboyNs5Incy079yVj5ihKwhotnhiT5UzIHXXJlhBe2LPOvVg/7NtXHqZl0VP7d/k9G3amFzM9zHmPIQNTsq0o1tgwgLiUV3mWw98Hss3FQ2i88SGeNsYrcEOt1E92MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917046; c=relaxed/simple;
	bh=noAPU6ufUmj4GqS/l2MwnK05MhfGysnpRiYBcPaYf9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFGKdyndxp3aQRr3G4gaNFdwYgvn1vPC7awemaa+LREk6nY+oltsDgwTNCr7Ur8OggyLZNKgfOK6rhgb12JZ6KaiIILxVqYWuSi9ofIQrIkJWxjjDpzkFUdMSnBNMk0o7qABVS3gPSYMxuI8j4cnx7Jc9yp6ZKpvZLNNZac1pK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mK3doMt2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r11xdNoRZFdbSIutkJtNqLxC5mByf5evL0hzeiweqVI=; b=mK3doMt25J0J6oXNI8JXX+ZTsw
	EjDr2Cmz4B2QCPIg5cM1NEg11KCvH1jeoENL8gk7Rw8PzMkxg1BgCCWMJ5Yd3vUZWljpg4OtJsBqL
	b6MiinzAMIs9HHl9kE4FpgQzk4tO2fNvoCrz79HDSzmGbqku1DMbq2yyqqronyKqq/C9qGedAcn58
	AhRtrKz8DJWqxR57fTDX5RfHah1WX/aqOV9G1P8LrG0vHbGrZev7Tx640+S1gHK5+mkEEY7RSYTRP
	FWXvL9XXXRosFV61UMjYs16I0aYXH4v+hvMJXuDTYSu46cTKCFqfQVVqO94T4uUe+uwqG2bQvZYeP
	KGcgg6CA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Qoh-00000002Slw-2sck;
	Wed, 08 Oct 2025 09:50:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D9C5A300220; Wed, 08 Oct 2025 11:50:39 +0200 (CEST)
Date: Wed, 8 Oct 2025 11:50:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, jstultz@google.com,
	stultz@google.com
Subject: Re: [bisected][mainline]Kernel warnings at
 kernel/sched/cpudeadline.c:219
Message-ID: <20251008095039.GG3245006@noisy.programming.kicks-ass.net>
References: <8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com>

On Wed, Oct 08, 2025 at 07:41:10AM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> IBM CI has reported a kernel warnings while running CPU hot plug operation
> on IBM Power9 system.
> 
> 
> Command to reproduce the issue:
> 
> drmgr -c cpu -r -q 1
> 
> 
> Git Bisect is pointing to below commit as the first bad commit.

Does something like this help?

(also, for future reference, please don't line wrap logs, it makes them
very hard to read)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 198d2dd45f59..65f37bfcd661 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8328,6 +8328,7 @@ static inline void sched_set_rq_offline(struct rq *rq, int cpu)
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 		set_rq_offline(rq);
 	}
+	dl_server_stop(&rq->fair_server);
 	rq_unlock_irqrestore(rq, &rf);
 }
 

