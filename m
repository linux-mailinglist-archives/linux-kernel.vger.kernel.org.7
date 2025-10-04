Return-Path: <linux-kernel+bounces-841979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69343BB8B4D
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 10:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927654A00EF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB66246BD7;
	Sat,  4 Oct 2025 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9gzqenE"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4118FDAF
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759566957; cv=none; b=DQEuqhA6AnNs9eY+Zqj8oEn4Feer0qMnApQ4HSPYCWXcbXxnSd8uN0EDHhtZyRAS3XG3u5xzJbzIWIOM5LgM8a+Iuezus3imL75/W3OBu8NlGNaKBoiuwKTNRtpjef17hNHf17yjPPIw4qpTmuFCNEikVgqhgq8YY2R94K+Yrbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759566957; c=relaxed/simple;
	bh=JsQqE9p1BnSsmmi8AuDK+KSrAV78o80Mh5hwa3pmkBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nUVj3N+AkUTIoU1wiOHLmVkS3k/5FrNKVFz0hoCAkuBfB0dZQNrkRPVp7SeUq5X7aL3fLIlC+zvD6kJGUhzAz5WYIZHavC/O41DRW0bxSl3UONwVJUjROEQ4y0+4Otvq5SA+BJ5vaCQ/vOdQID3rrPX56H9vteVlQxr59h5pYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9gzqenE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so33861265e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759566952; x=1760171752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SAZP7F4LpAyeiWuUVfM9K9SMysgSblKGV29vPTVd7ME=;
        b=O9gzqenEkTa+j1dpa+3eP0IZbvPDo8W7UNh1hmvhLyNcN6EioxisQSBZYhLgFUVAgX
         AXVYwxOn4pr4gYpBfzYwQxykivVjRFLVp9vrY+jpFoOtfEB7AtWwsg9Z/apg0BJFJVc4
         5GDD/43/hf/M1VcELu51Yf6HaMT217x11sMf8JWPGFD9SnOlcqFBOKKdz625EwGGcsOq
         pIS75zAcJP6vdOmdTnZQ0k8HPxl1i4OBLsZjP3rkENDXHI/bdG4WcrGaLUWAlywCxeqB
         SOtO0BPtn35IixOJoLj9S/9nsELsuLCX2oZ0ihy/89E7lDZayRKDyRzvHkl2mMKZPwTr
         gJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759566952; x=1760171752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAZP7F4LpAyeiWuUVfM9K9SMysgSblKGV29vPTVd7ME=;
        b=vgKivJGsVQz5KGg55Wj9/AqPweXMN/K3aLKpD5LNChPdgVXiuy3J3WhRNozT3xKCrq
         ZX8NdkBuYr25S+xU6MY8DI3n0T2dGzb7mOtAZPLKRtOSQojp/Zl1a4+4ZXOMYMFVkY89
         UJKG+1o7ZZQyZdGIH5fDrNSZaNwgsr6Q2QWKyrFv1s5OeDe4cJqqhk9Lv+Ju8Ll3jLao
         q2F8aWnkbv9eZYgJA5fOFzYbaTx1WS68U/aKHCuXkAD7hWo9E54KtQ356fPEzLxxyGQK
         OTJgHwV+c8DZZOGD9aqoA/otGuIPwkSOBj19TIOOANhKpH2MjUgYd9JvKiyDQ2bWTfv8
         7N/A==
X-Forwarded-Encrypted: i=1; AJvYcCW+Rjv610M7tmBtxq8kdHGq/f0no0fYPtqE24/F7gvBcd2WcQ02u27GQCAsJ/8GaJX4tg1LPLX0yNS2PzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAUsmnHPWuXUe2qXrLU0FHRQqo0HkY64IAIW50I41osPNdYUH
	TycVnbg8ABZq/T/6BQpuTN8Dnx9rxPOyoE3bPcLvf9kI5MKV5u2G3rWt9tYAEkYvywM=
X-Gm-Gg: ASbGnctVPnvjS/btJvUEqsmh+0pIX4uhMTbuo4MJwYOfvnVq4uUYJGY5/gO5w5/YZeO
	sCIU18pLQb7J9tBe4/ZtW0QF6vT9m0W9WrX7/JIC3KI5j/IQO3vWTT4qa/WC6tgHgjyEnaDIxAN
	WppfKqxvy8tDj5TNGTDCNK6jgkk1nt02XAyyMqtBl0+o+733NdSTrEnOzf1K0F+UB/8/6TcHq8f
	Renz2FwQpwuSSaiEbSz/AJwSVA+ndIgndbw3XTWBZkFJUWP5XGFZGJQjUdPvm9aMX9qhTDeFGvP
	iFwYJSM5FRlt1JxTL5YL1QtgUZsM1+53mIOe8VrhNlUKRhQpNG2lf5L1XoTk/Ik6oHtSPkGYi6n
	37J9pZ/LqLtJeboOs2zNnSOyniviXyc0TkO2VHxSKpT8CtW6BE0GAP8b5xhXsl3pWx7U=
