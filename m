Return-Path: <linux-kernel+bounces-867312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C257C02395
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 642484E3110
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D5D2264D9;
	Thu, 23 Oct 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVOF+WDj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B09421ABB1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234505; cv=none; b=dYl14qJwUrOkL4239goqKaPQ86HTG8gAgJRqh4Fj7iRfIKInoo3vIig4M7D0nyUmxPx0q6WCA+fYfOnUnKzBoHkOgurEYjdzMPmAs0ByTc7uC633VMWgFtR/KSAP245oTH1WzAkWlMVzmH3tWNZryt/P+ivVVZpl4oWprr1oV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234505; c=relaxed/simple;
	bh=DtBrMovIMi8nkW6mvl87BBEZBuBwT/3dCBDkaoO3tw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6jrsw6AKPMQsKm4TuA+v2x31I/mQfVBBPYD846sJIfCffZQnSpH748op0FZnaG4Ar/QktfycLC8R9ntNk7GmccjYgA8aE8leMTEMjQ2V/Gd9rg3fBae+dfAxx1YSKuEKiGdD0Vojgvmurdoh9qxinP+m+36GQkw6dEEo2nSyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVOF+WDj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761234503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DtBrMovIMi8nkW6mvl87BBEZBuBwT/3dCBDkaoO3tw0=;
	b=dVOF+WDjh7RnRcuP8eobYmNUED2KcbNDr5CEcCrg7jh2Q9YqhRpZ/mkavzxcLKNO33/0WB
	uc3XD9UztPDG9GpGM74RbKyw0SzDYukd8mb7q6Sa4FOZnT1SBAeX1G9qS5y5ngieQ/5xlz
	gHI9l3ZVcDQgyowj6QmLs4itPbOxzp0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-MPGkyEJZMMGRzlK5bDEXgg-1; Thu,
 23 Oct 2025 11:48:21 -0400
X-MC-Unique: MPGkyEJZMMGRzlK5bDEXgg-1
X-Mimecast-MFC-AGG-ID: MPGkyEJZMMGRzlK5bDEXgg_1761234500
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 072EF18001DD;
	Thu, 23 Oct 2025 15:48:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2831C180057C;
	Thu, 23 Oct 2025 15:48:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Oct 2025 17:47:01 +0200 (CEST)
Date: Thu, 23 Oct 2025 17:46:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251023154657.GD26461@redhat.com>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <87wm4lbqt2.fsf@jogness.linutronix.de>
 <20251023151112.goqBFQcM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023151112.goqBFQcM@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Again, quite possibly I am wrong. please see my reply in another thread,
https://lore.kernel.org/all/20251023152942.GC26461@redhat.com/

On 10/23, Sebastian Andrzej Siewior wrote:
>
> This does not matter. My point is that there no need for this ifdefery.

I disagree. Rightly or not. To me this ifdefery in printk.c make the intent
more clear.

I am still thinking about the possible cleanup of the current usage of
DEFINE_WAIT_OVERRIDE_MAP(), but I think that, whatever we do, this cleanup
should take CONFIG_RT into account.

Oleg.


