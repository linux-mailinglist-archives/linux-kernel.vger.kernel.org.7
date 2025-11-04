Return-Path: <linux-kernel+bounces-884205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B310C2F9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4B0F4E1E69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9C1306490;
	Tue,  4 Nov 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Dfb2nEYL"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AB286891
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241326; cv=none; b=Y9wXsYTUKRVHgnBdU1c89DGgpy5F+W1WlvMWYXmIaINjW21p4d8Z1YnnSUurGggMMTXZ81DNS1zWZpF35PI6XWnlEALT7zySYJN/K2nNt2wymIObOwFMNvLvURUgpibt6G+5RznnR5fxulsuf6IvMyTTQDH1HAUYdMlhtI65q5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241326; c=relaxed/simple;
	bh=tOMroa1xSvKfWn7TAO2OTvWdTUvzXj9eyPyMmDlgprE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m2U1XNEtwTJ5b6ePC1HKDZjvtWYXsKaqwelMh0mpEn5m69IV3y65yk9fEg2oS+IsqNKjtp/Ry7/j99YSvTy+zE6Q/30VL6SzUkfb96CocnUuCSK4t0JD45EhRGy/Gl12Xn7go4ort1aChd33WZH2HkoLAl1y/+69y499qhkkFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Dfb2nEYL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=1QSw+y5HT3TcUyd3F/MxUjly0CwHD5TKPc20p//UxFU=;
	b=Dfb2nEYLHz9ugFUai5yaYyh41iCkUtEucW/HteS14/qsk5VLqFehetkHer7Ff+
	nUoMz3NzdnuIIVSRaQ4mMT6oal7cqK5mjaqqcuNzwdV3W8vY/pQ+gXISzoOjmGv1
	eTk0u6SNsBz9aC0dRPDcaRVlZrEDeFmNkRRZQ2BsDE10k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDn74SuqglpdwI+Bg--.673S2;
	Tue, 04 Nov 2025 15:26:40 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdich9700@163.com>,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] ALSA: au88x0: Fix array bounds warning in EQ drivers
Date: Tue,  4 Nov 2025 15:26:36 +0800
Message-Id: <20251104072636.93214-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn74SuqglpdwI+Bg--.673S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF47JryDCrW7Cry8tr1kKrg_yoW8XFWfpr
	Z3C3s7ArWUJrsrCwnYva1UZ34UJFs8XayxAa12kws7Cws8JFWUGr90k3yDJw4IvrZxCF1F
	9FW7Xw13J3Z8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEGYLsUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbibhH7T2kJpNSSNwAAs+

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


