Return-Path: <linux-kernel+bounces-867064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6599EC017DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEB43AF039
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F132AAA8;
	Thu, 23 Oct 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="qZoCrOVq"
Received: from smtp71.ord1d.emailsrvr.com (smtp71.ord1d.emailsrvr.com [184.106.54.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0237328B4B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226607; cv=none; b=MKyvrUqH68nCFehCGdk/EYSzKF3pZ/waQX6bNrLLgNUI89P+l98y4B7+yeRn2EhsT8N4AI45K4PwoMaaEwrRh58OPo9qOTYaScFsyhk8GaW68vkYLaq4ATHUo8cdUf/IjviVsfn/13fDinYQyFQJIEEPHMsynhewsSjrE3csXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226607; c=relaxed/simple;
	bh=mL0wt+KmpD+Meo1RC0onhLWZw0wiuEg+CHHKOUNV4BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+3cpfRU3CRD6e4hdgwuaqvSnBnF+SVEI5FdI5KG5NItVNx01q+luRnM2/m9KK5MQV/O2jxUYvEXuqYtYx4yN5tzpWzZzp+ofYMK8ACRO0daW/kTX7LZ+Ai7dv5Lv0taYKl1sVYhJGCqQi03UQ+gE7+jY9g/Vs7Up0xUu7nTh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=qZoCrOVq; arc=none smtp.client-ip=184.106.54.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761226056;
	bh=mL0wt+KmpD+Meo1RC0onhLWZw0wiuEg+CHHKOUNV4BQ=;
	h=From:To:Subject:Date:From;
	b=qZoCrOVqzjDcWM4/LWqMHlD1CMd14BBmq/5f+71Sb6SWPUQRfPVYdPxuLciSz3ah9
	 jL1R4FOKhgNQSObgM5zPrtO56KppjQDcqRNQSqxvDZXxqZmfo4HZ4zJodyELy9i1gg
	 VCQoW06FEPbCr1NEQkYzYbBcnirAPf3Xy823dYHE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1AEC34026E;
	Thu, 23 Oct 2025 09:27:35 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	lvc-project@linuxtesting.org
Subject: 
Date: Thu, 23 Oct 2025 14:06:44 +0100
Message-ID: <20251023132706.7983-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: a5f18e55-3fae-4f0c-8e4d-f1649ff649d1-1-1

Comedi allows legacy devices to be configured manually (with sys admin
privileges) with ioctl calls at run time by specifying parameters such
as board name, base port number and IRQ level.  If not done correctly
for the actual hardware being configured, there could be problems caused
by unexpected interrupts (not to mention problems due to reading or
writing incorrect hardware registers!).

These patches protect various functions in the core comedi module from
these problems by adding checks that the structures that the function
uses are in a valid state, and remain in a valid state until no longer
required by the function.

Some low-level Comedi drivers use these structures directly outside of
the core commedi function calls, and may also need fixing.  That has not
been done yet in this patch series, but it provides a mechanism to do
so.

1) comedi: Add reference counting for Comedi command handling
2) comedi: Use reference count for asynchronous command functions

 drivers/comedi/comedi_buf.c      | 274 ++++++++++++++++++++++++++-------------
 drivers/comedi/comedi_fops.c     | 134 ++++++++++++++-----
 drivers/comedi/comedi_internal.h |  12 ++
 drivers/comedi/drivers.c         | 134 ++++++++++++++-----
 include/linux/comedi/comedidev.h |   7 +
 5 files changed, 401 insertions(+), 160 deletions(-)

The alignment of the diff output in the second patch turned out a bit
wonky due to similar changes in different sections of the files.  I can
split the patch if deemed necessary.

