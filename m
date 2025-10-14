Return-Path: <linux-kernel+bounces-852084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77766BD820D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EF9A4F7AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170D2DC785;
	Tue, 14 Oct 2025 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ox8ZqGjs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDD2D660D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429752; cv=none; b=es5knkpzLcPwNEyUnxHhezSOQg2jXP/SR0w1P/U6DIkoK/mcnFsL3TGK+gBIRgblXMBf0KBPVIVtH4oZDVwTiFpgLniqjTf4ZUcE1aTC8IxhaHqY1ClDe7cidaPZCza5GVMDQRNN+SH8/CJZ6kFToW+51956iz189ffGbWNnN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429752; c=relaxed/simple;
	bh=T3VM9+nJOucKbcAUNaLY7AnPZybT97dyUiiCrlM3Of4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwlZdUQj9vdBsq2sL0dxiqPDAxNQ7x5B1WY1/Z5B5gEeVuBe4oMLGAa9pMxNQ43hnQF2u1IzV8G7laHkz/bJHgoLT97MvoHZzpTn3RUhrqAW4+y//s1PzdTB9JdmiTbseHA4kuGdV6xz/o5jzLEO6g/c+5PWbw2QSGZxBAIR+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ox8ZqGjs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760429749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRy/NLeLP/eFxKeQw3E8oGP9HZl94Z/4n7yWShfTFEg=;
	b=Ox8ZqGjspf1TtcrXCW2chJtYjJr/vqtfNf/cBMPqCGjSIBD+8zT1iq1cCnH5SlAH8XZ97p
	qh+/ePevS2vTnrjc3D+cZ+6nVVGVcPr/t0FrsaI3pl1Hjmz3nEXFzpm+B5WAo04I1UE4tc
	TbpqcLE/RmEdAkB/YTVZQEfNucPylno=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-a295BwRoPSuqjrnzznlUcw-1; Tue,
 14 Oct 2025 04:15:44 -0400
X-MC-Unique: a295BwRoPSuqjrnzznlUcw-1
X-Mimecast-MFC-AGG-ID: a295BwRoPSuqjrnzznlUcw_1760429742
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 716781800577;
	Tue, 14 Oct 2025 08:15:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AFEB1955F21;
	Tue, 14 Oct 2025 08:15:34 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:15:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai3@huawei.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH 4/4] blk-mq-debugfs: make blk_mq_debugfs_register_rqos()
 static
Message-ID: <aO4GoVOqVBh1RMw-@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-5-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014022149.947800-5-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 14, 2025 at 10:21:49AM +0800, Yu Kuai wrote:
> Because it's only used inside blk-mq-debugfs.c now.

If it is true, why do you export it in 2nd patch?

Thanks, 
Ming


