Return-Path: <linux-kernel+bounces-830569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B563B9A000
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85494189859D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE602FD7AE;
	Wed, 24 Sep 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="o0klVteT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cOsYNuez"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E72D9EE7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719909; cv=none; b=ZbInlcI+zflumwbIWbKz3NAYD1dTsc6RnS+otFG+Qo6imTkvqn246J5oi2o2/LaOVvTAzaivp9o53VVtqUdyhm//W0NoMC/47ZCsgFueZyU88bForZ7lJOIdWbYXxR8J0GJFg/FOkTTeIAKtz2z/xFNthxDDekwqxorg3qqo4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719909; c=relaxed/simple;
	bh=1WfF27/2t/FCUQj8Mggu/OD+u30RrUHAvn0w96/pjo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/GQR9q+IAlmbmRruoh0u5kQqiDC8Us67kVNUhLZ3xYIVVfIFsqf9Gxfojjh4RsXuxQ+ZO3lx4uhX3Bsw4Xv+WJglJg5PVJj9cFdTifij2GdZqnIJJQ+rhWLs3L8uFGuAkL/3kFodNE0AGcVPs2HUnITh1Sb4I8TQYrt7UlRhs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=o0klVteT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cOsYNuez; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 21321EC0143;
	Wed, 24 Sep 2025 09:18:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 09:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758719907; x=
	1758806307; bh=XThZObXpOx3mRUMR2g5aaL1x6qimlG3yoThumN9ezRA=; b=o
	0klVteTve98rgM5Z3qNkQ8JhqnBC3jveXj0wLuWcaD8b2Yj+JGt6fZB9vh43RQdJ
	CezpVacwGv92ln3Mj2Dswc54h2uqtiub1RT8ok9mxACxHERbV4yXLiXbxdgHfakc
	pMowmK4sOaYuGGbuIyHMrwXRdl2hyalMPKUR9pdk1SDJWowRzwiK3ePSLkfchuIR
	/qLlZivxQOXzBP3sVFzkR6fdQp/+AWvjeqN6Go8JcsbYMxdPOIgZ503alC5zFbWR
	x3k5CleJFlcV+x6BKX4KweqhzsgjCpCk8gLHbCtl+ACE45n26/oi/kdbqLl/pCVQ
	QYNrJHmLT3IYmIlrJYo9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758719907; x=1758806307; bh=X
	ThZObXpOx3mRUMR2g5aaL1x6qimlG3yoThumN9ezRA=; b=cOsYNuezLkClbfaa4
	pQZBag7h0EL2uuMHibIXADLfeK2elBdFigrJhebQqDddMBO/gE4CGImcG9+Up3KS
	3/mlQUpElZ3pSxjvbUu8u6MH4dXOeeWWT3IweFazHy4De6BF0ducDh5MBo4LgXJh
	5FpSQAJmRDzX6+ATYOAPRerf2m/cTvafa+4V/RxT2673vbrquK9QZJXCKn4C9zVw
	+BC8cT/DYr5Q4/MiWtA0YvrPDGLeKnyeinXQefnY8VErBeV4sTXADveN2pLngvb6
	bhw+ZMK8RyVD3ZNCONtxppvvNafr7YGc6I0Gx0K4RpvMMv5gCOuRciyNvo9NDOa6
	/5L4w==
X-ME-Sender: <xms:ou_TaL7FKwYV_ZTzNACIp2iGe6VncLDQmVM4nI6LN5ydv7LKUCx7Kw>
    <xme:ou_TaO0uTis8oPlgKpZSX5XoFfiWYDWHmgl4Vr0BCveGzvvsn2vgZphLhc33u01bf
    omHYrQhQcJ-KIJ1p-YOWwT7DB3Gmqriucf8vghDxH5gR60TRpryVSx9>
X-ME-Received: <xmr:ou_TaKBmtWAoPOHQboTqGrJImHY4mbGlyi8YQXjPROAnZt_5pIIOFuuHck9z944O9Kkzaiq-GUovMMotKZ7nN4jp-BmhHws_KRrFeDe7q5tmlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepjedvteetudfhie
    dvheegiedvkefgkedtleeftdetleejkedvueekheekvdfggfevnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefle
    egqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ou_TaI1diCC1mqUFjaUh7eU982_rHObMQnLtMK9ZnBEO7NqG67bGeA>
    <xmx:ou_TaMs1rb1Q81DmA1IMwAJzkzrmg54CFkgVUc6WTxtUkaUHBVsrOA>
    <xmx:ou_TaA5BCrRTgyvbEQyBFzcWIe8CTuecNIUTBpPahHNKRH7R_aerMg>
    <xmx:ou_TaFJPNjAyFnGt4B5W8_IaUMDYkmaHMNH9pxgAFf1k6hNZ_wylTw>
    <xmx:o-_TaMs21_vHwP37b6c32bPFOvroQc7aGC9_fJs_ZfI6CLA6C8MYq2dt>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 09:18:25 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] firewire: core: revert "serialize topology building and bus manager work"
Date: Wed, 24 Sep 2025 22:18:21 +0900
Message-ID: <20250924131823.262136-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250924124212.231080-1-o-takashi@sakamocchi.jp>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The patchset that serialized bm_work() and fw_core_handle_bus_reset()
was merged without sufficient consideration of the race condition during
fw_card removal.

This patchset reverts some commits and restores the acquisition of the
fw_card spin lock.

[1] https://lore.kernel.org/lkml/20250917000347.52369-1-o-takashi@sakamocchi.jp/

Changes from v1:
* Fulfill cover-letter title

Takashi Sakamoto (2):
  Revert "firewire: core: shrink critical section of fw_card spinlock in
    bm_work"
  Revert "firewire: core: disable bus management work temporarily during
    updating topology"

 drivers/firewire/core-card.c     | 38 +++++++++++++++++++++++++-------
 drivers/firewire/core-topology.c |  8 -------
 2 files changed, 30 insertions(+), 16 deletions(-)


base-commit: 19e73f65940d3d3357c637f3d7e19a59305a748f
-- 
2.48.1


