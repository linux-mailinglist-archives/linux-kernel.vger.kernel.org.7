Return-Path: <linux-kernel+bounces-838844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC3BB0429
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87473B78BE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2E2E7F3A;
	Wed,  1 Oct 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EtOyDVxk"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCAE2E7F3E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319940; cv=none; b=SfBdNrmIF0e5Wx254LaqOkKM23KQMHghszcBkHLbKgJatkAM2QyTgQjoIm5UibJ+CEs8vURJiLykmuN9ZBCaOHDtJmu4Jx7cuBzywCZpDKPGVnRg5QSDtwSvw7KzgLQawhydrmoWTHJRFtP9G1eb7pDQGFzG3ZkItukt9Y+VNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319940; c=relaxed/simple;
	bh=NN5GgRIzCCi/hMERBMeR8ROhByBf62Xiy5LgeqicMs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFt1t052GgVLOwepnIEgbLN3/33N+Hufg41QJT96xuFo4Yj3MqBkKPmwDmsfe7iSWrc5le4TGIz8NWnD6mxFxVzkkSYc4FA6M44o21qqN+4raCmpQExuCUHIb8XO8VlyARGiSykBiuJTZPe8UbJ3yBDkh55GNkKdu1tR63ayiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EtOyDVxk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-330469eb750so8298757a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759319937; x=1759924737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=92Qglsz/Eya8BRF97YA+VHR4I83RleB9lL6/yCypHW8=;
        b=EtOyDVxkDmGpPHMhNMtCS0WX0DvJmBIOPX2xb7iUHokwa71hwLb4uqG9mWbGBePQvr
         DyWpOEqVxPNYp1cwpgPGNz7TgQjkY99MyVhcT+zijJ1bGaUnnxPZnHs5rXnhngYOivSt
         /TFH0t8gS4oqGVRVLxjGULXXFiDHRsQ47aQFAkuvZ8D/zl95NK2zMlgR25StOVFEnq9M
         cLCl9rO2yPM+O1q7snOP7/W/TbwZ0ORZeMUOCmFJSI3meRXW3kSQIeyshYO18a+DFqy7
         tMFtPG9X6gA2VKjKLnt7cMxLYI60up+RNrP9AuJyzg/Mb+JY8e+TEwEohSXrNELEQOwN
         afPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759319937; x=1759924737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92Qglsz/Eya8BRF97YA+VHR4I83RleB9lL6/yCypHW8=;
        b=vjj8nYmLvEu+R/tFfdY2iTNvfpHDq3iik6EfNYjMo4vxVpLTtaVlH5NmJ4ahqLLWyf
         qrcSgU7m/i21c2rMq4/ep69Fo/o1pu5WFDkVnQp3+pNqQS4W4H7HnmjLWZx5GgAZ0xkY
         qba/zNn+jdhP116Gsaiyxwxu+DZwgSd4aLABEXComMMbqBN+ZMWm1AmhSwVWQZJekI4D
         KtbzpdHn54HJuKgZc8ZwWh8y1jun6ZSxWYADNqZfed4SumV3rIwsNBl1jN5AYCeyqeBp
         KILwbP19qE6bTI4pxWqEh6gdk/h4j6BmsKPfSmowuSt3YhE9zICO8Y/fKqwhw0DAvW05
         HlwA==
X-Forwarded-Encrypted: i=1; AJvYcCVrjbN1F/u41nWVP+xWz8x1CHk+lkzEX4iij7XoshqVWOxoDIJJCgj7hkcEeXbwrRRzAK8DqEtRoApPZGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4hmGrbT+yDOrgfMZ818THOrZJYP7FCY1IbNEa5fQO37KRhah
	iDk/W9Jzxy6MvyJZlXDJ5qoEI+j8X0M7100gx8hRdUJAjdHr+IpGFaSWuVZoxr14Yw==
X-Gm-Gg: ASbGncuFFeLi8NYETJ9maLJ+XbchMFShMgihFkcOBTk/Bd+5LaZ56vA0Kth3mL/RsW5
	uO4J9Gsl0m1/thvZitbqR6PF9MwNGfQOXjR3TXE4AfWaYRDq1fGF2Vk7MMtp+adlYTmA4Jz6XNW
	N+YyKbvEoOyrAcb6bufFvbBjMKGEH97DAyaNy1mpcLBDImNqTsYbUWBgigc5sjB9+hJlWV6+6pz
	1Ihfz9A9tkj7JffXDqo914AA5h0C5psY7/OMtt0ECX4l6l3+wa8AugwKijjgdeT5GwJdv2E/vo9
	ZvLeDD78Kkncaut8wDCDaHUOiEJwEjGRhhVoUs+qnNtzEp1JwvHtq1Oyhynw4GGZze4dYAFTe9g
	6QvSaalJbGQPH/9Z8ht/qYBM+pxnvzhXfTj0Nqv5cd29ce8PJYTw=
X-Google-Smtp-Source: AGHT+IEkaLSylOZc5E7F3SXLckvWF+pTKi0KPQUlgdWEILUjfaUWCRhrpGbzZev8BbY9O4wUVAVUFw==
X-Received: by 2002:a17:90b:3812:b0:335:2a00:6842 with SMTP id 98e67ed59e1d1-339a6f6aec8mr3679616a91.26.1759319936967;
        Wed, 01 Oct 2025 04:58:56 -0700 (PDT)
Received: from bytedance ([38.181.81.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53db8d2sm15894243a12.24.2025.10.01.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:58:56 -0700 (PDT)
Date: Wed, 1 Oct 2025 19:58:42 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20251001115842.GA674@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>
 <20250930075602.GA510@bytedance>
 <658734b1-b02b-4e04-8479-ed17eb42c1f2@amd.com>
 <20250930110717.GC510@bytedance>
 <dc328049-b1e6-4558-bb9b-e2e1d186daeb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc328049-b1e6-4558-bb9b-e2e1d186daeb@amd.com>

On Tue, Sep 30, 2025 at 07:08:20PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> I'll merge the two replies in one.
> 
> On 9/30/2025 4:37 PM, Aaron Lu wrote:
> > So in my original patch, cfs_rqs will (most likely) start with
> > runtime_remaining == 1 and unthrottled after calling throttle_cfs_rq(),
> > which will also start the B/W timer. The timer is not needed in this
> > case when no cfs_rqs are actually throttled but it doesn't hurt. Looks
> > like everything is OK, we do not need to do any special handling in
> > enqueue_throttled_task(). Thoughts?
> 
> Now that I look at throttle_cfs_rq() properly, we'll only move the
> runtime_remaining from 0 to 1 so few usecs worth of bandwidth
> distributed at max should be okay. Sorry for the being overly cautious!

Never mind.

> 
> So your current approach should be good. Please feel free to include:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks!

