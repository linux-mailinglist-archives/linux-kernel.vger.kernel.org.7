Return-Path: <linux-kernel+bounces-759131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B2B1D8F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D00D3B7142
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD36B25B311;
	Thu,  7 Aug 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PWDJSY1x"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBC2561AE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573140; cv=none; b=rXCawqKx6fd1yt2jxKE+gJFylPr2YFxbAwkddkZfmdkmGQH7xasbTM698zLkic9kI60s2sg1EIz6XqbC/aVj97Jd2xNUt7xJDOTYnhe9BLkcp4vtAlGZ6d1FFGWr2uFw90hiq3/9IFAtlSXtVVMGoxZTk5JhhG2h6uqGUuQ8Jpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573140; c=relaxed/simple;
	bh=BE5Henonj83S/x58TbOMswxN6uWYEKzKyZZTSsbruCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSsvlBpw3F10dKcESbckJ1FE2Wnqaw9nDZgTv1eL5BUUzMZ4be16bYITE1TxtIEbCt80by+u2jNyZ/p6ZsnhXhSaN8dCAubOZMisWIHaWOlOLdF/sUvKwm5RpGtjaiICcyYc+fP2nc7QSmBf09perZpl9UxnUkgbG+zGGp1QBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PWDJSY1x; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7910123a0so845792f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754573135; x=1755177935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkK/h5wyW78slTbM7rfscexueduuSs96e2Qc2RW5gY8=;
        b=PWDJSY1x3KjIoYMyRAV/nD8dicioBVARS+3hoJXNlET0sg58G2ZjUOEvn8PDbav+1j
         OsZpkEpx2lfO17rbC2SAEYeIL2Pa6ODOBw68VrpELrTa2if1E4a5AORzmAkdOb3ct/5A
         YacrUmrPsTOXLOjlnXu6RHXhjlur2LVQKFsU4r2PRHeYOFCJ/CgBaB9I4NJ8dXP2lRi+
         8DXiBG1mXTVv1azIpPECnV1jkVlPMKpOUx48kwq5YOkkKfwPyM5dhAZhPhJ1i6aJ8zVu
         q0zy01V3PqUJT3w9T1MS10KqnK3qpvRfgXvYmgAq81px+dwjqknCIAcQOePn34dX96EZ
         iH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573135; x=1755177935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkK/h5wyW78slTbM7rfscexueduuSs96e2Qc2RW5gY8=;
        b=SPrDvS+WGUZEdmsZKt5urKyBC10JWgxpK4bsk6rIGVdHMt+rWAemMwipG2EGCPc1e7
         QrByVHVMFI/Z4wCQIw8wSzZjZVXotQPfNvMXs84zc7pNH2tMIyFCujAxS7QbD1KQfP6A
         I+k8J7+yjlu2oUqVmBySDXRxYbxwISGWracp1fpZOLZ0y1oGQelGJlgyxymFsvg4eG+L
         N8u54Wv9NGiM78sl6BzNYbUnajF/ilIz0iVVE69O3seyoPiAEF9fnts+WZIKspDjAPzL
         EYi2GEVM1auWOmUTduVR1x4pkGicI0m1W7ytZcRteHyLHi3XJkJtYiSsGryz/QEb/CT2
         L4qw==
X-Forwarded-Encrypted: i=1; AJvYcCVGBpsJgF+fGvC4Wkqa1yc8N8z5hC7Ayy4QuLWWA/BgCtt4rGgxxCg2LgD8W8Q1X3WWAMsRdEe6g2Xfa6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhq3Y+eFr9sxdSu0b7m9ymcsO57d2i3LBf10F6O6WL0N9YA+X
	3HGrxN2/pqn1DYqm7pd9//vpHNrS6Zdrm6epZiC5oaOO5o0ZXp0thkdkIKVWA5c7dl4=
