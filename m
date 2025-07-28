Return-Path: <linux-kernel+bounces-747351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD58B132DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F357A9256
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819C1E5B91;
	Mon, 28 Jul 2025 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ePAANq2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEgAPSn5"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A61CEAB2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753667497; cv=none; b=OeLic6GzC/KcH1gUJX2IQDr/pV3QTngbqASjIo0s+Oao2gYvc+QL+AyuBmtT8Tf6bmhS6qtHjGNXk+ro+R1lSEmDwVNWy0xEiojCBVin9H2PH/Cuq6WWaG1zO3bDE5gLicfZYx05sYit2MFFuti9/fHpxOCLIvPICAZdE0kpNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753667497; c=relaxed/simple;
	bh=C6q76Gzm2DqD6HRJKHqm4Ac926Hyh8QT5OZunvVP9WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3EMRV5qPYeOOu/b+yDZXA0q47mN4thyBj7xFIhU1YQ+x9FBcNTosXq4t0WH4spaHhGD4RBK69BpHrVEYVH5nPndA2El7/aUoOUgUTV4xId7JIUmpTjLzDsQBNjhS4xmWdEQvakA0bS6CG//L86qzv0dC2sr8+g4oFrqSM7J3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ePAANq2p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEgAPSn5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FDEC14000E3;
	Sun, 27 Jul 2025 21:51:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 27 Jul 2025 21:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1753667494; x=
	1753753894; bh=T+KYmE/l+yGdl7UNyJzzt98jcLOcd4qLqrRVfYXoeUM=; b=e
	PAANq2py4DHrail2mkIieVSfGEEkvkDJ3dC//02HMEBCL0p93iairB+HFq/jUNog
	RkgkYC9SQmrxIW/5ROZheBTHbBY0++f/o7WA+bv7HOHS7IR2Od4ReaWdVDiqoRL6
	mLjdPNX1AZ2DLbzAHjof+g1DlixAYbSynjZYMtkKzqYZFLhsCajVzbEmJJnFwvtm
	3JDQDRh1AQtJvMy6OKyx63Zp6Iw0c0M66ntIcTsS07YaaIX//8n8IytF89n6IwFV
	M/mbviy3L5wErDGQFlLOh4iMh3eDSl2gByWNYtWQAcqPj1ZOMAhY/lvZhcGv/+uw
	6/ktQA9MpWxNmahmIu5Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1753667494; x=1753753894; bh=T
	+KYmE/l+yGdl7UNyJzzt98jcLOcd4qLqrRVfYXoeUM=; b=EEgAPSn5YsQuTs/2x
	AXUhSMT/17SVBszKPa1ILfrRdwlmYLZkYm7qo18JCUoLE4wBVFj1C0gZaMAJL2oE
	b14/9mpnN3Os8YLfbkJ4HbQfS5zSPnmr4WPZ8tjHpY9EesxppnbagyWz6+uCuks9
	g+BQlBSunGQ70zaLNFTjRtxtm7Ej11K+vNuP7T5ImVN87WB6124mVunyoMkSTxD2
	p2ru9cP3WNFk0sxxEG4/+P4SbJ3fs094zG742gVvOzooeZscA4CDw3Ro9j2kXP0L
	gmqGN0CCaTMW/Y+qcyPGdHCNRSPX/GQ959i6YlxRSl4s3bJfS7oeyHsh7RU4FJi+
	pteKw==
X-ME-Sender: <xms:pteGaBa2vOLSFbwp43454_6n-o_QgutkmDX_hiIXT45XiegxuMmM-A>
    <xme:pteGaBXJ_--XN83VyPyRUP6GppehppgPuIlLmRfY6mQEF0ysqa1ATRI4QHeoDOIzn
    V04hsMA3FvgasNRjCY>
