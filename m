Return-Path: <linux-kernel+bounces-733381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69604B073E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB37F189AFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864052C327F;
	Wed, 16 Jul 2025 10:47:45 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552472E36F4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662865; cv=none; b=iGGIz3KnrDKxZtCeetMv0uLyy8k/f/DjPdprqvU49C5SuK/LfUq39vZt/WGpaaviJoINr5B0fej6487cp95Lj/5Z9+Scwp/ZoGTW8yzxi90xxj13sdc+oMX2cZ0rvLyWhdrlnblGO75y6fm8icBFm2ntTebrtT5eYM3ccKRIlm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662865; c=relaxed/simple;
	bh=Bw893+tcIhNDuXhS4/X2kP4Sk7gyR15KSCtgEwihDgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/qSDFgSy3wLCWcZ51pqe0J3p+MMd5H/rDNGjZ2sgTtPrdzCmvgtIrspNCzmyTg38BCa1KSfPux9eencT51gOoFdtsOlqkZTsJmPovk1Ogei8vSzM9D0pSfvz8HpXhTqxZYN/P3zl1w/2L+pnjQ8h3EjaDnOiEvub53IbmnCGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1299151366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662862; x=1753267662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNRWt242eZxFezILvmaU9dhPGHw06BH6CH3GJ8C1+Mg=;
        b=AKPxxfN0HmIxU5/TjEElNbbBciFYgQHdSfKZam7IivtdzvoBt3sSHBrJ6DQVtEXJh7
         eLJwgKW0Wqhiz5qSxCEksA9IO7TKBzuOppvAfX1wIEDQuuifTwM7Dx7PULTI2bvLXOfM
         ohK2fvTr39dzDG8M9/I92UNytEEP423zP7z2YsaGmokG7IxUG3fzoTbQD50l37kfnje+
         jnHVq2leYNx56eJNIGyGR+6Ze3K7v0JhdJhrkiP08dTAHWVcejB656U2PgzaZxBm26bz
         g4gOnOzzepEDkeQjH+JRDXCeyzQV99F7s4kHRiiPc3giq7u26yaSLPKkGfgXpuS3qsR0
         hpFw==
X-Forwarded-Encrypted: i=1; AJvYcCW9f7UgG3kwOWrMug9sfjff0y8vQBhsXbAPj4a9d9bNzS/pbD4HsDBFRd3WsqxgG0mYtVGPauK693pi+ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9Hz50+cov+Vpbe2QaF4n81cieDggg0sCxDrxYCTVPtgEyDtK
	cR3kndaD2a0kfkqwsOhMH7AVLwG0Ht29UtmYEw65mo4t0oaRyTT6DEuM
X-Gm-Gg: ASbGnctZVlLM7qK+0SxeJ2p9S5bWZMbzUVvGMvtDUDO6fqR4TpyABCWERlGjIH+2Sfa
	lw2lA3GGp4ORILYP+NxainLKZJwumIrJbIQ4o7lPjCnhzsAYdgFUYU2Urvkhter9ET7/gKG9eeI
	mQJ0Ngc1YA2hKr+8aPzMm7vneyTTF0Hca5ekYJgSmMgDgD/oH/DFAP7rBBhY67tTZo9QOrUY4+P
	voDhCO8MqmBe7aSlL16sKWS8Q03UWNsW3s3FEVr1+uoCaoPsP652Yy93O1I8V/+UtHryJoSTXKj
	nsRSrM8zL7Vl8ES6AH2Db0KgRQwetZf/3LYu3IArbDgW2yW1KzOCgirdHdMF1njX1lJjAq3AWyU
	gHgUDxwn9Kg==
X-Google-Smtp-Source: AGHT+IG9NkxoRQLKN7gikfTWbqSsO28t6HOYxllXlHF2iby6CSVSR6dVnR5lVFd+R3ljmm4QDXScTQ==
X-Received: by 2002:a17:906:4743:b0:ae0:ded9:7f31 with SMTP id a640c23a62f3a-ae9cde179bfmr159803466b.20.1752662861248;
        Wed, 16 Jul 2025 03:47:41 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294b5fsm1148171666b.125.2025.07.16.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:47:40 -0700 (PDT)
Date: Wed, 16 Jul 2025 03:47:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Track currently locked rq
Message-ID: <qxulb3ckm256bltfep45iac3vifv342o24654ulh4zt6shvg5j@grp7crx56rk3>
References: <20250422082907.110167-1-arighi@nvidia.com>
 <20250422082907.110167-2-arighi@nvidia.com>
 <xy47uzzirvauag3otkqhhhzwyhlpnnmeh3s77i2snmtoub3jhl@ywoeaxl3iq3x>
 <aHaN3FqRG6gXNwbv@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHaN3FqRG6gXNwbv@gpd4>

Hello Andrea,

On Tue, Jul 15, 2025 at 07:20:28PM +0200, Andrea Righi wrote:
> > On Tue, Apr 22, 2025 at 10:26:32AM +0200, Andrea Righi wrote:

> > 
> > > +		lockdep_assert_rq_held(rq);
> > > +	__this_cpu_write(locked_rq, rq);
> > 
> > This is hitting the following BUG() on some of my debug kernels:
> > 
> > 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> > 
> > I have lockdep enabled, and I don't see the assert above. I am wondering
> > if rq is locked but preemption continues to be enabled (!?)
> 
> Interesting. And it makes sense, because we may have callbacks called from
> a preemptible context (especially when rq == NULL).
> 
> I think we can just put a preempt_disable() / preempt_enable() around
> __this_cpu_write(). If we jump to another CPU during the callback it's
> fine, since we would track the rq state on the other CPU with its own local
> variable. And if we were able to jump there, it means that preemption was
> disabled as well.

First of all thanks for the suggestion!

What about a patch like the following:

commit 9ed31e914181ec8f2d0b4484c42b00b6794661b9
Author: Breno Leitao <leitao@debian.org>
Date:   Wed Jul 16 03:10:59 2025 -0700

    sched/ext: Suppress warning in __this_cpu_write() by disabling preemption
    
    __this_cpu_write() emits a warning if used with preemption enabled.
    
    Function update_locked_rq() might be called with preemption enabled,
    which causes the following warning:
    
            BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
    
    Disable preemption around the __this_cpu_write() call in
    update_locked_rq() to suppress the warning, without affecting behavior.
    
    If preemption triggers a jump to another CPU during the callback it's
    fine, since we would track the rq state on the other CPU with its own
    local variable.
    
    Suggested-by: Andrea Righi <arighi@nvidia.com>
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba210..24fcbd7331f73 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1258,7 +1258,14 @@ static inline void update_locked_rq(struct rq *rq)
 	 */
 	if (rq)
 		lockdep_assert_rq_held(rq);
+	/*
+	 * __this_cpu_write() emits a warning when used with preemption enabled.
+	 * While there's no functional issue if the callback runs on another
+	 * CPU, we disable preemption here solely to suppress that warning.
+	 */
+	preempt_disable();
 	__this_cpu_write(locked_rq, rq);
+	preempt_enable();
 }
 
 /*

