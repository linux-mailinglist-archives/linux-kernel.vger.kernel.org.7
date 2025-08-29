Return-Path: <linux-kernel+bounces-792279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16459B3C239
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA99BA006CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80D341ADC;
	Fri, 29 Aug 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/pjhV6e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39821019E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490752; cv=none; b=H4NeKKOCtKgUVLrYrhI0xENykEra7vngLNRaoSntpMxkpOHPlwAxJadiZW9zIbFa/GVbXQdBQnQwDNVYz6YntX/AliGeM/kz0ZHteKwT9KgJA9OTGy/z8Q2he0rM39shkLkcCuPAyZYOLQ2LCdfME2T/e8gdl4iBSERxIgzDETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490752; c=relaxed/simple;
	bh=u1e2LALm18nas0vKQ6sCc9bRuEFbXQoI3oI+CSc9GUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA8VBeCJnhlFCVG/a9LUxmFZl+ezFq/1dwh8vibVQG1zKpdomtXkvNRGCZITdOCQZ486mxOFNyg23kajZZJDbeLWIjL5VeFY7S5L3z0Amh6HdEIADoJGNcqoEETBCU/O5xvKB2pG0YqTlYNWAg6/uZmvGO63epBRpJVbMJARjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/pjhV6e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756490750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/50SATT95Ds6BvNgK0T9SUh3zNyDh5/nmD6Y6LNzh8=;
	b=h/pjhV6eUydcyN2ZQEuQrA3St8Azz46Du1NGY2HfKKqoWQeYDu2lvHDgNKIgnYVHhn3EC3
	+uQQXko/gezz2L5gzQ37eAu8YvsKJBVrKNbr2UbXdTaa/wXUW6rC7z+Sl2Pgr/r2wFxSUF
	cx/6VFuuQgfkMBb8jSNyXaYD0Uwsp0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-aPTk7qcCP-Gtn3kBaEHZ_Q-1; Fri,
 29 Aug 2025 14:05:46 -0400
X-MC-Unique: aPTk7qcCP-Gtn3kBaEHZ_Q-1
X-Mimecast-MFC-AGG-ID: aPTk7qcCP-Gtn3kBaEHZ_Q_1756490745
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87BDC180035B;
	Fri, 29 Aug 2025 18:05:45 +0000 (UTC)
Received: from redhat.com (unknown [10.22.89.196])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 939801800280;
	Fri, 29 Aug 2025 18:05:44 +0000 (UTC)
Date: Fri, 29 Aug 2025 13:05:42 -0500
From: David Teigland <teigland@redhat.com>
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: Alexander Aring <aahringo@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix(dlm): handle unlock/cancel during deferred lock
 messages
Message-ID: <aLHr5VAuXQZE0bBd@redhat.com>
References: <20250829110749.500571-1-226562783+SigAttilio@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829110749.500571-1-226562783+SigAttilio@users.noreply.github.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Aug 29, 2025 at 01:07:49PM +0200, Alessio Attilio wrote:
> ---
>  fs/dlm/lock.c | 8067 ++++++++++++++++++++++++-------------------------
>  1 file changed, 3944 insertions(+), 4123 deletions(-)

Thanks for working on this, lock cancel has always been sketchy, and I'd
be happy to see that improved.  An 8000 line patch is going to be
difficult to review, though!  It looks like diff may just be moving a lot
of lines around, and perhaps splitting this up could avoid some of that?
Also, I'm not seeing which upstream commit the patch is against.

Thanks,
Dave



