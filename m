Return-Path: <linux-kernel+bounces-823778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0C8B876D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641BB18927C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735C4274FEF;
	Thu, 18 Sep 2025 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="L2dmJe8U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mdDt1WGC"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6E34BA5A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239694; cv=none; b=KNOgkZE2pb5vAhk7PnBdLnvb2wl8uT7uO2SaqwmoYQhg5uIoo+MCh3pH9C4MCG2YS+lsg8zzONyKQdohDnJRiooQtd1YgnN9Le0abXVpaw6s40xNAh2qgp5ulqEsBZzPyJTMmwtVC7BupN6eLd7kfdfHxZM8/HNZp5IuQ1k24pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239694; c=relaxed/simple;
	bh=NSy/o4ZzRkF6XSr+ZivyDW8rhlDJLXSDsRwo7qhw7zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DALu6QA6VHdqCcnOqDmcrvAlKikw749IJ62uoqhDlMIFQcasw5WLlISb/o2I8mL3ud6lwQTlOG5PX7dL3mAXu3EqJlosEYw4WpRYhJQMDtdbN+X5BiszaEnW8xRcFL/ePjq8YzUkxMW5IX2Swh2fJGRerB+ut6FccflK96ljU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=L2dmJe8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mdDt1WGC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3A527A02EB;
	Thu, 18 Sep 2025 19:54:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 18 Sep 2025 19:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758239691; x=
	1758326091; bh=JXjjbUEqhHDFtZPE4qxfZxl67VIDcJ7T0Luenviwv8U=; b=L
	2dmJe8Um0BT+/9U2qhQxqSez86kh86SfHLxStcFYGlvxWiqFj1deztTmp+qvW+oG
	kkbMOgD3ap5wgczOabVTByNl+tE5cKplNN/OeHgJ7d2U4T32lOQfoPLl10ykjamn
	h9OeaxHQMOxbahwfdJVaECDeo7BdC0ejJH0X/GotK7jhdk6pXnv/T9o6ol9iV3bM
	SRthV4H/lN20w7moVK00IRHISzq1iwB+Ze6jKS9EwdAfrHFGntPWOMunSKJMskri
	EI5bCABaYSq81yEk51zOxeELPk/h7SzNnkAYlkbiJ1/CtSzTIHFSU3/3QdGideex
	dQAv9siljt4bQ+ujGpDmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758239691; x=1758326091; bh=J
	XjjbUEqhHDFtZPE4qxfZxl67VIDcJ7T0Luenviwv8U=; b=mdDt1WGCA+Su6241R
	syfDPSP+fgfwksDtLGY2PH6vrqX8dGnlMplZPvfZ8ZuzMJj1z28fx/gCrxhwgOOM
	owU1IpopgPo2neJrJsmPfmgI0qZzUamL//i6Qx3rCuT17ZS7372JCdk+jwPAjc2o
	y6ovDmhiY4TrQ05dPzCWnWMqvZ3qoSIxvjkIqnvcmlzPPwzKi3fTJIqquZQXOSuS
	FoLVgfI6+duGO211AtsiKgJnAhOaIi2CA7134SS4HDwjjpYcDuCqx1ns7bTGr4tt
	p2mU2mzaI2B9eOt3z0InIaNycAuqJZGhDV+rVKRaEUXSNjQIIQe3QGt5G9eCfov8
	0HMGA==
X-ME-Sender: <xms:y5vMaNnCyvvo4FaxFg_ds3ouViuepLzkbPHL1tD5Fuh7BD6p_A_9qA>
    <xme:y5vMaBxqNhgMvRYLKoG6jfpJzNeajCdWGSh_hDc9_vqa7QwGP-vkhWFXJ0qe_pxFE
    REhCbU_6yJUj7BzH14>
X-ME-Received: <xmr:y5vMaFlB6Ol5Ig56o7q74hM2pPcSEeyJUpW-8s86KdvtRtU2ASUSUADyCT9aW5Bg-MiTWX4nV28AUm8ibqNAzfrhdwSsohyIpLXIOdNK8tFnw0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:y5vMaKd7OopXATFBDZp3aMjIf19MM24K_RIyJYi0qLIPNl5cjyl_aQ>
    <xmx:y5vMaLqnxOcdPH57yZYzxX1PmSNAHN7hRULm1M738Gf9xb2o_079VQ>
    <xmx:y5vMaI6OYn1pZ3Ce67bGcWpWKOepK01dndwaRIcqWrHAtVHla65q4A>
    <xmx:y5vMaBrKvGYXYuv7-kajUSXGpEIS1ftQORq9KM_G3VGRzK2JvhihUw>
    <xmx:y5vMaJLRG-oKs6buMbnA3Ppelr0_32pSdmzJ3_RJV8LHWvtLAGcuip8K>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:54:50 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] firewire: core: code refactoring for work item of bus manager
Date: Fri, 19 Sep 2025 08:54:42 +0900
Message-ID: <20250918235448.129705-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250918230857.127400-1-o-takashi@sakamocchi.jp>
References: <20250918230857.127400-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset is the revised version of my previous one:
https://lore.kernel.org/lkml/20250918230857.127400-1-o-takashi@sakamocchi.jp/

Changes from v1:
* Ensure to initialize local variable

Takashi Sakamoto (6):
  firewire: core: remove useless generation check
  firewire: core: use switch statement to evaluate transaction result to
    CSR_BUS_MANAGER_ID
  firewire: core: code refactoring for the case of generation mismatch
  firewire: core: code refactoring to split contention procedure for bus
    manager
  firewire: core; eliminate pick_me goto label
  firewire: core: minor code refactoring to delete useless local
    variable

 drivers/firewire/core-card.c | 335 ++++++++++++++++++-----------------
 1 file changed, 177 insertions(+), 158 deletions(-)


base-commit: e6d2338b6f3e522872f3a14fcc5e5de2f58bf23b
-- 
2.48.1


