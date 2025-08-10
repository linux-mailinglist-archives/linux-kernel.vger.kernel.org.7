Return-Path: <linux-kernel+bounces-761299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED03B1F808
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 04:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A93B899B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCE12CDBE;
	Sun, 10 Aug 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OllaE3yr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C82E403
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754792434; cv=none; b=fG7oRcn1t1yz+TKsil7bcFT9m7ti/SJs7I4s4c9T4fGhyv2P+LN75x6kzU1oIQ0//qEK1QYdbnEw32yF1Pjmj86Nu6sfnzKABTEnjx0pn23lYEdgmaAFYmu6X1zmAIxQu6PymFgnnI4mK0xZ2KmmREmFJ5jNQX0UjRzg7sI+nSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754792434; c=relaxed/simple;
	bh=6Pew7s0WnTitAKxA8XpQ2w+u6BlQ+0z6G46rhCW4oYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqpB4ihomEtdBuLcLQarpOnnBiEBs82toiEZD2C9mlcziCUA2gPDxzrWUCU+xYm45Xk92e1MIbYP19Efc9k3CVLWINQDFqIQh0tG8vO02+nwx4AQpBXy6XJ2Wt/ZDeZ7nLKpZJNLTITDaYuLOu3NI2gobm7X07qZT31MOz2OQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OllaE3yr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754792432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnRMiAU3tPcWF7dW1OEzm3VNFxTkrF27m8b5qJprNOA=;
	b=OllaE3yr/7bbqMoXsTg6DK2Yr9UCrAW0Ci6t+J4E86YdMJZVSiJSGjzUWvv02Xm+JqfNGZ
	omz90quWm8LLitqI8J2xR2uRsUUFNynqxTkvDLZ1Bxy1v7BdwWJpWfdsGdsml2Fl31J6PP
	SEzLrKBv5AIyX+UHmcfqZsgm2go6pgY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-_Wum_dUKN7meicn7rY64dg-1; Sat,
 09 Aug 2025 22:20:28 -0400
X-MC-Unique: _Wum_dUKN7meicn7rY64dg-1
X-Mimecast-MFC-AGG-ID: _Wum_dUKN7meicn7rY64dg_1754792427
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47F9B19560AA;
	Sun, 10 Aug 2025 02:20:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FC751955F16;
	Sun, 10 Aug 2025 02:20:22 +0000 (UTC)
Date: Sun, 10 Aug 2025 10:20:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: check for unprivileged daemon on each I/O fetch
Message-ID: <aJgB4q0qJ5wFf_Fh@fedora>
References: <20250808155216.296170-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155216.296170-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Aug 08, 2025 at 09:52:15AM -0600, Caleb Sander Mateos wrote:
> Commit ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue
> daemon") allowed each ublk I/O to have an independent daemon task.
> However, nr_privileged_daemon is only computed based on whether the last
> I/O fetched in each ublk queue has an unprivileged daemon task.
> Fix this by checking whether every fetched I/O's daemon is privileged.
> Change nr_privileged_daemon from a count of queues to a boolean
> indicating whether any I/Os have an unprivileged daemon.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


