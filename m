Return-Path: <linux-kernel+bounces-817914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B83B58890
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15544204832
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBAE2DA776;
	Mon, 15 Sep 2025 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="pd+4wDUX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwtrSVER"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A82D8773
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980074; cv=none; b=fHCmDLJrjAOMi8M+hyAEjcGHcc/7s9TA9feAMds46x7JukfaTZS34sWLM3vPkLf2xa8ihz4g3Vwke6x7HEXy17guodxChZzyyJt45pQBiUw5qqAhlZCOj1pmuIzsxoqoLqogjg/O4IUgpWVI7CpqNw8s9qu1fUnMCHqXybaQMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980074; c=relaxed/simple;
	bh=kvFGGaTmbPFgW/4yhqADh5WIuw3AqvoQayJ5yPkTEBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePoLqtxus9Ktypn7t7XFh0w2bYpk7azv6cnFSrGaUYOelU2PdY6dGninyk9gTvL8qH/eQUY71ICV3DkaZ7yCtKelocBJ4Mnrp3LRI2Trqh/SYHJUvls+rs1zwmdBLl+Qy5Ci6pgTHUWNi8Y7cDuFecepXNiD4rB3Q/L6WHaTBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=pd+4wDUX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AwtrSVER; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C6387A01CA;
	Mon, 15 Sep 2025 19:47:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 15 Sep 2025 19:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1757980071; x=1758066471; bh=qsaoSUpaWq
	feihvZLMbkP6PL1UV86xVlfjL5cVWoios=; b=pd+4wDUX19GMdCqD46brCxh+G8
	/2swdZOgWyNq2qnipQFu36SM550gtwQa0kSnKq2AP260xdHK0HUdpT+QOozucecq
	6ZXcHhDzsGb0dL4+cj696Zpp/rK/tRd834e+ZkHiPVUA8RLKncfKfLKOZaIqopbc
	KG701wCQJTNECdrU/50vtHxHFHUuvnvRZUfjXT6Y9jNLNyoDojpA5CJFKwFXAFtl
	KmOJSBnyptGjEjAw+LT+lmkauqX9WdOjBM/bIU2UrwwW6OQKflLJS3EWFAJ8HgiI
	Y0YxwgSptYHmeM6yK2mUvyZywMLDEtLlaNRgpOwyX/jMBO86x5QfKTU8S+2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757980071; x=1758066471; bh=qsaoSUpaWqfeihvZLMbkP6PL1UV86xVlfjL
	5cVWoios=; b=AwtrSVERl4PhGUgB1MeTHbxHZm0sSLVTACLYR7OlSVEEZoYoUqS
	nn1QI0WDMOPGRccZB89amkoddgK88hvqNA8UWWeWn33Yyn5CMf5Ce6uTQXSHSFYm
	SDTcbzxcpVxYjEPKfsqhT3EvN8SMeGmOIOq5HKkzl7LVGetYl+SnMXe3b73YYvo5
	CNO4VXtNbUlAVdMuhDFFD7LSdXdOcB0MF+l8O83mnGmB7+lneGYMjyOGHjNzha8h
	y2ft9sZH3/OFLz6wk+3QOBf4hRwtdtYiUxfaJqmL89jArrz+TjXhEQEiLTVFXBjo
	q7dTLC2RMWkeb+Md3PMGaPYrbMdRP6o2u9g==
X-ME-Sender: <xms:pqXIaEOPzqLpy7v-os91KJbm_Ce5xvso-5SdtwmFfC5XWCZ-Trr2hQ>
    <xme:pqXIaD6vM_wnsP_b-sA5yQoiRVvBEFWXHMih0ojknTdD7U47H-2oLVy3PzNJUcRg2
    GROeUyQ7TuMO_7pGG0>
X-ME-Received: <xmr:pqXIaNM8M8AQ3k--akeNUFORGtqhE7NydLXKmdtTXbIjjGtQVD2lx40R1pdVlmgc--N3cBBVn3kPkhqlpf0bQYrfHahR3s_PX_U4SVcoHaiZFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledthecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pqXIaJkqj8ZVbD4wTDM8EQMgzoSqYrX4Q8DQhugv4MfkDTmUhGR5GQ>
    <xmx:p6XIaMSQGNB1ITqfUP0d7PxjSmcrbHIWcnQQrYaFmBLqdWI_rPMULg>
    <xmx:p6XIaNDDs02elsPUoCNju7a_W0M44cPcduzu7Ge68WBQfmBFCnMPlg>
    <xmx:p6XIaDTDAWRVIOrClsg6raUI2WW-2LRHhjxMUK_zZxkV8r_-cg7iyw>
    <xmx:p6XIaMykjii7a_XyTN9utjtEYA0eOwwM3LB9YwxlL0aochpiEpwnImUU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 19:47:49 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] firewire: core: partition fw_card spinlock
Date: Tue, 16 Sep 2025 08:47:41 +0900
Message-ID: <20250915234747.915922-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The current implementation uses the fw_card spinlock for a wide range of
purposes, which goes against the theory that the type of lock should
protect critical sections as narrowly as possible.

This patchset adds some spinlocks for specific purposes, therefore
partitioning the existing wide-purpose lock.

Takashi Sakamoto (6):
  firewire: core: use scoped_guard() to manage critical section to
    update topology
  firewire: core: maintain phy packet receivers locally in cdev layer
  firewire: core: use spin lock specific to topology map
  firewire: core: use spin lock specific to transaction
  firewire: core: use spin lock specific to timer for split transaction
  firewire: core: annotate fw_destroy_nodes with must-hold-lock

 drivers/firewire/core-card.c        |  23 +++--
 drivers/firewire/core-cdev.c        |  27 ++++--
 drivers/firewire/core-topology.c    |  92 ++++++++++----------
 drivers/firewire/core-transaction.c | 128 ++++++++++++++++++----------
 include/linux/firewire.h            |  33 ++++---
 5 files changed, 185 insertions(+), 118 deletions(-)


base-commit: 931383f161c066ac5fda12035540498931739842
-- 
2.48.1


