Return-Path: <linux-kernel+bounces-887787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33901C39168
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 05:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 069824E2056
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 04:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAEC2C235D;
	Thu,  6 Nov 2025 04:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyNsUC6n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4D2C11CF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 04:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402991; cv=none; b=fEgjo1MMqu6uF1Z16ubHANv6J2brcREAZhqs4L8w7/DE/TtWNVw+ZAA9oHK/j3OHc2UK+Y7CIIFqRBo1Kg2zwKAqAm01lXnU/ekpyYaQ5dQ4ERikQtwNaiCu6QR44/DmfMWdlyGKfdIoYrdQoiLlIqTjaGJjisPwRv+mdC5G+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402991; c=relaxed/simple;
	bh=MDu/x5MjuWQmqdTJsivVkQennR0uk9XQkzjnFg+MG6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuGZjeIItbsXPYr564kggTczxcNCVQzpiWit48gpfupg8R4gi/3auvfnOPFi0rF93s3DBIT3SCpojjU1xtBTK59b5LGbbMGUmXEaoFEr80sA62zyaWNBxTJHmF9Euo6nnDRVbomWoS9v5s8I0enQ9+148ttVIPbRS6SYaO6lJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyNsUC6n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762402988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McWH5uoiv0Qcs12llAIn0we0DdmJGhAn3KTRWhafxfs=;
	b=NyNsUC6nucS6ylondWNnck0nEex8EnTgZpWzELUucUBEnFjhN7KLFxAjAhcCJztdfsFWWI
	koHx7slRQUvlfHkUP+9lxuSkWugR5vP9ETr0qVzsY9/+OuPNPCzYsRvWCkWo7EPRdKvMs4
	VnIKAzsWbYHnQ66qbgJ2eztVvGOb6N4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-_eNqBynKOEKO6sRZQ5qoTQ-1; Wed,
 05 Nov 2025 23:23:03 -0500
X-MC-Unique: _eNqBynKOEKO6sRZQ5qoTQ-1
X-Mimecast-MFC-AGG-ID: _eNqBynKOEKO6sRZQ5qoTQ_1762402982
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 998B81800350;
	Thu,  6 Nov 2025 04:23:01 +0000 (UTC)
Received: from fedora (unknown [10.72.120.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9BC3300018D;
	Thu,  6 Nov 2025 04:22:57 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:22:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ublk: use copy_{to,from}_iter() for user copy
Message-ID: <aQwinGy55Bk0r-LU@fedora>
References: <20251105202823.2198194-1-csander@purestorage.com>
 <20251105202823.2198194-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105202823.2198194-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 05, 2025 at 01:28:22PM -0700, Caleb Sander Mateos wrote:
> ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> iov_iter_get_pages2() to extract the pages from the iov_iter and
> memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
> Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
> user page reference count increments and decrements and needing to split
> the memcpy() at user page boundaries. It also simplifies the code
> considerably.
> Ming reports a 40% throughput improvement when issuing I/O to the
> selftests null ublk server with zero-copy disabled.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