X-Google-Smtp-Source: AGHT+IGa6E+3wJm7+c+5/woLvErvO0WuhjoiRpVAjW0z69Cszk2FpgixLHJeZ82h4IS7E9Toa0IMxQ==
X-Received: by 2002:a05:600c:8b6e:b0:46e:4499:ba30 with SMTP id 5b1f17b1804b1-46e71153ad0mr42510465e9.30.1759566952004;
        Sat, 04 Oct 2025 01:35:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e723614c9sm63490555e9.14.2025.10.04.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 01:35:51 -0700 (PDT)
Date: Sat, 4 Oct 2025 11:35:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Subject: Re: [PATCH] sched: drop unused variable cpumask in mm_cid_get()
Message-ID: <202510041546.DvhFLp2x-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002-sched-w1-v1-1-a6fdf549d179@linaro.org>

Hi André,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Draszik/sched-drop-unused-variable-cpumask-in-mm_cid_get/20251002-192448
base:   3b9b1f8df454caa453c7fb07689064edb2eda90a
patch link:    https://lore.kernel.org/r/20251002-sched-w1-v1-1-a6fdf549d179%40linaro.org
patch subject: [PATCH] sched: drop unused variable cpumask in mm_cid_get()
config: i386-randconfig-141-20251004 (https://download.01.org/0day-ci/archive/20251004/202510041546.DvhFLp2x-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510041546.DvhFLp2x-lkp@intel.com/

smatch warnings:
kernel/sched/sched.h:3810 switch_mm_cid() error: we previously assumed 'next->mm' could be null (see line 3772)

vim +3810 kernel/sched/sched.h

223baf9d17f25e Mathieu Desnoyers 2023-04-20  3762  static inline void switch_mm_cid(struct rq *rq,
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3763  				 struct task_struct *prev,
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3764  				 struct task_struct *next)
af7f588d8f7355 Mathieu Desnoyers 2022-11-22  3765  {
af7f588d8f7355 Mathieu Desnoyers 2022-11-22  3766  	/*
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3767  	 * Provide a memory barrier between rq->curr store and load of
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3768  	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3769  	 *
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3770  	 * Should be adapted if context_switch() is modified.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3771  	 */
223baf9d17f25e Mathieu Desnoyers 2023-04-20 @3772  	if (!next->mm) {                                // to kernel

Can ->mm_cid_active be true when next->mm is false?  I don't know.
If so then it's fine.  I suspect it's fine...

223baf9d17f25e Mathieu Desnoyers 2023-04-20  3773  		/*
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3774  		 * user -> kernel transition does not guarantee a barrier, but
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3775  		 * we can use the fact that it performs an atomic operation in
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3776  		 * mmgrab().
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3777  		 */
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3778  		if (prev->mm)                           // from user
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3779  			smp_mb__after_mmgrab();
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3780  		/*
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3781  		 * kernel -> kernel transition does not change rq->curr->mm
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3782  		 * state. It stays NULL.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3783  		 */
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3784  	} else {                                        // to user
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3785  		/*
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3786  		 * kernel -> user transition does not provide a barrier
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3787  		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3788  		 * Provide it here.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3789  		 */
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3790  		if (!prev->mm) {                        // from kernel
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3791  			smp_mb();
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3792  		} else {				// from user
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3793  			/*
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3794  			 * user->user transition relies on an implicit
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3795  			 * memory barrier in switch_mm() when
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3796  			 * current->mm changes. If the architecture
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3797  			 * switch_mm() does not have an implicit memory
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3798  			 * barrier, it is emitted here.  If current->mm
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3799  			 * is unchanged, no barrier is needed.
af7f588d8f7355 Mathieu Desnoyers 2022-11-22  3800  			 */
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3801  			smp_mb__after_switch_mm();
fe90f3967bdb3e Mathieu Desnoyers 2024-04-15  3802  		}
af7f588d8f7355 Mathieu Desnoyers 2022-11-22  3803  	}
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3804  	if (prev->mm_cid_active) {
223baf9d17f25e Mathieu Desnoyers 2023-04-20  3805  		mm_cid_snapshot_time(rq, prev->mm);

Same thing for "prev->mm".

223baf9d17f25e Mathieu Desnoyers 2023-04-20  3806  		mm_cid_put_lazy(prev);
af7f588d8f7355 Mathieu Desnoyers 2022-11-22  3807  		prev->mm_cid = -1;
af7f588d8f7355 Mathieu Desnoyers 2022-11-22  3808  	}
af7f588d8f7355 Mathieu Desnoyers 2022-11-22  3809  	if (next->mm_cid_active)
7e019dcc470f27 Mathieu Desnoyers 2024-10-09 @3810  		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next, next->mm);
                                                                                                                        ^^^^^^^^
Unchecked dereference.

af7f588d8f7355 Mathieu Desnoyers 2022-11-22  3811  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


