Return-Path: <linux-kernel+bounces-891978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63036C43FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 15:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6E0188C38D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89B2FB62C;
	Sun,  9 Nov 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3sC7Qw6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F6883F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697429; cv=none; b=klcqXVudbr5u9E6eCCRKo4FTw3Kq979r+8KFjj+G235t0W2LrSHwOKp5bOEotaQ9yU7UZIoaHILFcUs4AXp/UzhohZOp1cecHZb+vrtLYDUxXaEh+m22AZ7xvNAXbqr4sCy36+a5cb7tHrZBRinkQvd91kQFwyd13yC3AtmWp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697429; c=relaxed/simple;
	bh=sgI1/eUFrILj6wvdND38wYbLB6Flw8nV7OnLGaaPZxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBcQwJqSY0UkhMjmG2cpW/LjzHHlmjmvKBYhJkKATSHhS5njJQRPIJILHkNp+OWFlsC0ut5A1D/EAfasv1MzRsKb93tlz8B1ZHt68DOWCCYVCwxeg6ifQ1tt4pW9IGKCP/u8alKjClKiTLXm4MUna7IUQeaC4Z/5EwRpWHc7qsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3sC7Qw6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762697425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uBlAd3hXdjYytscmpv4W9r+BbTlVxRqdbdY/rC5rp8o=;
	b=f3sC7Qw6q+yrk/HxwGBaojJNE9+KtGPUm3AdaTJrZU7//AHYbShWimoGQnnOatLzVEgY3m
	Ce7fFJW+p0e34rabWJVI3jMeebsPKvtJBIIBVTQNX3JT0xX974W8W7IwAMQZdY1If3/XV6
	mfNdyn78W7Ir3syhbvz8mXQeDRRF5qY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-4_3F8eLxM2eMLi-rpyp9xQ-1; Sun,
 09 Nov 2025 09:10:24 -0500
X-MC-Unique: 4_3F8eLxM2eMLi-rpyp9xQ-1
X-Mimecast-MFC-AGG-ID: 4_3F8eLxM2eMLi-rpyp9xQ_1762697423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09DC31956094;
	Sun,  9 Nov 2025 14:10:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.19])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84498180057A;
	Sun,  9 Nov 2025 14:10:17 +0000 (UTC)
Date: Sun, 9 Nov 2025 22:10:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: remove unnecessary checks in
 ublk_check_and_get_req()
Message-ID: <aRCgw_DpO9PVWu48@fedora>
References: <20251108221746.4159333-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108221746.4159333-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Nov 08, 2025 at 03:17:45PM -0700, Caleb Sander Mateos wrote:
> ub = iocb->ki_filp->private_data cannot be NULL, as it's set in
> ublk_ch_open() before it returns succesfully. req->mq_hctx cannot be
> NULL as any inflight ublk request must belong to some queue. And
> req->mq_hctx->driver_data cannot be NULL as it's set to the ublk_queue
> pointer in ublk_init_hctx(). So drop the unnecessary checks.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


