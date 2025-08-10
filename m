Return-Path: <linux-kernel+bounces-761298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9178AB1F805
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 04:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05A6189A599
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 02:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB28B18E750;
	Sun, 10 Aug 2025 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBL5014Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF12CA4E
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754792014; cv=none; b=kCNkjBZ2ZgfHIekcdi4xAPgHVN7Lj++GrfB7mlFZXet7I/rhAarJN7XMaZJlzfJYATJug9yiL4Ew/Nn8TzW+X/No1YdlRCNA+cCBzo/893Zw83//XTiqZBl7kI6xyI46qfuWYLW2n5jiP/yv9Rxgu43t9YvH5DeBnFXKHiG+Zug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754792014; c=relaxed/simple;
	bh=dVnGKnePBw74sOHtCp/v28UGcUI3jRnvc9o/OrVl9Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMYFKKzzRbomOZ8kT98mjzjqPzf1fx7KVaHdL/GhjRMUTCy8I0OuTm6z4uNYrIeztIQ6PX7G0R+pC1FMXua67RaJ+y9E9opoVlaaSOHeX4EO1q5B7ScmHr8sd9ja7PeISDsvCfR515wZKn6+oocva9vE/Skx1aGwAyqmoTQnvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBL5014Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754792010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hhfM4rpcv7musMy2JrdGtCvlHDIjQyFAb9ebgwYg7/A=;
	b=IBL5014ZNtw9LTs5Ae/BvZeHogtCjsLYl/y1kRBkbxivwQy/ujIaf9x1q+9XzQO0n0T2kX
	mWQomdV4KgpBKpOQEMSIj2eAWnYEXHGAqKBE6v0GedRW7Lk38cZ9cmNpVKrk6cMGMx+wf8
	otO5SetLV4gexo33LlNVSa5rmKqYHRc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-sLxQ4AV9N-2GI5Raf_BgIw-1; Sat,
 09 Aug 2025 22:13:29 -0400
X-MC-Unique: sLxQ4AV9N-2GI5Raf_BgIw-1
X-Mimecast-MFC-AGG-ID: sLxQ4AV9N-2GI5Raf_BgIw_1754792008
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 107FD1956089;
	Sun, 10 Aug 2025 02:13:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E3401954199;
	Sun, 10 Aug 2025 02:13:23 +0000 (UTC)
Date: Sun, 10 Aug 2025 10:13:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: don't quiesce in ublk_ch_release
Message-ID: <aJgAP_7eB1HppEpq@fedora>
References: <20250808-ublk_quiesce2-v1-1-f87ade33fa3d@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-ublk_quiesce2-v1-1-f87ade33fa3d@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Aug 08, 2025 at 03:44:43PM -0600, Uday Shankar wrote:
> ublk_ch_release currently quiesces the device's request_queue while
> setting force_abort/fail_io.  This avoids data races by preventing
> concurrent reads from the I/O path, but is not strictly needed - at this
> point, canceling is already set and guaranteed to be observed by any
> concurrently executing I/Os, so they will be handled properly even if
> the changes to force_abort/fail_io propagate to the I/O path later.
> Remove the quiesce/unquiesce calls from ublk_ch_release. This makes the
> writes to force_abort/fail_io concurrent with the reads in the I/O path,
> so make the accesses atomic.
> 
> Before this change, the call to blk_mq_quiesce_queue was responsible for
> most (90%) of the runtime of ublk_ch_release. With that call eliminated,
> ublk_ch_release runs much faster. Here is a comparison of the total time
> spent in calls to ublk_ch_release when a server handling 128 devices
> exits, before and after this change:
> 
> before: 1.11s
> after: 0.09s
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

As commented, ->canceling is already set and observed in ublk io fast path,
this patch looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


