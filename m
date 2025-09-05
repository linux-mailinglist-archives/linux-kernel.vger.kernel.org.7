Return-Path: <linux-kernel+bounces-801914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D2B44B87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFC13B6221
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451C216E24;
	Fri,  5 Sep 2025 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PHdK59ZW"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5861F239B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038518; cv=none; b=UcYiaWMk65uoA5RrUl3yj3Bk1hSFifyTCpbTpGvIRo7SubjjQkPE8g5zB1M1b8u8rrsnL0ho+qoARXvEs2mJRBiui842lYCTaJaLfeUQlGH6gnVByGF7iFqKPcMpOqa261w5QOeOd6A7T6RCHVgx8MVRXjSOqzexCkj3TAm7FzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038518; c=relaxed/simple;
	bh=FdJg8qi0IXKD3DxP7XqO+tU6s0IqlaIOdYGxPJTlKOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRITqlvzPvFgwkL++gEAsds2ZEuSe7/+7F+dtIPYzyaVd4QhEX/0B43kmmXySPcDM5RmZJoC0q9vER6Ee+/20hoapZIkwZqKyYpXihDQPcoLUnMc95J8dQdjYBodI167KKax6/FxsVw4N5Sipc/JZ09YKEWy545ci22lGT/NxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PHdK59ZW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445806e03cso22443915ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 19:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757038515; x=1757643315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdpMCZLXYFG7Z+YsWln7uIOJqN9REs+5xi/n0BkoWu0=;
        b=PHdK59ZWuZ2ZNtPHD0eieqkgTbQMNmqr+zBU9EYiGDWED5/Z+OFgYUOL8+MeRb4wSF
         HO9drYlVMv4xIwssH2Yip11ARgr3w5jmGKvS52mxna+osMR0YLzoXtWJ3f4wpKw9oom9
         31tZsj1RKop9S8DxLa+wx2Dt8T/clHG7HMVBGr0qf3sf51z4H1Cfa/M+PaJPw+nutc3u
         taqUAlbLRqDOijWCvfVLaF57AuA6/0Ai45p/AGI8ffuXN5LS0ZG6GNkW6zNnE+6j3/zs
         c7wD0zfKvWNfKvDkeBXmD1zpwza6neWLxuBa4KQJachcu5KNoUbJmFiW1njQTEC6ee0R
         igcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757038515; x=1757643315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BdpMCZLXYFG7Z+YsWln7uIOJqN9REs+5xi/n0BkoWu0=;
        b=JoarZG4fzTV9f2MC2H07Q79/hLGuAhQMhRTdPIIg0bwNaQr0qmS0y/Gfl2PyFeqgkk
         9zExHcGE8eYMB23VnIoT0lw4AvaHybdVRAzGZw9dccZob1mODIzeJ6Py2NsF7A4W6yqM
         srBonbGTgcfw3/VPFYum8T0CFCcqncp+RC22qdjbbDy/0lUNBffZSY/YKpEL5kTSQ7L+
         T5nuWgkT9zxFJhHFWDRCuej72x3ZItKH4uK83HQLau0VLZwNaqEQhmQaHYZyYIoiz+Wi
         NhTtTwkYuzgItifxJaaia9hRdl8C0yY2n1V/88aHLRJ5gHhqHCzO1V5dPoPR1V16mJZ4
         r0OA==
X-Forwarded-Encrypted: i=1; AJvYcCWdP8eL2ryjr2jEMAFsx/w2LmeWu55eV4ZHISBKd6XsL/Wcois+g6/ZWreb5SzxO13Uslx1txSlD+BZC5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8QQtmO0H6EK103z9zVRZy4pb3Ni9MuK43/e+FPuLsVkaXaF4H
	QaDe8FPVeQ4ZMKmRTSOG0OSrnLQz264xA0SF9w0KvXL6f9+9B+6kP+FWzUMwus5Xyo0=
X-Gm-Gg: ASbGncs7dxeCbeXNFLY+0EfZ+nw3Tbec8EXeoYUcdc/NfIJhXRTs822OgoAuOZa1862
	JIIK9P7LN2jmEe7/FnfInXbXOsEajXmL+FKiPYom88tQIZowQiI5qgi+2OPLUd+D6+bnVKQfoYg
	HBzn0+yCkIVqoqjJRI6YD6kz/UxAHLdaEvIg4quo3OydmbWYtC05pOdlPk+7nZh0NyAoK7r/VdG
	9Dm+N4Pf2TvSNSU8sSGD5e/vKthZ3orNuL5TJV83B/qEtSI6d3mjxI7u3gXMKZ9bd45d8jQOl9q
	r/6ZURFMsRZX+jN1NujpLOV+8ELjl07RSGFb/KFqsuQ00zvloENtmfvnJ8viEqIqEIFdsfqX9K3
	cHL487Zlf8PYwhMXahA0UKgdbev63B3VF9RcWGLAHj+h4N2uox9I=
X-Google-Smtp-Source: AGHT+IHoBI624L6O54AH50C3ze77TjZ857tCQoGDBFor6or0zHBAE7Vdc3v56yYiYr04kqNnN5S5mg==
X-Received: by 2002:a17:903:1d2:b0:24c:82ad:a4ef with SMTP id d9443c01a7336-24c82ada7c5mr108445345ad.32.1757038515215;
        Thu, 04 Sep 2025 19:15:15 -0700 (PDT)
Received: from [10.84.146.165] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b4e27902dsm7415780a91.12.2025.09.04.19.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 19:15:14 -0700 (PDT)
Message-ID: <a73a3a5e-b206-4013-ad61-81a5d9c0d0ee@bytedance.com>
Date: Fri, 5 Sep 2025 10:15:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Defer flushing of the cpuset_migrate_mm_wq to
 task_work
To: Tejun Heo <tj@kernel.org>
Cc: mkoutny@suse.com, hannes@cmpxchg.org, longman@redhat.com,
 linux-kernel@vger.kernel.org
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
 <aLnL8RLdyRCPo-9P@slm.duckdns.org>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <aLnL8RLdyRCPo-9P@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/5 01:27, Tejun Heo 写道:
> On Thu, Sep 04, 2025 at 03:45:02PM +0800, Chuyi Zhou wrote:
>> Now in cpuset_attach(), we need to synchronously wait for
>> flush_workqueue to complete. The execution time of flushing
>> cpuset_migrate_mm_wq depends on the amount of mm migration initiated by
>> cpusets at that time. When the cpuset.mems of a cgroup occupying a large
>> amount of memory is modified, it may trigger extensive mm migration,
>> causing cpuset_attach() to block on flush_workqueue for an extended period.
> 
> Applied 1-3 to cgroup/for-6.18. There were a couple conflicts that I
> resolved. It'd be great if you can take a look and make sure everything is
> okay.
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
> 
> Thanks.
> 

Sorry, I forgot to rebase the latest cgroup branch before sending the 
patchset. I made sure everything is okay.

Thanks.


