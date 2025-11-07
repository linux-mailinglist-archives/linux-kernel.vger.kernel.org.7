Return-Path: <linux-kernel+bounces-890755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685E8C40D93
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378453B4378
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4696F264634;
	Fri,  7 Nov 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p2vhcV9E"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA396261595
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532302; cv=none; b=AqcadNQhgC+YaSFkA5G+CX/YEkUOtkE6T1iKGVhjLHWvxttelh9xYT+LxVsV+jHbL/MrTTaVLlAemtT/T8Z1JZYpW1k/RjJrqA6prJ/TpKucYshCYbkx3lGkDpV+Yc64rXoHDPpVLkg/77OhE/ve5iGv35rE+sOp1KBOzRNqVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532302; c=relaxed/simple;
	bh=X56xHjmK09pjaEsSOZBpxYflqOx5s/ONZ13vOeBhZhI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=eR4z35tha00jTlSZyDjiUY7g9uUrwKa4/IMch0ue20481mGGXCQNMdBMmfNadBPLGyfGpE5Fyu0R+NGvhVrODQplfth8SkHrINiBPU2hzbX8xc6Abo1b/Blc59403VR6sVzo+yfP+RS07YyVaxl8TDPbcCo0v51i0kcDTNIH8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p2vhcV9E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZB2h4dGhcK9TxkRdVGaERfGCO6fwXtDuysjkKY0+IbQ=; b=p2vhcV9EgbaOT94SfbmTSDlHla
	kRfMeC9cr1BgeWw9pc4gQ1Wc6UPEUeRty7cov04Yhe0i8DJVe30UcmJAluo1tytXukTs/UnC/MJ4g
	76uVbEKU3aapEGoJ8PVr6GYEH+yQkMJrv0gukEqQLdvBvJMmf4OO4Ss3xcCwR52CBhrkcJ/XtMUtQ
	baFW+JfD1xvkc8qNN3ggcuMymqVY5Qyi7zNVevBRXs1g7cFiOKvAgDHjLeiGGoLXhS8Y+k6XFhLU/
	5z+LVIZSa9cUMba567WyBw2bJv+tsRQ1rXVfjd0GNT84gz0hBgNKl92W6AHiP5UHdT8F/JL7rCU+o
	hVREb1pw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHPA8-0000000DUTK-0Mo9;
	Fri, 07 Nov 2025 16:18:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EE7D63003C4; Fri, 07 Nov 2025 17:18:07 +0100 (CET)
Message-ID: <20251107160645.929564468@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 07 Nov 2025 17:06:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chris Mason <clm@meta.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>,
 Adam Li <adamli@os.amperecomputing.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
 Josh Don <joshdon@google.com>
Cc: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] sched: The newidle balance regression
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi!

So most of you ran into Chris' commit 155213a2aed4 ("sched/fair: Bump
sd->max_newidle_lb_cost when newidle balance fails") [*]

And I posted a patch with a few alternative options. And while I've heard back
from a number of you, indicating that NI_TARGET (the effective revert) works
for you. Not many tested TARGET+RANDOM (thanks Adam!).

In my limited schbench testing that combination isn't horrible, and per Adam
that combination also doesn't suck for him. Chris, could you please see what
this does for your machines with your actual workload?

Anyway, here are a few patches that basically do the revert and introduce the
proportional newidle balance -- the NI_TARGET+NI_RANDOM equivalent.

Also at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/newidle

Please all, give it a whirl. Hopefully I didn't wreck it, its Friday after all :-)

[*] https://lkml.kernel.org/r/006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com



