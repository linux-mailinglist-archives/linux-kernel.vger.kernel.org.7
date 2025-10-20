Return-Path: <linux-kernel+bounces-860915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 220CBBF1504
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B6324E260D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C6258EF0;
	Mon, 20 Oct 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBGL6kT+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ECB354AF2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964506; cv=none; b=YXE1MjPQDtxLCBhRDmfaQGZAQqKkS4H24l/HpyUMeo3TkeiLa23jfdVak6nUHLVCz7eVA3mOs3sheLlBybbczrwj5QAOq225F/53e7x6S/E7BCteCHs7s5y5fQPzm+Uk6MuTQPv0HaoexPTQaEnmoIs9TauK5zEq47621XlSdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964506; c=relaxed/simple;
	bh=+qf+TjXxCiR0qhVf7qManTV2DzqIOclaw3kvS4WkbAw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tGB4cCCYlYOkz4f78N1jKIgp+xmAOnsjlu4knaBhdNQcuF7Z8E5HdyPbcwKaOzY5irHBngFd1clzp0W0ZMFO8nP9cFj4/UBm1WFqPrE+/ZgqS/i7KTIsml1OKhm1LLeFflBlipu03KxLYu633htrHL+vPxKm7OUTrhQpD/j2iNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBGL6kT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760964503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AT1ICbYdC6I6dRAB8zElo0gTfdZGTrpQstLYEHePEfo=;
	b=JBGL6kT+2aDCD/4u/BVkxEpxofiRTCevvkZZDzqUMH6x7k0rrRg4DfLsr/C/mrY/YZCgh9
	MfEtoIgLPH4FtlYUfOH7z/f2KiZYc7p3Z9dZuhgHO8Rrhj8iAC+gHIIPii77gT1rYHGnzD
	V8eN3nRoztKCxjZTTh1hScopxwZrhHE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-a5XKjd30OVCMkzi3lUktBA-1; Mon,
 20 Oct 2025 08:48:20 -0400
X-MC-Unique: a5XKjd30OVCMkzi3lUktBA-1
X-Mimecast-MFC-AGG-ID: a5XKjd30OVCMkzi3lUktBA_1760964499
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16C9A19541AA;
	Mon, 20 Oct 2025 12:48:19 +0000 (UTC)
Received: from [10.44.32.107] (unknown [10.44.32.107])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 650FA3000218;
	Mon, 20 Oct 2025 12:48:16 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:48:13 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
cc: Alasdair Kergon <agk@redhat.com>, DMML <dm-devel@lists.linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] dm-bufio: align write boundary on bdev_logical_block_size
In-Reply-To: <20251020123350.2671495-1-urezki@gmail.com>
Message-ID: <cdb598ce-88ec-0c3c-8e4b-b557093bea92@redhat.com>
References: <20251020123350.2671495-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Mon, 20 Oct 2025, Uladzislau Rezki (Sony) wrote:

> When performing a read-modify-write(RMW) operation, any modification
> to a buffered block must cause the entire buffer to be marked dirty.
> 
> Marking only a subrange as dirty is incorrect because the underlying
> device block size(ubs) defines the minimum read/write granularity. A
> lower device can perform I/O only on regions which are fully aligned
> and sized to ubs.

Hi

I think it would be better to fix this in dm-bufio, so that other dm-bufio 
users would also benefit from the fix. Please try this patch - does it fix 
it?

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>

There may be devices with logical block size larger than 4k. Fix
dm-bufio, so that it will align I/O on logical block size. This commit
fixes I/O errors on the dm-ebs target on the top of emulated nvme device
with 8k logical block size created with qemu parameters:

-device nvme,drive=drv0,serial=foo,logical_block_size=8192,physical_block_size=8192

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/md/dm-bufio.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/md/dm-bufio.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-bufio.c	2025-10-13 21:42:47.000000000 +0200
+++ linux-2.6/drivers/md/dm-bufio.c	2025-10-20 14:40:32.000000000 +0200
@@ -1374,7 +1374,7 @@ static void submit_io(struct dm_buffer *
 {
 	unsigned int n_sectors;
 	sector_t sector;
-	unsigned int offset, end;
+	unsigned int offset, end, align;
 
 	b->end_io = end_io;
 
@@ -1388,9 +1388,10 @@ static void submit_io(struct dm_buffer *
 			b->c->write_callback(b);
 		offset = b->write_start;
 		end = b->write_end;
-		offset &= -DM_BUFIO_WRITE_ALIGN;
-		end += DM_BUFIO_WRITE_ALIGN - 1;
-		end &= -DM_BUFIO_WRITE_ALIGN;
+		align = max(DM_BUFIO_WRITE_ALIGN, bdev_logical_block_size(b->c->bdev));
+		offset &= -align;
+		end += align - 1;
+		end &= -align;
 		if (unlikely(end > b->c->block_size))
 			end = b->c->block_size;
 


