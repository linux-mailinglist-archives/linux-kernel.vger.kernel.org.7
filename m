Return-Path: <linux-kernel+bounces-872163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2AFC0F6B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEB4FABF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F641312819;
	Mon, 27 Oct 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="WKg6Nwue";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="NZm544+G"
Received: from mta-01.yadro.com (mta-01.yadro.com [195.3.219.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9151EAE7;
	Mon, 27 Oct 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.219.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583409; cv=none; b=JaKWsuk2IJ++Li+oW+dmmes6w90FwW7a15zFBfnxHlGQxtC9Ts8SgYxDlPYWGPNaq25bGR2Xxzchrf3bmLjqfFiKcEJjjXeiA8921aw/CzOg7W+znpv6zJXonbASrtIDoiWAuHnOXhzxuVIcYU76QiLjXOST7YOEh1kqstxzbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583409; c=relaxed/simple;
	bh=FThlKf9mPp6z/y8Uoh/3G44IfMfSzTwr6+FTkAYPw3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GOopZ20UE/DVa8IJ0dKhlxHMHSewzshQ2Vgg+GyFa9smxdVEukf5d+jQ3PmQOeqWd5TAqGBVI5CzGwS9C0KXqJ2eAkcTRSDYcme+2LOivIRCUl5i5QZqW/q0iqp43yKh5tMM+JsJFRdLy844oOy0iIuTuKklCpKE2wHISgo/eWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=WKg6Nwue; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=NZm544+G; arc=none smtp.client-ip=195.3.219.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 554912001D;
	Mon, 27 Oct 2025 19:36:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com 554912001D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1761582994; bh=mfpLLcjjSLHnXsHxBUMYqBg3s2C4zQ/P2NyM/Se6WAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=WKg6Nwue+SQpZixo1Qa11K0XLgor805rhCZKtmkmrZGguGMnxyUXyvjaKTLGp/Qn9
	 z68Ihw4D4X+GKUzJ6qpvvpWJ6+SgAHzatzycjl4Amgtjigi9kEc+g37yEQ/7KGIKcK
	 tTWMvmWRXQs/WDQjGTZPZdbfLrL6YF0UIA0yyLKM61EQvV8DQ32ENy4HIZhdU5USfA
	 RuEIcZgRvU7D0If0ORnVZVMAhIC6ujySOoQZY8xjt3L9fQA8gM6LUxVXS20EvKKbY4
	 vbK9jUlfYuMx+qx/7NEb/ykuJVJ7fsocoPkIvcdnnqbQlFyqe2rD/ppPEXe6sQbIz6
	 mrZPs0oVL8cew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1761582994; bh=mfpLLcjjSLHnXsHxBUMYqBg3s2C4zQ/P2NyM/Se6WAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NZm544+GMjcaupdkmKaXqnUi+5IreZ+91utfh17h6prAW7SCgZA8IDLh0otwCxH96
	 F3LlwgSph05pu8sitPWSA45CvzJGAXesqN2wPVwpwA41NVY9Zqa+wRnxvNl7DQTEF0
	 /+mayEvQU0psPxL/1fY3VOn42zI+M9DBkJI4NK8g+/R5xUPqgYZP6mPxSAJObzEgYb
	 cKc8fB4g3c5nUtNPGGVSyLIzDhy+W4ydnahftU4LM1F1qG4PmLTpj7ui8uGzVs72za
	 9PdAZZvYVZlLkoh9THs5Zd3Rz0pc8dDVtIWIEx3BlTCtZiZOIVSLxIvwGzqF5di9Ql
	 kmxXpgv+Jyhlw==
Received: from RTM-EXCH-01.corp.yadro.com (unknown [10.34.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Mon, 27 Oct 2025 19:36:30 +0300 (MSK)
Received: from T-EXCH-12.corp.yadro.com (10.34.9.214) by
 RTM-EXCH-01.corp.yadro.com (10.34.9.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 19:36:36 +0300
Received: from NB-591.corp.yadro.com (172.17.34.55) by
 T-EXCH-12.corp.yadro.com (10.34.9.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 27 Oct 2025 19:36:35 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Stuart Hayes
	<stuart.w.hayes@gmail.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux@yadro.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
	<stable@vger.kernel.org>
Subject: [RESEND] [PATCH] nvme-tcp: fix usage of page_frag_cache
Date: Mon, 27 Oct 2025 19:36:27 +0300
Message-ID: <20251027163627.12289-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTM-EXCH-04.corp.yadro.com (10.34.9.204) To
 T-EXCH-12.corp.yadro.com (10.34.9.214)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/27 14:30:00 #27802224
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

nvme uses page_frag_cache to preallocate PDU for each preallocated request
of block device. Block devices are created in parallel threads,
consequently page_frag_cache is used in not thread-safe manner.
That leads to incorrect refcounting of backstore pages and premature free.

That can be catched by !sendpage_ok inside network stack:

WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
	tcp_sendmsg_locked+0x782/0xce0
	tcp_sendmsg+0x27/0x40
	sock_sendmsg+0x8b/0xa0
	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
Then random panic may occur.

Fix that by serializing the usage of page_frag_cache.

Cc: stable@vger.kernel.org # 6.12
Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d52..823e07759e0d3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -145,6 +145,7 @@ struct nvme_tcp_queue {
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
 
@@ -556,9 +557,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1420,9 +1423,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1450,6 +1455,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1772,6 +1778,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1903,6 +1910,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 
-- 
2.25.1


