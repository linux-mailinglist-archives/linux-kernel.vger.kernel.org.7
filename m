Return-Path: <linux-kernel+bounces-801667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CEBB4488C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEEB97BD095
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E22C1580;
	Thu,  4 Sep 2025 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNY5VNYC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D702C0F61
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021502; cv=none; b=Mh3jXe6qCL3r8sC51L0yNkbBZ1PiRCJFlR8i6uCL4YJvydoYpJw/C+ZDaxIB0CPaWW5nQisJ00xXqWbemj+y0qdKSu0OQqqL0xLRjUBWgdNyhXB2wH4JQOhYbY0J9NqqOw6mRdhxqW1ntwq89n/R8e3EqT6HkHnAVrUCGn6nnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021502; c=relaxed/simple;
	bh=UTOOlZIQ4c9dm1bWMI/1leIB+NQMUt7B2+b+Jnoq2CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc6lX+srvuLDKWHRnfr3708oZpOaGdVvvAZKtISj41wYMqyIjglkgQG4w+Ddf4tL9ylsi1c2Jn2y+f0Ye4c2PpME1oMmhgRLiP/LY2uzpRtktItYj1hlloCb4rURBbItKcs35xTiFi31WTCb4dQV/2+Lf1QGw/ropBXeiUATtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNY5VNYC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757021498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENzZgn6QrvH6M67TV54TxO3IiK3WQ2Mya06rqToR830=;
	b=TNY5VNYCphqsio55zJCWv5iH5Qglin+uPxM/s5JCuOZbm6C0q6dc7xTTGXtaAqpctcXQIW
	pTUThWpgqP//l9oHg9rrb8Rd/lJCpEfHgV1n0DW3vGnYPYRfrfPdku8pu2gL419MG8dntE
	dj0/yjKSxx4rrXSQi2h9MPl63+icQGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-yw9cgntCNoeu_7jTKlf-3Q-1; Thu, 04 Sep 2025 17:31:37 -0400
X-MC-Unique: yw9cgntCNoeu_7jTKlf-3Q-1
X-Mimecast-MFC-AGG-ID: yw9cgntCNoeu_7jTKlf-3Q_1757021496
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3d3d2472b92so839116f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021496; x=1757626296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENzZgn6QrvH6M67TV54TxO3IiK3WQ2Mya06rqToR830=;
        b=PsFsn+yg2fy6nPxvO4JwuGY6tU+Ay6md50ozL2BT1z+PvubmMrOE0peKeKcNcKsjFN
         J85KW4XUlqRIpPr9bo6vrQYjrugM56JbiN2CaAyIqIT7tNJJsMSgAiAyGtAsno8CQu8Q
         HKtT7RM33KKAAJWgOkoZJyXLf9PzpsRFsPy/Cb5vli76ujoFi9yWA+nTkDm+VcT7jIZ+
         WaE0K5jhT+9GS+/dGjxxcoA2Dj9k7/aZ6QTrLvsZESY6q0/Tzp4QzZkUPtUXxWOb3udG
         DATJ4os7Z9VaqVA5rOKRMimTn/eSEtWEWckKWUJNrBgHqBHTLYZCUA4TcC/34euIuF/U
         CKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWruD0TNPZX4MhOkDBQoc9zlrCyClSDngE9Be+Z1xW1ygBgfxD1u8B5f+VNk5zcZAqibRba5Zna7m71SYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzodKO1/drK+o0ObIXncvyPyBK1Ohy3dItqQTmsM0rCoE9L/g8+
	i4uwLMNVpIQ6mxKoXT5N6H8acbQuuNnhN/CLomnsqXC+Acz2YkzB9hrpy+Nz2YyZ281oOuP39ij
	n2sKzdlJnG3BA0zNnwkyfl9WzkeWz/P83klXZsUyo7eAHRTwzCX7zV9KmpB8n37YrDA==
X-Gm-Gg: ASbGncsJkoDsGij0QF7gIPs/cx4fgDmeGVQP9FRwodLc3wRsJ42+Nutwqao5Z9IbEKF
	+0reOru4dcGYaxe/pZpETx14QukM93IXyNv8uhQVVZzm1lYTBA0+xHfh45BKIdETODM8rcRWiEq
	CV5CB+PWmT5+/421oefWNQfoCdV1V9ztqcsxgvCrJ/Q0HT7JAb2VxAdFToYEFU4GVX4nzxzwjfa
	QDIktOmInj419v0Rb29pjzphsm9uRaiTgJNVCytrBhOcWPZxcUHz98BZG88ZV6thHuF2BZDwsCB
	dg7kY0vXbch0RoWCoDCCSvX3OO8SOOBkg9Yfv8JpZfoM3gPcu/uRCjbRE1U5bQTN1A==
X-Received: by 2002:a05:6000:381:b0:3d7:38a7:35aa with SMTP id ffacd0b85a97d-3d738a7398bmr13118396f8f.24.1757021496217;
        Thu, 04 Sep 2025 14:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER4VSHQehlxm9viGCaLCiSUfIBqClOaGylclXglywjo1Jhx+yPCFvISOavLQeeDAzgnPEefA==
