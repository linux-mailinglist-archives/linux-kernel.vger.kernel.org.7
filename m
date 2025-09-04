Return-Path: <linux-kernel+bounces-801130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 477EBB44030
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139E71635C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C530BF74;
	Thu,  4 Sep 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELmKKe8C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1B30C352
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998771; cv=none; b=fcZZ77507aaIYOXBlZmQXc/uV3RmuxVx0I8CnoHnQd1Ch/pFh/aDP0c44N+fzkh5zxnEk14YVETMfv38W4yX/HD9qZsFVvnlSZGLXLYxCZsIZzt53q5EjA2C9Uwlsp+C3rQtiVyyE0zk/Qk+zQ8aSUfMQTJvGe9E+kM7vfxQb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998771; c=relaxed/simple;
	bh=Pbi9gig2NTuB50rv4gPbLOsN/bAk0EM9Q4KtJ15enEc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sfP5QONNoN6vb+JbhsSZqqhXorbYYUKizIOrlE7rRCT61QC3bC5VcJywgQtQYSF+N8FuB5q7CVbWroedf1sjgtr7FHnkTMmZPw4JTWv+1SOXiT25Vs3W8usSZRZi4p/5oj3++KRa08tCdeQJ+enSltj1AR5ZoR88fHCbJ5l/25c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELmKKe8C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756998768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EmXOduh7kig2rL+ELapzORQP8M/UXp2eaQEiNLRnvs=;
	b=ELmKKe8CxEXts2Nk8UHFwV2DQrJbfufZnIWgAza4OVRT4hhfkSW0BpkVy++P/Fl95azsXR
	CTZlaSfdAlvd0QQ602/Ep8YiTYD/3slRjTZqcnpu+ZSuHuFzWA5KCiP0gUAobvS7rZR99L
	9+cN2n2OpGP+EvDeKXlAq3r6TuPv89M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-X_cs7ZmbN7iMMgI6OcVw0A-1; Thu, 04 Sep 2025 11:12:47 -0400
X-MC-Unique: X_cs7ZmbN7iMMgI6OcVw0A-1
X-Mimecast-MFC-AGG-ID: X_cs7ZmbN7iMMgI6OcVw0A_1756998767
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3349c2c65so29717521cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998766; x=1757603566;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EmXOduh7kig2rL+ELapzORQP8M/UXp2eaQEiNLRnvs=;
        b=HjAz3DYCZ9pYmO2mDPDZsN2X+gZ/v7ODd6WPdP73n1jmKv0LrM7wLqXfPT3sVnSyjO
         bbE2uRMNQbQRMLUwPKZZDenYiiGeFOTKTN75QmtaF3uK7slynYSyko4YHkpzqIkcEFDE
         jbGaYCA+BX0UBPBJGG7+q3x/x2DKWDI15T3EMMjFbl7TeU4KA+eyrfmNF4MHegww8Diy
         Nb6UeLF6aTfK3E+k4Q63amC+8bK++uecd1qfji14pJuGS/Mtj9h+9WepU66ddRoFu+iB
         88TXNB3J2AINlWn615lB36ksSnbQiSR9kqi0DVcZAZIur1ViqqdCwmYkbTn+l1VgLJ7M
         hLJA==
X-Gm-Message-State: AOJu0YwndvjdjLXuoOwTbqYp3huqh05adLP2uIUoZWsBS5w7OpBFX+RD
	bzRcRL6heDy/NwfAqntOVw4PaTi8tHUkBhR3It7SdM7hcpuMkvmcgCcGtXqrUnYlo3bY3/Rwv7o
	scrQhzyPIZ7RAj+uDpwyOydfhYqgZaU7OjpiYIiuxZ/jqOLAcsncvg9wqNEnXLaGzFg==
X-Gm-Gg: ASbGncuftubPCuckIhk48HjEaypDVHGe2tXLj7Zu7XLrsCCfCegI2IXqfyDwk8U9sCV
	cSI3prVEVGcSXXA4NJ3dDhRtYli3C9zU6sB+saTPfBGBkkAiAfD5nx/qlrXQ21W4YiOiHk47Nqn
	n6H5B/Vd5eAOH9g8ijl/siIQEHKJmTPpjNK9t/09pemH9aJwwl0jQOx5ee0a2n1B+tp1351A6Db
	YxvFRfT+5Ghb1iQG+zHUtvGzSv26PMPxrLSAFtBYhJj33yVe4UbbEYRFcXY3Gu7RVzFupwMtGto
	kwHfjJh+ELCYySy1nOYFvB0+sfvuN48v76ggUZxhiM6NMmFPt2V1bR5u2ME7PYggIIHPOS2MMyU
	mBr65w2OFxg==
X-Received: by 2002:a05:622a:1646:b0:4b5:4874:4f8b with SMTP id d75a77b69052e-4b548745199mr49131811cf.46.1756998766615;
        Thu, 04 Sep 2025 08:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfexEgP8sQlEIJFUeIW7J5FbH2QFW8cUdaODIrG/JqpdWxUT8ae9/MqXXjGOPpz0hvbSQGPg==
X-Received: by 2002:a05:622a:1646:b0:4b5:4874:4f8b with SMTP id d75a77b69052e-4b548745199mr49131511cf.46.1756998766207;
        Thu, 04 Sep 2025 08:12:46 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f77d6c4sm29848671cf.36.2025.09.04.08.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 08:12:44 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5e9efe12-0f59-4836-81cd-d39805f3b243@redhat.com>
Date: Thu, 4 Sep 2025 11:12:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpuset: Don't always flush cpuset_migrate_mm_wq in
 cpuset_write_resmask
To: Chuyi Zhou <zhouchuyi@bytedance.com>, tj@kernel.org, mkoutny@suse.com,
 hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
 <20250904074505.1722678-2-zhouchuyi@bytedance.com>
Content-Language: en-US
In-Reply-To: <20250904074505.1722678-2-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/25 3:45 AM, Chuyi Zhou wrote:
> It is unnecessary to always wait for the flush operation of
> cpuset_migrate_mm_wq to complete in cpuset_write_resmask, as modifying
> cpuset.cpus or cpuset.exclusive does not trigger mm migrations. The
> flush_workqueue can be executed only when cpuset.mems is modified.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   kernel/cgroup/cpuset.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675d..3d8492581c8c4 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3256,7 +3256,8 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   out_unlock:
>   	mutex_unlock(&cpuset_mutex);
>   	cpus_read_unlock();
> -	flush_workqueue(cpuset_migrate_mm_wq);
> +	if (of_cft(of)->private == FILE_MEMLIST)
> +		flush_workqueue(cpuset_migrate_mm_wq);
>   	return retval ?: nbytes;
>   }
>   

LGTM

Reviewed-by:  Waiman Long <longman@redhat.com>


