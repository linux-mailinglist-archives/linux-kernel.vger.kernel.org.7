Return-Path: <linux-kernel+bounces-801141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E63B44050
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891C03BF5CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74C91F4CBC;
	Thu,  4 Sep 2025 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXaGWIEd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30641B85F8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999039; cv=none; b=L6TljHsQDVDaT11FwNmw3u32yP0zBxnj76/lyzoTlQ8wONiC3c0gH8DyZ0aPvHBpSUKJ2miutCS3gLmuSpp6kUKgcV9pxIzHFH/qoG+ttZL/DI6S1bXxsul28g1IofOmrb7piGIHZKkEuCybGsW2RhCq9dfdNodDbQZE1j0dhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999039; c=relaxed/simple;
	bh=g6aBgaGI5Hggp+gJ1bSFu2LCZqIJDzghdbH5v9LPKf8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nw7W4PwYjXjJqDsLwcnSjucwod/olFJJ8aU6yeuvaCB3j1BUGVcQbsLu583ye9DwCtEuYMtG/B9MsNAmXMTqWemfBjHeplqzWeBVkLO86wBKWEYJFWj5uzP4O+Te1HX6/wqdoOpuBpHLX1UlYwPU5JMyhz96yMncx33BqLp0b5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXaGWIEd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756999036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXBd33UW3ON4tRIQqchImht+rBKarL2bcunZMHnxTcs=;
	b=ZXaGWIEdJ0ctqkEvUQJ/2I1+au7t1qaDf1FVi+L2fYOTTJ8CTOIEFKd5ZEDzWaTENFLBaj
	7ztg8IXjtzDU4wQNik2+ijeR0PYZmuHOGhj2F//k+V4wItJfR+TX+Rv+X6rCd0DiAKvakk
	gzQ/Zj1HGGRE2Nz3v3DQ27wx1nxu62k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-iMS3wpLFMMmfog4_U8PKrg-1; Thu, 04 Sep 2025 11:17:15 -0400
X-MC-Unique: iMS3wpLFMMmfog4_U8PKrg-1
X-Mimecast-MFC-AGG-ID: iMS3wpLFMMmfog4_U8PKrg_1756999035
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-718cb6230afso19044636d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756999035; x=1757603835;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXBd33UW3ON4tRIQqchImht+rBKarL2bcunZMHnxTcs=;
        b=f+5uoCIHFWF2AwLJUi+ichdI81rxcvOtjhNqwSaBo9YQmb+U6CJ+6MgJdpr8aJRCLN
         EcjDDPwo85Amyy+rM5kEQ9ft2rTt4ABSta3j3Ag4o+991b9dxtHmb+8qvpVcvXuMePM7
         4grxL1F8wUoBACDlxacS/c/XIG0SyccOdEhLDyCGos1AanFiWDjfDOSaIUfuGdVcVL3d
         jRvdOVx6iHktm+9MpaRMmR/t1l8m7BF6Xh4QDJEprmStPRg1xSOS4dsh1uB7opMwB+m0
         r1ywbTjBDfZkwExG1PLc86H6axwLCC/LEsjRaapdbwez7fd23ZCE8Jz2j6Ukm9CVak+Q
         V7NA==
X-Gm-Message-State: AOJu0YxCZOsTe0Jr3Wo+zKyPTx+rB4q52SjbBgF5R/l74HIoW9iTutGj
	WCoeZaQKoTnXIoV4pdws6ARfVF59JuK8TvM2IopyoFBdFVxqitByA0xJSYm4oPh54Eih+B/uMc8
	5WvtOUInCxEoPChoGzy0c7bJiCp0qhYIhEjIPj7p5ZZXnaQyphbDIxJ0Q7kh0E3JW+g==
X-Gm-Gg: ASbGncvS3D6R6b4AbV58UryyAfyF1swb4W2NRVXnTZMX3uEBeP/0bezDG1kp2TGvmGr
	MZ/tcKRtXCFlD5pDmqDchDClttD0B4oVOp4tTtyaFkXu8Lkp1BgRw+SpZT7CjdcHa1Wx7aeVwNf
	Kz/cPcUwXK9Mf8O/JNIz8ohCUYJ41IP3tHoGi3FcNnM4/OXlnbBD8pychbdZu6+9zYY12wxR0Qo
	NuzWYnlwAzYEONUiqhFsZ52K+cxMU+QkPH1p1gyLgDsZ5TQRkpMmD5Iah0frnEcwTPELemhAvMp
	fIl0jJ9EWwl9XK1VbsO1GmhQ8YxHqasKBnSewoeuwX2V79mGmK91yIS46My4CIu58GdWk5qr9Os
	Y4746OjSAWg==
X-Received: by 2002:a05:6214:19e9:b0:729:17fd:e2cd with SMTP id 6a1803df08f44-72917fde4a8mr31949286d6.63.1756999034728;
        Thu, 04 Sep 2025 08:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA+P22Z98z8CTQUErCARkNuwDpGOPt9XWM8vKG5IqQSbzoS0jOL9ckJ0jIGMFCBOxTi4NLtA==
X-Received: by 2002:a05:6214:19e9:b0:729:17fd:e2cd with SMTP id 6a1803df08f44-72917fde4a8mr31948456d6.63.1756999034027;
        Thu, 04 Sep 2025 08:17:14 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720add63b87sm48343566d6.29.2025.09.04.08.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 08:17:12 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f7b5caf9-ab30-4b51-b3c0-9e3cdfdc2b2a@redhat.com>
Date: Thu, 4 Sep 2025 11:17:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cgroup: Remove unused cgroup_subsys::post_attach
To: Chuyi Zhou <zhouchuyi@bytedance.com>, tj@kernel.org, mkoutny@suse.com,
 hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
 <20250904074505.1722678-4-zhouchuyi@bytedance.com>
Content-Language: en-US
In-Reply-To: <20250904074505.1722678-4-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/25 3:45 AM, Chuyi Zhou wrote:
> cgroup_subsys::post_attach callback was introduced in commit 5cf1cacb49ae
> ("cgroup, cpuset: replace cpuset_post_attach_flush() with
> cgroup_subsys->post_attach callback") and only cpuset would use this
> callback to wait for the mm migration to complete at the end of
> __cgroup_procs_write(). Since the previous patch defer the flush operation
> until returning to userspace, no one use this callback now. Remove this
> callback from cgroup_subsys.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   include/linux/cgroup-defs.h | 1 -
>   kernel/cgroup/cgroup.c      | 4 ----
>   2 files changed, 5 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 6b93a64115fe9..432abdfdb2593 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -746,7 +746,6 @@ struct cgroup_subsys {
>   	int (*can_attach)(struct cgroup_taskset *tset);
>   	void (*cancel_attach)(struct cgroup_taskset *tset);
>   	void (*attach)(struct cgroup_taskset *tset);
> -	void (*post_attach)(void);
>   	int (*can_fork)(struct task_struct *task,
>   			struct css_set *cset);
>   	void (*cancel_fork)(struct task_struct *task, struct css_set *cset);
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8b55bb7..75819bb2f1148 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3033,10 +3033,6 @@ void cgroup_procs_write_finish(struct task_struct *task, bool threadgroup_locked
>   	put_task_struct(task);
>   
>   	cgroup_attach_unlock(threadgroup_locked);
> -
> -	for_each_subsys(ss, ssid)
> -		if (ss->post_attach)
> -			ss->post_attach();
>   }
>   
>   static void cgroup_print_ss_mask(struct seq_file *seq, u16 ss_mask)

Note that we may have to add it back in the future if a new use case 
comes up.

Acked-by:  Waiman Long <longman@redhat.com>


