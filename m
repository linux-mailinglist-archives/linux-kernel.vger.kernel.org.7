Return-Path: <linux-kernel+bounces-771104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87608B282E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7049EAE2792
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE02C15B9;
	Fri, 15 Aug 2025 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haAZ/8Fr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A52C0F9F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271578; cv=none; b=lgr4PQOy6yclu1jV/N4lFx3ZpYBm4t+GSIOltkEqEsgSLRc80tFFbynxeRmeGwuDX4p6Q1jNv8pd+JsiYbgPgOEPY4ZjpiGA5eHz9HG7DDc3NjJz8kXKmmYYS7yTHnoOClnKNWxA7dumxm1oFpNtNHvBskiZ2kA6k+8KJEd727A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271578; c=relaxed/simple;
	bh=1qJWDpzdCyAu0Pdvv7uxCLOhIB0a2UclUOXa4ckCQGw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dMsCfJUDHtFxy3wb0TNSSRabqJfb1nJRgCh/pRi2bhEsfpByZWkpthe+yho2PLfCZ31G/upG/oF5dS831S2HLAH9PMo3n/o/QmMj+ZabXhglDSNa448qfbDgFMh+DkUenA6MuItYsmbK17b1tiilrVOlBHHH0nBgMdA2KddQRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haAZ/8Fr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755271575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqjjyKEuzrRtWKhNC1YdtIomtSy7pyEQe4b8oSCwkZ0=;
	b=haAZ/8Frw9czYumgL9VblpMA4hLNYvAxHV3OUwztRxdXU+lfsUkFetylBP84/NiczNB2Hd
	xAz4+K8dEkvmTJWgpEBYaFybxlY7XwpEJY/INfwqy0rsfvtkSFJeBThvKB6i8bZhBBl1dQ
	mKZHkEaSFlfndxdEQDC4GaucqlT+fHE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-eXeddd2jPRq_627cBWF9gg-1; Fri,
 15 Aug 2025 11:26:12 -0400
X-MC-Unique: eXeddd2jPRq_627cBWF9gg-1
X-Mimecast-MFC-AGG-ID: eXeddd2jPRq_627cBWF9gg_1755271570
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC2A6180035C;
	Fri, 15 Aug 2025 15:26:10 +0000 (UTC)
Received: from [10.22.80.50] (unknown [10.22.80.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5ED830001A6;
	Fri, 15 Aug 2025 15:26:07 +0000 (UTC)
Date: Fri, 15 Aug 2025 17:26:03 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux Documentation <linux-doc@vger.kernel.org>, 
    Linux Device Mapper <dm-devel@lists.linux.dev>, 
    Matthew Sakai <msakai@redhat.com>, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    "J. corwin Coburn" <corwin@hurlbutnet.net>
Subject: Re: [PATCH] dm-vdo: Promote dm-vdo title to title heading
In-Reply-To: <20250815080313.25132-1-bagasdotme@gmail.com>
Message-ID: <44c7bffa-63c4-5aeb-0b58-f2b16da34331@redhat.com>
References: <20250815080313.25132-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Applied, thanks.

Mikulas



On Fri, 15 Aug 2025, Bagas Sanjaya wrote:

> dm-vdo docs currently has no explicit title heading but instead there
> are multiple section headings as top-level heading. As such, these
> sections are rendered as titles and inflates number of entries in the
> toctree index.
> 
> Promote the first section heading ("dm-vdo") to title heading.
> 
> Fixes: 04bf7ac646ab ("dm: add documentation for dm-vdo target")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/admin-guide/device-mapper/vdo.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/device-mapper/vdo.rst b/Documentation/admin-guide/device-mapper/vdo.rst
> index a14e6d3e787c91..8a67b320a97b58 100644
> --- a/Documentation/admin-guide/device-mapper/vdo.rst
> +++ b/Documentation/admin-guide/device-mapper/vdo.rst
> @@ -1,5 +1,6 @@
>  .. SPDX-License-Identifier: GPL-2.0-only
>  
> +======
>  dm-vdo
>  ======
>  
> -- 
> An old man doll... just what I always wanted! - Clara
> 


