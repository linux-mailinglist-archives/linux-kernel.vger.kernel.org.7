Return-Path: <linux-kernel+bounces-838880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F23BB0590
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE6C3C421F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB302EA736;
	Wed,  1 Oct 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3U/mCTow"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B742EA494
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321565; cv=none; b=rrBQgnuiJt7EHW3E3OHYn8889D3n+lM800PPdv3isLwhL5bVhLS5sYGeIMIeA7t7oho7hL2nITFwBOiEykD8T+uJG6sYcZlGq084Z/R2+SLOeOLFY9S/NUGitfdWAUXF5Dsi8qMnlNEFX6kOhbiB4kwuNugviWaj817AwL1EgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321565; c=relaxed/simple;
	bh=3ayNbCgEBpgJcWx7QrG/+sfX9FPJmaUZWIZVJumsQGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WW+hZEUiBUc0jmbaGze2eEWOR71wf8aPPrU3a9YbLZiwGQ4tfE8EKSb/5UpYIJDAz0ePrvGM8Mz6vQClEGeJjq8QCtjN5KdvYy1E3EqRyuCnFh2VoI2DBiyIvOC3FJHmmIuASoLJt0c9xoFbrYxq19NWoo1sTiRhesuFnQZCl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3U/mCTow; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e39567579so34612135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759321562; x=1759926362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ayNbCgEBpgJcWx7QrG/+sfX9FPJmaUZWIZVJumsQGU=;
        b=3U/mCTowXOnhJQi1QtviqlgieKoGZzAhE4T0tVwy5zYEcQN9uw+8WofZOJn8lZqlS6
         0t2acNadH2SWViqDezYvxFkbSy+QnylK82HJuFFyad64X/Q6EUQAmunR8dPyOUAaJmpZ
         NluE3ZksSOA3J7UV704b7PtwDkxXVp97x0RvHbv2HzuNEnBrwc2wxHe6zbU85o7Gm3hP
         /Kis6xMV6nPfbwFec2iz+D6hePi9SytP0n+IDHu6+GK1rf67igcN9di/rMVqNeEinfZl
         I31frip5kvIhG+NEq/oeNyYbmjCxp7155Rg/G9+zd3OyI/sypfjMuWWj7SVPKzFu7LkP
         8Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759321562; x=1759926362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ayNbCgEBpgJcWx7QrG/+sfX9FPJmaUZWIZVJumsQGU=;
        b=Gzz0fCN0t6Hi9Aq6lJVHMLTuszIdCXx866dW0Q3ue/+NXX0neL5DSsxQiG1LtC0Lk0
         /yMhLO/uJ6xysGljLrKl9ArK8zWMXFbrdl8KkSuHf1abRLcmdjDeQI1leLOtUw9eEpmD
         OaObQOSdrO2jgUuUyfHLNcaUimS4+VHdTo2AduB8QSgijnqQONZZCrizhowPaOZhmTze
         rTKChOc7rpnG96n6mjEI4MUMwBIO1XdQZq/d3RDpKnk+9oyzhryyXbnQsx31iMHFEN9R
         xIX7VFflbc0jrSSu7x80UHA78xczmjBb609dvq+pErWhf8LBYsx69894XGam5jHHNPNQ
         25RQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1lwiy/CW5GvqpILOSzqGeLdDi4zKRD85Z/iGO9Nt661SAVosVe/twgLJkv/54asl23c9U0MG9DUyQMAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmU419E1Kj8Cd+eaKZ9Hsl77ibimHJSlJWRnFO3Q34+c+Om0z
	ENTQ1Md+Pc8rAz4oRlRzfDG8dtw/nRzWnZF5h5H7+RjcpfkC/cILt4ltCKILLyI0rR815EeN0EX
	zNI1QG1fX0wHXYQ==
X-Google-Smtp-Source: AGHT+IHhvLWUAOpfrdTW7oF5fo1iHNdyUu7ve/F2YpxM44Rj8ywwvuvN6K0k8Lfbtju5XwvYHXm0pqfTKrxDrQ==
X-Received: from wmbgx21.prod.google.com ([2002:a05:600c:8595:b0:45d:e2f3:c626])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:37cc:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-46e6121ba13mr29447395e9.15.1759321561760;
 Wed, 01 Oct 2025 05:26:01 -0700 (PDT)
Date: Wed, 01 Oct 2025 12:26:00 +0000
In-Reply-To: <202509272136.N4ELb64u-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-3-2d861768041f@google.com> <202509272136.N4ELb64u-lkp@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD6ZFZGBMSLA.7BSBIIJN0SLP@google.com>
Subject: Re: [PATCH 03/21] x86/mm: factor out phys_pgd_init()
From: Brendan Jackman <jackmanb@google.com>
To: kernel test robot <lkp@intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>, 
	<akpm@linux-foundation.org>, <david@redhat.com>, <derkling@google.com>, 
	<junaids@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<reijiw@google.com>, <rientjes@google.com>, <rppt@kernel.org>, 
	<vbabka@suse.cz>, <x86@kernel.org>, <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sat Sep 27, 2025 at 7:29 PM UTC, kernel test robot wrote:
> Hi Brendan,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bf2602a3cb2381fb1a04bf1c39a290518d2538d1]

I've fixed this and the others in my WIP branch but I will wait a bit
longer before sending a v2..

They're all real issues - one of them confirms I have not exercised the
CMA with this code (by demonstrating that I did not even compile with
CONFIG_CMA=y). This one is just a benign bug that only shows up with
W=1.

