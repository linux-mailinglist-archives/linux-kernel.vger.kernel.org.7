Return-Path: <linux-kernel+bounces-879839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A2C2431D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BBE3A6F89
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C4329E60;
	Fri, 31 Oct 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ToakaNpd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0DA2F6931
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903102; cv=none; b=n2TpX6HuMTXI4AGrObHxqfCWthObx4xZ7FcQ6bIFiWDmUrbXNdG9eUvpLIBjb/LXd/wiMb+ekLjEpGPk0pKV9lUaBW6pwrIFB3BTbsvslamhYo76vkgWj3R+jWMXVGux69anbVGNJm62PaF7Bl1o+qSbRgyi2vkvchp67yzPzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903102; c=relaxed/simple;
	bh=i4aMKq8odkJsmnkgFgZb/jGnVc3hqLQys6Z2jKNzKJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZhbcKVTGVc4BHE4cctDeD19awmd2uCLLYm1ba2TDgJdsYCXA+vNXnsSHlaS8/Y+KYMpN5dnc05VOESf3L4yxouPx0SIj1LbkT30kjIgbc7ygwJ+ranGtgsdXSCu4MrtoiE2ZKcVmoKPQHbIg+rT77xs0Rmj51HTBo5gtjj9nqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ToakaNpd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so14479775e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761903099; x=1762507899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZqsIXX4i9fDMKAO6vBiIA93QUBSotAqCxkbGp8FfSY=;
        b=ToakaNpd8aEHDaLi1V13hCthR3ihAt8zQbBItHsVCbqVk6EE6cAj1/33m3FPWNfxvN
         QbAHvnzgJGbzE4G2IQr6FkhSJ6/E9EcnnySzrjQ3OimVH7pSXHrqGfTA+1CGkdg1aP2d
         brkf4O/Ft8vSzU0cGVXV6C0/yu38uFYM3Mb+u/etYAaprOwW9PUBwB3UTB0HXumNSMpC
         UNFj31EReKlA3KRdfvvwWN+aAc7sn2KoA6jJSMAvJym88M1Uvd7BBp6tMFKvs60nEtcg
         AaushUMtbOkw8Y1u5VcScLr4247TL2bGKY/lJ57/16wCfjSnaX3rXqeboEklVvkTf5G4
         jNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903099; x=1762507899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZqsIXX4i9fDMKAO6vBiIA93QUBSotAqCxkbGp8FfSY=;
        b=PlYUxXB4ekhYqrNgM+WJW7f2MznDLZIKWjkvPpVwXeWggwe3yEM8HHEAcErX3mm2Zh
         QT1/j+V//K1M2Q8YwUKHc8e7e7v3vUSTxX1KYCS71pkNUnjFJCfddANp+loUFgHKJ+YI
         C0LoK4KvjGCTFTpBoGKk1adPAuVw+CeqLoR/rtjWiJxhJVK9cBW5aYVDwehD83aPBrPt
         NXRGh4L4ojrYWCVkH3Ir8BSHAxbFOu5RnxRgevO85UUiNQjrLhyAUX2N7sFTjb0urtpL
         GY5d/MjGs5sKhrhz5hZPdM4vc7U9BYZ86tAPiDvqv/OZpvrUL1seiL3sVME8o5uNCVs+
         Lbpg==
X-Forwarded-Encrypted: i=1; AJvYcCVPUETkshzEsw0oZnypPIDXfgS7v8t0zlsFldwrz+7ij/UGUfTMEktaihEEauu3HIcy903Uf7GSjp1YXGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1CIVo/EAt0gdS6j/dN/cZSMCwzSYAtvwRAAf6hUAr5992ni9K
	bKX9ovgNnS8ZFkMsK8QyovSVyxexqemxb+wtxgCO1WRgnXtKWl/IWd7a5HH/VghhBCM=
X-Gm-Gg: ASbGnctzGz0al/NW1sqpUqge8YMF39X59K0IphDoqhGnZDzoZccpTLW4GKtzJ8zCvOS
	QvUjxwpw7derWDlNBiIjlFBEVMn9FbFyJSeTAgD5gWzmC1uuYPqExMmH9ZbddeetuhwprE+wuXR
	w/EjP4VE6l9t3A7eQIsbdRYBBKKQe8nxMJpYsl5xCf9R24mcbRmHjDrQI8gMLkeHG4KNza27inG
	N4Blf6PFBvYjLpXEL7DtrwGdyzso+ok5cggXfMmkWqteMo7tY/mUHVEKErfT59Nxzl13bjkA737
	dKbJNWCvZpBLZ6trq+SoURhdfTy1+YNwDOPdjB5IMkPfNs3IlizkqFwoBezZDpYqPsjB4XYH6v5
	XYkK7QLr8mBkSOBF+RwxQMYpzEtI+h2YF5A116kJ+hA1sQEo4Jt1bHixUf67/DY+kYqPskCUZw5
	m/Fefg4P1bQ+nusQ==
X-Google-Smtp-Source: AGHT+IG50zQtJd3CIUQKj9ncFkPdrH/t/rsOh53ftoZJnLGX9Bc7esexz1A2xxBb08Zp7FtUCXSR/Q==
X-Received: by 2002:a5d:588a:0:b0:429:b52e:351c with SMTP id ffacd0b85a97d-429bd69ff31mr2719399f8f.38.1761903098515;
        Fri, 31 Oct 2025 02:31:38 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13edc36sm2536910f8f.37.2025.10.31.02.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:31:37 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:31:36 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/23] mm: BPF OOM
Message-ID: <aQSB-BgjKmSkrSO7@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-1-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:03, Roman Gushchin wrote:
> The second part is related to the fundamental question on when to
> declare the OOM event. It's a trade-off between the risk of
> unnecessary OOM kills and associated work losses and the risk of
> infinite trashing and effective soft lockups.  In the last few years
> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> systemd-OOMd [4]). The common idea was to use userspace daemons to
> implement custom OOM logic as well as rely on PSI monitoring to avoid
> stalls. In this scenario the userspace daemon was supposed to handle
> the majority of OOMs, while the in-kernel OOM killer worked as the
> last resort measure to guarantee that the system would never deadlock
> on the memory. But this approach creates additional infrastructure
> churn: userspace OOM daemon is a separate entity which needs to be
> deployed, updated, monitored. A completely different pipeline needs to
> be built to monitor both types of OOM events and collect associated
> logs. A userspace daemon is more restricted in terms on what data is
> available to it. Implementing a daemon which can work reliably under a
> heavy memory pressure in the system is also tricky.

I do not see this part addressed in the series. Am I just missing
something or this will follow up once the initial (plugging to the
existing OOM handling) is merged?

-- 
Michal Hocko
SUSE Labs

