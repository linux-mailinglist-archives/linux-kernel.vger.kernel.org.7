Return-Path: <linux-kernel+bounces-873133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA85C1330F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E916B583D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D6F2C0265;
	Tue, 28 Oct 2025 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cARi23tA"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8D2C027C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633569; cv=none; b=Sx1pdBQcsXo+GZ2ibU7p2W+lCBiD6CNx/hI0j7B+689O8XubNE6CrbbyXY5042XAFlAv5BCB4tqbIW0Bzt96F2xUo1dwB71FMiSO244F4F49HcnFD0dZTo9VvFTgr9ebGjWczxdjNKAmrjef5igbTK8f1PyTXr8DCM8Qcm380kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633569; c=relaxed/simple;
	bh=xg47qiXaMabziicsQApM2cb97Q7+iRfL16gme2qF/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1maBT94re8Mb0cOLe/LsD8T7pTvu3Nq+2nugUJHuq8qs8LJJ/xqhYUfD13n+v3sTiALtdnDH4o+66QbFQIxZwPokFmehO+pWNRuy06RUb+qeKrAGPNiB+y2YbwKInlXvB0lFOWQoRU2m8sJ1Mdsjk7zFgAYt98JhxKdzhaWwqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cARi23tA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290a3a4c7ecso63515435ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761633567; x=1762238367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Sk3J4rV0V6ChOKqxsqTPdO+lGlptY+6n53U86ci7Xs=;
        b=cARi23tAjDfHA1B7ErUB+DqI/Hz3GsazxWNnKRQKBJB0ale/2GUkcw0lz5s/1aZIe7
         O3MPK+IugQCxnZ4DNf8YHKQV0PqnVc3O8jqJtZ2KIcARsx2a3rBpP/WrE0jYL5dyo1F2
         T+9dA+3rEN/u6LPC7+alk4jCNhBQk5yop4F6U9apHk8dbZHT2ENLTLSpPOBw2hWqdMR1
         sxKmFwF6QgVxJoJLaFGDSt4ofHNESfhN2w/0g+zC/EPchkrtKDFLiSaaKYVwMg3mCLQI
         kWVZw6j83PH21IxV/pwsXbkWDXOGjyJmEzkQZQD8Ego+7AQwZpaCXOrwUyUyXnrzAc4w
         PQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761633567; x=1762238367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Sk3J4rV0V6ChOKqxsqTPdO+lGlptY+6n53U86ci7Xs=;
        b=jyiJn15OX7Tcu0gBi7sAh2YOhdh9pL04oMwSNFD/EgdTrqHG0LaTqBiY9zeoWI4Hpv
         2+wPJyRyt7yiFCJE7tq4mpd+FoNAvvGyYFN9lryNDeCTOUXnMEysTP0IdJ27iHIK1Cl5
         IAktImE3SzCqNEi2r3XOEXZ5t52koV2HnzxceknbOQpHEn4RBt5bT8BVhY2w0qYUjqTy
         IXc8celAQbvcX4bXdWnFGb32oKbTat5fNm1AqWIm6BoRCDTErTnQH1s1iEcfxrDkjijv
         OEFXK02TRTn0zEbUkRfb5McHn0URcX7cRowDIx8asg4wj7qCjL6/FEcO4f+xPJnjN8Ej
         b7gA==
X-Forwarded-Encrypted: i=1; AJvYcCWBkZdHWrdNNOwwrE4f06LJwWu3/lbjbY1K0ZN1W07SUhaDbi8Pi6oaOhvC/ZOFjhgELPOr+Kf2XFYXous=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcIy3K5XXf13oKwDutCPFG55fa9vU2qkphKF7EZNwFioRhvI1
	AN6KiRPzTbbhPLpX325ezIthCFSLlak+6KfVZR+P1BLWFYDHHLuS7aMvMOJLR2F4yQ==
