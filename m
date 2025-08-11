Return-Path: <linux-kernel+bounces-762550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA412B20859
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D430164DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0280D2D3A6C;
	Mon, 11 Aug 2025 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="mLsYxGCg"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DA23C515
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914026; cv=none; b=ogZ/m7uY7jvR5pzpeBgamHFZnRjIUGCP3IFlyuz3nZJuq7f/G4nylZlkTg6bRn/WZrW8oJpQgcdGjojxDpk2FoZQkyB09PG90QqhjegB/e20YSerMk1tOIRe+amHK591pcuNXBe0qcWrVZIdB7mWAWhL+lOAyYc2x7L8jFMn4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914026; c=relaxed/simple;
	bh=eMy45TQUkqvd/t/01pizWUxZhtrUYXIVhVtWJCeDHbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSAIoi7P4CZu2+ZFfd4FYquBtEUCu7Cav0eyRXeWD8zsVMMMhnx4NiA5ZcFofReDGqN9CjXZpaVP4bij0L2OXzb9+da7pOQacQkX+6MejhS+o4FxfXXQRwd0izwLIfK9nIXqpONnDCnrsU68PGzPvjZTnUli+Pyw+lTH1ZB0BQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=mLsYxGCg; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 26AB7108024C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:36:57 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 26AB7108024C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754914017; bh=eMy45TQUkqvd/t/01pizWUxZhtrUYXIVhVtWJCeDHbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLsYxGCgkGdtYm+sFWiGuSaLnMrwronxeVCCIqJeRBJyc3TRnizUqpX4sJBEZuN7N
	 /3CYlG8RA74V8GZlU7sY5d5yK0sEMwv6S1qTbth82+hDRk1totM0MlH3KHG6HBirN8
	 XUHCt51E79dbaZ+7XnqyFbygHtEktZ5geDdo7GS8=
Received: (qmail 15728 invoked by uid 510); 11 Aug 2025 17:36:57 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.482603 secs; 11 Aug 2025 17:36:57 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 11 Aug 2025 17:36:52 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 2B8CF3414EA;
	Mon, 11 Aug 2025 17:36:52 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 05D3B1E8135B;
	Mon, 11 Aug 2025 17:36:52 +0530 (IST)
Date: Mon, 11 Aug 2025 17:36:47 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] include/linux/rv.h: remove redundant include file
Message-ID: <aJnc17BSsDOnfNwg@bhairav-test.ee.iitb.ac.in>
References: <aJbsYkON4V4iFPFG@bhairav-test.ee.iitb.ac.in>
 <30f0e085-b636-45be-960b-68bf6a136f59@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f0e085-b636-45be-960b-68bf6a136f59@redhat.com>

On Mon, Aug 11, 2025 at 10:49:00AM +0000, Gabriele Monaco wrote:
> 2025-08-09T06:36:58Z Akhilesh Patil <akhilesh@ee.iitb.ac.in>:
> 
> > Remove redundant include <linux/types.h> to clean up the code.
> > Fix this redundancy introduced by commit [1].
> >
> > Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor") [1]
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202507312017.oyD08TL5-lkp@intel.com/
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > ---
> 
> Thanks for the patch!
> I'm really being picky here, but, since you're touching this, isn't it cleaner to keep all includes inside ifdef CONFIG_RV ?

Agree.

> When CONFIG_RV is not enabled, the header only defines constants so it doesn't need other includes.
> 
> This would mean you could remove the other #include <linux/types.h>, instead, and move the #include <linux/list.h> down.
> 
> I think you can keep the Fixes: tag and make clear the reason for cleanup in the commit message.
> 
> Thanks,
> Gabriele
> 

Thanks for the review.
I have shared v2 addressing these comments and additional cleanup.

Regards,
Akhilesh

> > include/linux/rv.h | 1 -
> > 1 file changed, 1 deletion(-)
> >
> > diff --git a/include/linux/rv.h b/include/linux/rv.h
> > index 14410a42faef..8b968b8ed77b 100644
> > --- a/include/linux/rv.h
> > +++ b/include/linux/rv.h
> > @@ -15,7 +15,6 @@
> >
> > #ifdef CONFIG_RV
> > #include <linux/bitops.h>
> > -#include <linux/types.h>
> > #include <linux/array_size.h>
> >
> > /*
> > --
> > 2.34.1
> 

