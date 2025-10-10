Return-Path: <linux-kernel+bounces-848133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4240BBCC9CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2DCE35351B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C57286897;
	Fri, 10 Oct 2025 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="voOBielH"
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722E2853EF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093595; cv=none; b=j/Xl8v0QjbADXAUZShDieXy0Y5YXrsh/djGi/bd9SfEryXdEITQvUX2E78q00zPNXh5+ssZzhig/8ZrlOETVK4Ygh2SYF2BXhLmvpPDqLLQgkOR0AQFvGxuNUfsTTFu4LjLb/pW/AMOSY3bqXnikGu7oWe5ctPhxWC246rg+bP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093595; c=relaxed/simple;
	bh=8A/uk6sQ89G8Ki8wYEWl9p01loK2J2LgcrJ9MRioWbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yi+hyZnl/9BFy1ZPGTZJQ6f2sW3GTdO+qW+xPAA2myga3duYjc4jvidedZ4TI20s3X7Pe5kPooXECjFfITFdsJIbQ/0lxkSIEFzBcTc/CnRREW5dXd6P7oBd44K16bYSkITBd6pB7cYlrtUFMO9PpOyIx7AEWJk6SQrbIPFsfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=voOBielH; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1760093584;
	bh=N7brHjyGflrQ+iAO9Tiac5aunqIUPtwvhliG0NoK95A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=voOBielHeXpef5JduzSuoOecmO0aRWD2f6D31xmOU9djNpHMLZiXf/QgOPNKwJkOJ
	 M75IE0hj99igjEAGTIn0XufsypLL2OFl7ZMskHMbEGeNmKkWyGv7khXN1DT8ZxYB6U
	 e2YEmylSjr8uyAa6rlMIBm5NN4a3loLMwodmf/Z33xWqhDqgDv7xvTzBcbLzfN3tO4
	 rbBQHOMqxK4wHovdcgQIr8Knac/LNVDP2dvJ1KrTVrBflrDYP4lypj8V9x43G1HGQb
	 dB3fDsJQqsocN/CoM3nsww8es3B9vzoKIXseuthPLVw0GgQ09I8mE1dqMWDlyp8S4Q
	 sGwJmjAYWFQ9g==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 21C6A5A179A;
	Fri, 10 Oct 2025 13:53:04 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id B6E6C5A15D3;
	Fri, 10 Oct 2025 13:53:03 +0300 (MSK)
Received: from votokina.avp.ru (10.16.104.187) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 13:53:03 +0300
From: Victoria Votokina <Victoria.Votokina@kaspersky.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: Victoria Votokina <Victoria.Votokina@kaspersky.com>, Christian Gromm
	<christian.gromm@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>
Subject: [PATCH 0/2] most: usb: Fix UAF in hdm_disconnect and put_device() before device initialization in hdm_probe().
Date: Fri, 10 Oct 2025 13:52:39 +0300
Message-ID: <20251010105241.4087114-1-Victoria.Votokina@kaspersky.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/10/2025 10:41:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196985 [Oct 10 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Victoria.Votokina@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 71 0.3.71
 ee78c3da48e828d2b9b16d6d0b31328b8b240a3c
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;kaspersky.com:7.1.1,5.0.1;votokina.avp.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/10/2025 10:44:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/10/2025 9:12:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/10 09:41:00 #27899163
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

This series fixes two issues in drivers/most/most_usb.c.

- 1/2: hdm_disconnect() raced with device core teardown, leading to a
       syzbot-reported KASAN UAF/double-free. Move all mdev-owned frees
       into release_mdev() and drop redundant puts in the disconnect path.

- 2/2: early hdm_probe() error path called put_device() before
       device_initialize(), triggering a WARN and touching an
       uninitialized kobject. Use kfree(mdev) there instead.

Both patches tighten lifetime rules and remove WARN/UAF.

Victoria Votokina (2):
  most: usb: Fix use-after-free in hdm_disconnect
  most: usb: hdm_probe: Fix calling put_device() before
    device initialization

 drivers/most/most_usb.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.30.2


