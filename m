Return-Path: <linux-kernel+bounces-867067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B19C01828
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141A31A67BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4414332913;
	Thu, 23 Oct 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="TDgzZWa+"
Received: from smtp87.iad3b.emailsrvr.com (smtp87.iad3b.emailsrvr.com [146.20.161.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F01332910
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226622; cv=none; b=ZlIlxU/VofYlAvpT0GMHxkhllNTaptq5OgdXBXsMBajpGdrTp8d+BfYFn2YMPc3QqoWZa72bDBAGJMFWByX7yGvF/2qS4Qc0O3HOySOQ+5haB7h2Qdf13smt+SpqcKVCPzSWmhfLjQWODPoOkx9QGeGTcaAdIFcpzGteMmJv/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226622; c=relaxed/simple;
	bh=mL0wt+KmpD+Meo1RC0onhLWZw0wiuEg+CHHKOUNV4BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDgXjT+/yo1RFs0hl9/I3OfO5uSNvrqqazd9/HBBJJ7JkGAwC4gCeDOmo5NrA5wpi/MathTMdAoLRpUUF2Pd3m7YJp0kq191tM3ygPGmOt879QZVLDKquGoSK+dZ+5OhPY2L8sxv1JF4pGkWUjfmk0HGky4w1xurzgS+j4elvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=TDgzZWa+; arc=none smtp.client-ip=146.20.161.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761226288;
	bh=mL0wt+KmpD+Meo1RC0onhLWZw0wiuEg+CHHKOUNV4BQ=;
	h=From:To:Subject:Date:From;
	b=TDgzZWa+XIiBxDNzqY2nAFygSXAqA9mvHuWkey0sLdEU1umi749MuDvKrq0TGSylW
	 D0ffcHhTcjbNGtzPSV29LC/d5ZgITRiydglj2Oqrj/FjktexR5hIL0dUiILTkxDLwh
	 /L/2jqmkOd1zfA6xtA69un+OTNqoRcb0tEjPuCAo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp11.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 5319E40411;
	Thu, 23 Oct 2025 09:31:27 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 0/2]: comedi: Reference counting for Comedi command
Date: Thu, 23 Oct 2025 14:28:17 +0100
Message-ID: <20251023133001.8439-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 06accbc7-f6e3-458a-bef4-026d948b4d7a-1-1

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

