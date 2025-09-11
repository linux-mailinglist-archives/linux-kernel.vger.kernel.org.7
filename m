Return-Path: <linux-kernel+bounces-812028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAA1B531E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB2204E282D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A1320A0B;
	Thu, 11 Sep 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Np7S3seO"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F732039A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592987; cv=none; b=Bq0MYfvUbkz3Oqtvdg3GrKTdaPms40QrNewcUFN1+tTEjLDKTaxiiDLPWmoWQ9yADdpicO1tWa4kyxHr0ab/ZnizvEbnhzSHaXn2AdMQQyfifQF0SThvSQOx0/wihPCfIK3+sZqDCL4Au/URNOSO45+oh9LQSZ2bY2wIEImiK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592987; c=relaxed/simple;
	bh=Nkk0sxE8BH3+yB4o5Mu+OIN5OlgmUX2qaTVlrbO/VW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU1RqFbOf4Yta9S630BRDig3Vmj6qBhlghEW02ef7UnhifT+zS+eK1huxSWlFyI7M8666OuvACgLcjGWJ4ewJiyHtRehO9M5Ppxxe6wyvSzAx0Q+aMfmlU5uzmUQA0DPRzxe8aLlcR7HJ2ElMgF+n4NvTkfzLkI1XAXm0Y2vNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Np7S3seO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32dc4faa0d7so528925a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757592985; x=1758197785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7e0REf7inJfYaWh9eYV/puVKMCe0iLwN9bZeS5FZpsM=;
        b=Np7S3seORPsfnOuwUyuIkH0bcP4yDtBpv5gpsG0fJj/YNf4vrZBivWVZtpv5MU+sEq
         sv7IoEETYZk26G+L5q+UfA31x7jxlpfZVr61z/topCIOFXw/X+x8tTmSY0mIHVnfyObJ
         BVLkhn7mPDePQ1yGo/h/algBTdPZSj1mfcJfCd93aF6Do1uA8B4IUHraubH0WryoyUUl
         uMBXWHa6W0PBu4omHAne25ReBtuIJ619/NaLS9c8SvoqEAH8Y0kLy2faUphI+6XvKgZx
         8gjazyGrNzHy8oKjkAbH5XB3P+/7aZHJ5pf3E65BsNiDLZtInocJyChpctxkr8pwU93x
         85AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757592985; x=1758197785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e0REf7inJfYaWh9eYV/puVKMCe0iLwN9bZeS5FZpsM=;
        b=dp6GVHPsS6h5ZAnxsvhqwNqhMMg7V2AJsIfaMFA8QH5mhB6tdXM5G0BVshkknreA+E
         naav663lJu4TE/cFzaozKCq3nceXoHKtlZVdfKTe8ufDAdBLYlWtt9r+Ax/XhlagWSSZ
         8fDn4CEkGWoPVvXpmty/E0Pn0QbWMZQ9UEKIDIqyjwXjwORE3y8CF2GxfjHkdzYB3piB
         LfYnuobwx9KWkpTL7yl8mY0pJ6VmI/U3scRQOhh3sJW6kx0SUYvPi7d2v5IVFr4cWXLL
         OoG0IlknRpVhKIjD7Lgz2VK8H14ZS9fKqBLM4cP16K+4QAgCUJRCp5EqJor4N65u+WWH
         +uww==
X-Forwarded-Encrypted: i=1; AJvYcCXQvrA1G6p1iI1kNn3EaTDTruMyS4GXBBUsgqgC43ZLrhhnW4H8MRyGJWXE+aemB0pIrQrGrjDMeobs3m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz394lIv+6oATXWBaU5AyamYhttdF9bWXN2Fe+bYx2LXwfFJpbo
	K0qVVGsAg7sP4tERZMZyQ5OK+XbcDw3ZtM0Hh2iQPHre/4Q/hF7+aQ2NTFA1MHzMqA==
X-Gm-Gg: ASbGnctxaarl0oIAi9ebXr1jgZi57U9HSC6j+hwLlCY16hHLlW3ext+1J+WK9QfJu/c
	ZXYm45/BCrOTV10tVej2zcGRQ7GmVcGEBJVlCjy+niRbkg3ur6aKQ+Uk81WmsZ0ELDhIYBboT0p
	2dsVKaX0T7MSLwePXkhnEdZbNS3MtJcX4DQZUGtWvS2ipa/CGaM5BLi6psk++lqRmd6odHVhPfa
	8aTciMR1CeUPTWBYgvwyTb7dpo2NMbo9SLannaIfqgUpD7IK/lNPAg6ev3iJ6k2A5ma/KUD3VZY
	15T+hRBNfiHdLuvCtzipEZ4Z9DL8WU5soeSBnhgQHLm16IS9ddC3dDHVu8KxdMfBe5to1G2DkdR
	nFAXuX+5zdc5WGSOH9Ue4eQVijHllcNrBlZjEhqVAb/OQ5OfXaDnnd1YEOX/C
X-Google-Smtp-Source: AGHT+IEJ++6azul+0fpB335kCHq+dCL8m91X5KX086O/e7QcizUiDyCMF/q+GjVyJV/vZEt0qWgMow==
X-Received: by 2002:a17:90b:1641:b0:32d:a670:bd3e with SMTP id 98e67ed59e1d1-32da670d6d2mr11898180a91.29.1757592985018;
        Thu, 11 Sep 2025 05:16:25 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd621c790sm2549296a91.11.2025.09.11.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:16:24 -0700 (PDT)
Date: Thu, 11 Sep 2025 20:16:01 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
Subject: Re: [PATCH 0/4] Task based throttle follow ups
Message-ID: <20250911121601.GA36@bytedance>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
 <20250911104222.GY3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911104222.GY3289052@noisy.programming.kicks-ass.net>

On Thu, Sep 11, 2025 at 12:42:22PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 10, 2025 at 05:50:40PM +0800, Aaron Lu wrote:
> 
> > Aaron Lu (4):
> >   sched/fair: Propagate load for throttled cfs_rq
> >   sched/fair: update_cfs_group() for throttled cfs_rqs
> >   sched/fair: Do not special case tasks in throttled hierarchy
> 
> I stuffed these first 3 into queue/sched/core, leaving this one:
> 
> >   sched/fair: Do not balance task to a throttled cfs_rq
> 
> on the table, because the robot already hated on it.

Should have followed Prateek's suggestion to put it behind
CONFIG_CFS_BANDWIDTH. Will fix that and send an updated version later,
thanks.

