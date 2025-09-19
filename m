Return-Path: <linux-kernel+bounces-824091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E55B88193
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534E91C81CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2242C11C7;
	Fri, 19 Sep 2025 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCKo2pF/"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A542C0F9E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265567; cv=none; b=JxhLw1N2gEWYmV/z4StvGtjFk6znrWn0PZ0ggyRz2l04OThsHqrwb8eEG1vHMKsl2bVh7h6hzgk1Ij3FdQkIJugSpGEqQMjS2g8lF/UhYm6Mfz7QcvA2+uXjYdC/Jepkbk37Ce7SGcs8lfVpcK6lcRbPp6jy4sSFzZcIbvdLdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265567; c=relaxed/simple;
	bh=ItZKaGQl9It/js9gzPNXCsAEXczA+CYbzua9BHh+ovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFxppYKBVuaqrFjNOM1Z/tfl49iSEwJY31yTktCq56jdEuwpi/pwfViLuPEwbl+z0yvrM3beBTYQZf9kImjl3UvURSI/mK65HtF/4AzAr+nw2e8UuhEyvfJXUAmxBAIdx2rTu116JZ5nYHVAZVLxG93hPd9Iwo8wtttM3AenUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCKo2pF/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee1381b835so833765f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758265564; x=1758870364; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Klo+L3KBBL4ssbFZ2YOqJt7BcxJ8M+dYCfYzeUYYBY=;
        b=hCKo2pF/F78auKEP48toZ9iiNufcpa9c36bPf4P6fwtH1zaEBgaQ/RUiLIQk92rhWc
         B1LgQpeOqlgQlCfm8iif2jUa154KDKMvYQlSys5NZtt+K1jFjuxbzMGsfZi6gawxzMjn
         PH1A3hFkQbnoa61/vfXUDV3CSh6jvceVmBuMfBRP49NRPxq7AcTmj8PJJt5FMoY07PFM
         f45k7CojLt6eIQlQbuDN/fIh6vTw8m23VBVFZPh7tGbrilgmVh+/LguX/Dq/QoxcwGQt
         4CRU8KcVWlbcPIAhwDzT0GR2qRk3ORkC5h6ualYsffvKdotgOB88M7c91H+ryPIHp9Um
         Nvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265564; x=1758870364;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Klo+L3KBBL4ssbFZ2YOqJt7BcxJ8M+dYCfYzeUYYBY=;
        b=MbF/yqzWclMXZCteAN6ch61Q22K2y+g2mZvC4kYP8SavOGFCuPyrwm5xYf4eHEYDl/
         9wh4X//rLTGUXJkfrAZAK6huGQ0SzCC6/vXY/0OkWWw6cdO6IDrv9jqbBih5YKl+TjKE
         tcggXJ8uoKasckEFBZuW16DTgH/meVUEcPpE0YHfkCkB0+QSPDzlgNGkE9Ax6p8OkVC7
         unhcIzaX5W9NKGv0nut7wjQhgPopzEjdmECGCx/a2WOlpMEBqewno3IERU4jW3Uv2/HP
         sWRJE/5U8Kn7KDCN8JeX+fCeJhO/KU6npcZUqWOb/7KAJR0dYnnWZRUveMOllZOiYGxG
         WHrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv6JFkGakye+oNFuPhVXaAwPmzYcYzWHyzIgOWS1XeiVMLUgU2s9TnCTN299KZFlJsEtC04Vyqob6yRB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFdAc/o9tNPThDRWr+inmMwwv9iF6J71e66d9h3j/SJ1MLdQV
	mUhQZ3I+8XvPY55VbQ1foAUrfXdJx3ZO29se0teIZONgbNxudWqaMqBkmAKIgHq/LQ==
