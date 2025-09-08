Return-Path: <linux-kernel+bounces-804921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC09B481F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE43165A56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADDF1B87C0;
	Mon,  8 Sep 2025 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="FCawOmjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+fHIuAI"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02621176ADE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294479; cv=none; b=t5VM8LjjIsMdqT8ZJfAtwdwz8T3Zx+5gqbW0N0cN7nTGlgV+yj7y5N1WpWOTwAkx8Z+j5MQt319/puw/pIpBdyuv1eHOymULJhfx3QnHGysDOQd7hNy72ATYPwUkJX/HZOrWlITVJKRuI6LsUnE3fXoohSSa+VwWyCP3XK0jVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294479; c=relaxed/simple;
	bh=qtJY3gFujkGCgovEPsTWYhpNOn86IPxa5w6Iy/nKWXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTLPwHeMIhceMY3SPQyPAvO5HgXVa/0+AUCqsCyhJ6q6CKrUjdlIpwuzfqiTanqnvVSrZ61wHtTbQ5Fp7mkPuW5TROtlTAqGAETO+ZPTQh1SVDeaMQlIqXasUz+iMDlsxiH/z+KHx75dlPKkIkabk5UAvMbpn/uL6xtv/tPtIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=FCawOmjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+fHIuAI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CFBFCEC003B;
	Sun,  7 Sep 2025 21:21:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 07 Sep 2025 21:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1757294473; x=1757380873; bh=Ddrc2RDJT3
	nN7fxKBo2BZeJOnIBeRfoyXyg3B41qNxI=; b=FCawOmjk+iGWC8jzb3oxBXnmNy
	P1UfrFNW0RUO0BjVC+HqWovCKeVNPcqmfg/vsFs9M0PEvNTBw1DeeWKJNsvK7v1C
	8f4WXmsuWLBX882QnE2dxtz83AEt+RB4FaxImJFOaz4JGFM47/+cbEsZCKQd1zPa
	A7DbC+hJOVFSaQ7z/1+PpeG+6FoZURhAHVWLnrROZPk0I7EcViUhYPCdzoaFhBcT
	6GprSNeQN6CZ1nNTSL9Ok5Neo0fiFSNPCPokGZr/yeE1v2PuEEJ1UNl0rk27E1jM
	yxpzlWfoxpNF3UxKElmULm6PbcIPQQoZ/T+fzM05jtpqA5N4O6hL65ojIjyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757294473; x=1757380873; bh=Ddrc2RDJT3nN7fxKBo2BZeJOnIBeRfoyXyg
	3B41qNxI=; b=C+fHIuAI9LLfjgNHrUWDU3bcltwyJhgMAC2fbRKCh5EMGf3C7In
	i0x490GFJMAE3DayKOwo8RVKRugJyp8PFxs5rqw+8hxzOZLm3Jbf+YUswyR8Bd6O
	4J4IvammciNXi+dGKvRGht3pR+SigsRMPMq+Z5b5RXwCwRcEH+SKmd7/VCyl8UUT
	JZ+HKkKmiw0O3jpwFX36QpvjCyBRTBSoU4bl6ujkZ/bnPLEbtWX9h1KkS4SG7Iez
	9vbqSds1ns2u8KYMSR9+NnE5hzN7ar4L7jwMKWh8TbeL3ITb1BZ4wmwKWM/+2O3b
	t9yPHiZJMXsQDhZ3tayETavdhcruo3oOosA==
X-ME-Sender: <xms:iS--aDS57iPOhBuc_mlrjMGI8H1fRbULGQRbD2iJia6UpJtV8JTXXg>
    <xme:iS--aNsQwIT4CqOjn5iZncoryGwbAzt0Hq_h6FWCn8nnciGWyo_cnb-TCcmVcThNp
    XgniFgbAhwVz91794M>
X-ME-Received: <xmr:iS--aKzaZyYh47cr-_2rqYM1L8oJXzYDw6jKrrivp_J3vVVw6rc49qoHZ_kPhyFcSiMaKUbKrlEMQc6rZc-DJdcoScdjo73RbfiNeobY63E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhf
    etjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmh
    hotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfh
    horhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iS--aP5V00JTWOq-QHiEtgZzrhJQuGU7F1tnxLO026u_Ip71HjIsjg>
    <xmx:iS--aMXIN48tOfGqROTX7-x-dsp6M7vBjyuEF26a10idsiJZwKOyTw>
    <xmx:iS--aD2COzmdGsNOpr_oZ7_tPv1w-l5bNFMHEUzLASt5ZlCwaisluQ>
    <xmx:iS--aJ3FX7Qt0ZOee25r4_DDFZlKp-x1lemz-OcifSHFzcuTCMUrvQ>
    <xmx:iS--aL8HuevlvgWzjO1UKdqbVPy-D9EWN5-YmIMKHRYNKObU4U9Gy-Vv>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] firewire: code refactoring mainly for bm_work
Date: Mon,  8 Sep 2025 10:20:57 +0900
Message-ID: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The core function in this subsystem have bm_work work item. The
corresponding function has many lines with comments. It is a sign
that it is time to be refactored, in my experience.

This series includes the first take for the purpose, as well as the
other code improvements of 1394 OHCI PCI driver and the other core
functions.

Takashi Sakamoto (11):
  firewire: ohci: use kcalloc() variant for array allocation
  firewire: core: utilize cleanup function to release workqueue in error
    path
  firewire: ohci: use return value from fw_node_get()
  firewire: core: add helper functions to access to fw_device data in
    fw_node structure
  firewire: core: use cleanup function in bm_work
  firewire: ohci: localize transaction data and rcode per condition
    branch
  firewire: core: code refactoring to evaluate transaction result to
    CSR_BUS_MANAGER_ID
  firewire: core: refer fw_card member to initiate bus reset under
    acquiring lock
  firewire: core: code refactoring to detect both IEEE 1394:1995 IRM and
    Canon MV5i
  firewire: core: code refactoring to investigate root node for bus
    manager
  firewire: core: code refactoring whether root node is cycle master
    capable

 drivers/firewire/core-card.c   | 239 +++++++++++++++++----------------
 drivers/firewire/core-device.c |  18 +--
 drivers/firewire/core.h        |  14 +-
 drivers/firewire/ohci.c        |   7 +-
 4 files changed, 143 insertions(+), 135 deletions(-)


base-commit: a901f493d06631091bf1f644fdbb5cb4f566645d
-- 
2.48.1


