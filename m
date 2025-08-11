Return-Path: <linux-kernel+bounces-762012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCCAB2010D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC0617CFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F523507C;
	Mon, 11 Aug 2025 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLO+LuoO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0901F936
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899251; cv=none; b=rFtEmChe2bV6ChlZ/ONM6oSulm6wZq6luBeZbK0agyYWvtSytT1QERBOYKiI2GyblK7/Ek9Q9J8hzbTA5mvh6hNAGrGLZO8g7D5Hbx+4OvfDTkseAEg05CJ14Ejsh4SgiNkn8bIBXqfJ0xHAwhtds+VyILIJ6oxSaPO8RgN3Gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899251; c=relaxed/simple;
	bh=cjZtRu5OXf9JXKnHATVcX5fDwbKbX0uvLSrZsQCQxvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5EIk+xTGwmB4vPYPnSKaGZJPQODWIRZI9LYBE00gt0Kud9may4+rehzYNXv4iobvlrRihGBxCbzh0sC3wnbsEf0K3bic17tfy/90VXV+B/ZXPw4gKn8txHjxlOoH8Z5iPmfFMfDy4FVfollIC4GB2z+52OjKb5Lfmt6ogPRuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLO+LuoO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754899248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M05mA5/Cn/fNMaklkCPAr949XgPrcsIP2UFNbyCPgnk=;
	b=NLO+LuoOBjrj2ABT7qyVnRtUqoiSEHUXxSi0tPJLSWTuEvOumq5ptOcifI4L6rP7Pbqrcl
	oIe18QGQkK1OWr77i6TETYhgClDvMBQHVJh0COVqAMRSDlsYJv1Kr6sHvNfZgxfp1pNi4s
	GeXrWqwB2eyfakTqtvyC+9hc1jWdaM4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-h86qnwARO5CHbDkC1CS7QQ-1; Mon,
 11 Aug 2025 04:00:43 -0400
X-MC-Unique: h86qnwARO5CHbDkC1CS7QQ-1
X-Mimecast-MFC-AGG-ID: h86qnwARO5CHbDkC1CS7QQ_1754899242
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4CC51800451;
	Mon, 11 Aug 2025 08:00:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.98])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC4D019560AD;
	Mon, 11 Aug 2025 08:00:31 +0000 (UTC)
Date: Mon, 11 Aug 2025 16:00:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
	zhengqixing@huawei.com, lilingfeng3@huawei.com, nilay@linux.ibm.com
Subject: Re: [PATCH v2] block: fix kobject double initialization in add_disk
Message-ID: <aJmjE6QvRrVyQwgi@fedora>
References: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 08, 2025 at 01:36:09PM +0800, Zheng Qixing wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
> 
> Device-mapper can call add_disk() multiple times for the same gendisk
> due to its two-phase creation process (dm create + dm load). This leads
> to kobject double initialization errors when the underlying iSCSI devices
> become temporarily unavailable and then reappear.
> 
> However, if the first add_disk() call fails and is retried, the queue_kobj
> gets initialized twice, causing:
> 
> kobject: kobject (ffff88810c27bb90): tried to init an initialized object,
> something is seriously wrong.
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5b/0x80
>   kobject_init.cold+0x43/0x51
>   blk_register_queue+0x46/0x280
>   add_disk_fwnode+0xb5/0x280
>   dm_setup_md_queue+0x194/0x1c0
>   table_load+0x297/0x2d0
>   ctl_ioctl+0x2a2/0x480
>   dm_ctl_ioctl+0xe/0x20
>   __x64_sys_ioctl+0xc7/0x110
>   do_syscall_64+0x72/0x390
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fix this by separating kobject initialization from sysfs registration:
>  - Initialize queue_kobj early during gendisk allocation
>  - add_disk() only adds the already-initialized kobject to sysfs
>  - del_gendisk() removes from sysfs but doesn't destroy the kobject
>  - Final cleanup happens when the disk is released
> 
> Fixes: 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Closes: https://lore.kernel.org/all/83591d0b-2467-433c-bce0-5581298eb161@huawei.com/
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


