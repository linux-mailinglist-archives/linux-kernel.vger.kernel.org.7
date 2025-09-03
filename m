Return-Path: <linux-kernel+bounces-798643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ABDB420E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256847B1E54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70657307AF7;
	Wed,  3 Sep 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOU9V8+F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2E301483
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905064; cv=none; b=Pwq4yLCFKGgXYLtLuC+Ihxym+aREkIBiqBADsgnwyvbyxJViP0UVERvg8HlmMmGPxS/RmyZWhifSMD5XgHp8jffKXqZFLcyJ4vheE8Q2voUYNitC7L+32ii+TrAoWmoaLGQDwJDEwfxubofRVgj5QWj0RF3MU/JWJ1TA9Wz6gpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905064; c=relaxed/simple;
	bh=Y/X2fWSGYvLP2GbzQgVsXw6QemqhTogGncbWhT+ee+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlQSUe5RfPhq21rQsXpvFC7vrc/sMnHHu4DAUZru08lOKsabzxcZ944YtmLw3kj6LIQTSiH+V5sdxQF6HoDgf2pA78mFYhys58n+vAy4y2y4MKjrrg9+wbZ5B++R7vo7jK96hYraSMORDztH97FE0f6tqBQacM52k7L0T+SeXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOU9V8+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756905061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fu1nRMO4mP7hG3XcSYcXuE1KvbxzA7CKEO6dC9YqXJc=;
	b=fOU9V8+Fy/wuJ8EREoBTDv6Sx64l6GmuBDDEFGhP0h67yPhjGC126t/Xmjd98kCKkXmxvL
	L6hx3JpVHFpt22X9UEQCIUFpNVekgA3MG+FLZ9YucYreLwrib8aRfy4u0N8u3q/UoQKJ/m
	GQAzLKCzmtZAooBtEooEGlIz04aEeUA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-qAEQp7ktOCieP9Tlpu_LlA-1; Wed, 03 Sep 2025 09:10:59 -0400
X-MC-Unique: qAEQp7ktOCieP9Tlpu_LlA-1
X-Mimecast-MFC-AGG-ID: qAEQp7ktOCieP9Tlpu_LlA_1756905057
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b87609663so22659915e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905057; x=1757509857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu1nRMO4mP7hG3XcSYcXuE1KvbxzA7CKEO6dC9YqXJc=;
        b=FF8FIvHa6QWLJff7AjLt/0h/5+guHVkyOZ0O8OonTnNl5rvqEw5CtG9TzbEUKEOXdg
         5CZ2knAUv4/QahH2Knkt2T/fxJeavj3DlfkRJLPuAOTX1WJhyUnDii8lI05CgSW1+wMl
         WOH7afNy3iBoigb/k7oFY02Eq+4SXN5MeIi+brDPcBEWpD7DgFGULaDcf3DeafmBeAwD
         YJt+tLa4tgleWyF1TG0qH3lL/KMrowwVQQSAdmT7DV+xs3xdVb2QuNFUogvvJQCTQI/l
         cyjptHg7wqzCsL5RxRe7eT6eHsP+ayvYkNUI0MsUny2RpwGLCqbFvio8Mrbf0gz2qI9Q
         cENQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ha7gHPkVFGY/pHo3Jd7Gk69zhXLjcHcDzFrQPH84xxJ6ZY71OP0kuyjCkRXzxIdhknXRfuuK33dIMJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHqDZkIsv3hRpsIith17+WUV/o/AhIeVig3uZudYIhptp+wHF/
	Nf6NVG89QnyX/vAZnmAl2DPlDYtmyLvr3F9LGnguSs4m69CpunCfXh/TdOJWamkE3FLA7GcbJ4c
	7I8/nWzzxR+j7UqPgv+/igDSMwlVbAhyahSTtmnkbhbDVIvA/myt907o5IVz6LzRD3Q==
X-Gm-Gg: ASbGncvY4q+GlFgtD7jexdNOzzld5TLvZaqe3zEDj0idIjyzbWdhYBym/3PmXMzZ5fR
	wCPx0UeOGCNc4BPi8TW8LCwPWncYdjSFB3Xsy8/o6BleJ3RP2bfhg2IAA+qimermNwENoyVkDLX
	7HkyaRVSWhgsNJXHv+gcZRiqEjMx44OamDzWKaZm1ObINpO3ZW0TiNuSvxTr2nVKuLWPcI2l9/i
	ulSCWXEZ3dzlAYjuiKvdqZm4GptUtyFLElEe+ff75ueVu+srWOTdUnN8k4CrI8v5fAC/l93TseE
	chs6YOnjsv+tHl3hJ5Xn/giNA0OxUA==
X-Received: by 2002:a05:6000:3110:b0:3cc:29e8:d52f with SMTP id ffacd0b85a97d-3d1dea86a76mr12153279f8f.38.1756905057056;
        Wed, 03 Sep 2025 06:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb0624kVbYkja7DUsEoelJ71o6GXCbvgslVOj9fGNi28SVeur6o32uG23Fh/vV7MnRvsF1pw==
X-Received: by 2002:a05:6000:3110:b0:3cc:29e8:d52f with SMTP id ffacd0b85a97d-3d1dea86a76mr12153241f8f.38.1756905056517;
        Wed, 03 Sep 2025 06:10:56 -0700 (PDT)
Received: from redhat.com ([2a0e:41b:f000:0:c4d3:2073:6af0:f91d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm237242065e9.20.2025.09.03.06.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:10:56 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:10:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH 2/4] netdev queue flow control for TUN
Message-ID: <20250903090723-mutt-send-email-mst@kernel.org>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902080957.47265-3-simon.schippers@tu-dortmund.de>

On Tue, Sep 02, 2025 at 10:09:55AM +0200, Simon Schippers wrote:
> The netdev queue is stopped in tun_net_xmit after inserting an SKB into
> the ring buffer if the ring buffer became full because of that. If the
> insertion into the ptr_ring fails, the netdev queue is also stopped and
> the SKB is dropped. However, this never happened in my testing. To ensure
> that the ptr_ring change is available to the consumer before the netdev
> queue stop, an smp_wmb() is used.
> 
> Then in tun_ring_recv, the new helper wake_netdev_queue is called in the
> blocking wait queue and after consuming an SKB from the ptr_ring. This
> helper first checks if the netdev queue has stopped. Then with the paired
> smp_rmb() it is known that tun_net_xmit will not produce SKBs anymore.
> With that knowledge, the helper can then wake the netdev queue if there is
> at least a single spare slot in the ptr_ring by calling ptr_ring_spare
> with cnt=1.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>


Oh you just want to know if produce will succeed?
Kind of a version of peek but for producer?

So all this cuteness of looking at the consumer is actually not necessary,
and bad for cache.

You just want this:


Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 551329220e4f..de25fe81dd4e 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
+static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
+{
+	if (unlikely(!r->size) || r->queue[r->producer])
+		return -ENOSPC;
+
+	return 0;
+}
+
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
  * Callers are responsible for making sure pointer that is being queued
@@ -103,8 +111,10 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || r->queue[r->producer])
-		return -ENOSPC;
+	int r = __ptr_ring_produce_peek(r);
+
+	if (r)
+		return r;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */



Add some docs, and call this, then wake.  No?

-- 
MST


