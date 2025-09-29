Return-Path: <linux-kernel+bounces-835932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8BBA8611
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB49C17BD42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF0926D4D8;
	Mon, 29 Sep 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM0x5MeM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190C14B06C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134145; cv=none; b=PzbP1P5FeGUXZHtqOOT+fSk1+KX8z+LqVGRSCN2y+yE6lvxnXFRsB9q1Lv8d4D2YD855rpJwwdE7NHyH6CB32S+HfKqBznv1FB7UNhQqOkvfMkjjSj0l7WYDlotZGlum7u89tQVCyPjtkR1B8gyXBDW02p7Aq1I+a6NsatEtoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134145; c=relaxed/simple;
	bh=viVgC9eKfZfPegm5V32POE92OvmFgYwi95g9Lg+B1fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNWkTDrsl0Foo4lqUVKwwPU37HLVhV0lQgCr4VXi915EP0NYNGGgpQSJPE7dEcrQnn7s5q+tKYVMYX4Dq3BymebQI0jI8n3EYx6hx+FSuF96bUYLrxmcBKFWouDMUfK1DjcaGZSmjjo95sXUZIT9RgaJxqG53CtGEDemHIwCxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SM0x5MeM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759134142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GL/2dFIqy9o7LDqAQM77JNhA4n8xcsUmNbGqhHKd79E=;
	b=SM0x5MeM5LwNgOND16USaFEbI0iw1l1tofdD9vxydU23+vEzGgPT/WyMhfVI+V2lgfYxFu
	AA8zbOl3ZE6q/VDLjNcQA/25OnnPRh8y02PfRRvOtEYxAZ9s5Oj6FHhhXR2LStqnAl1YlH
	g7IRF5Dzh+wv1m2G4i0Cg3340HCekYI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Yj_T8zaBMl21Gu0PZ_kARw-1; Mon, 29 Sep 2025 04:22:20 -0400
X-MC-Unique: Yj_T8zaBMl21Gu0PZ_kARw-1
X-Mimecast-MFC-AGG-ID: Yj_T8zaBMl21Gu0PZ_kARw_1759134140
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso2606241f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134139; x=1759738939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GL/2dFIqy9o7LDqAQM77JNhA4n8xcsUmNbGqhHKd79E=;
        b=NJ/oUDeTuEyQSFf8+gcNqVz0V5D87L+oguf0VgdqiVtUySYJCUumD5BILiiGOUMlfW
         U5gpuJmPEtfBxImgKP5UrzHNxGq9e0lCzFgxJc7LQ6PuMGJq6kDHtFttVBZpthO3iOMX
         nZ9oBY+YxO7j6MVQMpPDrd8WrlIFDTcn9sUUYMN7MQrRBtN5Ox1qm7XOdUmR4wSHvQDw
         3YzCibWH83KgO6u1yAm5jlnjUuHn1QNqLna59P/izi/yrlz9AtJI8wkEJl2O2E96VRLo
         EkX3vaNMPKKR1rfT/PLLgTujYbpVyM/5rN7QyKaWmPOB+QXkM/CegViFGfwmZwzZIrEN
         X8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhD+1wGiK3r4bzhaPKXBdawTXzSGg+KkNmSCnVj5LxExvx1NX2tHdkraSmAjo2Dt4iA5RmoBqRvhQJyyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAR+3K7C4L6pBuiemgriJokI6sTp1X/gGla/dv253Vx3ZYYBvR
	l3WlyVnEQBakfQEXyLUJh+Ca71c0LPEur20sJ7tfsF6qLco/CD0vxo8gs28oIEpFj8JEcqgEM4t
	mnZVu6lrN7ODGdT1ucVhBSaWC7bxinh0on2kY4F2UMYU2Ao6T+PDfBu/YDE++UcrkbA==
