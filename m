Return-Path: <linux-kernel+bounces-649813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C94AB8977
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CD83A6598
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712E192D6B;
	Thu, 15 May 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPO8ZFQI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A231F153C
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319405; cv=none; b=g4K0fSOQI/pJrnaBt7sMaEu4/p3FshUWGPuTAii8Xl8U6i9KhH5PL8q9wkbHfZLDHwGmQ7gbS/DJr/3Zm6xMalKYYeI5caFZ6mov7qGP9zdcaba+oMi05T26un814SHx9SJPKy7RuZmcN7R5Ry8eYEiFGl2ztqMNuFdFTO4iJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319405; c=relaxed/simple;
	bh=CKVCE6FYRwGO1ZYByo3D3Sl20e3L0LNJOmAsdbP2pZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smnE4UiSiJgykeA42cuFc9Usjb6ZNKz+rffmckRxFx9onEm+uY5r3eEO797v+BZy9hKgSLVI1xNpKbr8lCCzzeQTb4+nvLhNpwDYs0LL6zm5JPouG0GJjIpN3UN26ARHvNI8/tgg6iXe0HMhqP23FsvJeubCSxos9T0kU5ISom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPO8ZFQI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747319401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NrlNTj4ACN9JV0fl+09/+98WwJkRHgkTF51TDbdMmk=;
	b=FPO8ZFQIHVwWk1DyBqD0oT8yBMEUp2O4V4VZnurzGh1zF2bV7Befdxc/0zhtboW/AEMXpt
	eRbhEqvjZdoBg+sA57vVyHOLw9kylUZD9qctDeAk3T1LfBMhkcvxl9CK6wPW85aZTj3Old
	XwQutQKWzMubdcF56jZTBnw99lQSO58=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-2qdRxWsmMXeNt08w91mfFw-1; Thu,
 15 May 2025 10:30:00 -0400
X-MC-Unique: 2qdRxWsmMXeNt08w91mfFw-1
X-Mimecast-MFC-AGG-ID: 2qdRxWsmMXeNt08w91mfFw_1747319399
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A7301955DAB;
	Thu, 15 May 2025 14:29:59 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA290195608D;
	Thu, 15 May 2025 14:29:58 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 54FETvCV4120496
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:29:57 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 54FETtva4120495;
	Thu, 15 May 2025 10:29:55 -0400
Date: Thu, 15 May 2025 10:29:54 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@infradead.org>,
        Kevin Wolf <kwolf@redhat.com>, dm-devel@lists.linux.dev,
        Hanna Czenczek <hreitz@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, snitzer@kernel.org,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 0/2] dm mpath: Interface for explicit probing of active
 paths
Message-ID: <aCX6Ys9mOc441ydA@redhat.com>
References: <20250429165018.112999-1-kwolf@redhat.com>
 <47dd225b433b0df585a25084a2e793344eeda239.camel@suse.com>
 <aCIRUwt5BueQmlMZ@redhat.com>
 <aCLe5UT2kfzI96TQ@infradead.org>
 <aCMQ5S-gI6vZJxmq@redhat.com>
 <aCQiz88HksKg791Z@infradead.org>
 <aCTDiHMuMncwdp_X@redhat.com>
 <50beb356b4dc000446fd186ab754c87f386eaeae.camel@suse.com>
 <CABgObfaEiMN=YANk02EWini+jAXU1MxSvo8_jYWaMiu3ds7hgQ@mail.gmail.com>
 <2f0fc8ef7d04c590893bd6d54a6c0c842c4b21d7.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f0fc8ef7d04c590893bd6d54a6c0c842c4b21d7.camel@suse.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, May 15, 2025 at 12:34:13PM +0200, Martin Wilck wrote:
