Return-Path: <linux-kernel+bounces-666755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4439AC7B56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 11:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D491B1C04930
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5E28033D;
	Thu, 29 May 2025 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwDRkPQJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AE280CC8
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511961; cv=none; b=asVkm9jPOSpTwg5zOS/jVLXc4uxKwWCGh3oHuXpdp+qDUrotRIPM5fPpi3HraCRlt1c9JQhEbnEcHpuJ5MuFo1tfwqWn6fvc8yHRZrCd0RiidSgpD1kZ8m052EmVzx+i/gmYmRIADfSdS/iTN80vxJ3jURNFi5sScqNOIo4S+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511961; c=relaxed/simple;
	bh=C3dsgHLbVyzKSPMLEtimqxXQ5ZlGknrd6JAeTwzY2QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhpGbkocazGO5DZbXlcRrsrBnHt0UOm/c2KGIzx+ArbGB6gtxDjzV/vky7s7kHt1OMbWbVVYS7LSz/4PnCYHoK885qYXuI2eFmEgl5G2NB/HJadtpohT8bzNe1JW9GtBwYwZyIAbHgYbQlTDYGi91IYPemV7hSUvKyr7go+81Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwDRkPQJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748511958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guKLXomrM/e1x57KkYEEeXlGW3IrC3Z8fk0Z4EY8ZCQ=;
	b=EwDRkPQJJVSSwwI7gq738sZWJ6zLpgsvaLFkcuhJ8HoAqlxYbTLkZQFMFUKRzh0A90cHrs
	9QXAtyZMwj5KNM60BUxxhgN0lX1ohbeotiqGaKuMyaaE3frQF/kRpJsJ95KsksBRYPADaB
	2wRLMwVySNQBbgCdjsnnfUwXXfBX6W8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-b8JzpSiUMxSDojDNVwJUXQ-1; Thu,
 29 May 2025 05:45:55 -0400
X-MC-Unique: b8JzpSiUMxSDojDNVwJUXQ-1
X-Mimecast-MFC-AGG-ID: b8JzpSiUMxSDojDNVwJUXQ_1748511954
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDF741850FD0;
	Thu, 29 May 2025 09:45:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 775B519560AE;
	Thu, 29 May 2025 09:45:35 +0000 (UTC)
Date: Thu, 29 May 2025 17:45:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 3/8] selftests: ublk: kublk: tie sqe allocation to io
 instead of queue
Message-ID: <aDgsups3ZCp3p3aq@fedora>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
 <20250527-ublk_task_per_io-v7-3-cbdbaf283baa@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-ublk_task_per_io-v7-3-cbdbaf283baa@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, May 27, 2025 at 05:01:26PM -0600, Uday Shankar wrote:
> We currently have a helper ublk_queue_alloc_sqes which the ublk targets
> use to allocate SQEs for their own operations. However, as we move
> towards decoupled ublk_queues and ublk server threads, this helper does
> not make sense anymore. SQEs are allocated from rings, and we will have
> one ring per thread to avoid locking. Change the SQE allocation helper
> to ublk_io_alloc_sqes. Currently this still allocates SQEs from the io's
> queue's ring, but when we fully decouple threads and queues, it will
> allocate from the io's thread's ring instead.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


