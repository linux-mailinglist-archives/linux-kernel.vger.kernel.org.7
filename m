Return-Path: <linux-kernel+bounces-874108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFEBC15949
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C723B66D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DB345CA3;
	Tue, 28 Oct 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aTGEdT4I"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE2340A47
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665641; cv=none; b=rXW4ubd1SWt8zXrRq20Wso1hUtwWYEips+yjSeve18ibN/L52l7ZPz+xN/nASTqKsxNgzXG4HpWweuWiIh97tknZvFLa4s7CfP74mtwpuqrmpyLS6vkQu6P0NGSNxT+Wgz4wmx/7Rl+J30ROx7PhkmtoHP80uFPROc94Bc4J+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665641; c=relaxed/simple;
	bh=5HUMdWdP7Gh+IDVSu3h6YOirnoHB3M6a1g128nvu7CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvthKMRNbaOL9/+HciqIqZEFbV82X9czV4eV+JoO9rgA5LDbE/eDJIZ//KrhZuwLcsGQgb7+1Lqaw+bDX1BSHVRF40Bl2SuDrk8vitBRpoRHfblldu0RL2U9hDdH31d9gxzyDFeKdGWKHXsUxApvn+LW5r4rGLsv4fNZli2uRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aTGEdT4I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OHvaXLoEg+XCwHHw8NdpuxdvPKvxXIA9NAlup/Qhm+s=; b=aTGEdT4I2T4evtzUStevRmclaS
	2u9Tq7Bg276IJ8f3a0GHwn4GNXIOTJ4O6sih69CtlNI4DZsACL8Pk4wcvxJIr9wqt8XmZlDpd9EMO
	0+w74RTF9HHFqXQ6FO4diVoX2EcxKHer+gReAPGeQmiSObBg8XvPD/rqIGZcIE+RLK3vHov3FTrkT
	QTsneCvMEu7c0iJN3UJdd0fR8VDnbRUgJmMgwOKHvvcHX92s8YcAt4A0MlvwMabvhyaLHuVR2g8la
	Qyo7wFTeDLg/sj1oe9fIPXaldEFuEY4s28wpdsxMUKnPTdLPtPYaTlme/WsYHA1oehYmRFHVrq0r1
	wehUxJ4A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlhn-00000000jHK-2Xuo;
	Tue, 28 Oct 2025 15:33:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 810E9300289; Tue, 28 Oct 2025 16:33:51 +0100 (CET)
Date: Tue, 28 Oct 2025 16:33:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <20251028153351.GN3245006@noisy.programming.kicks-ass.net>
References: <20251027133915.4103633-1-mgorman@techsingularity.net>
 <20251027133915.4103633-3-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027133915.4103633-3-mgorman@techsingularity.net>

On Mon, Oct 27, 2025 at 01:39:15PM +0000, Mel Gorman wrote:
> @@ -8783,7 +8862,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  		 * When non-idle entity preempt an idle entity,
>  		 * don't give idle entity slice protection.
>  		 */
> -		do_preempt_short = true;
> +		do_preempt_short = PREEMPT_WAKEUP_NEXT;
>  		goto preempt;
>  	}

I'm confused, should this not be WAKEUP_RESCHED?

