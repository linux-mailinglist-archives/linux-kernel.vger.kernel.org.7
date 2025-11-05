Return-Path: <linux-kernel+bounces-887508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EFFC38664
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607AB3B408F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AA42F6594;
	Wed,  5 Nov 2025 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="pnlXejjs"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990B34CDD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386434; cv=none; b=m68BQmhrldhemX59XwsYySNlsH7LXbkXDp2gC1nc5EzsNk7cPqu5yznwYjKCcvkpaVFSB8vFNY4lDyO/NkuULw3+lt6nl7SqnQE7RJqooWHwMg9D4XrX10NEYEzFlfFBzEDY0fV29f/HdIttL6Vc3JEn1owoX4TjrUq83eW3t8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386434; c=relaxed/simple;
	bh=iDL/fYVB0XdNQ9cQBIPuJoBhKJMQstBOVe5dLKTDSCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFSjzgx1a/gQAKCRf/MdHEKoj37omJuavIjWowXRB67CdKizCLPHUL4fUkRTV6+xGBKtMFdBW3oAXX44PUrz8VMrkToZUys+iOgaAUS4Od9fivZR4j03dZolZzaLt8wil/XEsz8kWfTH9gX9nllyqu62Im5Bhm/SO+Gue0CwnWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=pnlXejjs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=lLcKO3sGqtKTsAJlFMLELZLsLKvmaqj3Oc8nensnQe4=; b=pnlXejjsXncoebt/QNt5n6lrnD
	+/MRYCX6yZWkX8GUQanTSXgFT9dsHhuv7o0a/6N5D1H7ZahdEEVrGJQwIkvB7sodseDizw+tu4iDF
	dE6QQGokC+sh3SG3TyGP/ro1Z/94lUBDAWWeyGUdIO4D0aDFITgWtmmr01X8xjAIHCsFtpcP2ctsW
	dJ6lQ0KRIFRumNMWKAHn0yYN5wd3mfsBctJDpD5wVxfmXFPcdckwbGQPIP9z8pqh7EduFMCVILVn1
	ZMTE6KGdhTl1lrcjFXY8vYc0crvdmOA4EHo1EPHFkHjifrmScP01/TrSFokhUVUEW4qBy0khZg1cJ
	s8LiybqA==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vGnDb-0001Oh-1r; Thu, 06 Nov 2025 00:47:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v2 0/4] Improve error handling for qnap-mcu transfers
Date: Thu,  6 Nov 2025 00:47:00 +0100
Message-ID: <20251105234704.159381-1-heiko@sntech.de>
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

changes in v2:
- rebase on top of 6.18-rc1
- include improvement suggestions from Lee


Heiko Stuebner (4):
  mfd: qnap-mcu: Calculate the checksum on the actual number of bytes
    received
  mfd: qnap-mcu: Use EPROTO in stead of EIO on checksum errors
  mfd: qnap-mcu: Move checksum verification to its own function
  mfd: qnap-mcu: Add proper error handling for command errors

 drivers/mfd/qnap-mcu.c | 78 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

-- 
2.47.2


