Return-Path: <linux-kernel+bounces-788741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F1B3898C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0355E8155
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2512D9EE4;
	Wed, 27 Aug 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVob6Jl7"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DC4438B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319369; cv=none; b=dmQzm7xgaTy56l/3o3hkrwbqHjWmavV2h9QMoMGVKub9GR8jEjB4KLtN7Hs96OaBTG2VdtqTQju5oxHD8RczKf5KvCv29MLjwM93YZ/eGkAdSCdfAKdrf0nmUGSF0me5MJka9JbJAK0yEy8DicC5BEtSePfpnS4H3eXk+2o1OVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319369; c=relaxed/simple;
	bh=O/LtAwUEJERVnH82qlPKqih1a2GzKNB+Mj6dBnw6pHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0m0s9RhmKfRwfw2487d57fM91FGJISLM2JgkUo2q4NY43Bd1sx/2L3vNq0t/ZoTJLPOGI6/1/sKuF4yCjrX6UhetbQZXXqwCy+4J0NTLOQ+/U8nnzebcsbUZMHOVl9pmkBgEUcI18AwPoA+rOPlY5bXVH4HXHIoLmb5X1AeCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVob6Jl7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24458272c00so1533725ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756319366; x=1756924166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/V1ASIrDSi0g28DFi0KZDWfzgadLb4GaGK114cw4Lvg=;
        b=CVob6Jl7mBpZ4/jNDo+4kbKslNL2xljmlJnvTqvfGWQvlfmm1pIw7u5rGS+mhp9WCR
         xWp9b+ci71KKEpxwsKfeGeHx3JxErlPQt12iOfSArFIGAavlFPSmqX7VYANWYgXuzMqH
         sjzVYjkEvStlRIcgkIeptR26Gr0dyO6YHchbpg9Iah8bb9FbQbHa0hx5FctIE/XvqbQM
         dUOrezS6QrCzrEUEWab95Gcqd1zxLbl/ixJ9OMAXtMY2VuVJwxbalzgaDdVMA7NOM8EC
         F7NZG+V4BM2LBwhWxSiySLau1SMZRCcB4eT19X0lDo681fQsVv7+NNOXc0WPRm/nrAFs
         74dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756319366; x=1756924166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V1ASIrDSi0g28DFi0KZDWfzgadLb4GaGK114cw4Lvg=;
        b=dhg9yXt930HwmmI6BRFWLJAqAghB7GHK8dV6HZJCv5HhIpKhVAhv0Sfyp3u2EoXPNX
         chlzAZqmFNB/lf4w+DAnZrzllFzFAwlIYN1U8GJxwAEYiJljUFUNdfJRYtRUqWRlVq0U
         V6GhzvayEJdSbrsmsqiEIvwBuZHgK2VAWg1jf+eiKC8b3kch2K/qrnIydpI0NKxyN8A+
         p+QLN0RBaurFJ3GmMF8WjRNmXggEAuRL7SBG/jde9mZJTWCqQSTbJjkVi3ZV2AMXNIrh
         Q0EEEsA1+0lUHcvj2TmYtsWTH+HcW3QKtHBxw5FC8C8X/20ZccikfKnnEl090HpSNO2P
         HEIA==
X-Forwarded-Encrypted: i=1; AJvYcCVdlt9HVij9ibPBE582JIE1BPy74N3SWVslBa16NbpMzsKHpt6JmE6SC9rKLEIqzrRKDKmyEvS+nReNcTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFF1AeaLBcEUGGWbkAoJRDflDyD+ekmtbicQMt9phaTFNTxQz
	o/YKyDtr7EdCSdEouNyKdU9wNZZubydgVxIDLWt4RK0NLPKHtrlsoaW8
