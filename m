Return-Path: <linux-kernel+bounces-817240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59DCB57FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E271890277
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E524C33EAED;
	Mon, 15 Sep 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U6P5ZjA5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63533A004
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948065; cv=none; b=UdcCvEO2zD0qsqYwEvkGH6UeS15c6BcGWOhDE1VY7EJtUnULgsMPuW9un5yuWOKjGJLQkK1K64T+TYipLwCW13HZ5VebDDBhbtMvpNCS2o8bLCUrkZ7Qm8/qYs5O1QG0fsFUW76bfvCTk5XUXo1FdMjzv+PycUcFO9aBCHMU0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948065; c=relaxed/simple;
	bh=Ui/U/S9AymGrkSRFcnVlplj58Hk2kt/s3Rp0JocslVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qW0Coadnr6gWQLIs7+BwvrcCtlXCUi6Bst3HGokvMtRiCPkWiJEVYrjN592fuDanif16vPGi9xBmlC/XHuRbYxlvah3wjCP15aItcfvoq7Uq5+hB7qYAe2ZX+goYqgE/6dLOJIyHDWun9H9jfwvKlG58YlxHZVjfX3AZ5G8B27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U6P5ZjA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C90C4CEF1;
	Mon, 15 Sep 2025 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757948064;
	bh=Ui/U/S9AymGrkSRFcnVlplj58Hk2kt/s3Rp0JocslVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6P5ZjA5IRFxL9rHxEcZdzrLazt+fgB5i4BTehiadsRy+64rYowbeTTdTsbZYjVDq
	 lmOOh6lymGTuV9Xs9TPC9cf84aOtbZg5fEv1bofKW2NS80WDEbu/67Al+o1DljTBDd
	 MHs1o9b9mljCFcmhqX6LKix6XfCFzewQkMCjlLk8=
Date: Mon, 15 Sep 2025 16:52:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-53212: xenbus: check xen_domain in xenbus_probe_initcall
Message-ID: <2025091522-banjo-waggle-ccfe@gregkh>
References: <2025091511-CVE-2023-53212-fdd4@gregkh>
 <33fb4d70-c3e7-4158-9727-3ad29f974246@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fb4d70-c3e7-4158-9727-3ad29f974246@suse.com>

On Mon, Sep 15, 2025 at 04:38:05PM +0200, Juergen Gross wrote:
> On 15.09.25 16:21, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > 
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > xenbus: check xen_domain in xenbus_probe_initcall
> > 
> > The same way we already do in xenbus_init.
> > Fixes the following warning:
> > 
> > [  352.175563] Trying to free already-free IRQ 0
> > [  352.177355] WARNING: CPU: 1 PID: 88 at kernel/irq/manage.c:1893 free_irq+0xbf/0x350
> > [...]
> > [  352.213951] Call Trace:
> > [  352.214390]  <TASK>
> > [  352.214717]  ? __warn+0x81/0x170
> > [  352.215436]  ? free_irq+0xbf/0x350
> > [  352.215906]  ? report_bug+0x10b/0x200
> > [  352.216408]  ? prb_read_valid+0x17/0x20
> > [  352.216926]  ? handle_bug+0x44/0x80
> > [  352.217409]  ? exc_invalid_op+0x13/0x60
> > [  352.217932]  ? asm_exc_invalid_op+0x16/0x20
> > [  352.218497]  ? free_irq+0xbf/0x350
> > [  352.218979]  ? __pfx_xenbus_probe_thread+0x10/0x10
> > [  352.219600]  xenbus_probe+0x7a/0x80
> > [  352.221030]  xenbus_probe_thread+0x76/0xc0
> > 
> > The Linux kernel CVE team has assigned CVE-2023-53212 to this issue.
> 
> I don't see how an unprivileged user could trigger this problem.
> 
> Please revoke this CVE.

Now rejected, thanks for the review!

greg k-h

