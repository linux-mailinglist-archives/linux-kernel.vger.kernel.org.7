Return-Path: <linux-kernel+bounces-778724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17FB2E969
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5391A68817D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE021C861B;
	Thu, 21 Aug 2025 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="PgGioA74";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sj0OllW5"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6246447
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736227; cv=none; b=FDujp16KqKthF2ZhIaiHLxFZ6lI5HMlKt6RT3zVZvHZZzmF/GZoqz0Io8GIJI/Nj4EFan1CZYwW5ej7W6X48MvOmzRIiuA2bzTnGMr1jmtsTPVuc9mpcOtEI7YxsR5Cs948KhjDuzgs14HddTa8so+DT5P5WteaYhSDSJo5J1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736227; c=relaxed/simple;
	bh=nsWmaCHgXjoyO3s7DHSgGWeJKpmrr1gkOMqUOatFJ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLqy1lPMNFvhdvQAgPTJeizu4AoYnPqOLEdkQwTuSfwgXDa8Uu2zm7ws1V0S6TVGGWUSRrg70oCjBLiGp5dOWGUklwLGHXlraW981dFiq8JCL1ha/rVj1Jx+Mwpw8eXOZNQrbNZlD298gE7bRpbvqjUlCXy39UnS847HXhK341Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=PgGioA74; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sj0OllW5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F9DDEC012D;
	Wed, 20 Aug 2025 20:30:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 Aug 2025 20:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1755736223; x=
	1755822623; bh=q8zu4VWXyIevjukySC25gkI6lGHvLvrvS0El5rB82bQ=; b=P
	gGioA746gOHDK6lr7f9AxhREk2c0WjEBv2uVmfoX3ytkRxeQ4IcqNz+57DvXJjlE
	ucIiNOHLt+vBWvXvLxdc4ImtnHPS/rSuFsz9nmheGEDnfHPnHSEizP4kn8ElarCf
	uvsKUZ3lgRFVVD/En/ZwV8Xgb5h2qRzWQ23R3Vn5Xgwva190rWGeRcAN/muc0LvH
	kIa/iQe+zDbFHfs+9k2TAJE/CgzqtQosWQ4Ihvfb09kxAl9l4FoJfQE2EpyG6i85
	7tR3Uvdx2dB4v7sNiWmTZalkEdqbfcNIT7NTXp+xDEMIQsH5nI59raoPqNSXayDH
	brQSFlztfmayazfqnhQBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755736223; x=1755822623; bh=q
	8zu4VWXyIevjukySC25gkI6lGHvLvrvS0El5rB82bQ=; b=Sj0OllW5zy9N6GScC
	2QUxt9BQy60pk5+aCSHpn21QTJKbDftSk1YxZmcmTiPbDU1PS7jPRm67LL4Ff9od
	4fZj+ExdHrII6zKY/qhnlYu3Mk59epXsHes3Tc1S6Sr9p7bXmj04Mx/4u+BoaqJ7
	AaO4fV5yAIvA/yDEpChy+cwFagj1XME8nYTdedgqCMCbY3DbuHahR0OFir7LsnDc
	X821dkIOBmx1bmjtuRwwUZOCNEeQdT6kexFzc3rqXyPmmLKqRFA405WiUGl/sFQP
	/RVuZRKTZkknvGEplRpKHxmAFI2LBDDs+dZMK0cu9PernNEaiCunwQKG6MPoKP50
	DFdPg==
X-ME-Sender: <xms:n2imaAZyeblFLCOw_7MFp8msBm0g-1L3ZLXjGIGkOamhcLp8RmFLKA>
    <xme:n2imaEVudVC35FLGxGe4E53cNrakGwQledP-xBYVYRyhbHFAoWH8s6vAew0JGF2AA
    LWY3Oe-bKiV1WdvYfQ>
X-ME-Received: <xmr:n2imaM7cRd4RdBR5eGCM53UD_ZBE5Vt49pOO1XOdlQPCvaFAIfSJQFWAy_-v-Th_t2PSMQZvHSaH_T1lVYHok0X1IWUYrdvhjDIOhQPy_5-E4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgjeeuvd
    fguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurh
    gtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n2imaHjKnHWxg3_ViRLxwm08iRoTcn1h8ZL9fTKRJsRiqE7wj024TA>
    <xmx:n2imaLf8G1rdDVm97YrnwHStiJQeXMg_kxRVrrwuf4XW-pWRxS8fNg>
    <xmx:n2imaEcMKWLcPFFxGBMzPPXOlvEhSQjZZqNjmw7KHw9JU-leXPAY0A>
    <xmx:n2imaN-HwHim1vA4N2sz01OmO7VFp5Q8VljkvPCbIJp1XpRPX3B5KA>
    <xmx:n2imaOf1fk99YAcJK-hh4VNFo2MUMftIvTWn203WrM9beYHYde8cL0Ru>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 20:30:22 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] firewire: ohci: remove obsolete debug logging for IRQ events
