Return-Path: <linux-kernel+bounces-897303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B60C52923
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F08D3A9265
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68713338931;
	Wed, 12 Nov 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EJRO3cEI"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F03375A3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954908; cv=none; b=h2lke46LMRaBlwIzmtHXwJjE1Pp5WqGHyTFzc2MUiaa73KpEt5OrZTo/QULtvN2/FcgDEr/PVUE9N1Yoh/drCLdjzMwybVO4Yu1laTrJP4vDlzQR/ICITsFSgpQAdKD7284SWbdUKqvjaxtCgzg3t8DqMx9MGb71bd0eO+nvU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954908; c=relaxed/simple;
	bh=YsU0dTaqs4QW/ED0m7pbODQ7IBzPI5JhvGwCLt8xFDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfHh7E/N8N3AVMPDPr6+/Kg62+xCoQ/PjUdtKjCtB/hifUFUaoabY+Dt3dV93cT1BJy61m4OlLIvml9D8U1BwreP7nlZafipMXi7KGEthX+7q+MLegxCeRq/go5ShvhSEN53KU+VXctw8jeDlB02fItNhpirbJDgVNSSG0e+sQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EJRO3cEI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VNdezKaPuLlZLoCS026niETCaWu0TRKcJwyY+1b8+NY=; b=EJRO3cEIdg1oCFfncPNDgu/2DM
	X+httyovw/bbr8sJAXbb2e6jzazh+hC4G7F389d3t0XgTwraEZfr4cGYDR1ldnv1HpXb7anJtSFPc
	SVS3XqEmJWKRvzQaQTtVkJeCylqTAmrbQMQMEF+NWKhNnaalM/F2SN3FRtVjgUC0n7pJFrGyi0iqb
	/liFmGz+vAo6+c0P5bbXoPEHWOC58TrnlXOTyEOWtbC6hpX8zBtB5NCOSOdSMWV2bkJjNZSAiFm74
	/EJBgq8CeGkFIjIW6i0yoAOv5pF/it8N31zEK5QKghYl8vp9yGMgwsYsrXBXQbaOhTy1HIB2Y1785
	+qvVH5DQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJAEg-0000000FVxO-32GB;
	Wed, 12 Nov 2025 12:46:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 85399300265; Wed, 12 Nov 2025 14:41:33 +0100 (CET)
Date: Wed, 12 Nov 2025 14:41:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Adam Li <adamli@os.amperecomputing.com>
Cc: Chris Mason <clm@meta.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Josh Don <joshdon@google.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched/fair: Proportional newidle balance
Message-ID: <20251112134133.GD3245006@noisy.programming.kicks-ass.net>
References: <20251107160645.929564468@infradead.org>
 <20251107161739.770122091@infradead.org>
 <ee62fc73-2a08-4648-8852-afa9e2705c8c@os.amperecomputing.com>
 <20251111092009.GE278048@noisy.programming.kicks-ass.net>
 <39bf6191-82d5-467c-9c09-2deb420875ba@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39bf6191-82d5-467c-9c09-2deb420875ba@os.amperecomputing.com>

On Wed, Nov 12, 2025 at 08:04:05PM +0800, Adam Li wrote:
> On 11/11/2025 5:20 PM, Peter Zijlstra wrote:
> > On Tue, Nov 11, 2025 at 05:07:45PM +0800, Adam Li wrote:
> >>> @@ -12843,6 +12858,22 @@ static int sched_balance_newidle(struct
> >>>  			break;
> >>>  
> >>>  		if (sd->flags & SD_BALANCE_NEWIDLE) {
> >>> +			unsigned int weight = 1;
> >>> +
> >>> +			if (sched_feat(NI_RANDOM)) {
> >>> +				/*
> >>> +				 * Throw a 1k sided dice; and only run
> >>> +				 * newidle_balance according to the success
> >>> +				 * rate.
> >>> +				 */
> >>> +				u32 d1k = sched_rng() % 1024;
> >>> +				weight = 1 + sd->newidle_ratio;
> >>> +				if (d1k > weight) {
> >>> +					update_newidle_stats(sd, 0);
> >>> +					continue;
> >>> +				}
> >>> +				weight = (1024 + weight/2) / weight;
> >>> +			}
> >>>  
> >> e.g: Why 'weight = (1024 + weight/2) / weight'
> > 
> > Not sure what you're asking, so two answers:
> > 
> > That's a rounding divide. We have a helper for that, but I never can
> > remember what its called.
> > 
> > The transformation as a whole here is from a ratio to a weight, suppose
> > our ratio is 256, this means that we do 1-in-4 or 25% of the balance
> > calls. However this also means that each success needs to be weighted as
> > 4 (=1024/256), otherwise we under-account the successes and not even a
> > 100% success rate can lift you out the hole.
> > 
> > Now, I made it a rounding divide to make it a little easier to climb out
> > of said hole (I even considered ceiling divide).
> > 
> > 
> Thanks for clarification.
> 
> If I understand correctly, (sd->newidle_ratio / 1024) is close to
> (sd->newidle_success / sd->newidle_call). 'sd->newidle_ratio' means
> success rate of newidle balance.
> 
> Shall we update newidle stats only from sched_balance_newidle()
> as bellow patch? So that sched_balance_domains() will not update sd->newidle_call.
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12171,7 +12171,8 @@ update_newidle_cost(struct sched_domain *sd, u64 cost, unsigned int success)
>         unsigned long next_decay = sd->last_decay_max_lb_cost + HZ;
>         unsigned long now = jiffies;
> 
> -       update_newidle_stats(sd, success);
> +       if (cost)
> +               update_newidle_stats(sd, success);
> 
>         if (cost > sd->max_newidle_lb_cost) {
>                 /*
>  
> I tested this change, Specjbb performance is similar with your patch.

Ah yes, that makes sense. Let me make that change.

Thanks!

