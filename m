Return-Path: <linux-kernel+bounces-778891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29869B2EC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EE058811E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F60275B17;
	Thu, 21 Aug 2025 03:59:24 +0000 (UTC)
Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411C2566D1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748763; cv=none; b=UJejbLz4JFmT7bPRPQhzEpXIyyz1N6oZC3FJUxCuI/quWocGjOfukTAk7bg6n1lB7Fs4McX7FCVfXuy5fNX1SutNKWo4IcMZzKOtQkloX9vRWeKwpERwnblIDx+sHPChxlkO+0jrZwa26Kl0sk4CQu8QZf2Myw/xTjz/xQgO7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748763; c=relaxed/simple;
	bh=OM37L5cv2RmlC6JZ53yTNt/rs57hHsEEkgrjdphvmWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mAok+a7eNeH/DxrLXsx+W8rRMSYSKLG3amLWzWJURgsg5sqtBuC3vQ7ZYkOmMRpKNRzbWB4Plce26r+mXwCZ4kmM/XE2IAp64m2+AiyjZntEk/LXGopWG56TJYLMI9jg5Ngo9ZlzxLsVxvCG3vtY7QgErJ4kB4ihy60ky4itTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id C8BEE102AD; Thu, 21 Aug 2025 05:59:17 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH] vt: monochrome mode with 512 glyphs
Date: Thu, 21 Aug 2025 05:55:33 +0200
Message-Id: <20250821035533.8206-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In monochrome mode the lowest 2 bits of the attribute are used for the
intensity. If a 512 glyph font is loaded the lowest attribute bit is
used for the MSB.

The result is that with normal intensity (1) the MSB of the glyph can
be set.

Due to this on my setup the erase character becomes 0x120 instead of
0x20. As 0x120 is allocated to U+0161 in the loaded font the erased area
will be filled with "s" instead of spaces.

To make the 512 glyph case work in monochrome mode the intensity was cut
down to one bit (bold only) in this patch.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 62049ceb3..8eebb5f17 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -667,7 +667,7 @@ static u8 build_attr(struct vc_data *vc, u8 _color,
 	{
 	u8 a = _color;
 	if (!vc->vc_can_do_color)
-		return _intensity |
+		return (_intensity & ~(vc->vc_hi_font_mask ? 1 : 0)) |
 		       (_italic    << 1) |
 		       (_underline << 2) |
 		       (_reverse   << 3) |
-- 
2.30.2