X-ME-Received: <xmr:pteGaF5nhTHp4QnvFax_csu1fS8W3lnNKBKUopD_5pt8JqLXKNOVU_OmUFUNggYi0jlYANCwlO95zuLFJB77FiQRORrWbVkVQwxDvk1SWb9hZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeltdeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejuedvgf
    duudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pteGaMgp6Jrn-LNnNnfzGSSBp5Uujb1jsGO79sw5n1FJcPs8OATnYw>
    <xmx:pteGaMdxlTAZNlBje4qK62T-I8bx6I4kSkN0_tx241gpeuONGFAw0g>
    <xmx:pteGaBdEzJ3wfMM6T9uURNwL8NCmGQkCEUSjkCM8i2R1udXWmMXXog>
    <xmx:pteGaG8rJFUUdFhuN8BfYBSepX-BAb76BsTfODR1gcPDK6i6f0EDWw>
    <xmx:pteGaHeGew6PdFc7CKrojzW2P-V-_TC49ZYrsriq_VQbaK-MWN3SGAzU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jul 2025 21:51:33 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] firewire: core: call FCP address handlers outside RCU read-side critical section
Date: Mon, 28 Jul 2025 10:51:25 +0900
Message-ID: <20250728015125.17825-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250728015125.17825-1-o-takashi@sakamocchi.jp>
References: <20250728015125.17825-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit added reference counting to ensure safe invocations of
address handlers.

This commit moves the invocation of FCP address handlers outside of the
RCU read critical section. Unlike the exclusive-region address handlers,
all FCP address handlers should be called on receiving an FCP request.
An XArray is used to collect the FCP address handlers during the RCU
read-side critical section, after which they are invoked. Reference
counting ensures that each FCP address handler is called safely.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a742971c65fa..c5408c83709c 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -956,13 +956,14 @@ static void handle_fcp_region_request(struct fw_card *card,
 				      unsigned long long offset)
 {
 	struct fw_address_handler *handler;
+	DEFINE_XARRAY_ALLOC(handlers);
 	int tcode, destination, source;
+	unsigned long id;
 
 	if ((offset != (CSR_REGISTER_BASE | CSR_FCP_COMMAND) &&
 	     offset != (CSR_REGISTER_BASE | CSR_FCP_RESPONSE)) ||
 	    request->length > 0x200) {
 		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
-
 		return;
 	}
 
@@ -973,22 +974,39 @@ static void handle_fcp_region_request(struct fw_card *card,
 	if (tcode != TCODE_WRITE_QUADLET_REQUEST &&
 	    tcode != TCODE_WRITE_BLOCK_REQUEST) {
 		fw_send_response(card, request, RCODE_TYPE_ERROR);
+		return;
+	}
 
+	// Reserve an entry outside the RCU read-side critical section to cover most cases.
+	id = 0;
+	if (xa_reserve(&handlers, id, GFP_KERNEL) < 0) {
+		fw_send_response(card, request, RCODE_CONFLICT_ERROR);
 		return;
 	}
 
 	scoped_guard(rcu) {
 		list_for_each_entry_rcu(handler, &address_handler_list, link) {
 			if (is_enclosing_handler(handler, offset, request->length)) {
-				get_address_handler(handler);
-				handler->address_callback(card, request, tcode, destination, source,
-							  p->generation, offset, request->data,
-							  request->length, handler->callback_data);
-				put_address_handler(handler);
+				// FCP is used for purposes unrelated to significant system
+				// resources (e.g. storage or networking), so allocation
+				// failures are not considered so critical.
+				void *ptr = xa_store(&handlers, id, handler, GFP_ATOMIC);
+				if (!xa_is_err(ptr)) {
+					++id;
+					get_address_handler(handler);
+				}
 			}
 		}
 	}
 
+	xa_for_each(&handlers, id, handler) {
+		// Outside the RCU read-side critical section. Without spinlock. With reference count.
+		handler->address_callback(card, request, tcode, destination, source, p->generation,
+					  offset, request->data, request->length, handler->callback_data);
+		put_address_handler(handler);
+	}
+
+	xa_destroy(&handlers);
 	fw_send_response(card, request, RCODE_COMPLETE);
 }
 
-- 
2.48.1