X-Gm-Gg: ASbGncs/XObaFqpXH/HscG+Fikh0xi4spUC6Xq4j7fWaeozkqHImMNHJQBN6hEh0QJq
	h6HBtZPA/YIUnCimyk+dMLSh3ZfhwmsaePMpNhLQ4Z8GE2F3CKtm0pQHKGuPgXWgTFo1TUpXIPl
	Eqi4sQrAbCUTBY8eA7mx7XRj0t+5zAlV6G9Tvy4YKFNb3FQoQmGXNRXTTTfvy673b6ND/K75FqQ
	foNh5vRedg83bv3QR2JaV3SLMpiYZ340/c6SH60yC8lPQG5AZoHoW6zBNh3n4CR8MfrKHpj5Zqj
	2k2u1VTWucWI2FWgeLVa/2yiq4OcHUYdQp6ec8+9AZbue8fyRuSOww2Lg4hCnFrmm+SyqH7OrXd
	GKvMkkgBrIvGc+qMHL4IukZOqNgWBSZTzrIv8vaPjkf9bcQ==
X-Google-Smtp-Source: AGHT+IHQ9dMmpvwSG0LG+OsU60Voye7P7DJOnU5DCYn4cofMlrbc+GKVT9M1/0FDZpZM67dPsg7qAw==
X-Received: by 2002:a05:6000:1a85:b0:3b7:78c8:9392 with SMTP id ffacd0b85a97d-3b8f4166f4emr5537116f8f.19.1754573135392;
        Thu, 07 Aug 2025 06:25:35 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c453ab0sm27171452f8f.44.2025.08.07.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:25:35 -0700 (PDT)
Date: Thu, 7 Aug 2025 15:25:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>, xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
Message-ID: <aJSpTpB9_jijiO6m@tiehlicka>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807121418.139765-1-zhangzihuan@kylinos.cn>

On Thu 07-08-25 20:14:09, Zihuan Zhang wrote:
> The Linux task freezer was designed in a much earlier era, when userspace was relatively simple and flat.
> Over the years, as modern desktop and mobile systems have become increasingly complex—with intricate IPC,
> asynchronous I/O, and deep event loops—the original freezer model has shown its age.

A modern userspace might be more complex or convoluted but I do not
think the above statement is accurate or even correct.

> ## Background
> 
> Currently, the freezer traverses the task list linearly and attempts to freeze all tasks equally.
> It sends a signal and waits for `freezing()` to become true. While this model works well in many cases, it has several inherent limitations:
> 
> - Signal-based logic cannot freeze uninterruptible (D-state) tasks
> - Dependencies between processes can cause freeze retries 
> - Retry-based recovery introduces unpredictable suspend latency
> 
> ## Real-world problem illustration
> 
> Consider the following scenario during suspend:
> 
> Freeze Window Begins
> 
>     [process A] - epoll_wait()
>         │
>         ▼
>     [process B] - event source (already frozen)
> 
> → A enters D-state because of waiting for B

I thought opoll_wait was waiting in interruptible sleep.

> → Cannot respond to freezing signal
> → Freezer retries in a loop
> → Suspend latency spikes
> 
> In such cases, we observed that a normal 1–2ms freezer cycle could balloon to **tens of milliseconds**. 
> Worse, the kernel has no insight into the root cause and simply retries blindly.
> 
> ## Proposed solution: Freeze priority model
> 
> To address this, we propose a **layered freeze model** based on per-task freeze priorities.
> 
> ### Design
> 
> We introduce 4 levels of freeze priority:
> 
> 
> | Priority | Level             | Description                       |
> |----------|-------------------|-----------------------------------|
> | 0        | HIGH              | D-state TASKs                     |
> | 1        | NORMAL            | regular  use space TASKS          |
> | 2        | LOW               | not yet used                      |
> | 4        | NEVER_FREEZE      | zombie TASKs , PF_SUSPNED_TASK    |
> 
> 
> The kernel will freeze processes **in priority order**, ensuring that higher-priority tasks are frozen first.
> This avoids dependency inversion scenarios and provides a deterministic path forward for tricky cases.
> By freezing control or event-source threads first, we prevent dependent tasks from entering D-state prematurely — effectively avoiding dependency inversion.

I really fail to see how that is supposed to work to be honest. If a
process is running in the userspace then the priority shouldn't really
matter much. Tasks will get a signal, freeze themselves and you are
done. If they are running in the userspace and e.g. sleeping while not
TASK_FREEZABLE then priority simply makes no difference. And if they are
TASK_FREEZABLE then the priority doens't matter either.

What am I missing?
-- 
Michal Hocko
SUSE Labs

