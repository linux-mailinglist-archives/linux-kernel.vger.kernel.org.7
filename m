Return-Path: <linux-kernel+bounces-794943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994BB3EB13
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586EE486953
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438F2D594C;
	Mon,  1 Sep 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRPa2JLx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A12D593E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740808; cv=none; b=TvqXlpYrN9EtYk/n+Ag2GcbNn6cWMvbbF+Wv61ZJ+uGBxuHWptjnolB9bcspTHHTAP18HRJd86lXdmuL47wA9LKWyIsLx4rVK/7v0nSWh7GeCamQn5ZEhXyiRnl8sDSN0+nDH3O9Ou0QDOmoYmxmkAkIhYgQSg5SgGScyXmMYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740808; c=relaxed/simple;
	bh=HwfE37ILkpJLGlX5x9Akah5htBxTQ4MLFW4gwTbjKCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga+QKUEkd6KafBCNMPUO/Re7TemL60/kyY4HbijYGJaptTZGtiQnGo84ZP9qCgZ3e8bMKPKsj6iebNJpwCcy2JmpQVLN45HEOg1k/hDz/uy4Xr+q2MtyEkI9fhBnVxqFrtJXBYK/J0IokV2iW6bGvzybtC5nhbjTc8AXroJhYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRPa2JLx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756740806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TrgTQsbjRK4plaVS2IeLRNEJop7nYsHFeJcp7M6qYU0=;
	b=HRPa2JLxbLXKMYEvbaGfQZopBGQr1IpQu3NXf313qBWEeAqElX9ha8WM11/5JD1mwxXAu2
	MRXbN/ryby/DxsJJnaN/ZGW+6QTO0GzwwxAbSMiN0IE3tQqIBIv/mf8t4XVZNbQlGOpPeF
	y/gtu6ktQYYZuzooCbaO3Vu9AqCYvyI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-at_GCWa8O_q74nhYssOPFg-1; Mon,
 01 Sep 2025 11:33:23 -0400
X-MC-Unique: at_GCWa8O_q74nhYssOPFg-1
X-Mimecast-MFC-AGG-ID: at_GCWa8O_q74nhYssOPFg_1756740801
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B774195609F;
	Mon,  1 Sep 2025 15:33:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CE9D180044F;
	Mon,  1 Sep 2025 15:33:20 +0000 (UTC)
Date: Mon, 1 Sep 2025 23:33:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
Message-ID: <aLW8u1Lvlcp5Y3tc@MiWiFi-R3L-srv>
References: <20250831121058.92971-1-urezki@gmail.com>
 <aLVyia16eyoYftAw@MiWiFi-R3L-srv>
 <aLV0JrSPfitu1jFV@pc638.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLV0JrSPfitu1jFV@pc638.lan>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/01/25 at 12:23pm, Uladzislau Rezki wrote:
> On Mon, Sep 01, 2025 at 06:16:41PM +0800, Baoquan He wrote:
> > Hi Uladzislau,
> > 
> > On 08/31/25 at 02:10pm, Uladzislau Rezki (Sony) wrote:
> > > kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
> > > and always allocate memory using the hardcoded GFP_KERNEL flag. This
> > > makes them inconsistent with vmalloc(), which was recently extended to
> > > support GFP_NOFS and GFP_NOIO allocations.
> > 
> > Is this patch on top of your patchset "[PATCH 0/8] __vmalloc() and no-block
> > support"? Or it is a replacement of "[PATCH 5/8] mm/kasan, mm/vmalloc: Respect
> > GFP flags in kasan_populate_vmalloc()" in the patchset?
> > 
> > I may not get their relationship clearly.
> > 
> It is out of series which i posted to support no-block for vmalloc. 
> I will base a new version based on this patch because it is rather
> a fix.
> 
> It is to address and complete GFP_NOFS/GFP_NOIO flags for vmalloc.

I got it now, thanks a lot.


