Return-Path: <linux-kernel+bounces-738970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C49B0BFC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E39189E73D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918DA289369;
	Mon, 21 Jul 2025 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWbd2Y2e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85CEAC6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089334; cv=none; b=t1XNG7E7+Ok6UXbNnY8LSeHG5hu9B/kApC2HmdYWXnwNyVhXIUIAPkCucqHNe0kWa4oxGbpoJK1GzklXnwAIQAzHrYUGMsvIfazKqqZOV5qWVnOXKkeis3JjnbtVavRTYPMZT0C8aMnlWd4RTQsyJCQ+bCQD/ePmO3yt4JAr2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089334; c=relaxed/simple;
	bh=VUqpeieItmRy+6krQTtjvBkMriLDepTx2K1OxLH8LA4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XzHaYYiaRJZnhl84EsRb1f0dlytIEWQSm3AJusJS1yVR/BGfbHdWVdeBCNq1iwjJsTKsLCrMOvxxlxsNcbHcAQDjwuKOXS7/C37lwuZopNXhoAQCH/UgSAu5Zy15wonuEbQt0f/iZ+aBZ/fHKTr9pOUovEbpbPk7OYeHmAMakAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWbd2Y2e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753089331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gOo2Uhf03mStzeNe5O5JtC75m9m/G/QejYzox/jWos=;
	b=gWbd2Y2ePpa1yjbjYnZoUSQo1jVCG4W3YSNsk+gaa9K7MaOK19k3t3LE8Fm/47UeaH7L09
	B+sjRxqWsf0rZzkeFyfVtrwnPgds9CiHdTocIkUcdpA6gS4/9RLVVzhaynrX4AZnoHorut
	xthjqfCfFV84xo7oFwaGOPrmiHv4O98=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-SsbRPYtZMF2PXQCL6dCeUA-1; Mon,
 21 Jul 2025 05:15:27 -0400
X-MC-Unique: SsbRPYtZMF2PXQCL6dCeUA-1
X-Mimecast-MFC-AGG-ID: SsbRPYtZMF2PXQCL6dCeUA_1753089326
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40CE419560B5;
	Mon, 21 Jul 2025 09:15:26 +0000 (UTC)
Received: from [10.22.80.24] (unknown [10.22.80.24])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E37F1956094;
	Mon, 21 Jul 2025 09:15:22 +0000 (UTC)
Date: Mon, 21 Jul 2025 11:15:16 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai3@huawei.com>, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    Konstantin Khorenko <khorenko@virtuozzo.com>, 
    Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH] dm-raid: do not include dm-core.h
In-Reply-To: <20250721034929.374552-1-ptikhomirov@virtuozzo.com>
Message-ID: <d524e3d7-69e2-0267-b9ef-b4dc576e6c55@redhat.com>
References: <20250721034929.374552-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On Mon, 21 Jul 2025, Pavel Tikhomirov wrote:

> In commit 4cc96131afce ("dm: move request-based code out to dm-rq.[hc]")
> we have a note: "DM targets should _never_ include dm-core.h!". And it
> is not used in any DM targets except dm-raid now, so let's remove it
> from dm-raid for consistency, also use special helpers instead of
> accessing dm_table and mapper_device fields directly. This change is
> merely a cleanup and should not affect functionality.
> 
> Fixes: 7168be3c8a6b ("md: record dm-raid gendisk in mddev")
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>  drivers/md/dm-raid.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index e8c0a8c6fb51..4fb5ddf50560 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -14,7 +14,6 @@
>  #include "raid5.h"
>  #include "raid10.h"
>  #include "md-bitmap.h"
> -#include "dm-core.h"
>  
>  #include <linux/device-mapper.h>
>  
> @@ -3305,7 +3304,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  
>  	/* Disable/enable discard support on raid set. */
>  	configure_discard_support(rs);
> -	rs->md.dm_gendisk = ti->table->md->disk;
> +	rs->md.dm_gendisk = dm_disk(dm_table_get_md(ti->table));
>  
>  	mddev_unlock(&rs->md);
>  	return 0;
> -- 
> 2.50.0
> 

Applied, thanks.

(I deleted the Fixes line, because it is not really a bugfix and it 
doesn't have to be backported to the stable kernel branches)

Mikulas


