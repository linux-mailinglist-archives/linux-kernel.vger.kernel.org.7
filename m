Return-Path: <linux-kernel+bounces-795910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F84B3F944
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF9E17F313
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF25D2E8DE7;
	Tue,  2 Sep 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zvwu18K1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763162E8DE5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803478; cv=none; b=fVgXkgfNNMZmW/GacMGHWX6lNJtozU4RXA5+4vPHa9zZMUnY9WiquHyAB4lHjI1pe3ywkljzvGcCxcADNzVGX0fZMtrMSdprgSX+nJGLHVc6IVUN5/COw4QcnLCD5JYbHD8Hj/YRlAHz1Z+H6SzteEoUQkhGfkOB2t3szZWUvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803478; c=relaxed/simple;
	bh=klnu46oSJniNNAMiaXef/qdgeSS8x0/UFDkRNhAfyn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM8OLSb8tff9zGZb7NotmeYPeshjBC2bRgL3+QiHk1FRgnjF+M2HZOM66LjFpwWhYYaTtGXKulssekGXcMnZuNIe2k/PNx0ZWLcjXBbd2qvEBAywZDYH3dw6/dB/rT48hO7pJnRw9pzpAt/4A11gloPgzelmkznjiFUTLj1Gxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zvwu18K1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I6uYkwY2CsYU1nC2AAWHSC21ebs594OzIwR3unsg0m4=; b=Zvwu18K1S+JDg0VdD2HL56NetU
	c/aIXyrYw5bZhxItq/7IDcy8zttqTybr2OQ2MZC9sf/u9isnzm6iTgGWBi0yFSZDX0N587IOFvZmL
	1Olv1sHYYC61XMOc+XHNPz1n1sHF58NGTrK2mfcWeZX8y5r9uHzwYAvsq/wagPTI6a+850lSMCrPX
	64pOA4A+nxm5aWjx6+XnlVdcgUUTQVhGK0iqzp+LjB9PNtKJY6v+zPyBKkRZto0R46etiUdDxAwaY
	dKBkq5+h6RdrakCZNw7EFuNQzdPuM1HMFFuBzNOHHv5KqIRhefabZ1R5/alqOUBKoU9qvsjBBEmn9
	fKUSBe+A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utMpm-00000003yM3-2p5V;
	Tue, 02 Sep 2025 08:57:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AC55F30039F; Tue, 02 Sep 2025 10:57:45 +0200 (CEST)
Date: Tue, 2 Sep 2025 10:57:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xia Fukun <xiafukun@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	mgorman@suse.de, riel@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix division-by-zero error in task_scan_max()
Message-ID: <20250902085745.GT3289052@noisy.programming.kicks-ass.net>
References: <20250827123427.1229183-1-xiafukun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827123427.1229183-1-xiafukun@huawei.com>

On Wed, Aug 27, 2025 at 12:34:27PM +0000, Xia Fukun wrote:
> The error can be reproduced by following these steps:
> First, set sysctl_numa_balancing_scan_size to 0:
> 
> echo 0 > /sys/kernel/debug/sched/numa_balancing/scan_size_mb
> 
> Then trigger the clone system call, for example, by using
> pthread_create to create a new thread.

How about rejecting 0 instead?

