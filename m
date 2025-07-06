Return-Path: <linux-kernel+bounces-715541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FCAAF7764
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98D44E1C4E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F52EE266;
	Thu,  3 Jul 2025 14:26:16 +0000 (UTC)
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A222ED848;
	Thu,  3 Jul 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552775; cv=none; b=PQUX+SZmPfFj9t0XJ5ftPjrsAzLEWRnRtunQwS81VTFiJlD/np6RzDyGaKxcLtJbO0cYL3+xR79bwkmx9JTzHzvWODh3nLp9NdjWvCA9wMX9OJV4TOqLE/IDHNRSD/26dHwxAg3xUHTZreDc5W/G+yS5ncQxu2zh4ebbU3nK9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552775; c=relaxed/simple;
	bh=J99JaJ4floWwfZaj+zZ6sO0yTygkK0zGjhShgkmfZFQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoJjcsnTQkY652qd5v9xfXYF36OSb0UBTJkH4giUkb/FxXiLTFwgy7/5mUZAO76hgdMEcfvZY2lsMqaK2eOlQdeJopiXG74cSYZmSk27W0y2Sx7hcC6b0db2Cka/CdbTnVp6d6TYzigY9SSgYaJhaH1W8dd/hIjxhzN+oUTj7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 236EB449C8;
	Thu,  3 Jul 2025 14:26:10 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: trivial@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bastien Nocera <hadess@hadess.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kees Cook <kees@kernel.org>,
	Erick Archer <erick.archer@outlook.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	asahi@lists.linux.dev
Subject: [PATCH 7/7] Bluetooth: Fix typos
Date: Thu,  3 Jul 2025 16:24:35 +0200
Message-ID: <20250703142542.985248-8-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703142542.985248-1-hadess@hadess.net>
References: <20250703142542.985248-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehtrhhivhhirghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgvrghnrdifrghnghesmhgvughirghtvghkrdgtohhmpdhrtghpthhtohepmhgrthhth
 hhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght

Found by codespell.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 net/bluetooth/hci_conn.c  | 2 +-
 net/bluetooth/hci_event.c | 4 ++--
 net/bluetooth/hci_sync.c  | 2 +-
 net/bluetooth/lib.c       | 2 +-
 net/bluetooth/smp.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4f379184df5b..cb360adbb6ec 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -814,7 +814,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
  *
  * Detects if there any BIS left connected in a BIG
  * broadcaster: Remove advertising instance and terminate BIG.
- * broadcaster receiver: Teminate BIG sync and terminate PA sync.
+ * broadcaster receiver: Terminate BIG sync and terminate PA sync.
  */
 static void bis_cleanup(struct hci_conn *conn)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 66052d6aaa1d..a546cb058e8e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5754,7 +5754,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	conn->state = BT_CONFIG;
 
 	/* Store current advertising instance as connection advertising instance
-	 * when sotfware rotation is in use so it can be re-enabled when
+	 * when software rotation is in use so it can be re-enabled when
 	 * disconnected.
 	 */
 	if (!ext_adv_capable(hdev))
@@ -7077,7 +7077,7 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 /* Entries in this table shall have their position according to the subevent
  * opcode they handle so the use of the macros above is recommend since it does
  * attempt to initialize at its proper index using Designated Initializers that
- * way events without a callback function can be ommited.
+ * way events without a callback function can be omitted.
  */
 static const struct hci_le_ev {
 	void (*func)(struct hci_dev *hdev, void *data, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6687f2a4d1eb..febad7922008 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5633,7 +5633,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	}
 
 	/* Cleanup hci_conn object if it cannot be cancelled as it
-	 * likelly means the controller and host stack are out of sync
+	 * likely means the controller and host stack are out of sync
 	 * or in case of LE it was still scanning so it can be cleanup
 	 * safely.
 	 */
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 43aa01fd07b9..305044a84478 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -54,7 +54,7 @@ EXPORT_SYMBOL(baswap);
  * bt_to_errno() - Bluetooth error codes to standard errno
  * @code: Bluetooth error code to be converted
  *
- * This function takes a Bluetooth error code as input and convets
+ * This function takes a Bluetooth error code as input and converts
  * it to an equivalent Unix/standard errno value.
  *
  * Return:
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 47f359f24d1f..5b4ade03bdcc 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3172,7 +3172,7 @@ static void smp_ready_cb(struct l2cap_chan *chan)
 	/* No need to call l2cap_chan_hold() here since we already own
 	 * the reference taken in smp_new_conn_cb(). This is just the
 	 * first time that we tie it to a specific pointer. The code in
-	 * l2cap_core.c ensures that there's no risk this function wont
+	 * l2cap_core.c ensures that there's no risk this function won't
 	 * get called if smp_new_conn_cb was previously called.
 	 */
 	conn->smp = chan;
-- 
2.50.0


