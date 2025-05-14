Return-Path: <linux-kernel+bounces-648070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9CAB7126
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 18:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A75C1B67405
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287532797A0;
	Wed, 14 May 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUdr5od6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B21E7C24
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239825; cv=none; b=CKFzG2NQjFtuLM2AWC7YaZGjQ8o5odZXH7gwqfh69Z7nKZjznu/3AZBiVKmxIhszxDajUbT3t2sfthNhqImZlWVK1pVnAYjrYkCVcIryI2ahP65H68xo0SA3Q0qIHB16LvVcwBR4M8V2Zmi/a2PtjvsP6KNsudYZ3upB6dTe5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239825; c=relaxed/simple;
	bh=uLYLi5sPLzFsbuoX9uoR+EmNVUpFHJUk1wUc7bBfx5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crM0k52jOJ+MOFwltyWggK/3tHetXA6VoDFZcIz3qVIIC/Zvvx0v+HzwqfcpSGaEN9VcHGQjeUhfe74JXl+/o0iIKt9/aCHU8egxcKbhbFYKFiVOtbi4JTpEM0ed1woBXI+rnpwQgKxT+QkSt5dq9V8yiYMRbnUcRaUEp9iCb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUdr5od6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747239822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/3Vrn9aMLQKAG/4WrELKX6B5u1E7rwwnaweJ9QsMPM=;
	b=HUdr5od62xTSFJAjsegYcNJ5N8HFtR094gta0f3t092w2LCPKDeAqZfOpQcd68rTz4fhSG
	u607iIkaKy4q1jYx3icJU2yd6biEjKBiI5pe+A+K2wkSGdA6TFxumS29W/Upgo+zspThxj
	Ro9E0krzWy3bXWoEqBTaJgQ4qUwYmC0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-Ot4MCk9uPoWoDdgWs2u_eA-1; Wed,
 14 May 2025 12:23:41 -0400
X-MC-Unique: Ot4MCk9uPoWoDdgWs2u_eA-1
X-Mimecast-MFC-AGG-ID: Ot4MCk9uPoWoDdgWs2u_eA_1747239820
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A21DE195609E;
	Wed, 14 May 2025 16:23:39 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E8FD19560AD;
	Wed, 14 May 2025 16:23:38 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 54EGNbgU3731968
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 12:23:37 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 54EGNa373731967;
	Wed, 14 May 2025 12:23:36 -0400
Date: Wed, 14 May 2025 12:23:36 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Martin Wilck <mwilck@suse.com>,
        dm-devel@lists.linux.dev, hreitz@redhat.com, mpatocka@redhat.com,
        snitzer@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH 0/2] dm mpath: Interface for explicit probing of active
 paths
Message-ID: <aCTDiHMuMncwdp_X@redhat.com>
References: <20250429165018.112999-1-kwolf@redhat.com>
 <47dd225b433b0df585a25084a2e793344eeda239.camel@suse.com>
 <aCIRUwt5BueQmlMZ@redhat.com>
 <aCLe5UT2kfzI96TQ@infradead.org>
 <aCMQ5S-gI6vZJxmq@redhat.com>
 <aCQiz88HksKg791Z@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCQiz88HksKg791Z@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, May 13, 2025 at 09:57:51PM -0700, Christoph Hellwig wrote:
> On Tue, May 13, 2025 at 11:29:09AM +0200, Kevin Wolf wrote:
> > Am 13.05.2025 um 07:55 hat Christoph Hellwig geschrieben:
> > > On Mon, May 12, 2025 at 05:18:43PM +0200, Kevin Wolf wrote:
> > > > Yes, it's a bit unfortunate, but we have to work with what we have. QEMU
> > > > doesn't even necessarily know that it's dealing with a multipath device,
> > > > so it just has to blindly try the ioctl and see if it works.
> > > 
> > > Why is qemu even using SG_IO to start with?
> > 
> > How else would you do SCSI passthrough?
> > 
> > Ok, from your replies to Hannes I understand an implicit message, you
> > wouldn't. But I don't think that's really an answer, at least not for
> > all users.
> 
> SG_IO is fine and the only way for SCSI passthrough.  But doing
> SCSI passthrough through md-multipath just doesn't work.  SCSI isn't
> built for layering, and ALUA and it's vendor-specific variants and
> alternatives certainly isn't.  If you try that you're playing with
> fire and is not chance of ever moving properly.

Could you be a bit more specific. All multipath is doing here is
forwarding the ioctls to an underlying scsi device, and passing back up
the result. Admittedly, it doesn't always make sense to pass the ioctl
on from the multipath device to just one scsi device. Persistent
Reservations are perfect example of this, and that's why QEMU doesn't
use DMs ioctl passthrough code to handle them. Also, when you have ALUA
setups, not all the scsi devices are equal. But multipath isn't naievely
assuming that they are. It's only passing ioctls to the highest priority
activated paths, just like it does for IO, and multipath is in charge of
handling explicit alua devices. This hasn't proved to be problematic in
practice.

The reality of the situation is that customers have been using this for
a while, and the only issue that they run into is that multipath can't
tell when a SG_IO has failed due to a retryable error. Currently,
they're left with waiting for multipathd's preemptive path checking to
fail the path so they can retry down a new one. The purpose of this
patchset and Martin's previous one is to handle this problem. If there
are unavoidable critical problems that you see with this setup, it would
be really helpful to know what they are.

-Ben


