Return-Path: <linux-kernel+bounces-856790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1533BE516B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B045840A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1E23D7F2;
	Thu, 16 Oct 2025 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UfdnloSc"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F823A9B0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640231; cv=none; b=UeUPxpBLqFdbGlJhDudAHu/Oh8vOMsCxCuznko7cFdzyzjSvCrLX4iqN4lmTY1BB4QpqYXPWQkWIe/om84j8/x4uIyBeS1Z9kMtfJajxaWf/dym9Y+p+kz1ncrujBcTX2wykFaYOocD/SgWg6kAG04992rKPIGr3Zn+Hggxg31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640231; c=relaxed/simple;
	bh=AUMqM5KwDaH6FkEguXjWOsp3VPXxkmvw7hUmlsK3MT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwEfaFvRZ5bI7DEuWja/m5Cm97269RyvOgde4HOtR7rN1fr3ZuZt285p4C1kt59porldMlwenhPP6fvEzVbpYQvYl9sZ3W9j4qJvD3QYCYiNFP6K/oa2yDq4LtcrSfmQ/19rlyYgn0HflPs9DtlHbyvw52IBCgK2oI/4KGMT7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UfdnloSc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42557c5cedcso662639f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760640227; x=1761245027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZf/xOnYZ5AB4g+Afgo4f1SIJz1a8qeaJvzviov59ws=;
        b=UfdnloScTOSjfuY/OzztT8W95wB64wiYYI213hm6NIbjKcpQFpZq9eh8IVApAlVaXx
         WfBeOwmR+tipbvVcW0XS003kkE73rQkLpqDg5NDoie2KLcJXyhaRJ/PZ2ee3nxRpquEd
         v4WHSQ8nGl4XJf6Bv714BfG7Z5UeEuNa4B7xJPMvwUCoFiPiUfC147hhXZa4xBkGo1zw
         zLeb9pJBnkkwMUYe64ql4YR5JrT34inPCCdkLFu4G10DFk5ca5dIYc2JYltrt0DNID9y
         tF+zaGeBzSC1c5RVZilY1LIrP1RKF2T8ETOa2YmG7/so5WxSeJ0MClGbKQJ3ml0EPa2R
         8FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640227; x=1761245027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZf/xOnYZ5AB4g+Afgo4f1SIJz1a8qeaJvzviov59ws=;
        b=Qy+teSS9cZKjAxq+Lg1aG8AY9UvN5t/9Df2CAqE1Q9BvOfdRv8S5y+dlT5qprcm9Tx
         llJzRdSBHvwzxFPHZqtmJoiG2xw8r5xZtwwcij72oWJRGApzrJASjVCo+UA5lonyDZjp
         z8eG6ZYfbos7ucv3kNR2cuxRpjfVXOWvGog0QmRnZKevH7FWuKoMyk8LCAEAA8ljdOwZ
         /BaRB5ECwo5NiDN0/0Vwna/SJ9NPoYUICcti4xtaGMblHhoR+jtQ4MNyF2jE3OBgl3V/
         dg4BUrKYHrvGQ+rcN+w8NQWsUFFa3nu6+lpFuSGoYrItrCpAXcIF4S5WckGs4o+JF67H
         VxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbp73+f5m/AaGV4513yyEoVTXZbjYNgEHGseynSKycxNAEUcEh3VYYTN/7+HAOUflFRg5It0CQLE6pBpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcU2rrb1qh6lOFiYd+gLje/sSge3+Zru3QdyoJZ6TPTKxSz0qv
	DsLBtDsCs3BfoWSVupjorHhyfCVY1h3uV/ZwaQUEflna4oXqS9sjI7RKQioykWTv9yQ=
X-Gm-Gg: ASbGncuN04vpAjN2wF8N/YfB0jGjDRVLyWRFW8icXHcFhiAo+taBEjD1tqRPZFukeFX
	GqvOD4KUh2ebx6tfjy0LqaHGavlyjFb3IyvUCeDdIsUB/X77U5BLBER9DcG8XYnpLqX1CV4Fp39
	jta8gjYYQq+AONADZDAS4acemgqtQaCMT7lmkck87LeKL6ctmSm4xqhMyKhNYwZsS7aXi/51avi
	B93PYZsv+ukIXczSojCBjZYgNd4TrsVirfEqY7NBTaHynNY6+mtVoIDfjcRpriZ0bHZbnM3RiEl
	4p7dEln26TmgOiD5VY/QlbKZnkWUV8xq3UX8IBFcuuINXZkbq7RS6qToRjYiWW0gCE8wO6eYZ2e
	e3sav3AF75O/DEtquuX/G3qhKU5a3Juhjhw1s/3LIJzppVo33cblP1T80ctR6EtSlAQUvYdwwla
	RPRBn2LxIx1m8=
X-Google-Smtp-Source: AGHT+IGo6y5lk13djMjMMq4R3viE+pYB2nSrAPV8y+Kp8nAdZ4R6ve9ypzaXAl0LPNYCFR1kJAQtiw==
X-Received: by 2002:a05:6000:250d:b0:3fd:eb15:77a with SMTP id ffacd0b85a97d-42704d143e3mr765616f8f.6.1760640227495;
        Thu, 16 Oct 2025 11:43:47 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471144b5d48sm41689115e9.9.2025.10.16.11.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:43:47 -0700 (PDT)
Date: Thu, 16 Oct 2025 20:43:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/vmscan: Add retry logic for cgroups with
 memory.low in kswapd
Message-ID: <aPE84XfToVH4eAbs@tiehlicka>
References: <20251014081850.65379-1-jiayuan.chen@linux.dev>
 <aO4Y35l12Cav-xr4@tiehlicka>
 <a6cd4eb712f3b9f8898e9a2e511b397e8dc397fc@linux.dev>
 <aPEGDwiA_LhuLZmX@tiehlicka>
 <46df65477e0580d350e6e14fea5e68aee6a2832b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46df65477e0580d350e6e14fea5e68aee6a2832b@linux.dev>

On Thu 16-10-25 15:10:31, Jiayuan Chen wrote:
[...]
> The issue we encountered is that since the watermark_boost parameter is enabled by
> default, it causes kswapd to be woken up even when memory watermarks are still relatively
> high. Due to rapid consecutive wake-ups, kswapd_failures eventually reaches MAX_RECLAIM_RETRIES,
> causing kswapd to stop running, which ultimately triggers direct memory reclaim.
>
> I believe we should choose another approach that avoids breaking the memory.low semantics.
> Specifically, in cases where kswapd is woken up due to watermark_boost, we should bypass the
> logic that increments kswapd_failures.

yes, this seems like unintended side effect of the implementation. Seems
like a rare problem as low limits would have to be configured very close
to kswapd watermarks. My assumption has always been that low limits are
not getting very close to watermarks because that makes any reclaim very
hard and configuration rather unstable but you might have a very good
reason to configure the memory protection that way. It would definitely
help to describe your specific setup with rationale so that we can look
into that closer.
-- 
Michal Hocko
SUSE Labs

