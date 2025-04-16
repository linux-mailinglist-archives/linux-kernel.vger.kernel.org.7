Return-Path: <linux-kernel+bounces-602852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8AEA88025
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 14:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB05188C6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671EE29CB5C;
	Mon, 14 Apr 2025 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJpqrkAc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233A290BCB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632818; cv=none; b=mpjzv3wolQpSsYwqg2sU8r17Ow4tqRiU05zMJ/Liz4cbYo7Hyq9+0QJ7e8pZF8BFrnjoVWimpeMzzH6TL/GVueG2pxG9PXQUSDo0CdCifj3douFSf9ZCZz8KnMSbnpXo8tWZvekyNPCzNylbFlprynczkKWyws8lnOJIzwfTSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632818; c=relaxed/simple;
	bh=tek+9yIhv/inJSoNG6Oa9yTvOsy+wDQ1yZOAEV9xRTQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EHML3XfAn3pcPa627AtAc4dYK5raJEqwAxJiy8MxBnlMQorLi0sB/k5sDjo5LbHiXW+V5dSC8gxtFTHFiB0Lolu9KMRk2fuzQwKogLyKQkGeDmOb4gzAXvf68qJLu1Y9zNkX8JDCo0MetrsktS8ngDyL7jBZJfmMaoXBncUIkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJpqrkAc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744632816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGXOIiFLOKlRL+utvX2910PESSbxXzHZjxCc4Cz0fY4=;
	b=dJpqrkAcq/48ULvuqgiO+8TQ0/Oe+XzsP/iU/4N7oHbByEYN0Xn2RhhEAXODuYx+l/nzNP
	jRjf5jzv/8/6Fc0tk6k1G/RmryoJ2vf1bsuZBTHWAFYUpDCGnL9nLt6XvdYQjlKFMFpMBg
	UXC3UT9aCbncmAkrnnseDf+j9m2/GKo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-W9yS-uk8Or22d5cyR0Mopw-1; Mon,
 14 Apr 2025 08:13:30 -0400
X-MC-Unique: W9yS-uk8Or22d5cyR0Mopw-1
X-Mimecast-MFC-AGG-ID: W9yS-uk8Or22d5cyR0Mopw_1744632808
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 977881801A1A;
	Mon, 14 Apr 2025 12:13:28 +0000 (UTC)
Received: from [10.22.80.44] (unknown [10.22.80.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 539F119560AD;
	Mon, 14 Apr 2025 12:13:24 +0000 (UTC)
Date: Mon, 14 Apr 2025 14:13:18 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] dm table: Fix W=1 build warning when
 mempool_needs_integrity is unused
In-Reply-To: <Z_zd1NCtn_QxaCzC@smile.fi.intel.com>
Message-ID: <a0b1fcbf-9cda-9da2-ecbe-ac5cbc75b775@redhat.com>
References: <20250407072126.3879086-1-andriy.shevchenko@linux.intel.com> <Z_zdwSCfaYDotOI2@smile.fi.intel.com> <Z_zd1NCtn_QxaCzC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Mon, 14 Apr 2025, Andy Shevchenko wrote:

> On Mon, Apr 14, 2025 at 01:04:49PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 07, 2025 at 10:21:26AM +0300, Andy Shevchenko wrote:
> > > The mempool_needs_integrity is unused. This, in particular, prevents
> > > kernel builds with Clang, `make W=1` and CONFIG_WERROR=y:
> > > 
> > > drivers/md/dm-table.c:1052:7: error: variable 'mempool_needs_integrity' set but not used [-Werror,-Wunused-but-set-variable]
> > >  1052 |         bool mempool_needs_integrity = t->integrity_supported;
> > >       |              ^
> > > 
> > > Fix this by removing the leftover.
> > 
> > This issue is still present in v6.15-rc1.
> 
> I meant v6.15-rc2, of course.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

I will send it to Linus (maybe with other changes) before 6.15 comes out.

Mikulas


