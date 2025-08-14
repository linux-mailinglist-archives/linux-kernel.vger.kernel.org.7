Return-Path: <linux-kernel+bounces-768600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55867B26319
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011065A6F37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38CE2EAB86;
	Thu, 14 Aug 2025 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnfDEpGL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8AA2E7BC8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168144; cv=none; b=nn0ofJt7hcSeJZsWscb/Q8bKPyF9pTmHWhmNRTy01IXNWCDmdJk8huEMK1rrkgxSvSROgP0oL9SXS12cLPXd6/t2vpTDb7+/UdEVaoy09y7IClu1d4XDfDSDYfPCz7T2LzUg4Gdir34q5aUc4RGCA8qIf5sl8lUJrmE98XA9kDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168144; c=relaxed/simple;
	bh=NZEGr2QeyUxRWwugsIcQDl4cNFKSjIiz0H7NjY0LWuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi1BJyr1fMPyBs3P8x+RbiovJBQWcDlW29fo+5SfOtj80GUPNQgooY7NSnQsI1vYLR0igtxuKP9L62STt+oFozRUkka7M6pKIkElbErtHQ8aZ+9uSo+NtVaV7p+yvmvMtyVvTjwA1Adsf20WVzULTjrHm/1Dt/d7ARPS+bSBRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnfDEpGL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755168141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT5Tzn19cqg4hmQfGcslJH9hMAr6Q0PLi1IKh5xD2zI=;
	b=SnfDEpGLVBDJsjYue/B6E/omYAluQ43nu0PIrKQuL06NqVcbOVakN4WmhnMG3pBvA6g6kh
	ghE2P+2peRcXvD2e1JE5kGTgOy2GXnQbILuAkGXS5mrqV6azb26IYNrtrrzAf2w37uEZ9e
	im5/Wzwv4YRY194ckeNt2vWCmQM3L6Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-duGt4pAGMDeXl8UJ8C1A0w-1; Thu, 14 Aug 2025 06:42:20 -0400
X-MC-Unique: duGt4pAGMDeXl8UJ8C1A0w-1
X-Mimecast-MFC-AGG-ID: duGt4pAGMDeXl8UJ8C1A0w_1755168139
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b04f817so3138095e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168138; x=1755772938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT5Tzn19cqg4hmQfGcslJH9hMAr6Q0PLi1IKh5xD2zI=;
        b=XWKKSeXul8v1dN8xJodj9vx4J2ReB0Bxscipz31c59J6kquKPe0hNDcQlz65H4qd/C
         6V+U3DWmBAsV6HeBfPWfUns9ii5XGU0w4GE3Z/OdZIncVbSxQSOvE/X0i+2w5eGt+nCW
         OnEW3nQf0bylNc7/F6nlDGLagX70gbWIHdnl35vZaFWZ+eHHZiwC3NB/UP8NsJjmZ9/8
         lk1cTIKaMx4KGtn8grF5xY9ly9ft6zQvFXVx2kM5R0t9LAielp1TzxQ1dyFLkvF3qgS5
         m51QuUw2kiYyeNbNo3istiS3g1oYw5nn3yiXT0SaES655AglZSn63ep7mbb+OsImzR5Z
         zDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh7bcKdd8I3Y4MgANps6AHFl5e38l2JKL6I19yuSOxu8V9gtr6UUGyd32pJUu9+3OfeXb8TQ13Nx7PCIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcV0e2H2kHcxI4oKaRtWjusJqnlqk6BzCwbmSXXqTrE0GiovEQ
	c/Wq3wnQAqHorPhxAw1lvcjME6rCp/YB+Va9lpwc04OfxuQUfZzXTozKggMd32t/pLxvSEakgIH
	jbL4V1FxjPNVt9q1AIRpeG7hY8J21KhPl61xhhACLfhmucGGlziXL/et5TF12JN+mqQ==
X-Gm-Gg: ASbGncsxybpoE6iiGf9KSbz/GWHVj7GQEenM0xEnvCPiKikYeEcNDhlSyQqUmSVKaGF
	WGUfyItNfDOao2Z2ZncmbOxngDpAlaiQWb5BaRcCWqo+pLpgBl/6CqjPRV+DFlbEqLS8pRUfxuh
	1Or2GMNlzt6JsOsHUqXmkP98JecTSqAb6O2mQJa3mVpRHZ4DnP1Yby5JrchKe5m5qHUAry8jxKE
	NRR2KUJzNoJw1Uq+F3Y+AzFQ9v4fLYKsoRev6KQoiDnXoadH9FKy6mMaOZ1WMUnTmDxYYknLhF+
	gCIyxyQZW6Jd7if4O6fjssscZ5y9hgw7uwk=
X-Received: by 2002:a05:600c:a06:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45a1b687253mr23970575e9.30.1755168138562;
        Thu, 14 Aug 2025 03:42:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9mCEyeVUFOpZlzFS33KyQN6euUVxnMFYMC8qwFmmhan4Sd4sDTaAq8nOK27r6IHm2BnFDpw==
X-Received: by 2002:a05:600c:a06:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45a1b687253mr23970315e9.30.1755168138131;
        Thu, 14 Aug 2025 03:42:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d6:5500:f926:f5f2:d44c:9bbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cf151sm16626985e9.8.2025.08.14.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:42:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 06:42:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
Message-ID: <20250814063927-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org>
 <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>

On Thu, Aug 14, 2025 at 11:36:22AM +0800, Jason Wang wrote:
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index addbc209275a..37029df94aaf 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -40,6 +40,13 @@ struct virtqueue {
> > >       void *priv;
> > >  };
> > >
> > > +union vring_mapping_token {
> > > +     /* Device that performs DMA */
> > > +     struct device *dma_dev;
> > > +     /* Transport specific token used for doing map */
> > > +     void *opaque;
> >
> > Please just declare whatever structure you want it to be.
> 
> It's an opaque one and so
> 
> 1) the virtio core knows nothing about that because it could be
> transport or device specific
> 2) no assumption of the type and usage, it just receive it from the
> transport and pass it back when doing the mapping
> 
> It should work like page->private etc.
> 
> Does this make sense?
> 
> Thanks

I fully expect most devices simply to use DMA here and no weird
tricks. vduse is the weird one, but I don't see us making it
grow much beyond that.

So I think for now we can just make it vduse_iova_domain *. If we see
it's getting out of hand with too many types, we can think of solutions.

-- 
MST


