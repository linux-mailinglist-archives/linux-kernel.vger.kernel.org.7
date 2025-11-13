Return-Path: <linux-kernel+bounces-898816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89564C56143
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093DE3B3A42
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E2832571D;
	Thu, 13 Nov 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="INh9kisN"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1332936C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019448; cv=none; b=MiBCVP32R5nlhnLDS5DvPoknp46Unjm+XE+g5rXr9ejUFtw+LbHhjClqy/Xky/fpyB39hpICKIfsYjskR8shQPgbme+wvmbiqFcoDx2g6aNXEtR90RhhWrna21vvNVrp0nYDESTF/vqUVMdEtUJRuqhYKusQlz8PtQUYzEQjJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019448; c=relaxed/simple;
	bh=I/WpisZDYfQ6eCNY3xqj3kPfAZ27Pt/dd0Ntuhox6BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F23tnae92Hl5rHWVgx479A6CABf5fn6wrp9slxGtsnON1T29CFy1BJmjul7MCtmRZHNcNEKwJhbrk0iUu55kwx86YjsJAx8MEX9rzCCM5sLY4xZn1j9Zwz2Wmt63mkhUD81caCeMnvIMsR68UxkzUfSg9dsSPfk1eaj7636vTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=INh9kisN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so621417a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763019438; x=1763624238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ErwKpSB7O06bd8pyRpgr/pjZeD/ktQ7vFDy/Wy+0Yk=;
        b=INh9kisN5YK8NAnyE9AoeNpRdCEsOuXou0i8pGvKb9XQVk7FnsUsj7/B4Ma4fHD+YT
         b0pahEBS209G2TUHRid8B4YWs5VevneZ30f9iyo2cKMXUEra6Ynq1hYrfFJlutusN0wj
         tTqD9G0lPyJmXWoyGddl7Rwcgcegvg+ftFFl2op2agdSO4iLtFOJikV/MXZO2XdmUFRq
         bY66pjgSFpBkAd6DSkoJsmCuGJKX/VYrVnDK9bta7odlTqoO3P5cIjl+lqo6Zcb3Qqj0
         UU/s9w+xgCbxMCMfwxPb0Pcd+QUU4ZZlb8gYPULgQKNzOuOBlyFlxphlidhFr5av12Tp
         YFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763019438; x=1763624238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ErwKpSB7O06bd8pyRpgr/pjZeD/ktQ7vFDy/Wy+0Yk=;
        b=e31sDsGjv4jUtlmKOwvB79QzR/ubuD3Aj2ZM+hv6j2IIOc/0VTLuh/mlvsRn/LL4MM
         USK7DLdbTPoPk1wM4zoPJOF9MwVClEHkgSCcUPCV25KgdJ8XTGGOXtkxUF83O1H2J408
         QyWKuxS8F0r3cnuIiu/d6p94TXBXl5pLTQILgKO6bak1LMGnV2u48Ng/hHubMH8Ldnkr
         BBuOHPchV4SpQ24DMg0mUzbK/Zlwu/BvQ9vhUSQMOSVT/8kE2BtiboD8vrhLCOmm+OOl
         F/R6y4rAJvgJRwW1437lFyu3ojsbo3jGaoU5/04KAAm5V90ZyzQcIB+YcxCOKrPKSJC1
         aaHQ==
X-Gm-Message-State: AOJu0YwcHHEwobgnTQqhSJ9TTTw4wRpqxP98wZnh7STgdAo59gbXqgLM
	r8+uOkBXhFYYNufVF1XpdYZoLO0ClTIaY9qr6eK+pPRTKBVLjV3np5UaiKnUGv+ffBE=
