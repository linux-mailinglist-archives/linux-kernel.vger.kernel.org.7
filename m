Return-Path: <linux-kernel+bounces-826396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0BB8E691
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3E917C3D9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E31E5B7A;
	Sun, 21 Sep 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM9Bz1pa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865E28D82A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490818; cv=none; b=ACcGPhIGB0fKJFVVj5yJEjVq+i9YjIXA/sGUZ9zMVrFiXxgteLfEBb1nWd2hTCI0s1WMS1jWMdsGlBbjuop4mXj29xpOAHC3jHGWJQxus3rCf0KDRCfAtu50xJpMvtkkbcXUUhOTYzfFqjX7V7SWSqyEG/M3+RAv0X9S2LaGcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490818; c=relaxed/simple;
	bh=mYlu1Cb8XJxVfGYYbOwNf+5SlCKDDhSJhlXNvH2HuoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELeP/iYssdfWcTbwyDX8jst4uzXgrIL7qU2UmtWCnaLuplG8MkCVC49n6YT+yj+vgsgWgR7feoskqTbLI+htjExyLqd3AoHgVZLX4A2cjNikOA9kzmFxSKBAiMvapkUVML+MdHfGT7qnaPMIFupV2EP0rVSnl79LpP88fQH7z+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM9Bz1pa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjWDsw8BL0wSRiGtGTApSm/QghMD5iCMDJieH5fCE5Y=;
	b=CM9Bz1paAXak10/8CMGernAtA1TPfLKAHUzzipkVz5pSw3edUbLaW5GbFWZRl7KIaLxiDp
	IFPZBBx7LoHIjeJaQdkC+/4N2PaE2GA7121HX+YzhZQACZgjWZT1c8R2e2Rmkzuyptotjv
	O/siMSi3/CJJzhHgdNS9yNk3oUb+OxE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-1lKpYLXkPCWrPS3EsE3T8A-1; Sun, 21 Sep 2025 17:40:05 -0400
X-MC-Unique: 1lKpYLXkPCWrPS3EsE3T8A-1
X-Mimecast-MFC-AGG-ID: 1lKpYLXkPCWrPS3EsE3T8A_1758490805
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso558487f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490804; x=1759095604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjWDsw8BL0wSRiGtGTApSm/QghMD5iCMDJieH5fCE5Y=;
        b=l8DEyZ6wUt6xf2vqZlqg25prYeZ+Nj7EG87BPkSxYHQ2TR3VrBmD43GMZDBo2SqnMJ
         tcqdQKavN5Up24LJpKlILnviwXt+gVX38h/eg4V8uEn/EGXmv8N6s8lF3M/YejNegeh4
         kU5tk0LXMB9kbe4KayPkLBGeRimyzjtxNSPrmWwJm7nX2x7CiYgdf46PlBN8fIP8E8WG
         J5bF1/+N7y9PP48KTtmVtiOsU3UPF4HFLEWF5JoGRbg16SOsciuEyw7V1DQ/EZbkQl0X
         4UYv4+WmuYorn6Xc8CguSc7AcFhPuzdthRA+6tN5q9sfxxYpM3Uer1TXlb2pQ6VuQlCs
         C66g==
X-Forwarded-Encrypted: i=1; AJvYcCXmM1bnYFxQOnlnr97AUzjCDiWjuvBNyqQR/BFzjy71Fpz7Z13KcL0IKSY3RB1jIMDnwSFiJaPCCm08rXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTz1CZysqmb1/6zEcvAgf+qYvJ1DyLlCF8A1nTu3tE8z/tPQ8q
	2wFOM96Nfrm8BVslgHU3yYB+9aorHaJYOS6a6XLd61dKjwCIQCGOPqc11Qv8xiWx8OztqZJK57J
	OXb38auNMWfviruJAAcjtFmxiQt3V+n2+y+QCQ0GGvqiVi9N/tQzv1Bih4rFpMGqKCg==
X-Gm-Gg: ASbGncuKuhEP697zdSZhKnofYz1wONUKVk1J4WQbhKiwyVO+BPTmkQkzG8PxOWtJh5D
	+agC4bX3n/XV/45dtrwojiUFpUoDwBD9QTs1whN3zeBtSLua5fsXBSDqZeZn4A0sPzIYqfa3OxH
	vSBBDum1WNknoxPffSNZrfUhCTI8imvEunFDibeaYdiAhM1nON9stCL86S83HVZIg6FR9yRE/8y
	RytpC4Pvs5WoHxDbjhv7f2D4hghm4xWNoQiAut7l/9DDgEGoXVUBS7H1kkgrFtDIpqWzf9MZVus
	IwqHYzX4drhgRVjA5H2pIXmjK83beos4hg8=
X-Received: by 2002:a05:6000:2285:b0:3ed:a43b:f173 with SMTP id ffacd0b85a97d-3ee8585e3d7mr9640221f8f.42.1758490804608;
        Sun, 21 Sep 2025 14:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW4yYuHu/iRIBuAiq3TYquYa/BUUV5VnlAcln8dUtQI5Bcq9TDf+qyoforvTHvt2Z+XzLrWw==
X-Received: by 2002:a05:6000:2285:b0:3ed:a43b:f173 with SMTP id ffacd0b85a97d-3ee8585e3d7mr9640208f8f.42.1758490804220;
        Sun, 21 Sep 2025 14:40:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm17304749f8f.60.2025.09.21.14.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:40:03 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:40:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: Take a reference on the task that is reference in
 struct vhost_task.
Message-ID: <20250921173934-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <20250918120607-mutt-send-email-mst@kernel.org>
 <20250918181144.Ygo8BZ-R@linutronix.de>
 <20250921165538-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921165538-mutt-send-email-mst@kernel.org>

On Sun, Sep 21, 2025 at 04:56:20PM -0400, Michael S. Tsirkin wrote:
> Subject: that is reference -> that is referenced

to note i fixed it for now. just dropped "that is referenced"
completely. shorter.

> On Thu, Sep 18, 2025 at 08:11:44PM +0200, Sebastian Andrzej Siewior wrote:
> > vhost_task_create() creates a task and keeps a reference to its
> > task_struct. That task may exit early via a signal and its task_struct
> > will be released.
> > A pending vhost_task_wake() will then attempt to wake the task and
> > access a task_struct which is no longer there.
> > 
> > Acquire a reference on the task_struct while creating the thread and
> > release the reference while the struct vhost_task itself is removed.
> > If the task exits early due to a signal, then the vhost_task_wake() will
> > still access a valid task_struct. The wake is safe and will be skipped
> > in this case.
> > 
> > Fixes: f9010dbdce911 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> > Reported-by: Sean Christopherson <seanjc@google.com>
> > Closes: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com/
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/vhost_task.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> > index bc738fa90c1d6..27107dcc1cbfe 100644
> > --- a/kernel/vhost_task.c
> > +++ b/kernel/vhost_task.c
> > @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
> >  	 * freeing it below.
> >  	 */
> >  	wait_for_completion(&vtsk->exited);
> > +	put_task_struct(vtsk->task);
> >  	kfree(vtsk);
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_stop);
> > @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
> >  		return ERR_CAST(tsk);
> >  	}
> >  
> > -	vtsk->task = tsk;
> > +	vtsk->task = get_task_struct(tsk);
> >  	return vtsk;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_create);
> > -- 
> > 2.51.0


