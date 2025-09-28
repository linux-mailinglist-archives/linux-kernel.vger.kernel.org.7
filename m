Return-Path: <linux-kernel+bounces-835127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563DFBA6559
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F201899E77
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F2C225416;
	Sun, 28 Sep 2025 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="qPVWc4Rx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ST9zoHux"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E884225791
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759022359; cv=none; b=OcerCoGTBniHmmIXVMd66SlyEYIvgeLig4aQcu6uo4KY2WdXRRF/v0nf917qcuszvTP59sBCBZo0vM65FsJw1pO/OB1dg2JSsk+rQjO8wNtfa+w8VHf9DNmTsf+2751CbrSjltq4STLBA+M/IhFWT8jYKyrZj48FvxUS5HY/MrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759022359; c=relaxed/simple;
	bh=RefFHA/xtSK0kRCRzFzSxqY+FsRtxEJwtqSS/cGYyS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSqYY10z7GbHESjlDqzcGS/By0qHBSmZ6mo13Us70WZ19ml1Iaz0dSwnMdV+CDY3f93G3mjpecmYlG8v7w8prf7CHC290C/YgqqIxYH3f41LwwnLxergiI9Yh0XZh3HJGxVp9SANkFocDYDGhcXu8NRjHnh7uoO2xAwtY88581A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=qPVWc4Rx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ST9zoHux; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 92CB51D0004A;
	Sat, 27 Sep 2025 21:19:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 27 Sep 2025 21:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1759022355; x=1759108755; bh=1TxogxZatZ
	GvNMp5ACuFO5OBpuGGoJOFgQq9sF3nt/4=; b=qPVWc4Rxwj3foYInoPMvyIDL2v
	fdKXNCG1Xw5jcxZV21GdJJ1Uv7/x25vkSYXAaTlENq6AJ/noVpj5zwNepy1j+RPx
	U5lSe6s7Qd+X+FBwN21U85ArWmOTftjZTsTPTLSgJnRP1YbPL1LsXE9WfJOrVBv3
	qW0xb4kgzb/YFqPUqMW2wtLj48aYGG+m/wvJ8NGkiIQ49Kb78q0aV5xK52Q1TIbc
	QDaUaMp7EtFGntE7CwmqY6PXu3kyjOIaKsCa7y4+n45mtpfiQXDGgoJKT1sx28PT
	t5jbyclOfp4o8Vo3PUGxp9KET9FiYcgYxJKRoxpO98AP0kRT0D+0ohrVY4yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759022355; x=1759108755; bh=1TxogxZatZGvNMp5ACuFO5OBpuGGoJOFgQq
	9sF3nt/4=; b=ST9zoHux5r8ZqzY9zvdQ/ZK3/wMmNZqXMK8r2X5ER6EjG+kY28c
	cIh1fyQxIJCQWVop7q4gDgM8NDkpTZJa1LMdfd/SmkoWN6q8dGXFkIL0W3OAj9Tb
	X/8MYGpwgO4UjWwQL73T82Gp/7r9CE1I+yMbKpyltAnvhxsZQI+yTa8okEBFfwTu
	OmVPycgp23EQuUBWQ6I2o9mJH6F/k0V4e1GnDJyzbk9kmoVFTiye9BtYx8Yj54c6
	68p6Z4S3b1pvnVRTEzyRcZE03Noku5hxXbzb66jwotVfU+8JOItbSIPaYs65BsBf
	XQJaqlbUOzjYfOpl7Z7pKBsEhFpPRNkSOtQ==
X-ME-Sender: <xms:E43YaOP_yNH8Gfri-_CUklvjOg0fkCTXHzPo6Xa-Nt4jmH28CvNeGw>
    <xme:E43YaEtpiZCHLGvyVqYCSSlv99xdHTlUl8v57TPZ2WlWM0HDzccpeqqNeFG7hs0DH
    9I99B0Vz8Y2mcQ3RH1TJdMgLoe1T8GLpcXyKrP45mHInxY1Ya5D1ns>
X-ME-Received: <xmr:E43YaIWyoISWLjbNA-hirCGGYXKiydnnfLFWfrSLj7rfvAGkk13Zyguj92ssVhL1kwfmYHKEskScWh8NM9732TqKA9m1meoCkVW-Vi3TDhx_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepgefgheelheejieelhe
    evfeekhfdtfeeftdefgefhkeffteduveejgeekvefhvdeunecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqd
    guvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhkphesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:E43YaMsB_ctZC1mFyxfaIRhXpwSV2CUAav5U0WhvJoUtdo9n00dwkQ>
    <xmx:E43YaEUvTUnab3g_BeJbAVK2gUfoLTOFuwLWKNImY1O2Pk40meARKA>
    <xmx:E43YaPneH1t_4_RwV5mAKR6ovIJD6kEa_DQ2iHvLCS8v9vrL2YOPGg>
    <xmx:E43YaNazW1gQOFOtX1knpM0-pgWm4z8pToDtCxWrhkLpqiB57GjqHg>
    <xmx:E43YaInkIQf9fBKupRpNruyYw9_dbk7t2Xvqb62D9bp2zKthVP5W6HBo>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 21:19:13 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] firewire: core: fix undefined reference error in ARM EABI
Date: Sun, 28 Sep 2025 10:19:10 +0900
Message-ID: <20250928011910.581475-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ARM EABI, GCC generates a reference to __aeabi_uldivmod when compiling
a division of 64-bit integer with 32-bit integer. This function is not
available in Linux kernel. In such cases, helper macros are defined in
include/linux/math64.h.

This commit replaces the division with div_u64().

Fixes: 8ec6a8ec23b9 ("firewire: core: suppress overflow warning when computing jiffies from isochronous cycle")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509270428.FZaO2PPq-lkp@intel.com/
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 2dd715a580ac..e67395ce26b5 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -30,7 +30,7 @@ struct fw_packet;
 // This is the arbitrary value we use to indicate a mismatched gap count.
 #define GAP_COUNT_MISMATCHED	0
 
-#define isoc_cycles_to_jiffies(cycles)	usecs_to_jiffies((u32)((u64)(cycles) * USEC_PER_SEC / 8000))
+#define isoc_cycles_to_jiffies(cycles) usecs_to_jiffies((u32)div_u64((u64)cycles * USEC_PER_SEC, 8000))
 
 extern __printf(2, 3)
 void fw_err(const struct fw_card *card, const char *fmt, ...);
-- 
2.48.1


