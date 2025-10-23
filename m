Return-Path: <linux-kernel+bounces-866717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2BAC0080B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A27734F8049
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8550030CD9F;
	Thu, 23 Oct 2025 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHHHxOTe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96530CD87
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215371; cv=none; b=ZAfVQi13KsxpYqIgKpzCsOkn5gAitCro0Ttzv27kUecyk5sqwvkUFlO/255WDMimd0P69IToMZ7EpXSWooxpkkIuqwUU60WCf+j/GKfQEdcFm7Gr0E9v3Qdbam4S5L3JR9c61eBfLf9QCcjIKd7Mr8/dFSWCFgkMgj/nLIjulLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215371; c=relaxed/simple;
	bh=TviFKF3zoXHvhdB/N/MNX1rJQiJXg6rVqhmEanhYx90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlnDiERYHnr1i2vACwt1wFiGAV/rY3MHKxmX7BZYUr/U95cqhZ2mvhG87qU9DG/P+GQ1bLqOO8BBlLQmqnwo+HAkmJ6q+zYJ8HtXklymRCwYgznYT0EniN8bPYBsJzwiWq4WOrwMsmGmRJb1eWY0GXsD9tHqyQV8X3gWPDCDHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHHHxOTe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761215369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TviFKF3zoXHvhdB/N/MNX1rJQiJXg6rVqhmEanhYx90=;
	b=WHHHxOTeZttDoGg5mUK6bP2MnN8fBJqQYRiQ0/3B9VCBoA6FCJuQKN+76/e4r74036b1RG
	QgV3X19uDAgagjMOmJB7JZ7VCBcqNg4Lmy+RDC8G3jed4IA1Ckg/esbb/5kVUlwdJit0wu
	wxl3MEdrJaglF9ekEeHITUuXDWV8ZoM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-6cRBT6CTOm24cdSWnfFHHg-1; Thu,
 23 Oct 2025 06:29:23 -0400
X-MC-Unique: 6cRBT6CTOm24cdSWnfFHHg-1
X-Mimecast-MFC-AGG-ID: 6cRBT6CTOm24cdSWnfFHHg_1761215362
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 683AC1800592;
	Thu, 23 Oct 2025 10:29:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 410A919540E2;
	Thu, 23 Oct 2025 10:29:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Oct 2025 12:28:03 +0200 (CEST)
Date: Thu, 23 Oct 2025 12:28:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251023102800.GB26461@redhat.com>
References: <20251022154115.GA22400@redhat.com>
 <aPneEnDQmHhpvRkG@pathway.suse.cz>
 <87a51ic7up.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a51ic7up.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/23, John Ogness wrote:
>
> I prefer avoiding CONFIG_PROVE_RAW_LOCK_NESTING since it is not necessary.

OK,

> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks! I'll send v2 in a minute with yours and Petr's acks preserved.

> I would like to see an official ACK from Sebastian as well.

Yes, me too, even if we already dicsussed this in another thread
https://lore.kernel.org/all/20250811105948.OafBprND@linutronix.de/

Oleg.


