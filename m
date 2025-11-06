Return-Path: <linux-kernel+bounces-887871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77641C39467
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E38234F0B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35642D46D0;
	Thu,  6 Nov 2025 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LczhEutb"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0023B616;
	Thu,  6 Nov 2025 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410871; cv=none; b=CzwzIuQJg4w5ChR23ueKyOqtmO8yzNklc23a7Qh5rupuEhfRUZOUikTEYChCBoZ/+vi9km1I+YIzZStfsa8loJb8m1RhFcpi1CGOt1O6vt2gwddwzlb/hvtxUHQ/nYeO0d9tblK8U6CbffgCqLRhJjX2AnXqx/tOcEGUKvMASho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410871; c=relaxed/simple;
	bh=tOMroa1xSvKfWn7TAO2OTvWdTUvzXj9eyPyMmDlgprE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kSSAQ9KifAj6eRzIzdJMFmNV+E5nlLUwupxMOq847odsOlxlJFdCWfJ4ToETeH23jUz+q//BsvPInPD1EwGm9CCkjNyaKQk8VlIylh8Bc2/oy5ZnzWoCJax3QAm8ABxFfj7YbMBypN83Hy/93TXg039qObjd9zx8zq8EcXEIc84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LczhEutb; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=1QSw+y5HT3TcUyd3F/MxUjly0CwHD5TKPc20p//UxFU=;
	b=LczhEutbWhnRAhZdt07+G3NJC4N8E2OK6xesEjD+hiUQ/+J+gMoSaxw9XSZxXB
	2q5eSubM7NTO40N35Od9PJms8Ok/YxVgiBuHbDIjZPJcF7lm+yC0pGKzUb5vN6aA
	RnR5ipNKuPw5eUKVWdc1qRNYRU+MkHRSIskuYoJQ9rmw0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHRAJFQQxpjDa9Bg--.91S2;
	Thu, 06 Nov 2025 14:33:42 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdich9700@163.com>,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] ALSA: au88x0: Fix array bounds warning in EQ drivers
Date: Thu,  6 Nov 2025 14:33:39 +0800
Message-Id: <20251106063339.114596-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHRAJFQQxpjDa9Bg--.91S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF47JryDCrW7Cry8tr1kKrg_yoW8XFWfpr
	Z3C3s7ArWUJrsrCwnYva1UZ34UJFs8XayxAa12kws7Cws8JFWUGr90k3yDJw4IvrZxCF1F
	9FW7Xw13J3Z8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piUPE3UUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbibhj9T2kMMt8qKgABsN

From: wangdicheng <wangdich9700@163.com>

In file included from ../sound/pci/au88x0/au8830.c:15:
In function ‘vortex_Eqlzr_SetAllBandsFromActiveCoeffSet’,
../sound/pci/au88x0/au88x0_eq.c:571:9: error: ‘vortex_EqHw_SetRightGainsTarget’ reading 2 bytes from a region of size 0 [-Werror=stringop-overread]
	vortex_EqHw_SetRightGainsTarget(vortex, &(eq->this130[eq->this10]));

Modified the array access in vortex_Eqlzr_SetAllBandsFromActiveCoeffSet() to use pointer arithmetic instead of array indexing.
This resolves a compiler warning that incorrectly flagged a buffer overread when accessing the EQ gain array.
The this130 array has fixed size 20 and the index is safely within bounds, making the original code correct but confusing to static analysis.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/pci/au88x0/au88x0_eq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/au88x0/au88x0_eq.c b/sound/pci/au88x0/au88x0_eq.c
index 71c13100d7ef..81a63b5bb31c 100644
--- a/sound/pci/au88x0/au88x0_eq.c
+++ b/sound/pci/au88x0/au88x0_eq.c
@@ -568,7 +568,7 @@ static int vortex_Eqlzr_SetAllBandsFromActiveCoeffSet(vortex_t * vortex)
 	eqlzr_t *eq = &(vortex->eq);
 
 	vortex_EqHw_SetLeftGainsTarget(vortex, eq->this130);
-	vortex_EqHw_SetRightGainsTarget(vortex, &(eq->this130[eq->this10]));
+	vortex_EqHw_SetRightGainsTarget(vortex, eq->this130 + eq->this10);
 
 	return 0;
 }
-- 
2.25.1


