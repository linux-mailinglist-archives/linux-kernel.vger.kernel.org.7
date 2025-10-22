Return-Path: <linux-kernel+bounces-864167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA73BFA145
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFB718C73A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1C2ECEAC;
	Wed, 22 Oct 2025 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVOWVlso"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136312EC097
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111530; cv=none; b=Edvf1ZPndKiTJFb95UlDSj9nyFuj0IxUqOSxszA6B/+r+EcGzScdnKmQDGmzzmREOlitUnpxZJ6UvUTDhuIVJ/yXgWoc1GICtWMyMo/LAhBxE2iIxZMG9J0DfL4nvtZU6InXf1Ih+XabGYFHGZYyrwyKvolTty6g5KZA4pORNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111530; c=relaxed/simple;
	bh=BD0r+9duyb0Je7KN6QwZlA2llUYLAAoXVTwTTHeoZb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me+Ax1RpG8COPnWWrnqyOhoepFdWawYCCL0gf/jTNerERvQgHGciIvqwlw1kwbuyOSj1g8ONCM5jbz52sLwSp0gP2ZeSnyJEFZ1UOOieygZ58t/pryfGOJyzMdHcqurAQlkJFH5QislPabtjYejTPCHTwjZPmQlTuj8rBAILY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVOWVlso; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761111525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AO9bGgHA9SRDMxQBFatU3saNKYYbXbIllCsnpW+/KUs=;
	b=ZVOWVlsow3yG6J3+NqUOnBk1oJbPyS/sI4AEviEql0+5pAUrUytBcPRQ8u1RbIy8djeZGJ
	CCjj4WtHMcQjgeOQ1zHEW4ZovMQrkxr0fYJBvqY6orZkDIOD2HPJmCTp6+j6Iu6gqCTY0c
	vbq/99aVndx4j6NsQEd5mbSuP7fbt1w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-06onF-iXN3iVxiEhiFIIzg-1; Wed, 22 Oct 2025 01:38:44 -0400
X-MC-Unique: 06onF-iXN3iVxiEhiFIIzg-1
X-Mimecast-MFC-AGG-ID: 06onF-iXN3iVxiEhiFIIzg_1761111523
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-428565ab570so104719f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111523; x=1761716323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO9bGgHA9SRDMxQBFatU3saNKYYbXbIllCsnpW+/KUs=;
        b=nrfVR2DxmU1Jegb9zT4l93hQnaIX5uP1erDKFwbMHxi3vZErBSV/fqZpteHFbVcfLo
         KojfgQmyL5U4AScOPUpCEns0oYPQuOLIN/WOqk6z5OE2aF6rBi/p3VnHd2rKWWhm0Xy1
         HorMR/YhpgRHO2yI/OAPxGsTR2rfNKSh1x4kmf2rRe0KNEc+ldlo36npAMxN1n45evSw
         8CrA5lvkNzJ8MBDG6CSnDRcJ3OW/uPtNwefjql3+njiKow0MHZrJ4jkk6eD25AtwzpGE
         /Box5Ih/MGM3v4RXxeNIVlPBJYeIgCUVJMUNdW2ABdsBkI6MJcOzugoX6gqp8vT1JwLN
         8l3w==
X-Gm-Message-State: AOJu0YzrZZldLtGponbpdbWVRO9g1EelLAC6chWTANogGlhAgxhpW96z
	eCQnz+kLhbvB0U2tatjl/lGDKeptKE/iiGOPbXBGNl20TAV7dzdJBqj2RyoICY+bhIxEvORTaeD
	f14GuMmsUiSMuQHH51GKDVxvEnKkNLcoow8u1gy1tdHdXaFfZ8CXT+aYlOOMTJTcw7EJBxQ2DHQ
	==
X-Gm-Gg: ASbGncv1Prp5bG+DlaYt27FwXAWU6q0FV320VGntD9YNbNzvBLVMaBPkuu+sFDaJNWp
	QJI2vOtbzlwGYriIMj8r/ljKW+DMC2JguVs3nPi5cJydJP14uWaFGgFJaPhB3E0vQTbijhecF55
	dJhhux6LvyrWyt7vvi+BwVKT/ZXvTkmgmrO5By9cHQC7lw8MSxBuKmJwM7mt3nPiGyZNScS41ab
	GDBDEobhMToy9YmTuFquNptLmjatEYOQ3axbzBErUZWhg4y8c2TdBotfkejMARVau1qtn6FZhFd
	+RAUdfk9ysNaSPlx8xrMGYimc+QeBKia5AAgsggaAES1kYneKXPs7nBAEkRWtW+4kKsf
X-Received: by 2002:a05:6000:400a:b0:427:492:79e6 with SMTP id ffacd0b85a97d-42704d83d9amr12240055f8f.2.1761111523097;
        Tue, 21 Oct 2025 22:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjl/ZOfjT4Svi3ER983luOVRdvr+S2/sxG9MG9uyIZrwESjrcFAROjL57Mw6QZVPlN9sOhBw==
X-Received: by 2002:a05:6000:400a:b0:427:492:79e6 with SMTP id ffacd0b85a97d-42704d83d9amr12240028f8f.2.1761111522433;
        Tue, 21 Oct 2025 22:38:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm23976991f8f.29.2025.10.21.22.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:38:41 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:38:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio: clean up features qword/dword terms
Message-ID: <20251022013753-mutt-send-email-mst@kernel.org>
References: <cover.1761058274.git.mst@redhat.com>
 <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@redhat.com>
 <8138fb02-f7c5-4c83-a4cb-d86412d8c048@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8138fb02-f7c5-4c83-a4cb-d86412d8c048@lunn.ch>

On Wed, Oct 22, 2025 at 04:20:52AM +0200, Andrew Lunn wrote:
> > @@ -1752,7 +1752,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
> >  
> >  		/* Copy the net features, up to the user-provided buffer size */
> >  		argp += sizeof(u64);
> > -		copied = min(count, VIRTIO_FEATURES_DWORDS);
> > +		copied = min(count, (u64)VIRTIO_FEATURES_ARRAY_SIZE);
> 
> Why is the cast needed? Why was 2 O.K, but (128 >> 6) needs a cast?

It's not - a leftover from one of the approaches I tried, thanks!

> > -#define VIRTIO_FEATURES_DWORDS	2
> > -#define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_DWORDS * 64)
> > -#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_DWORDS * 2)
> > +#define VIRTIO_FEATURES_BITS	(128)
> >  #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
> > -#define VIRTIO_DWORD(b)		((b) >> 6)
> > +#define VIRTIO_U64(b)		((b) >> 6)
> > +
> > +#define VIRTIO_FEATURES_ARRAY_SIZE VIRTIO_U64(VIRTIO_FEATURES_BITS)
> 
> 	Andrew


