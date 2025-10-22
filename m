Return-Path: <linux-kernel+bounces-864856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8599BFBB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2834B502FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FF534028B;
	Wed, 22 Oct 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JafbY4np"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA333F8DC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133409; cv=none; b=XWRn539Ket0/V3GvAAn5oy2lTs37+ZDhr/ocYJo0VaRC6yY+SHD6AvVAUgQ4T6o3W0t4Q7r/4jIAUQlDOnm+bk8APr0G+mLPhhCVT0jkO4vO2UQL6fGCro5JjEs1YqE6yUQIMJd5RdsHln9ZCseKSGtTscgQABDqXpoee8Bf+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133409; c=relaxed/simple;
	bh=c2gkXQ9qcXJtUs/3FfqdNZPZA2zNtwVFuMGrLRxmayY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/S7EJv5gj455j0iGLkmoufufxdckJxve62REnvNUayO3Ymi9mNf4AFA1qqM4OHO4XftnnH2BHKYsKIrVrw7/GkbJWvuB32srm+uExrVO1FILZVQrwxPj/gRN8RKjM0CSmVqdGg2CI4cLPz0fo3ebFHaJ3wXlZhZJl2z2EQ4NPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JafbY4np; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761133406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gq9iqnmobSVqV9ZHUp92OeMBuruVUcw0JjePNmGaQbs=;
	b=JafbY4npXi0qiUn2s8DopQiJuPSy7BFCxS9sVyZRtI03xiZdGzDvWz8Cqo4Td8ylLgUQHj
	gAPwaECetLTkiDxo3o6EwI5gr/KD+sXBbtG08U+01vVfslkBptR9cBGP+dywJy3EKQTRhb
	mqB2wWbh5b9PQFvDUcPWyohNGYaHQsE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-GiTEoKXbM8e0dL5_GhkhqA-1; Wed, 22 Oct 2025 07:43:25 -0400
X-MC-Unique: GiTEoKXbM8e0dL5_GhkhqA-1
X-Mimecast-MFC-AGG-ID: GiTEoKXbM8e0dL5_GhkhqA_1761133404
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6c033cbf37so233452866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761133404; x=1761738204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq9iqnmobSVqV9ZHUp92OeMBuruVUcw0JjePNmGaQbs=;
        b=pnx37/8+tOIUW11m9YXSaplIj1COjTDECE4+LbF/6CrTwpHDQQgItnnC4IcYIBZ4gJ
         UuStxQMH3zW7ZWvqa6dkcUkDBESB07dqqA5z/LTr88RYIEORCr3jnbM1nO86rKUnNgme
         1aCruBQtcmaMJ9NnuqVWpTMqhCKDmSvyaMsTdW0dIMn4OsK21X5L9/5T8N3DQcSR3nOY
         m6HAPwGel1LS8WPpqo0kb8a5shO2vTb2Pl4mSdQwmjChjq41ci0WQXR09fJITFB7FLf9
         WsxIcTt3RFwTLdc0ONaO36tVvoXmswyKISNUF9OP67Lx5LXCdrf4+8EdwqdEVN16QHsD
         NJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCX0BcZKgEVurrVM7SOvGP/Osrblnp58djLCF+LRl42FS+bViwkEWssDLZeIXlhUkMGytDLyl1nKh+ohrLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gnm2ZvILKiNGt7TWA3QCSkZaMp39dXAdpR/u9Jqp1cQUt3Ul
	LykKqDrwb59rh+slg/bgOdNNIkyCMLCdbU6ppxCNKdCc7Ad+kz0AX0yxRXr1vfgJxnGVN8HpsFT
	dLp7h+SoxFMruPcbsFX5XL+ARbhbV2VCkMygVuYd1TBpSIKTsAowGt5i7s/FeNvR6OA==
X-Gm-Gg: ASbGncvxttOt0SVQKjLsj5UhwWmHOURkrQvIWtIN2RPoBxoBTXJcXQLHE5BK2xOqcCP
	+wueiqt51lhcKkUj1lt4iqHxTw4rK0EowrlMZ5oVvbTSBEq0b8aghROJisCtGaWp5g6iigEQG2u
	fzQJx5O6HM2mTPCfHLDqHjBgP/KeN2OaW3Qu5p+9BVwHOBhbAa2iLULtOEmalP202P+kzn2A0sE
	IskvXSyTaSYcGXB9/xFG1yhfuSZPIFhFEzgskSJGY36+1E+bK6XqFdIHeYD8evwPNBhXECSLr9D
	o2r7XMOY/d6sObxESmpMmiQMpT3ewWNyP+37YlKrkNivk1D3pOtLRT535wR2DqNT
X-Received: by 2002:a17:907:7ba5:b0:b41:a571:21b0 with SMTP id a640c23a62f3a-b6475ff442amr2415778866b.39.1761133403989;
        Wed, 22 Oct 2025 04:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZGzSladakOrxLxalLSUPQkdwcOvpWAWqSmSMF7sigp17wPG2uCWvHCAJbfBX3zgt7DTEEUw==
X-Received: by 2002:a17:907:7ba5:b0:b41:a571:21b0 with SMTP id a640c23a62f3a-b6475ff442amr2415776466b.39.1761133403330;
        Wed, 22 Oct 2025 04:43:23 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8971897sm1318623966b.37.2025.10.22.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:43:22 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:43:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251022073231-mutt-send-email-mst@kernel.org>
References: <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org>
 <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>

On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> Let me switch to MQ as I think it illustrates the point better.
> 
> IIUC the workflow:
> a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> b) VDUSE CVQ sends ok to the virtio-net driver
> c) VDUSE CVQ sends the command to the VDUSE device
> d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> e) VDUSE CVQ sends ok to the virtio-net driver
> 
> The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> so it potentially uses the second rx queue. But, by the standard:
> 
> The device MUST NOT queue packets on receive queues greater than
> virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> command in a used buffer.
> 
> So the driver does not expect rx buffers on that queue at all. From
> the driver's POV, the device is invalid, and it could mark it as
> broken.

ok intresting. Note that if userspace processes vqs it should process
cvq too. I don't know what to do in this case yet, I'm going on
vacation, let me ponder this a bit.


> And, what's worse, how to handle it if the device now replies with
> VIRTIO_NET_ERR to the VDUSE CVQ?

this part does not bother me much. break it, probably.

> > > If we wait for the device to reply, we're in the
> > > same situation regarding the RTNL.
> > >
> > > Now we receive a new state (A, B, E). We haven't sent the (A, B, D),
> > > so it is good to just replace the (A, B, D) with that. and send it
> > > when (A, B, C) is completed with either success or failure.
> > >
> > > 2) VQ_PAIRS_SET
> > >
> > > The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, and
> > > the VDUSE CVQ forwards the command. The driver still thinks that it is
> > > using 1 vq pair. I can store that the driver request was 3, and it is
> > > still in-flight. Now the timeout occurs, so the VDUSE device returns
> > > fail to the driver, and the driver frees the vq regions etc. After
> > > that, the device now replies OK. The memory that was sent as the new
> > > vqs avail ring and descriptor ring now contains garbage, and it could
> > > happen that the device start overriding unrelated memory.
> > >
> > > Not even VQ_RESET protects against it as there is still a window
> > > between the CMD set and the VQ reset.
> >
> > Timeouts should be up to userspace. If userspace times out
> > and then gets confused, kernel is not to blame.
> >
> >
> 
> I meant the virtio-net driver will be confused.


