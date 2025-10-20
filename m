Return-Path: <linux-kernel+bounces-860048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA38BEF33A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4C03E1218
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627BF2BDC0E;
	Mon, 20 Oct 2025 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAgigDDw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E941EE02F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760931729; cv=none; b=INcTjVr9sVyZ2KE7dXSNWGosvrM+lMxoK032roPcPKwl5cqqTo+G/V8TB1oqdnUcgMkG0ps0lf3Uomd7oA6PnCl4URFNLeM7l/fSYdAkUMwGwjqFUAzg7vrqJBy/UBI9xqvyYG26gZZ6iW1kKP0y13dWSVx+uafkIJBml/OWZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760931729; c=relaxed/simple;
	bh=F7m2xN6NSKKAdtb51MAlh0ewiLoa0FeS1f5YpOfqP2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4mVfZc4bJSubstY6GIXg0mz8689HCEXl58WL/knkBnexopwBeSyPVLBR9+kfzzYWNB8UhZyOvW9RJDmGQDKiFl/HtSko7rneBiHhi00FprTxOE/Mf9zZp4v1JTSMzKLu7XUtpZE6cFHtDkxWxByqFo3BagFd9HMrYJTPcOszSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAgigDDw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760931726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMd/avdnmuS39WBEGuS+d9HiFABWbIj3ZesvQXRFs6U=;
	b=VAgigDDwpGIz8wjZJSDLU50MgCiv4MntwFrDpFw+rHaCZk7iPEg5Zqa+xg9DjUWx4OUO/E
	fft55efJZKZ64eyS5K0EoULpQBR9/N6X3CuviiYIYjRKeMxVZkhEqjioQHO3EsZwRHVeSP
	7Rmh3Ire3sLLaEJwNYqXKbzFCf6CVfw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-JHjzMSk5Pq6faMxp7b4DyA-1; Sun,
 19 Oct 2025 23:41:59 -0400
X-MC-Unique: JHjzMSk5Pq6faMxp7b4DyA-1
X-Mimecast-MFC-AGG-ID: JHjzMSk5Pq6faMxp7b4DyA_1760931718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5B6D19560A3;
	Mon, 20 Oct 2025 03:41:56 +0000 (UTC)
Received: from localhost (unknown [10.72.112.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A96719560A2;
	Mon, 20 Oct 2025 03:41:54 +0000 (UTC)
Date: Mon, 20 Oct 2025 11:41:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm-unstable tree
Message-ID: <aPWvfu5MQROcWKOf@MiWiFi-R3L-srv>
References: <20251020134517.795a133d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020134517.795a133d@canb.auug.org.au>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/20/25 at 01:45pm, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm-unstable tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/admin-guide/mm/index.rst:24: WARNING: toctree contains reference to nonexisting document 'admin-guide/mm/swap_numa' [toc.not_readable]
> 
> Introduced by commit
> 
>   9e1d0b5b7f28 ("mm/swap: do not choose swap device according to numa node")

Thanks, Stephen.

Below fix can be appended to commit 9e1d0b5b7f28 to fix the building
warning. Not sure if I need respin v5 to include this.

From 0c6f376f320dcc4d902377d540adc519394cdb12 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Mon, 20 Oct 2025 11:37:09 +0800
Subject: [PATCH] doc: clean up the relics of swap_numa
Content-type: text/plain

The doc swap_numa.rst has been removed in mm-new commit 9e1d0b5b7f28
("mm/swap: do not choose swap device according to numa node"). Clean up
the rest in mm/index.rst.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/mm/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index ebc83ca20fdc..bbb563cba5d2 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -39,7 +39,6 @@ the Linux memory management.
    shrinker_debugfs
    slab
    soft-dirty
-   swap_numa
    transhuge
    userfaultfd
    zswap
-- 
2.41.0


