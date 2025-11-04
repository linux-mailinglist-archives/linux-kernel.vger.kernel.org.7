Return-Path: <linux-kernel+bounces-884501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB9C30459
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 466ED34D1E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6E2C21D4;
	Tue,  4 Nov 2025 09:31:55 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29F23F294
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248714; cv=none; b=ZwlZUorFSwLTYY007mzP8TOsdIk9xYpTvszMxP9VngYOI7HQ6iYhCTB1bSpdt1IvISqYC+wb6M8pIrfkoJIDqnyvzBu2/rvxmqcVq9+SrNWw3dEBrckR9IpUHls2quwVY3uGgfUzOnPkxpeNfFAl+dpyqFax6yfZZxJMhb6T4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248714; c=relaxed/simple;
	bh=RJSDD1w/k+N41WeKWWgKKGsJhAf5wsWwhwoTf2CzD7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIzwdRxZ5vJlKPp55e8D0wtCkGyeiTz7TIvBrSx2Ol/Ym3muFak7scrnJdOLzfKSD6mVOP++pTKlhK0TrHWySnzVrwFP5ZtRmnQjnvay4730Oktq4IX+gS+8D62BoL4FLG5/3tsiI1VlvYG/GllI76fpt2TM5XIt5TTI8KxM6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpip4t1762248700t3624cd74
X-QQ-Originating-IP: /EhhjABVvgkfE7ERNKjtQSTR5Pgao4k6eTquA0xetcI=
Received: from arch ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Nov 2025 17:31:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3312186764243878189
From: Luo Qiu <luoqiu@kylinsec.com.cn>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] logic_pio: use pr_err_ratelimited() in find_io_range()
Date: Tue,  4 Nov 2025 17:31:35 +0800
Message-ID: <EC97073D4233B88A+20251104093135.29259-1-luoqiu@kylinsec.com.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MhqQ6Gpzx/83UKWCmCYdqmLF5NCmunImZLlg8loVAlYT7bESsjXdskN+
	OReHNtkxyfahJo3Us3S234YdFkOj88ukz/tjxJgEE+dPD4TDxqPu07BuOflBunPgxkvt2mh
	sJj3PyEOkfrRLz3tkppankrtNVnUKbtiZozp8FKiRreCWhG9rFwzjii78qZbsr0J07DTGhc
	92PmWZfenchSzv9RmDZ/fDgob589+CG2pBEsS62QxdHL0qlrnZZzB6EyRI5Wrsb/1h+GNQ5
	d0uJjKGBmvnksVrCntFaUp23wirGUUl3fAyD5OAGz3FeO491NuBAzu7+uYDemsiTPmMfQ7I
	c42Y0WV5M0uhManI6d7p7+CWLmefkfJLu5vinHhCll5y6YLEVGSn413kfni7YFj+z9XzP4D
	6MER2JQ3c8YRPuWYy3sv2wL4oLOMfeYaUE07a3AIsjwbZwJGuMd96rtSFeq5IG+aEUmmsfn
	YmDPkp3h8hJhyj8TRomWSpAY9Owl5r91zMw+Bpydz6I7dtzVGS5ar9Y6Zjq7zS9Wc/msjW/
	zWUB6Nv0l7YM3eAcZp/YLYUMdVmru7d9Cag0I1Y6/CS0xRjzpir+nkhZiD7R6L/Y0UTm6ys
	R86NoMTZbtqH0PKL6aknmZqA0p/LKVnWAotDjH9fKwLvkD9Cufx66iiVxWWEAFlX+cPAQll
	f66X2l73b6XHfHKByRx+K9WKR4Mmt0AZq/mWX9SIs1S6+ft5iIEiixERbwdlnuYNaWfzTxW
	oNWlqMGfg/FZ2bz8K47jKOvLNWA6lJKfHR9kic5aIaVTuKsGRiIMwxR+40Ms6etvrysfe6m
	ZYTYsYCyGsVTNP89YiRIXZVeFaG+0MIBwMNiyu+Xc3aakxh6yQzogVa5fjnBoz9bzspG5WH
	zQYD99kiLwCAvNHbO1CWKla7kzwXeFWcLFD7yOkPmw5LUXK9AXWFjuCILr7u1h+7HdlfrQv
	DkOidlwlWxi8TPzXD9p7BKzcBnYAcxuvaViCcqXGFIWpSBf+VvtdlmHQLKud8yH5JfrBNzq
	ZkZDWULw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

The pr_err() in find_io_range() can be triggered repeatedly when
invalid PIO tokens are encountered, potentially flooding the kernel
log with duplicate error messages. This is particularly problematic
in scenarios where drivers may repeatedly attempt to access invalid
PIO ranges.

Signed-off-by: Luo Qiu <luoqiu@kylinsec.com.cn>
---
 lib/logic_pio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index e29496a38d06..d8f583246a1b 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -153,7 +153,7 @@ static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
 	rcu_read_unlock();
 
 	if (!found_range)
-		pr_err("PIO entry token 0x%lx invalid\n", pio);
+		pr_err_ratelimited("PIO entry token 0x%lx invalid\n", pio);
 
 	return found_range;
 }
-- 
2.51.2


