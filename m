Return-Path: <linux-kernel+bounces-861167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74BBF1F63
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 512404F7CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9BD212550;
	Mon, 20 Oct 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="O167+jNW"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7922DF9E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972359; cv=none; b=c56b+wNE7uegy6VMTo5nkqe/67u0maW+KzGfQujuK1VYz6ljLaWDmKVfIDXfPuQesjw6ugNjgCDSrduF3G11nlkkNsNBh7w7kR/tKMTrl0Cqdvg910UXj+ogFgUyN+I6sVXyprTfRIW9hRZxQWxtqziVumsRHxqMptqwWojZeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972359; c=relaxed/simple;
	bh=eIPL1PbOzwAC87OBdpfmylQC4VtAfo42cYrhK761NYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqJLKKZVyaAezB/0FyaAyuPbALOpqpvogoMKD/tHO1uK+C41Vj8j1kN2uMi0KQNi7NPYP/RPhUKp9QsmvW7jXPGgwtYspKDua77X/o6pFH2+cxytfk6j2ena5DfkiW8vpKPk0B1S6XdP8TvWFibgjIdEChvjsKSKxR/h0KU82uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=O167+jNW; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202510201459052e51708b86000207cb
        for <linux-kernel@vger.kernel.org>;
        Mon, 20 Oct 2025 16:59:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xOoP2nGkuPA+Uw6JrVQpJJCCCgyXytImgBHWQrNgGWI=;
 b=O167+jNWU0bL59qvFRB5NixTYEG0ZAXwuPwpknhkA+Xn5Xpy/+TewnsTe5UF64LYJ5lzEa
 kQ4hNmJM6EyYRX3+aHHaAOfnZYlQ2WdCV7WhOZ8Cax10F7dhguzMJY6+0mg11ruE8Xcm/NdK
 FYMYRcN6fvqQJ8vO6wy4rvK+v/jOliZHZqNYd8u3rJSLkxcZlSB3hCYjeIxxXi3RhubEH8a7
 aSw1VSPC9wPveaKfxcLehztQ8PK8kA2sE/uzl0gqj4/BS9140sDRj8qKgFBbZv214BzeUCyD
 4l6TbSXqjccpu99h7zv87Gc3xSWP28sS8mBmmaN+HlDqAD3L58dVEIsw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patrick.wicki@siemens.com
Subject: [PATCH v2] eeprom: at25: fram: Fix chip range in comment
Date: Mon, 20 Oct 2025 16:58:47 +0200
Message-ID: <20251020145858.1598599-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The first chip supported by the commented code is CY15B102QN, fix the
copy-paste error.

Fixes: cf4d2ce1eded ("eeprom: at25: fram: Detect and support inside-out chip variants")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2:
- dropped "Cc: stable" tag
- rebased onto v6.18-rc1

 drivers/misc/eeprom/at25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index e2868f7bdb035..883dfd0ed6583 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -408,7 +408,7 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
 			chip->byte_len = BIT(id[7] - 0x21 + 4) * 1024;
 			break;
 		case 0x2a ... 0x30:
-			/* CY15B116QN ... CY15B116QN */
+			/* CY15B102QN ... CY15B116QN */
 			chip->byte_len = BIT(((id[7] >> 1) & 0xf) + 13);
 			break;
 		default:
-- 
2.51.0


