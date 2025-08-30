Return-Path: <linux-kernel+bounces-792933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6CB3CAA1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F85C5E04DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9FC2737F0;
	Sat, 30 Aug 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxBuEsTw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6C2CCDB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756554511; cv=none; b=jFxsSzi6iZc4vT/FCl2YyKjXez8nO0BjNRhsH7xBW825hJSlagKU1vHjFReUcsjnLyWi8NAJghWk9T4nRYt3Zw2Sf8PKhidTP/TJard7j9dq35AyLiq/S/2X3R1ZqKPQkgmBYLOin6hmioZTRZPQsDHYU2ksD/NzmXdKxq1N8tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756554511; c=relaxed/simple;
	bh=zaeQ9+KQzLSByS2I5JXk0VDH5I1R+0tcwVDmQJqKIVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3kNLS49AC73RMraFosFBbVDJuNGwVDkc69Q0WlYywFe9DpyS7F4boMOAB/eJcv1tAYXZhr2nCXw17u5NbXLvbFbXS5yNU1zxUsDhXkhJH8R1aAEKgfYscW/Jgvjbca/5tituPXOCDFKTrGXPzGal+gkLRgjgeDg+JLJIWuk+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxBuEsTw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756554508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KaKjGFLwy+V7ecd9sJXmkoNWgd3Dh2vSUHl3RDc679g=;
	b=OxBuEsTw/5ofpHk6RQQTW4eCcDSjhON4eFyclzZqd3gSAVmO50iH0VgggCxhLIzB+Fjw4G
	CyJUabJOcJCK+FmAaRPhO/360kLUdw2TZfK/v9M8z/8ZD4MfT2XMIDI3JiXxQtAcNs7owv
	Xm7VGCTwiJzmoSp5XGuLPer6pekHuWw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-nRUyjfMbPiCxLbP2wjnBMg-1; Sat, 30 Aug 2025 07:48:25 -0400
X-MC-Unique: nRUyjfMbPiCxLbP2wjnBMg-1
X-Mimecast-MFC-AGG-ID: nRUyjfMbPiCxLbP2wjnBMg_1756554504
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b83ae1717so7532215e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756554504; x=1757159304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaKjGFLwy+V7ecd9sJXmkoNWgd3Dh2vSUHl3RDc679g=;
        b=MBeYuCSp9bgugCkG7oXtMuZbuLuFS45krIkohVZ+XGSb5OYjLvrxHTZcxtQXaZcWDJ
         j2z6W2s66h+Vtd6elwCG4/Seu6U0nzNMsdy1g6SPbIsC5BjResd6TJdy5nr0ZEUPaZG+
         UgduOfJyvc6B3N4XTW1O2FLuFQKXWf9Xy42BXiDI57ONuwlPTgF8OHxdICk5twJRRsWT
         0EBbW4F2JXLHUoFJOGuzWHAEvFjreAPJAwf7IXZC66V3XyLPClvWAkBKxucHrSIkzVVC
         s9T8wSLj8zzO5kXEC584P3o7va6TYeFh6v63D2GlRPVJRX2+2V+fj84wzh5nykVHeYEk
         Gk+w==
X-Forwarded-Encrypted: i=1; AJvYcCXHwt+UNwibn3qI3jE/WE7VKkon6ztn9sSLEU2n94KSzfQKJ/B/Dcb10wWokTWzIGgFKfu+U4DYvYKvkII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqrja3uz4nkeRGRcRcpTPu8Xl+GovNrbodKTa1M8KmglOHbyhA
	V9TlLVFsCkbXKlvI0AdeGcnyL/xBLCzJi1rY0s/nT/eBmkcmlcFx7KeQ7+X8jBkWc9dDkeBT1wu
	ad79txzfgV4vlNVzrh2oy1NywpZpsZBXKpop0So4t3FcMRnwXwPfaFYg9MUJBo22FNg==
X-Gm-Gg: ASbGncvSi2fbX/s55R/IjLCOf1BsBaYw5jPO9MvcL8KWMIEvkp0O/oa/Fkpwh4rUric
	Q1X/52jfRAAWRDreDl0iwPilaYe6OxSNML5yq1cFQEGuY1XLcP//elYJSeoTiqJKJY+hgZdRJTu
	UXdFyMEhHk6nfHdgvTwV2biDn+fkSVVtnDVZIR/uwfvTmmtiL1vrE0fUi/XjGaDj9kWqtuBEClQ
	HBu0+ZTs6vxgldTHgrk3URV9G6tp+wEcvBOE3h48tYLq/r2pvBiFa4fB9Q53EhN1TASGzEj4ovB
	YAMzTsopJij/LAaaFP/Oz5E1x1GPtc5yLx8=
X-Received: by 2002:a05:600c:1c98:b0:459:dd16:ddde with SMTP id 5b1f17b1804b1-45b8559b660mr12175395e9.23.1756554504263;
        Sat, 30 Aug 2025 04:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Nv86gUIdggy1hEBUnLjrjO0ADmTfym8Sdz/L9HHFlU6ED/awS0qFW6I6CEH8xnA1upuKWw==
X-Received: by 2002:a05:600c:1c98:b0:459:dd16:ddde with SMTP id 5b1f17b1804b1-45b8559b660mr12175215e9.23.1756554503856;
        Sat, 30 Aug 2025 04:48:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc496sm7074059f8f.1.2025.08.30.04.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:48:23 -0700 (PDT)
Date: Sat, 30 Aug 2025 07:48:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v2 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <20250830074747-mutt-send-email-mst@kernel.org>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
 <20250826205617.1032945-8-vishal.moola@gmail.com>
 <5ee2b684-94d9-40be-b01c-b0538ced33bc@redhat.com>
 <aK9Ogjn71JoOM3w3@fedora>
 <aLBthEcK1rDPQLrE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLBthEcK1rDPQLrE@casper.infradead.org>

On Thu, Aug 28, 2025 at 03:53:56PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 27, 2025 at 11:29:22AM -0700, Vishal Moola (Oracle) wrote:
> > I imagine theres more of these lingering in the kernel, but theres so
> > many callers and I only looked for the ones that were calling
> > page_address() inline :(.
> 
> There's only 841 callers of free_page() and free_pages()!
> 
> It's a bit of a disease we have, to be honest,  Almost all of
> them should be using kmalloc() instead.  To pick on one at random,
> sel_read_bool() in security/selinux/selinuxfs.c is the implementation
> of read() for some file in selinux.  All it's trying to do is output two
> numbers, so it allocates an entire page of memory, prints two numbers
> to it (while being VERY CAREFUL not to overflow the buffer!) and copies
> the buffer to userspace.
> 
> It should just use kmalloc.

Why even kmalloc? Why not have a small array on stack?

>  Oh, and it should avoid leaking the buffer
> if security_get_bool_value() returns an error.


