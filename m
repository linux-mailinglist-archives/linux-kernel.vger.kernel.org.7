Return-Path: <linux-kernel+bounces-698317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9981AE4067
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797E918942C2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751224BD1F;
	Mon, 23 Jun 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="FJyirCYl"
Received: from outbound.pv.icloud.com (p-west1-cluster2-host12-snip4-10.eps.apple.com [57.103.64.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534524A049
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681904; cv=none; b=thrwtMOontQiMq4uDFrHeal87NNBoHmW2qMu3bYLFs80Y+9osvQJDx9731p4E88ZuKbyZtiUeO8SJEWfbcuAX6GhT3mZvB71pCNXiCOzx3GpLbNmQeNlIsPQxnFMAH97aTjW3etpKOmQct5eRArbXdXDhaVeSu/PqC6Zgtek32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681904; c=relaxed/simple;
	bh=J1RM/naRig61JPIyS5A7i1IZVZPPaLZeQxHMAzk1/2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUlkyZvbue/cJ8U1c+cqC75aWWuIJimo8jR7dOLBYZwETkTE2t40T/oDsjwV7yJEgQnEOtJ1mAAyos3a2AqiTunPHNh9rL+X8/eyIVLKmrn5mbzWJDjtRtad7P4xYr35W9Zy8CAZRn6TFLzDyjAlWFyxfIe5UoaPP++EDghqpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=FJyirCYl; arc=none smtp.client-ip=57.103.64.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 2038C18001C4;
	Mon, 23 Jun 2025 12:31:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=+bOMZxGNcbHMaMNIw5IRQMdjJTzHAuHb31YFz+gbxtU=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=FJyirCYl7eJmDiSo7j96q2fxsSxPqbmKj3bWcBIapxYbGy6ASf9zufgqe0abLtyCnynVyUBBYsq/NmRaykL5mTW8LIeZ2Y5wEqqeA18lmPlaFGw+Liebfm10E19mup5aSe/2GN91tj/7xdiwwu7Pg4o6AyK/3cKuSdaoqir5nybUBby2rBjHrT+QRwBLHH5bwKQqvWh3gguphqfs2FX3qDmK5GYC31/325jkqpyJlgLvggCzWfxS2mjp5TqzkkbY8suguL1jE9eh79nNtPdtEzBkxkmIkPMf4/iM5bRMYb1/Z66XtZbuAUyEqvbFDA+OiVvinbr6bYeIturnE536Og==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 7DD641803759;
	Mon, 23 Jun 2025 12:31:37 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 23 Jun 2025 20:31:18 +0800
Subject: [PATCH 3/4] Bluetooth: hci_core: Eliminate an unnecessary goto
 label in hci_find_irk_by_addr()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-bt_cleanup-v1-3-5d3d171e3822@oss.qualcomm.com>
References: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
In-Reply-To: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NSBTYWx0ZWRfX12VavILxTGeQ
 qS7OesVf8ESm/76ljFGRQyGAknVyQCsMB/KMCJ67L7iFM8zT8B3l6nccQFj3NoEsbfWyDVc9DeW
 E46dQBbXe6qHM0ht2Q0FnANQPXCf8xzeucdyk5fFz6qdKqDD65n3ijtXOVbfJ6BRNHXYEpAAS3G
 R+AmDLDqeNAQ55xtNN/ILcdr6rV2IeFZi7zDRVvmvAUaz5xTyQpUpkE6cBZMi7zuS+pHH9nufUi
 dix7Z0WkZxhgkfPS2kKXP3qoss1NJ2U8HhZtH5nX+uVgO/njbXMQuxcuPFMZyJQjjAyshwM0Y=
X-Proofpoint-ORIG-GUID: 0FUP7SD9JBMuQuXhpKs9AYjI_0G0L3Po
X-Proofpoint-GUID: 0FUP7SD9JBMuQuXhpKs9AYjI_0G0L3Po
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2506230075

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Eliminate an unnecessary goto label by using break instead of goto to
exit the loop in hci_find_irk_by_addr().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ce1d8c997a31529996ad98f22ec0997ed3ac9b36..9af4d7345e4df1d715fdab7427a700007303f65e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1256,12 +1256,10 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		if (addr_type == irk->addr_type &&
 		    bacmp(bdaddr, &irk->bdaddr) == 0) {
 			irk_to_return = irk;
-			goto done;
+			break;
 		}
 	}
 
-done:
-
 	if (irk_to_return && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
 						irk_to_return->val)) {
 		bt_dev_warn_ratelimited(hdev, "Identity key blocked for %pMR",

-- 
2.34.1


