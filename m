Return-Path: <linux-kernel+bounces-829306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4205FB96C19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D3818A86E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0E2E62A6;
	Tue, 23 Sep 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="siHL7Ucn"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D672594B7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643751; cv=none; b=ZJjzFuX3Mn9L3rg1qk8GzRXtqCRXmVepo47LQKOs7GCwyANBKhFmAeNAleDRtU2Kdk6GUX3MinXMQ3Yowtaq9i2D837zV5mlxMx9UA1T6j/SbBbUXK2TuNlg++159OCbS3BFM1Qe1ZaR/wLbl6bLb93OPqFRMZJt4NiIYh+I3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643751; c=relaxed/simple;
	bh=x9X96hMgAGFxxcsHhyNTPNXiL7Ot85gn0tyK93BGP6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmbaHdTJShybpob3OxDel9xWO3tF2qtwMe5BfxXrO91R0sAT3qcCObFBXanEpi+vG5GztDDo0GrpWB55oMe1IbgztsSidonwJ80GQ6MzasKWhTn5RvQS7n2w4WGTb7aGN1VLkPQKZOljfccwKwz2HtP8goRGK/c+IdPt4w7tV94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=siHL7Ucn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=hEVR4GKzbzxnFp7pR2uZelqErVZakxG8cLE/u9yFksk=; b=siHL7UcnrvaINZBUdyBI9vqq1d
	GJ2K+wUO7lL/yd+9H8CMeJNHlPy1Ylw3X0TclS/HjD3Ghl717YbaQYOfMFSDdYkmeQYJIOLFODgxT
	5NX++Fx1cH7mxjN0LgZAb8b8VyTJyyHOvIrYotjs8t4gecX9vR54MWzJsUaETKOAZTRs/a/lvMNTK
	4razf+zUnaTv5IfzYTyJp7bsi5ksY7hu/PSbSG4x3lq694NtUCKc4x+BsRFxeZDzOEnQWRWMC0Cv/
	RnpZngZsUc08TTniHP3ft5IpjQYl5J0a+IzKiPHsLSwkWxcxnwnpnNo8TDO4zMqOQjAxNl6XrcRl/
	PQXEy9+Q==;
Received: from i53875a1e.versanet.de ([83.135.90.30] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v15Zi-0004vp-OJ; Tue, 23 Sep 2025 18:09:06 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH 0/4] Improve error handling for qnap-mcu transfers
Date: Tue, 23 Sep 2025 18:08:49 +0200
Message-ID: <20250923160853.1925674-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Digging deeper into how that MCU behaves, I found out it can return
more status codes than the "@0" for "ok".

The additional codes can report a failed checksum verification and
some "general" error for the command execution.

This also explains sporadic command timeout messages, I have seen
over time, when the controller sends an error code while we expect
a longer reply from it.

So while I'm not sure yet why it reports an error, with these changes
we at least handle the error return code in a meaningful way.


Heiko Stuebner (4):
  mfd: qnap-mcu: Calculate the checksum on the actual number of bytes
    received
  mfd: qnap-mcu: Use EPROTO in stead of EIO on checksum errors
  mfd: qnap-mcu: Move checksum verification to its own function
  mfd: qnap-mcu: Add proper error handling for command errors

 drivers/mfd/qnap-mcu.c | 55 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

-- 
2.47.2


