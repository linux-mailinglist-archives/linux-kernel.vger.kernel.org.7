Return-Path: <linux-kernel+bounces-733597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465CCB076C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D47758418C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF61A2C0B;
	Wed, 16 Jul 2025 13:20:09 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3619DFAB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672008; cv=none; b=e6Zc2s/RauzZlMPCZBhdYpJkwkzxGcVqPKiMd1xHZB1tyhmjVHjP0zI4NACflRkKJvT/ruq/OFtP0Gg74gFzzEyzpbT7X5zqiCDHuZvbpyStnHp9qPU2Oeakz64TIiW0XwlCR2vqucL4Mv0IK59DgJlb1wDOZNjChb7Xcqdun04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672008; c=relaxed/simple;
	bh=dACukwy5e1IqhOkQbEEgrKOgUKHKPKIzoOfLvmNuDO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNUE09clFmooQjowO/UXTrZuiF9trZ229pRMQXMLKVZks5kPOEn7UKWphZtdK+VLtQqiLWnG/O3sJBoZtvPgRynsPVnE8MJX3DBW5izMlqQ2wTUqsnx7mUmN2e1Lf4xA6WyVkVRW+4SUO8QefT2VDBTEyZyLtnlLNgn8bvrZq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so11007159a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752672005; x=1753276805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dACukwy5e1IqhOkQbEEgrKOgUKHKPKIzoOfLvmNuDO0=;
        b=pniNe7M8w2BhKoottQiJNk9tKxVHu3HQoa2UApMXIT8aSv8FNigill5IRo9+4YpftN
         wgMXf9wFpnhGKRlPuFnPqxtPOO08w1r7RkUB5BnbeU19PB6vUBOugeKXtdD5+hr+/x50
         3OSr61s8DJQkk1DY9f6HeHlZibeghgVrLsUu0UGjTQAvWQwHGIgaX4TVvKeKZWy76ccE
         AwuF6VTzgNKkNi4PrNJ5Nk0Pr2Q/mXZwxx3ApU5KnS7gYWwaBcTWINmWV7YD1AGDZP68
         Qa5fq2/hjZpm8Th7JMAIn6mWkxT7NYo7XpfVM2E/2WyZ8k9y/zdGGdCFDxGN0c3mjdin
         fYrg==
X-Forwarded-Encrypted: i=1; AJvYcCUYTvO/znAaRIITjvcWJxhloZB8Lg0DXNXavKVh9Wwypp1i89XWdYiyNiRmP5xlISYcYznSIvdsGqRppsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNWt5nb9kdlsT8bV5uaAZpPmGGsOjLvwsoQzW2jjd+eHt6QMj
	tqV5Y29sW/0hH7nyP5wjqolubLFQqYFIV3wHi7LYvAOjh7rq7XJMGOY2
X-Gm-Gg: ASbGnctENoAfNWfAmu/U+fATyDhBiebcjHNHO7lYfMBFuZPwPabhqFL/PGUMWeaVqqJ
	be8yLWUF0+kT6dPqPuuO4SMOmRREm9+aAr0tkDRtEPqk2PoI76ScjVdNQq4zDfWEjV7gQBb3gsw
	1EE73omHM7dMbb6qcr768yFuKfmIehWiW76RBTs0Q4PF8WsHsDamCDyt7wpeWalABg6kBBAZfpJ
	jQQNHJ5iPNF0R/Zu2Njj/p7CmWi9CrYIt7sMRb5fehpJcqsyQIzpESX/0jrsfNr26D4cPFFzIz0
	lCxMARTLJ1A7mIJFnGHkcZJiCoMMhUX+Mj4o9htf6Qlw/2jMP6M7l3M4bfVyFfCpQh6CNJjtjqa
	PbSyG499HYL5Hqere9opRYwlA
X-Google-Smtp-Source: AGHT+IEV7flreD6co6LNa/Ga66E039SwJUxLo0b9BC7zArsxmbJYOLWaq/Ncwd0UQVGLdGF5I1E+mQ==
X-Received: by 2002:a05:6402:3187:b0:601:ad95:ca6d with SMTP id 4fb4d7f45d1cf-6128595d9c3mr1968290a12.8.1752672005001;
        Wed, 16 Jul 2025 06:20:05 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611fe587b72sm6807251a12.70.2025.07.16.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:20:04 -0700 (PDT)
Date: Wed, 16 Jul 2025 06:20:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrea Righi <arighi@nvidia.com>, peterz@infradead.org
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <d2ocjfutd6o6euvjhln5tj4sdnmlblgpy2papponnumtu5slcx@tfc6y5webosm>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
 <aHel4LvT_Y5gpYfy@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHel4LvT_Y5gpYfy@gpd4>

Hello Peter,

On Wed, Jul 16, 2025 at 03:15:12PM +0200, Andrea Righi wrote:
> On Wed, Jul 16, 2025 at 02:51:28PM +0200, Peter Zijlstra wrote:
> > Also, I don't seem to have this scx_layered

This is a rust scheduler that could be found at
https://github.com/sched-ext/scx/tree/main/scheds/rust/scx_layered

Thanks for the review,
--breno

