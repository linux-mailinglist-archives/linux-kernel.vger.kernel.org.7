Return-Path: <linux-kernel+bounces-627745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E30AA5496
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 21:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680021C2147B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E35C270557;
	Wed, 30 Apr 2025 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHmopTOC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE526988C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040638; cv=none; b=WZTvDtdRjEQfeXocDJQJS1upQF1ARnRZcVMMsSf89/51PNwiss8YBvGyAZK8PsWT8t3OlkLl1z4y7DrCzjdjYvOA/iTs2EP0+bSXmQFbgxQl3cDu2AvvXDFZesSHK+Q1yYQQioW30TygqHcfGVE9WTfDbijoDpC5JeShFUyDN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040638; c=relaxed/simple;
	bh=WE3U9M6bFtNqTnlRCzpMfoMFofIWbXyu0m0xU2AgNKI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MRAVImHjA9QqKgmq4INUF34pdZfKJ3MxrL8wpS+oLTNwXcYxHMxU0hAGQRvIM9ox83xGdc4h4w34Kcu9427ciE7QZ8WUbz5LKp04WPiUN04B+hUdlrjpsIzsdcI2XHLLHHvTflSxIVBsfmIJ/Zx+g130hZIthlWH9VehRywVDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHmopTOC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746040635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qcJbYty0ZuARoMmKQQUrWafrtx6uU8ln7Eiw3EBt3kw=;
	b=eHmopTOCmYUOEjVWFk4ywDoN6f8FoDUFprTgDH8CRB1mrLsp8UC89fxjPhDHJs3NKWVjel
	XY+Osj1gy0SWakdMZEZQ+GuSwYA+nR15+pEhqSzR0wfyxwqHwZRcr9rU0kMoqi1FQ7iqGZ
	7R+hzQCi+2x4ADWutbgV9QIVQoFPm4I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-sshOLpprMcSD7bfy4TRoSg-1; Wed,
 30 Apr 2025 15:17:10 -0400
X-MC-Unique: sshOLpprMcSD7bfy4TRoSg-1
X-Mimecast-MFC-AGG-ID: sshOLpprMcSD7bfy4TRoSg_1746040629
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C6251800878;
	Wed, 30 Apr 2025 19:17:09 +0000 (UTC)
Received: from [10.22.80.45] (unknown [10.22.80.45])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82504180087B;
	Wed, 30 Apr 2025 19:17:06 +0000 (UTC)
Date: Wed, 30 Apr 2025 21:17:01 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, 
    Benjamin Marzinski <bmarzins@redhat.com>
cc: Eric Biggers <ebiggers@kernel.org>, Satya Tangirala <satyat@google.com>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dm: add missing unlock on in dm_keyslot_evict()
In-Reply-To: <aBJgeV7pZ7Q47OCb@stanley.mountain>
Message-ID: <cad25513-31c4-5895-cfc0-b9c7dce4ce08@redhat.com>
References: <aBHZ4puON8GNK0vw@stanley.mountain> <20250430165037.GA1958@sol.localdomain> <aBJgeV7pZ7Q47OCb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On Wed, 30 Apr 2025, Dan Carpenter wrote:

> On Wed, Apr 30, 2025 at 09:50:37AM -0700, Eric Biggers wrote:
> > On Wed, Apr 30, 2025 at 11:05:54AM +0300, Dan Carpenter wrote:
> > > We need to call dm_put_live_table() even if dm_get_live_table() returns
> > > NULL.
> > > 
> > > Fixes: 9355a9eb21a5 ("dm: support key eviction from keyslot managers of underlying devices")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > >  drivers/md/dm-table.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > 
> > Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> > 
> > But that's an awfully error-prone API.
> 
> Yep.
> 
> > 
> > dm_blk_report_zones() gets this wrong too.
> 
> Ugh...  dm_blk_report_zones() is too weird for my static checker tool.
> The checker is looking very specifically for error paths with missing
> unlocks.

Ben already tried to fix it in dm_blk_report_zones (see the linux-dm git, 
for-next branch) - but his fix is incorrect because the "if" condition for 
dm_get_live_table and dm_put_live_table differs. I'll update his patch to 
fix this mismatch.

Mikulas

> regards,
> dan carpenter
> 


