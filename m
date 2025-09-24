Return-Path: <linux-kernel+bounces-830528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CD6B99E98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C854A17A9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A14304972;
	Wed, 24 Sep 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RRuTB5pP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQWJlbtV"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E82FCBEB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717739; cv=none; b=nOFlAPE05P8Ib27XkNMi/1mT00NkoZTf/040h0Ke2Wj9GYBJa5NU3WnRk3aOK9lbBBjMBeLMwVtztJmLqrbYU5in5YYnVWjGCPEXDqDGTPNDgYORb/zjeUZQcWRPJGHEl1C2kwTJD+E62/hJl9lHKhmxFhq0gek4XLG6cq5BpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717739; c=relaxed/simple;
	bh=BdNmYy2YGhL4+QWcMxhKCvTFtnl3Izi5wUp1zTpqgs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ywve5P5SC5d3Wj8rfuaASY9niAVNGFHcI+ztUQioxM3KqrRqkbXj23MY24BR52IroXn9/5O5O6+bwzvR8zkZP9jpWEQA7b/7JwLG1IF5yGjbkFQfWYcTFZ6/4vzi75tllzBrGu7jl4LHQJrWFnc9gBYjWA57VAePEEW4w0aUt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=RRuTB5pP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQWJlbtV; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 158D714000B0;
	Wed, 24 Sep 2025 08:42:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 24 Sep 2025 08:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1758717736; x=1758804136; bh=9MKDNSErEC
	CFY6ABmDdtI9ovPxbnXJPL/ZRBrEEvqgw=; b=RRuTB5pPDxO9X/b6L02DZOeePD
	NcalxzUiP0SHcHkN3DawMnrOkqmZp0PVBrzCKYsoKL3ToMat6l14b0pFFIE37Xje
	XN4J2QYFI0qvM4vaigrW+UlOeJE1ha+tOwAqO/hJvwD5Mt1qii1tNWpTurrQvC27
	2u9fzNdKX/DKtGeqSqX2NFql/LREkMwjqV4K1OcknGr4X/XeRNtLeRpr0i6kozZW
	0u2slsT12htuiUrnqppSrZIfVAiDuahHb8sb5arPM/ii43gGPDxRCHxFFzEz3IiS
	h/JKOUZxueJFSF3OBdGH/oSp0u3HRP0Ln/la60XEktlsXNzpx3BVzyCxlQrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758717736; x=1758804136; bh=9MKDNSErECCFY6ABmDdtI9ovPxbnXJPL/ZR
	BrEEvqgw=; b=hQWJlbtVayZ/ivETxim5mGTHXqcAQV92s72C6uq2GIK2chD0KcG
	Egw/NxgXKbtCJYDM4XBVUowp9hqwfcin/wHzzlZw2jFxCwYNQ67PL4QlBi++Cp4n
	FdifHedWHehkG5ds3GK8qne2GDD6OAblw/72P9SK0KhVrifjjxtFm6Ef7dbnwrj2
	rDWY/TNXPcYVGrRxTRHoBvDNT4cCxMJ83Q87VOfS6o5jHWEKge8+RH8kQQPcJ6FH
	hsgTTynqoIP2v0+E+7k2mO24HQfHRB/c9YegiWhJWSLNMOUL/vsGUkfIdDgUR7Db
	hxXlS6N5QPB1ra+ZgfRX4cTIqdHp6JVWwIA==
X-ME-Sender: <xms:J-fTaJ4AtGrz5VteXtLjpPORnA2PXEcGwceuVSovBge9E0fxA76fEA>
    <xme:J-fTaE2AtOQMZfqCYpa3mRzns34SR4Q5t-Ch0nkXzp700FKtHge9qGKKdV6R6vBes
    M0qLDiKS6xKpoq9ScOZ78gT8fn15DPWL0UX6RZd_AeU76QyprRLGxQ>
X-ME-Received: <xmr:J-fTaIBM4oLqaBuYbTEiVDAZBtXvRaOENp7wzE78LOt85bFvMURGjfeu-FAuwqH6ANnlxBmL7KclDrkPYrPi3nWuN3ENIREluUgG0tDFfDv7Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepgefgheelheejieelhe
    evfeekhfdtfeeftdefgefhkeffteduveejgeekvefhvdeunecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqd
    guvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:J-fTaO19rS4z6z0ZhdOROikHSZe3nbLf_jp5la293-dyt6NUtK0m_A>
    <xmx:J-fTaKs-Ejc8MnXYx2eQGqV_8AJm5H8WqeLvbHZ8jTR4e_k1ljDsSQ>
    <xmx:J-fTaG5IiJi7SauUwYoeISM2t6PSl1f1590HCKL-0Z486nLo8tf60Q>
    <xmx:J-fTaDKz_8C8veirTFO60pLS1l4DhsFA6lrYhPHuTCrpPBSpY_zTEw>
    <xmx:KOfTaKswu1QQ7ZNrBAqGlBYzZQzQX8qtrPNObamy4lP8QWkDiH5ETe7o>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 08:42:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firewire: core: 
Date: Wed, 24 Sep 2025 21:42:10 +0900
Message-ID: <20250924124212.231080-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
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


