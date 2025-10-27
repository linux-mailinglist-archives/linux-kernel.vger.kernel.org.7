Return-Path: <linux-kernel+bounces-870739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC28C0B919
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E75BB4E8999
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7874236A73;
	Mon, 27 Oct 2025 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9r9KL0i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C09233722
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761527244; cv=none; b=qrwpAWs9Ux/TrUm1GNU7j4+8RLWD4Yd/jHss2dNGQbJJPmpArk5B+Sa0rvw3Xmq7yaC5bf1LsPjXJiPl84ZSK/B0I0P8uYWque3CkvV6lkN88BtAvhjx1W32Z73UzgCNDh1HnD3u/0TYwSczjj/Vs34zv/gKcL97Vp22pAjc0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761527244; c=relaxed/simple;
	bh=Ooe0nZxzMsht5d6mISZP87sfL1uzhvy5l+GIeUPNI8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq3Pxvz7ytMU5VGZfs8syQapMxBGPjsH8DHcf/6uozavAemqv5OGCmlbey8g2e1qAigFZ0nuDZy7R2q0u1gYdsVGqZf7ixvA6114RLNtGL4cXkpto3/M0MLwWBlyWXnlbi0xYIQC4t7gYR/LAuQ7+Q4VO9F0gE0Fuj3UXUoB2+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9r9KL0i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761527239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2t4mw1zSmVIWsEnWSMfaPLHnq3Vdi6wvPFKTcwFuNI=;
	b=d9r9KL0iWMPVm/usKtsYtTaYzGXteKRsgap0IENHQAqqh5y/SndBMC7SJGg/u89DUKx7n8
	5sPgJqDYSdcLyjlaLi2Wz0wZZmvx1BvoFQ5w9dCwhEQpKQLLIJPDncXUhWhLjXv4krvEWh
	DKLT5KvScd3p/eAIxkvEowniw1Ee+Wg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-W5ZfyNuRMja3ZIPxS6OHuw-1; Sun,
 26 Oct 2025 21:07:16 -0400
X-MC-Unique: W5ZfyNuRMja3ZIPxS6OHuw-1
X-Mimecast-MFC-AGG-ID: W5ZfyNuRMja3ZIPxS6OHuw_1761527234
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5E81180A25D;
	Mon, 27 Oct 2025 01:07:13 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 704B019560AD;
	Mon, 27 Oct 2025 01:07:09 +0000 (UTC)
Date: Mon, 27 Oct 2025 09:07:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] lib/group_cpus: fix cross-NUMA CPU assignment in
 group_cpus_evenly
Message-ID: <aP7Ft5Y0WEMGv7jX@fedora>
References: <20251020124646.2050459-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020124646.2050459-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Oct 20, 2025 at 08:46:46PM +0800, Ming Lei wrote:
> When numgrps > nodes, group_cpus_evenly() can incorrectly assign CPUs
> from different NUMA nodes to the same group due to the wrapping logic.
> Then poor block IO performance is caused because of remote IO completion.
> And it can be avoided completely in case of `numgrps > nodes` because
> each numa node may includes more CPUs than group's.
> 
> The issue occurs when curgrp reaches last_grp and wraps to 0. This causes
> CPUs from later-processed nodes to be added to groups that already contain
> CPUs from earlier-processed nodes, violating NUMA locality.
> 
> Example with 8 NUMA nodes, 16 groups:
> - Each node gets 2 groups allocated
> - After processing nodes, curgrp reaches 16
> - Wrapping to 0 causes CPUs from node N to be added to group 0 which
>   already has CPUs from node 0
> 
> Fix this by adding find_next_node_group() helper that searches for the
> next group (starting from 0) that already contains CPUs from the same
> NUMA node. When wrapping is needed, use this helper instead of blindly
> wrapping to 0, ensuring CPUs are only added to groups within the same
> NUMA node.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello,

ping...


Thanks,
Ming


