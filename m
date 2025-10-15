Return-Path: <linux-kernel+bounces-853756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D0ABDC88C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D3F426368
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD02FF140;
	Wed, 15 Oct 2025 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcBwNAky"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73018258EC8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503356; cv=none; b=aRuslGKEa1l+cIr1ykTaal6o+EUX5l5dMVPVZLNUgW+L3yW7BiEuNHuF6zrl86B3K72e4P9m6ZJOYWSdRa4bDaA2/U9sluLou22OoMYU8uLko9z8PeYZTetRcW1bwRXMVSaLy+6AGUQf+J8ZZq9J7JOuzXxvwSaCJ2RqMbYisw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503356; c=relaxed/simple;
	bh=+5ZF4RyJyHpvniDSxc7hWwmXqMHK28ij2c+CP1KkqKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BztA6hqILnggt6MZDIgyRsRd/fPdRjbW7gRa0r3aWCUGLlpnvfzgN7Z+BwoDnJhZt2EBwtzTaIIPuom25k1rEhrUVthHeOF2QoXpZltxKfySw/NvLKwvOEU8meDiPVj2zFmgZeJlNwUcD/P8bSx0uQXPFD86rmlAyhbjzt2NpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcBwNAky; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760503352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aV/fYRVLDrIHpgp6BZgVLDjuKKgLmK3HmKlkssBfu6c=;
	b=LcBwNAkyfbA2rxJju+KYGLgkr+iwHPyCo268+rrrcEmh98FYMyECRGaf4i8BK6mIv/rhuo
	ruvuJQhgdwKadXeEhKdkgT1nC3VQAGjB69U7fmUAz/CLv+f5fLqrYvH9pJbQb5oiKwYN4k
	D0nh7Ob/4x7pQBQH1NKh45xuhYAo9Y8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-dKPBB6F7PHeq5qkMVMNGhw-1; Wed, 15 Oct 2025 00:42:31 -0400
X-MC-Unique: dKPBB6F7PHeq5qkMVMNGhw-1
X-Mimecast-MFC-AGG-ID: dKPBB6F7PHeq5qkMVMNGhw_1760503350
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-332560b7171so485911a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503350; x=1761108150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV/fYRVLDrIHpgp6BZgVLDjuKKgLmK3HmKlkssBfu6c=;
        b=R5XQURzJGc3T5K7J0pWw68nWG1U+lICuWBEazn/iSBqvFJgv9mp2zUXBJZX4jojfK0
         R1diukSvyZ/OxY5mS8b1MA4vtwkab5sO7brGj1Fr/tOjNQIX0Bum3FxxoBTunIskYYbp
         Bv8TPfFWtJ4fgquJscCOE7r52stJv/IDY8ShnydCIvZPYyO6ngMGC7ARlkRfWOQjyHRE
         hRke3nztBsxz97O6SmPKWt/N0JXZMDwQ6YgBxmb5m2v3MZvWX9NZLFyRBzSX+BAUk0Kq
         Nm5DVos2MkIKaWQdCWx3a8UirQhsC0R4w/AvmopLO0xcPgCjC6/7I+7rSAyFNXYIk+Xt
         221g==
X-Forwarded-Encrypted: i=1; AJvYcCWB3kHmZXsoKpx8fZzs2fGxBXFNXkuxyHdVB8Cn8mEUEOHRnX+5R5O1obRAptgFdHMR6wpR8ME+U7I/CCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsY84AhE5zrFsMcz27q/tFm9EojHoYv1oGjAHPLSv5ISw8HY4P
	pW2+sd2Kie09mbllGZ8Giq/QRZt5CJq2H5Ww7AvODpa5Xk89byuUdy1WgvdQ0Z51yN0drk/JALI
	CUJ5h8sXUCKHFyc2nMuCrZDUUwyCunDYEUpM40z0cmh+iCp2A6UaG613Ll7ItKvct9iYlmVWK1l
	KVBWE5Baa+95QwGfse2lbJG63IstfLcWkXbVr7V79k
X-Gm-Gg: ASbGncsoveL6vqS5QxGkT7+Qz0oxicS10PWcF3c3V5pC3AzZeQKqcp/5KDzp7CMOnBR
	x5S1IHL7x9+DVOFGj9QBpGX851CThvQ3RjSd5eLOzT5bbXKJ1gEQi7eumAKOsTrJM6H7yM8kbwj
	siydesCNhKbmGs2MOzEczV7Q==
X-Received: by 2002:a17:90b:3b42:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-33b516770a2mr37677962a91.6.1760503349859;
        Tue, 14 Oct 2025 21:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/q3+lPQ5DLfIebWoXdeLkPswrE6RMbgEMJJk+z4itpaPQsFcdWz6AfYn4yR/oQPeypZaAuMRSSDbvWumqXk8=
X-Received: by 2002:a17:90b:3b42:b0:32e:4716:d551 with SMTP id
 98e67ed59e1d1-33b516770a2mr37677938a91.6.1760503349405; Tue, 14 Oct 2025
 21:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925103708.44589-1-jasowang@redhat.com> <20250925103708.44589-20-jasowang@redhat.com>
 <20251014050901-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251014050901-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Oct 2025 12:42:17 +0800
X-Gm-Features: AS18NWCAApHsVnDxGYBndRcoZtUTawY7kdOzVXOs0YEWXm7ivQ2w_lFD5C1Gm1o
Message-ID: <CACGkMEtDgs-JXvuTAbAJX2qcx5ZrkS=gK_4aw6bmxhQ8pLY4vQ@mail.gmail.com>
Subject: Re: [PATCH V7 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Sep 25, 2025 at 06:37:08PM +0800, Jason Wang wrote:
> > @@ -683,7 +707,12 @@ static inline int virtqueue_add_split(struct vring=
_virtqueue *vq,
> >       vq->vq.num_free -=3D descs_used;
> >
> >       /* Update free pointer */
> > -     if (indirect)
> > +     if (virtqueue_is_in_order(vq)) {
> > +             vq->free_head +=3D descs_used;
> > +             if (vq->free_head >=3D vq->split.vring.num)
> > +                     vq->free_head -=3D vq->split.vring.num;
> > +             vq->split.desc_state[head].total_len =3D total_len;;
> > +     } else if (indirect)
> >               vq->free_head =3D vq->split.desc_extra[head].next;
> >       else
> >               vq->free_head =3D i;
>
> So in order is clearly doing something funky with the free_head.
> It's no longer a head of a linked list of free descriptors, is it?
> what is it doing and why?

Since descriptors were consumed in order, it's not yet a list. But
it's still the free head.

How about something like:

        /*
         * Without IN_ORDER it's the head of free buffer list. With
         * IN_ORDER and SPLIT, it's the next available buffer
         * index. With IN_ORDER and PACKED, it's unused.
         */
        unsigned int free_head;

>  Please add code comments to explain
> both where free_list is defined and where it's used.
> For example, virtqueue_vring_attach_packed only inits free_list
> if not in order. So who will init it for in order? And so on.

Packed virtqueue reuses the next_avail_idx, so free_head is unused there.

How about:

static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
                                          struct
vring_virtqueue_packed *vring_packed)
{
        vq->packed =3D *vring_packed;

        if (virtqueue_is_in_order(vq))
                vq->batch_last.id =3D vq->packed.vring.num;
        else {
                /*
                 * Put everything in free lists. Note that
                 * next_avail_idx is sufficient with IN_ORDER so
                 * free_head is unused.
                 */
                vq->free_head =3D 0 ;
        }
}

Thanks

>
> --
> MST
>


