Return-Path: <linux-kernel+bounces-888097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9864FC39D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7593BDC29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA82E54A0;
	Thu,  6 Nov 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qx1MDcnr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37DA35965
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421710; cv=none; b=gaLKU++zMM2awczhSjJVgVYhNZ22uxEdUhbp/RAc26tYhH3aps6XVnq2Sez7EurTvS8qVqNt62SsxEaKNHU7nnhOmC95V5dxwkiuQTCXXv2CdlrJd7zc0xLez6vOxNt/fc+NBHQOL+z/ZphnGJ+zxiiIKtcHNwdqhK9oLtInmPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421710; c=relaxed/simple;
	bh=qEmhvJ0+ukIwFOZA8ME1ha5DyXFo9s7/Arup1Wg1aF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXxXzHRLE1d1JUjvSTM3Jkn3WmMgDbNzSM7Y0GaoHW22vBsLWoJU2ocPLL0QaEJkOMmhEpCfdok8ueT7XnRmjUKIpV9WX5XfMlUiUyPDEdLlIFlhbWYwx2RpYCBLdeaPWtPFDf7pPSG+G9MyF9L8eNOir+fuSXOxw+FFcfe/BD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qx1MDcnr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eQGd6Ve9TxX74YCdLm04W/lnilUX+GeVs4HRiQ0wIYA=; b=Qx1MDcnrOTnwHCTv4gJ+Kp57Yu
	eSrNvnorzSw22w3tADCSKkJlTq737IXVAt/QybkqGW0qlv1ma3r05CFdOP+4X5bsmtqaET96vlAy4
	GvDR8yOpwpXDeCiCmMR5lej1BevHZtyRwynmXKrkg+3SRX+QUnIqb+YHuXSJabLGrYRE+aHgsg/x4
	WMDA3aujbH1CoMrVF7HD9p3K/+nCyLc7J4MzbHZtC00viqsyjvbQZhcOsOEJp2Djfu9/OJpEIINyh
	reJcnXZXovM5pESghbR0hrqmnDQjfvvYKgX6IxUrP69r1s9IbjMIAtbnP0HzqV4XBdWQD7lvpPyYV
	rrzCcYSg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGwOU-0000000G7dm-3FpZ;
	Thu, 06 Nov 2025 09:35:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AD62830049A; Thu, 06 Nov 2025 10:35:02 +0100 (CET)
Date: Thu, 6 Nov 2025 10:35:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vmlinux.lds: Fix TEXT_MAIN to include .text.start and
 friends
Message-ID: <20251106093502.GS4067720@noisy.programming.kicks-ass.net>
References: <5c4ca80e52958da289f92157430d2a31d29109d3.1762322973.git.jpoimboe@kernel.org>
 <2fm4yxe6nr6khoyjmo7r7v4u4zxwygz3wch2vb5yolo2tqjsx7@s27lvvoe6x3j>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fm4yxe6nr6khoyjmo7r7v4u4zxwygz3wch2vb5yolo2tqjsx7@s27lvvoe6x3j>

On Wed, Nov 05, 2025 at 10:55:19PM -0800, Josh Poimboeuf wrote:
> On Tue, Nov 04, 2025 at 10:11:42PM -0800, Josh Poimboeuf wrote:
> > Since commit 6568f14cb5ae ("vmlinux.lds: Exclude .text.startup and
> > .text.exit from TEXT_MAIN"), the TEXT_MAIN macro uses a series of
> > patterns to prevent the .text.startup[.*] and .text.exit[.*] sections
> > from getting linked into vmlinux runtime .text.
> > 
> > That commit is a tad too aggressive: it also inadvertently filters out
> > valid runtime text sections like .text.start and
> > .text.start.constprop.0, which can be generated for a function named
> > start() when -ffunction-sections is enabled.
> > 
> > As a result, those sections become orphans when building with
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION for arm:
> > 
> >   arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/usb/host/sl811-hcd.o' being placed in section `.text.start.constprop.0'
> >   arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/media/dvb-frontends/drxk_hard.o' being placed in section `.text.start.constprop.0'
> >   arm-linux-gnueabi-ld: warning: orphan section `.text.start' from `drivers/media/dvb-frontends/stv0910.o' being placed in section `.text.start'
> >   arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/media/pci/ddbridge/ddbridge-sx8.o' being placed in section `.text.start.constprop.0'
> > 
> > Fix that by explicitly adding the partial "substring" sections (.text.s,
> > .text.st, .text.sta, etc) and their cloned derivatives.
> > 
> > While this unfortunately means that TEXT_MAIN continues to grow, these
> > changes are ultimately necessary for proper support of
> > -ffunction-sections.
> > 
> > Fixes: 6568f14cb5ae ("vmlinux.lds: Exclude .text.startup and .text.exit from TEXT_MAIN")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202511040812.DFGedJiy-lkp@intel.com/
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> > For tip/objtool/core.
> 
> Nack.
> 
> There are still some additional headaches that need fixing.

Hah, good thing I was otherwise pre-occupied yesterday.

I'll await a new version then!