X-Gm-Gg: ASbGncsXHE8/gb8Afh4WF5v/ycIfYiK057O7wRdIpYX5DQ/cvKZ+lwMuOsYlUcgD0cR
	XB6t7KrooVVUzBy0p8IEqvSJCp0Wwk352tCLBLlBsUBXzSjDhGyyIK1ES9hqYLmGk3u1gZ6BXed
	WHVAR83ujcC4vdBLRBsIxwiAhyTA8LIQCgDN8fwZhZ0NlhGUghzk5Md6cusKw422oWrh6NIsqAX
	Mn0qA2uHP7u2mVDpVb71ozCO4Ahq4SsSX+suODQTftvh7L1IGMta5adbEerXlY8wEwi6dJ5OuID
	WYk3a6PmCM5dFTnMIAeHk4XP3OMX6OqF2V9FvMqHXeXVe9qhdEDmgPlHm4H+63tj89gXn17+9O5
	/HWD0jI79CbRf37Rp0t8reQoAy0oVE8elC3jc1ncBZq8rtlwntQncGXrScmY=
X-Google-Smtp-Source: AGHT+IHPi1pgPaxjy0qFYAQQyA+9c6RpQAFZf3vA/UzVRkHTrs+JR5MqjC9zARfGu5kWXbLyHGkoeg==
X-Received: by 2002:a05:6000:2c0b:b0:3ea:6680:8fcd with SMTP id ffacd0b85a97d-3ee7c925245mr1570227f8f.13.1758265563176;
        Fri, 19 Sep 2025 00:06:03 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:1f7a:8520:7568:dac6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf1d35sm7200088f8f.55.2025.09.19.00.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:06:02 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:05:54 +0200
From: Marco Elver <elver@google.com>
To: syzbot ci <syzbot+ciac51bb7578ba7c59@syzkaller.appspotmail.com>
Cc: arnd@arndb.de, boqun.feng@gmail.com, bvanassche@acm.org, corbet@lwn.net,
	davem@davemloft.net, dvyukov@google.com, edumazet@google.com,
	frederic@kernel.org, glider@google.com, gregkh@linuxfoundation.org,
	hch@lst.de, herbert@gondor.apana.org.au, irogers@google.com,
	jannh@google.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
	justinstitt@google.com, kasan-dev@googlegroups.com, kees@kernel.org,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-sparse@vger.kernel.org, llvm@lists.linux.dev,
	longman@redhat.com, luc.vanoostenryck@gmail.com,
	lukas.bulwahn@gmail.com, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, mingo@kernel.org, mingo@redhat.com,
	morbo@google.com, nathan@kernel.org, neeraj.upadhyay@kernel.org,
	nick.desaulniers@gmail.com, ojeda@kernel.org, paulmck@kernel.org,
	penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
	rcu@vger.kernel.org, rostedt@goodmis.org, takedakn@nttdata.co.jp,
	tglx@linutronix.de, tgraf@suug.ch, urezki@gmail.com,
	will@kernel.org, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: Compiler-Based Capability- and Locking-Analysis
Message-ID: <aM0A0p4-3lwLeAWF@elver.google.com>
References: <20250918140451.1289454-1-elver@google.com>
 <68cc6067.a00a0220.37dadf.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cc6067.a00a0220.37dadf.0003.GAE@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Thu, Sep 18, 2025 at 12:41PM -0700, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v3] Compiler-Based Capability- and Locking-Analysis
[...]
> and found the following issue:
> general protection fault in validate_page_before_insert
> 
> Full report is available here:
> https://ci.syzbot.org/series/81182522-74c0-4494-bcf8-976133df7dc7
> 
> ***
> 
> general protection fault in validate_page_before_insert

Thanks, syzbot ci!

I messed up the type when moving kcov->area access inside the critical
section. This is the fix:


    fixup! kcov: Enable capability analysis

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 1897c8ca6209..e81e3c0d01c6 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -497,7 +497,7 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 	unsigned long size, off;
 	struct page *page;
 	unsigned long flags;
-	unsigned long *area;
+	void *area;
 
 	spin_lock_irqsave(&kcov->lock, flags);
 	size = kcov->size * sizeof(unsigned long);

