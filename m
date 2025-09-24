Return-Path: <linux-kernel+bounces-830562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F971B99FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C581700A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD93002A6;
	Wed, 24 Sep 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BvMnjJdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPcd+TMK"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03022BEC3F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719507; cv=none; b=IMN7dn71SAL3PfWdBTz1s53cjN4rNYLV/JaOeIRY+DhKCfmeDH0qDZOtGe3Lx6TLCZJVG9BP/hNbFmY85lMdvICS1XEfF5P3465ISjoYr2Pw5MLKJoWL0JB5mBpFJbXWAguNZNZ11huztirGJymYlcWyTU+hx5EM6S64FWFjdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719507; c=relaxed/simple;
	bh=EdexPTflT22Ftp6zl2u0hS2bPWc+eqW2DuTW2elpvG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMZVgjP2be6tDiszV7HIxbaCFtLZWVWpD2ocRDunkUYm0HUYybiijBcA7ptmZwM5qSICrIVK1V3hye1clx8HbfezdS9Ag2deK9qGviVUUTwc7V1ZUBnchP8tsfrUYULHiZ8uAVC6Ry4aKaGi/ouJvxof+8mn3bJV+Zxp24z83nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=BvMnjJdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPcd+TMK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 12602EC00D0;
	Wed, 24 Sep 2025 09:11:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 09:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1758719505; x=1758805905; bh=wYx2HdEIXg
	FlbgpS+qiqZSNU/sf04pXjiGxuBrpjJ/Y=; b=BvMnjJdASXv6BaiiWFBTmO6GwU
	bcpPYuN04WJUVwAZoqo8wqXckpVEM7uNInUZXTEPTskz0NqKKc+jfjfZloCiFOAG
	WRn20nXWRT6D9/78ufRYhObE4ktHj+JKsUEn4cfQeqFTGM3pyx9Xr7xCUrjFKOSW
	ZOPpu6T06VJzQ+/QatFQpdYHvKL0AUrVIJsJC3w5/6SInGR1ZrzDBncjVryzbPpr
	NSzoWc7GFJtNOtRC2RSjOFNA1jI0G3M+fA9LYxkMpfB/oF29Om5Lv5popct8aSLk
	YPw3qLurVjkxxM0NFRhtoQrORz2LX8mHdW5uANZXwXNJPa8lMWFucagh8vKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758719505; x=1758805905; bh=wYx2HdEIXgFlbgpS+qiqZSNU/sf04pXjiGx
	uBrpjJ/Y=; b=hPcd+TMKtvHJXz/rqV78GS5RxZYLoSWbHdk+HTzaAgmkSbHL+jU
	PXt+1R3Mxiic1WUmLm3vyGHpdAzSdBDT6s1WUXUqVeshcDh5pKZjt8QpEUwk+kmv
	ZsQ16Dbhpi6kkILsKbyau7icpETczYboiVI7qYrrR7T6ou2ONtq0omSiIhB5r+dO
	oODfisje/h0JBiSJKL30L1QquuMWE2tt8nEbv2RdnfWqTyp69PdMobl5JdSxi85q
	TK0j776ExdtPUmHsnHfGfgIMMLs+rXF4ayqr47TVRLO5aZaHjZGDYoGU/Ra3YgSC
	+2w6yTyiRVqKpZdPYMmEYZATHUb5zZENApw==
X-ME-Sender: <xms:EO7TaNCiysv2pVwt2WetTjSSLdo_5FFmktvGhfFm1tsOayBFUt7ydA>
    <xme:EO7TaDS2GDTpSgK459gTze8fEhSlupR9sLRTcev30qdU2iZ0zeqLK4DZRYT79G-Nd
    zsU8Qbym2-g9ls_Wd0nt-DzT_Aj-PS56mRYRpeMVN0TlJ_oDj9JCZXj>
X-ME-Received: <xmr:EO7TaLrHidyGsRsFVgEwP8TeT3MBswlsi6O79TBlPUIHRnbbtYc6ctmsaPuI2PZYz2JmeSOj2RvOsixhOHPk7SD0B4oF8rCQUtSnfjVorvVK2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeilecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:EO7TaFynJCZc2PqLjWgEGcAWDhyz8Nz_CZx0voGCnaqNYgA31sZCMw>
    <xmx:EO7TaAL0mqqaanDfvBPfffjNoSmezNwttM1f_a24Ca3RknDttuth0w>
    <xmx:EO7TaHJxOuy1WZqi2fKEC2GkqAwdz-NyrhFOVMdEB3j7pHAIMo4FbQ>
    <xmx:EO7TaFvH0PVyz9RmXqESAojjW3MdhepkXlRabjZcPuPaxiYZ5M0Vgw>
    <xmx:Ee7TaJqmSD82YNegRS2wXwLG7Scgyo-oO6CvhBf1w0ln5vMyOk4fioWU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 09:11:43 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] firewire: core: suppress overflow warning when computing jiffies from isochronous cycle
Date: Wed, 24 Sep 2025 22:11:40 +0900
Message-ID: <20250924131140.261686-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The multiplication by USEC_PER_SEC (=1000000L) may trigger an overflow
warning with 32 bit storage. In the case of the subsystem the input value
ranges between 800 and 16000, thus the result always fits within 32 bit
storage.

This commit suppresses the warning by using widening conversion to 64 bit
storage before multiplication, then using narrowing conversion to 32 bit
storage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509170136.b5ZHaNAV-lkp@intel.com/
Fixes: 379b870c28c6 ("firewire: core: use helper macros instead of direct access to HZ")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 7f2ca93406ce..2dd715a580ac 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -30,7 +30,7 @@ struct fw_packet;
 // This is the arbitrary value we use to indicate a mismatched gap count.
 #define GAP_COUNT_MISMATCHED	0
 
-#define isoc_cycles_to_jiffies(cycles)	usecs_to_jiffies(cycles * USEC_PER_SEC / 8000)
+#define isoc_cycles_to_jiffies(cycles)	usecs_to_jiffies((u32)((u64)(cycles) * USEC_PER_SEC / 8000))
 
 extern __printf(2, 3)
 void fw_err(const struct fw_card *card, const char *fmt, ...);

base-commit: 19e73f65940d3d3357c637f3d7e19a59305a748f
-- 
2.48.1


