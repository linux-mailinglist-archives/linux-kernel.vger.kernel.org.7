Return-Path: <linux-kernel+bounces-760252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DCB1E87F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198F91C23754
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00525279798;
	Fri,  8 Aug 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgacXeh2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61278278E42
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656713; cv=none; b=hut/YMdiM4gDOmqNb25Pr/yxI0BzxxDKRJzp2C4EBrkiMm8n5I60BZH5Ga9vTqWPucIEBo09ZYI+gFevRhp7aMrFPLDZxKuiHD2s0p/Y+qSJq7DxAtC2GmwXVDxsLPbgGi1jiUpOYsAVoix28smZJuRqrvKg4tZByc7Yt+6QVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656713; c=relaxed/simple;
	bh=+z1SARUox8cV+m8+0oqKQI8N2ni6j8C28ZvZfwIMiVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRjHq6HGteXGtnslUTSa/aSAqevM0Et3OrWYeQBgxCvVuPDYIp2cGWMZZmLotdyTJz7LzHiCwd8kI6227IV1BLNPG8K6DseM95ilLkuel0TKmE7txrIuR6ZoSwlwxlgkwVMRXS8X2An7MQR3KBI2kdYYMqjlYpCrma82NcCHNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgacXeh2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754656710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2c5qQSEQJ04PpUTVBYvGevi1pSNfV7Q71bDlXVhAWyw=;
	b=AgacXeh2Bp8yo9/gEJJ+qyJbf3bCh8rS9m0kZ0rE35V37uO1k7wa+4Y2o3sWGFvHBcIxoU
	lgPSR+oyqGL7RzrsucKkvNKKu43teTa27GFyWtgbTBayJASJUqrOJr4afxxM6OV4u+xGv9
	DFhxrDE2pKbUhorFGla+ZvTELTLdWcU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-Lvq33mHbNX2NeCDMkBqKYQ-1; Fri,
 08 Aug 2025 08:38:28 -0400
X-MC-Unique: Lvq33mHbNX2NeCDMkBqKYQ-1
X-Mimecast-MFC-AGG-ID: Lvq33mHbNX2NeCDMkBqKYQ_1754656707
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D6AE1800561;
	Fri,  8 Aug 2025 12:38:27 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7488930002C0;
	Fri,  8 Aug 2025 12:38:26 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs: more client side tracepoints in write and
 writeback codepaths
Date: Fri, 08 Aug 2025 08:38:24 -0400
Message-ID: <620922BE-915F-4987-8AD6-3D62D4749FB6@redhat.com>
In-Reply-To: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
References: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8 Aug 2025, at 7:40, Jeff Layton wrote:

> This is a pile of tracepoint additions and cleanups. Most of these I
> plumbed in while tracking down the recent client-side corruption I've
> been hunting. Please consider for v6.18.
>
> Thanks,
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (5):
>       nfs: remove trailing space from tracepoint
>       nfs: add tracepoints to nfs_file_read() and nfs_file_write()
>       nfs: new tracepoints around write handling
>       nfs: more in-depth tracing of writepage events
>       nfs: add tracepoints to nfs_writepages()
>
>  fs/nfs/file.c     |  20 ++++++--
>  fs/nfs/nfstrace.h | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/nfs/write.c    |  22 +++++++--
>  3 files changed, 168 insertions(+), 9 deletions(-)
> ---
> base-commit: 0919a5b3b11c699d23bc528df5709f2e3213f6a9
> change-id: 20250807-nfs-tracepoints-f1d84186564d
>
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>


These look great.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


