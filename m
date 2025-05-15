Return-Path: <linux-kernel+bounces-649360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA39AB839E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B9A9E24D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006C9297A78;
	Thu, 15 May 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVsnYh8Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2AA296D0E
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303922; cv=none; b=uNnKUixWB/65p+KCHDpcme/JGrcZJJgD4bbe+GE1dxcjZafGYfsJVOZXcuMeI6yfWq+8UCAOT1gQsEY7FIwUNITbWOjTI4JU6dRSCjYCch3DJ2d5vJougrhInqGOsk64wD+Y8HmtPPBXYBulBJmgw2aZZZBjZfC7FqscI6wlOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303922; c=relaxed/simple;
	bh=3MZkfwBnqjkppTndA3TyrtUNZ72s3mnrYhtf/Y5Q3vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcuT+ukL0PIlQ2q3IzrHvMp8U0khzRXL94cf4RfLhqCvkcR6KsXrrgkfx3bnzyyNI//F7i5dHcbZKoJnxDxLAipyQ9FEyTYsnmx5rNDaJzcW42VMtyKo5OcnNbM+vY8F2geRpDfUcWmScvu9lBLXt7LvAHPB1TcXpSS/PBPJTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVsnYh8Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747303919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXOA9ey0mc2YYVtY7dX6y6yx+zTsszpuFBN07DKCk1s=;
	b=PVsnYh8Y+pLjYkrIkuHFrRSIsOo9RM1jGTqs87UTVsixbuVTy3mQW+nJ41AU7ku8vSW0bp
	joMoCpVUyvntDqHnUW3PkYp4gX9nXJ9VgLVinHjH9HhcdU+XyhtFWjNyxUVYnybE0RVnT6
	fCtTzRdUZh8Tfxm9paL5bbjmLTIDJb4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-q3avyBW_OEGTuZ0Vv5BpHw-1; Thu,
 15 May 2025 06:11:57 -0400
X-MC-Unique: q3avyBW_OEGTuZ0Vv5BpHw-1
X-Mimecast-MFC-AGG-ID: q3avyBW_OEGTuZ0Vv5BpHw_1747303916
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92FB31956089;
	Thu, 15 May 2025 10:11:55 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.242])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D9E11956094;
	Thu, 15 May 2025 10:11:52 +0000 (UTC)
Date: Thu, 15 May 2025 12:11:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev,
	hreitz@redhat.com, mpatocka@redhat.com, snitzer@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dm mpath: Interface for explicit probing of active
 paths
Message-ID: <aCW95f8RGpLJZwSA@redhat.com>
References: <20250429165018.112999-1-kwolf@redhat.com>
 <47dd225b433b0df585a25084a2e793344eeda239.camel@suse.com>
 <aCIRUwt5BueQmlMZ@redhat.com>
 <d51d6f85b5728648fe9c584f9cb3acee12c4873f.camel@suse.com>
 <cc2ec011cf286cb5d119f2378ecbd7b818e46769.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc2ec011cf286cb5d119f2378ecbd7b818e46769.camel@suse.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Am 14.05.2025 um 23:21 hat Martin Wilck geschrieben:
> On Tue, 2025-05-13 at 10:00 +0200, Martin Wilck wrote:
> > > If you think it does, is there another reason why you didn't try
> > > this
> > > before?
> > 
> > It didn't occur to me back then that we could fail paths without
> > retrying in the kernel.
> > 
> > Perhaps we could have the sg driver pass the blk_status_t (which is
> > available on the sg level) to device mapper somehow in the sg_io_hdr
> > structure? That way we could entirely avoid the layering violation
> > between SCSI and dm. Not sure if that would be acceptible to
> > Christoph,
> > as blk_status_t is supposed to be exclusive to the kernel. Can we
> > find
> > a way to make sure it's passed to DM, but not to user space?
> 
> I have to correct myself. I was confused by my old patches which
> contain special casing for SG_IO. The current upstream code does of
> course not support special-casing SG_IO in any way. device-mapper
> neither looks at the ioctl `cmd` value nor at any arguments, and has
> only the Unix error code to examine when the ioctl returns. The device
> mapper layer has access to *less* information than the user space
> process that issued the ioctl. Adding hooks to the sg driver wouldn't
> buy us anything in this situation.
> 
> If we can't change this, we can't fail paths in the SG_IO error code
> path, end of story.

Yes, as long as we can't look at the sg_io_hdr, there is no way to
figure out if we got a path error.

> With Kevin's patch 1/2 applied, it would in principle be feasible to
> special-case SG_IO, handle it in the dm-multipath, retrieve the
> blk_status_t somehow, and possibly initiate path failover. This way
> we'd at least keep the generic dm layer clean of SCSI specific code.
> But still, the end result would look very similar attempt from 2021 and
> would therefore lead us nowhere, probably.

Right, that was my impression, too.

The interfaces could be made look a bit different, and we could return
-EAGAIN to userspace instead of retrying immediately (not that it makes
sense to me, but if that were really the issue, fine with me), but the
core logic with copying the sg_io_hdr, calling sg_io() directly and then
inspecting the status and possibly failing paths would have to be pretty
much the same as you had.

> I'm still not too fond of DM_MPATH_PROBE_PATHS_CMD, but I can't offer a
> better solution at this time. If the side issues are fixed, it will be
> an improvement over the current upstream, situation where we can do no
> path failover at all.

Yes, I agree we should focus on improving what we have, rather than
trying to find another radically different approach that none of us have
thought of before.

> In the long term,�we should evaluate alternatives. If my conjecture in
> my previous post is correct we need only PRIN/PROUT commands, there
> might be a better solution than scsi-block for our customers. Using
> regular block IO should actually also improved performance.

If you're talking about SG_IO in dm-mpath, then PRIN/PROUT commands are
actually the one thing that we don't need. libmpathpersist sends the
commands to the individual path devices, so dm-mpath will never see
those. It's mostly about getting the full results on the SCSI level for
normal I/O commands.

There has actually been a patch series on qemu-devel last year (that I
haven't found the time to review properly yet) that would add explicit
persistent reservation operations to QEMU's block layer that could then
be used with the emulated scsi-hd device. On the backend, it only
implemented it for iscsi, but I suppose we could implement it for
file-posix, too (using the same libmpathpersist code as for
passthrough). If that works, maybe at least some users can move away
from SCSI passthrough.

The thing that we need to make sure, though, is that the emulated status
we can expose to the guest is actually good enough. That Paolo said that
the problem with reservation conflicts was mostly because -EBADE wasn't
a thing yet gives me some hope that at least this wouldn't be a problem
any more today.

We would still lose other parts of the SCSI status, so I'm still a bit
cautious here with making a prediction for how many users could
eventually (I expect years) use the emulated device instead and how many
would keep using passthrough even in the long term.

Kevin


