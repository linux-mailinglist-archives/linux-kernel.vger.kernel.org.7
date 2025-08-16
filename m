Return-Path: <linux-kernel+bounces-771924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FA6B28CEE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC387BEAC5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08AC298264;
	Sat, 16 Aug 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMyeqhKZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90726CE2B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340480; cv=none; b=S9/NJ2AZrXyUy012lSDLXdyQPqESGwZwYIfdO9xlzqQUCdny3MehLHBrTVg54Mvs5gfjfy9qjtQkQOTk/gm4nN/QrDAxCS9P/RPvuhZ+Kjbzkx0ZI+ZfskTBMirSJUAn8jcYFh/KG/2rlPL+ANYcMRWdXpKnwrUDu3mZLBDr0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340480; c=relaxed/simple;
	bh=t9nsA9xxppfh4GuaSr2En7HWIUYMTE5nS0V7EiLZoKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuqGe5FdOStXv/W0eP/pVnvbiL30dL8WifVMCJoQ4W1OlnuJl4POChIcare2jxrGN2ub9HTL5hW1Jd75w0F5gvOnmC1hmQzLhFXDF2jWNxPio98W0wYjUZrlaIm5nExW/ye+cZxiRacbPbTzQvhoSTSxXQyXST/aGz573GsDO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMyeqhKZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755340477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbxBMAjshEeD1LlV1sadxP05g9sf1GmiKcl0uerjKR0=;
	b=aMyeqhKZiZNZLPd9u4pCo4NZE5UGbLtyztvqGmaFKab8sRiYSbiji+o4LZgR7+6wD8gHC6
	t/Xax3HczqyOT9bqbLJOXJq0Wr4bQdx7EGZyuRqz95uwPRrkGyQzHHQK2QMuTbgvdE7VQc
	Xu2IM4Tf5JpXM9BgtykhmwWilEiq760=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-lnnrJl02N3KSDgteE2e2Ng-1; Sat, 16 Aug 2025 06:34:36 -0400
X-MC-Unique: lnnrJl02N3KSDgteE2e2Ng-1
X-Mimecast-MFC-AGG-ID: lnnrJl02N3KSDgteE2e2Ng_1755340475
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9dc5c2ba0so1260245f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755340474; x=1755945274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbxBMAjshEeD1LlV1sadxP05g9sf1GmiKcl0uerjKR0=;
        b=R7IutI6tyQLExR8In1f+Jami7TwBkUwh1RYqjNVfF8DSdVx+EK+eymJvbWO8I6sEUf
         gRiMjflQv+9dpUpnO9flgH4+LpYRjVJis9lg/bIElrEUlpdsQQ1AN834OebmsxpzaMgz
         Uj31JcWSoln7fgiQdfM8hBixVvkyDkfTu6gjqlRZkuji1XSGbwvs45zyWQ5zbuqomI/9
         wCp4+mPuQGyS0T2qhpjQHNwBXzZZV4ye1HNtk8ssCnN4UlvFB7XHLvCgLyfAm+VvbWD/
         +4/5bWvfwoh502iHii2+/uJ29wSdC7HGZViMf61euubLbPkfNiPzU95OH3tqYBqr0i2J
         tJ0g==
X-Forwarded-Encrypted: i=1; AJvYcCXMvZpENG4IdzSXM6sW9cNY9QE+QWrSscwSrOsGxgb/sJlMT0mwyT9qA3FbBJm4upwmcRzAlfCcYdHyQ74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFL9V6ReZgOXWJ9g5dPz7+yjq8JU95Md3xZhzjnGgzc8sD1sCQ
	QAqFdK018dfH0W8NjPamNQwPqpzblaIEnkDHgWrpI5HvGoQpWES74oT1jRK5ynaDEpEIk3CVywF
	W+kDSfTrI9i1EM2iOtTXwp591AOCef8wfjmYNOWbjSgE/1HeySNyjd01XqU8eCpFrzQ==
X-Gm-Gg: ASbGncsZyHM8ydsjBogVv4M51x3W8bQ4T1HPtcgDCRcKojEXskd3lqxi0zXPYPKc8bD
	/fNIzyuVxh8oNBOZxsvlZH/99bj0gdMD2xJ2+XB08kSB77IFww1YzIlZlBhF7knYp2Q8Ohulucv
	OzxTvwcX5uBZG1su06O3Xp6/0q0JFm0LqEkYZVfT3WvwAySRZy1jD3Ebs3tIStsWE88NgUB1orI
	bKUW5tUqakURhmvSuYoDUTJJa+7RyhbzsBdhJVFDKxcc3esoyCptceug8/smsrF9VljwGyzfyjl
	cw7IpuZypdZyNKxNjwVdaqdBP515nmfuDcI=
X-Received: by 2002:a05:6000:24c4:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3bc694261a0mr1550452f8f.25.1755340473678;
        Sat, 16 Aug 2025 03:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvMJVoF0MSZh9zb0Y1qco87mCLOaf2fgKACdvLYKV1i5IJWFVtigfJ0ROFghywjQv+IIbDVg==
