Return-Path: <linux-kernel+bounces-851146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7B0BD5A75
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B315F408045
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2F2D0C83;
	Mon, 13 Oct 2025 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU5CRz/0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB412D12EB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378847; cv=none; b=Xgf3zot2iabufJ0vZZSMdG4w2m8eLXeZ1D94T6Jcz2G1kRZo1NrHRSmNpKlQMzD/NSayLNWSMwkwIPoQNFthzLMNHer7l4Yq1Pg+y7ZgChVb9LLXWxR/5d8tU1ZmgJ/cawjbVBo7cn7mx72+OP0buFqxw11EAwf63BMfWS7Te3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378847; c=relaxed/simple;
	bh=ec468sUdlPior92fEOwciycgEdPP3rJJ7JplWSCISIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDtABgNJRr19z7WW0uuTr/SqBiEJGHFDQrcZb3kPJ+iN4lkoAE4FTIdzLhEF691DVatv6YtFyIjYd4ma+d41JN0hmrqZRdHwEubRHGzLN/4cHMGOl0INDhHOLxZXHz1PGFAIAfXC4gg0F9YogkXV2dtHKSmQsJNr9s0ocfa4gCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU5CRz/0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760378844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=heV73gvBg4o6OaIEpLpiDR+pemy/KAioE642ZBmJkl8=;
	b=gU5CRz/0BmBIvhz/HS4vUSlBLoxRh+YzcQjFe7ZUj4VL1uhk2cpHr12nw4DtOP9z07le9I
	Vv2gvMt7hFmSFXkq8V7l1yOwsp4rdsSW0bMi981+F7bA3neuV1T8sPR8krM9NspvGnjk3v
	jFPwqaBhwpF17Bga63iVxzwKwau4sjM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-1CDAH4ElOXqzHVl1-ROvbQ-1; Mon, 13 Oct 2025 14:07:23 -0400
X-MC-Unique: 1CDAH4ElOXqzHVl1-ROvbQ-1
X-Mimecast-MFC-AGG-ID: 1CDAH4ElOXqzHVl1-ROvbQ_1760378841
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e45899798so30289805e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760378841; x=1760983641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heV73gvBg4o6OaIEpLpiDR+pemy/KAioE642ZBmJkl8=;
        b=hgGLw1W1Z3YoFLn7g1mIqVdcW/CyGN7lakfXEW4XegcnzFjALtI1MSbaDVvVo+ckVt
         ezL+iuikag/+zvnyIsGjC+Aj8fc0Y3RjidnHpwiIDCKdDVTFtcuzqutIDqd+YkGd7Tal
         ywpv6m4cpNmab1aMSIfEPrEjv90Lv7ru6opmjXKdKsEA+B9i3KuKGrCveT50SRxbhluv
         24eWkHu4AmzF82noPlzwx9pG5OsyWeb2WwDqssvK8RYaKjfNETCd75g/91CjWHrUimB8
         QbpL3IH8rN1Z8AP6WKodW52qASXnVIdUrKBTcoOai7ZhuZi7BzSNC/iQjBIcUKfR+rde
         KMKw==
X-Forwarded-Encrypted: i=1; AJvYcCVQGgSt5zSrXY9gApI2cB+4osdg2jzyXR3Kht5YXrSP0S58YPZhQkCjEV2MqPGoosQGMmug3793mcTLtJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKB6ePuSkEmKLVjJhr4akyonIlybPQbazfFm1msiO9N6vdXw+F
	oG6jRYte5MBP0FtpqZyv0GuPWW123ig/HjkCs9oP1bxv/t4U7Eal4REx6SNrvVFb4+XWq+7jpsi
	47BV+jStpPn8IiupwVpxsvBLC8coV6brdF5o31ee3WRtf0i6m10Ozf+axiqP43RRcqQ==
X-Gm-Gg: ASbGncuiilkd3X6Yr6j7ZRgg0ljOdweA1XMViRw2J1n/ZmkUsWsPEUl0Nx6nHxxQRVL
	4hcMRqildBXbhhtrOFnKhyET/yMdXlOuvrBgmIBhZjUOFGl+JGIWzOJAoLMsHDks1h0tE8EM26N
	uF/DBrONYwEp16ffYKoRtJ2ImvNhL+Vggwb7G0dPpZRI6zujIZuE6URtQKxzy6caSNzvP/BUWdb
	Fz7lVvLBxwhP26Ikg6NwzZ65CTDI3iW1nYydAH0FadMYZ+Q4iOJDGUuZN3rWSbOyEs6HpmoVcfU
	DvSYf+k/DTag+1tJqAmL2NBOFJpE+BxIEQ==
X-Received: by 2002:a05:600c:8b38:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-46fa9af3682mr162925175e9.18.1760378840706;
        Mon, 13 Oct 2025 11:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6NSG53jZlFPMrLIRjIMLz3I3zfd3vW98lZywLTQ95z1DX1KrroQS8L4AgN5nQ3GdFs4i6qg==
