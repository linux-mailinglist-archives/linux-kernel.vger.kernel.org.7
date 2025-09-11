Return-Path: <linux-kernel+bounces-812496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAAEB538E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A8C1BC4B16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4403B350D53;
	Thu, 11 Sep 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="DuOnxO9R"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30E33A03D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607457; cv=none; b=cnbevPUnuwZHRmm+A8STy/lPfh7nqSnZwJiNr9lpKY5TaWIVIWOofX7IO6Ss/26ZxB8AhwJMU2NEC8lSUroACv9v8mKakTLj9kYqZ9wpiHNKk7pbV81E2o5nXX0DrQE5+RY/tOVYBgLo7PpWaKLvhn6yjhmBZOsYDbB0alpx9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607457; c=relaxed/simple;
	bh=29ujcLqr1uM83e/ICJXbND5pFmUcSE3Z3w8JiclMBjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDdrvWsHlJCNMljBV6mK5JRiQrj0c9QJtJSVVR9w68Dj9rDwBz460qz7mEzDwqhiUudTgrqSSbKOoe0FrLONvvmoHby8+WfTrEX8zRzx9RPA313BOBHIz1tVKV3i/DkOqoIjPlP2pLG6vd0pVo2ejLjO9Una31i5DOaGhyaLJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=DuOnxO9R; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id E5D1F1014350
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:47:22 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in E5D1F1014350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1757607442; bh=29ujcLqr1uM83e/ICJXbND5pFmUcSE3Z3w8JiclMBjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuOnxO9Rqdn1i+vfLoQR3YXeYnysFBbfMG4akQh4nKsYDpoqjGl9vUVRZB9EQL+nQ
	 AO7S03ZQ9UouGGMl/5EZXR1vlV+9b7oqQEyxOKTHayOmengxMywbVSUbUvIfy70OEh
	 WoDYtsXEA+7xvDqAQWR16S6SGIMNN3/xEcabyYYg=
Received: (qmail 26613 invoked by uid 510); 11 Sep 2025 21:47:22 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.470537 secs; 11 Sep 2025 21:47:22 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 11 Sep 2025 21:47:18 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id B9203360052;
	Thu, 11 Sep 2025 21:47:17 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 7DEBE1E8147E;
	Thu, 11 Sep 2025 21:47:17 +0530 (IST)
Date: Thu, 11 Sep 2025 21:47:12 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, sj@kernel.org, dakr@kernel.org,
	mic@digikod.net, masahiroy@kernel.org, corbet@lwn.net,
	clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 0/2] samples: timers: hpet_example: Improve user
 experience
Message-ID: <20250911161712.GA2538958@bhairav-test.ee.iitb.ac.in>
References: <cover.1755436239.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755436239.git.akhilesh@ee.iitb.ac.in>

On Sun, Aug 17, 2025 at 06:54:00PM +0530, Akhilesh Patil wrote:
> Hi all, 
>   This patch series improves user experience for
> samples/timers/hpet_example
> 
> PATCH 1/2 --> Add support to print help text if user does not provide
> required arguments.
> 
> PATCH 2/2  --> add help text in timers Kconfig
> 
> Testing: 
> I have tested the changes on x86 with hpet device as follows. 
> 
> 1. Build the sample program 
> $ gcc hpet_example.c -o hpet_example
> 
> 2. Run hpet program with no args
> 
> $ ./hpet_example
> -hpet: requires command
> Format: hpet_example <command> </dev/device_name>
> Supported commands:
>         open-close
>         info
>         poll
>         fasync

Hi all, I Would like to follow-up on this patch series for any feedback or
improvements needed. 

Regards,
Akhilesh



