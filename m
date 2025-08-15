Return-Path: <linux-kernel+bounces-770760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C19AB27EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70389623255
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B73009C2;
	Fri, 15 Aug 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOw47Lzu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA102FFDF1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254697; cv=none; b=RUkdxE07QpjLsufRUIVVNopCs8+WRNNb4YjOwCUMzUlvZ4mm0c0COkIaljMqLKvbBTf8jRocOHbQoya8Fk+MZazl3Nhrh9avBTIBu7X5i/UrdmBP8ZP2SfuKvxQUzB7gZWdkGpWWRu7xgN+xuMYzlCOXh6hgRTBmdRV+TMLCd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254697; c=relaxed/simple;
	bh=WjR/rbwNJc0Qp2k2aQAdE2Gr22tCrag3f7ATcKE39Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueFpxfB6nu5BNENIzo7Q0MtvLZp44H+Sc1Iw+csW+qOnFRvcAcPCYQxTztDS5iIUB5wXMwFxzJqV734Yg1LGk+bx4PeZTdAxuYlVnzVqbRP+Hxd00dDlTcimG94qaokryALrvY2DkMV9FA7QcqUPvnThaFUD9nS7FMyjxO1u0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOw47Lzu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755254695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5GOAcmmdxLGbEbM9B2YGjZnwu9h8dtTUkFqo/i0QYA=;
	b=gOw47LzufTf2haNuRfCk3P2bFSCjFRwzn7jAz4gGMkyIa89yz9OATtcCTpqVFWsxS+pDeD
	DFeKk+TF0rOa7707G6Bqbsw2Pxp+1yTx3LwdZOrrxINTnBkYo+f9K4bQ0iYvJqAVSskPnp
	nPNEnk/Y1HY9bP3aT+4tk3i0ALBSmIs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-A3z9AInuNYeGJ2YDoAnXGQ-1; Fri, 15 Aug 2025 06:44:54 -0400
X-MC-Unique: A3z9AInuNYeGJ2YDoAnXGQ-1
X-Mimecast-MFC-AGG-ID: A3z9AInuNYeGJ2YDoAnXGQ_1755254693
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9edf80ddcso765505f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254692; x=1755859492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5GOAcmmdxLGbEbM9B2YGjZnwu9h8dtTUkFqo/i0QYA=;
        b=XW1QWVdB6n8F0i7C4m+GSrEylQrebAPk7vkvPbF/6Gm+vmH2vk2sEm9tsZUHmFvbyX
         pIZJhjsg7oQTQsPXrvDftcQE5Zo5yV84f7R15kL+4LHLCHBbi20N7bwGH2yElAlW5WY4
         ZmxxK0WpX69VsfVwaDtI0cdaBS7lPzmfc/AeUaX5tx0nNWpI/b6Z83of9wkdRRFArKVh
         Q8EBrVSFzG7pl50UeHTT+ahJ0r7iuVxlU3GIkzeLW87bCj4C4wc9EYDCSy9lo3M4O2LV
         qrkssmNtd7kaPEoErmZRWYK6qfrnxHOCMbOYTAPAsyrjrSxAOstEFaccNhrC5szow9wf
         gjeg==
X-Forwarded-Encrypted: i=1; AJvYcCVaqw4dFtjpUsftsmhyJzyVR0TYGloDWm6Xi4Mi2unj5IO32O+QGRr/c3MyefN9cclzP1x30JCqmaqhQ1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0uYY5N7sFQhYuXQZUWpGMm4D8EPShW/1agSAVAtCCOJzPax+Y
	1OcULTY9+zdhyw/HbrlQ6nO4OF9gkgA5QYj+xcevKlWo3qwBS8oymG6YnVvmrLozfvoBMBdchfk
	Xl6lXdh2O4LdfzSjBbNWodZi7InMyj14Umj9nmd09hkKDFIrb5hiskhpQMgaL1U14Eg==
X-Gm-Gg: ASbGncst3QriDiOztUsZ6Q5d5dhZFdiJEt4LbOVfTmM+/XC4Zo77JuqC4BSItyiKX1N
	91Fwnqd+mbRy5GVSCCW23iL8FUdjUT3u4Nb9z9EckvEcXE9uZXUTOUPGXp/6m5WpKzH7Iy1QxBf
	HmOQ3xZsOhxOzRahLGnqfDLBWw88OmY/GKAqPwzIz8eyY0fJwj8EhxsGpMgiOPaF7U9cfKXA5/A
	GdoftfDwAKi3Ja0AO/Xfl6LGKq5XbiXuxcyMe6vEPwWw8yAaHmB+0DeDB+v+VX7wUfMM25xF2Db
	eja77X2EEzpNnrWCEkDivJmcSeNTVx07sFc=
X-Received: by 2002:a05:6000:1a8d:b0:3b7:9d83:50ef with SMTP id ffacd0b85a97d-3bb694af396mr1111615f8f.55.1755254691705;
        Fri, 15 Aug 2025 03:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjxJ9VfnonVDFqga9qmU4sokEZCEtKZYfi4E6SPLLakFaeJSs6iOf6aXLBGPZEAaqLwiSlKQ==
X-Received: by 2002:a05:6000:1a8d:b0:3b7:9d83:50ef with SMTP id ffacd0b85a97d-3bb694af396mr1111588f8f.55.1755254691299;
        Fri, 15 Aug 2025 03:44:51 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9936sm1456218f8f.38.2025.08.15.03.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:44:50 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:44:47 -0400
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
Message-ID: <20250815063140-mutt-send-email-mst@kernel.org>
References: <20250812052645-mutt-send-email-mst@kernel.org>
 <689b1156.050a0220.7f033.011c.GAE@google.com>
 <20250812061425-mutt-send-email-mst@kernel.org>
 <aJ8HVCbE-fIoS1U4@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ8HVCbE-fIoS1U4@willie-the-truck>

On Fri, Aug 15, 2025 at 11:09:24AM +0100, Will Deacon wrote:
> On Tue, Aug 12, 2025 at 06:15:46AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Aug 12, 2025 at 03:03:02AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > WARNING in virtio_transport_send_pkt_info
> > 
> > OK so the issue triggers on
> > commit 6693731487a8145a9b039bc983d77edc47693855
> > Author: Will Deacon <will@kernel.org>
> > Date:   Thu Jul 17 10:01:16 2025 +0100
> > 
> >     vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
> >     
> > 
> > but does not trigger on:
> > 
> > commit 8ca76151d2c8219edea82f1925a2a25907ff6a9d
> > Author: Will Deacon <will@kernel.org>
> > Date:   Thu Jul 17 10:01:15 2025 +0100
> > 
> >     vsock/virtio: Rename virtio_vsock_skb_rx_put()
> >     
> > 
> > 
> > Will, I suspect your patch merely uncovers a latent bug
> > in zero copy handling elsewhere.
> > Want to take a look?
> 
> Sorry for the delay, I was debugging something else!
> 
> I see Hillf already tried some stuff in the other thread, but I can take
> a look as well.
> 
> Will

I will be frank I don't understand how that patch makes sense though.

-- 
MST


