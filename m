Return-Path: <linux-kernel+bounces-645564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A0AB4FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 11:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC853ABA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB12226863;
	Tue, 13 May 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8HqYb3T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312F20E6E7
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128562; cv=none; b=ShkZgoFofUQs2+1WI0AjMu+V9EUYo8DiqylA0qOLI4SkoISPmO4YP5jueO05ucEBtw6GNgXDvM2CnByQz9RzK8EUrlnGqGtqwqQafAu79CJxVGw1Aha1KmXt1Y0KbAlDC0CcAtV4GSQLVhPirWuyFKoVPsxWsW6r4ZFqYob/D6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128562; c=relaxed/simple;
	bh=8O7CUj/TgXcdonn9vBDT5qTqdIn+fJHSMgChw4LhMjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0sczwTKB8X8aaGzMHjuBK+Gzv9CrH+1Mj1d5QJhVpwTkh6alao+CS0dBCZIqL67aFIqSNkrJ3MZS6BYIOfWi0U7/TdLU+sne7FtPSJiki349PF96UGNOTrZBHdYF/EXXZOpW14trG8NWWmpDrzCW8/kWycgsdNmZEIxDZ62E3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8HqYb3T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747128560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93t4tFkIyPCogX7UwUqjdNFHzcw9/x4QgZzmXcOPlSo=;
	b=X8HqYb3TI7JgDhFqXD1+i8yUddYAsvNmMka87R2sp63BneTtdKvHN2PoXlEEsfJ3dA2iEB
	lcheWQsNegrmaA3a8Vccu27U5YkRrM6CK2Te73PBhGoPHcFUG1fX/P6LhZ0phdNzz3kv1/
	S2lRkX090B+APVWqqhufZN1gNwCRrBE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-D5izl036PjW_6LLqymc3TA-1; Tue,
 13 May 2025 05:29:17 -0400
X-MC-Unique: D5izl036PjW_6LLqymc3TA-1
X-Mimecast-MFC-AGG-ID: D5izl036PjW_6LLqymc3TA_1747128555
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F5F51955DB2;
	Tue, 13 May 2025 09:29:15 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.238])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E8BD1953B82;
	Tue, 13 May 2025 09:29:12 +0000 (UTC)
Date: Tue, 13 May 2025 11:29:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Wilck <mwilck@suse.com>, dm-devel@lists.linux.dev,
	hreitz@redhat.com, mpatocka@redhat.com, snitzer@kernel.org,
	bmarzins@redhat.com, linux-kernel@vger.kernel.org,
	pbonzini@redhat.com
Subject: Re: [PATCH 0/2] dm mpath: Interface for explicit probing of active
 paths
Message-ID: <aCMQ5S-gI6vZJxmq@redhat.com>
References: <20250429165018.112999-1-kwolf@redhat.com>
 <47dd225b433b0df585a25084a2e793344eeda239.camel@suse.com>
 <aCIRUwt5BueQmlMZ@redhat.com>
 <aCLe5UT2kfzI96TQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCLe5UT2kfzI96TQ@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Am 13.05.2025 um 07:55 hat Christoph Hellwig geschrieben:
> On Mon, May 12, 2025 at 05:18:43PM +0200, Kevin Wolf wrote:
> > Yes, it's a bit unfortunate, but we have to work with what we have. QEMU
> > doesn't even necessarily know that it's dealing with a multipath device,
> > so it just has to blindly try the ioctl and see if it works.
> 
> Why is qemu even using SG_IO to start with?

How else would you do SCSI passthrough?

Ok, from your replies to Hannes I understand an implicit message, you
wouldn't. But I don't think that's really an answer, at least not for
all users.

Yes, I'll give you that in the long term, we might be able to move some
passthrough users away from it by using more specific interfaces like
for persistent reservations (though see below). But for example, it's
also used for vendor-specific commands and I don't see how Linux could
ever provide more specific interfaces than SG_IO for those.

But it's even about more than just accessing commands that aren't
otherwise accessible. Mapping a SCSI response from the device to a
single errno and back into SCSI status for the guest isn't lossless.
QEMU's scsi-block device actually started off using normal I/O for reads
and writes and using SG_IO only for things that aren't covered by normal
I/O. But then those had to be changed to SG_IO, too, so that the guest
would actually see the full SCSI status. Things the commit message
mentions are unit attention codes and handling RESERVATION CONFLICT
correctly (which made me unsure above if the more specific interface for
reservations could actually be used to fully get rid of SG_IO). For more
context, I'm adding Paolo who actually made that change back then. He
may remember the concrete bug(s) this fixed.

So if you want the guest device to behave mostly the same as your host
device, I don't really see any way around SCSI passthrough and therefore
SG_IO.

Kevin


