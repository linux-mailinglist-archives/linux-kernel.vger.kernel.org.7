Return-Path: <linux-kernel+bounces-823091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B6DB857FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906961B25B41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5233C30FC0E;
	Thu, 18 Sep 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbjL9Her"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95B30DD11
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208155; cv=none; b=LlzcDXNQoAgNgVyGiR2qRU4Mf0BjuDvrLZEi2+Dh8yQi+Lz0SPI8VlR7N1A89dypMj09yPg6wmizWU1flJvwXYigxKnmrraEpI+wzBoix1DJtFoyHCW+MlRNQwseVc5CmizFUyoBnpchOewVGEY+g7sKkPt/TYLOCeLYXyUR8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208155; c=relaxed/simple;
	bh=48WfDspnNYYwY+nqsrybAAO10uUojF00QMRofRzWMNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2pLDNU6zwL/7Y8yqjyMIOZMhznvqxuIzPW2UZ4x3K8rfPZdnK7aWX0uHM4qSFAHTWy1+OGCHf0aCVDFJZZeF5O62uw14AxImNfgET8Bw12Y4lGhZhIdlJ3Y59AU6ddlQXY3XYOoTpIDym4v0QEC73U/boYyQQ8/Q/cnhlKMH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbjL9Her; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758208151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Okp6kP9+YlujH23hoSs0Wy/CFE9uS+Y/4tNJyV9DleU=;
	b=CbjL9Her5yuI5edkX7ROGHGFTq0qx5K0LDnUBUY5j368MEszgg0Zf3LmT5AeBBgZX5I9BK
	y8GC9uw6fOPYUiQiCESOkpAPbdiMPGOTDBsh2zz5HWjuQYNjw6zfVZTWUnKEqBVtjQyTPf
	4Sm2qyqCkT/o51h5hTfLWsoZcPXaM+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-jmLSUkzqPZSt7koAXvvm2Q-1; Thu, 18 Sep 2025 11:09:10 -0400
X-MC-Unique: jmLSUkzqPZSt7koAXvvm2Q-1
X-Mimecast-MFC-AGG-ID: jmLSUkzqPZSt7koAXvvm2Q_1758208149
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45df9e11fc6so7729505e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208149; x=1758812949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Okp6kP9+YlujH23hoSs0Wy/CFE9uS+Y/4tNJyV9DleU=;
        b=bG4x1nHY1pGETnsQMyoCeALkMGVYLUjwbM05kKNPwgLMDjKa8LEg7EmFq7g9SmH6pR
         0XwHmmaGSN19tMn7GnMjpq7UnZ87xJa9u95VWqBxA4gT1QVW00iGAK3Mjh4LvQLl7kD3
         +R7418f/rLsinLpFa4hr/q6wPpAzUlYRNyAWeE43mIjMhUBC4uTDUmMzmDRRLGenpXL5
         1pxQp9n/s7makff2z0Vf/kpEO1ySjKMJ3uy6y9utTuA1QTx+7p0VZKXV/s4lbkOabeD4
         LNrdmlpGkNvWvpTN+Y1mN7bW1nWehrtS0O6pxLT4qpvg57qsYhCwnS/niDhxpQwLOiVt
         9QZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqaZyAaaYRga1U9Ih3zNqrqs31yz6nOKPpJdOmmp7YqxNSlzvCnxVbdi6Ntl2hRtr7ntN9pkxX0iLDR/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHVaYcOrp/Eo8TYx8umofI+6ReAScjOEhuwH1MwofXAww9fgV
	0Esz70pzp1VQpwQuT0czDMtZWSuHUER9SSJD9aBFQU4Bfz3dFcQpR8pfgG0TNjCw1VhUytp8Bo2
	C2sowNk98BtmqRCTlCau2VF3C3NvB4XBqRI7yU1KUhzCiCsqTCGCkH9XZ6M8oLx/BfPX11GlB5g
	==
X-Gm-Gg: ASbGncvOTcimH3Cz/k0mr1dfqSjh/6e+RmuMyQPDVAA5VCjGGD2CfWXZWFOk0ksjQsa
	1A/kB8b+aEkj3hB5lE1fifsrHOmGTdaAzNWbsQ864r3jwim1O2yVStIx6hOgusbJJwb5XATU1Ni
	YXM1y416Ja+FwTHwd+J/hkSzBghmQS+NGBecmBoK5qVjN9PdFG2Sz1htTBUX4Iv+YHqVuCm82i7
	Ey7ebeax+wVYvHGwpnp4y3FYi0Nu9o0GYdEthhLZJPl9+BJObmMsVJmVoVWbDPAqOXWIpuM9Nnb
	xKKZzpFR4tckAS2khg8v8Kj4cy2dnjieZgo=
X-Received: by 2002:a05:600c:3b0f:b0:45f:28c9:c4aa with SMTP id 5b1f17b1804b1-46202a0e8b9mr57240865e9.9.1758208149047;
        Thu, 18 Sep 2025 08:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4pxOb15HbXf6kQkik0F3fAf2Q1845KsjAT75QUOI8d0zEUi3a3iP8sUQbUJhBuS6AvT6fxg==
X-Received: by 2002:a05:600c:3b0f:b0:45f:28c9:c4aa with SMTP id 5b1f17b1804b1-46202a0e8b9mr57240595e9.9.1758208148642;
        Thu, 18 Sep 2025 08:09:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f41csm52209105e9.15.2025.09.18.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:09:08 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:09:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918110828-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827201059.EmmdDFB_@linutronix.de>

On Wed, Aug 27, 2025 at 10:10:59PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > Michael,
> 
> Sean,
> 
> would the bellow work by chance? It is a quick shot but it looks
> symmetrical…
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
> 
> Sebastian


So how about switching to this approach then?
Instead of piling up fixes like we seem to do now ...
Sean?

-- 
MST