X-Gm-Gg: ASbGncvfkjepbADRIJPONVe509ncd+jwwq79FKuetEDWWMnC1RFC37TylKmiXDclRB1
	k4LNHYEmrDpNql5iGj2Tg2EO8bc+HhpVFfHCHoiNOrtIGwMEQkOoLy9ZI0BYwipzI8hUDfXoqA2
	aP5aEE9TOc57HYgtcQFbyWBjNigb9elQF2OyPa+XaABSHl9flruHDNf3GOUfkC+MVtufEhkNYHA
	5KskFm/2I8frH5iH32XXxawrVKbufki/ELvjc4PASPeqEB3LBNbWg2Qaz2VPCLHDAHoC3bJpsxD
	aP/k/Fs1Ittt3wl8JFNEXop/OXueQeuMxIhhmkjfn+jdR54BMFAECsO5QSRFNu1R9VtzpIJ7AWf
	Jr4v0842LuEtfOH/KImmojF5JjX8voCYpMa58yaypDaUAMOXh3S/MVTgUjJuryKJ3d1WD+7msw2
	Sn21w=
X-Google-Smtp-Source: AGHT+IE1XubvOmCmqqWcHZQN3QCxNQ8u2ErQ5jVOLKC4ySPOfcJKtLtnzPEW0D1kRbNejdQV4zA7gg==
X-Received: by 2002:a05:6402:40d6:b0:640:f8a7:aa25 with SMTP id 4fb4d7f45d1cf-6431a55e67fmr5271820a12.30.1763019438038;
        Wed, 12 Nov 2025 23:37:18 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b28b0sm831174a12.30.2025.11.12.23.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 23:37:17 -0800 (PST)
Date: Thu, 13 Nov 2025 08:37:15 +0100
From: Petr Mladek <pmladek@suse.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	d-tatianin@yandex-team.ru, john.ogness@linutronix.de,
	sfr@canb.auug.org.au, rostedt@goodmis.org, senozhatsky@chromium.org
Subject: Re: [BUG -next] WARNING: kernel/printk/printk_ringbuffer.c:1278 at
 get_data+0xb3/0x100
Message-ID: <aRWKq2KNKjxbXexA@pathway.suse.cz>
References: <a2f58837-2b29-4318-9c78-5905ab2e9d3b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f58837-2b29-4318-9c78-5905ab2e9d3b@paulmck-laptop>

Hi Paul,

first, thanks a lot for reporting the regression.

On Wed 2025-11-12 16:52:16, Paul E. McKenney wrote:
> Hello!
> 
> Some rcutorture runs on next-20251110 hit the following error on x86:
> 
> WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0xb3/0x100, CPU#0: rcu_torture_sta/63
> 
> This happens in about 20-25% of the rcutorture runs, and is the
> WARN_ON_ONCE(1) in the "else" clause of get_data().  There was no
> rcutorture scenario that failed to reproduce this bug, so I am guessing
> that the various .config files will not provide useful information.
> Please see the end of this email for a representative splat, which is
> usually rcutorture printing out something or another.  (Which, in its
> defense, has worked just fine in the past.)
> 
> Bisection converged on this commit:
> 
> 67e1b0052f6b ("printk_ringbuffer: don't needlessly wrap data blocks around")
> 
> Reverting this commit suppressed (or at least hugely reduced the
> probability of) the WARN_ON_ONCE().
> 
> The SRCU-T, SRCU-U, and TREE09 scenarios hit this most frequently at
> about double the base rate, but are CONFIG_SMP=n builds.  The RUDE01
> scenario was the most productive CONFIG_SMP=y scenario.  Reproduce as
> follows, where "N" is the number of CPUs on your system divided by three,
> rounded down:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5 --configs "N*RUDE01"
> 
> Or if you can do CONFIG_SMP=n, the following works, where "N" is the
> number of CPUs on your system:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5 --configs "N*SRCU-T"
> 
> Or please tell me what debug I should enable on my runs.

The problem was reported by two test robots last week. It happens when
a message fits exactly up to the last byte before the ring buffer gets
wrapped for the first time. It is interesting that you have seen
so frequently (in about 20-25% rcutorture runs).

Anyway, I have pushed a fix on Monday. It is the commit
cc3bad11de6e0d601 ("printk_ringbuffer: Fix check of
valid data size when blk_lpos overflows"), see
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.19&id=cc3bad11de6e0d6012460487903e7167d3e73957

Thanks a lot for so exhaustive report. And I am sorry that you
probably spent a lot of time with it.

Best Regards,
Petr

