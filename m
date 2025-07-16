Return-Path: <linux-kernel+bounces-733161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F1EB07107
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE8C7B11F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD782EF9D8;
	Wed, 16 Jul 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmWkjtNG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B01248878
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656342; cv=none; b=g5PmsPEIZwAz1ggvDfhEe+IKt35KAA1piM0/GXBRLAfIaVgjTaX5UkckfYd6Z579uZJ9+XssvHn1l7HRiG675cKgZIjjjmA78jKB2t4qRqPXZ653X6rypnBAltVaIckD14OKlVwcz/bLgZVkpKnBiJRblM2zGjbhtpVjiZH+VzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656342; c=relaxed/simple;
	bh=k/xKLRmdytdD5dFxCZPED+uv6Wm4lSnJRb0jKkIgcTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucwogCculMSKKkkx7FZ/jiH04Ho4KhKwItzrJo/3FGSsu4slGbxDDny7DeuT8m8KL0yzpBWGokzfDZa0i4tWO2UV1nuHxBBckB+vRW2Lq9BulmBjiLJqdHNAOO0EaWVb+Mc4VDWa+C5H647IXzyM4kqsQkFq3xbQ+Lean6vnCXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmWkjtNG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752656339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BzMG3VIcZp7IpI2SiaxGZq52jq3kQ6ab3CdN8rN3Rxw=;
	b=GmWkjtNGpIYrlC/z2hGoci+OnhaQZCC1791vckyMFDMVlshS6WLyhE96h9zpOijYIvB6Co
	uK0fhwzmjkLW5IWuS0Bf5ltEC8aDfOmVH8CFamSsuhpqdar70WB0RMR32fB2xoScgFqOVR
	LniLQdZe2dCjER2wUg2aVLAn/WwlUYA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-mBXAPudfOASOFGhHS5SjNQ-1; Wed, 16 Jul 2025 04:58:58 -0400
X-MC-Unique: mBXAPudfOASOFGhHS5SjNQ-1
X-Mimecast-MFC-AGG-ID: mBXAPudfOASOFGhHS5SjNQ_1752656337
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so3799360f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656337; x=1753261137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzMG3VIcZp7IpI2SiaxGZq52jq3kQ6ab3CdN8rN3Rxw=;
        b=QXECvaupWf3gU/qrPuqFKwJkRHEYTmKM0CVdoUolq9fxLksci0FpC+dRl/F7krxv5A
         6CcdUJd8YblIIxXeoeQb8PoVH3q6uauCh7WN0slv7arftXIzAb5ymSbm3SpOAcdfs32J
         8dKuQOLMJtEvyVg1O4Vh8tvuFE6lQGT3cp+PE1Ky5pgg3RSTIC2niW7VgpUwCILUnRbI
         VVgKBvtOircJd8c+jKIcN49v+iKwL0naLEcbZJ5ESVOMgq52K6Owxr888b9UvZXgnVUV
         2vMhmhE8MJUHOSn1+qH0hew/7pkak9k99qCgFKF9+A+OrLwkwV5dGd/ewKiAU9l8gQik
         y/hA==
X-Forwarded-Encrypted: i=1; AJvYcCUGfmJiTrIOsWuNRiv7nR1moARBZuq3KXlX7qoVtvW9RLJ2zEd3j1zbNrUrO17Rj6HMVNq+juWqVgcfLO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1D0LG9X31Zna7QcNgLVTpe7XL+1zHN/WkNH0ud16rZ0WQLAS
	y89XlLH/Oek2kDWqF5NBQlRj4Peg8HWWnk1iGnUnF2kiWzVyUJFx1ktiKsyifIuN2t/vUnx3QON
	vUEp6EmABymVcR1QSlxaTbi9+pK5j17hg/JS/uucI0PAaRrC3EYerfyaTkE4n9IlCUA==
X-Gm-Gg: ASbGnctOCaqSnyFXYWyfA8979jKfgkfXZOEF22dzq1I5heeFbwB4+itCEPRa6WBKnjn
	N0gi595y8DQ/GWGN6qkFGdPa8MkeLi8T6M4Xy9dm1/SiNe+p2ghl2Z23ys6SPZqWCZqcjPm4+aq
	VKabfGHnfLw+zWl6MSzwBrYevQb4SevUV3jnQ1L+yql9IuBJrk06UJGDqiVbbhjidYV5B4s6YmX
	niM26m5qE37GirOhT36tQ7AxPoCRqQNSiY2tQQHuGJkodS+FsHWiPDucHHJofcHYocHzIyzEGsa
	74RBo1Qa2Qf1aVjkU32DGCc90s5PAucR
X-Received: by 2002:a05:6000:2087:b0:3a6:e1e7:2a88 with SMTP id ffacd0b85a97d-3b60e518b33mr1415221f8f.57.1752656337279;
        Wed, 16 Jul 2025 01:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgFM5T6msjvz4eBt9JJxEEAvHAo5VJrH/1JPYb+hX9XJmhxEwUw9K86spL5EHzREJnWORrmA==
X-Received: by 2002:a05:6000:2087:b0:3a6:e1e7:2a88 with SMTP id ffacd0b85a97d-3b60e518b33mr1415197f8f.57.1752656336811;
        Wed, 16 Jul 2025 01:58:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d76fsm17596638f8f.64.2025.07.16.01.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:58:56 -0700 (PDT)
Date: Wed, 16 Jul 2025 04:58:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] vhost:  Use ERR_CAST inlined function instead of
 ERR_PTR(PTR_ERR(...))
Message-ID: <20250716045841-mutt-send-email-mst@kernel.org>
References: <1a8499a5da53e4f72cf21aca044ae4b26db8b2ad.1749020055.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8499a5da53e4f72cf21aca044ae4b26db8b2ad.1749020055.git.xiaopei01@kylinos.cn>

On Wed, Jun 04, 2025 at 02:55:48PM +0800, Pei Xiao wrote:
> cocci warning:
> ./kernel/vhost_task.c:148:9-16: WARNING: ERR_CAST can be used with tsk
> 
> Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...)).
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  kernel/vhost_task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 2f844c279a3e..8c4a82c0bdbe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
>   * @arg: data to be passed to fn and handled_kill
>   * @name: the thread's name
>   *
> - * This returns a specialized task for use by the vhost layer or ERR_PTR() on
> + * This returns a specialized task for use by the vhost layer or ERR_CAST() on
>   * failure. The returned task is inactive, and the caller must fire it up
>   * through vhost_task_start().
>   */
> @@ -145,7 +145,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
>  	tsk = copy_process(NULL, 0, NUMA_NO_NODE, &args);
>  	if (IS_ERR(tsk)) {
>  		kfree(vtsk);
> -		return ERR_PTR(PTR_ERR(tsk));
> +		return ERR_CAST(tsk);
>  	}
>  
>  	vtsk->task = tsk;

I applied just this chunk.

> -- 
> 2.25.1


