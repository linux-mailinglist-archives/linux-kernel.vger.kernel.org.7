Return-Path: <linux-kernel+bounces-747349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511DBB132DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3637D3AA7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F91DB127;
	Mon, 28 Jul 2025 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="l3gV/XPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8bbBz0l"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64CE1684B0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753667495; cv=none; b=lKydipBNqNU/uFN5NS/4svqjPh9ZCMg0szSNvucPMHOeoYwc82vi7wc/rjjbcp/qQfegqVpA6k7CIu3cYABG1HFLzWpnbDFOQmNvt+ZG9AEsOdv6WVaSTwMs/4Anycq6+rUbTQWwD739nqd4aH4WbDe7IM0fQ5Ih/UJdbggJ3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753667495; c=relaxed/simple;
	bh=NBOMXeN7jfbrMYzOfrYMQ9qDbDr5qjIwvGsaTdXgWX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwrzW8aIXvhwGrRlJgng0zzkpdQFqsIPEWdvV/Yubq4ER9EhlI0yzKUV3IW9KIIQPIeCGdEH01OuA/4BO+KDJMeCxHMKij6TDolELcfJoTd/Cz0iFIVPntM31NhYSeVzmX8Itq8FAo+NqNnStHB0BJmIr+73Qz43EDQ1ufelRuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=l3gV/XPJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8bbBz0l; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B102EEC0019;
	Sun, 27 Jul 2025 21:51:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 27 Jul 2025 21:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1753667491; x=
	1753753891; bh=uIT7ZT2GEbaZ13vB+uEm7pnNUB9wlozg2/F7BnXZ+14=; b=l
	3gV/XPJ4r1xwxtQ9ksecb5jrtlvMfWJtbXS1CuhqNt/3KDu0iaHldDK5L0SS3fLQ
	ej1yHobFmaramHnZ0aF1H+eeeMY36qaEcqFL5nLe3aWSTf7BpAGq/UbO5asjskF3
	Q/xF5L0GMRUzvUxbhFb9ZORmQPLN5IHVhZEFLhEQS8PPuTToyAzmFohrgvkqZLWJ
	NVg+9IMPHCxgSuJHhmDOhF95rsGGaSf9TIKZ4XKdDAiAPw5gJiyuFoL7LauDSTxS
	SxoC/PXL0xt4LETcpHcwG1InTUZ4BbdSA/FNvKy09qYByHnca3L8rnNMY9LV7JxM
	QQafrML4XzGIPLKBr/k1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1753667491; x=1753753891; bh=u
	IT7ZT2GEbaZ13vB+uEm7pnNUB9wlozg2/F7BnXZ+14=; b=F8bbBz0lyHYKe4Aml
	DJP0RrI+gmxl0mhs3kVJIQrR9ohMh9sm199eN9ze+D5YnZ/5BxQxoN2bY6y7im/p
	iHKvmy2B+EmbNN8HzfkIPWiPMhNNrNdtE38k+hBTcJ6x8bu3EMM8YBc66+3/D1Mn
	UpDyYEED7MZz8U0+ITpjNw5nBgHby3ZjpawkQpqbs8B97Y91+LNG6fVwsUgVDKqp
	UScU9bsG9sGGJhrzR6vybUG/uHiJIrXd/PuYGzGFkG0BvetYbKJYpDHkWzqBHMQj
	51tsqdyWH8vhFwA6RyaXd4d4KBDuhM0kGMUoFWxvW4EfyykGtSJPY3LFT9Sk3b9M
	ssnFw==
X-ME-Sender: <xms:o9eGaNhxIiWfMcz8_w7bkYAItFTv8ST6QKg4nzOudLebq4poDP1jLw>
    <xme:o9eGaK8G2e5Swio1ZSulj0j6f05mJJe-x_PRSMaR165WHvFJUIxXqIgQ3vx4uTtAO
    JQYGOawyVFTicOWgls>
X-ME-Received: <xmr:o9eGaPD9VDcBBLouEWCe_hv5U-zIAJzcKSAacXdAa5Jqd8k6NPHFu_V8FhRIZBO4-dy0vAShZ16duc-uiHY3Q8CQdQqqDOpFtT7H_ZQzxiMC0w>
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
X-ME-Proxy: <xmx:o9eGaPJxKgDgMuuEvTC2_mQJepB4Lk60vyadE4gyAzvQHDchPA1lAQ>
    <xmx:o9eGaKnnW81j_4NwmFVfV25EUJaQJF06ABIaOcA1hpy2s_szjvV_ag>
    <xmx:o9eGaFGBjVQ0NhUBMevyZZ_jzVZi5zTQEM0csgPyKIOpYQIA5QdKng>
    <xmx:o9eGaCFZ5X-BLL1DmU8qcRRqUKZHf_SI5z2JrEy4BApSkNsvwP4dkw>
    <xmx:o9eGaMn1d98qCRBvnEAu61M2KeigC6RiDYttjnzn02XtQQ0d3-Dbby0g>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jul 2025 21:51:30 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] firewire: core: use reference counting to invoke address handlers safely
