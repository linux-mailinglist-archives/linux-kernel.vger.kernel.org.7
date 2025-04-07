Return-Path: <linux-kernel+bounces-591234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988C4A7DCF3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 13:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAED3A9763
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6922B8A5;
	Mon,  7 Apr 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="anymPyWj"
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5E1A8F68
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026940; cv=none; b=tEKmO92NU1gAgbVJ1RfAixWE9ExuP9djdm2Ic1S9MYgYPYrBqmZaCBlzkZjF9yOZT4nrJ41AwJyekMmgf/H/9XFkwFC6tNiKaMh2yWlhVDjIRfwXRKvOqMa2X2PkQKk5U/n6QhlffkFVY6sQZthy74V4u7CsD84KnUKta+OhWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026940; c=relaxed/simple;
	bh=Q7w6rQMWzrrI56q78w0SYb/BTNujEKUgrLF8isK6A8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=on0/DzgWjeR8If1clH7oKvKXWlcs/SM4DCT8VhqSyzm+EV3XnDSdS7kcY9KnHySe5mBMnHtsUXUwJ1ZIYt24Oo0ggZPleVr9j/wbO44SUHGimmeo7Dvhg1YiGrp311Twjstw9j3kaZ4l4wGlxox/GyYNIBsqiKz+I1Z8WLR4k2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=anymPyWj; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=Z75kDtTMKquraVShLM7bPPJB66WvUMJ0QtUbJjFQFJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=anymPyWjrQHKXWLbTzp5qhjeZc2WbjdqfQgYHsxP3SmB7oAoFj7RauAT55mdnYQR7
	 w0unR/JlTIpMBC24xy0XXDAAPFtIRMu4uOkRsFL2SSnkPk/jNH13/dFZOR7PFQLA2m
	 gliT4Ukkmd1dcAdSSsULfYzSbkG5wwiM4tbVlL3l+p1Lm9cc5T81eOZ34VZt2n3o3A
	 pyYLv8NXk+wuPEC4xAuNO41DDZMu0Xr6FNV5F9yTxFdlIOH+m76ivGFDzCR2gEsUsJ
	 HU6ZBYzzLE5DfD7Bg6STnOASObUNAJnw1x5ULuZgWAg2/0rId3A2aE221RvNTpLWZi
	 Lf16WFvaI+aiw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id A20402010176;
	Mon,  7 Apr 2025 11:55:34 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 07 Apr 2025 19:55:20 +0800
Subject: [PATCH] fbdev/nvidiafb: Correct const string length in
 nvidiafb_setup()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-fix_nvidia-v1-1-843f8d031c7d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACe982cC/x2MQQqAIBAAvyJ7TjAp1L4SEYtutRcLBQnEvycdh
 2GmQqbElGERFRIVznzHDuMgwF8YT5IcOoNWelaTMvLgd4+FA6NEF4z2zqJVFnrwJOr2n61bax/
 BNxyRXAAAAA==
X-Change-ID: 20250407-fix_nvidia-a9d72c98a808
To: Antonino Daplas <adaplas@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: hR7R5pRJtDpg_X92yc7fAbAx09XflHRV
X-Proofpoint-GUID: hR7R5pRJtDpg_X92yc7fAbAx09XflHRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1011
 malwarescore=0 spamscore=0 mlxlogscore=857 adultscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070085
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

The actual length of const string "noaccel" is 7, but the strncmp()
branch in nvidiafb_setup() wrongly hard codes it as 6.

Fix by using actual length 7 as argument of the strncmp().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/video/fbdev/nvidia/nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 8900f181f1952acd2acc16a6ab49a5a42ec056ac..cfaf9454014d8161bedc3598fb68855e04ea9408 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1484,7 +1484,7 @@ static int nvidiafb_setup(char *options)
 			flatpanel = 1;
 		} else if (!strncmp(this_opt, "hwcur", 5)) {
 			hwcur = 1;
-		} else if (!strncmp(this_opt, "noaccel", 6)) {
+		} else if (!strncmp(this_opt, "noaccel", 7)) {
 			noaccel = 1;
 		} else if (!strncmp(this_opt, "noscale", 7)) {
 			noscale = 1;

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250407-fix_nvidia-a9d72c98a808

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


