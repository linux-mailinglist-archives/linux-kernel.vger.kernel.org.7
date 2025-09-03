Return-Path: <linux-kernel+bounces-798389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A52BB41D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BD95E7649
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F572D7D2F;
	Wed,  3 Sep 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pOCc05jC"
Received: from outbound.pv.icloud.com (p-west1-cluster3-host12-snip4-1.eps.apple.com [57.103.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF792FAC12
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899472; cv=none; b=B2dETkA7CqDLrHPGdYXZr7WUDCyBxs0B/OZDuXeUh9gk4PNOBmYx0CFKQWCMxQuZ4RMvsYw7NM9Du8AVbgH+wZxLshkMH8EGvIX9zf+wKlsRuJjwzm9oei/pqkGxrzbhDV21zW4lW86iu0FwTUTrMBdAr7eUnlUwtIrAkIUBb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899472; c=relaxed/simple;
	bh=CPiwPUtD4cwAuvvlGEFQRzLeWgJSTBUTxIvwwAaotFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rb7bEdCVNFUHVptEAkhZoQFnhqYtRdeWD8SFlZMLcXUrB97P48jxSN9He894sy81+FMcrEOtud6y7gDh9LkpgJps32OKetwZYfMrGzk0FVEq02Th5v5pXNNk9rIwRsK1s/U0GQ0d7+IVvjQNqcHURRYH7p/4NyGz0le8oxYFzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pOCc05jC; arc=none smtp.client-ip=57.103.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id 42F6518000BD;
	Wed,  3 Sep 2025 11:37:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=EYFcnrbtMMN5XXe62g2AnQ0JsSDv7UuRCam4wU3oAvc=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=pOCc05jCBV4Vw7zM6v+vESp6QBn4YPfkG2Nz5Jmv83cPJmkpKg65cfiJ9WasqVqTXW0XHEovvkWkbl87omTHVq4pDVxre3rvsLMxMUvCM67Rr1fxvPXgw9NC7iiBC8a1GL+JHu9OTgNd+8R2JH6PnKdViipmSKe/I3+yIkizHcsYBGOabrhKzJZBytvL4zlBFUfL/LVtbP25oXNegddJi4yB0cRJRzfcGPGI/r6EJKwg7gYhu7fHeY64WwuFgXdWM7tiUMQOEPZVldbusOgVJvbaUxHksUpwSgOsF3rl6c/HM9XfN39Ku1JCuP7JhEvRSqc4maaEljzngvbeFpRpXA==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id 102CF18001DB;
	Wed,  3 Sep 2025 11:37:45 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 03 Sep 2025 19:37:22 +0800
Subject: [PATCH v2] driver core: auxiliary bus: Optimize logic of
 auxiliary_match_id()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-fix_auxbus-v2-1-3eae8374fd65@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHEouGgC/22MywrCMBREf6XctSlJxNS48j+kSF61AdvUXBMqJ
 f9u7NrNwJlhzgbooncIl2aD6LJHH+YK/NCAGdX8cMTbysApP1FJORn8eldp1QlJJ7Qzkh07YTX
 UwxJdXXfZra88enyH+Nndmf3av5rMCCNSK2HPahgo764BsX0l9TRhmtoa0JdSvkG8VhWrAAAA
X-Change-ID: 20250902-fix_auxbus-76bec91376db
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: IVNgTc2tD3vuU-iBEX7twSAz4m1Z-TY0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX1Jl3waq5MoY7
 QWVJ7B2jaZLHgkRunvisBnc5vwG+pJZ7+Qvefgw9ycd6QHlX1+tPMHUtJtJ/yIBfziDwkRAow8h
 dEM/EvfeGdlDYi8x6mpbMzywrvoMaHpc79glzwzEUFJNn6C1LmUtVZ+O8oK+z0QtHU41t0uqwjN
 bGRYMh9o4wm83suSZXx8ubB3O+e+xyekpCkvZrg7sXQM4aAKnUf4TB/wL2NscebTsZt2emCzvWi
 xW8ntC6Jjl4AmsXrfcEvYxRqnKTADvxfOxn69BkcnQgzDBYqnAVHhpCUt5Uzhpbs6PdIg2/U8=
X-Proofpoint-ORIG-GUID: IVNgTc2tD3vuU-iBEX7twSAz4m1Z-TY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=922 phishscore=0 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509030117
X-JNJ: AAAAAAABgHVpgktymTALy7br6j2L6MQUelPigtr04Lhwv50Q3JVuW7Dqn9IB9Z31Il2b2vj5r1KCBB0T2gnACtMu9SccaWakQpjzejnnesqbGVQmlfvuauVZaljKsAyQqFhjeDp1WJAD5kMiqgz5zG+KvEzglujZ72IIYRKz6yFF67jaJZzkmZxd7AuMRq4Yn8E9frQ7F+gEVHH0xyzYw7ObBA31w7727s7VJVerGvTlRKIySgG97vcozFdTHzTLiQ2DIM9aYhCKTqrjHqS79/vaUv9v++ymCnSqAnxGLdm41nJj4qr5AndchraxGEOSFyel3VRa3ByLSq+3JyX1o++xrkQ7qOcJ8ip5F21Ou2qIXWtb15kklLadD9X4yHJa+EghpErEr11otOllKhVlKkiTnWNdXJZjYQjJJKkBAj/hR4MPTd3allehuCFHT4YHZ4g4PVTP3DEFFZ/2+qvn0DzH4egqZATAOSTFWa1CiUTCZR2HJtYZJNmhbVFuSo0929zrCsj7qXUTftXTMDsclUdr2xjcjPVqrUcQ7YRr7lFTQaVwMGeQStordiQqVBWtzVsyIhywdlFGpu3+pHzeth57vpsCxoJsIE9SktmGp/b3GmBkdtcAAy1BY55OKSrFcCIspEg5NIpwrBieSkdCDK2R4UTwIb2oGuhMsfq77p6kpWWy6R5V1AhuyMlT0m+MhO2IQSAKlZyC

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

auxiliary_match_id() repeatedly calculates variable @match_size in the
for loop, however, the variable is fixed actually, so it is enough to
only calculate the variable once.

Besides, the function should return directly if name of the @auxdev
does not include '.', but it still iterates over the ID table.

Additionally, statement 'dev_name(&auxdev->dev)' is fixed, but may be
evaluated more than 3 times.

Optimize logic of the function by:
- Move the logic calculating the variable out of the for loop
- Return NULL directly if @p == NULL
- Give the statement an dedicated local variable @auxdev_name

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v2:
- Give statement 'dev_name(&auxdev->dev)' a dedicated local variable
- Correct tile and commit message
- Link to v1: https://lore.kernel.org/r/20250902-fix_auxbus-v1-1-9ba6d8aff027@oss.qualcomm.com
---
 drivers/base/auxiliary.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 12ffdd8437567f282374bbf3775d9de7ca0dc4c7..ed2537cf3b048149e784e5a582631db549050734 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -171,17 +171,18 @@
 static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
 							    const struct auxiliary_device *auxdev)
 {
-	for (; id->name[0]; id++) {
-		const char *p = strrchr(dev_name(&auxdev->dev), '.');
-		int match_size;
+	const char *auxdev_name = dev_name(&auxdev->dev);
+	const char *p = strrchr(auxdev_name, '.');
+	int match_size;
 
-		if (!p)
-			continue;
-		match_size = p - dev_name(&auxdev->dev);
+	if (!p)
+		return NULL;
+	match_size = p - auxdev_name;
 
+	for (; id->name[0]; id++) {
 		/* use dev_name(&auxdev->dev) prefix before last '.' char to match to */
 		if (strlen(id->name) == match_size &&
-		    !strncmp(dev_name(&auxdev->dev), id->name, match_size))
+		    !strncmp(auxdev_name, id->name, match_size))
 			return id;
 	}
 	return NULL;

---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250902-fix_auxbus-76bec91376db

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>