> On Thu, 2025-05-15 at 04:53 +0200, Paolo Bonzini wrote:
> > Il mer 14 mag 2025, 13:37 Martin Wilck <mwilck@suse.com> ha scritto:
> > > 
> > > I'd go one step further. Christoph is right to say that what we're
> > > currently doing in qemu – passing through every command except the
> > > PRIN/PROUT to a multipath device – is a dangerous thing to do.
> > > 
> > > Passthrough from a dm-multipath device to a SCSI device makes sense
> > > only for a small subset of the SCSI command set. Basically just for
> > > the
> > > regular IO commands like the various READ and WRITE variants and
> > > the
> > > occasional UNMAP. The fact that customers
> > > have been running these setups in large deployments over many years
> > > suggests that, if other commands ever get passed through to member
> > > devices, it has rarely had fatal consequences.
> > > 
> > > Nobody would seriously consider sending ALUA commands to the
> > > multipath
> > > devices. TUR and REQUEST SENSE are other examples for commands that
> > > can't be reasonably passed through to random member devices of a
> > > multipath map.
> > 
> > Yes, as usual things are a bit more complicated. First, a handful of
> > commands are special (REQUEST SENSE would be for HBAs that don't use
> > auto sense, but that is fortunately not something you encounter).
> > Second, there's already a filter in the kernel in
> > drivers/scsi/scsi_ioctl.c for commands that are allowed without
> > CAP_SYS_RAWIO. QEMU is subject to that so the commands you'll see are
> > mostly I/O, INQUIRY, TUR, MODE SENSE/SELECT and that's it.
> 
> Thanks for mentioning this.
> 
> However, I suppose that depends on the permissions with which the qemu
> process is started, no? Wouldn't qemu need CAP_SYS_RAWIO for PCI
> passthrough as well? 
> 
> I admit that I'm confused by the many indirections in qemu's scsi-block
> code flow. AFAICS qemu forwards everything except PRIN/PROUT to the
> kernel block device in "scsi-block" mode. Correct me if I'm wrong.
> 
> Anwyway, let's not forget that we're talking about the kernel here.
> While qemu is the main target application for this feature is created,
> any application can use it, and it may or may not run with
> CAP_SYS_RAWIO.

Maybe I'm missing your issue, but QEMU is just using DM's existing ioctl
forwarding code, which was already designed for general use, and I don't
see any capability issues with this patchset itself. If the caller has
the capability to issue this ioctl, they already have the capability to
do reads to the device directly, which will cause any unusable paths to
be failed, exactly like the ioctl does. The only difference it that the
user has no way to know how many reads they would need to issue to the
multipath device directly to force it to try all the paths. This gives
any application the ability to verify the paths just like doing enough
IO to the multipath device would, but it guarantees that it will use the
minimum IO.

-Ben
 
> > Any command that the kernel doesn't filter would be rejected, or
> > handled specially in the case of PR commands (PR commands use a
> > separate privileged helper to send them down to the device; the
> > helper
> > also knows about multipath and uses the userspace libmpathpersist if
> > it receives a dm-mpath file descriptor via SCM_RIGHTS).
> > 
> > > AFAIK the only commands that we really need to pass through (except
> > > the standard ones) are the reservation commands, which get special
> > > handling
> > > by qemu anyway. @Ben, @Kevin, are you aware of anything else?
> > 
> > .Of the ones that aren't simple I/O, mode parameters and TUR are the
> > important cases. A TUR failure would be handled by the ioctl that
> > Kevin proposed here by forcing a path switch. Mode parameters might
> > not be shared(*) and would need to be sent down all the paths in that
> > case; that can be fixed in userspace if necessary.
> 
> Passing TUR from a multipath device to a random member doesn't make
> much sense to me. qemu would need to implement some logic to determine
> whether the map has any usable paths.
> 
> > > I'd also be interested in understanding this better. As noted
> > > above,
> > > I'm aware that passing through everything is dangerous and wrong in
> > > principle. But in practice, we haven't observed anything serious
> > > except
> > > (as Ben already said) the failure to do path failover in the SG_IO
> > > code
> > > path, which both this patch set and my set from the past are
> > > intended
> > > to fix.
> > 
> > Yes, the kernel filter is a PITA in the normal single path case but
> > here it helps not doing something overly wrong.
> 
> This seems coincidental to me. Filtering by permissions and filtering
> for commands that make sense on multipath devices are orthogonal
> problems.
> 
> Regards,
> Martin


