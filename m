Return-Path: <linux-kernel+bounces-892892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D977C460D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FDB188B011
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB69D305E27;
	Mon, 10 Nov 2025 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ah5RHcia"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F9212550
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771797; cv=none; b=dmRZUNUNeQM5riJcAM0/92mXupYxT2ZUpv9ZTAff0mlvqW0N0uCb9CRrZx1EeFBPYvrN3kEO262uN9aeSIVEtdW3mePRfG+aoFVU7JH0nPexFcKgx6rAq59i4Au4gz9TjkWfUFGxneemEHA2BAcIfpMMH2x9gr261wnsrUNmWOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771797; c=relaxed/simple;
	bh=xU8sY/U+Epx6hzvm3hj005tB6987LtJ6SFDdcl10XMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SARUXD7cnx83k6ByY7WVdGccEjq8AIHT2QRijnuYV9WOoXp/6Wc2Xo78Y+PvybwZ3XWrQEscXEa8s0wv3ShyMDrcLlgDZusCZjeu0w05BLr5awxXyxU4hhvaUItIi5zaNJZVjYQBy+6l0cOGnFMiyeCK5J/j30xteHzEyzfITbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ah5RHcia; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b98a619f020so2536184a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762771795; x=1763376595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lDeRZdyYag4vENzRo1TPNmjEaRs7VZvYUM0bgVV1nn0=;
        b=ah5RHciatagk9ieZy3rDKP94q0y6TzWYXWC6Qm9tT7OCveuxMncgPdsZ+1bg6/HHCi
         nIlOdvLn+4E7daZXIL+lR8Op7fKvtr/ibeBana9wzrcKSHfcpenc8yIW8TapuD3Mvrxb
         RA9qiPJ0mbut1d9pzMCKeOQ9gMC+1bDNocd/LSlPR2E3k3eYqEiBF2x9XvYw0tJ8St3S
         6Jf/qJnJycO0FUJxiKhMiRzS7omXZ8/2GXuEADppV/ai9Tti1H/GMX9zvXG1Cn/OrgXP
         XNWge2oFgIB0uAMOlfDcPh/4tY3ayZNUQG9KbMSQvLH6g4jZb5C7PqtRYcNOEAO5NS8o
         NRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771795; x=1763376595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDeRZdyYag4vENzRo1TPNmjEaRs7VZvYUM0bgVV1nn0=;
        b=QCsl+moGrlRPH/FWOoZBr/battc+WfmXI7jpbbW9wfYHN+BQ3Z6BHwFq7U8W4NMsGX
         VGafTiaApImcj8UHY5AZI4WugB1YFPF+zku+qAUmTo9wnPxTZyqUB3D9NEepGh7u4zJH
         r/VWnyxrm4fm64wrEFyGXp2Q6TQUgpI9QmyjtxDEd1aPXUqQVJkRc4ZTtHKAFXRHmio0
         ZTKbl1+Hu9D8rrhDO9xfDivUdxnwZv9QvxIQkK34eQqBm1bFbuVLWhRAwbPDthoY2LTw
         PLgac5GsYOFDSeui4Oj4TlmpdA7xI1oZuXbyvMeZ+COkGkv8kErlqOowKRhcZmZdmpNS
         /Itg==
X-Gm-Message-State: AOJu0YwXJA2oOyvAmMTa0hqhLobtC/5q5ODzVccyJoqslag2fy5VES3l
	DR7UyPk33GCcg19ih1yVcPPgsfCPnR5ocF6MLto8OW73Yt0aTeSKPPuouV9Z85nqreQ=
X-Gm-Gg: ASbGncugg4r0QO/06ngkxfptJ5B4odrDhZw+otx3WOqSSMogbtbyWCpt4ozunsNTu8u
	Gc87z3B65N5JXzDTNM5R76Xh7Az2GtUQlydCLDZfrK0/ayCPhfsnXD6YnYoA4LsylFLie171fQ9
	zJwEodaZFxAYHxE0WhNwPETsfSnnz9WHP8hn9X0w6F38zfz2M9KaPTT9awrp5XwTe0sPcX+CUCF
	hgw83Myz+MBOgqWy8oOH5/3fINsuOCCBHaqYpaaCoCpj2dMEZBdzSNWcT/p3MWAJ78aviOkqs82
	fkCfK5DqKK8Qb7M1RaPGE/5dfJ5899f0/vNQSIajyByuxQ/wSQ+uLCK44btxXY4t2AsVCykW613
	XXkLhr6VkiDy+QultdAB+Am3qAAPAny//H2OCedW7Jf71QKLcuJnfJiSyq8fHBRkmAPu5bENR+l
	EQ
X-Google-Smtp-Source: AGHT+IEdNDr6Otbb2RROj5/vAfBaFYdws8NbdFblgDxxPFWLMhWpkRHK+/9t+JYyBm57B3EBrBmAnA==
X-Received: by 2002:a17:903:38cd:b0:297:dad8:f265 with SMTP id d9443c01a7336-297e53e7df9mr96877135ad.3.1762771794882;
        Mon, 10 Nov 2025 02:49:54 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968298sm144484165ad.6.2025.11.10.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:49:54 -0800 (PST)
Date: Mon, 10 Nov 2025 16:19:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] cpufreq: add WQ_PERCPU to alloc_workqueue users
Message-ID: <atnzuecdwp77svypw76e5z5occyh4tkswfc7rg4yqh4joeh7fn@ayygwyjdpe7x>
References: <20251106163341.336989-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106163341.336989-1-marco.crivellari@suse.com>


On 06-11-25, 17:33, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Updated subject to:

    cpufreq: tegra194: add WQ_PERCPU to alloc_workqueue users

Applied. Thanks.

-- 
viresh

