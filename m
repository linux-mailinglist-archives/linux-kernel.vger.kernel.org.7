Return-Path: <linux-kernel+bounces-840675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03BBB4F34
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF3B7B0D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3C27A929;
	Thu,  2 Oct 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXPBiV+k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221012C544
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431386; cv=none; b=Of3MymLsARe1c3kqHOCVNW8Bp6UNGoqVbTSScx5epAU0Ydp1vgk07JBoKxmgszEWgkCb0rbxfVAY+ImK5EUeWO6l9CybtJTSJfNtQCbLIVXwplTZR3KGRZtwUcBQ8/gCRNhsXB/H85zlNXDIlXXcPcJXkT1eGlQGUz+u9mfodns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431386; c=relaxed/simple;
	bh=Jd/Nxn/77U6TKr3gxOFcE8YnPSlSF0Yo3DPxfKgZNLc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=b+9ToxcKIGV7dRRdnetz9J2qiTame+Cat9pZdRZvfIY/YeGBrJ7232yyaseE4BizNdBVNY3VtFSlycLv3YxisDDh7J4/UhzqfCtXThKzmR7HJRo2J49apMvu7md47ZeGcoRfzv4nvqYiekdIJ3iWJbYsspO8LJIXzLXbW2znUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXPBiV+k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759431383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LeBvsXJbZKRcWekwLFv1GcSEyAVQd9KaZvQLUBpujv4=;
	b=dXPBiV+kS3iN62Zjo3YbH7G8HanXBtAcPNYn5xfPm6tkPdZhYLLduKhXkcu73aYD16Pgdk
	AP0CJiu+Cs9OwgTSCgh091HwUqn5Dn2QJjPsRTPb36M1NzW47TH7nPWNn3p3A9ASFed7aX
	9DPqblYJevYzTGhwmgd/OYA9oAC2U58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-OOC1aUQdOwav8N3yFB6xAA-1; Thu,
 02 Oct 2025 14:56:22 -0400
X-MC-Unique: OOC1aUQdOwav8N3yFB6xAA-1
X-Mimecast-MFC-AGG-ID: OOC1aUQdOwav8N3yFB6xAA_1759431379
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A30619560BB;
	Thu,  2 Oct 2025 18:56:18 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.65.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 956D5300018D;
	Thu,  2 Oct 2025 18:56:14 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk,  bvanassche@acm.org,  ming.lei@redhat.com,
  nilay@linux.ibm.com,  linux-block@vger.kernel.org,
  linux-kernel@vger.kernel.org,  yukuai3@huawei.com,  yi.zhang@huawei.com,
  yangerkun@huawei.com,  johnny.chenyi@huawei.com
Subject: Re: [PATCH 5/7] mq-deadline: covert to use request_queue->async_depth
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
	<20250930071111.1218494-6-yukuai1@huaweicloud.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 02 Oct 2025 14:56:11 -0400
In-Reply-To: <20250930071111.1218494-6-yukuai1@huaweicloud.com> (Yu Kuai's
	message of "Tue, 30 Sep 2025 15:11:09 +0800")
Message-ID: <x497bxdrv3o.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Yu Kuai <yukuai1@huaweicloud.com> writes:

> Fix this problem by converting to request_queue->async_depth, where
> min_shallow_depth is set each time async_depth is updated.

Removing the iosched/async_depth attribute may cause problems for
existing scripts or udev rules.  I'm not sure if we care, but the
changelog does not seem to address this.

-Jeff


