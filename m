Return-Path: <linux-kernel+bounces-890575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA7C40656
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CE23B39C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4FF329C46;
	Fri,  7 Nov 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJiKOAMq"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B8C2DE6F1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526017; cv=none; b=RlLBPqUQFjy05DPv547rZyrMR/lEdq/AG6XHwVMTlJxBtcUpFlR82TQ4IHRC/H0rFg6t3cXrQX1T02l+3eUTRnu3YY1emmrMzCRzbPsnxV1dYiCP6zL2oc1GtCy15gZ9f63ymCdX9qtxogqoQFJ77vemY4IsvzP6lZWj/xfolpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526017; c=relaxed/simple;
	bh=VYv4VbKIBTMGATkaXkrYMjm0YUGRwfUgEtijjdf3tVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7Lra3nAM0vu5jrlaJN+M6vex12cJyKAY4b2Wjgu27xPO/KqnZIkixHP/Bry1VEOAW6JHbxAQ5cpjmfL2kOQQT2wlEiLGJkIwxcmG3w6bcA5Cfq4wsWxcAfieiFVKJ6JeLsnyb7KaYEn6VFayF2sgv3HuUrCxgPKLiy6PI5WGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJiKOAMq; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63f96d5038dso783912d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762526015; x=1763130815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVuiPgxoIdFU9eK0ffLkE96ijOOEBPKS5XMimJNBPpY=;
        b=CJiKOAMqKo5D/1mQZK/h+5JUwB1sEFbxe7da0jogRS2cdglc4CZAXt5rzdN8HmCjGE
         tgP4SJRVa0+xqTjl71qWyhEuCYikoE9ZbY1xXX+BU1brjW/tlzk+nUqhmxH4hVfNZDdr
         wX+gYYNFv7MeHydzMVO2QhwWc34+dwGTJpXHfcUFFKwjX9zblxMY7qJ/Vci6Ygn/hPz4
         3RUGu8DWjp0BWdJSVAqZgSIN/Op1d5qMMeGSCj6YBl9k+Zvj6B5xTsp1G7fx3n+BgyOU
         bHaA6FmaNwn1U49b6340jedPawyxnkxZGvCo1PJ3TZQqKW3lZQsxznTENmRO0RnRixPW
         2Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526015; x=1763130815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVuiPgxoIdFU9eK0ffLkE96ijOOEBPKS5XMimJNBPpY=;
        b=TLcBAMYnxJjfTRFLEgYFTJ/boYW2XNaxP/i6E6um/ZTKrxqqpuIKuP1nvAWTcbuF/w
         aUKyEAAt1dxafYrYgIPMYJ1Ik+tDGAL0SXprygZPG+ioyguQ5ggaD8I5K80/sTnAesi5
         M3Fs92dmHTv8aW6mVYigochGTh+UAGZk1w8TwyPibFd4G5nmaPpyhaQPnp/HNCMxPfv7
         G39Ur6Wp/SOSX/ilRsS4o1kyXrLj2btedj25YH5FKX0SAPpGFI5kExwDfoHfNtAh9lfU
         7g3liH2ryTVX6olU9wnTNU98A28fPCZ2IS2S+DAG+pMK6DGTRNd4PGp45NjWdBF+n+bE
         hJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCUfue2famj/W3Rd3eG6K4Jw2S0F0WDboTQc9osBKVhgNW7HG2goTQViGGEpngpPiqlk1Va2rk/xYKWrLEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qlwGt9Yi5GnuKFGTBxbt43jB8eAkp+aUT5bAsLh0J8j/atrM
	vbW7U0LY5iZe+/TmNhztpjMN6fCfSatPz3lNRXG4OvelA8MtP9vnMwIz
X-Gm-Gg: ASbGncuG5WxdH+HfqJAijvhvaimFZQ+0jMhG6Kj07VmgIvYI5eeBclWA5MsJjKL8aaP
	HllLEUS51JVLUbukVCwnnbzp9a9I+aJ5KpyD1BSEV1Jz+1//dLdK+vWf62GzQYO6SRtyxF4dLoG
	DmidyU57ULCLrv8vUO1Hyv0TQwP3biio+E51DH3iI/5nhamWDtjBl6DHw1hdV7KVhsWVFQ7ornM
	Cy9Fvlry9qbrBkxtq4KkJVCUQLqSlvK3b/ss0pvIImdF5LmqPutodEwBpR8E17w4msAMhEx+ivi
	VhotvgKkVecE7bjatpbzNm+urp0fh2ExIODWORnL9jj2jrhl9qHZkhzMjuvMfSOecnZ1eyHx91j
	zJt0LWarbGBCsYZAwWCnP2dc6FGLW3diQRff1YgC/dqfcfH96X4YV5cjRgupYSHsam9sn7n6xq8
	YTicF4BHrlVc+wNJFiyANAAgYxxIH5KZVb
X-Google-Smtp-Source: AGHT+IFGSfosbX24aGud2tUIAN0TjKPBi0xBs/kxp0rskWuLz9Gqspfd/w8KLNX31uQmkNqo82qJIQ==
X-Received: by 2002:a05:690e:4183:b0:63f:5785:a201 with SMTP id 956f58d0204a3-640c4170b06mr2559782d50.15.1762526015073;
        Fri, 07 Nov 2025 06:33:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640c72fa3aasm605605d50.6.2025.11.07.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:33:34 -0800 (PST)
Date: Fri, 7 Nov 2025 06:33:33 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <aQ4DPSgu3xJhLkZ4@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
 <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>

> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index dcc8a1d5851e..b8e52c71920a 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> > > 					 info->flags,
> > > 					 zcopy);
> > > 
> > > +	/*
> > > +	 * If there is no corresponding socket, then we don't have a
> > > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
> > > +	 */
> > 
> > So, in virtio_transport_recv_pkt() should we check that `net` is not set?
> > 
> > Should we set it to NULL here?
> > 
> 
> Sounds good to me.
> 
> > > +	if (vsk) {
> > > +		virtio_vsock_skb_set_net(skb, info->net);
> > 
> > Ditto here about the net refcnt, can the net disappear?
> > Should we use get_net() in some way, or the socket will prevent that?
> > 
> 
> As long as the socket has an outstanding skb it can't be destroyed and
> so will have a reference to the net, that is after skb_set_owner_w() and
> freeing... so I think this is okay.
> 
> But, maybe we could simplify the implied relationship between skb, sk,
> and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
> ever referring to sock_net(skb->sk)? I remember originally having a
> reason for adding it to the cb, but my hunch is it that it was probably
> some confusion over the !vsk case.
> 
> WDYT?
> 

... now I remember the reason, because I didn't want two different
places for storing the net for RX and TX.

Best,
Bobby

