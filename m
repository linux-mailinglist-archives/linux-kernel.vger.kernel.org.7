Return-Path: <linux-kernel+bounces-653511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F55ABBA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 12:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69A8166C37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 10:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93E26F44F;
	Mon, 19 May 2025 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um+V1J9j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6ED35957
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649179; cv=none; b=AhaTc7n/ruj/D/WJNnaYN7m9hB8IXCyzbV51cN5LoFkttVr1a9pVsWT16dylQRnDK98XU6YxtPbz12Od502+IjbFyPlGNsyNN9RdVNnhyc1TPYPb6lHT7bjmU01dIYOkX5Tb8H82svCPygY1pgiQVrOSwxFwE8j45FKArJEnSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649179; c=relaxed/simple;
	bh=WY4pVtTTZhYVG9r0kI5X0a3ASMeqcPFq3H1auY5Ce1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA9kz+RCNs2x9T7RMxq3i8k/TnqqDG1e58hFewITRa4eJbqVeAf5W48q+oUMDwl4uuJERPrCAfpRcFkDC16pIDdL0LMpyzlCeYHBCMgfEO4eIPPhf1y2l6K7sFZWY4EmvXcKMeXd1wVJUFbP1iE6NeOqBwicnWaMAUpEQai2inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Um+V1J9j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747649176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8y8RvBhJowtfwrg+WUxnhDmoJuUc4fa/9tDJ52ajU4=;
	b=Um+V1J9j5h1v4VsS/qHHEGH/VgxCkveZ25QdhPSPP6y2Bl8x9vouKAiRtwNwW1sjoco+Em
	ISlqd9AR1y2IgGBgIV5jVejHcOTfoeC943G6NBScQb1fj88GcksmFow76RtFNXhKP4rfke
	HzdJ4HvBgVzXD0/ab2L1pk+YKDqOYD0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-qVK8RXgdOuq2NyqG4Brs0Q-1; Mon,
 19 May 2025 06:06:13 -0400
X-MC-Unique: qVK8RXgdOuq2NyqG4Brs0Q-1
X-Mimecast-MFC-AGG-ID: qVK8RXgdOuq2NyqG4Brs0Q_1747649172
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24F0F19560AF;
	Mon, 19 May 2025 10:06:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.97])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9AD030001AB;
	Mon, 19 May 2025 10:06:08 +0000 (UTC)
Date: Mon, 19 May 2025 12:06:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev,
	hreitz@redhat.com, mpatocka@redhat.com, snitzer@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dm mpath: Interface for explicit probing of active
 paths
Message-ID: <aCsCjVQa0pqWP6AT@redhat.com>
References: <20250429165018.112999-1-kwolf@redhat.com>
 <47dd225b433b0df585a25084a2e793344eeda239.camel@suse.com>
 <aCIRUwt5BueQmlMZ@redhat.com>
 <d51d6f85b5728648fe9c584f9cb3acee12c4873f.camel@suse.com>
 <cc2ec011cf286cb5d119f2378ecbd7b818e46769.camel@suse.com>
 <aCW95f8RGpLJZwSA@redhat.com>
 <aCbUcdew393RZIkV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCbUcdew393RZIkV@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Am 16.05.2025 um 08:00 hat Christoph Hellwig geschrieben:
> On Thu, May 15, 2025 at 12:11:49PM +0200, Kevin Wolf wrote:
> > If you're talking about SG_IO in dm-mpath, then PRIN/PROUT commands are
> > actually the one thing that we don't need. libmpathpersist sends the
> > commands to the individual path devices, so dm-mpath will never see
> > those. It's mostly about getting the full results on the SCSI level for
> > normal I/O commands.
> > 
> > There has actually been a patch series on qemu-devel last year (that I
> > haven't found the time to review properly yet) that would add explicit
> > persistent reservation operations to QEMU's block layer that could then
> > be used with the emulated scsi-hd device. On the backend, it only
> > implemented it for iscsi, but I suppose we could implement it for
> > file-posix, too (using the same libmpathpersist code as for
> > passthrough). If that works, maybe at least some users can move away
> > from SCSI passthrough.
> 
> Please call into the kernel PR code instead of hacking up more of
> this, which will just run into problems again.

I agree that using kernel code is preferable to doing things behind the
kernel's back.

However, libmpathpersist is the official interface for doing these
things with multipath devices, so I think the necessary work to make
this happen should primarily be done in the library (and possibly the
kernel if the existing interfaces aren't good enough).

QEMU could directly call the kernel when qemu-pr-helper isn't in use.
I don't know enough about how libmpathpersist works internally to tell
if running it this way would be a good idea for multipath devices. Can
multipathd still do its job with reservations being made behind its
back? (It would probably be good to allow this eventually, but is it the
case today?)

Kevin


