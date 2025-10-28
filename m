Return-Path: <linux-kernel+bounces-873971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31125C1539F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AC9661961
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93483338929;
	Tue, 28 Oct 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u6qGGxXO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3BF32D450
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662274; cv=none; b=V3mZQx2ceuLMgbLq0K+5iNHWEgFjU3vuRbsTZ+TRD8xb1oxT4MjTGL2rJGRADVZcFQqUDbdK6ENCiBsGBhRf4rQoCSv9UrWcfYCF0LyaQgaWhQdSFrnLqF1XuzNJ+DgrgFNOkgIkOmHVoP783QnFfErV+ciILWgSBWQsz4ct75w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662274; c=relaxed/simple;
	bh=FNAqnDifNFBgyCPGedx8QMbyxN8hGtIjXzp5yiKuE6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NblJpnjdfG6KX26bvVUQoFDnRHJxyvpKrh+i01+ohDgVpc406ry9V2Dv9FZ3KG/f+3wm8R0053lzpqlcq/iOs+ZsTj9HkFfDSlOidu99Sbe8qpBn9DBFHhrikubsq8eGvCaDmjnTtlFmvb6zvIE9jip9D8lnBKD9La3hkEk1TBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u6qGGxXO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FNAqnDifNFBgyCPGedx8QMbyxN8hGtIjXzp5yiKuE6k=; b=u6qGGxXOvKp4if2NLv6gwHx+nT
	iYFP+zcP9Gdda7WguxzfCcoXkb+jR2YrRJakVrOqABDkCQuZb55H0Mo1nqL88nhdHCIoHnbCEkpFP
	ZALa7oim7YFISGOHVyaAgMn/+enpJLAzWA+GogfdwZYyspb0w2CvKunuLPThpb97ZN6u3mQW4OZx0
	VWEIVleRypD7CfA7aMCgdmykT9xK/SVbO7r3Z5scHYKCgkwedWMbbP6WkaV3C9rSgberAIkW8x9Hf
	vwiM24ftMs3H3KBCU0N7kL9vhrwwtTPIXxBkR9mXr4ZCbATzkyRwG1wq4BPzUs7TWT6Q/30Jg6FMK
	kWFewo5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDkpO-0000000H7lH-2Gwj;
	Tue, 28 Oct 2025 14:37:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6FFB8300220; Tue, 28 Oct 2025 15:37:38 +0100 (CET)
Date: Tue, 28 Oct 2025 15:37:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH 1/2] sched/fair: Enable scheduler feature NEXT_BUDDY
Message-ID: <20251028143738.GB4067720@noisy.programming.kicks-ass.net>
References: <20251027133915.4103633-1-mgorman@techsingularity.net>
 <20251027133915.4103633-2-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027133915.4103633-2-mgorman@techsingularity.net>

On Mon, Oct 27, 2025 at 01:39:14PM +0000, Mel Gorman wrote:

> NEXT_BUDDY has been disabled since commit 0ec9fab3d186 ("sched: Improve
> latencies and throughput") and LAST_BUDDY was removed in commit 5e963f2bd465
> ("sched/fair: Commit to EEVDF"). The reasoning is not clear but as vruntime
> spread is mentioned so the expectation is that NEXT_BUDDY had an impact
> on overall fairness. It was not noted why LAST_BUDDY was removed but it
> is assumed that it's very difficult to reason what LAST_BUDDY's correct
> and effective behaviour should be while still respecting EEVDFs goals.

I think I was just struggling to make sense of things and figured
less is more and axed it.

I have vague memories trying to work through the dynamics of a
wakeup-stack and the EEVDF latency requirements and getting a head-ache.

