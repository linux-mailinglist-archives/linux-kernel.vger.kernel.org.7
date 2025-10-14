Return-Path: <linux-kernel+bounces-852106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD8BD82DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5633BFAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBFC30F95B;
	Tue, 14 Oct 2025 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbZ6JExw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142612DE6ED
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430575; cv=none; b=CeLW4RG2Zrdf134MS1phd7JojtU9T5CfRssrxWaWvEZppU+x/pzXLsUkmABuahHS/YPh7wInxEnPjYXJAyo2EA18dqErI47ziFwyOSU0Crck6A5W3ayQYSlkZ7JbmQAEycm8EbDxLAEbDt6OE/JqWOFoTbTMVxu6mBsOiUOWKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430575; c=relaxed/simple;
	bh=/HuGM/47bIodPOEN9kcu3pwg2q/33WidymgDi6AyiKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doFh+B6wUc4/b+lMLKmP1CFbkQ+9dtuMas5S+leAx4rL28YIODsqREFOY0Mcee6Gmg81to3ajKOnm0w2TMpISP2UrEC/GchvpYduh1H4X5xkLLmBk6/8vQyKiI0To1KVbuc8kZust1OVBhwP+AFW4/Wt5Fo3Sp81C1ZY2+iRRss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbZ6JExw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760430573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsUz6hmX3VwPCSslBpSvxo71U4IXbfFNHhR64HdKblQ=;
	b=CbZ6JExwGalHh/W77AyfW8+m6WbjqAy0fuOFdKlshku83+xUo1o5XnMq/jzsgeiy1DaddE
	o9dZl/6bflFhtXfpM0CYbqr/1aY2A8ScG6/G5IKRJlpnf8j38isCBB8pbOe1hcxrA29dOi
	MBa/QecjXiLPaZ8GtriqBHzLBgGDc/c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-JBBIoF7eOii0VZPj4B0GqQ-1; Tue, 14 Oct 2025 04:29:31 -0400
X-MC-Unique: JBBIoF7eOii0VZPj4B0GqQ-1
X-Mimecast-MFC-AGG-ID: JBBIoF7eOii0VZPj4B0GqQ_1760430571
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ece14b9231so4374047f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430570; x=1761035370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsUz6hmX3VwPCSslBpSvxo71U4IXbfFNHhR64HdKblQ=;
        b=LNsyADUGJeC4LWPke1XQivgKBNUat2MVPo1OjV9T/N1+Wd8BWj7lz8WrxJs80hLwmA
         iOVfQcC8On4qjhshdSui/oTOFEyp+symXlLEzsPr0BmIGz1GkxZMhdOcDmrc+hZ+5EW3
         tinP5VPMwnNeMRSfz9bSOccplC+3+zf8om1VJn8Aov+nMLAm8eagb9uY0ksryAesCZH6
         Npg5epFZAC4E/+ehhiVxddHNLKqINZBWMItl+nGmOqtucbxpJ14/TrwNULv8lGDod5Ug
         F8Qx5rEn34omC9ZXWAtt5jFNvvcv9aYcsNyVRLOQ7hoJxz9+WZMwbjq8oYTuL3Cf3cdn
         d3bw==
X-Forwarded-Encrypted: i=1; AJvYcCW2STi/bpZe0Jp24irKtVDidj+tHtX48xhadtJ28VEwr/Yg9nUANHAkPzJRX4btvrBGSkNbcWOlADdzb6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Bm2tqSj/IRkEdqRolgVFQfkh3NfOehX7/C2i4L4seYydntv3
	jNLJgAJxOSBfQ5MHHcDWjZqpwm7iv9uhZLOLQSr0IJrFyXdGuVbER0J1oJPEgvMxxVCMOUq3ebl
	UKD4CsCeQKV2XieZHPSxK6Rf4Y8A49oRx1swXxPLtqj9JRiWw3XwA5RXXr5Jk8EvupzDtZj9si6
	xV
X-Gm-Gg: ASbGncvqmwG25vvI/T/tvYbQLYLte1RpHqS9wr9CZn1A9bKGs22flFi54+4kZLvtZ3L
	5VvvmwFucTn8y7o+NPaBSKwUDCZWvENAKepDltavovAeHju9tDGelEyLpUfJTrEUn+te7E45bd9
	JbKy/HryhAWIp0DV0/VpczhjQHUZaB1nh02dLhg6LK4q75pjwAF7zaSyGuSjZYtib5wrMcJovsQ
	wznkVfaPTD2nu7hcC1dFOUKxd/M2utGA+IDrdUQMpia/FT/F1y0LI/0DQJEaCcs3pFdMA7Ut2gl
	NYWgSP06+Mlu0iP/A04Kr6je1SxRGGjVtA==
X-Received: by 2002:a5d:588b:0:b0:3ee:1368:a8e9 with SMTP id ffacd0b85a97d-4266e7befe4mr15816883f8f.17.1760430570331;
        Tue, 14 Oct 2025 01:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnpTZe8/dTR/rZB5cDRVDATWu3FS9RUOdcRXVHaoWWz3AZV0WhnIxngSzIEhkjXnqWmVvhFw==
X-Received: by 2002:a5d:588b:0:b0:3ee:1368:a8e9 with SMTP id ffacd0b85a97d-4266e7befe4mr15816855f8f.17.1760430569735;
        Tue, 14 Oct 2025 01:29:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e10e8sm22344542f8f.39.2025.10.14.01.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:29:29 -0700 (PDT)
Date: Tue, 14 Oct 2025 04:29:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251014042459-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251007130622.144762-2-eperezma@redhat.com>

On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> An userland device implemented through VDUSE could take rtnl forever if
> the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> device if it does not return the buffer in a longer-than-assumible
> timeout.

So now I can't debug qemu with gdb because guest dies :(
Let's not break valid use-cases please.


Instead, solve it in vduse, probably by handling cvq within
kernel.


> A less agressive path can be taken to recover the device, like only
> resetting the control virtqueue.  However, the state of the device after
> this action is taken races, as the vq could be reset after the device
> writes the OK.  Leaving TODO anyway.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/net/virtio_net.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 31bd32bdecaf..ed68ad69a019 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  {
>  	struct scatterlist *sgs[5], hdr, stat;
>  	u32 out_num = 0, tmp, in_num = 0;
> +	unsigned long end_time;
>  	bool ok;
>  	int ret;
>  
> @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  
>  	/* Spin for a response, the kick causes an ioport write, trapping
>  	 * into the hypervisor, so the request should be handled immediately.
> +	 *
> +	 * Long timeout so a malicious device is not able to lock rtnl forever.
>  	 */
> +	end_time = jiffies + 30 * HZ;
>  	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>  	       !virtqueue_is_broken(vi->cvq)) {
>  		cond_resched();
>  		cpu_relax();
> +
> +		if (time_after(end_time, jiffies)) {
> +			/* TODO Reset vq if possible? */
> +			virtio_break_device(vi->vdev);
> +			break;
> +		}
>  	}
>  
>  unlock:
> -- 
> 2.51.0


