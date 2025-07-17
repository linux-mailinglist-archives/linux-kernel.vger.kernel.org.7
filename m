Return-Path: <linux-kernel+bounces-735832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20055B09440
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12E37BBAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D8A2F7CEC;
	Thu, 17 Jul 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1jWP992"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54420F062
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777919; cv=none; b=lhGNhB3uWHLOjX8ys7xZKzdXqE9OqJOunkkISgcIg1ACcFHQppYq+VenIBkuJOVwGwQGvwH8uxOHtOMFhifCmO6/GBpWNKiabT9QcpL1BDOi+WtyqStpVDkr2O37ELMyv5fYsSWd0QlSS3dVXQxDJQZIMziSPuz0pRxphmHyQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777919; c=relaxed/simple;
	bh=iCODk3vz9pQ9hELvizADlsNgqHqbJ6FJikL9aPR1ULQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LatNQXHTDfQUkCE5p8XMbVUNnxiFh7jEJ97+0AT6Ro6LZEwrjbYvYaQt8C9G6eUUT3lPnJRRAADdA9hrJ2t0hurDIW0XlMFnoEoNf21brJ2J+gj3WiKORJIHGG52yCjeem4TVmjbadomPoKK4ZM/duD6KxbCCyRf0AZqoI+W6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1jWP992; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752777916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OzzSjsCD1Pa9yTiXogoBuFHgaMwgidcnwrRrCtsowbo=;
	b=S1jWP9923RzW0fthlApnrbt5bH9CksCg6H9A/AeETFMfArL7fTKx2MVTLGm6RynakeEJM9
	EnW1pD+QBTzkWdm0+NRzXPtiCVr9sDLHtE5MvJ/MTu8c6NpKaJib/g1kN0Kd9pyMMraZqg
	/F6S7jfkSHHgC3neMd7agwOdY9NQpf4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-BgsjEowHNROwISabuwS5aQ-1; Thu,
 17 Jul 2025 14:45:13 -0400
X-MC-Unique: BgsjEowHNROwISabuwS5aQ-1
X-Mimecast-MFC-AGG-ID: BgsjEowHNROwISabuwS5aQ_1752777911
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99057195FD1B;
	Thu, 17 Jul 2025 18:45:10 +0000 (UTC)
Received: from [10.22.80.10] (unknown [10.22.80.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DA821956089;
	Thu, 17 Jul 2025 18:45:06 +0000 (UTC)
Date: Thu, 17 Jul 2025 20:45:00 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Hou Tao <houtao1@huawei.com>
cc: Li Lingfeng <lilingfeng3@huawei.com>, dm-devel@lists.linux.dev, 
    agk@redhat.com, snitzer@kernel.org, tusharsu@linux.microsoft.com, 
    colin.i.king@gmail.com, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
    yangerkun@huawei.com, yukuai3@huawei.com, chengzhihao1@huawei.com, 
    lilingfeng@huaweicloud.com
Subject: Re: [PATCH] dm: introduce spinlocks to prevent concurrent usage and
 release of device_metadata and hash
In-Reply-To: <5a29db22-13a9-f3ea-dbf2-13ce7f7aa649@huawei.com>
Message-ID: <5be1fab4-192d-8327-b541-bb92d53313cc@redhat.com>
References: <20250717140728.3221243-1-lilingfeng3@huawei.com> <5a29db22-13a9-f3ea-dbf2-13ce7f7aa649@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On Thu, 17 Jul 2025, Hou Tao wrote:

> Hi,
> 
> On 7/17/2025 10:07 PM, Li Lingfeng wrote:
> > There is a window between freeing md->ima.active_table.hash and setting
> > md->ima.active_table.hash to NULL in dm_ima_measure_on_device_resume().
> > If dm_ima_measure_on_device_remove() accesses md->ima.active_table.hash
> > concurrently during this window, it could lead to a double free or UAF,
> > as shown below:
> 
> The UAF is a problem. However, I think the order of
> dm_ima_measure_on_device_remove() and dm_ima_measure_on_device_resume is
> bigger problem. Is it possible to order these two invocations properly
> by using suspend_lock ?

That's a good point. The patch just papers over the problem. It will fix 
the UAF warning, but it won't fix the fact that 
dm_ima_measure_on_device_resume can race with 
dm_ima_measure_on_device_remove.

The real fix would be to make sure that dm_ima_measure_* calls are never 
called concurrently on the same table - we should use existing device 
mapper locks for that.

Mikukas


