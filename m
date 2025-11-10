Return-Path: <linux-kernel+bounces-892940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAB1C462CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577D51883F12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F2030ACFB;
	Mon, 10 Nov 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRb3Lomc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88916219A8D;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773292; cv=none; b=ck2BckdsjaI8ddDIzY3DHGe9zFXeruB32nFWnxzKsjM9QgEB0/zf6DAGytfn+Db/wQGUTAsLO814BE0hxM7mBto7hXumwQpPs6hGth2eHRMpIY3wG0Q/WtRC5we2U9KaB4UHq1DLd2QicACmH9XV8WIRFvG9FmYQC1r0zI1irZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773292; c=relaxed/simple;
	bh=KmkEv5bRm5BWYgNK7zilaGlWpyAsR6ksgiOjZMe4jj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0OY/Qmay6A9Zr4NW0nNIo5ZRXap9mAC5Otaq5VjzxJ2ftUMWtLVN3tUigZx0oeyfXYGL7g7li3SRCWuM/XDktrVyXxiADUE+3s+rCHqA9IiPhm0+aB9VXk/3nvCx5BSF/DnVJcmKe5bRPbHNgYZPRyNBVjwucwUnCg3TqO4BUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRb3Lomc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03003C16AAE;
	Mon, 10 Nov 2025 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773292;
	bh=KmkEv5bRm5BWYgNK7zilaGlWpyAsR6ksgiOjZMe4jj4=;
	h=From:To:Cc:Subject:Date:From;
	b=hRb3Lomcij6JQVvw6nwNGrv8R1kAt9FpyyRmqUT+IInWw9V5L2GjvnSposxuMs+QT
	 4eUtoyBqLAkZHOMa5ka6VFeQZ6/+dS/+Jn2c5oUqcQWgUQOxsgX0MQtVSLR/mkpJ/s
	 FbUVIHs4dym340E6vjTcSEw1QHiKPBUNWhRFMX+c1gvcoC5J3NtrdV+2HZnm/DCvtA
	 AsWkvVlFXpz/Ad/1H2z8H7QYwLIEvSA5TbJ9aGtaePyOGX7De+fxf2+V067TKcWiU5
	 fcYPVEOQgb3CfLU0On9a70jitgJaStH8NZb0UBqpnUjSG1jrqrXkRY+/sRlbvV9Iwh
	 /d5OFYh/bbBeA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPrH-0000000007W-1t3F;
	Mon, 10 Nov 2025 12:14:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Mann <rmann@ndigital.com>,
	Andreas Messer <andi@bastelmap.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] USB: serial: ftdi_sio: clean up quirk handling
Date: Mon, 10 Nov 2025 12:12:04 +0100
Message-ID: <20251110111212.32702-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent discussion about some JTAG devices made me revisit the ftdi_sio
quirk handling which could use a bit of cleanup.

Johan


Johan Hovold (8):
  USB: serial: ftdi_sio: match on interface number for jtag
  USB: serial: ftdi_sio: silence jtag probe
  USB: serial: ftdi_sio: rewrite 8u2232c quirk
  USB: serial: ftdi_sio: clean up quirk comments
  USB: serial: ftdi_sio: rename quirk symbols
  USB: serial: ftdi_sio: enable NDI speed hack consistently
  USB: serial: ftdi_sio: clean up NDI speed hack
  USB: serial: ftdi_sio: drop NDI quirk module parameter

 drivers/usb/serial/ftdi_sio.c | 200 ++++++++++++----------------------
 1 file changed, 68 insertions(+), 132 deletions(-)

-- 
2.51.0


