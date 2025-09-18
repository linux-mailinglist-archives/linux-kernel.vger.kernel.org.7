Return-Path: <linux-kernel+bounces-787480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA6B3770C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA77C7C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CC2063F0;
	Wed, 27 Aug 2025 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RScG9f9H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737919CC0C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258578; cv=none; b=pbIu26B74gL1N5x/hMUeTVa+lE06pvNCTOUDhqRxP6NYMZtDRIJ+hwR//h9FjDdShgaHoutauC7tSswN++aU5llB2cjxT+tbFdOE/fHJEtXJi8lsH7TgCMhfAF/+uq27SpzjasaybcL26it61CjtPGhwUR002bBMpjqcfmPnm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258578; c=relaxed/simple;
	bh=RhBWOxeDhjCNkAcloi64zcLtdy1Pqu00U519pdZTMzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFmi37kgMJm+asdFlQ/e2fcgAK6jhpnGfZ8P5FjmAhdE8cfJDzXMseynZj1o/AkjYHrlzQroAaVf0Q3tCQwK/64Nqo/omMEMN5yfiRDpgowNSjut1gvZwWfmZ6oavfUPl4P328Q+CHEAWKkUR/nwKzQ5l2+nWEV4mh+afjYuS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RScG9f9H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756258575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HxuLFWE113CgkxdORkCjjK0e55oZfBuoUwTzXB1jts=;
	b=RScG9f9Hd1WpNrV3mL4zmwNLNRSvtie+1M/onMmJU7yFAGE3vnMYoOvZe0KHXE53gToOkz
	sgfnBUvRXeyIs/llkl3owTuc1j6LQU7rqLCcMS9A/ZQ/GdKczcgnQRMOk+8JDdKlE9/f70
	zeRyZplc8hMJIKRA2rIMLrn8NmIrB0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-wvYcERIuM1K-bwfBBypDQQ-1; Tue,
 26 Aug 2025 21:36:12 -0400
X-MC-Unique: wvYcERIuM1K-bwfBBypDQQ-1
X-Mimecast-MFC-AGG-ID: wvYcERIuM1K-bwfBBypDQQ_1756258570
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B0681800346;
	Wed, 27 Aug 2025 01:36:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8360530001A5;
	Wed, 27 Aug 2025 01:36:00 +0000 (UTC)
Date: Wed, 27 Aug 2025 09:35:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linan666@huaweicloud.com, axboe@kernel.dk, jianchao.w.wang@oracle.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yangerkun@huawei.com, yi.zhang@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
Message-ID: <aK5g-38izFqjPk9v@fedora>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
 <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Aug 27, 2025 at 09:04:45AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/27 8:58, Ming Lei 写道:
> > On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
> > > From: Li Nan <linan122@huawei.com>
> > > 
> > > In __blk_mq_update_nr_hw_queues() the return value of
> > > blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
> > 
> > Looks we should check its return value and handle the failure in both
> > the call site and blk_mq_sysfs_register_hctxs().
> 
> From __blk_mq_update_nr_hw_queues(), the old hctxs is already
> unregistered, and this function is void, we failed to register new hctxs
> because of memory allocation failure. I really don't know how to handle
> the failure here, do you have any suggestions?

It is out of memory, I think it is fine to do whatever to leave queue state
intact instead of making it `partial workable`, such as:

- try update nr_hw_queues to 1

- if it still fails, delete disk & mark queue as dead if disk is attached

...

Thanks,
Ming


