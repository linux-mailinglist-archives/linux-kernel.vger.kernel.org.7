Return-Path: <linux-kernel+bounces-867396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB6BC027C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 986AD4F6D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39B262D14;
	Thu, 23 Oct 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev6IOi9f"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E044D8CE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237948; cv=none; b=nKCDhnGgVl1XZE2Dq2G0Lyp6GQzAdcXZZ1nTGy0JF0ptYBatUcETK9gyS1rNeAs7MQyPnoDxd3pVOFGomRYzeSvNGyxastiK2Kuq6KGqJ+RKmRu5G2NkZV5JCvCuMd58I2hzq7aVgatbCoF0XhigFbywOiIDEFp62iM5/tO/zh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237948; c=relaxed/simple;
	bh=zmtdx/gvSgP7Ui9FQG348+xx7lk0NXvyNMRcV5dmqbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI0yjEoTPl8hgAmTiXtrUoexHqUiR9wz85QdV+eAj+A9UiHcRDUSSEAJ0uxNVBsHWOrVFfX+Y6AwkFtzA5nHTHyFKwgnmBbX5vSYNFFds5obY9gz+ZIRSOOwWe58WAoGDKfYAVk7KK3lvIWku85/ed+GC3qlHHvP4o3Ps0vGxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev6IOi9f; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-890cc9b6bbbso135365785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761237945; x=1761842745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hVUMRr8F8Syx+/SpzR0LKkBYTLcd+wi4cHIxcJpGM1M=;
        b=Ev6IOi9fPvU6aW/5I0MjrmsIuyXq/giux6BQRrmrvCuqlJKmy6x7CtFaN0+NhZpazc
         0hY4SFsoZfrqX89v4W9y+Wjh9pZiRtot5t0Qv8xH7tjqzueF8JjkvcrL+2OOjEGnpdi5
         Cax+3YaS2vLn1BB3lS9T+ZPXUDN9MO6MW6SBmga0mvWbl22OSg0uXLsqv0PWlAlOIrIz
         0FGsdVffNt63C/ItMMnKFZbM1tinspSbdHwVRL4KsHb7dIl12dw72qnN0kSnjSnub0Se
         if3xaJwYzYYUR4Z7Svvr6oK5g25G5NytJ+oD3bOe8cUog9yXLtbuxMuOEv5c2au3qbMM
         xshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237945; x=1761842745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVUMRr8F8Syx+/SpzR0LKkBYTLcd+wi4cHIxcJpGM1M=;
        b=VlPQjMkatKEblfJe+wB7JgPQMlr/xJVNMCM9qFhifiDR8HMsZJF95mSWohvulKD+WX
         psMAEm0Mfqd5DbWMsqWNcMeSZYN4v3pywkyZRxY9zC2nAaP+zDXt2ru3SVu1na6pApXY
         drW+20LerIAOTKU/RqKjUsrGBOaQGPfPso9hCofHwpzzzn3Fx0fDMtZ4vcMFPOg1jNko
         7ay0H+Irlm52rqhC1aNib7QH5PgCkW6Oiszi+/CDzS93ZJmQyzik5+LMOBcg3NPM66ah
         ih85orbkQ7FRIYP1Wv1tIx7cEPJSlOwOHFwSsh4ZXiAIlLR8l+el/Sk4Xjyb3sIzQdsQ
         BxaQ==
X-Gm-Message-State: AOJu0Yyc2+xlmU151iXXZdaUasvgqPgPSCyWbRUwETlN7XleVPlfKj8B
	NMmNRmLFS06iBOL8CKPNew76lCgZ0SdGmXdZdavkuZL683EXmjBzrGjo
X-Gm-Gg: ASbGnctJ/QponEQ4cuZJHPflSTpR4APu4gyA9UWN5+Tj286TnfDLUjJ6oaS+j78WQCQ
	X8vpCo4pu/lYhcIpFwVQ9t8pwmiwnjTd0dE7NZW/8IUuSPbAmHnW3wTUvjJ1wVr7WrWFiykKVgF
	Z+oZFOqfwT8IapCvk1/z+4IFLC7lKehG5a2aA8x+cJDDWvA6AvN4vd8G6FuxgR/llRIhSkFtqxF
	dUihilA9hNcIx7m0p+lgX9Z9Slve+edONm4HoeejloBeCQ/EJF51s0frmYMUsD6yWGildT4iQc9
	e7+Kho0eSke3pljDIiv/szjL6WGoCSTDGLvejMD8az5aplC6j9uQByuBel43/lhGLlKCUn0GyM7
	+swfdvP6vugtyyAt2mKtC7N3llezOCTSTJJf5MFO+v1rF4ixjfhe/1x83xQoWbLpP33L8AYnt6f
	mbaKsirSs=
X-Google-Smtp-Source: AGHT+IGINX6g3FWPo0V3yrHvsvpJFGhTYw+6ONKZxAE9/LeQP30rl0qPrZbEPNWsdNzahSmACi3/MA==
X-Received: by 2002:a05:622a:3cc:b0:4e8:9cd2:4992 with SMTP id d75a77b69052e-4e89d1d9f0fmr323913681cf.16.1761237945338;
        Thu, 23 Oct 2025 09:45:45 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eb8062dc5csm18161071cf.11.2025.10.23.09.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:45:44 -0700 (PDT)
Date: Thu, 23 Oct 2025 12:45:43 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>
Subject: Re: [patch V2 08/20] sched/mmcid: Use cpumask_or_and_calc_weight()
Message-ID: <aPpbtwgzeeZzFh7S@yury>
References: <20251022104005.907410538@linutronix.de>
 <20251022110555.901055185@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022110555.901055185@linutronix.de>

On Wed, Oct 22, 2025 at 02:55:29PM +0200, Thomas Gleixner wrote:
> Use cpumask_or_and_calc_weight() instead of cpumask_or() and
> cpumask_weight() on the result, which walks the same bitmap twice.

On the previous round you've reported 10-20% performance improvement.
Can you post the numbers in the commit message?
 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/sched/core.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10375,6 +10375,7 @@ void call_trace_sched_update_nr_running(
>  static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
>  {
>  	struct cpumask *mm_allowed;
> +	unsigned int weight;
>  
>  	if (!mm)
>  		return;
> @@ -10385,8 +10386,8 @@ static inline void mm_update_cpus_allowe
>  	 */
>  	guard(raw_spinlock)(&mm->mm_cid.lock);
>  	mm_allowed = mm_cpus_allowed(mm);
> -	cpumask_or(mm_allowed, mm_allowed, affmsk);
> -	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
> +	weight = cpumask_or_and_calc_weight(mm_allowed, mm_allowed, affmsk);
> +	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
>  }
>  
>  void sched_mm_cid_exit_signals(struct task_struct *t)

