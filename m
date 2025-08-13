Return-Path: <linux-kernel+bounces-767445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C00B2544A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A7C1C8404F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF20F4FA;
	Wed, 13 Aug 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayX0ijin"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757002FD7AD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115763; cv=none; b=kamYJ4g5uHYKoHhheeyxnvTj1vY0Cz9hEWAc+AeqJA+dU1WMnrGZd9QGR8NPDngDceKx26patVEDquJyZ0HZPPONRMpmJ2Fh4Qd0PnYIuOz90cn9MVDd7R+U3efYWfsVVNswZI2OFQkRTSiMfZ8NCbLBq+e6tQ4DzniPM3NJIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115763; c=relaxed/simple;
	bh=2n4wZwTwJAQn+2kkdeSV5czAJtaQGGR+E9aS+hCH9Lk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rUIVd/nYOZPF6pRfSNI/FbuSvG9LV0A5yPS2hIeTgrHyihUxw2gWj3DN0MZNVmrtKo9vMpkGtxMsePR7yxFsdTH3sw8ReW8fjyS+w8+krfkge4crucuXG5u/RNHr8ZdfIr+/Pk9VT29LQk9d+gM8qZxdEA+C2yucMg6rtzq8BiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayX0ijin; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755115761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Id7hIB1jKShzLzzptFHUZAPK8H5+qbzZTzK312LljXM=;
	b=ayX0ijino+gqACB+sg3RnZ2w6o91AXlTkVPqIdCi6jWTf2sFVSSeQY3B1lpZS+RMQ0/anF
	m9pSoJeeF81V1P07DjArMwPZLR6M89K45mjxL8jBmidDdbLYyUETKppGgNLPekHp/KUHku
	QR4DCWVi+pdP/7/5TVF1z20yU+zXtRw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-Qi6t1i-DMKqSvZApqMhuEg-1; Wed, 13 Aug 2025 16:09:19 -0400
X-MC-Unique: Qi6t1i-DMKqSvZApqMhuEg-1
X-Mimecast-MFC-AGG-ID: Qi6t1i-DMKqSvZApqMhuEg_1755115759
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e931cc1d46bso381184276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755115759; x=1755720559;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Id7hIB1jKShzLzzptFHUZAPK8H5+qbzZTzK312LljXM=;
        b=qPNIYFGfSY6zRPOEvaIilvnKjXnK2MYwbK94W8QDdknZMNDoaeJKrVbQtKAqq7rE7t
         hbPD5qRCg94Beps5FrxkegNo9qs5rbkBxo5qQ+xBsBett7xjX22IIes/BP8AjYBopqAa
         FkXtf7GQcW+lek0odabOhT8YSoLecPr9hMWdcEFnxdxb+Z/gBrqOWBjcKiNe9F2RPjDH
         RfBllK4svNKvSNbSlxkmKXnTgc8KRApaRlruV3qwhLy4LezobGkTe0OwQE+2N0b1BWaY
         RKvAa66OZMArccrQ1A2ZGiKj0FLwRJOUDybWz30cfcRL1brBVnfodNVx7WIPKXRyntQi
         uRUg==
X-Forwarded-Encrypted: i=1; AJvYcCWuotf8lstNCCSZiMHC8pl6dhS8eOKBelHwXgXU3ququhmFQFjfSxKjFees7QRFqVQ2MyPx+zayLEIMAQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXpeK4jO8vE6NOLUEevUm5LHNWi2AVX47vw/9hseQpDC3E4+f
	KtYSxq34NKux3J+KyS/074bNgvyC/w/1/xs/AoBZ6C8P0F1hf80D/YbkVBU/RlqhoRyCidi88zf
	EkkEo0ZLPfSFgXlO9+v5ppWmS2mTorhKJ5rjVIYZTR4v/Tp2gr+W07RutkqWtiP5dVg==
X-Gm-Gg: ASbGnctUwnk1FwoxolV7QYQ8EXq5tYtahT44eoOOMOaxDgowPgauI8lBmXM0H+8KAYQ
	lo3dUjZSC8zJ6+Qd9TOSXZwtacttYK5S4iZvbeVy/LyiAe3Ms/FuP16rzjBn5v/vI/kW0Ofy/9+
	p0lrI9rAkJ+F5rqqyn/EjhdY0xbuA939sDH8VhQcIZ2/xFduP7mjbuaIXOqwxN3LB2ilZjfzaeo
	ZWr4LVe0i8rAATrURNGr7xV4x5joSYb3nFrmaohiGSay+nD/YWhAcRphy6xwK0W0f8RyXBoZM+S
	GPEi4elC10MXfFHdT5g2ZJbWukulw3K+r6pvlTeCNGOl7ENxBGgApixSMRUVZ7Qn5faIp8ZGlXE
	46sljEHLTIQ==
X-Received: by 2002:a05:6902:6b05:b0:e90:7383:cc7d with SMTP id 3f1490d57ef6-e931e191b93mr570932276.21.1755115759196;
        Wed, 13 Aug 2025 13:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpwtZpmV8u1pxNPLlWMiYmxOFFQKXKvZEYc1RrYFUSBfDMMIM6iARj11h42NsnC/JdPE9Gkg==
X-Received: by 2002:a05:6902:6b05:b0:e90:7383:cc7d with SMTP id 3f1490d57ef6-e931e191b93mr570888276.21.1755115758702;
        Wed, 13 Aug 2025 13:09:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e931d56ed53sm128685276.21.2025.08.13.13.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 13:09:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e0ac3594-deab-455c-9c2f-495b4e4422e2@redhat.com>
Date: Wed, 13 Aug 2025 16:09:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 4/4] cpuset: add helpers for cpus read and cpuset_mutex
 locks
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-5-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250813082904.1091651-5-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 4:29 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> cpuset: add helpers for cpus_read_lock and cpuset_mutex
>
> Replace repetitive locking patterns with new helpers:
> - cpus_read_cpuset_lock()
> - cpus_read_cpuset_unlock()
>
> This makes the code cleaner and ensures consistent lock ordering.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h |  2 ++
>   kernel/cgroup/cpuset-v1.c       | 12 +++------
>   kernel/cgroup/cpuset.c          | 48 +++++++++++++++------------------
>   3 files changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 75b3aef39231..6fb00c96044d 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on)
>   ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   				    char *buf, size_t nbytes, loff_t off);
>   int cpuset_common_seq_show(struct seq_file *sf, void *v);
> +void cpus_read_cpuset_lock(void);
> +void cpus_read_cpuset_unlock(void);

The names are not intuitive. I would prefer just extend the 
cpuset_lock/unlock to include cpus_read_lock/unlock and we use 
cpuset_lock/unlock consistently in the cpuset code. Also, there is now 
no external user of cpuset_lock/unlock, we may as well remove them from 
include/linux/cpuset.h.

Cheers,
Longman


