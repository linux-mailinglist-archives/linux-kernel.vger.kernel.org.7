Return-Path: <linux-kernel+bounces-812215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA85B5349C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA1188CD7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2DD32A3D1;
	Thu, 11 Sep 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NWNg9s5E"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0F3164C0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598999; cv=none; b=Q6FEnGqE9zXmMgCIKfjYxMy98Fj+3LfAzAN7T5GUPMJvyxHDqSVxQYzDf4eZJdH1gT7s7hrOhOv5X/fvmvjN5HcnP8bIStj+I6mw8ICTOhxXMDbewGtpUfhtgjV78jfeoKnFSLi3iZfylzE4IjDX7OFS/ZBz5L/CsnVisH7oWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598999; c=relaxed/simple;
	bh=ZdohH05+uUDyLKxAFEM5dNNmUiWBnpQVEpY+OTeNxY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9VJoLhqB5T/g7eUj8Hgw2UnE37+IAlDUXqz68mG4gwVKc365sO8QAdVu7Q28iY7kcBSNQ9dBz8u8d7qJ9KBAmqRWZHQrMszJlzFR+mC9uQqL5sdfvK+WM8TDRMHEpsHo6imjfDdRfhqY0xUanDQgIcjZfCOH+nq5qZmhEJGrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NWNg9s5E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZdohH05+uUDyLKxAFEM5dNNmUiWBnpQVEpY+OTeNxY4=; b=NWNg9s5EEPJfOFvYoslh6axEUD
	MpFpBDeOKlklz0WgzNKLhPuj0hI/YMO9bJ1rvq5ATIQfT7+FalkB9nZYRLtmtgWXE6+bjnaOlSxjT
	xNv0UTlNImEsZkI2f5F2Ln+IjPyTuJ5HNYGIecFoU2ooKxWYdDgPFQr9yvZ5gwB3qoFkeB42FxiIh
	cGZtZqU+0AG5/W3D40IR822+GZOTHYGWJY8edwr1sRC8Os3/B8QN/O/ZzLLUSbbOO3A9Lv5PWjom3
	iSbr1scM0X5V+3FFTJWIp4YFA88Nuj9fJUxNQTjCQnM3lyFlxsW/I+tT+1UOl0+d7PWzBD9vY7fJq
	iLIqi8iQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwhmm-0000000C0Mz-0O9W;
	Thu, 11 Sep 2025 13:56:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 99383302E5F; Thu, 11 Sep 2025 15:56:25 +0200 (CEST)
Date: Thu, 11 Sep 2025 15:56:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fernand Sieber <sieberf@amazon.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, bsegall@google.com, graf@amazon.com,
	wangtao554@huawei.com, tanghui20@huawei.com, zhangqiao22@huawei.com,
	linux-kernel@vger.kernel.org,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH RESEND] sched/fair: Only increment deadline once on yield
Message-ID: <20250911135625.GS4068168@noisy.programming.kicks-ass.net>
References: <20250911095113.203439-1-sieberf@amazon.com>
 <20250911113746.GO4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911113746.GO4067720@noisy.programming.kicks-ass.net>

Also, do not cross-post with moderated lists, that's rude. I suspect it
is that nh-open-source@amazon nosense, which I now removed.

