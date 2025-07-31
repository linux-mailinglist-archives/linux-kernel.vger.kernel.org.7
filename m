Return-Path: <linux-kernel+bounces-751870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682EB16E94
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2E7621558
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC11F2BE028;
	Thu, 31 Jul 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzMq5fst"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C829CB59
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953941; cv=none; b=UKWJLPKSJpXqncaA35vWnHT6gKNQaaFmbpYiYDhfKvptPP8eoYgTMcX/N9TYtLQ5/ZdisAPc0dr8X7cEdWom/tDJoKzYxgQIP+Mzh6nwsdLI3y6alqwF/iK7oqBcfnMhMuO0vP0IDyhdr2wv1/z4lcwSfonq91D6Z3LBqLyPoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953941; c=relaxed/simple;
	bh=F/kyMRg9amWHy5VNn12meu3kJW8SbR2vDu83nieisB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwqGIrm1uG6vEPiSq0jXxUbHF1X2WlP9kkJAwuV8O3T7OGUoLxYd856FEebU1k4WQsYTSlJ3I5Nm3r8OSqdw5B1VVJW/ZBQE7chHTBTjHh9j0Rni/t3mpY4s1NEzvKcKdSGGF2IC+6pVN5TzXYY9K1sI2Gga3fEI7hW1VM5kov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzMq5fst; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753953938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKeh7VJ5S9c7YzR0dFENlYj0yyHuQf1HeWrzZHEAVrI=;
	b=OzMq5fstUxZVBqF++s3svSak02bmvnEUBE11bCu2hMhGcd+gtAXM1sUT67G3hC0EhnwpTq
	qlNlYvXzwnjavpdhgl6oT67nsiLpXytkMd2pCPCXqLM9tbTrIgQ+QZOBjWrXmLIa3x4CeV
	4AIBrqms2Bsr9bBh0lf8RQQxEsVNoh8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-MKYe2GG6PwSFD4D4UfMOBw-1; Thu,
 31 Jul 2025 05:25:32 -0400
X-MC-Unique: MKYe2GG6PwSFD4D4UfMOBw-1
X-Mimecast-MFC-AGG-ID: MKYe2GG6PwSFD4D4UfMOBw_1753953930
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BA2A180035F;
	Thu, 31 Jul 2025 09:25:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEB5E19776D1;
	Thu, 31 Jul 2025 09:25:20 +0000 (UTC)
Date: Thu, 31 Jul 2025 17:25:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: dlemoal@kernel.org, hare@suse.de, jack@suse.cz, tj@kernel.org,
	josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 0/5] blk-mq-sched: support request batch dispatching
 for sq elevator
Message-ID: <aIs2e3wJpMmCHeZk@fedora>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <aIsmvj_lxLA6ZaWe@fedora>
 <99e9aa7e-b33c-ce2e-bf0f-0021434690e8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99e9aa7e-b33c-ce2e-bf0f-0021434690e8@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jul 31, 2025 at 04:42:10PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/31 16:18, Ming Lei 写道:
> > batch dispatch may hurt io merge performance which is important for
> > elevator, so please provide test data on real HDD. & SSD., instead of
> > null_blk only, and it can be perfect if merge sensitive workload
> > is evaluated.
> 
> Ok, I'll provide test data on HDD and SSD that I have for now.
> 
> For the elevator IO merge case, what I have in mind is that we issue
> small sequential IO one by one with multiple contexts, so that bios
> won't be merged in plug, and this will require IO issue > IO done, is
> this case enough?

Long time ago, I investigated one such issue which is triggered in qemu
workload, but not sure if I can find it now.

Also many scsi devices may easily run into queue busy, then scheduler merge
starts to work, and it may perform worse if you dispatch more in this
situation.

Thanks,
Ming


