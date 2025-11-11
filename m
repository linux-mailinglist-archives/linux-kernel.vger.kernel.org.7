Return-Path: <linux-kernel+bounces-894694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14596C4B9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCDCF34E650
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E42BD5AD;
	Tue, 11 Nov 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="jPejZi9O"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3F2BD5BF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841546; cv=none; b=suy0+pjg/Pun5wtB0/mr372cwH1QeADylOs4g53QDGbJV0iV38eeTeg9QuqMio6ZtioQHt0ZMcy0IkOYY570U1aW7EOVrx1qbDBqKdQVAJGRxAH4XtAYJM2iJborGFVaSOa6V54EAdrJMCkkH/NKUbUCNKaZ8Wolrlx/xS8D12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841546; c=relaxed/simple;
	bh=FWwWHfVGkeFFK0gt3TeAwp+q+y/27u6YbRdVkJwdPgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1+w8V7GVjoQTEvC0uJphBlU7HJJoDK7UQDojV6X1WTWBVQacOVLAQR0ZzKwG4MaaMA2EQ8MgWNAydX/ywaNDUxoR8FIcaZVM5j0tLdCXVlgGP9zm88RMmC6SmPLSa1fi/vN8iMG52INMonKI87CelEvquieJaA4Ksy9j4rMWV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=jPejZi9O; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7afd7789ccdso3590143b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762841543; x=1763446343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWwWHfVGkeFFK0gt3TeAwp+q+y/27u6YbRdVkJwdPgA=;
        b=jPejZi9OQ2F5tjT6Hh7i9Bww7Zd+0DWwHf5d3FUNRtsLrzhg/vDpVCwgYp5s2euxkR
         i8gwDZdAFrLhUxa9UfnRGvgIAFRCZI12EoRwwYnKSJmUAfHNZZ0KqHNCltaSEXaXqa+k
         iVjBnmLnnOY6ky8OibfIyuTIjrtFHA72WeIP7k0mZamBOU48/itNAsFaEmQTsJL7V0MH
         m8AmOZKIFypPT1agMwzgApKyBLihxgNnNKggaD+HwwRHlOW1CCOhWhQD5CFuyVSDma8P
         6FlkIfLOJnWRWZS7QQa+dElGO+WKkD7kvc5ps8Y7qsls8sCF66Ai4hZDm32oDoNtARg2
         FXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762841543; x=1763446343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FWwWHfVGkeFFK0gt3TeAwp+q+y/27u6YbRdVkJwdPgA=;
        b=EzUmj62wc2Si6zN7VP2ncy/Ep7oKD+dVlH6xCQly7fjr2kY1ymQJN66PrVmNGqxZo4
         hBsmp2zGlOBcT4BP7Ti4PVhCA0MTaOt4oDQ/e1joqHE7wq2JLqt4hJVLGnVyU/9wuQ/1
         MEgPm2I056dAAg5cHiIYGbOu3QvCD9uTRNUK0munEvkF6lnzCf1Kx4ZlqJNL0jC4Szmy
         Xtx9EyPtjkuuo9x4+FhFvd7LdIG7xk8GUh0AIaHexerpfdvDDU/hJi9R9GSgMkQpH9Gi
         UCqlHo99ewlb7/5mNPhf0n3P9iOdOq32unktOyl6g8DLRZv1lOVXgDtI1jrtS925EVpo
         EDQg==
X-Forwarded-Encrypted: i=1; AJvYcCXNTwN2llgRTg7NAoeDzQZSnXXdpTWE6wWF8rgZdN4iqEYaOZRhno92tJiTra7BYBFbx+ozIb30hdAmVcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvx9I65eWFwxX5IgnaGjP7CvBGzmqPwGQbu+OyUhsbSczaOWI1
	qVjAppxe4LKZX6mSTuH8XqNnt93m4Ah6GcGn57R90YFHr/IidByBQZrPK6lCRr2PXe8=
X-Gm-Gg: ASbGncu8RETIGqW2xPUrMpXQC+vVaJKjfNaIJ8RFp/Jp21NqjH7N3OiCTx05FxJ582m
	GxgME4Yt11eYMUBCCH5RpvIUYr71s3wPHCSXkyU8qMBzFpUAl3oJ58VSNqNoIILbOyrhzCMWdjN
	Xyu2ueQBcAySpShKyX1pEghjHlgvW6r/KHIZbpg5/oV6H/rKfNsQ18kjslyW0BAIb7QGJ15qoZ8
	dz1Cdqv8czs9myvAO8WnXdq8YrOpaOD+PHOmWsMoKXd8mAwL8Cp7jvlpPiJjtX/JA1yeilaP3N6
	9GKqX1cb/bUW8iVtfazR1mxZU53nBw8xsVYAI81E82rtpdgdYpR/P7kzS/pcLklQFdeub86XHKa
	rj5xpX+JdyYTEP/twjMi792+Xl1fxlpc2mMULOIlFCUkf3C5gmySdXDXVc0/6RQL9/kDnFZCwwL
	H6Nl1F+E96E6izUFiIMKakirxk
X-Google-Smtp-Source: AGHT+IFvxypcxwiOfBwdgzPuM+j/Y1RLEUCRj28ISBfw3r7KvT4isOe0gB52rHuhHDaQS6UnBqQMLw==
X-Received: by 2002:a05:6a00:2d8b:b0:7aa:a2a8:9808 with SMTP id d2e1a72fcca58-7b22668efe6mr11556484b3a.20.1762841542634;
        Mon, 10 Nov 2025 22:12:22 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ca1e7b19sm13755722b3a.32.2025.11.10.22.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 22:12:22 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: mhocko@suse.com
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	jack@suse.cz,
	joel.granados@kernel.org,
	kyle.meyer@hpe.com,
	lance.yang@linux.dev,
	laoar.shao@gmail.com,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mclapinski@google.com,
	mkoutny@suse.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	tj@kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for on-demand stats flushing
Date: Tue, 11 Nov 2025 14:12:13 +0800
Message-ID: <20251111061214.70785-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aRHMWewcW41Vdzed@tiehlicka>
References: <aRHMWewcW41Vdzed@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 10, 2025 at 7:28 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 10-11-25 18:19:48, Leon Huang Fu wrote:
> > Memory cgroup statistics are updated asynchronously with periodic
> > flushing to reduce overhead. The current implementation uses a flush
> > threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
> > determining when to aggregate per-CPU memory cgroup statistics. On
> > systems with high core counts, this threshold can become very large
> > (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
> > statistics when userspace reads memory.stat files.
> >
> > This is particularly problematic for monitoring and management tools
> > that rely on reasonably fresh statistics, as they may observe data
> > that is thousands of updates out of date.
> >
> > Introduce a new write-only file, memory.stat_refresh, that allows
> > userspace to explicitly trigger an immediate flush of memory statistics.
> > Writing any value to this file forces a synchronous flush via
> > __mem_cgroup_flush_stats(memcg, true) for the cgroup and all its
> > descendants, ensuring that subsequent reads of memory.stat and
> > memory.numa_stat reflect current data.
> >
> > This approach follows the pattern established by /proc/sys/vm/stat_refresh
> > and memory.peak, where the written value is ignored, keeping the
> > interface simple and consistent with existing kernel APIs.
> >
> > Usage example:
> >   echo 1 > /sys/fs/cgroup/mygroup/memory.stat_refresh
> >   cat /sys/fs/cgroup/mygroup/memory.stat
> >
> > The feature is available in both cgroup v1 and v2 for consistency.
> >
> > Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!
>

Thank you for your review.

Thanks,
Leon

[...]

