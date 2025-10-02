Return-Path: <linux-kernel+bounces-840438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD5BB46DD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418091891FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD45B17A586;
	Thu,  2 Oct 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="veE8CEM/"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9E27453
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420869; cv=none; b=V7Foqmfbdwz9YGNrDycsCjQK+gSQy4ElrLc9ai0efHOh4PY8MvyX23F4qfbTjPB3gwrmoIe8jlauQGflh06545dx3kOXHU08PXWsNQjBAIQSQaalqaFIcV/SIP17jk7vf9HN5kca+H2vyu6RWAYCzGauNAYw9g8V7Si+Bk/UBKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420869; c=relaxed/simple;
	bh=pU5ODyOpKgrJfAinV1dcdi2m1lpWYA3M5fMV34X7Kk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8FdlTi2D5p9lgDraqfqtaWe14CGt611Ynl13oCWiBVHymOWJkXleqljVNI58nq9FqRtAtIz6ak9++cKPm+CpO6+CG6XUxhZZnwC8xSmORWRDeTWdxlFXQBHZSGXYJFKb7gQRo36fj0uU76vDMPzKL+vq7zst86BPSR4gf5oI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=veE8CEM/; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 4CCC2103BD36
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:21:23 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 4CCC2103BD36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1759420283; bh=pU5ODyOpKgrJfAinV1dcdi2m1lpWYA3M5fMV34X7Kk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=veE8CEM/JQTrNXnNaUxSjTy3nXCrH+jcJ0yHhU9crPy+d6U4v9XY4FPPVSCuD2N2v
	 t9P63vlHiNSifeVwoolhmazII2WDJWBSLoBRnPrlD98EoMBxFnZBsBVr1HZxn/pexM
	 BzW8LKREjPKq4w2f/qk4yO/tYR0szF600Qr/C0Y8=
Received: (qmail 15111 invoked by uid 510); 2 Oct 2025 21:21:23 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.263975 secs; 02 Oct 2025 21:21:23 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 2 Oct 2025 21:21:19 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 7AD1A360079;
	Thu,  2 Oct 2025 21:21:19 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 57BC41E814C6;
	Thu,  2 Oct 2025 21:21:19 +0530 (IST)
Date: Thu, 2 Oct 2025 21:21:14 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org
Cc: skhan@linuxfoundation.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: Re: [PATCH v3 0/6] rtc: m41t93: add new features alarm, clock out,
 watchdog
Message-ID: <2025102-155114-838866@bhairav-test.ee.iitb.ac.in>
References: <cover.1758379856.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758379856.git.akhilesh@ee.iitb.ac.in>

On Sat, Sep 20, 2025 at 08:30:59PM +0530, Akhilesh Patil wrote:
> This patch series adds following to m41t93 rtc driver.
> 
> Functionalities: 
> - Alarm support (support to configure alarm 1)
> - Square wave output support
> - Watchdog support
> 
> Code improvements:
> this series migrates existing driver to use standard regmap interface
> for spi instead of direct spi calls and uses regmap for new features.
> 
> Device tree support:
> Adds device tree support to the driver along with binding documentation.
> 
> Testing:
> This patch series is validated on TI am62x board with m41t93 rtc chip
> connected to spi0 bus.
> regmap migration is additionally tested by observing spi transfers
> with the help of logic analyzer. Short summary of test flow is added in
> commit message of respective features.
> 
> Datasheet:
> https://www.st.com/resource/en/datasheet/m41t93.pdf
> 
> patch 4 to 6 depend on patch 3 (regmap patch)
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---

Hi Alexandre, I would like to follow-up on this patch series for review
and feedback for rtc code. Let me know if any additional improvements needed.
I am willing to volunteer to support this driver in the kernel, in case
needed, as a reviewer/maintainer. I have this m41t93 RTC hardware with
me. Given we are in 6.18 merge window, looking forward for
this patch series.

Regards,
Akhilesh

> Changes in v3:
> - Address comments on bindings from Krzysztof and add myself
> as a maintainer.
> - Re-validation/testing on top of v6.17-rc6
> - Link to v2: https://lore.kernel.org/lkml/cover.1757510157.git.akhilesh@ee.iitb.ac.in/
> 
> Changes in v2:
> - Address DTS and bindings coding style feedback from Krzysztof
> - Verify bindings using $ make dt_binding_check 
> - Update example in binding documentation after testing.
> - Analyze and Fix build warnings as suggested by kernel test robot.
> - Drop patch 5 from series (device detect logic change).
>   This will be taken separately. Focus on functionalities in this series.
> - Update commit messages with short test steps for each feature.
> - Link to v1: https://lore.kernel.org/lkml/cover.1756908788.git.akhilesh@ee.iitb.ac.in/
> ---
> 
> Akhilesh Patil (6):
>   dt-bindings: rtc: Add ST m41t93
>   rtc: m41t93: add device tree support
>   rtc: m41t93: migrate to regmap api for register access
>   rtc: m41t93: Add alarm support
>   rtc: m41t93: Add square wave clock provider support
>   rtc: m41t93: Add watchdog support
> 
>  .../devicetree/bindings/rtc/st,m41t93.yaml    |  50 ++
>  drivers/rtc/rtc-m41t93.c                      | 488 ++++++++++++++++--
>  2 files changed, 486 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> 
> -- 
> 2.34.1
> 

