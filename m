Return-Path: <linux-kernel+bounces-715540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D50AF7760
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 16:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91FA1885EC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866B2ED16A;
	Thu,  3 Jul 2025 14:26:13 +0000 (UTC)
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491422ECEAC;
	Thu,  3 Jul 2025 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552773; cv=none; b=MsYrN20xg6n6NJb9fA20Vmrm2N5kP0N1JNZGyRT6z3EXyNqayO45hTh9BxZfLS3piPXatJtbDSReDq51EiZDRRHfw+Er9NdKc1tz8DcHotUWM/iGkM1Or/7s/IEvd+Y0KtKj7qo78XeEzVYHGnTaI20aWH+E5tuRMY8fk6yZGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552773; c=relaxed/simple;
	bh=0eCsvuR4bu3TjfVEuzOE91/BdXRw1oTzdIEqsx0Fu/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWaeT+oSb617DL0XuxCTP9LBoxoNKc9w8L/xF6GcOthi1rMkVXp1W7yrbIUnJe95H+AZxuugktpcZ4MuuTWniH6ZvohF1useRaplkd4lUuf5Z+x4uJzP9tCmfXSqzuXDg1VudmVc6HD01MN/zZ33FapKd34puyvW52ZnQRDxtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95D75449C4;
	Thu,  3 Jul 2025 14:26:07 +0000 (UTC)
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
Subject: [PATCH 6/7] Bluetooth: RFCOMM: Fix typos
Date: Thu,  3 Jul 2025 16:24:34 +0200
Message-ID: <20250703142542.985248-7-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehtrhhivhhirghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgvrghnrdifrghnghesmhgvughirghtvghkrdgtohhmpdhrtghpthhtohepmhgrthhth
 hhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght

Found by codespell.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 net/bluetooth/rfcomm/core.c | 3 ++-
 net/bluetooth/rfcomm/tty.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 3b8f39618d65..96250807b32b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1962,7 +1962,8 @@ static void rfcomm_accept_connection(struct rfcomm_session *s)
 	int err;
 
 	/* Fast check for a new connection.
-	 * Avoids unnesesary socket allocations. */
+	 * Avoids unnecessary socket allocations.
+	 */
 	if (list_empty(&bt_sk(sock->sk)->accept_q))
 		return;
 
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 21a5b5535ebc..58d1707f7daf 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -980,7 +980,7 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty,
 		baud = RFCOMM_RPN_BR_230400;
 		break;
 	default:
-		/* 9600 is standard accordinag to the RFCOMM specification */
+		/* 9600 is standard according to the RFCOMM specification */
 		baud = RFCOMM_RPN_BR_9600;
 		break;
 
-- 
2.50.0


