Return-Path: <linux-kernel+bounces-756691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF88B1B7CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E380E17AE95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28128980A;
	Tue,  5 Aug 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FBIbUXO9"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70F1C84B8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409251; cv=none; b=IjrBWx1a4k229GS3R832V+9Mpz1uwROIt42bAUSUOhrDrYyfhRnYnVhv0DAqwYKBrfhNkqJ4l0wOo/wYLa1zFWUPlRfIo/KZpc9aCq5h+edFs1DIjsJ2VZbMUMFWgqxSIBjeK5/EbeqFq5B/gl1uL8X6wVFJXL34zCRVMiTP7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409251; c=relaxed/simple;
	bh=1DLj+UIzPcRfqcLsZC4XHHacraADOCrmwZgUgHtfmzs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FwCvGeSSvNWxxw8Q3baqWi5EWil3gdf5/dVYzyJS7RP35j+/7iI+fgFYjfd2i+BzvTH6EyzFYuDbshuwRCC0fpmFpQp97f7L97+KESO7c8F5kzz1ALAnHWVuWDGVEg4yQCPLHDpRtkCBHK5PIANF0gRxKPmdCV61Yesq9SHFiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FBIbUXO9; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 634025c8721411f08871991801538c65-20250805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MDBvzVKssQSva27++Dk9F/cZ5uTyJvj5l+46UJDxufg=;
	b=FBIbUXO9qrQ4eYsTnY/6jrIVX1SfrsS2u6WJNCXU5tYg61qae9Cy5kgkdanSsc8n/apxrRK9E3ux1Ucze1EX4IiQqW57vDRNvUWurxceKcSEAdprIqaq9QK+SSzFjyctET4iHY39tu5T9VUpIdNhiPMSMaR6NSZxXvV+GL66lxU=;
X-CID-CACHE: Type:Local,Time:202508052353+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:8c928d11-75d7-4a81-b167-18d4e39d130b,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:9eb4ff7,CLOUDID:aadd2409-aadc-4681-92d7-012627504691,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 634025c8721411f08871991801538c65-20250805
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <kuyo.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2053633338; Tue, 05 Aug 2025 23:53:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 5 Aug 2025 23:53:49 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 5 Aug 2025 23:53:49 +0800
From: Kuyo Chang <kuyo.chang@mediatek.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"Matthias Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: kuyo chang <kuyo.chang@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] sched/deadline: Add DL server activated message
Date: Tue, 5 Aug 2025 23:53:32 +0800
Message-ID: <20250805155347.1693676-1-kuyo.chang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: kuyo chang <kuyo.chang@mediatek.com>

The DL server is introduced as a replacement for realtime throttling.
When RT throttling is activated, a message
"sched: RT throttling activated" is shown. However, it is currently
difficult for users to know when the DL server is activated.

This patch adds a similar message to indicate when the DL server
is activated, which helps users debug RT/CFS contention issues.

Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4306b3..8e0de6cdb980 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2042,6 +2042,9 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	}
 
 	__enqueue_dl_entity(dl_se);
+
+	if (dl_server(dl_se))
+		printk_deferred_once("sched: dl_server activated\n");
 }
 
 static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags)
-- 
2.45.2


