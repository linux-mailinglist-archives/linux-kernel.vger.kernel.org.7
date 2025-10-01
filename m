Return-Path: <linux-kernel+bounces-854279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D7BDDF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46855192118B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F431D726;
	Wed, 15 Oct 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fnJ/Mvy1"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06A31C58E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523978; cv=none; b=TyK9UK2ZhPEhW0a/mz1d9Ab6TNt/3h6YlqTki56D/XvIG9SIqgUANxlc9kAvahmcgVIN1b1+dG+67ngfrzHE4PyZCY+68u5d7WZ9JFonwBb/fgR78M17mwDgvDCf2oR6KfpXqUOLYN/Oj5YZG84CUPrc9bqaHTnPgBIG/hNB2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523978; c=relaxed/simple;
	bh=skb5N45a85DEvXJs/vBUCiqgAv3VNkJmX2Nn+jZL8ZY=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=teA+atVM2nY89gz1xIlMxtrdH/1NDuQsi7oPZSD5kkcqh1liNAjxCCmHi6mMdL0zpKU2VbQ63SutFWbaFUOIIxni0uaTE0XnsqBKmFiC100aQJRW6zwfYcjmt6ufZ4vgX3qKDZ3RloN87KOpyb3zZy3nU+NpgWr0+DoX++zx5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fnJ/Mvy1; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760523971; bh=ezgtSDOXHivCFuC5AUAl3AvdnYQYhmw66BozkVx5J4s=;
	h=Date:From:To:Subject;
	b=fnJ/Mvy1e+J0WqJimzGXcbqgPcXff6ysT4q0KYCupPYdj1Q+4tlthezp5CaCv3nvB
	 t66QPaA6Sj6VvGIttRrIaV5xkUU7+UEnB5zoNLp9WJUIe9lqIUzxxVPdJMPmlMjKqg
	 NPQgy3PyUhCWJ35r7WyZmxn4EpeOgZUU6xNUtpuE=
Received: from localhost.localdomain ([120.197.14.100])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 688B002E; Wed, 15 Oct 2025 18:26:08 +0800
X-QQ-mid: xmsmtpt1760523968t2v5hdscj
Message-ID: <tencent_F844A82DB85660D110008F34E54330312A08@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznAY66XNxY4lbviBs5aYbr52JEvjx3ndSIRX9HtLdU4CXGgX3AkN
	 OGnH/ROHiy1IyslmPmeYWZhncWgRsX3vcOlq2shw0SUVaxUK0aKinR5EhooDzwHOMR86x2tIaRRY
	 a5Ogi9lVC97/sX6GWWLvppJnRkij1rYz8JGjluGfOIuKU23UnTGan0q8OMGAasglQ8Zb7p5SXBFO
	 jDlxROKmkmAPPNrbzoiY292lHv5hbPrdoYGubv7zHFIoJJkdcgRFcqXEcsXO0Lh0CMvhVRf+D/R0
	 S+9egDapl0V4gSaO1svSJCuJevk/HUY9jos3/SJFdxGpGLnevSrG4Z2VHyeo+lBET+sTxAZOn1z1
	 GBjdt7kzEW0H2d2KbVK3vvpu5c0c6Dhb06exTvcuneZ+lKf3wtZIPp9FMerWbxV/IZy0Q4yaEqcu
	 MZmtmtAs6qJdX+WmF4YMjWYmm+0d38DbrfWPut9r5lq9i9D1ROMTFPG0gJUeMn41VDZypcrLbhZO
	 Kcl7J+OusBrv5C5n7FFjrhnipbrTWzNYCR+W0GZlyxt4qiMB1iIrdQW6LrchePtWyf0sipYdAtEg
	 te/YnNxKlHZOt1+FLWhFO71vPS7RfyuR1vj6KK3AQHE+CQ22iOQ5xggm6gmRAo8+nNQqqGBWrv2d
	 KPW9H78pEyDHqNhAYndfUBs0vGW7OjDQoHzUtilYJezUSZl4z06Rgj63jsO51fCgLxlQBFh3q3Ny
	 DBoOeRIdY4P0ZEgI4AOnu3ymIouASIIoYi/zuENs/9nbaSh4FvtH2Wmz+UDfCes3m9rnlKjBiWrb
	 56QlMpZq24qVY9GLkz3r9j/9yAlyODlDI0TikX+7+ajDG4sCeDmcs+QUmRZS/kDeM1aEoYurhMzu
	 QkK8NSUpQm5iqIZJmXIrs6zJ/2gUpIZGfDv/aN82PWzPR3H2tbNqduu6odehvJFyip8hJYtyRo6J
	 cHuQgGb1NuQP0h6msNvGBVlZ63lSSidrxHANjWJU5LmP0PMbg5+B3MEoVFokH5fONuMS8ZbDk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Date: Wed, 1 Oct 2025 22:42:39 +0800
From: Haoran lee <470658536@qq.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: PATCH: Fix typo recommand in comment
X-OQ-MSGID: <aN0938CSHL6NoJa_@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From e949fa326c98953fda200fe92c108fa71e334715 Mon Sep 17 00:00:00 2001
From: Haoran Lee <470658536@qq.com>
Date: Wed, 15 Oct 2025 10:18:52 +0000
Subject: [PATCH] powerpc/smu: Fix typo "recommand" in comment

The word "recommand" is incorrect. The correct spelling is "recommend".

Fix the typo in the comment in arch/powerpc/include/asm/smu.h.

Signed-off-by: Haoran Lee <470658536@qq.com>
---
 arch/powerpc/include/asm/smu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/smu.h b/arch/powerpc/include/asm/smu.h
index 2ac6ab903023..23b4ed8b4399 100644
--- a/arch/powerpc/include/asm/smu.h
+++ b/arch/powerpc/include/asm/smu.h
@@ -667,7 +667,7 @@ extern struct smu_sdbp_header *smu_sat_get_sdb_partition(unsigned int sat_id,
  * file is opened. poll() isn't implemented yet. The reply will consist
  * of a header as well, followed by the reply data if any. You should
  * always provide a buffer large enough for the maximum reply data, I
- * recommand one page.
+ * recommend one page.
  *
  * It is illegal to send SMU commands through a file descriptor configured
  * for events reception
-- 
2.48.1


