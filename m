Return-Path: <linux-kernel+bounces-764155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA228B21EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605513BFEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7572BDC1B;
	Tue, 12 Aug 2025 06:59:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B9296BAB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981987; cv=none; b=AqebQwL7+NIaVQtD6Ip4XLc/NgI4KJE2hP8XujLDYnvappzHY0Aq+XHF3nJ8mXMuK3MAmeb85PdTfHwZnz8Mxzfh7h5KZybGUAIh4E1nuc1ImJmOGcqk3DkHxKK+VOMdoz+Exxv4dIlSHnnpT9Cmm63vJ996m5uDXbsSDD2QnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981987; c=relaxed/simple;
	bh=T2rWe4foDLwzSadYt5BrhW6X+WR6pw0PSgy81VI4xe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dwluuxd5HHMjzAZsi1iBfhtMkAcUGJT4nX6c2GygFtqiPekMUBlYI2++22wGB9klvEzb1wI3PcnZbK3k1OiJytDp4QSAW3u5ssMaWsWbume4IKWv7rUQgilGCuR5hkolJem28zUpHQKSi4m0jANnJWD/LuL+NwepAYHvub8K2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e7f04eee774911f0b29709d653e92f7d-20250812
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e46736c3-de8c-47f0-a283-047ffdd95743,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:9040537a3e6de48336df6fb7ddc47263,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e7f04eee774911f0b29709d653e92f7d-20250812
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 545928281; Tue, 12 Aug 2025 14:59:35 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 5FB40B8258E7;
	Tue, 12 Aug 2025 14:59:35 +0800 (CST)
X-ns-mid: postfix-689AE657-189842208
Received: from localhost.localdomain (unknown [10.42.12.87])
	by node2.com.cn (NSMail) with ESMTPA id DE2B4B812916;
	Tue, 12 Aug 2025 06:59:33 +0000 (UTC)
From: zhaoguohan@kylinos.cn
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [RESEND][PATCH] drm/xe/hwmon: Return early on power limit read failure
Date: Tue, 12 Aug 2025 14:59:30 +0800
Message-ID: <20250812065930.15847-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

In xe_hwmon_pcode_rmw_power_limit(), when xe_pcode_read() fails,
the function logs the error but continues to execute the subsequent
logic. This can result in undefined behavior as the values val0 and
val1 may contain invalid data.

Fix this by adding an early return after logging the read failure,
ensuring that we don't proceed with potentially corrupted data.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 drivers/gpu/drm/xe/xe_hwmon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_hwmon.c b/drivers/gpu/drm/xe/xe_hwmon.=
c
index f08fc4377d25..eb410c5293e7 100644
--- a/drivers/gpu/drm/xe/xe_hwmon.c
+++ b/drivers/gpu/drm/xe/xe_hwmon.c
@@ -190,9 +190,11 @@ static int xe_hwmon_pcode_rmw_power_limit(const stru=
ct xe_hwmon *hwmon, u32 attr
 						  READ_PL_FROM_PCODE : READ_PL_FROM_FW),
 						  &val0, &val1);
=20
-	if (ret)
+	if (ret) {
 		drm_dbg(&hwmon->xe->drm, "read failed ch %d val0 0x%08x, val1 0x%08x, =
ret %d\n",
 			channel, val0, val1, ret);
+			return ret;
+	}
=20
 	if (attr =3D=3D PL1_HWMON_ATTR)
 		val0 =3D (val0 & ~clr) | set;
--=20
2.43.0