X-Received: by 2002:a05:6000:381:b0:3d7:38a7:35aa with SMTP id ffacd0b85a97d-3d738a7398bmr13118381f8f.24.1757021495725;
        Thu, 04 Sep 2025 14:31:35 -0700 (PDT)
Received: from redhat.com (93-51-222-138.ip268.fastwebnet.it. [93.51.222.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0a1f807f9sm28148640f8f.38.2025.09.04.14.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:31:35 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:31:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Simon Horman <horms@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] virtio_net: Fix alignment and avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250904172951-mutt-send-email-mst@kernel.org>
References: <aLiYrQGdGmaDTtLF@kspp>
 <20250904091315.GB372207@horms.kernel.org>
 <cac19beb-eefb-4a6a-9eec-b414199ce339@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac19beb-eefb-4a6a-9eec-b414199ce339@embeddedor.com>

On Thu, Sep 04, 2025 at 08:53:31PM +0200, Gustavo A. R. Silva wrote:
> 
> 
> On 9/4/25 11:13, Simon Horman wrote:
> > On Wed, Sep 03, 2025 at 09:36:13PM +0200, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > > 
> > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > 
> > > drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 
> > > This helper creates a union between a flexible-array member (FAM)
> > > and a set of members that would otherwise follow it (in this case
> > > `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> > > overlays the trailing members (rss_hash_key_data) onto the FAM
> > > (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> > > The static_assert() ensures this alignment remains, and it's
> > > intentionally placed inmediately after `struct virtnet_info` (no
> > > blank line in between).
> > > 
> > > Notice that due to tail padding in flexible `struct
> > > virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> > > (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> > > offset 84 in struct virtnet_info) are misaligned by one byte. See
> > > below:
> > > 
> > > struct virtio_net_rss_config_trailer {
> > >          __le16                     max_tx_vq;            /*     0     2 */
> > >          __u8                       hash_key_length;      /*     2     1 */
> > >          __u8                       hash_key_data[];      /*     3     0 */
> > > 
> > >          /* size: 4, cachelines: 1, members: 3 */
> > >          /* padding: 1 */
> > >          /* last cacheline: 4 bytes */
> > > };
> > > 
> > > struct virtnet_info {
> > > ...
> > >          struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> > > 
> > >          /* XXX last struct has 1 byte of padding */
> > > 
> > >          u8                         rss_hash_key_data[40]; /*    84    40 */
> > > ...
> > >          /* size: 832, cachelines: 13, members: 48 */
> > >          /* sum members: 801, holes: 8, sum holes: 31 */
> > >          /* paddings: 2, sum paddings: 5 */
> > > };
> > > 
> > > After changes, those members are correctly aligned at offset 795:
> > > 
> > > struct virtnet_info {
> > > ...
> > >          union {
> > >                  struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
> > >                  struct {
> > >                          unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
> > >                          u8         rss_hash_key_data[40]; /*   795    40 */
> > >                  };                                       /*   792    43 */
> > >          };                                               /*   792    44 */
> > > ...
> > >          /* size: 840, cachelines: 14, members: 47 */
> > >          /* sum members: 801, holes: 8, sum holes: 35 */
> > >          /* padding: 4 */
> > >          /* paddings: 1, sum paddings: 4 */
> > >          /* last cacheline: 8 bytes */
> > > };
> > > 
> > > As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> > > moved to the end, since it seems those three members should stick
> > > around together. :)
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > > 
> > > This should probably include the following tag:
> > > 
> > > 	Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> > > 
> > > but I'd like to hear some feedback, first.
> > 
> > I tend to agree given that:
> > 
> > On the one hand:
> > 
> > 1) in virtnet_init_default_rss(), netdev_rss_key_fill() is used
> >     to write random data to .rss_hash_key_data
> > 
> > 2) In virtnet_set_rxfh() key data written to .rss_hash_key_data
> > 
> > While
> > 
> > 3) In virtnet_commit_rss_command() virtio_net_rss_config_trailer,
> >     including the contents of .hash_key_data based on the length of
> >     that data provided in .hash_key_length is copied.
> > 
> > It seems to me that step 3 will include 1 byte of uninitialised data
> > at the start of .hash_key_data. And, correspondingly, truncate
> > .rss_hash_key_data by one byte.
> > 
> > It's unclear to me what the effect of this - perhaps they key works
> > regardless. But it doesn't seem intended. And while the result may be
> > neutral, I do  suspect this reduces the quality of the key. And I more
> > strongly suspect it doesn't have any positive outcome.
> > 
> > So I would lean towards playing it safe and considering this as a bug.
> > 
> > Of course, other's may have better insight as to the actual effect of this.
> 
> Yeah, in the meantime I'll prepare v2 with both the 'Fixes' and 'stable'
> tags.
> 
> Thanks for the feedback!
> -Gustavo
> 
> 


I agree. It looks like that commit completely broke RSS
configuration. Akihiko do you mind sharing how that was
tested? Maybe help testing the fix? Thanks!


