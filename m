Return-Path: <linux-kernel+bounces-793842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78EB3D915
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0B47A87D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D3E246BB4;
	Mon,  1 Sep 2025 05:54:36 +0000 (UTC)
Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C2442C;
	Mon,  1 Sep 2025 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706076; cv=none; b=d4/8TRz6XbMQRWlZzMNtloIi1aolSa9N19xQa3FmtDL5f/RysDvzu3BVOeJfqzx89say1cHZk7HeJbur26ZewYH5pN6CvNE1Cc/SfWQzxlUMnUPGniiRhJcHsqQWYIdHWbMbA8DDf3FfaWseflyRfPqkamCs1Mw/lw7wBwjWJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706076; c=relaxed/simple;
	bh=ZD50RwRddaDSQ+q3aDocn10Q+tyd9MmUqLG7iZTxacA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oL3cXGbqmN6VAU0EimfeK1LJC3fPY1CJ1l/1ePTuoQIv6Z2/qFLqEDeOCZO6p3p0FX1o4X33ZhB5MmQqttBHXzREkEDnBzmd0breci2uJb9RpT81Bq2acWL6nPYtE7oG4DrtPTgEK219KcTHHuTsWAMIvjJhSHShghSqdITqRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 61D1D1011A; Mon,  1 Sep 2025 07:54:19 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH v2 1/4] tty/vt: 8th bit location in vc_uniscr routines
Date: Mon,  1 Sep 2025 07:26:33 +0200
Message-Id: <20250901052636.8981-2-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250901052636.8981-1-soci@c64.rulez.org>
References: <20250901052636.8981-1-soci@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both vc_uniscr_check and vc_uniscr_copy_line assume that the 8th bit of
glyph is also the 8th bit in the screen buffer. However this is only the
case for fbcon at the moment. Vgacon has it on the 11th and so the
conversion won't work in that case.

The patch adds a helper to read the glyph correctly from the buffer.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/tty/vt/vt.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 869261141..19ce9c426 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -293,6 +293,17 @@ static inline u16 *screenpos(const struct vc_data *vc, unsigned int offset,
 	return (u16 *)(origin + offset);
 }
 
+static inline u16 scr_read_glyph(const struct vc_data *vc, u16 *pos)
+{
+	u16 w = scr_readw(pos);
+	u16 glyph = w & 0xff;
+
+	if (w & vc->vc_hi_font_mask)
+		glyph |= 0x100;
+
+	return glyph;
+}
+
 static void con_putc(struct vc_data *vc, u16 ca, unsigned int y, unsigned int x)
 {
 	if (vc->vc_sw->con_putc)
@@ -493,7 +504,7 @@ int vc_uniscr_check(struct vc_data *vc)
 {
 	u32 **uni_lines;
 	unsigned short *p;
-	int x, y, mask;
+	int x, y;
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -514,11 +525,11 @@ int vc_uniscr_check(struct vc_data *vc)
 	 * unicode content will be available after a complete screen refresh.
 	 */
 	p = (unsigned short *)vc->vc_origin;
-	mask = vc->vc_hi_font_mask | 0xff;
 	for (y = 0; y < vc->vc_rows; y++) {
 		u32 *line = uni_lines[y];
 		for (x = 0; x < vc->vc_cols; x++) {
-			u16 glyph = scr_readw(p++) & mask;
+			u16 glyph = scr_read_glyph(vc, p++);
+
 			line[x] = inverse_translate(vc, glyph, true);
 		}
 	}
@@ -561,10 +572,10 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 		 * buffer of its own.
 		 */
 		u16 *p = (u16 *)pos;
-		int mask = vc->vc_hi_font_mask | 0xff;
 		u32 *uni_buf = dest;
 		while (nr--) {
-			u16 glyph = scr_readw(p++) & mask;
+			u16 glyph = scr_read_glyph(vc, p++);
+
 			*uni_buf++ = inverse_translate(vc, glyph, true);
 		}
 	}
@@ -4920,12 +4931,9 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
 /* used by selection */
 u16 screen_glyph(const struct vc_data *vc, int offset)
 {
-	u16 w = scr_readw(screenpos(vc, offset, true));
-	u16 c = w & 0xff;
+	u16 *pos = screenpos(vc, offset, true);
 
-	if (w & vc->vc_hi_font_mask)
-		c |= 0x100;
-	return c;
+	return scr_read_glyph(vc, pos);
 }
 EXPORT_SYMBOL_GPL(screen_glyph);
 
-- 
2.30.2


