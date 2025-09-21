Return-Path: <linux-kernel+bounces-826376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDE1B8E5BB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C3916AC04
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1B28C860;
	Sun, 21 Sep 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9PuIA4R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673F2765E8
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488192; cv=none; b=VVPo27RsSfj65RF0uLx0x6QpJBvPu43C1WWoweVYFsin2X5XCqUdtSP1zYQOVIH3fXsabitmhv03cqt1pulH56ojcCZdrFGX/d2/5YzvRAgXh/Oi4P+a5vLzA5S1ge/nd1Z5tA0619bG1+WLm3k35iHEi07XoMMnVFDcB2m2peE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488192; c=relaxed/simple;
	bh=vcRE+eOSUt9r7QlljmvLF/beKVSKoUFncXZuFjVkhlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db0cUiKG1oPWjFfxHuxyKk2AMwZ652Kqqw1G23PIwfPy/q7Z60SEkObJdCpQWxNbVwzLxmS5338FMrKZNPtd3cRlA+i11MKlwpWCZNKYGugvKeytRqicyAVtC1tkOYxzLzJxzGj1+maCo0UQzPhdIC4ZIdC1GZNawPXxAEXzNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9PuIA4R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZa+gvlnzJbu0CdEMidkqaQp0dZ4QxQQFlF/kZd1gcw=;
	b=D9PuIA4R59s5xfy97JcL3y6euoq1F2CMa8kM3mVogSW1ShPnDN4wi8991BkTxPnlBATW1D
	RKgKeweF6gmLQex4etojGrLuV60h/AS5rzJQvHsyoZ1gDkf7yTpQd+kaQIVXp3Q6vmNTbZ
	ZKvJwnXHQBRMMrDatjBzVf6/xIECNd4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-t4lH_sxtNeKWgkGv3F9bAw-1; Sun, 21 Sep 2025 16:56:21 -0400
X-MC-Unique: t4lH_sxtNeKWgkGv3F9bAw-1
X-Mimecast-MFC-AGG-ID: t4lH_sxtNeKWgkGv3F9bAw_1758488180
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45de07b831dso22823745e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488180; x=1759092980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZa+gvlnzJbu0CdEMidkqaQp0dZ4QxQQFlF/kZd1gcw=;
        b=Qq54vxkhVgAruCYxL6ObdYeeStrZQqCowpdWssWwJPjzpmB3Hbbli+huDdliC9qOMR
         iNPpdb6maH48bbF9h75h72Tjv3tx2rnvInaCDyxbH/q5EEXeUtcDnoaLe/+qPueZGajb
         ItYK7RGj/JwiTz16DV1UaCHgtUHzsT4mriqFV7bXkLEfvVxhsKaCV80ymhOlpt3qJgmJ
         m9etfyqPJXdN6EguY4s+XiZPmrw/mGIKPXw6JgCOmw7A5NuQJRrpAstTjbGiHNqq6ITg
         Y70pfhUQOUZfT5iLAoo4pboRfUozAVGY5UFsPYYPuPJrk0xH20Qi0vSZG9wK18m7cdu0
         p6cg==
X-Forwarded-Encrypted: i=1; AJvYcCX7xx8j1Rze5LefgXZrzPeJUMe4hPzf4BmffHkxwmxYmWecKhUgoEAsLJTCQtk1T+3L8JV3s/DP0YRxKVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi7gV+TK4ID4kTwIzXfk6yBycQEZNehZFmOfwG1FHFguNyDsaZ
	EZ4+f61t6+jsYzskdpUPF3991eilRi1K0/Fo09GAam7FEigSN9cWaWSz0jGEqDsJ5+MAr1XAaal
	hSnCTUrbmxFTR+yOLCG5hB4kYTNtq0B1JyGsDsHWWYvovXXKDQZb743IDwFp8aYU+Lew1j0z5eg
	==
X-Gm-Gg: ASbGnctzdIcBNPHiC/brzFQv1+vAZRtE50ffkgTXQK4pQeco0H7IR3M93oQjbRG35VO
	HdS3QiH3+mZFkeUvAFER7TZbU9i4YCnVbuEmno5e+sKnUw71NoCuO72k+uRmk2XGjZXrlH4MZ5B
	/s372LnGvtDNYlikPv5tHgSYzI8HBZfPg4chyfOiqQvOVAQBHmBel+AQis78x7cJnrhNE5y9rrS
	z5Q9URElhbkkglLubzwR/V4FOSPEfz/Wzli4miN/9epdr7MkoF4N2eUU3lHJ9rIrfc5mwz/WPmF
	nrJXyN2QZnj6DMEFvrxcL5Cgz7lHJFe1VYE=
X-Received: by 2002:a05:600c:9a5:b0:46c:e3df:529e with SMTP id 5b1f17b1804b1-46ce3df54dfmr9206405e9.19.1758488180274;
        Sun, 21 Sep 2025 13:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnqwMssDCjhijdZ/zRsJjF/aux8aMPTu3vT6tEWO8ityPhOqzUTeSFi2aStyrPs+FMZNaF1Q==
X-Received: by 2002:a05:600c:9a5:b0:46c:e3df:529e with SMTP id 5b1f17b1804b1-46ce3df54dfmr9206345e9.19.1758488179887;
        Sun, 21 Sep 2025 13:56:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f321032a1sm131335005e9.2.2025.09.21.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:56:19 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:56:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: Take a reference on the task that is reference in
 struct vhost_task.
Message-ID: <20250921165538-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <20250918120607-mutt-send-email-mst@kernel.org>
 <20250918181144.Ygo8BZ-R@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918181144.Ygo8BZ-R@linutronix.de>

Subject: that is reference -> that is referenced

On Thu, Sep 18, 2025 at 08:11:44PM +0200, Sebastian Andrzej Siewior wrote:
> vhost_task_create() creates a task and keeps a reference to its
> task_struct. That task may exit early via a signal and its task_struct
> will be released.
> A pending vhost_task_wake() will then attempt to wake the task and
> access a task_struct which is no longer there.
> 
> Acquire a reference on the task_struct while creating the thread and
> release the reference while the struct vhost_task itself is removed.
> If the task exits early due to a signal, then the vhost_task_wake() will
> still access a valid task_struct. The wake is safe and will be skipped
> in this case.
> 
> Fixes: f9010dbdce911 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> Reported-by: Sean Christopherson <seanjc@google.com>
> Closes: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/vhost_task.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>  	 * freeing it below.
>  	 */
>  	wait_for_completion(&vtsk->exited);
> +	put_task_struct(vtsk->task);
>  	kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
>  		return ERR_CAST(tsk);
>  	}
>  
> -	vtsk->task = tsk;
> +	vtsk->task = get_task_struct(tsk);
>  	return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);
> -- 
> 2.51.0


