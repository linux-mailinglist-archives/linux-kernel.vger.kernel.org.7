Return-Path: <linux-kernel+bounces-754415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CC4B19408
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EB73B8B6A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B88A26A087;
	Sun,  3 Aug 2025 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="SXZBtoE2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nc665JG+"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896E2641C6
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754223629; cv=none; b=eKo1ozhXFgnLdRIXrn6VjmnOUjtRdvDjsMFY+ldOFz/0vHgWmgpWX5dm8IHMBdU7LgSic0DZq7f/uIIyjrZWnoI7QezPhOIA1IMzm4aY1o8UH7DYUKKo1Ipfl3t/AXYEYCu2WMpqppo+J/EyDuuO1h4M8rKgq7fwKPRhqmWzavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754223629; c=relaxed/simple;
	bh=4Mjl2grO/2bl1y5sh2vtEhDDO1Bj2z8wDS98ah5dKCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUFdS5RRNCXb4VkS8gPzQZnXSPxk2r4WBPYho5/RnNvXepk3+1J26yhjmXkQNEngAvqPOBZcpNEyRY7x/MzLWPsGJUrfncauTyJBMKkuq4duofre9zI8rT1HpX7s5/2jGx/i+jy/tZYhzpzec50wyFWZSTKLEHAt+NG3jy0mrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=SXZBtoE2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nc665JG+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C70DD1D00051;
	Sun,  3 Aug 2025 08:20:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 03 Aug 2025 08:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1754223626; x=
	1754310026; bh=0wTs9lEFAXHwGLgW5F3fT9Ue6CFiDVXylrQSLEDJF5Q=; b=S
	XZBtoE2P06n5pul5xgkbVgKzh346tEB0dNZwnU2gZXpBM4zKcolo+kAp0fW8rXuC
	L+iu+wBFYzHxRebM3kEqCa0necdFU6q+X+7uz7kpGR4b9RTkKZeAh14z1BLNNAWa
	stTacs/tBO1SMRLnYLNyS2RUoVtne7kidDSWqH6yYNGH9syKZF2N+gyGXmunnsac
	SfFCPUFEEX+BuFn3fhEjFKwv4hsdfbWKrzPuJZRiFELCD0avUP7MkrhJ1VShCi8u
	9bN/iK38oqs2Nf9fFsUafwKjFiEW52Zyj81Z1pQ0WgXlCcE2RDd2+r0gTwa/Rgz+
	3B+9xX32pi0LwohDacxZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754223626; x=1754310026; bh=0
	wTs9lEFAXHwGLgW5F3fT9Ue6CFiDVXylrQSLEDJF5Q=; b=nc665JG+ObNYJmP0m
	rilqml+2lwXXx0RrPNn/lJZHvWwc6+glGBcnbAJnyPQoSZGCNHV0/dXPmdup/r5W
	gHKywlzqRMVBq+YyUUSpDN5BjivrFS/i9x+tWlvxITF0ZzkeuFPvzM+yjTI9/3Lc
	JgBix7SaZXIFgCnuhDCMXd1DQ5Gdr2wlBqtQtMo2QMLFjx0QimvFH/jK+Jl8BJHg
	s/7OqnUI7BQecrFBANmU9zkjJFKmVEFBELme/I3CBOtZkeBoDLzDX4+ffWHQMXGJ
	bWaQqr1dMwf7xysmQAVe8NCy1xbZXS/ZaTI2pj6c1qZv/4Mid0iv3AQmm1ZUoM3R
	ZkVqA==
X-ME-Sender: <xms:ClSPaMA1EwxBIo4bjo5F1us7Vf9bzdhc5tP6gQqBl_6WgBp8jl1dUw>
    <xme:ClSPaHfgPl2-OKQ0Pm-g56hsXPfAj8PDtYSTHQQalkeRcRwBrbkdS7S0qReu81Xtm
    Dj8wmsc-9K_t3I71V8>
