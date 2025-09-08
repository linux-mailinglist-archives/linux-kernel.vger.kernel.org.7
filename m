Return-Path: <linux-kernel+bounces-806523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42A3B4980D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A01C1BC4086
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71EB31578E;
	Mon,  8 Sep 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uev2jrWe"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F0314A9C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355282; cv=none; b=XxahQzK+1q/+AM0U8A0i5I2mRuTWD/hHfoTjFb+VCKQu+z0meSr6cqpTf2xInRcp00X4GwCfCxYJlPsbfxn6Q/nbMrkGK/Uq4Dw/mv6TnaLSg3b/3tLa60u6YW9RZ9lGoc8OKOcz94wtqFhI0uc5S9eqXHZUlQz9vtSdbnls/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355282; c=relaxed/simple;
	bh=wvb9kExJlVTJopDzlR14wlmHKK39VVW4GDPK4XfQE5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LP1Gf+leUQ5O6pUgSUf3IXQ6QTk0WtffQ9Wo9WI7g9hL0to0KKUH6OdffaP94SZLKfg2NtjRsj/0Ke3FDeBaK+bPIhaGmLMjW1Nji18E+ig6IrgY16h/vmPrvZTbGJX4clXqILRDCUohVrqfsSfS87YEl5q16Ehvg4SO3oVhYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uev2jrWe; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757355277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hkWHmbRxIQF8liHGFYlvZpkYRA2BPJc4g/PktgKTmvg=;
	b=uev2jrWeDsaTz8cfd0bVPcSK57yxDc4zR0uJWsTpWhkQK6FA1ychCh/+u23UYEAk5a0g43
	EnAMk9QgO5IQhUthY492bTier3nHFz3m2WiIYN85xB5RPzwpmtfik32h2Gi00mA/lXFF1c
	G0hgeKCZk767juMHacdgbawu10E1Mnk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] char/adi: Use min_t(size_t,,) in adi_read() + adi_write()
Date: Mon,  8 Sep 2025 20:13:54 +0200
Message-ID: <20250908181354.436680-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace min() and manual casting of MAX_BUF_SZ with min_t(size_t,,) in
both adi_read() and adi_write().

This matches the initial buffer size calculation:

	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);

and makes the code more consistent. No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/char/adi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/adi.c b/drivers/char/adi.c
index f9bec10a6064..ca3a202dc2b2 100644
--- a/drivers/char/adi.c
+++ b/drivers/char/adi.c
@@ -80,8 +80,8 @@ static ssize_t adi_read(struct file *file, char __user *buf,
 			bytes_read += ver_buf_sz;
 			ver_buf_idx = 0;
 
-			ver_buf_sz = min(count - bytes_read,
-					 (size_t)MAX_BUF_SZ);
+			ver_buf_sz = min_t(size_t, count - bytes_read,
+					   MAX_BUF_SZ);
 		}
 	}
 
@@ -157,7 +157,7 @@ static ssize_t adi_write(struct file *file, const char __user *buf,
 		}
 
 		bytes_written += ver_buf_sz;
-		ver_buf_sz = min(count - bytes_written, (size_t)MAX_BUF_SZ);
+		ver_buf_sz = min_t(size_t, count - bytes_written, MAX_BUF_SZ);
 	} while (bytes_written < count);
 
 	(*offp) += bytes_written;
-- 
2.51.0