X-Gm-Gg: ASbGnct2JpwxiX4kFmjpW5WEtGpP7codXBudyA3CKrd7bUxVQaJO2aTg1INF2lb+cTC
	CQSrAgh15PLkOYdgRzOds6IjeP/SlL05nL8WwZY6SICkkAIvKRMXYd5VFgEF7U7iipXFYxkROSg
	KiCy3mPwxQ+SsxbNU7fb5nGXpW1qgJmDYciXz98g+xV0EaklzdvVh6Qx8gaCtL2XFAlex9u7eeK
	pzy8BFF3+ztTVl5oj0CnCX2myIdtUDccPbT76Xlv5+Go22B0zKnGrxaL2e4E4ni72F9sJyCjOqF
	u7sgxy+jL85tFS6Gu4E+PA+1IBgc9GpyLg==
X-Received: by 2002:a05:6000:2512:b0:3e7:610b:85f6 with SMTP id ffacd0b85a97d-40e4ece56f9mr15052538f8f.39.1759134139574;
        Mon, 29 Sep 2025 01:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUiQuaFrIDh0CTm/I8TXBLiYezuIZtt/OSkVDM7sUXPkUT1zKLp8GDaA3T7T36q3fGutodtg==
X-Received: by 2002:a05:6000:2512:b0:3e7:610b:85f6 with SMTP id ffacd0b85a97d-40e4ece56f9mr15052510f8f.39.1759134139141;
        Mon, 29 Sep 2025 01:22:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f744b0sm3004985e9.17.2025.09.29.01.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:22:18 -0700 (PDT)
Date: Mon, 29 Sep 2025 04:22:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 12/19] virtio_ring: use u16 for last_used_idx in
 virtqueue_poll_split()
Message-ID: <20250929041808-mutt-send-email-mst@kernel.org>
References: <20250925103708.44589-1-jasowang@redhat.com>
 <20250925103708.44589-13-jasowang@redhat.com>
 <20250928192719.7ea3a825@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250928192719.7ea3a825@pumpkin>

On Sun, Sep 28, 2025 at 07:27:19PM +0100, David Laight wrote:
> On Thu, 25 Sep 2025 18:37:01 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > Use u16 for last_used_idx in virtqueue_poll_split() to align with the
> > spec.
> 
> If you care about performance you should pretty much never use 'u16' for
> function parameters, return values or any arithmetic.
> Just because the domain of the variable is [0..65535] doesn't mean that
> 'unsigned int' isn't the correct type.
> 
> > 
> > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>



I don't like this because it is inconsistent with virtqueue_poll.


If you are going to change this, change virtqueue_enable_cb_prepare_split
too.


But really there's no point.


> > ---
> >  drivers/virtio/virtio_ring.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 58c03a8aab85..4679a027dc53 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -806,7 +806,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  }
> >  
> >  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> > -				 unsigned int last_used_idx)
> > +				 u16 last_used_idx)
> >  {
> >  	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
> 
> You can't want that (u16) cast now, I doubt it was ever needed.
> Note that the compiler promotes the value to 'signed int',
> so the LHS of the comparison is actually (int)(u16)last_used_idx.
> 
> 	David

It is not needed because the value is from
virtqueue_enable_cb_prepare_split:

static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
{
        struct vring_virtqueue *vq = to_vvq(_vq);
        u16 last_used_idx;

        START_USE(vq);

        /* We optimistically turn back on interrupts, then check if there was
         * more to do. */
        /* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
         * either clear the flags bit or point the event index at the next
         * entry. Always do both to keep code simple. */
        if (vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
                vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
                if (!vq->event)
                        vq->split.vring.avail->flags =
                                cpu_to_virtio16(_vq->vdev,
                                                vq->split.avail_flags_shadow);
        }
        vring_used_event(&vq->split.vring) = cpu_to_virtio16(_vq->vdev,
                        last_used_idx = vq->last_used_idx);
        END_USE(vq);
        return last_used_idx;
}






> >  			vq->split.vring.used->idx);