X-Received: by 2002:a05:600c:8b38:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-46fa9af3682mr162924925e9.18.1760378840252;
        Mon, 13 Oct 2025 11:07:20 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49be017sm194828505e9.13.2025.10.13.11.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:07:19 -0700 (PDT)
Date: Mon, 13 Oct 2025 20:07:18 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aO0/1oCiuOgxZMrg@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2318164.vFx2qVVIhK@fedora.fritz.box>
 <aOzL8f4C27z361P2@fedora>
 <5719046.rdbgypaU67@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5719046.rdbgypaU67@fedora.fritz.box>

On Mon, Oct 13, 2025 at 06:29:44PM +0200, Francesco Valla wrote:
> Hello Matias,
> 
> On Monday, 13 October 2025 at 11:52:49 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Fri, Oct 10, 2025 at 11:20:22PM +0200, Francesco Valla wrote:
> > > On Friday, 10 October 2025 at 17:46:25 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > > Hello Mikhail, Harald,
> > > > > 
> > > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > > 
> > > > 
> > > > I am working on the v6 by addressing the comments in this thread.
> > > > 
> > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > +
> > > > > > +/* virtio_can private data structure */
> > > > > > +struct virtio_can_priv {
> > > > > > +	struct can_priv can;	/* must be the first member */
> > > > > > +	/* NAPI for RX messages */
> > > > > > +	struct napi_struct napi;
> > > > > > +	/* NAPI for TX messages */
> > > > > > +	struct napi_struct napi_tx;
> > > > > > +	/* The network device we're associated with */
> > > > > > +	struct net_device *dev;
> > > > > > +	/* The virtio device we're associated with */
> > > > > > +	struct virtio_device *vdev;
> > > > > > +	/* The virtqueues */
> > > > > > +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> > > > > > +	/* I/O callback function pointers for the virtqueues */
> > > > > > +	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
> > > > > > +	/* Lock for TX operations */
> > > > > > +	spinlock_t tx_lock;
> > > > > > +	/* Control queue lock. Defensive programming, may be not needed */
> > > > > > +	struct mutex ctrl_lock;
> > > > > > +	/* Wait for control queue processing without polling */
> > > > > > +	struct completion ctrl_done;
> > > > > > +	/* List of virtio CAN TX message */
> > > > > > +	struct list_head tx_list;
> > > > > > +	/* Array of receive queue messages */
> > > > > > +	struct virtio_can_rx rpkt[128];
> > > > > 
> > > > > This array should probably be allocated dynamically at probe - maybe
> > > > > using a module parameter instead of a hardcoded value as length? 
> > > > > 
> > > > 
> > > > If I allocate this array in probe(), I would not know sdu[] in advance
> > > > if I defined it as a flexible array. That made me wonder: can sdu[] be
> > > > defined as flexible array for rx? 
> > > > 
> > > > Thanks.
> > > > 
> > > 
> > > One thing that can be done is to define struct virtio_can_rx as:
> > > 
> > > struct virtio_can_rx {
> > > #define VIRTIO_CAN_RX                   0x0101
> > > 	__le16 msg_type;
> > > 	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > > 	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > > 	__u8 padding;
> > > 	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > > 	__le32 flags;
> > > 	__le32 can_id;
> > > 	__u8 sdu[] __counted_by(length);
> > > };
> > > 
> > > and then allocate the rpkt[] array using the maximum length for SDU:
> > > 
> > > priv->rpkt = kcalloc(num_rx_buffers,
> > > 		sizeof(struct virtio_can_rx) + VIRTIO_CAN_MAX_DLEN,
> > > 		GFP_KERNEL);
> > > 
> > > In this way, the size of each member of rpkt[] is known and is thus
> > > suitable for virtio_can_populate_vqs().
> > > 
> > > 
> > 
> > Thanks for your answer. What is the value of VIRTIO_CAN_MAX_DLEN? I
> > can't find it nor in the code or in the spec. I guess is 64 bytes? Also,
> > IIUC, using __counted_by() would not end up saving space but adding an
> > extra check for the compiler. Am I right? In that case, can't I just use
> > a fixed array of VIRTIO_CAN_MAX_DLEN bytes?
> 
> My bad, I forgot to say that VIRTIO_CAN_MAX_DLEN has to be defined, but:
> given some more thoughts, maybe this can be a dynamic value based on
> the features received from the virtio framework, to avoid wasting memory?
> 
> E.g.:
> 
> if (virtio_has_feature(VIRTIO_CAN_F_CAN_FD))
> 	sdu_len = CANFD_MAX_DLEN;
> else
> 	sdu_len = CAN_MAX_DLEN;
> 
> priv->rpkt = kcalloc(num_rx_buffers, sizeof(struct virtio_can_rx) + sdu_len,
> 		GFP_KERNEL);
> 
> 
> My understanding of __counted_by() is the same: additional checks but nothing
> more.
> 
> 
> CAN-XL appears to be not supported by the virtio specs v1.4 [1], but if/when
> it will be, the addition of an additional case would be simple.
> 
> [1] https://github.com/oasis-tcs/virtio-spec/blob/virtio-1.4/device-types/can/description.tex#L33
> 

Sounds good, I'll add that.

Matias


