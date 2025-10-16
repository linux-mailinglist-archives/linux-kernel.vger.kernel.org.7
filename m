Return-Path: <linux-kernel+bounces-855532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B78BE18DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1405C4EF8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB4239E63;
	Thu, 16 Oct 2025 05:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYVhTT2g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1282BAF9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593539; cv=none; b=akY6C8BYshVDiNdLGxMbgIu1ZgpXM8tHe8iJ4mEM/NMHKx2y/nUzxf4kVakwiECL4hWKYOKC+nWY7Pgw9eB4k3z/KvCHsNablpxKIH9RfAHFjXjsbfbg6FT8QskTOZVPZvedVrdwY+Y+eU2ni6EKSMyxLLMs3aftUFHQXIU8mYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593539; c=relaxed/simple;
	bh=r2fTEOjoFnPVv1x53F0vcfkzpwq24TElbV+k62WXsaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0k08Tv+sttlt8CWAeWLZzq7rTagPoSbbVQwWoxIXXsBPgaRScpcjMaxO5bmL7vcR6iHIQqPwyAppsU9sOWQnFpe3POH66eOAfYIap1f3aG4X0h3MkVFmaQFDrqbYJD0b5488qyZVr8mcpi8hxAv0EhNWSj92jhPPJHJtYXsMCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYVhTT2g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760593536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hln+Mh7y31shW7LFq2Q8UORyGgt35tPk5kgAnX1J3oc=;
	b=aYVhTT2gB9A32MidIi63JWAg0eMOAlS8RFRPJBlhfq6QToCuzqyThZUXVqPsgeDmwxADbP
	ESU2zwYd/E0oiR7AIeTJGM5nVTsUe6y8OVuH4QUC8TOdc6L26k/PPKI2cJ1lDRzXq0E9Wv
	8IbhKa2FBISAVSehxhPfG5GqDra47ZA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674--5Z4L8AqP36bbU7hxReS1w-1; Thu, 16 Oct 2025 01:45:34 -0400
X-MC-Unique: -5Z4L8AqP36bbU7hxReS1w-1
X-Mimecast-MFC-AGG-ID: -5Z4L8AqP36bbU7hxReS1w_1760593533
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47114d373d5so29705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760593533; x=1761198333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hln+Mh7y31shW7LFq2Q8UORyGgt35tPk5kgAnX1J3oc=;
        b=oJabfsyz6I/yuN89waDR64hr1zblemSqBMRX17DPRwGWbIYhOnHgPh4ZJoxh7vBLT4
         uMtH48Z3avchodYM3J69mq/uN0JeOEjaxD6KpnhkpEl0J7uWW1R+7FSROqQjuHbTd5Zz
         hZnc4fjMqxfk9RVxg1UZbitSxZ9cuv/Cum3/M+kijx24LWpAZlFwvMbs1bsock3/79tZ
         twiNS6eMhwIWvtsh2BP0F49cXl40Pb82l8FsrR/oou4fsSO6w4q2rH0yNEjrgyl3oDw6
         thEHSD8gitN1CUL24O/2lBIB14q/VEx2+Fj8/WL0epRHkHmvex3nQpBq1rS99JIsiQtB
         DDQA==
X-Forwarded-Encrypted: i=1; AJvYcCXrOVkerJf8B3+eqMX5wTK+Yx9UAAV1RHUC7UQTVOvsvp0cSmWJwX4BQDWhBt7xrB5hJ5zZSg/Wk8qZbbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgGWIhVj6ySLlMSefSIYTtS2a31NpBt7y4ucW8t62Jn4vDvdX
	lmyAItNuAvKwpgTsuIGg8nD5wzBoVD+6SyG1/+uXUYCcehi3FmUGlKq2Pin4NP4xW/0m5A67Lx0
	EXHIxrN88ijPkf6sgcxyeR5XP6smXY5AGCUju9iXQAnEG7LmtUgWAoq+zhZGeZHGe1Q==
X-Gm-Gg: ASbGnctgV5hV2hqRRYVe/ZOJ1Aa8PUK34ochcKSD+WTQlX9MYclYtGBuVk7GdxZGDPZ
	oTVw54nuhd+9UPRxTLFUnoLLIBpk4ipHO6iDYtronnw1q30IbJaqfdJPZYtP6s+W2yhDtGUJ86m
	gKEvFwI4xzZ8EYZTTLplBF7TF0+gfsfiBsQ3GppsPOjNxEQV1AjJHDOwVoW76UIbARS1OmsFhM9
	Vp6ZGb8z3pIxjDXcm9QMDQi3Dlj0WMR3D3yXR8qFdOrUJ8iRdPi/dlONbGNcdAQlZOjt9RcG73f
	iXzXq3CkBRDVxe+EtIEGzhXqR+MhvRUnsurWQEdFJYcxPYlWrHSnUczik1f2N0QlRHfq
X-Received: by 2002:a05:600d:a:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-46fb32e4c1bmr146181585e9.1.1760593532913;
        Wed, 15 Oct 2025 22:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm2++Ga7HqP6xO8R+d1IdvHTPsPVi8E4+KUc/IBWMBsgRUIWmXYBIDUaPDdGLmuf07U44bfQ==
X-Received: by 2002:a05:600d:a:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-46fb32e4c1bmr146181465e9.1.1760593532483;
        Wed, 15 Oct 2025 22:45:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm32099660f8f.35.2025.10.15.22.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:45:31 -0700 (PDT)
Date: Thu, 16 Oct 2025 01:45:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251016014328-mutt-send-email-mst@kernel.org>
References: <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>

On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > >
> > > Not exactly bufferize, record.  E.g. we do not need to send
> > > 100 messages to enable/disable promisc mode - together they
> > > have no effect.
> 
> Note that there's a case that multiple commands need to be sent, e.g
> set rx mode. And assuming not all the commands are the best effort,
> kernel VDUSE still needs to wait for the usersapce at least for a
> while.

Not wait, record. Generate 1st command, after userspace consumed it -
generate and send second command and so on.
But for each bit of data, at most one command has to be sent,
we do not care if guest tweaked rx mode 3 times, we only care about
the latest state.

-- 
MST