X-ME-Received: <xmr:ClSPaBhovO63JTATgfiNVre6CoB0hH1OeoyDxHIBuxPuFaQv2D26zPArBZ6Ctd8TGzgVlLzdZGtqfWmFwb5mQgqMyfoclXwyDVmxkhL3BK7C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdelgeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ClSPaPqUco28fRggWyja7YC5xrdHBlZMPaWyi2Uc0RO2crhy4G3LcA>
    <xmx:ClSPaBEC7P-uYNs1mMolY3ebUPBb3L0ChdfA-8Xf4I-ERvcVXP2NDA>
    <xmx:ClSPaJkvgtuyWgEcTXvJn4mS6vxkk1sJlvCtI_v9MYfM7yzhaO71rA>
    <xmx:ClSPaMk9COWv02RwotSiWMs7ZW-hCcVLP7pkIBW7DF20jzSgZVFZGw>
    <xmx:ClSPaPGWkwb7DpigS2hW7pH_VWKzhcLDXRZxZy8rjQGN5f3HsQgP6BUR>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 08:20:25 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] firewire: core: reallocate buffer for FCP address handlers when more than 4 are registered
Date: Sun,  3 Aug 2025 21:20:15 +0900
Message-ID: <20250803122015.236493-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803122015.236493-1-o-takashi@sakamocchi.jp>
References: <20250803122015.236493-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The former commit has a limitation that only up to 4 FCP address
handlers could be processed per request. Although it suffices for most
use cases, it is technically a regression.

This commit lifts the restriction by reallocating the buffer from kernel
heap when more than 4 handlers are registered. The allocation is performed
within RCU read-side critical section, thus it uses GCP_ATOMIC flag. The
buffer size is rounded up to the next power of two to align with kmalloc
allocation units.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 36 +++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 7a62c660e912..1d1c2d8f85ae 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -960,7 +960,7 @@ static void handle_fcp_region_request(struct fw_card *card,
 {
 	struct fw_address_handler *buffer_on_kernel_stack[BUFFER_ON_KERNEL_STACK_SIZE];
 	struct fw_address_handler *handler, **handlers;
-	int tcode, destination, source, i, count;
+	int tcode, destination, source, i, count, buffer_size;
 
 	if ((offset != (CSR_REGISTER_BASE | CSR_FCP_COMMAND) &&
 	     offset != (CSR_REGISTER_BASE | CSR_FCP_RESPONSE)) ||
@@ -983,13 +983,38 @@ static void handle_fcp_region_request(struct fw_card *card,
 
 	count = 0;
 	handlers = buffer_on_kernel_stack;
+	buffer_size = ARRAY_SIZE(buffer_on_kernel_stack);
 	scoped_guard(rcu) {
 		list_for_each_entry_rcu(handler, &address_handler_list, link) {
 			if (is_enclosing_handler(handler, offset, request->length)) {
+				if (count >= buffer_size) {
+					int next_size = buffer_size * 2;
+					struct fw_address_handler **buffer_on_kernel_heap;
+
+					if (handlers == buffer_on_kernel_stack)
+						buffer_on_kernel_heap = NULL;
+					else
+						buffer_on_kernel_heap = handlers;
+
+					buffer_on_kernel_heap =
+						krealloc_array(buffer_on_kernel_heap, next_size,
+							sizeof(*buffer_on_kernel_heap), GFP_ATOMIC);
+					// FCP is used for purposes unrelated to significant system
+					// resources (e.g. storage or networking), so allocation
+					// failures are not considered so critical.
+					if (!buffer_on_kernel_heap)
+						break;
+
+					if (handlers == buffer_on_kernel_stack) {
+						memcpy(buffer_on_kernel_heap, buffer_on_kernel_stack,
+						       sizeof(buffer_on_kernel_stack));
+					}
+
+					handlers = buffer_on_kernel_heap;
+					buffer_size = next_size;
+				}
 				get_address_handler(handler);
-				handlers[count] = handler;
-				if (++count >= ARRAY_SIZE(buffer_on_kernel_stack))
-					break;
+				handlers[count++] = handler;
 			}
 		}
 	}
@@ -1002,6 +1027,9 @@ static void handle_fcp_region_request(struct fw_card *card,
 		put_address_handler(handler);
 	}
 
+	if (handlers != buffer_on_kernel_stack)
+		kfree(handlers);
+
 	fw_send_response(card, request, RCODE_COMPLETE);
 }
 
-- 
2.48.1


