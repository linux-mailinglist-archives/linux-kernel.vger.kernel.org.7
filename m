Return-Path: <linux-kernel+bounces-771709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D70FB28A91
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3804E10A8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788C41E25E8;
	Sat, 16 Aug 2025 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="jHTQ6IDA"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6B191
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755319420; cv=none; b=EdFkwdJSSDS9HiIEzeSOPrq69k0ISz+MkFwn8yVWICaEkXgfAu6Kjpp1KXSUiHdCo/xJiFxhr/LMwVBrqkRhUpkx328f/09dfYtt8xyzArxe7fizdYAceHGRAILpCNQ+erI00h8mip2BAnZjhS2PipVXzsdoR9LTTEJw5l5Ruu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755319420; c=relaxed/simple;
	bh=Pq4zY20r2hDlH7rMB0y0utkHPKa2ujCGHObqC8u8EA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRfwokJ1ksImv5xNeEaXM392LgYwhSmyUv+ZaXCyJ5nCJg4fZAbcrDI70udEz/FPTJRwPGfCyMRZJscVmwucOVE0dUb41UzsGsfNe8vdZzUQPLeN0V5e6Rb/Na3YbB/TR9HqP8rofEr+lZz3idvkOCWw20iauBsKavtCAyQbj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=jHTQ6IDA; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id E71E1104C1F9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:13:25 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in E71E1104C1F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755319405; bh=Pq4zY20r2hDlH7rMB0y0utkHPKa2ujCGHObqC8u8EA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHTQ6IDAB1V95xXlq/+fYEANhQrUE02i+RtBXYzp8ElEP/NO/+NCIOTNJDjG1fOBL
	 9irJFRQIjDnkGBm8Da72SY1+FTVU00tL9fR6mP3L74ps5X/iuemXcRAswgCDWojEWj
	 VQk5VESMBt1iCAuZKe4c5hiQBEW4TeeKf3xybLVo=
Received: (qmail 18167 invoked by uid 510); 16 Aug 2025 10:13:25 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.166873 secs; 16 Aug 2025 10:13:25 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 16 Aug 2025 10:13:23 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 2D8A336003F;
	Sat, 16 Aug 2025 10:13:23 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id EE6841E8134B;
	Sat, 16 Aug 2025 10:13:22 +0530 (IST)
Date: Sat, 16 Aug 2025 10:13:17 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: akhileshpatilvnit@gmail.com, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	Itay Avraham <itayavr@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
Message-ID: <aKAMZenB2iqSSfd3@bhairav-test.ee.iitb.ac.in>
References: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
 <35e23690-a907-4606-a484-e3e342a14e7c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e23690-a907-4606-a484-e3e342a14e7c@web.de>

On Fri, Aug 15, 2025 at 04:40:10PM +0200, Markus Elfring wrote:
> > Use kvfree() to free memory allocated by kvzalloc() instead of kfree().
> > Avoid potential memory management issue by matching alloc/free routines.
> 
> Will another bit of background information become helpful
> for an improved change description?
> 
> Test command example:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> /usr/bin/spatch -D report scripts/coccinelle/api/kfree_mismatch.cocci drivers/fwctl/mlx5/main.c

Sure, I will update the commit message to add this and push v2.
Thanks Markus for the suggestion. 

Regards,
Akhilesh

> …
> 
> Regards,
> Markus