Date: Thu, 21 Aug 2025 09:30:14 +0900
Message-ID: <20250821003017.186752-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250821003017.186752-1-o-takashi@sakamocchi.jp>
References: <20250821003017.186752-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A commit 0d8914165dd1 ("firewire: ohci: add tracepoints event for hardIRQ
event") added "firewire_ohci:irqs" event in v6.11, which can provide
equivalent information to the existing debug logging.

This commit removes the logging.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 5d8301b0f3aa..d3ed43f4d0c3 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -395,50 +395,18 @@ MODULE_PARM_DESC(quirks, "Chip quirks (default = 0"
 
 #define OHCI_PARAM_DEBUG_AT_AR		1
 #define OHCI_PARAM_DEBUG_SELFIDS	2
-#define OHCI_PARAM_DEBUG_IRQS		4
 
 static int param_debug;
 module_param_named(debug, param_debug, int, 0644);
 MODULE_PARM_DESC(debug, "Verbose logging, deprecated in v6.11 kernel or later. (default = 0"
 	", AT/AR events = "	__stringify(OHCI_PARAM_DEBUG_AT_AR)
 	", self-IDs = "		__stringify(OHCI_PARAM_DEBUG_SELFIDS)
-	", IRQs = "		__stringify(OHCI_PARAM_DEBUG_IRQS)
 	", or a combination, or all = -1)");
 
 static bool param_remote_dma;
 module_param_named(remote_dma, param_remote_dma, bool, 0444);
 MODULE_PARM_DESC(remote_dma, "Enable unfiltered remote DMA (default = N)");
 
-static void log_irqs(struct fw_ohci *ohci, u32 evt)
-{
-	if (likely(!(param_debug & OHCI_PARAM_DEBUG_IRQS)))
-		return;
-
-	ohci_notice(ohci, "IRQ %08x%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n", evt,
-	    evt & OHCI1394_selfIDComplete	? " selfID"		: "",
-	    evt & OHCI1394_RQPkt		? " AR_req"		: "",
-	    evt & OHCI1394_RSPkt		? " AR_resp"		: "",
-	    evt & OHCI1394_reqTxComplete	? " AT_req"		: "",
-	    evt & OHCI1394_respTxComplete	? " AT_resp"		: "",
-	    evt & OHCI1394_isochRx		? " IR"			: "",
-	    evt & OHCI1394_isochTx		? " IT"			: "",
-	    evt & OHCI1394_postedWriteErr	? " postedWriteErr"	: "",
-	    evt & OHCI1394_cycleTooLong		? " cycleTooLong"	: "",
-	    evt & OHCI1394_cycle64Seconds	? " cycle64Seconds"	: "",
-	    evt & OHCI1394_cycleInconsistent	? " cycleInconsistent"	: "",
-	    evt & OHCI1394_regAccessFail	? " regAccessFail"	: "",
-	    evt & OHCI1394_unrecoverableError	? " unrecoverableError"	: "",
-	    evt & OHCI1394_busReset		? " busReset"		: "",
-	    evt & ~(OHCI1394_selfIDComplete | OHCI1394_RQPkt |
-		    OHCI1394_RSPkt | OHCI1394_reqTxComplete |
-		    OHCI1394_respTxComplete | OHCI1394_isochRx |
-		    OHCI1394_isochTx | OHCI1394_postedWriteErr |
-		    OHCI1394_cycleTooLong | OHCI1394_cycle64Seconds |
-		    OHCI1394_cycleInconsistent |
-		    OHCI1394_regAccessFail | OHCI1394_busReset)
-						? " ?"			: "");
-}
-
 static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
 {
 	static const char *const speed[] = {
@@ -2226,7 +2194,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 	reg_write(ohci, OHCI1394_IntEventClear,
 		  event & ~(OHCI1394_busReset | OHCI1394_postedWriteErr));
 	trace_irqs(ohci->card.index, event);
-	log_irqs(ohci, event);
+
 	// The flag is masked again at bus_reset_work() scheduled by selfID event.
 	if (event & OHCI1394_busReset)
 		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
-- 
2.48.1


