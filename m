Return-Path: <linux-kernel+bounces-815155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E057AB5605B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A432656243A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F1A2EC54F;
	Sat, 13 Sep 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="C+ZDDDRp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeeTkr6c"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE52E2DE4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757761063; cv=none; b=MaYZyC//Iuf6Ls9IDE1crAKEeNCS3buSQNaoEf2faGPIAYm6FLli11cUB0znQULVaPXTErreUiQSJnuMHkQqo5UnsO0eb8jKoHu7uG4rXgW7JZqw8TNKEu/rVtMMgpyywWEaat9FwedTFPxjuEtZmXv7P0sQitXvJFb71B2rnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757761063; c=relaxed/simple;
	bh=CsQGCBsTatedql4lnSrz9vNFBukD1zL3rUYTBMKIK7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qIojAukGyGhyWfD7sgWLg4EP9p2F4K2igxOs3dSzcJ4MWqDkDHiGgABTwGPWnv4PdhUQjHdCIkL04HcEYnoUPQwLiHPnmsjdnb/QeavB0AJeju859MF5ydOoD6AckutHpgtRaWHaVkKpaHPS641VJ+uxWYBNW8gn2S78TLqGd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=C+ZDDDRp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeeTkr6c; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D296D1400124;
	Sat, 13 Sep 2025 06:57:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 13 Sep 2025 06:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1757761060; x=1757847460; bh=Ke1+46Unlv
	WlNxeH+CbOubd1oTFRZM0wqYyrcYtRd7k=; b=C+ZDDDRpUZtvXR2mFqApju+Ir6
	nGIwbSbkF55QoCGNKLx9cN5yHVttd9K6gce1w/8r0x2Y7/bEa7rYrPcdQN/5gxu7
	m/uy/HuPEglfvJvd9TZmZqzd8IoLKm6Odb+5NiXy1tCN0QOZ+O7zqNouap5EVikv
	dVpshgtxEVsKAYqtAbwCdcxKqIFzflxAaFc2H13C8cNyJVy4N65yJuu97RxKZztA
	JBD6hgw5PvMqqbCcHGNEc/2jGN6esYz1TlZjUgzdPHtbsA+sJEdbr6WXu4zQqMw/
	0Nw1C+o3t4M5+jzXX3Oo2y8gvPDE5jtlZgkaqHrGZ76d1sY/AIuxrO1idNTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757761060; x=1757847460; bh=Ke1+46UnlvWlNxeH+CbOubd1oTFRZM0wqYy
	rcYtRd7k=; b=ZeeTkr6cRzdR+EX3FuqwUSr1YdrcxII5DJW7EBjZJsVI6p9o5Uh
	fU/qdZDnantKcav8pECAaT2pONfaldDs0Y7zfkiAuQLRS/t+WpM9cNiqSGL5lbAs
	m0+1cUymarO7SHb1kpXeOmDDOEGg/DqGHvrskBaCI1zarhKqQZIE9W45vKwpNRk/
	n7N/CFnZvjMTwnWszr7MX/rz5dmQUmztMDeVuWIyrkcLF9ythRv2X3AZXP17JAah
	vSdmtM+fh0WtxCeqVsuZaVapVA08oEYIBNUCDiaRGE/S/6v3lmRZ7c4PzUzH+Bbc
	1If4oIGP6FuJBvnd5kt2cBI8aLPU62/Bg4w==
X-ME-Sender: <xms:JE7FaAz19PgKvVG1AM-cJil4hJ5yHFtNEGxQO9YCNhCrdTtWHet1QA>
    <xme:JE7FaNObS01J-ivzeLK2kasGCmzNjNo-OEpx-NwYtLrVSsFdicuHSMjSjXd6Zvzt1
    tBlgkv1ajZrXjn8YZE>
X-ME-Received: <xmr:JE7FaETWTBWEf4ElLeEWoNX0PligF0uOk974fjTutDpKJ_DxlLQHKQL81NxznajFQtELchrpaZLFcBgpB2XkPnSHY3TMrDFA78sP3Pl1znnZog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudejhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:JE7FaLYFfXRVpiXDF0IJ1StzhLS1zqBTez9dUlk_UNQoS6fnjV8dHA>
    <xmx:JE7FaB3q9rXrW9s7XW526_Hdiwt2q5HPWYc2ehQnIIhQMInWJHOadg>
    <xmx:JE7FaLXEsX0OKpDHq05McrmYXZ69CE3j2sjMArJD4Qlz0KNJt6nGrA>
    <xmx:JE7FaLXiEXGyqWEm3EWllr7LmTDqvY7Xp5EVUYhDRoZcJp0qJcqhVw>
    <xmx:JE7FaJ1h3BZ966-uUpAP2nHjzSo_IDoVHTicQgtU1w8-dZrkFJrbbgCh>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 06:57:39 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firewire: core: use macro for magic numbers related to bus manager work
Date: Sat, 13 Sep 2025 19:57:35 +0900
Message-ID: <20250913105737.778038-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some magic numbers are used for bus manager work. This patchset adds
some macros to replace the magic numbers.

* 0x3f: BUS_MANAGER_ID_NOT_REGISTERED
* 0: GAP_COUNT_MISMATCHED

Takashi Sakamoto (2):
  firewire: core: use macro expression for gap count mismatch
  firewire: core: use macro expression for not-registered state of
    BUS_MANAGER_ID

 drivers/firewire/core-card.c     | 14 +++++++++-----
 drivers/firewire/core-topology.c |  2 +-
 drivers/firewire/core.h          |  6 ++++++
 3 files changed, 16 insertions(+), 6 deletions(-)


base-commit: 136d8a6f73fee0686d163dca91fdffb35e25f092
-- 
2.48.1