Date: Mon, 28 Jul 2025 10:51:23 +0900
Message-ID: <20250728015125.17825-2-o-takashi@sakamocchi.jp>
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

The lifetime of address handler has been managed by linked list and RCU.
This approach was introduced in commit 35202f7d8420 ("firewire: remove
global lock around address handlers, convert to RCU"). The invocations of
address handler are performed within RCU read-side critical sections.

In commit 57e6d9f85fff ("firewire: ohci: use workqueue to handle events
of AR request/response contexts"), the invocations are in a workqueue
context. The approach still imposes limitation that sleeping is not
allowed within RCU read-side critical sections.

However, since sleeping is not permitted within RCU read-side
critical sections, this approach still has a limitation.

This commit adds reference counting to decouple handler invocation from
handler discovery. The linked list and RCU is used to discover the
handlers, while the reference counting is used to invoke them safely.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 32 +++++++++++++++++++++++++++--
 include/linux/firewire.h            |  4 ++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index d28477d84697..29ca9f3f14ce 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -550,6 +550,23 @@ const struct fw_address_region fw_unit_space_region =
 	{ .start = 0xfffff0000900ULL, .end = 0x1000000000000ULL, };
 #endif  /*  0  */
 
+static void complete_address_handler(struct kref *kref)
+{
+	struct fw_address_handler *handler = container_of(kref, struct fw_address_handler, kref);
+
+	complete(&handler->done);
+}
+
+static void get_address_handler(struct fw_address_handler *handler)
+{
+	kref_get(&handler->kref);
+}
+
+static int put_address_handler(struct fw_address_handler *handler)
+{
+	return kref_put(&handler->kref, complete_address_handler);
+}
+
 /**
  * fw_core_add_address_handler() - register for incoming requests
  * @handler:	callback
@@ -596,6 +613,8 @@ int fw_core_add_address_handler(struct fw_address_handler *handler,
 		if (other != NULL) {
 			handler->offset += other->length;
 		} else {
+			init_completion(&handler->done);
+			kref_init(&handler->kref);
 			list_add_tail_rcu(&handler->link, &address_handler_list);
 			ret = 0;
 			break;
@@ -621,6 +640,9 @@ void fw_core_remove_address_handler(struct fw_address_handler *handler)
 		list_del_rcu(&handler->link);
 
 	synchronize_rcu();
+
+	if (!put_address_handler(handler))
+		wait_for_completion(&handler->done);
 }
 EXPORT_SYMBOL(fw_core_remove_address_handler);
 
@@ -913,10 +935,13 @@ static void handle_exclusive_region_request(struct fw_card *card,
 	scoped_guard(rcu) {
 		handler = lookup_enclosing_address_handler(&address_handler_list, offset,
 							   request->length);
-		if (handler)
+		if (handler) {
+			get_address_handler(handler);
 			handler->address_callback(card, request, tcode, destination, source,
 						  p->generation, offset, request->data,
 						  request->length, handler->callback_data);
+			put_address_handler(handler);
+		}
 	}
 
 	if (!handler)
@@ -952,10 +977,13 @@ static void handle_fcp_region_request(struct fw_card *card,
 
 	scoped_guard(rcu) {
 		list_for_each_entry_rcu(handler, &address_handler_list, link) {
-			if (is_enclosing_handler(handler, offset, request->length))
+			if (is_enclosing_handler(handler, offset, request->length)) {
+				get_address_handler(handler);
 				handler->address_callback(card, request, tcode, destination, source,
 							  p->generation, offset, request->data,
 							  request->length, handler->callback_data);
+				put_address_handler(handler);
+			}
 		}
 	}
 
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index cceb70415ed2..d38c6e538e5c 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -341,7 +341,11 @@ struct fw_address_handler {
 	u64 length;
 	fw_address_callback_t address_callback;
 	void *callback_data;
+
+	// Only for core functions.
 	struct list_head link;
+	struct kref kref;
+	struct completion done;
 };
 
 struct fw_address_region {
-- 
2.48.1


