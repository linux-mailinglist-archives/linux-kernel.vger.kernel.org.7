Return-Path: <linux-kernel+bounces-876901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FC8C1CABE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 660E134CC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D2430B528;
	Wed, 29 Oct 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3ZNnEW/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF743246BB9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761194; cv=none; b=bNGZONuMud4R3b8p70fcaXNQ55g8L/ekSUa3hBUNvDOkfnup2ZeubyQnh+xOLH/ZtlC6y/up4kU8GM3B2+3Vuxe+P8qdE1YIwTTzdJatF65b1bX5eLp3n9F+foOMiEg7Lb0e3mxBFAKD9yXYWJiDY48KCnnjZR68dIjcXQgMOuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761194; c=relaxed/simple;
	bh=9b8fa0Z4aKyzjlBhpiWw7f1pqpaADXZXoSC2CTbbwjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeSz4K3WwXmvwHWxbMO2jFO2d5e5IVe3fj0neCcUII1pXuq3OJbFzjGdP1VZ667NXo5KG6vkgodm9iamiyN15ODoRQJaSiefRGUN9NippEhJ6bbwlWSF0sa5Sz5o3e75nTzOhRiZIAKTFqm+RaaqJo7oPYNJPjd0WWFneEw14C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3ZNnEW/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761761192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZfLqAcbRHxrnYziCYWRvgm+ru2d0JIR1i0V2VmmB+Y=;
	b=J3ZNnEW/MOuFjXjBTC1G1JUFxlMdGjdFl4OR9fUmjAfz8KkTOQqC5z9pIlKP76+XaVS+vL
	s35Dey56eFUaRtVh0YBvJpOPma6xvkvavkDkS+74f09oXLVkFgz4XaYoKzY43JYh/HjWfx
	YsFXLJHaLOshzI6BBtTvHAkGA/9DH8E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-WIyi2CbMOkqzfQvzj0zY-Q-1; Wed,
 29 Oct 2025 14:06:28 -0400
X-MC-Unique: WIyi2CbMOkqzfQvzj0zY-Q-1
X-Mimecast-MFC-AGG-ID: WIyi2CbMOkqzfQvzj0zY-Q_1761761187
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E502180737E;
	Wed, 29 Oct 2025 18:06:27 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E4C330001A2;
	Wed, 29 Oct 2025 18:06:26 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id AA35940504A61; Wed, 29 Oct 2025 15:01:50 -0300 (-03)
Date: Wed, 29 Oct 2025 15:01:50 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/idle: disable tick in idle=poll idle entry
Message-ID: <aQJWjteaSaaC1dnU@tpad>
References: <aQJWWIDMMUxqDxnR@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJWWIDMMUxqDxnR@tpad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 29, 2025 at 03:00:56PM -0300, Marcelo Tosatti wrote:
> 
> Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
> ("tick/nohz: Conditionally restart tick on idle exit") allows
> a nohz_full CPU to enter idle and return from it with the 
> scheduler tick disabled (since the tick might be undesired noise).
> 
> The idle=poll case still unconditionally restarts the tick when entering
> idle.
> 
> To reduce the noise for that case as well, stop the tick when entering
> idle, for the idle=poll case.
> 
> Change tick_nohz_full_kick_cpu to set NEED_RESCHED bit, to handle the
> case where a new timer is added from an interrupt. This breaks out of
> cpu_idle_poll and rearms the timer if necessary.

Frederic,

As a reminder, this is the original patch and discussion:

https://patchew.org/linux/ZIEqlkIASx2F2DRF@tpad/



