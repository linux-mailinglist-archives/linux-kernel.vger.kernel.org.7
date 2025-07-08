Return-Path: <linux-kernel+bounces-721548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FA5AFCAAE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D0F189F511
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81212DC32E;
	Tue,  8 Jul 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cVwHGCQx"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D8286410
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978588; cv=none; b=e3AxouKwv9h673/qCA9/jgPjNQ4i0Bgc45Of+bZV5xjRz+xHuW0EJ+waG/R85HUD4Re7U+ek0ADXxUZXmyVs8f9GXSZDro3LMprSKClp25SYpGGDUor4h/fRUncS7pCJVLWxqoxpZGPVfeLpyIcasj9kunvvcdOROQqjkDPZ+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978588; c=relaxed/simple;
	bh=GCS3IYgVtZF4bdF8zSNSKV6xyl3fmffSF/az3Ic/hbg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WhUgNBQQ3gWZgNBS9bffUywxMGVieHAD1BB2TUonjcU1Pd4enzHSJ9hohGE6PBiM79rbE/wulQ+/FHgx46U0rxnQI8osdrLOvXTkKX66TrXuj54K+HUVN+wrfMN9U8cj8nlcI+E/smv5rGxU84TuZ9n6b4PhMdHyBwoCXJAgCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cVwHGCQx; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1751978267; bh=QYTtlc5YXWXyaIVmV7obEbFBKsLXdf/uqYcuRYRTR6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cVwHGCQxl2lkHUpahV+fe0IC7yd/+esncSWR/rnaiNqW2mUTJ/c9xF2H+qTq9npH3
	 VpdfRuAAPMV06hg91PR6rx9EUm+VxvXF9VcnQoccZ4shVkB+llQ54teprv+ulOY4M3
	 R18TBTAEVRQcu1q6OLTuDtP/GYOPLiMDWfHBymkI=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 96D9A4EE; Tue, 08 Jul 2025 20:37:45 +0800
X-QQ-mid: xmsmtpt1751978265tuujp277p
Message-ID: <tencent_B0B82F456DC094ECE982EF1ECCEC7AEA6D0A@qq.com>
X-QQ-XMAILINFO: NssJ/YX50roaHfXT7zgDHONtY2NjEzT1NKCNLwfsu0GGV2WNEZoD/NetDfTx4z
	 /2YupMw2BK9DLLS88dB2wEP6ZWvuhpU/AdDbY7zndSPBRhodxyI5ERJOfXFurqnJwsVz2bGSxnoS
	 cxfIQZzjTaa9tBPutpJf3SH9K1iCkwbNmmI51cGkdBcj4r3E2kRWTB5RS9hw0xmntdjo8XDBSHpc
	 4iu5czcB70jUQmhUu5g/fRWzyPxYLDKJo5qef/o8pHx5HTLIYdWny0kweuVLrYYplwP4cL+oI6f9
	 WcmgIV74l3v5z6Iz28CsKdiGP/ymDjLWfwziiATN6dTpAyPu77OteRL4HGCxMJVKBbdkVB5dzl42
	 Jgi1r0KprkSh881yOu8hMM9PRY327d3LzJvTE5oaNQN222gV+W51k2c/zNviRPj3AvEv7JVVWQhD
	 lPN/XHC5i98ceejBavn8SvZ1xcSQNPIGHt+u+92dtzUMHb3UX6fWrcFBMtMZNsfSkugzOxtbYNQd
	 wTRu+NCyDPYVOb/+c4YkgfsWZO8mOgYAfCQfW3Y1Kzenw+IFoxiVQwc80JJzYXbfRIId7u+MCjRV
	 tOYfyYbISlhTz7OowlP8DIcG4VehFCY+QOBxL/y/BvGqVhEeE8sNrojR0gj1WVRFzVPpOQ76i9e5
	 KT+q6D7T+mWD9IsFhYepDI3UXnHn7DQp6rWgt1mQI4BQQOXlpWOqZ8raZYOGCHU+8VVo5zy8abSW
	 WAxGa1iNNJ5HXm9BnCy/dqcbQs7oIZnaL3R5+Eeiq80iWxMKedvVGbMTlfN85vWt1aRyTYrmjJHX
	 VWvyN/UbE7FA+Nhj2mQAHE2Y0JmCv6gxDLJ8WLTIpbEhlLX8HJYkQrh0zUnyzEIvn31UkQnOSYmv
	 FMEABgk4wpFom6Z0H5S4e3Jd177DfK0ii8j21UB+ksAEClbmYMIHli/pxbT7dHlZQ5nI6R3ophfv
	 QRWgqsrU/tBBIanGIyS4nXQxCDNKfODL0mwHJY7bQ=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com
Cc: abbotti@mev.co.uk,
	hsweeten@visionengravers.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] comedi: aio_iiro_16: Prevent invlaid irq number
Date: Tue,  8 Jul 2025 20:37:21 +0800
X-OQ-MSGID: <20250708123720.252288-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <686bf6a0.a00a0220.b087d.01f2.GAE@google.com>
References: <686bf6a0.a00a0220.b087d.01f2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irq number 0x2166 passed by the reproducer is too large and is not
within the supported range [2-7, 10-12, 14, or 15], which triggers the oob.

Fixes: ad7a370c8be4 ("staging: comedi: aio_iiro_16: add command support for change of state detection")
Reported-by: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f1bb7e4ea47ea12b535c
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/comedi/drivers/aio_iiro_16.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/aio_iiro_16.c b/drivers/comedi/drivers/aio_iiro_16.c
index b00fab0b89d4..e43730f00c8b 100644
--- a/drivers/comedi/drivers/aio_iiro_16.c
+++ b/drivers/comedi/drivers/aio_iiro_16.c
@@ -177,7 +177,8 @@ static int aio_iiro_16_attach(struct comedi_device *dev,
 	 * Digital input change of state interrupts are optionally supported
 	 * using IRQ 2-7, 10-12, 14, or 15.
 	 */
-	if ((1 << it->options[1]) & 0xdcfc) {
+	if (it->options[1] > 1 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0xdcfc) {
 		ret = request_irq(it->options[1], aio_iiro_16_cos, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
-- 
2.43.0


