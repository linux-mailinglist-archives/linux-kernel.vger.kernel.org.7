Return-Path: <linux-kernel+bounces-819767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BACAB801BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316842A5891
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52761FDA;
	Wed, 17 Sep 2025 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="mCvSAdwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWU1nGRW"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C7634
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067434; cv=none; b=aCsxI2cg/sBpSXSsn/1VL5hXPCFpAqu0uYToMAqV5oM2GX1883ei0OJRqDvXoajxzWdfssuTyR3mdmLXQsIgARIxnmIsTwMCwF0VweYBe5Z6B4KDf9buz+MkNBRuJudY+5kbVuFfadW5TYkrJOE5mtXFuMzE5hltocJKEH5Yq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067434; c=relaxed/simple;
	bh=++y61Bpiv7Edw263OOZp0o7TFrOwRUTft8Yj74JeZbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cl3pRccQ8VYfL7BB9hs71bCHAceDmiZ0Xj0HB1+V4ASj9okl8FVq6p/Axurugm1BXf9VDQmpZmjElhme8hNmtmYnr4x8ACKfVumTfdXGT6/60w/YhkngJoOiVjOfsjoq3qSfoFlhEYFEIAY0U1oD1LrNPQeLMvfeZPa6Sig/5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=mCvSAdwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWU1nGRW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4508D1D001BB;
	Tue, 16 Sep 2025 20:03:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 16 Sep 2025 20:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1758067431; x=1758153831; bh=lAtbokD6hX
	mqQ1ZHRl3dNvhzvAtOyz0DHK3MaRgY6AM=; b=mCvSAdwqFLcKeKVBKSWPSKhJQI
	PckNgn+bl11efE/reWEmn9NEfPBoQKcrryQdb9kETP+deuq8AQYZ+CT5Tp5Ltj9L
	USNnT2aAUEYtmE0T423oeVTiWrlpdor92IacWwhBK+dk/ZP0snzydG+uPJUGbKIJ
	Lk4rjWRrN0NDn1NYk3BJs9O9VZXQ/ze79Uf2gRoT538BLmsz2M+O1IV1R6yWonmK
	YYmzoBp6JdtuCpvNLSN/NjJzwFfVWHKA4SY/w73mtYaKgUEljeNjf/3bhj1/Y9ni
	NvLlRTNT+yxCHxt0sf/a/PAYobgN3bhQuknrQe72DEzQvDsBRp/yL+zdTGGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758067431; x=1758153831; bh=lAtbokD6hXmqQ1ZHRl3dNvhzvAtOyz0DHK3
	MaRgY6AM=; b=ZWU1nGRWga8oR6MPKkkClc1hmPc2FF2sK11A2AqXnqZBYhwOJNP
	a4wIaKFMnqunF8pVE01EchDIQ/gzYg1TwUsoGxjZ2uArdbdyJ77+0kZ+LXoykb4n
	l+vs0fTSrJ4SEZR3o0j5GSOv0QfSWdtZquGjupWaF7m+hWib4xUCeC8klrZH9H4e
	mSurxWl3FlRIMbTibKj+MkICxVn1yp6pr6QVIEOIYOVcNfulUBt2a0W+DdpbbUJ8
	6hu7dWjFNDW2XgMgxQ5JiqV3ssqlwIXi5aeZ0aSr4YNZVkp/rqgcEA+uPXarZIqh
	EefrGmq0FUmHRN1RZZOk8Df2I6HQmzOI05Q==
X-ME-Sender: <xms:5_rJaEodO2REVcAuxa2YDaTfxZy375ZmXMd0iNG1SYN09o-AOCxPjw>
    <xme:5_rJaDlyet8qcZekTIPFyVB3KJdOLK4iXMYnrLR5XmMbf8XGZllCodfEN4vFhDcEU
    HOHrujgVEQkMsJDK54>
X-ME-Received: <xmr:5_rJaLLD5YFnhsm5YxL04ToHBZAY2HZQ50W8vIOBP0hsU8pFImUsraNh-LeLI5Tf3oaXI5CpYGsEnGib8cImbZp_YPfFHykslRBk9VnS8w6JJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudeliecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:5_rJaIzxUlzGPB5w8_7LEH2a2PCt7LWBnyadfAm4bAuS0CGcXHLy3Q>
    <xmx:5_rJaDuYNptMqipURH9m1PDxUEix_IAEJbjrNNbhjYUTbMUCZ1s8LA>
    <xmx:5_rJaHvb5dfj2PUI7F4DSQXWY42EkhAtULq_IMQUIFeDowFz0skl2Q>
    <xmx:5_rJaAN5PViHcrhT0YSHAfEAErozZSBehgQHRMGPk0WYOvJQZb_C8Q>
    <xmx:5_rJaEv2nRplGbEpIqRBLOiF9-qw7TZS2VpBI3LCZ9UL4dcnJmyWHhML>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 20:03:49 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] firewire: core: serialize topology building and bus manager work
Date: Wed, 17 Sep 2025 09:03:44 +0900
Message-ID: <20250917000347.52369-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Two functions, fw_core_handle_bus_reset() and bm_work(), acquire fw_card
spin lock, however each purpose is different.  The former function manages
to update some members of fw_card, and the latter function manages just to
access these members of fw_card. This reflects that the members are valid
during current bus generation once determined by the former function.

Current implementation schedules a work item for the latter function under
acquiring the spin lock in the former function. This could causes the
latter function to be stalled by spinning until the former function
finishes, depending on the timing to invoke the work item.

This patchset suppresses the stalling by serializing these two
functions. In former commits, the former function is invoked by IRQ
thread, thus sleep-able. The former function disables the work item
synchronously, then acquires the spin lock to update the members of
fw_card. After that, it releases the spin lock, then enable and schedule
the work item. The latter function is free from the spin lock.

Takashi Sakamoto (3):
  firewire: core: schedule bm_work item outside of spin lock
  firewire: core: disable bus management work temporarily during
    updating topology
  firewire: core: shrink critical section of fw_card spinlock in bm_work

 drivers/firewire/core-card.c     | 30 ++++++++----------------------
 drivers/firewire/core-topology.c | 11 ++++++++++-
 2 files changed, 18 insertions(+), 23 deletions(-)


base-commit: e0cda0dd12e08ecb8d26b8d78dc63e67e7069510
-- 
2.48.1


