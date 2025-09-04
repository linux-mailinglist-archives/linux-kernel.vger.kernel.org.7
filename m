Return-Path: <linux-kernel+bounces-801672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF20B44897
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0991CC169A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705A629A30E;
	Thu,  4 Sep 2025 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp/KtA/e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3A2C032E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021587; cv=none; b=CK7xAzwvxDUbOKUdG5LXoXUBWyYDyDE8rOmKkmbcHx4Cli8lvainBXbaMXsrLCo0YhQOYZ/lCYH2dXSx0edyBuzbh6l3n8/wed1zN4q//VFpJQ/lZYDx0KZNAZfHEvLO7p/OgjzJj5hHQq38K3KdVDKYkuLcPmN3o+sPLRnI69w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021587; c=relaxed/simple;
	bh=9MiI5ZvuCO1wq15mMD/fHkYQx414pGpbtnQ0zoGU7d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMKVGrsZCcloJxkRMgzJhMCPd5QRRXODKBZpaeW5Gkp2fpgGc1Q/dKY3Y144R/eH5cJIjkHBXUy5hIvUFxqQLFFbsVEGGC0ItY+FUjbheYIWJc3WtBkIa57x1pmJFRyDMHNwVT/pk3XVGCLWpnIHP/Mg39am8lJq7OrqYAA/e74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp/KtA/e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757021585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G12ZvoIGncdc5q9Oz1isjoS1D9PWqRfwj3EJGyQfxdc=;
	b=Xp/KtA/eyk3YDRLcUOr5SnITUMJzCWutnkLG7kPdjGAR++Kl5AqHcSLKsTNysctANVBU0z
	DIMEUKU7cKXT/xxmY5+vnYuepxrnG5RuKVUbn9HzwGzzT7qEUGDLIUp6UfFoJtazDO4CVu
	NpsuSj3LorBFuh0CVIEkHLKHMXfXUZA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-KQfXbXJaP_68DDBX-vmtYQ-1; Thu, 04 Sep 2025 17:33:03 -0400
X-MC-Unique: KQfXbXJaP_68DDBX-vmtYQ-1
X-Mimecast-MFC-AGG-ID: KQfXbXJaP_68DDBX-vmtYQ_1757021582
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dabec38299so889255f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021582; x=1757626382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G12ZvoIGncdc5q9Oz1isjoS1D9PWqRfwj3EJGyQfxdc=;
        b=A++xga00aAUp+GfSCJsiJIedYgujpQEic6dbY2iMqc11DQ9R26gMzjPIEG5BOcD2Um
         pdCr3lnCQSc8jG1mtIE6jaJeUBJH3am+zzs4p4sRRt6B9MpMLiCMZj0Lfloij49RIh0F
         5uT1bPnYk8JUasb418snA2iKfJIe5ENBes4h732iVsg3pDyyhELDznQYx+PxaI9TnEu+
         PEn3g0EFw50vD/+4BqQPUaFZRjBfWZcoW1z5CdIggh5I4WLJyQ4FOgrMZgvClDn50Q98
         KbybIvHCI39oRS9S9ntuoimouFCItuCqr/fUyC2ED75YKIvb5DpSzP5c8aEasaeDa8Ql
         QPwg==
X-Forwarded-Encrypted: i=1; AJvYcCXRfoMRL4geN1jJnghX+LJSzP8g0SIN5w9S6BshP5uIS5ar47UMMy8SFKqPTgUaXTqASOxnVhNkrwwKxi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSclgphiPke137BiyMURgpPh7uAf4hgkatYzYg2KpEmwLxvRkx
	Ns5F/aoXyODqT7CU/K6dSDE5dsm6nCj4tDTOhI8AwViOAmPiMLIRaGKcWGswKFVyA3QEXkMdaj8
	1zz97fICgRrcwS8f8nMJN6O/HqRpKBVWmne5wn0b+/Zs0WwyeBgai815CoHIaBGjZyA==
X-Gm-Gg: ASbGncuoY3UKz5IHdPOgzzE9y2lvBHFgtdUY0+M3lcFSimQ71wCn1Iel+wK591ixzA5
	U4IxEjVVnbphm7sQ9pdIhO61hcRS7xKlElqkXVMWe8086vyPoVf7x9CtmrhomNnulA6lCjHt42g
	XwRFqQEPr6A023lOiuXlXO4Cgk8UZu/HAZk2X800VQ5aRijUPna2nV8RZrBKccwr14LKPnc/vD8
	uRrR2SIZlbqfZZt7axF4mavla+JHwwG+HkxUPk7J6RM6KtcKWzvCkMvc0bYdbBYTGReKijWD985
	rmBmjq7uM7G3iDnjCRDaf09Qtk4I1t4m9xsD+Mrp3FDwqoKknhiun7l5r14YHhBIzw==