X-Gm-Gg: ASbGnctvlz07Yo85fZRRS2ElUA3b96g7F71BI0wN5IDgZplUTKVrc3l2/zz9+wokdT6
	yYqsw5pSRVEJ4XUmZYE20we2HMS5EfRadYNSZUW1rbBQdDdyXrskydoCEkgjQqgg7BdnzmsTTgv
	AVprniWsfsptL4Zzf9QeIWFR7NJDDUWLI0g3c8aduo7WBDWhXP2GOJ2aqs8bZXZpSqvQpjUxsg4
	S0EREikZZ5oJDUwsELm1ctqFbXPg29PhalMKUvKuXBU6mGgkOgT8lcdB1jcf6VScCponMn5pR0Q
	oWs/d4BMxECRJCsAlG4Xz0neJ5AGCYl471KcXGIOpJ61Od2cYm+kylvlrWooj/Td/cwivbD5l0O
	l8tV81ZPM3jznjekDh2ybIX7rv9v4o2DQA4E57SuNvrtaVz+SLTPvsw==
X-Google-Smtp-Source: AGHT+IF31+xUc8XH5FHaWxMDYwQHY6yAzaY35BNdjs0sugkpO8may1dby73rGFQR/wb+8akqXlbySQ==
X-Received: by 2002:a17:903:19ec:b0:248:9e56:e806 with SMTP id d9443c01a7336-2489e56ea30mr41835015ad.12.1756319365980;
        Wed, 27 Aug 2025 11:29:25 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2468f5de849sm112338435ad.141.2025.08.27.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:29:24 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:29:22 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <aK9Ogjn71JoOM3w3@fedora>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
 <20250826205617.1032945-8-vishal.moola@gmail.com>
 <5ee2b684-94d9-40be-b01c-b0538ced33bc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vepaSp8giM4exkxF"
Content-Disposition: inline
In-Reply-To: <5ee2b684-94d9-40be-b01c-b0538ced33bc@redhat.com>


--vepaSp8giM4exkxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 27, 2025 at 02:01:01PM +0200, David Hildenbrand wrote:
> On 26.08.25 22:56, Vishal Moola (Oracle) wrote:
> > free_pages() should be used when we only have a virtual address. We
> > should call __free_pages() directly on our page instead.
> > 
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >   drivers/virtio/virtio_balloon.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index eae65136cdfb..d4e6865ce355 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
> >   		page = balloon_page_pop(&vb->free_page_list);
> >   		if (!page)
> >   			break;
> > -		free_pages((unsigned long)page_address(page),
> > -			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> > +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> >   	}
> >   	vb->num_free_page_blocks -= num_returned;
> >   	spin_unlock_irq(&vb->free_page_list_lock);
> 
> I think you missed another nastiness of similar kind in
> get_free_page_and_send() where we do
> 
> 	p = page_address(page);
> 
> Just to call
> 
> 	free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);

Thanks for catching that. Andrew can you fold the attached patch into
this one please? It looks like the page_address() call is needed for other
things, but since we're changing the file we might as well clean these
up as well.

I imagine theres more of these lingering in the kernel, but theres so
many callers and I only looked for the ones that were calling
page_address() inline :(.

--vepaSp8giM4exkxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-virtio_ballon-Call-__free_pages-in-get_free_page_and.patch

From a7d439154c7990418da976e5864b91fce9d49d58 Mon Sep 17 00:00:00 2001
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Date: Wed, 27 Aug 2025 11:10:22 -0700
Subject: [PATCH] virtio_ballon: Call __free_pages() in
 get_free_page_and_send()

free_pages() should be used when we only have a virtual address. We
should call __free_pages() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 drivers/virtio/virtio_balloon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index d4e6865ce355..7f3fd72678eb 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -718,8 +718,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 	if (vq->num_free > 1) {
 		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
 		if (unlikely(err)) {
-			free_pages((unsigned long)p,
-				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+			__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 			return err;
 		}
 		virtqueue_kick(vq);
@@ -732,7 +731,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 		 * The vq has no available entry to add this page block, so
 		 * just free it.
 		 */
-		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 	}
 
 	return 0;
-- 
2.51.0


--vepaSp8giM4exkxF--

