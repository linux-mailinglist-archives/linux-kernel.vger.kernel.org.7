Return-Path: <linux-kernel+bounces-622115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F918A9E32F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5276C5A3AD3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA71531C1;
	Sun, 27 Apr 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qn+QtVQW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5B2E40B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758905; cv=none; b=A6reXhKcO1f/lH3zJxUUiBFGRLafxtDF6Vy74PborUA9IHSR1h5nSnBYuFLq/OVU7CU1R8tg36HBNl78Imjc4vOmuezm6MZ50h5sh/YMF5VA9rOhUwJL/0ttQ48KMLVqj9eG3BVr/fFVqzgV7FqYmaMiKtU0imcQxbfCn0qU4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758905; c=relaxed/simple;
	bh=ZglE8CasNQkRyZwqQ07x19uhJCcBvo7NtP6MxqxWpbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jbxf0P03n/kl4bClp66X8Lx+s1k2DZVD7w0dnos2xUH1jK6SdK6VAKsbUhorfnFAd0OrLPA0Rl8EJS0zTeIZifvvuQXwc8+2m0XAz8FlPih4Jzns5xD90EuW+zZzXUI+anstWsvslJrGQHi5sUkWVO7kB2omZRHfv/IoifHylIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qn+QtVQW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745758903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBmV6ADRgSJ8LWAWXhID2kwENoWgHwUt/9lB9Waom7Y=;
	b=Qn+QtVQWmF4/V1i7lt3k6ayySSmbtm/B5/FWcwTIAejF6Ox7MmMm5JXNJxWl0brn/FsTPo
	hxb/4iRsLEzoCoN2xj9ASJuaITtWqHkoH4j3f2+xVdV4QW74bEc0GoIY8EKuYinv017461
	EVTeCkcapIlD3MeAxfZSOmh1shGVUkQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-kXjJx-vhPeaIZojRNwztHQ-1; Sun,
 27 Apr 2025 09:01:40 -0400
X-MC-Unique: kXjJx-vhPeaIZojRNwztHQ-1
X-Mimecast-MFC-AGG-ID: kXjJx-vhPeaIZojRNwztHQ_1745758899
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0AF0195608A;
	Sun, 27 Apr 2025 13:01:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.119])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17FA3180045B;
	Sun, 27 Apr 2025 13:01:35 +0000 (UTC)
Date: Sun, 27 Apr 2025 21:01:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] ublk: remove misleading "ubq" in
 "ubq_complete_io_cmd()"
Message-ID: <aA4qqwHaEM42pzN_@fedora>
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427045803.772972-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Apr 26, 2025 at 10:57:58PM -0600, Caleb Sander Mateos wrote:
> ubq_complete_io_cmd() doesn't interact with a ublk queue, so "ubq" in
> the name is confusing. Most likely "ubq" was meant to be "ublk".
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


