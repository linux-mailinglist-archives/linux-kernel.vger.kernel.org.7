Return-Path: <linux-kernel+bounces-736532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE5B09E35
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578063A9117
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7075F293C5D;
	Fri, 18 Jul 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZyobl+f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9E292B4F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828032; cv=none; b=W3e7Or6zHdLERVr6Hno2hv75tqIGZHEDzA7eIKPF9HMrz9Eeup/Y5uIn/qFCyoZnVmSkkO8uxSwzUtXSerW1GoOS2aqf61Z/J6JoPEj2iFv9FF/DvbR/1HEhNMoKqVZiEBBa056a4iEYNedC1P6yPSQELna2Gs8gBY2XSjueqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828032; c=relaxed/simple;
	bh=d/cITLBHlMU6TAxUTNaIP7pa1O0kFJWp8UkvhASv7Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COqiJvwZimKVdlZ+MftHDDruPppJbYJAfbjT9DyKm9Q9TaMXrr9ZJCWi/JR/2R7uJy8FgT2a82WUKs1U4C/IHdQzjXdbCrJFMCzMe2F1XSyPVAOlK8k33celpnh4jWjrDv/DW3LutxwWprwe3nlOWn/1dxtayJyt9SK/FLBNJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZyobl+f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752828030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qhhj+5lPdjvEGUsT5bIy4jc4ubsrbG5zCwrEB9sz+w4=;
	b=TZyobl+fKytbjMcGwTVs6A/sNGVy0rxCyj8JBurrizaKGfwOp8IwoaLqytg45KHceBjZOF
	hN1Y+X/wkhjcv96xjPv7WRjR5N2Q9xAq19HDyIixe/9FjuuLXdtEWEzxurFduWTVg6oDNQ
	HZJW3wmVpk0Iq62sigk0t66AQiyD9Ks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-Ts0pJaniNNSY9YdchnkZnA-1; Fri, 18 Jul 2025 04:40:27 -0400
X-MC-Unique: Ts0pJaniNNSY9YdchnkZnA-1
X-Mimecast-MFC-AGG-ID: Ts0pJaniNNSY9YdchnkZnA_1752828026
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso924769f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828026; x=1753432826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhhj+5lPdjvEGUsT5bIy4jc4ubsrbG5zCwrEB9sz+w4=;
        b=TMZejm6ibOvDYoBp6wQ/H2JUPkXPnn4NXopK73qCt/qYOf/IgHYs4Q6ng2ly/Vhfus
         RNnUhNca7ou9vwMqaHmg5hvYPEMyLq2XKQB4poat9+YnSAxpCCj4PksaA5Oxq0fqyOp1
         dcom4GyVWs4hHNlbFjcT+tQLO3SMbeHJAmGCknUuzTpoT3Iw5TsAJwMZHrXa7PSYLhzn
         AFhKgEaarbUrvrTPBHKjumu0j3j27WjS3qLJv0769tU00BO669UekxTYG2M2afo7q+cG
         roxj4clulxYy9oN/B3wygStURDRaT5wF5tEdEG+gDEHHZpsgh0Xux+v3kn99GI9hu3M+
         /kIA==
X-Gm-Message-State: AOJu0YzCTkUE59VJiPC7aQIsZDhPr/m1sJ20MdVbeNW+MAkLFrO3fFsM
	pVvHbI5Hpt0VpfgbyI6k7t2AIQ1HPHeCrmeniT9nX7noAFjL6GBbvFUHNJ20iVoanzZKQbBjMdz
	+exvzsZOfuRzkK8mPmDJODu8w5ix4ru3Y8J++Pf+ylnwQHn3MEjMiM6YLA1Nd1801vA==
X-Gm-Gg: ASbGncsTKCU8wgeDqKCoUrt8GhqU12aaYAQQhZQ3VvZsCfKTCLMKhzqHms4PTO6xfDt
	pAXiKJSznAkxYOgD86KewdTs9psH3h1VHhGpUKOCN1LFpqNXbGJk2LrU9XhvDE6g4Pn+xorNE3Q
	KJhWWLqiKgB1yO8vFvdTMC7x0jP06mnQqLQocTytrRH0bJv31oOTq6BMCf76pcY0MlBoWBikGg6
	JfP1m8L7KxVp6A4jakxH2+ShmG1KOuKKOfquObfhntNo+2G9K5EZaw2b2KGDUIlhi3kTr39Ld54
	ITZvKLHpAsIYIll7e29ewBbltQTX+KBj
X-Received: by 2002:adf:e192:0:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3b61b0ebf41mr1511861f8f.5.1752828026486;
        Fri, 18 Jul 2025 01:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqBvIibZpxmEevMb7PnR+yqkZwG63DgOrUJ7WvDQrH3ySphvekTPCQWQL3DTfQJNDfF22bDw==
X-Received: by 2002:adf:e192:0:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3b61b0ebf41mr1511830f8f.5.1752828026104;
        Fri, 18 Jul 2025 01:40:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d475sm1164451f8f.65.2025.07.18.01.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:40:25 -0700 (PDT)
Date: Fri, 18 Jul 2025 04:40:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250718044006-mutt-send-email-mst@kernel.org>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
 <20250717091025-mutt-send-email-mst@kernel.org>
 <aHlZE18kPuHuDtTT@wunner.de>
 <20250717193122-mutt-send-email-mst@kernel.org>
 <aHnPLIe-0ScYDfej@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHnPLIe-0ScYDfej@wunner.de>

On Fri, Jul 18, 2025 at 06:35:56AM +0200, Lukas Wunner wrote:
> On Thu, Jul 17, 2025 at 07:31:57PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 17, 2025 at 10:12:03PM +0200, Lukas Wunner wrote:
> > > pciehp_handle_presence_or_link_change() is called from pciehp_ist(),
> > > the IRQ thread.  During safe removal the IRQ thread is busy in
> > > pciehp_unconfigure_device() and waiting for the driver to unbind
> > > from devices being safe-removed.
> > 
> > Confused. I thought safe removal happens in the userspace thread
> > that wrote into sysfs?
> 
> No, the userspace thread synthesizes a DISABLE_SLOT event,
> calls irq_wake_thread(), then waits for the IRQ thread to
> finish handling that event.  See pciehp_sysfs_disable_slot().
> 
> Until 2018 we indeed brought down the slot in the userspace
> thread, but that required locking between the workqueue fed
> by the interrupt handler on the one hand and the userspace
> thread on the other hand.  It was difficult to reason about
> the code.
> 
> We had bug reports about slots flapping the link or presence
> bits on slot bringdown that we could easily address by handling
> everything in the IRQ thread, see 3943af9d01e9.  The same was
> reported for slot bringup and addressed by 6c35a1ac3da6.
> 
> This wouldn't have been possible with the architecture prior
> to 2018, at least not this easily.
> 
> Thanks,
> 
> Lukas

Got it, thanks!

-- 
MST


