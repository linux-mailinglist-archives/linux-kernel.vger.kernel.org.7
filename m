Return-Path: <linux-kernel+bounces-722241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF0AFD6CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC8A1C245FF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687E92165E9;
	Tue,  8 Jul 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ho2EUAyd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D379801
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001331; cv=none; b=Yz3eVthvzyDD5djGLA3cNtAq2Baa887htC1VdRFHwnVpAvM7d4vuom4tU2pBfRFQ3mQaX9ndXZ2BdeCI8rPZSYGpNk2GQSGccrNCeNoPcSngE1ajj7KRPlNjEFfwXKLTjehqMCd2n2va4YeHAoAPO5PJZGGL+peYoVr7JRUIzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001331; c=relaxed/simple;
	bh=4PMTN+IctZyy7ZyBZURpieaQ75JXCm/LyZ+7rxRT4o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu9fOH0LnbciDrbISmIcXZWtOAuqhByqT8KXQkEO0yJUT2+jB1ONJxYOd2QzN/pRPyKjTLrQenwQ7KIlUH1OGjEf6rkPIW1vaB3+4D/8xXMbFs5NZxXAWynA/mKyf4zXU1OJM0K6dM66xWHNFVQr9S09TELTBB9r05gq9LQWyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ho2EUAyd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4PMTN+IctZyy7ZyBZURpieaQ75JXCm/LyZ+7rxRT4o8=; b=ho2EUAydrQ/mPLWHTJeua6Gw+Y
	h5k3j7T4dDyT3eQuur6E/s4yMfVM2G0aVpo+6byXtJAQ1m+jSBMEvjypQuT9Rbgvt35Zm5LS+ie/w
	5Symh4E8dHR0O3dtbg433JGqtLrMpO0VEca9x31YhBzBR3ATuv9a1WinlHwgiMaa7sHNP1KSBHFg9
	CLCWhxDX3MXAJAqvBMcwneDPa0iL47At2Ib3L1Sgq3v8XFh5dK+H65lHG2A2Pgz1bRDVL3b2++bNK
	5RvYfuCN6h1B1qSJgH/LblC7vLt4wuLudWARzk2EayWGDoA/wcPgezxhD6OiU7BE93ykTq5JUzqkE
	99S19rJw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZDZq-00000000oPC-2Anv;
	Tue, 08 Jul 2025 19:02:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 25EA8300125; Tue, 08 Jul 2025 21:02:02 +0200 (CEST)
Date: Tue, 8 Jul 2025 21:02:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, clm@meta.com
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
Message-ID: <20250708190201.GE477119@noisy.programming.kicks-ass.net>
References: <20250702114924.091581796@infradead.org>
 <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
 <6e274729-af12-4e0f-9e67-5f2d5b099e99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e274729-af12-4e0f-9e67-5f2d5b099e99@linux.ibm.com>

On Mon, Jul 07, 2025 at 11:49:17PM +0530, Shrikanth Hegde wrote:

> Git bisect points to
> # first bad commit: [dc968ba0544889883d0912360dd72d90f674c140] sched: Add ttwu_queue support for delayed tasks

Moo.. Are IPIs particularly expensive on your platform?

The 5 cores makes me think this is a partition of sorts, but IIRC the
power LPAR stuff was fixed physical, so routing interrupts shouldn't be
much more expensive vs native hardware.

> Note:
> at commit: "sched: Change ttwu_runnable() vs sched_delayed" there is a small regression.

Yes, that was more or less expected. I also see a dip because of that
patch, but its small compared to the gains gotten by the previous
patches -- so I was hoping I'd get away with it :-)