X-Received: by 2002:a05:6000:24c4:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3bc694261a0mr1550435f8f.25.1755340473295;
        Sat, 16 Aug 2025 03:34:33 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64d307cfsm5175627f8f.18.2025.08.16.03.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:34:32 -0700 (PDT)
Date: Sat, 16 Aug 2025 06:34:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in
 virtio_transport_send_pkt_info
Message-ID: <20250816063301-mutt-send-email-mst@kernel.org>
References: <20250812052645-mutt-send-email-mst@kernel.org>
 <689b1156.050a0220.7f033.011c.GAE@google.com>
 <20250812061425-mutt-send-email-mst@kernel.org>
 <aJ8HVCbE-fIoS1U4@willie-the-truck>
 <20250815063140-mutt-send-email-mst@kernel.org>
 <aJ8heyq4-RtJAPyI@willie-the-truck>
 <aJ9WsFovkgZM3z09@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ9WsFovkgZM3z09@willie-the-truck>

On Fri, Aug 15, 2025 at 04:48:00PM +0100, Will Deacon wrote:
> On Fri, Aug 15, 2025 at 01:00:59PM +0100, Will Deacon wrote:
> > On Fri, Aug 15, 2025 at 06:44:47AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Aug 15, 2025 at 11:09:24AM +0100, Will Deacon wrote:
> > > > On Tue, Aug 12, 2025 at 06:15:46AM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Aug 12, 2025 at 03:03:02AM -0700, syzbot wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > > WARNING in virtio_transport_send_pkt_info
> > > > > 
> > > > > OK so the issue triggers on
> > > > > commit 6693731487a8145a9b039bc983d77edc47693855
> > > > > Author: Will Deacon <will@kernel.org>
> > > > > Date:   Thu Jul 17 10:01:16 2025 +0100
> > > > > 
> > > > >     vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
> > > > >     
> > > > > 
> > > > > but does not trigger on:
> > > > > 
> > > > > commit 8ca76151d2c8219edea82f1925a2a25907ff6a9d
> > > > > Author: Will Deacon <will@kernel.org>
> > > > > Date:   Thu Jul 17 10:01:15 2025 +0100
> > > > > 
> > > > >     vsock/virtio: Rename virtio_vsock_skb_rx_put()
> > > > >     
> > > > > 
> > > > > 
> > > > > Will, I suspect your patch merely uncovers a latent bug
> > > > > in zero copy handling elsewhere.
> > 
> > I'm still looking at this, but I'm not sure zero-copy is the right place
> > to focus on.
> > 
> > The bisected patch 6693731487a8 ("vsock/virtio: Allocate nonlinear SKBs
> > for handling large transmit buffers") only has two hunks. The first is
> > for the non-zcopy case and the latter is a no-op for zcopy, as
> > skb_len == VIRTIO_VSOCK_SKB_HEADROOM and so we end up with a linear SKB
> > regardless.
> 
> It's looking like this is caused by moving from memcpy_from_msg() to
> skb_copy_datagram_from_iter(), which is necessary to handle non-linear
> SKBs correctly.
> 
> In the case of failure (i.e. faulting on the source and returning
> -EFAULT), memcpy_from_msg() rewinds the message iterator whereas
> skb_copy_datagram_from_iter() does not. If we have previously managed to
> transmit some of the packet, then I think
> virtio_transport_send_pkt_info() can end up returning a positive "bytes
> written" error code and the caller will call it again. If we've advanced
> the message iterator, then this can end up with the reported warning if
> we run out of input data.
> 
> As a hack (see below), I tried rewinding the iterator in the error path
> of skb_copy_datagram_from_iter() but I'm not sure whether other callers
> would be happy with that. If not, then we could save/restore the
> iterator state in virtio_transport_fill_skb() if the copy fails. Or we
> could add a variant of skb_copy_datagram_from_iter(), say
> skb_copy_datagram_from_iter_full(), which has the rewind behaviour.
> 
> What do you think?
> 
> Will

It is, at least, self-contained. I don't much like hacking around
it in virtio_transport_fill_skb. If your patch isn't acceptable,
skb_copy_datagram_from_iter_full seem like a better approach, I think.


> --->8
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 94cc4705e91d..62e44ab136b7 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -551,7 +551,7 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
>  				 int len)
>  {
>  	int start = skb_headlen(skb);
> -	int i, copy = start - offset;
> +	int i, copy = start - offset, start_off = offset;
>  	struct sk_buff *frag_iter;
>  
>  	/* Copy header. */
> @@ -614,6 +614,7 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
>  		return 0;
>  
>  fault:
> +	iov_iter_revert(from, offset - start_off);
>  	return -EFAULT;
>  }
>  EXPORT_SYMBOL(skb_copy_datagram_from_iter);


