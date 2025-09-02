Return-Path: <linux-kernel+bounces-796381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5CB40002
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A84C545250
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB57B306D2B;
	Tue,  2 Sep 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Sm+OdEfo"
Received: from outbound.pv.icloud.com (p-west1-cluster2-host12-snip4-10.eps.apple.com [57.103.64.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF32306D3F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814945; cv=none; b=Jcx928w0lthCUwhIxtd/NAenRdD+fARjfrYz0RVoZValoBNeW9yDWAziH8ngeLx5hd68KOsh5KoUxRKzxoFDSR+qg8iK0r28unlWWJzXhC657gj2i6M8cd0kXlc9N0B7ysuhIobB7lwMQAm6FLHYoxbiz21pRxy1xq8OjybuKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814945; c=relaxed/simple;
	bh=dmGqJ/2goIx70WN+gIp5nRrIjfUbCkiwef8JojtxaDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mx0dA05/IuQfAMOv1G0dyLcPMG3a3fDEfduMzFFlJmSAUbHKyoJSEa5c5BaDaU7b6wWS/LCA5j1KCLsLGN50GXQt+HHUiiCKYsCfKipyNJGeY1j3kWkKTpJxZ2UDNB7rDEsABNx1CsEcYGcPfwqxmGcuEZ1Cn/Le+JWg4dfQeA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Sm+OdEfo; arc=none smtp.client-ip=57.103.64.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPS id 0D2D91807F10;
	Tue,  2 Sep 2025 12:08:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=ydfPInkQfhv4gPusJ78yunnLvCmXq86IJsY1DqpE5j0=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=Sm+OdEforhqDqmfccsSwkm4eXyLx5ii2IdffbjQoGy7bZlKcIeeUB+ImKNMPzrbQCsyBq1Jfk5nR5C49nJe6tVKixgIn7/2ct4zKtzhrHkEXPt90ONNWeFDu4mZKNb35mZEzkX/CsBtcsoQ5O3UQMPESJAoF3F1Ks4ie8l53lPxKw1GCvep21YiYjP9KyKRHnn+sBbtnky3A3hU5hDs69PBUCDxoWN4OVSYrWhLk8xzgvKDgHuGiDTTwDJltjMCbsBsrNlmIZmE+RWgxSx8+somCn0qzjYRXu/ezyoC4J8vNXzpt+icwFnYriArXPP1mRd6bcZgTfm8kdNqX//4Now==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPSA id 729501803657;
	Tue,  2 Sep 2025 12:05:53 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 02 Sep 2025 20:05:32 +0800
Subject: [PATCH] driver core: auxiliary bus: Optimize auxiliary_match_id()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-fix_auxbus-v1-1-9ba6d8aff027@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIzdtmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMj3bTMivjE0oqk0mJdc7Ok1GRLQ2Nzs5QkJaCGgqJUoCzYsOjY2lo
 AqiMfBlwAAAA=
X-Change-ID: 20250902-fix_auxbus-76bec91376db
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: QfozRavpE5opzp4rHOce01VZ_eZI0UCr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDEyMCBTYWx0ZWRfXz8UcbmDFjzEg
 eBbNG2Ht0HhpjQkcr3r39WAZ+p1FMqtGQMJWfj2zCpxB5di6m3JwybgMVLqfeDMbghjSVdfWnWX
 stwSMFn9AmG0fAMCzXAjccfyscyJi+ItFnsmRxQh3bCA3zKZiS+o7AYquwYDQks3VN5r7XWux+0
 VchTpeZUNmaauR3zJdGP09dJVdsZkYKi8sVhtt9SWQYKCVfXAcV5fumBya+fTVx0zyH7saU0CUG
 5ON1x68Tv0KvJ+trLDKoMkBB+iOvLuI6DXK8gemm8I9oGcmsabF7oN5s0yLn9OW2SacmzLsDc=
X-Proofpoint-GUID: QfozRavpE5opzp4rHOce01VZ_eZI0UCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=957 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509020120
X-JNJ: AAAAAAAB4XCQS8EUVh4rlHmiCAuCnCXXymW/hCdi1SmPxnkhV/xPDGvxDpP+s5FzIPhFooqyOOoUnpbHh7GQ98jXQFiX1L06c6WDCpFc72LrALE4mmDKgvnJFnRebin9SiY+blFJ7IIaD8LC+yMYG0VePGRPYW7oJMWCpLTwzGC/T6/Nkia/6zx/uP6Y9H5CXX1+kYc1Pc44r4p0nbnQdv0Q4mXLoo5/QbnQhXMPOxGOSUbXWQG8DKDJKGd+uhVHp6hr+T9JxdnUpkwJ9r2qRFNy+NA22yiF3zbXIj61OORUf3+5BcTi7l9hRhupt2yK+tA6dRdE2Q3drc3Z/P7KV80XEQl9+TAKyMyQagszH0e+pJvz4/Xm8azAyLlaX5DvWFxuJi79Hkv/KbMSh7Uezp7qRK76z+H1ERiGBs6EEoolyTpH3lfSpH+A9KeW+XK1ViSTBG1GJGGeVuC0LkYJqBpLeXbwz1vNW+uApPbOOXY//76bOsm9WZUV4pBp8kJoZ93bwxXZtRl7gTTPT5vIxFzK1LrUU3a9SlPMrTIp/zVZ0RvEH948E3zLlbVcPDd0ROlo6yfnpvMEYDEdYhKvv307M709ZhwDxURWX3nYKOg0oHV177w/Buw/dW7g4ApgZyeit7X2R91oEw==

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Variable @match_size is fixed in auxiliary_match_id().

Optimize the function by moving the logic calculating the variable
out of the for loop.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/base/auxiliary.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 12ffdd8437567f282374bbf3775d9de7ca0dc4c7..9a53ada043045031e565ade57fd7ba781e7d20ea 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -171,14 +171,14 @@
 static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
 							    const struct auxiliary_device *auxdev)
 {
-	for (; id->name[0]; id++) {
-		const char *p = strrchr(dev_name(&auxdev->dev), '.');
-		int match_size;
+	const char *p = strrchr(dev_name(&auxdev->dev), '.');
+	int match_size;
 
-		if (!p)
-			continue;
-		match_size = p - dev_name(&auxdev->dev);
+	if (!p)
+		return NULL;
+	match_size = p - dev_name(&auxdev->dev);
 
+	for (; id->name[0]; id++) {
 		/* use dev_name(&auxdev->dev) prefix before last '.' char to match to */
 		if (strlen(id->name) == match_size &&
 		    !strncmp(dev_name(&auxdev->dev), id->name, match_size))

---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250902-fix_auxbus-76bec91376db

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>


