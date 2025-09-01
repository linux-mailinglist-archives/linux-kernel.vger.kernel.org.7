Return-Path: <linux-kernel+bounces-794316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A222B3DFEC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E596C7AFD31
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4B530E824;
	Mon,  1 Sep 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbU3qXOj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F91AB6F1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721819; cv=none; b=nOUiBoNqsfWvGwJTVumybfzBfH9arMpkCHVcBYI7HuoK2DSHbU1TJz9S/uRQ8HyP+cG38CmR6b8ITtlgUu1xFcVZgzg1zzLgb4R7xa6T5moNY9wZdu/b36n4nGCPvhdZH56VHhdSZtIVZ/hl3SkYyA8aX4W55Nw7utS9QOu6TCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721819; c=relaxed/simple;
	bh=B+1DlquKVk41/r6dL0vQTw41mvBrVwTTFhUlbS0w+mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpgK+Hyg7SEr8hQ28uRZfWkiNqHnZe7h3c7IQ4pF870PZWhNfgC2C/Fy+Z8k5g/o31RlK4oWyTV62aXhzxS7eNPgl/QsqPzJX04Ip/BmhSL2bGSAGefVEiRKntdmUOdWYLlMKXKheRPjiq6dPCepO4r34lLYMEgKj1PngQ/JHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbU3qXOj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+1DlquKVk41/r6dL0vQTw41mvBrVwTTFhUlbS0w+mE=;
	b=IbU3qXOjMNuQXg098SDhGf/d1Y1Di1LrrA+LKcJ85KobDKjLhTY9dMg+HT8keSmz3DR+y4
	SyFaiMoB5hFa/TgG+9+lrJS7tJZ/QMVvknrLNFFMW+tYtLJJ9jRTWsCn/7aHOepZssq179
	ZatZHWC0hh+Ft7g6R858539+xu1rMzQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-vz1nJLrVNeWLtfTda_JN2g-1; Mon,
 01 Sep 2025 06:16:53 -0400
X-MC-Unique: vz1nJLrVNeWLtfTda_JN2g-1
X-Mimecast-MFC-AGG-ID: vz1nJLrVNeWLtfTda_JN2g_1756721812
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96AA0180028D;
	Mon,  1 Sep 2025 10:16:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61B0530001A2;
	Mon,  1 Sep 2025 10:16:50 +0000 (UTC)
Date: Mon, 1 Sep 2025 18:16:41 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
Message-ID: <aLVyia16eyoYftAw@MiWiFi-R3L-srv>
References: <20250831121058.92971-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831121058.92971-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Uladzislau,

On 08/31/25 at 02:10pm, Uladzislau Rezki (Sony) wrote:
> kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
> and always allocate memory using the hardcoded GFP_KERNEL flag. This
> makes them inconsistent with vmalloc(), which was recently extended to
> support GFP_NOFS and GFP_NOIO allocations.

Is this patch on top of your patchset "[PATCH 0/8] __vmalloc() and no-block
support"? Or it is a replacement of "[PATCH 5/8] mm/kasan, mm/vmalloc: Respect
GFP flags in kasan_populate_vmalloc()" in the patchset?

I may not get their relationship clearly.

Thanks
Baoquan


