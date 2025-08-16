Return-Path: <linux-kernel+bounces-771710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A35B28A93
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214581C272D2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17B149C7B;
	Sat, 16 Aug 2025 04:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="GtPBXUOT"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810A79EA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755319671; cv=none; b=W2EDoDwWjWt/sJhyf87IQiAI8SiQjiIh4ssXM1GvEZA+7PolmJMVd7hZJkpTP5JGjDkJe3Da6YMfj0HUGuO6kt7tHXN3HYJqREnqCPQ/xrLigCDLrUVcdNGAepscBixYaZDt0Zatt7tC0KbwbByqZE5dgNoKYQsY5zGR1Yj5vAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755319671; c=relaxed/simple;
	bh=JLSoB8jwb0pqKgE8UWtDvQKlwRuPLGfY8+Zl/anW9Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj6oEyW0OEZiFPvDFrsBPWMhv1jY5AJMPjShxxkFNPTn/+zmQMbfrDSgdk9De+ASXZyFVoPjd2RAsF5UoJpnorNwSDJtxBJkSP6OcoPZbNA0WeDVP3rmrU1hFT3IOkgRcd6xVgebke6ftD23NUME+2yjbGxEyf3VWP9bEts3HDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=GtPBXUOT; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 8E7A5104D017
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:17:44 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 8E7A5104D017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755319664; bh=JLSoB8jwb0pqKgE8UWtDvQKlwRuPLGfY8+Zl/anW9Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtPBXUOTLuWUO6//PVhm2M3CxTFQyr0LAvwpwzPXvhGZyWlNp/vJvdt9W0ws8a+JN
	 M6OWAmHG21se304DGR1+iPWUMKvUyUFx6v502QsEmHeNo2gd04CzjANEdaIgANK971
	 jRDfJY7M0TPgZXB6XJDLqsC1aJYR7X5TO4Y2Y/gU=
Received: (qmail 19036 invoked by uid 510); 16 Aug 2025 10:17:44 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.261156 secs; 16 Aug 2025 10:17:44 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 16 Aug 2025 10:17:42 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id A0BF136003F;
	Sat, 16 Aug 2025 10:17:41 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id A46741E8134B;
	Sat, 16 Aug 2025 10:17:40 +0530 (IST)
Date: Sat, 16 Aug 2025 10:17:39 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Alison Schofield <alison.schofield@intel.com>
Cc: saeedm@nvidia.com, itayavr@nvidia.com, dave.jiang@intel.com,
	jgg@ziepe.ca, Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
Message-ID: <aKANa/mtzIYaCBUb@bhairav-test.ee.iitb.ac.in>
References: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
 <aJ-DebbVy8-9cEt0@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ-DebbVy8-9cEt0@aschofie-mobl2.lan>

On Fri, Aug 15, 2025 at 11:59:05AM -0700, Alison Schofield wrote:
> On Sun, Aug 10, 2025 at 11:47:42PM +0530, Akhilesh Patil wrote:
> > Use kvfree() to free memory allocated by kvzalloc() instead of kfree().
> > Avoid potential memory management issue by matching alloc/free routines.
> > 
> > Fixes: 52929c2142041 ("fwctl/mlx5: Support for communicating with mlx5 fw")
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> 
> Hi Akhilesh,
> 
> How about making the commit message more specific about why this
> patch is critical even when no immediate symptoms are observed. Based
> on the current description, a developer might think "this works fine
> in my testing, so it's not urgent."
> 
> This type bug is particularly dangerous because it can pass code review
> and testing, then cause mysterious production failures that are extremely
> difficult to trace back to the root cause.

Agree.
> 
> If this sounds like I'm going overboard on an obvious fix, I am doing
> so intentionally. I am encouraging you, as a new contributor, to show
> that you looked into how kvzalloc() works. I believe it can use either
> kmalloc() or vmalloc(). You don't need to be a memory alloc expert to
> submit this fix, but demonstrate that you looked beyond a report in a
> static analysis tool. Also, that's where the interesting learnings
> appear.
> 
> Similar to what Markus mentioned, a simple message stating how this
> was found is useful too.
> 
> --Alison

Thanks Alison for valuable insights and feedback :) 
I will add "How this issue got dicovered" and "Why it is important to
fix" in the commit message and share v2.

Regards,
Akhilesh

> 
> 
> > ---
> >  drivers/fwctl/mlx5/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
> > index f93aa0cecdb9..4b379f695eb7 100644
> > --- a/drivers/fwctl/mlx5/main.c
> > +++ b/drivers/fwctl/mlx5/main.c
> > @@ -345,7 +345,7 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> >  	 */
> >  	if (ret && ret != -EREMOTEIO) {
> >  		if (rpc_out != rpc_in)
> > -			kfree(rpc_out);
> > +			kvfree(rpc_out);
> >  		return ERR_PTR(ret);
> >  	}
> >  	return rpc_out;
> > -- 
> > 2.34.1
> > 

