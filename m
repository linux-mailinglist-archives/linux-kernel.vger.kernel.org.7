Return-Path: <linux-kernel+bounces-889703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20204C3E475
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C06894EBBE0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB862F746D;
	Fri,  7 Nov 2025 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R1YWm3Wy"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4FB2EB85E;
	Fri,  7 Nov 2025 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483580; cv=none; b=paoRqTZLDVpirWrE+h2KkhAe4/xnKa7CRCFZYL82tZfH16N8IhvWb3GRNfcTyQ4WVTuCkU2FUsqf1tL8ig+Oo57VQQfKeV/5PqRU0nbtL2pE3DUlCAZtt7oatAcwRpEw30yoIbDR5z9n/vjSxhklCL4hH32S2uQZRl1baKRjUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483580; c=relaxed/simple;
	bh=YqmgcrJVWPQJngI1MrraIFOBftyK55awYtmdXz1wQK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z3B4MsnO2bBr3Cq1s0RdQSWeNwAa+K6b2LrX9BXpAojtU4tEHWV/LNyyqoTF/iymsoa03LAs3htcdMihWKnwo9662Uspzf85c0vvpis4UHva8UeGC/JvD/FDiR5f2zk5FJZxv81yaXOzdoWhINrg5uJH0qIcNTuLAnIC9/U0fb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R1YWm3Wy; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=BVjtQxRr4Em1qccmrXpR3PPL5QbXoRMY7Rprht5+Ncg=;
	b=R1YWm3WyNBcbXHAqVIYbSvtH/J7qXz9LDeD9Dja86Crdz7p9+Ub4ilxDxHw70D
	pNwvOCzSY/8I8hmGCwn4z/x56nIWYmh01gAIv+MUkPfWYvNLrZdbS2aXmUolr6oH
	nf6/qFaYJVBPxLKI21IwO9ae1Bmr3xVe52HDO2iwiNbW8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD33z1HXQ1pfrTkCA--.1006S2;
	Fri, 07 Nov 2025 10:45:28 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH v2] ALSA: au88x0: Fix array bounds warning in EQ drivers
Date: Fri,  7 Nov 2025 10:45:25 +0800
Message-Id: <20251107024525.38454-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33z1HXQ1pfrTkCA--.1006S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF47JryDCrW7Cry8tr1kKrg_yoW8Wryxpr
	Z3Cwn7ArWUJrsrCwnYqa1UZa4UJFs8XFW8Aa12kws7Cws8JFWUGr98C3yDJw4IvrZxCF1F
	gFW7Xw13J3Z8JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYApnUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCwAgHVmkNXUhQjgAA32

From: wangdicheng <wangdicheng@kylinos.cn>

In file included from ../sound/pci/au88x0/au8830.c:15:
In function ‘vortex_Eqlzr_SetAllBandsFromActiveCoeffSet’,
../sound/pci/au88x0/au88x0_eq.c:571:9: error: ‘vortex_EqHw_SetRightGainsTarget’ reading 2 bytes from a region of size 0 [-Werror=stringop-overread]
	vortex_EqHw_SetRightGainsTarget(vortex, &(eq->this130[eq->this10]));

Modified the array access in vortex_Eqlzr_SetAllBandsFromActiveCoeffSet() to use pointer arithmetic instead of array indexing.
This resolves a compiler warning that incorrectly flagged a buffer overread when accessing the EQ gain array.
The this130 array has fixed size 20 and the index is safely within bounds, making the original code correct but confusing to static analysis.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---

v1->v2:
-Align both From and Signed-off-by addresses

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


