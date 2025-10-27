Return-Path: <linux-kernel+bounces-872092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC8DC0F3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 576114FE338
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D30311969;
	Mon, 27 Oct 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="pCGmjVA9"
Received: from smtp112.iad3a.emailsrvr.com (smtp112.iad3a.emailsrvr.com [173.203.187.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3623081DE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581810; cv=none; b=MTQj32vOk/eABl08t+aUJwZ/cyxJ0EbMbAKF81cUsQl7cgcA1l1lcr0ZrKMawKXOeGUl/HIwbnSjG0BnymewNwJLMvXsxe0I03/xSj0pt/u06a8Mry81I97I6eJX2vQ6zydJ0nW1Efz5uetPWOVCwya2Zue+JfjRKoFVMvcdCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581810; c=relaxed/simple;
	bh=Z50+hAuhC843Uia6rw7zChXTAqkUhJHl75BXmiZu//g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oO0dBmr0Ey5YwNUh1/ZNxF+4FQYMe3CXglm3XQphIlC+68Q0OuQEfDX+gkL8hY1LvUim+yn2XqnNavAJYA2grJEx70YqKwcHsUBlVwRqmmHDl8ZPFO9KydSMa2LaQZMcFIsptFvqD+HBViOCc2n77pXpBIilfbJn7Jquedw5ZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=pCGmjVA9; arc=none smtp.client-ip=173.203.187.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761579480;
	bh=Z50+hAuhC843Uia6rw7zChXTAqkUhJHl75BXmiZu//g=;
	h=From:To:Subject:Date:From;
	b=pCGmjVA90REKCbbXwGkBWd5Bo7Ri64l92q4jfjLs7A+bFCIPqKK8GAxzYsqlqD4J2
	 ysCbtGX//04+kI16CExsRrz25g3uy2K5VRdBN4GKmPu/v5cOqscun6x5XDSEAV77ra
	 JYJuLjF12GtfiI7TZjyBtQplO/Wm2+X2dhlzXZQw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BE5B8253A9;
	Mon, 27 Oct 2025 11:37:59 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 0/2] comedi: comedi_bond: Prevent loops of bonded devices
Date: Mon, 27 Oct 2025 15:25:01 +0000
Message-ID: <20251027153748.4569-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 91387a8e-76e7-4b89-824f-f1251498570e-1-1

The "comedi_bond" driver allows a COMEDI device to be set up that uses
(or "bonds") the subdevices of another COMEDI device.  But by
reconfiguring that other COMEDI device to bond to the subdevices of the
first COMEDI device, it is possible to form a loop of bonded devices.
We want to avoid that because it is is both silly, and will result in
mutex deadlocks when accessing the channels of the bonded devices.

This series of patches introduces variants of the `comedi_open()` and
`comedi_close()` functions in the "kcomedilib" module that indicate
which COMEDI device is attempting to open the other COMEDI device, so
that this information can be saved by the "kcomedilib" and used to check
for and prevent cycles of devices opening each other.  The "comedi_bond"
driver module is changed to use these variant functions (called
`comedi_open_from()` and `comedi_close_from()`).

1) comedi: kcomedilib: Add loop checking variants of open and close
2) comedi: comedi_bond: Check for loops when bonding devices

 drivers/comedi/drivers/comedi_bond.c        |   4 +-
 drivers/comedi/kcomedilib/kcomedilib_main.c | 120 ++++++++++++++++++++++++++--
 include/linux/comedi/comedilib.h            |  34 +++++++-
 3 files changed, 149 insertions(+), 9 deletions(-)

