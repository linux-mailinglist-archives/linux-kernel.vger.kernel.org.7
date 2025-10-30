Return-Path: <linux-kernel+bounces-877713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F0C1ED62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C51240147F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972CF1B87C9;
	Thu, 30 Oct 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ilXTkkZ/"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C317AE11
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810345; cv=none; b=FaeewI0w3bfF9ASkd73k5vi3L2YeoNNXNqS+ySywpm73Q9UNbTo4u2OBuDgRJ8KY97nDPiDRpWLS2c23BxrtDjgunuZThpM/uU1udJf4oR5OofHaKRG/3letDPPqD4gaIPb5devYxLnWn1UKj9w6v084NlKj3RXyDT7eKoZlkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810345; c=relaxed/simple;
	bh=9RXaC5kKVtR+Y+nfucEY0BNugM2y1HON4AevU+VGkjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv/3ZQ1xsS5ZyHb58uEQ69RVRFirxJzE/4zx1Sn+E6GAR6fFtvUfgfpDHzvP4EaJn0gjTOdC9mxBvy89ze1jXkstQYwu/G6V5kQuk2yJbbgtmnwubNkLCMnHQp/NJgzmTzMNQtxQpcxCZQ74wcAEGzmVgwMPAWu86VaACylFcbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ilXTkkZ/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso511469a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761810343; x=1762415143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SklV0/WLGV1WzornS2Q98CAJPfdOVpuXVr5+HbXWuY=;
        b=ilXTkkZ/12ymzlkIN1+tabv1lfkYvqyLRfEg+klNqVKYeuNlSk3EptPGL3R3/Wvnh3
         V9y/tc5IoL3llAD4rvSHrL2bimKoWCeQdO2mJnIeArIqQ8V8lpP/bcV/lHXmHXthHV9W
         SWp1jfjxfOK2I56xnNdrzmwaEYMdhA0LbU2ostlifYYEqGD7ygCrpaor9ecVyNGi2Dzo
         xEj4z/sOZotLwGujk6YtzN1ItiGFQbQSPaVu7Eha3ZhjcybBmPLwj4kXZ4GKztHFE1JW
         mjSxqgNbAD7NSYwVD8MgbiCZJkJdUReYb9O4KKYeajTAzsUyXQkxDW13Y8WPVLBpFK5s
         daKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761810343; x=1762415143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SklV0/WLGV1WzornS2Q98CAJPfdOVpuXVr5+HbXWuY=;
        b=sUwB23rSPu6FYDGCqbVrIG29RKAWGTce6S8pDmqROlJlMlNO8ZTkZd8dsUyJFvyisz
         iInWO0Ra2Ypw/begkaODF/HICHx6rM0JG2LnQBhuaLaRjX+1UZx9TIIePRJzUd8Pyajc
         CFtv9kJgQWU08eDQDhRmKrfqPkBhnOhmaBeCSsQ/4owAgLaRupKNKqvAbzK9hpvFM2ga
         fGmdlP7R4GgCs/SBYt3wuGNySBaFL0ASp3JNlr4c2MNqAjzQuTB6KhHdLz9tUu7iEbN6
         uqbaCx+a1/Chnys7LfwKGPur+Z4Di4je3ayKCOLcMOM9b7mU7VYG2A+BA0CYJCq05tZ5
         weXw==
X-Forwarded-Encrypted: i=1; AJvYcCVsqTRgD7bFiCsvj1271QzeZ9hme0Zk5p60AyS6eOLG14/gSNaweHmAcbFqmbOxmNI65MnjSsRdtsGwpIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPiXAI5d7ZWjmRVWKcH+KZu9EUZ9uG3tG/15fRf5I5XgWHXyP
	Ze8/vHwGhO7YuSS8lIyLp+hDQg+kNeR1FAe9ciGpd9GYgLtTFxv/J9pQkWGRdlHRrg==
X-Gm-Gg: ASbGncudr7n6+NnAQ+r7s8vDQWMnXKcrUC6CYucsY1028O3G1FeaKisRZaHe/03RRxi
	1FWT74p5jWrdLVY8rvNU4JV0AEoA8aA4tsSI9OmxDG/uJMWYL63JyugUQGxzHvsll3ZAv67W2Y3
	scnU160OR21SlyvBtDAjueq2UWqBKnljMLhPxoPbV4IJwAz0wwA3OCpcIIWpgXj0MtwIhZpBPaf
	qLvdWRmj4ne6EqMcmhaMN31VI3RqKNvNHw6qtu0TWPwvnRHadfM29twS6orBMgulzP5h2cQ+EIT
	ZNAy3HWhO4Qp4vwjFwCZX1QXCKNtSgm7DsdL1KbvQ+QGtUXhN8vbCoNDEamDxeBagj4LyR3OfxW
	3gXjqX06/0QxtevCPbXbHwnCytNK1oRG6bTSNI2jlEfC4mJ2u9mgBIpIKjwFrn+xdzQ+NsC9Ka6
	S8ZBTvFJ5Dty2w0f9na3Xf
X-Google-Smtp-Source: AGHT+IEbUF37lkb5ozNwDNxd1qB2BtXGZcvMrtCKLeg4O/l5G4d19jVQ4m7J2flpeskNyTQMRfuDcQ==
X-Received: by 2002:a17:902:ec8a:b0:235:ed02:288b with SMTP id d9443c01a7336-294deea95b8mr73321935ad.30.1761810342687;
        Thu, 30 Oct 2025 00:45:42 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2789bsm174180895ad.62.2025.10.30.00.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:45:42 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:45:19 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
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
Subject: Re: [PATCH v3] sched/fair: Prevent cfs_rq from being unthrottled
 with zero runtime_remaining
Message-ID: <20251030074519.GA47@bytedance>
References: <20251030032755.560-1-ziqianlu@bytedance.com>
 <be55df62-83ac-0605-48e9-7346fb4cb113@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be55df62-83ac-0605-48e9-7346fb4cb113@gmail.com>

On Thu, Oct 30, 2025 at 02:51:02PM +0800, Hao Jia wrote:
> It worked well in my test cases, and the non-empty throttled_limbo_list
> warning no longer appeared.
> 
> Tested-by: Hao Jia <jiahao1@lixiang.com>

Thanks Hao, it's great to get your confirm that this also works for
your case.