X-Gm-Gg: ASbGncsHIhrDsz4eQDUlKYnTxslXyajE21d5zEzmyrzVKPoAxsFnmX6PXCvYE70y2vw
	LKD00V+Zymu1bXf5uI8ukVz0fhJY9eoxlHkERkNXkHtKFK/bmMWd8G85HkszQe1Vio7DMaItUfR
	q3ZzqgJx4gviUdCe9eT6COh2Or85llu8J1EA4rd0jV+GMGmpfTkOIOA9tM1yJR1IM+RgFV6mS68
	fOrQSuUw+AcVVcXbZ7ld6BKKTKnLLEQZbJXPK5zYVkgmZbDuXgUl8sBxu2vFpUvg2OEyBpc4miF
	xKlMHSFFbBOMjmq2JcmjiM8fvtWIGCBsrxAeAIW43J442VHEH6U4S0uxpRLojvVHpc+TZU5ai6T
	js3yco6DGtYKRcOFZXV0n3Fhn+ithH7RN7bJRVJRgieF3/gDebzZyU4FQAJd60G6Ivyqm0zFBPn
	MO2BQOMAbpTKZ8pCZ4lEjU
X-Google-Smtp-Source: AGHT+IEkSGb9OX7GfA3LGBAOsesov4U2JsLuVNyVQWquI7ExFMu6C95r3VqqWrDDyxO4+M4/4t5JSw==
X-Received: by 2002:a17:902:e88d:b0:290:8d7b:4047 with SMTP id d9443c01a7336-294cb37b835mr35193375ad.21.1761633566859;
        Mon, 27 Oct 2025 23:39:26 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2903csm103711675ad.63.2025.10.27.23.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:39:26 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:39:18 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Hao Jia <jiahao.kernel@gmail.com>, mingo@redhat.com,
	peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v2] sched/fair: Fix non-empty throttled_limbo_list
 warning in tg_throttle_down()
Message-ID: <20251028063917.GD33@bytedance>
References: <20251027090534.94429-1-jiahao.kernel@gmail.com>
 <20251027120211.GB33@bytedance>
 <b2adb9ec-b4e3-4744-afee-8b93f2185837@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2adb9ec-b4e3-4744-afee-8b93f2185837@amd.com>

On Tue, Oct 28, 2025 at 08:33:15AM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 10/27/2025 5:32 PM, Aaron Lu wrote:
> > On Mon, Oct 27, 2025 at 05:05:34PM +0800, Hao Jia wrote:
> >> @@ -6403,7 +6407,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >>   * expired/exceeded, otherwise it may be allowed to steal additional ticks of
> >>   * runtime as update_curr() throttling can not trigger until it's on-rq.
> >>   */
> >> -static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
> >> +static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags)
> >>  {
> >>  	if (!cfs_bandwidth_used())
> >>  		return;
> >> @@ -6418,6 +6422,13 @@ static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
> >>  
> >>  	/* update runtime allocation */
> >>  	account_cfs_rq_runtime(cfs_rq, 0);
> >> +	/*
> >> +	 * Do not attempt to throttle on the cfs_rq unthrottle path.
> >> +	 * and it must be placed after account_cfs_rq_runtime() to
> >> +	 * prevent a possible missed start of the bandwidth timer.
> > 
> > Hi Prateek and Hao,
> > 
> > Does it matter to start the bw timer? If no cfs_rq gets throttled, the
> > timer doesn't look that useful.
> 
> Ack! But if we've reached here with ENQUEUE_THROTTLE set, we are in fact
> trying to enqueue a task during unthrottling and we only start the timer
> if we don't have any bandwidth since __account_cfs_rq_runtime() would bail
> out if "cfs_rq->runtime_remaining > 0"
> > Also, account_cfs_rq_runtime() calls
> > assign_cfs_rq_runtime() and if assign failed, it will do resched_curr()
> > but since we do not throttle cfs_rq here, that resched would be useless.
> 
> resched only happens if "cfs_rq->curr" is set andcheck_enqueue_throttle() already bails out if "cfs_rq->curr" is set so
> the resched is avoided.

Right, sorry I missed that.

