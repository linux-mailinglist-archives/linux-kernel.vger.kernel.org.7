Return-Path: <linux-kernel+bounces-758727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D20B1D32F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B0F723950
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7D0222576;
	Thu,  7 Aug 2025 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKGmN0p6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DE5235041;
	Thu,  7 Aug 2025 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551251; cv=none; b=UDOduO2bgcr9UHhab3iYEkBr5byChVVV3Dk8rRgG92/hxyevV4h6UjE2jx2yAOxieIM6ZAL64D9lFi1mzLEyacnVTJdj57ut30g3bUVLzf/6j0lvdnYm/LNdEVf2RXnHUCN+YKsMWw2852tKoPus3w18YDjNGiR9N3gg/avy6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551251; c=relaxed/simple;
	bh=dxJGE+mEq+3AgUMzvKMTimiXNGP1oHgsGV9MNV/DwJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dL5Eei4+2XPam/w+75Zq2fwiadPyOHmGIz10GO+kQblG0YeswF+OIqmTxGx1dWxWQSglM1u1mHdyLUB1/y485oDFzNr+YVfIwvLy02oMgrZS/sdzEhzg9DojoBOLc2Hcv9ZRRQaPH7N8pzz7tz58D+XfTTr5XvKl8JV9E9rbdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKGmN0p6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009ECC4CEEB;
	Thu,  7 Aug 2025 07:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754551251;
	bh=dxJGE+mEq+3AgUMzvKMTimiXNGP1oHgsGV9MNV/DwJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=BKGmN0p6MMXGOxCLX3XcXUShkZnLdIqI0ySdOp0gNrTrAPU3vYU1cEB2GY56Dal0t
	 0GNayzcyqU/0zDh93YZkiSKy6b4uiX/F5/T8VueVSkjlDhOwc1zuD0o9++h615TruI
	 3dbgRD74Dmu0zdAM07IreOBP+DAXntnJ54JYijv1OzsiaL4EqTYuknnRo34+CAip2f
	 GYO5DGAPYN54Akd6iua85zS0PN1kuoiwKf6qN6ToETXX7x2/1quroovME6Fs+VSkRw
	 Nv3Kqh+dPx1Itzg79aC0QStCkgO2Ue8D2PWyo9RzaLM57b8mhl8CpeIlCbvuNDyBpB
	 eqE54Z5R5vClQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] mtd: dc21285: fix bytewise memcpy()
Date: Thu,  7 Aug 2025 09:20:34 +0200
Message-Id: <20250807072044.4146480-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The commit that split up the 8/16/32-bit operations in 2004 seems to have
broken the 8-bit case, as clang-21 now points out:

drivers/mtd/maps/dc21285.c:129:97: error: parameter 'len' set but not used [-Werror,-Wunused-but-set-parameter]
  129 | static void dc21285_copy_to_8(struct map_info *map, unsigned long to, const void *from, ssize_t len)

Put back the loop that was in linux-2.6.8 and earlier for this case.

Fixes: 67d4878e4e61 ("NOR flash drivers update")
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/maps/dc21285.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/maps/dc21285.c b/drivers/mtd/maps/dc21285.c
index 70a3db3ab856..1d70bf62e91f 100644
--- a/drivers/mtd/maps/dc21285.c
+++ b/drivers/mtd/maps/dc21285.c
@@ -128,12 +128,14 @@ static void dc21285_copy_to_16(struct map_info *map, unsigned long to, const voi
 
 static void dc21285_copy_to_8(struct map_info *map, unsigned long to, const void *from, ssize_t len)
 {
-	map_word d;
-	d.x[0] = *((uint8_t*)from);
-	dc21285_write8(map, d, to);
-	from++;
-	to++;
-	len--;
+	while (len > 0) {
+		map_word d;
+		d.x[0] = *((uint8_t*)from);
+		dc21285_write8(map, d, to);
+		from++;
+		to++;
+		len--;
+	}
 }
 
 static struct map_info dc21285_map = {
-- 
2.39.5


