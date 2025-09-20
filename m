Return-Path: <linux-kernel+bounces-825594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA45B8C4A3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033CE3AFF04
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3805528689B;
	Sat, 20 Sep 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csOi9TV4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4433245008
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360765; cv=none; b=ounu0S7sXr7SfvYRLloUdRyVKBYKo5PeYHLZdPOhtGhSTbfWgbdLOjz9s4aFsf3AuKlm3Sebrkxpoge7Iv76w6GFsw7E0YBO0iFX2/9kdgiePhmL3AjpmNtaW9XpzTyzIcvbaEKPxWP5mUkLt6sY/bgUf/arSrwnCv0kgWref7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360765; c=relaxed/simple;
	bh=jn38kqNQ68eBb5l0qOBdrpaI4pY00xyMabeElzMRJ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKpcybx+uD/yMeAOJOWnDbaWIEdbH5Jv2ebCGWUkzUstVJgWWgu5O4opl9Q83uNgVlyo7Unf3gIJqeWvgE9wkhjsGgjsvtsySCH5XbMlJTrQUCllu3rV3bpuA+NIN2gXoq5D989Ay5q1XEPRR3Vaj/e+kkG96y5Hf6wTT0IdW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csOi9TV4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758360761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eMl2rs7B+0VhWHxG3X4Q//o1ou3ScAhGCqRNzOkP7TU=;
	b=csOi9TV4hLDkHM//kFwhubaOJBzoN5BoSCAThrize98MGI/2vK5YgNfU3jLSY2DH730hUY
	iZanJnziLvye48Kd0w82IMUGS7DpVhs6GPutF+k3gfTxxlLNIwO9ch6h0MfFsiGZjhdbNg
	OD8h6fS31WKCUp6SWX1UJgJdFwRa/eQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-YLcDCQbnPiK0nSRycQkiLg-1; Sat,
 20 Sep 2025 05:32:37 -0400
X-MC-Unique: YLcDCQbnPiK0nSRycQkiLg-1
X-Mimecast-MFC-AGG-ID: YLcDCQbnPiK0nSRycQkiLg_1758360756
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C375C19560B2;
	Sat, 20 Sep 2025 09:32:36 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C6CE1800451;
	Sat, 20 Sep 2025 09:32:32 +0000 (UTC)
Date: Sat, 20 Sep 2025 17:32:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] ublk: avoid accessing ublk_queue to handle
 ublksrv_io_cmd
Message-ID: <aM50q-eujoY7uvwc@fedora>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Sep 17, 2025 at 07:49:36PM -0600, Caleb Sander Mateos wrote:
> For ublk servers with many ublk queues, accessing the ublk_queue in
> ublk_ch_uring_cmd_local() and the functions it calls is a frequent cache miss.
> The ublk_queue is only accessed for its q_depth and flags, which are also
> available on ublk_device. And ublk_device is already accessed for nr_hw_queues,
> so it will already be cached. Unfortunately, the UBLK_IO_NEED_GET_DATA path
> still needs to access the ublk_queue for io_cmd_buf, so it's not possible to
> avoid accessing the ublk_queue there. (Allocating a single io_cmd_buf for all of
> a ublk_device's I/Os could be done in the future.) At least we can optimize
> UBLK_IO_FETCH_REQ, UBLK_IO_COMMIT_AND_FETCH_REQ, UBLK_IO_REGISTER_IO_BUF, and
> UBLK_IO_UNREGISTER_IO_BUF.
> Using only the ublk_device and not the ublk_queue in ublk_dispatch_req() is also
> possible, but left for a future change.

The idea looks good: avoid to read ublk_queue since querying ublk_device is 
inevitable & enough.

For the series,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

BTW, 'const struct ublk_device *' can be passed for several helpers, and it
can be one follow-up.


Thanks,
Ming


