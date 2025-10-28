Return-Path: <linux-kernel+bounces-874397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE37C163D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7A13AE6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722C259CA9;
	Tue, 28 Oct 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRf0bAvU"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6034A771
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673076; cv=none; b=Ol+hRwBkIK/uJ6Lo1Ol16sklv0w/sEHUHgtMhJD6qUsUidwu6BtSx9/8OnXE6q5yUYmxyJCgcLe4fphH2mWiVfPzqh5WRR3s0Z1L4Us7uYSbjnj/g9ZzJ+q/gPSCjAxvHGJrcijb6egxS3/M5oN35uvHrXsZ9NX5j+439Fr2NY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673076; c=relaxed/simple;
	bh=WCMg7UUnl6IMP5RsK5bXZua1oQz6K1bVCjhQkkqx5ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C2Jh6e7KdOrqJToRJMk1U8owUXMjRu1eoWzxUwjMLg0YDTztI9yj4QLYV2F8q106+6aGGft6jUHlvn7aD0xjKWZmcIgTj2uZkYH33s//3uIAjlTupFd+zm03L0TaaXotW8GyPHK4IbZYzHMZvM93EgyvzPgWVwaZwvI7tn2cky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRf0bAvU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290b13c5877so127258785ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761673074; x=1762277874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8T4o8duS8kLdi84UueGHzy38mnS8VEpOnZiB5sHhaeI=;
        b=tRf0bAvUAUTSp33Yt3tFnqg5tTnMoOcrM+iA1gfhIIAUknLfs/3w/AEMKzaqifFkRy
         GxzIM8x7gBENFZliOQvIBf5epa5qQ5xxJ2x8qYVxWux4P9aSKxHSWUdOUaMlvGhpmfeu
         gPZe5US1VyE7AQZiWrgaNiyYAw7FsbfuqmZK7I13+uL0HXpJrOUcoPP0MpFuFu+HPR4P
         Iy3Mgv60UelSQhZzE+z/HKCzEIN5L0keOAXpB+zxUgQB5A3v5+7wHY2hGwaDqGLoUA5A
         PyviehO+MT6kslaopuRZPENzj1E16IgkPQPjw3bVtfISjJ7sEMgQNudwnVpIAteQcl3S
         gGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673074; x=1762277874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8T4o8duS8kLdi84UueGHzy38mnS8VEpOnZiB5sHhaeI=;
        b=fv2Ihge7KLhM9YUJOMabScSueyO6cncAUy6AKgUiLRx4XKCuFoug5DOL84zRdx2mUD
         khhvZc2grZuOzQuGGYcOBGfXql0DaMpgG7K4JN5bWykUan3sNkpbo9ytV8zu2Ax0AigW
         z6XAigjffCVwR/Zyn7upO1OzSe64y2B4i7yFRotVJSb/Svh7qBb8bNbb9P7Jy15g13qk
         C0fsjdq5sPLNqQSYLm4LnS/OyqjWUMtWsGCoMvLQDU5+rYfmN0Qd7KccatypKScB19sZ
         g/kopJ7tom/A6w4cbRGb1BVrkSeaRvby1+SKsE0UGhkNgimRAMDPpWT1Dz9HAbZOe46w
         /NNg==
X-Forwarded-Encrypted: i=1; AJvYcCXDe9BxQUbynvCdSGr+pRjDA8NUljLZQP3+PzaWWdeY4FdPXe/P0J8cZ4En2yIdOJNBzw/M1LFLcu66zbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GZFsYOLe4/hY+fndBl9xhZc6jorF9wRswEBPW4p/4IBlspUC
	FdPAGWt9cVFnqlrjxFPVCdQlO8lgUkCvUb1YYJ+lfjlWWBK2aE7SmBIn1iGU+ltYeKvhIZDzzin
	EJq6PVQ==
X-Google-Smtp-Source: AGHT+IFos7dmlHc5zgyuKwSvkzMGrICMFJHNR7QI6Hf+TJ3vKWf9u68Fb2sJjv7IaagPEHKeX48Q/hD6mEQ=
X-Received: from plpp9.prod.google.com ([2002:a17:902:c709:b0:292:4a9c:44cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:246:b0:27e:e1f3:f853
 with SMTP id d9443c01a7336-294dedd4181mr189615ad.8.1761673074418; Tue, 28 Oct
 2025 10:37:54 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:37:53 -0700
In-Reply-To: <aEeAl9Hp7sSizrl8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250610001700.4097-1-chang.seok.bae@intel.com> <aEeAl9Hp7sSizrl8@intel.com>
Message-ID: <aQD_cZzqml1vindY@google.com>
Subject: Re: [PATCH] x86/fpu: Ensure XFD state on signal delivery
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, mingo@redhat.com, 
	linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 10, 2025, Chao Gao wrote:
> On Mon, Jun 09, 2025 at 05:16:59PM -0700, Chang S. Bae wrote:
> >Sean reported [1] the following splat when running KVM tests:
> >
> >   WARNING: CPU: 232 PID: 15391 at xfd_validate_state+0x65/0x70
> >   Call Trace:
> >    <TASK>
> >    fpu__clear_user_states+0x9c/0x100
> >    arch_do_signal_or_restart+0x142/0x210
> >    exit_to_user_mode_loop+0x55/0x100
> >    do_syscall_64+0x205/0x2c0
> >    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >
> >Chao further identified [2] a reproducible scenarios involving signal
> >delivery: a non-AMX task is preempted by an AMX-enabled task which
> >modifies the XFD MSR.
> >
> >When the non-AMX task resumes and reloads XSTATE with init values,
> >a warning is triggered due to a mismatch between fpstate::xfd and the
> >CPU's current XFD state. fpu__clear_user_states() does not currently
> >re-synchronize the XFD state after such preemption.
> >
> >Invoke xfd_update_state() which detects and corrects the mismatch if the
> >dynamic feature is enabled.
> >
> >This also benefits the sigreturn path, as fpu__restore_sig() may call
> >fpu__clear_user_states() when the sigframe is inaccessible.
> >
> >Fixes: 672365477ae8a ("x86/fpu: Update XFD state where required")
> >Reported-by: Sean Christopherson <seanjc@google.com>
> >Closes: https://lore.kernel.org/lkml/aDCo_SczQOUaB2rS@google.com [1]
> >Tested-by: Chao Gao <chao.gao@intel.com>
> >Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> >Cc: stable@vger.kernel.org
> >Link: https://lore.kernel.org/all/aDWbctO%2FRfTGiCg3@intel.com [2]
> 
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> 
> Thanks for looking into this issue.

Ping.  I _think_ this is still needed?  AFAICT, it just fell through the cracks.

