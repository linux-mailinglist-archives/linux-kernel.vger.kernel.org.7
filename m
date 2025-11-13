Return-Path: <linux-kernel+bounces-899910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24778C59107
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D91F5052D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8092A35B158;
	Thu, 13 Nov 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LkLxRaye"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D052DF144
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052748; cv=none; b=O51XD7X9LFSH2lnN+jBqR4ZLT3pdmgmMFnMwxFcavNlAacFfY50grL+ztrRfHAwrp73ieCJ+IYPw/MOdWyw0U7XL8n2RyjmVciy7DARmqZuK9GXBRy2wauyaRiDa1l1DKjAWVYTM9qj9aWw3P29ClDTz/Mcp2whgZd1lEFREsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052748; c=relaxed/simple;
	bh=z2uPvH08RZ8jrvnPFTdq1bxL0kZ1K38nwVv7uv2RJz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgeFQkftI1LAsvPohyHwN/UIndYZ3VC2MplPmuOuD6Ai2Stu1XRic7uj205t9FJDAIHIK6g+jreKOawyMNNoaV1IeExUEwHMYzAleSVn3QeI29H1WSuon1faJLFa8fI1pVDejFOSAgE1vno+y+GLNZIkU/vrgq6uMgwYcWYsDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LkLxRaye; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=D9erQHMkf5ayTG7zVl9it0JlY+9oEO2sFugS+aCRTn4=; b=LkLxRayehpdGaJ63O7KPdqMNY+
	d/DB6k2FBIdBnE0POTPimkjG+ZOUG/V8jSb1tSEcQv+FCYH4paAYgamZfHT80jIxeZ2WIFqCBiOJI
	9i9/YLYTQUXymM5hI8w77Uyxmtd0d34OreePsPhRc/i1heL3R+edqkAPUYhm0j5mfFb5GBadXyg0Y
	ErJJGgXk3egO0Jej9gHZBsAsrJUxMvYW6Vb1jbFf62/6jLakkkXbDMSsonaTNYzvElbZKqqvvGIJ2
	eirvtCwMeOqQZKCb3TVbgx5/DB/ymyFVVqQQFodxEzVidaOHZ3OpRYIO673h1t+TfAOwmqDtNJ3Kw
	+YyciHLw==;
Received: from i53875a11.versanet.de ([83.135.90.17] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJaYZ-0003BD-Im; Thu, 13 Nov 2025 17:52:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v3 0/4] Improve error handling for qnap-mcu transfers
Date: Thu, 13 Nov 2025 17:52:14 +0100
Message-ID: <20251113165218.449616-1-heiko@sntech.de>
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

changes in v3:
- fix stupid mistake of not running checkpatch after reorganizing
  the error handling code and having the function opening { not
  on the next line

changes in v2:
- rebase on top of 6.18-rc1
- include improvement suggestions from Lee

Heiko Stuebner (4):
  mfd: qnap-mcu: Calculate the checksum on the actual number of bytes
    received
  mfd: qnap-mcu: Use EPROTO in stead of EIO on checksum errors
  mfd: qnap-mcu: Move checksum verification to its own function
  mfd: qnap-mcu: Add proper error handling for command errors

 drivers/mfd/qnap-mcu.c | 79 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 5 deletions(-)

-- 
2.47.2


