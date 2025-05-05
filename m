Return-Path: <linux-kernel+bounces-632386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641D2AA96A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 16:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A1817B337
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088B25DD13;
	Mon,  5 May 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvoQfgjw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5C25DCF9
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456717; cv=none; b=tFbcjTgoTBmnEJO3Ce/OYJUbZcdjNhA+wCS/44VXf0wRJSCaw1UGeVKbaq6No3kfYHvhPYDQ8uH2mZqiwlGA+QCs6s5sOEQgnOlVcbJXq2iVbcN/ZILaeeIpjD9Xhp3zMW1klZgObaEZRp822pR1wpFgRHL8zlvqN9SOhF6YqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456717; c=relaxed/simple;
	bh=VZJhEgcNelTUBCn9Nx5qhUAurYvBwTIlj74F1eYonQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnBjj3IUjcQvWLuKbIFqEYbC85MpnpKCV/+ExztxgmCKr8CQlggWMsXxrJZI6Puvt3AHdiGYFAVWHOCW37qcyRwHZa+n1ZiSFtO7lHwAysv2aIE91+FMT5ugJsN0LQxsCwobCN+rUUumIHDhyw7dgC0Ix7fzcdGxum4wPkY0QMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvoQfgjw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746456714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMHmNv9bc+algQIruScrBYJ9y9sLQ/7TPs2SBjXhzwE=;
	b=EvoQfgjwBG9vR89Ak/YkP5Ga2NBH5xdrmF12TzQFp+lDjarV+njinDcUaeBoVXxemNHOQG
	cN5BINiotTJH+kLKAckV0uvDBOPs6kzPuLOJJoeS1mZ3XAwZAmyJhSsYcTDNHyvWU1uQ7E
	XGOXzMFW98ZZOgGt0rThqN40KbRXNiE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-RBJd_cO0PEaaIu3OaQfnkg-1; Mon,
 05 May 2025 10:51:50 -0400
X-MC-Unique: RBJd_cO0PEaaIu3OaQfnkg-1
X-Mimecast-MFC-AGG-ID: RBJd_cO0PEaaIu3OaQfnkg_1746456708
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EBE01800877;
	Mon,  5 May 2025 14:51:48 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6CF1195608D;
	Mon,  5 May 2025 14:51:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 545EpjmO2777670
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 5 May 2025 10:51:46 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 545Epj3s2777669;
	Mon, 5 May 2025 10:51:45 -0400
Date: Mon, 5 May 2025 10:51:45 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Satya Tangirala <satyat@google.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dm: add missing unlock on in dm_keyslot_evict()
Message-ID: <aBjQgfM-ovtt8Lua@redhat.com>
References: <aBHZ4puON8GNK0vw@stanley.mountain>
 <20250430165037.GA1958@sol.localdomain>
 <aBJgeV7pZ7Q47OCb@stanley.mountain>
 <cad25513-31c4-5895-cfc0-b9c7dce4ce08@redhat.com>
 <fbc26327-d14d-f049-d62e-babaab0e9750@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc26327-d14d-f049-d62e-babaab0e9750@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, May 04, 2025 at 01:30:42PM +0200, Mikulas Patocka wrote:
> 
> 
> On Wed, 30 Apr 2025, Mikulas Patocka wrote:
> 
> > Ben already tried to fix it in dm_blk_report_zones (see the linux-dm git, 
> > for-next branch) - but his fix is incorrect because the "if" condition for 
> > dm_get_live_table and dm_put_live_table differs. I'll update his patch to 
> > fix this mismatch.
> > 
> > Mikulas
> 
> I fixed it in the Ben's patch "dm: fix dm_blk_report_zones". Ben, please 
> review it - it's the patch 37f53a2c60d03743e0eacf7a0c01c279776fef4e in the 
> linux-dm repository, for-next branch.

Your changes look good. Thanks for catching that.
-Ben

> 
> Mikulas