X-Received: by 2002:a05:6000:2703:b0:3d3:6525:e35a with SMTP id ffacd0b85a97d-3d36525e8edmr9572274f8f.4.1757021581606;
        Thu, 04 Sep 2025 14:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfw63CZFozF8s+C6cWdSgHCPxbPiLm75XGfmKwvUvkmtLdSrYut8mMraqSLccxduV85Qv9AQ==
X-Received: by 2002:a05:6000:2703:b0:3d3:6525:e35a with SMTP id ffacd0b85a97d-3d36525e8edmr9572266f8f.4.1757021581097;
        Thu, 04 Sep 2025 14:33:01 -0700 (PDT)
Received: from redhat.com (93-51-222-138.ip268.fastwebnet.it. [93.51.222.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm302706375e9.24.2025.09.04.14.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:33:00 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:32:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] virtio_net: Fix alignment and avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250904173150-mutt-send-email-mst@kernel.org>
References: <aLiYrQGdGmaDTtLF@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLiYrQGdGmaDTtLF@kspp>

On Wed, Sep 03, 2025 at 09:36:13PM +0200, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> overlays the trailing members (rss_hash_key_data) onto the FAM
> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> The static_assert() ensures this alignment remains, and it's
> intentionally placed inmediately after `struct virtnet_info` (no
> blank line in between).
> 
> Notice that due to tail padding in flexible `struct
> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> offset 84 in struct virtnet_info) are misaligned by one byte. See
> below:
> 
> struct virtio_net_rss_config_trailer {
>         __le16                     max_tx_vq;            /*     0     2 */
>         __u8                       hash_key_length;      /*     2     1 */
>         __u8                       hash_key_data[];      /*     3     0 */
> 
>         /* size: 4, cachelines: 1, members: 3 */
>         /* padding: 1 */
>         /* last cacheline: 4 bytes */
> };
> 
> struct virtnet_info {
> ...
>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> 
>         /* XXX last struct has 1 byte of padding */
> 
>         u8                         rss_hash_key_data[40]; /*    84    40 */
> ...
>         /* size: 832, cachelines: 13, members: 48 */
>         /* sum members: 801, holes: 8, sum holes: 31 */
>         /* paddings: 2, sum paddings: 5 */
> };
> 
> After changes, those members are correctly aligned at offset 795:
> 
> struct virtnet_info {
> ...
>         union {
>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>                 struct {
>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>                         u8         rss_hash_key_data[40]; /*   795    40 */
>                 };                                       /*   792    43 */
>         };                                               /*   792    44 */
> ...
>         /* size: 840, cachelines: 14, members: 47 */
>         /* sum members: 801, holes: 8, sum holes: 35 */
>         /* padding: 4 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> moved to the end, since it seems those three members should stick
> around together. :)
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> 
> This should probably include the following tag:
> 
> 	Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> 
> but I'd like to hear some feedback, first.
> 
> Thanks!
> 


I would add:

as a result, the RSS key passed to the device is shifted by 1
byte: the last byte is cut off, and instead a (possibly uninitialized) byte
is added at the beginning.

>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 975bdc5dab84..f4964a18a214 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -425,9 +425,6 @@ struct virtnet_info {
>  	u16 rss_indir_table_size;
>  	u32 rss_hash_types_supported;
>  	u32 rss_hash_types_saved;
> -	struct virtio_net_rss_config_hdr *rss_hdr;
> -	struct virtio_net_rss_config_trailer rss_trailer;
> -	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>  
>  	/* Has control virtqueue */
>  	bool has_cvq;
> @@ -493,7 +490,16 @@ struct virtnet_info {
>  	struct failover *failover;
>  
>  	u64 device_stats_cap;
> +
> +	struct virtio_net_rss_config_hdr *rss_hdr;
> +
> +	/* Must be last --ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> +		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +	);
>  };
> +static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> +	      offsetof(struct virtnet_info, rss_hash_key_data));
>  
>  struct padded_vnet_hdr {
>  	struct virtio_net_hdr_v1_hash hdr;
> -- 
> 2.43.0


